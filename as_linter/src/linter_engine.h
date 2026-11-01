#pragma once

#include <angelscript.h>
#include <string>
#include <vector>

// Message info collected during compilation
struct LinterMessage {
    std::string section;
    int row;
    int col;
    int type; // asMSGTYPE_ERROR, asMSGTYPE_WARNING, asMSGTYPE_INFORMATION
    std::string message;
};

// Initialize the AngelScript engine with all game bindings
asIScriptEngine* CreateLinterEngine();

// Get collected messages for the current file (cleared per-file)
std::vector<LinterMessage>& GetCurrentMessages();
void ClearCurrentMessages();
