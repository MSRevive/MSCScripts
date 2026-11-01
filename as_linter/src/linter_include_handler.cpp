#include "linter_include_handler.h"
#include <fstream>
#include <sstream>
#include <cstdio>

#ifdef _WIN32
#include <io.h>
#define access _access
#define F_OK 0
#else
#include <unistd.h>
#endif

static std::string g_RootDir;
static std::vector<std::string> g_ExtraPaths;

void SetIncludePaths(const std::string& rootDir, const std::vector<std::string>& extraPaths)
{
    g_RootDir = rootDir;
    // Ensure trailing separator
    if (!g_RootDir.empty() && g_RootDir.back() != '/' && g_RootDir.back() != '\\')
        g_RootDir += '/';

    g_ExtraPaths = extraPaths;
    for (auto& p : g_ExtraPaths)
    {
        if (!p.empty() && p.back() != '/' && p.back() != '\\')
            p += '/';
    }
}

static bool FileExists(const std::string& path)
{
    return access(path.c_str(), F_OK) == 0;
}

// Extract directory portion of a path
static std::string DirOf(const std::string& path)
{
    size_t pos = path.find_last_of("/\\");
    if (pos == std::string::npos) return "";
    return path.substr(0, pos + 1);
}

int LinterIncludeCallback(const char* include, const char* from,
                           CScriptBuilder* builder, void* /*userParam*/)
{
    if (!include || !builder) return -1;

    std::string incFile(include);

    // Search order:
    // 1. Relative to the including file's directory
    if (from && from[0])
    {
        std::string candidate = DirOf(from) + incFile;
        if (FileExists(candidate))
        {
            return builder->AddSectionFromFile(candidate.c_str());
        }
    }

    // 2. Relative to the root scripts directory
    {
        std::string candidate = g_RootDir + incFile;
        if (FileExists(candidate))
        {
            return builder->AddSectionFromFile(candidate.c_str());
        }
    }

    // 3. Any additional include paths
    for (const auto& dir : g_ExtraPaths)
    {
        std::string candidate = dir + incFile;
        if (FileExists(candidate))
        {
            return builder->AddSectionFromFile(candidate.c_str());
        }
    }

    fprintf(stderr, "  Include not found: %s (from %s)\n", include, from ? from : "<top>");
    return -1;
}

int LinterPragmaCallback(const std::string& pragmaText,
                          CScriptBuilder& /*builder*/, void* /*userParam*/)
{
    // Trim
    size_t start = pragmaText.find_first_not_of(" \t\r\n");
    if (start == std::string::npos) return -1;
    size_t end = pragmaText.find_last_not_of(" \t\r\n");
    std::string text = pragmaText.substr(start, end - start + 1);

    // Accept "#pragma context server|client|shared" silently
    if (text.find("context") == 0)
    {
        return 0; // Accept
    }

    // Unknown pragma — warn but don't fail
    fprintf(stderr, "  Unknown pragma: %s\n", text.c_str());
    return 0;
}
