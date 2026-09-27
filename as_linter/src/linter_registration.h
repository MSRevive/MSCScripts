#pragma once

#include <angelscript.h>

// Register all game type/function bindings using dummy function pointers.
// This mirrors the exact interface the real game registers so transpiled
// .as files can be compiled against it.
void RegisterAllBindings(asIScriptEngine* engine);
