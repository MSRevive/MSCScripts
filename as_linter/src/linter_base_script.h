#pragma once

// CGameScript base class defined as AngelScript source code.
// This is compiled into every module so transpiled scripts can inherit from it.
// It mirrors the CGameScript type registered in ASScriptClasses.cpp but as a
// script-defined class instead of a native type.

static const char* g_BaseScript = R"AS(

// Base class that all transpiled scripts inherit from
class CGameScript
{
    // Variable storage (simulated — in real game this uses C++ std::map)
    dictionary@ m_vars;

    CGameScript()
    {
        @m_vars = dictionary();
    }

    void SetVar(const string &in name, const string &in value)
    {
        m_vars.set(name, value);
    }

    string GetVar(const string &in name, const string &in defaultValue = "")
    {
        string result;
        if (m_vars.get(name, result))
            return result;
        return defaultValue;
    }

    bool HasVar(const string &in name)
    {
        return m_vars.exists(name);
    }

    void RemoveVar(const string &in name)
    {
        m_vars.delete(name);
    }

    void ClearVars()
    {
        m_vars.deleteAll();
    }

    // Virtual event methods — scripts can override these
    void OnSpawn() {}
    void OnThink() {}
    void OnDamage(int amount) {}

    bool IsValidOwner() { return false; }
}

// Interface for script-defined classes
interface IScriptInterface
{
}

// Factory function
CGameScript@ CreateScript(const string &in className)
{
    return CGameScript();
}

)AS";
