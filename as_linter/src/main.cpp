//==========================================================================
// as_linter — Standalone AngelScript Compilation Linter
//
// Initializes a real AngelScript engine with the game's type registrations
// (dummy function pointers) and batch-compiles transpiled .as files.
//==========================================================================

#include "linter_engine.h"
#include "linter_report.h"
#include "linter_include_handler.h"
#include "linter_base_script.h"

#include <angelscript.h>
#include <scriptbuilder/scriptbuilder.h>

#include <string>
#include <vector>
#include <cstdio>
#include <cstring>
#include <filesystem>

namespace fs = std::filesystem;

// ── CLI Options ──────────────────────────────────────────────────────────
struct Options {
    std::vector<std::string> files;       // individual files
    std::string              directory;   // recursive directory
    std::string              outputFile;  // "" = stdout
    std::string              format;      // "text" or "json"
    std::vector<std::string> includePaths;
    bool stopOnError = false;
    bool verbose     = false;
    bool showHelp    = false;
};

static void PrintUsage()
{
    printf(
        "as_linter — AngelScript Compilation Linter\n"
        "\n"
        "Usage:\n"
        "  as_linter [options] <path>\n"
        "\n"
        "Options:\n"
        "  -f, --file <path>        Compile a single file\n"
        "  -d, --dir <path>         Compile all .as files recursively\n"
        "  -o, --output <path>      Write report to file (default: stdout)\n"
        "  --format text|json        Report format (default: text)\n"
        "  --include-path <path>    Additional include search path (repeatable)\n"
        "  --stop-on-error          Stop after first failure\n"
        "  --verbose                Show per-file progress\n"
        "  -h, --help               Show this help\n"
        "\n"
        "If a bare path is given without -f or -d, it is treated as a directory\n"
        "if it exists as a directory, otherwise as a single file.\n"
    );
}

static Options ParseArgs(int argc, char* argv[])
{
    Options opts;
    opts.format = "text";

    for (int i = 1; i < argc; i++)
    {
        std::string arg = argv[i];

        if (arg == "-h" || arg == "--help") {
            opts.showHelp = true;
        }
        else if ((arg == "-f" || arg == "--file") && i + 1 < argc) {
            opts.files.push_back(argv[++i]);
        }
        else if ((arg == "-d" || arg == "--dir") && i + 1 < argc) {
            opts.directory = argv[++i];
        }
        else if ((arg == "-o" || arg == "--output") && i + 1 < argc) {
            opts.outputFile = argv[++i];
        }
        else if (arg == "--format" && i + 1 < argc) {
            opts.format = argv[++i];
        }
        else if (arg == "--include-path" && i + 1 < argc) {
            opts.includePaths.push_back(argv[++i]);
        }
        else if (arg == "--stop-on-error") {
            opts.stopOnError = true;
        }
        else if (arg == "--verbose") {
            opts.verbose = true;
        }
        else if (arg[0] != '-') {
            // Bare path: detect file vs directory
            if (fs::is_directory(arg))
                opts.directory = arg;
            else
                opts.files.push_back(arg);
        }
        else {
            fprintf(stderr, "Unknown option: %s\n", arg.c_str());
        }
    }

    return opts;
}

// Collect .as files recursively
static std::vector<std::string> CollectFiles(const std::string& dir)
{
    std::vector<std::string> files;
    for (const auto& entry : fs::recursive_directory_iterator(dir))
    {
        if (entry.is_regular_file() && entry.path().extension() == ".as")
        {
            files.push_back(entry.path().string());
        }
    }
    return files;
}

// Compile a single file, return result
static FileResult CompileFile(asIScriptEngine* engine, const std::string& filePath,
                               int fileIndex)
{
    FileResult result;
    result.filePath = filePath;

    ClearCurrentMessages();

    // Each file gets a unique module name so they don't conflict
    char moduleName[64];
    snprintf(moduleName, sizeof(moduleName), "lint_%d", fileIndex);

    CScriptBuilder builder;
    builder.SetIncludeCallback(LinterIncludeCallback, nullptr);
    builder.SetPragmaCallback(LinterPragmaCallback, nullptr);

    int r = builder.StartNewModule(engine, moduleName);
    if (r < 0)
    {
        result.success = false;
        LinterMessage m;
        m.section = filePath;
        m.row = 0; m.col = 0;
        m.type = asMSGTYPE_ERROR;
        m.message = "Failed to start new module";
        result.messages.push_back(m);
        return result;
    }

    // Inject the CGameScript base class definition so scripts can inherit from it
    r = builder.AddSectionFromMemory("__base_script__", g_BaseScript);
    if (r < 0)
    {
        result.success = false;
        LinterMessage m;
        m.section = filePath;
        m.row = 0; m.col = 0;
        m.type = asMSGTYPE_ERROR;
        m.message = "Failed to inject base script definitions";
        result.messages.push_back(m);
        engine->DiscardModule(moduleName);
        return result;
    }

    r = builder.AddSectionFromFile(filePath.c_str());
    if (r < 0)
    {
        result.success = false;
        // Collect any messages generated
        result.messages = GetCurrentMessages();
        if (result.messages.empty())
        {
            LinterMessage m;
            m.section = filePath;
            m.row = 0; m.col = 0;
            m.type = asMSGTYPE_ERROR;
            m.message = "Failed to load file";
            result.messages.push_back(m);
        }
        engine->DiscardModule(moduleName);
        return result;
    }

    r = builder.BuildModule();
    result.success = (r >= 0);
    result.messages = GetCurrentMessages();

    // Discard the module to free memory
    engine->DiscardModule(moduleName);

    return result;
}

int main(int argc, char* argv[])
{
    Options opts = ParseArgs(argc, argv);

    if (opts.showHelp || (opts.files.empty() && opts.directory.empty()))
    {
        PrintUsage();
        return opts.showHelp ? 0 : 1;
    }

    // Build full file list
    std::vector<std::string> allFiles = opts.files;
    if (!opts.directory.empty())
    {
        auto dirFiles = CollectFiles(opts.directory);
        allFiles.insert(allFiles.end(), dirFiles.begin(), dirFiles.end());
    }

    if (allFiles.empty())
    {
        fprintf(stderr, "No .as files found.\n");
        return 1;
    }

    // Set up include paths (root = directory if given, else parent of first file)
    std::string rootDir;
    if (!opts.directory.empty())
        rootDir = opts.directory;
    else
        rootDir = fs::path(allFiles[0]).parent_path().string();

    SetIncludePaths(rootDir, opts.includePaths);

    // Create engine
    fprintf(stderr, "Initializing AngelScript engine...\n");
    asIScriptEngine* engine = CreateLinterEngine();
    if (!engine)
    {
        fprintf(stderr, "FATAL: Failed to create linter engine.\n");
        return 1;
    }

    fprintf(stderr, "Compiling %d file(s)...\n\n", (int)allFiles.size());

    // Compile all files
    LintReport report;
    report.total = (int)allFiles.size();

    for (int i = 0; i < (int)allFiles.size(); i++)
    {
        if (opts.verbose)
            fprintf(stderr, "[%d/%d] %s ... ", i + 1, report.total, allFiles[i].c_str());

        FileResult fr = CompileFile(engine, allFiles[i], i);

        if (fr.success)
        {
            report.passed++;
            if (opts.verbose) fprintf(stderr, "OK\n");
        }
        else
        {
            report.failed++;
            if (opts.verbose)
            {
                fprintf(stderr, "FAIL\n");
                for (const auto& m : fr.messages)
                {
                    if (m.type == asMSGTYPE_ERROR)
                        fprintf(stderr, "  (%d,%d): %s\n", m.row, m.col, m.message.c_str());
                }
            }
        }

        // Count warnings
        for (const auto& m : fr.messages)
        {
            if (m.type == asMSGTYPE_WARNING)
                report.warnings++;
        }

        report.results.push_back(std::move(fr));

        if (opts.stopOnError && report.failed > 0)
            break;
    }

    // Output report
    FILE* out = stdout;
    if (!opts.outputFile.empty())
    {
        out = fopen(opts.outputFile.c_str(), "w");
        if (!out)
        {
            fprintf(stderr, "ERROR: Cannot open output file: %s\n", opts.outputFile.c_str());
            out = stdout;
        }
    }

    if (opts.format == "json")
        PrintJsonReport(report, out);
    else
        PrintTextReport(report, out);

    if (out != stdout)
        fclose(out);

    // Cleanup
    engine->ShutDownAndRelease();

    return report.failed > 0 ? 1 : 0;
}
