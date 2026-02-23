#pragma once

#include <string>
#include <vector>
#include <scriptbuilder/scriptbuilder.h>

// Set the root scripts directory and additional include paths
void SetIncludePaths(const std::string& rootDir, const std::vector<std::string>& extraPaths);

// CScriptBuilder include callback
int LinterIncludeCallback(const char* include, const char* from,
                           CScriptBuilder* builder, void* userParam);

// CScriptBuilder pragma callback — silently accepts #pragma context
int LinterPragmaCallback(const std::string& pragmaText,
                          CScriptBuilder& builder, void* userParam);
