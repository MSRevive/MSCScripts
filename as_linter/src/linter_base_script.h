#pragma once

// CGameScript base class defined as AngelScript source code.
// This is compiled into every module so transpiled scripts can inherit from it.
// It mirrors the CGameScript type registered in ASScriptClasses.cpp but as a
// script-defined class instead of a native type.
//
// Every method that transpiled scripts call on 'this' (implicitly or
// explicitly) must appear here so the AS compiler can resolve the symbol.

static const char* g_BaseScript = R"AS(

// Base class that all transpiled scripts inherit from
class CGameScript
{
    // Variable storage (simulated — in real game this uses C++ std::map)
    dictionary@ m_vars;

    // Entity handle fields used by transpiled scripts
    CBaseEntity@ m_hTarget;
    CBaseEntity@ m_hLastCreated;
    CBaseEntity@ m_hLastUsed;
    CBaseEntity@ m_hLastStruck;
    CBaseEntity@ m_hLastStruckByMe;
    CBaseEntity@ m_hLastSeen;
    CBaseEntity@ m_hAttackTarget;

    CGameScript()
    {
        @m_vars = dictionary();
        @m_hTarget = null;
        @m_hLastCreated = null;
        @m_hLastUsed = null;
        @m_hLastStruck = null;
        @m_hLastStruckByMe = null;
        @m_hLastSeen = null;
        @m_hAttackTarget = null;
    }

    // ── Variable storage ──────────────────────────────────────────
    void SetVar(const string &in name, const string &in value)
    {
        m_vars.set(name, value);
    }

    void SetVar(const string &in name, float value)
    {
        m_vars.set(name, formatFloat(value, "", 0, 6));
    }

    void SetVar(const string &in name, int value)
    {
        m_vars.set(name, "" + value);
    }

    string GetVar(const string &in name, const string &in defaultValue = "")
    {
        string result;
        if (m_vars.get(name, result))
            return result;
        return defaultValue;
    }

    float GetVarFloat(const string &in name, float defaultValue = 0.0f)
    {
        string result;
        if (m_vars.get(name, result))
        {
            uint dummy;
            return float(parseFloat(result, dummy));
        }
        return defaultValue;
    }

    int GetVarInt(const string &in name, int defaultValue = 0)
    {
        string result;
        if (m_vars.get(name, result))
        {
            uint dummy;
            return int(parseInt(result, 10, dummy));
        }
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

    // ── Entity ownership ──────────────────────────────────────────
    CBaseEntity@ GetOwner() { return null; }
    void SetOwner(CBaseEntity@ pEntity) {}
    bool IsValidOwner() { return false; }

    // ── Properties (called on self by transpiled scripts) ─────────
    void SetHealth(float hp) {}
    void SetHealth(int hp) {}
    void SetMaxHealth(float hp) {}
    void SetName(const string &in name) {}
    void SetModel(const string &in model) {}
    void SetInvincible(bool val) {}
    void SetRace(const string &in race) {}
    void SetWidth(float w) {}
    void SetHeight(float h) {}
    void SetWidth(int w) {}
    void SetHeight(int h) {}
    void SetRoam(bool val) {}
    void SetRoam(int val) {}
    void SetModelBody(int group, int body) {}
    void SetSolid(int val) {}
    void SetSolid(const string &in val) {}
    void SetFly(bool val) {}
    void SetFly(int val) {}
    void SetNoPush(bool val) {}
    void SetNoPush(int val) {}
    void SetGravity(float val) {}
    void SetGravity(int val) {}
    void SetMoveAnim(const string &in anim) {}
    void SetIdleAnim(const string &in anim) {}
    void SetMoveDest(const string &in dest) {}
    void SetMoveDest(const Vector3 &in dest) {}
    void SetAngles(const string &in angles) {}
    void SetAngles(const Vector3 &in angles) {}
    void SetCallback(const string &in a) {}
    void SetCallback(const string &in a, const string &in b) {}
    void SetCallback(const string &in a, const string &in b, const string &in c) {}
    void SetRepeatDelay(float delay) {}
    void SetRepeatDelay(int delay) {}
    void SetStat(const string &in stat, int val) {}
    void SetStat(const string &in stat, const string &in val) {}
    void SetMenuAutoOpen(bool val) {}
    void SetMenuAutoOpen(int val) {}
    void SetFOV(float fov) {}
    void SetFOV(int fov) {}
    void SetBloodType(const string &in type) {}
    void SetSpeed(float speed) {}
    void SetSpeed(int speed) {}
    void SetBBox(const string &in mins, const string &in maxs) {}
    void SetBBox(const Vector3 &in mins, const Vector3 &in maxs) {}
    void SetScriptFlags(const string &in flags) {}
    void SetScriptFlags(const string &in a, const string &in b) {}
    void SetTarget(const string &in target) {}
    void SetTarget(CBaseEntity@ target) {}
    void SetDamageType(const string &in type) {}
    void SetDamageType(const string &in type, const string &in extra) {}

    // ── Animation ────────────────────────────────────────────────
    void PlayAnim(const string &in anim) {}
    void PlayAnim(const string &in anim, float framerate) {}

    // ── Script lifecycle ─────────────────────────────────────────
    void RemoveScript() {}
    void RemoveScript(const string &in script) {}

    // ── Virtual event callbacks ──────────────────────────────────
    // These must be declared so that subclasses can use 'override'
    void OnSpawn() {}
    void OnThink() {}
    void OnDamage(int amount) {}
    void OnDeath(CBaseEntity@ attacker) {}
    void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) {}
    void OnTouch(CBaseEntity@ other) {}
    void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) {}
    void OnHitByAttack(CBaseEntity@ attacker, int damage) {}
    void OnDeploy() {}
    void OnPickup(CBaseEntity@ player) {}
    void OnDrop() {}
    void OnScriptSay(const string &in text) {}
    void OnHeardSound(CBaseEntity@ source, Vector3 origin) {}
    void OnDamagedOther(CBaseEntity@ victim, int damage) {}
    void OnParry(CBaseEntity@ attacker) {}
    void OnPostSpawn() {}

    // NPC-specific callbacks
    void OnAttackTarget(CBaseEntity@ target) {}
    void OnHuntTarget(CBaseEntity@ target) {}
    void OnFlee() {}
    void OnAttackDoDamage(CBaseEntity@ target) {}
    void OnStruck(CBaseEntity@ attacker, int damage) {}
    void OnFlinch() {}
    void OnTargetValidate(CBaseEntity@ target) {}
    void OnAidingAlly(CBaseEntity@ ally, CBaseEntity@ enemy) {}
    void OnSuspendAI() {}

    // Timer callback
    void OnRepeatTimer() {}
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
