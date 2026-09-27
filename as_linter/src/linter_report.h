#pragma once

#include "linter_engine.h"
#include <string>
#include <vector>

struct FileResult {
    std::string filePath;
    bool success;
    std::vector<LinterMessage> messages;
};

struct LintReport {
    int total = 0;
    int passed = 0;
    int failed = 0;
    int warnings = 0;
    std::vector<FileResult> results;
};

void PrintTextReport(const LintReport& report, FILE* out);
void PrintJsonReport(const LintReport& report, FILE* out);
