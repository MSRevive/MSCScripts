#include "linter_engine.h"
#include "linter_registration.h"
#include <cstdio>

// Thread-local message collection for the current file being compiled
static std::vector<LinterMessage> g_CurrentMessages;

std::vector<LinterMessage>& GetCurrentMessages() { return g_CurrentMessages; }
void ClearCurrentMessages() { g_CurrentMessages.clear(); }

// AngelScript message callback — collects messages into the vector
static void MessageCallback(const asSMessageInfo* msg, void* /*param*/)
{
    LinterMessage m;
    m.section = msg->section ? msg->section : "";
    m.row     = msg->row;
    m.col     = msg->col;
    m.type    = msg->type;
    m.message = msg->message ? msg->message : "";
    g_CurrentMessages.push_back(m);
}

asIScriptEngine* CreateLinterEngine()
{
    asIScriptEngine* engine = asCreateScriptEngine();
    if (!engine)
    {
        fprintf(stderr, "ERROR: Failed to create AngelScript engine.\n");
        return nullptr;
    }

    // Set message callback
    int r = engine->SetMessageCallback(asFUNCTION(MessageCallback), nullptr, asCALL_CDECL);
    if (r < 0)
    {
        fprintf(stderr, "ERROR: Failed to set message callback.\n");
        engine->ShutDownAndRelease();
        return nullptr;
    }

    // Match engine properties from CAngelScriptManager::Initialize()
    engine->SetEngineProperty(asEP_MAX_STACK_SIZE, 1024 * 1024);       // 1 MB
    engine->SetEngineProperty(asEP_ALLOW_UNSAFE_REFERENCES, true);
    engine->SetEngineProperty(asEP_OPTIMIZE_BYTECODE, true);
    engine->SetEngineProperty(asEP_COPY_SCRIPT_SECTIONS, true);

    // Register all game bindings (types, methods, global functions, enums, etc.)
    RegisterAllBindings(engine);

    return engine;
}
