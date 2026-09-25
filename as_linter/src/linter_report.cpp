#include "linter_report.h"
#include <angelscript.h>
#include <cstdio>

// Escape a string for JSON output
static std::string JsonEscape(const std::string& s)
{
    std::string out;
    out.reserve(s.size() + 16);
    for (char c : s)
    {
        switch (c)
        {
            case '"':  out += "\\\""; break;
            case '\\': out += "\\\\"; break;
            case '\n': out += "\\n";  break;
            case '\r': out += "\\r";  break;
            case '\t': out += "\\t";  break;
            default:   out += c;      break;
        }
    }
    return out;
}

static const char* MsgTypeStr(int type)
{
    switch (type)
    {
        case asMSGTYPE_ERROR:       return "ERROR";
        case asMSGTYPE_WARNING:     return "WARN";
        case asMSGTYPE_INFORMATION: return "INFO";
        default:                    return "???";
    }
}

void PrintTextReport(const LintReport& report, FILE* out)
{
    fprintf(out, "=== AngelScript Compilation Report ===\n");
    fprintf(out, "Total: %d | Passed: %d | Failed: %d | Warnings: %d\n\n",
            report.total, report.passed, report.failed, report.warnings);

    // Print failures first
    for (const auto& fr : report.results)
    {
        if (fr.success) continue;
        fprintf(out, "[FAIL] %s\n", fr.filePath.c_str());
        for (const auto& m : fr.messages)
        {
            fprintf(out, "  (%d, %d) %s: %s\n",
                    m.row, m.col, MsgTypeStr(m.type), m.message.c_str());
        }
        fprintf(out, "\n");
    }

    // Print files with warnings only
    for (const auto& fr : report.results)
    {
        if (!fr.success) continue;
        bool hasWarnings = false;
        for (const auto& m : fr.messages)
            if (m.type == asMSGTYPE_WARNING) { hasWarnings = true; break; }
        if (!hasWarnings) continue;

        fprintf(out, "[WARN] %s\n", fr.filePath.c_str());
        for (const auto& m : fr.messages)
        {
            if (m.type == asMSGTYPE_WARNING)
                fprintf(out, "  (%d, %d): %s\n", m.row, m.col, m.message.c_str());
        }
        fprintf(out, "\n");
    }

    if (report.total > 0)
    {
        float pct = 100.0f * report.passed / report.total;
        fprintf(out, "Pass rate: %.1f%% (%d/%d)\n", pct, report.passed, report.total);
    }
}

void PrintJsonReport(const LintReport& report, FILE* out)
{
    fprintf(out, "{\n");
    fprintf(out, "  \"total\": %d,\n", report.total);
    fprintf(out, "  \"passed\": %d,\n", report.passed);
    fprintf(out, "  \"failed\": %d,\n", report.failed);
    fprintf(out, "  \"warnings\": %d,\n", report.warnings);
    fprintf(out, "  \"results\": [\n");

    for (size_t i = 0; i < report.results.size(); i++)
    {
        const auto& fr = report.results[i];
        fprintf(out, "    {\n");
        fprintf(out, "      \"file\": \"%s\",\n", JsonEscape(fr.filePath).c_str());
        fprintf(out, "      \"success\": %s,\n", fr.success ? "true" : "false");
        fprintf(out, "      \"messages\": [\n");

        for (size_t j = 0; j < fr.messages.size(); j++)
        {
            const auto& m = fr.messages[j];
            fprintf(out, "        {\"row\": %d, \"col\": %d, \"type\": \"%s\", \"message\": \"%s\"}%s\n",
                    m.row, m.col, MsgTypeStr(m.type),
                    JsonEscape(m.message).c_str(),
                    (j + 1 < fr.messages.size()) ? "," : "");
        }

        fprintf(out, "      ]\n");
        fprintf(out, "    }%s\n", (i + 1 < report.results.size()) ? "," : "");
    }

    fprintf(out, "  ]\n");
    fprintf(out, "}\n");
}
