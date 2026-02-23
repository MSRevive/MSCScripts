//==========================================================================
// linter_registration.cpp
//
// Re-declares every AngelScript type, method, property, enum, and global
// function that the real game registers — but with dummy function pointers
// (asCALL_GENERIC + no-op).  This lets the AS compiler validate transpiled
// .as files without any game engine dependency.
//
// Registration ORDER must match ASBindings::RegisterAll() exactly.
//==========================================================================

#include "linter_registration.h"

#include <angelscript.h>
#include <scriptstdstring/scriptstdstring.h>
#include <scriptarray/scriptarray.h>
#include <scriptdictionary/scriptdictionary.h>
#include <scriptmath/scriptmath.h>

#include <cstring>
#include <cstdio>

// ── Dummy generic callback used for every binding ────────────────────────
static void DummyGeneric(asIScriptGeneric*) {}

// ── Helpers to reduce boilerplate ────────────────────────────────────────
#define REG_OBJ_TYPE(name, flags) \
    r = engine->RegisterObjectType(name, 0, flags); \
    if (r < 0) fprintf(stderr, "WARN: RegisterObjectType(%s) = %d\n", name, r)

#define REG_OBJ_BEHAVE(type, beh, decl) \
    r = engine->RegisterObjectBehaviour(type, beh, decl, \
        asFUNCTION(DummyGeneric), asCALL_GENERIC); \
    if (r < 0) fprintf(stderr, "WARN: RegisterObjectBehaviour(%s, %s) = %d\n", type, decl, r)

#define REG_OBJ_METHOD(type, decl) \
    r = engine->RegisterObjectMethod(type, decl, \
        asFUNCTION(DummyGeneric), asCALL_GENERIC); \
    if (r < 0) fprintf(stderr, "WARN: RegisterObjectMethod(%s, %s) = %d\n", type, decl, r)

#define REG_OBJ_PROP(type, decl) \
    r = engine->RegisterObjectProperty(type, decl, 0); \
    if (r < 0) fprintf(stderr, "WARN: RegisterObjectProperty(%s, %s) = %d\n", type, decl, r)

#define REG_GLOBAL_FUNC(decl) \
    r = engine->RegisterGlobalFunction(decl, \
        asFUNCTION(DummyGeneric), asCALL_GENERIC); \
    if (r < 0) fprintf(stderr, "WARN: RegisterGlobalFunction(%s) = %d\n", decl, r)

#define REG_ENUM(name) \
    r = engine->RegisterEnum(name); \
    if (r < 0) fprintf(stderr, "WARN: RegisterEnum(%s) = %d\n", name, r)

#define REG_ENUM_VAL(type, name, val) \
    r = engine->RegisterEnumValue(type, name, val); \
    if (r < 0) fprintf(stderr, "WARN: RegisterEnumValue(%s, %s) = %d\n", type, name, r)

// Dummy global variable storage for const properties
static const float g_PI  = 3.14159265358979323846f;
static const float g_E   = 2.71828182845904523536f;
static const int g_kRenderNormal      = 0;
static const int g_kRenderTransColor  = 1;
static const int g_kRenderTransTexture = 2;
static const int g_kRenderGlow        = 3;
static const int g_kRenderTransAlpha  = 4;
static const int g_kRenderTransAdd    = 5;
static const int g_DAMAGE_NO  = 0;
static const int g_DAMAGE_YES = 1;
static const int g_DAMAGE_AIM = 2;

//==========================================================================
// Step 2: Vector3 & Color value types  (from ASCoreTypes.cpp)
//==========================================================================
static void RegisterCoreTypes(asIScriptEngine* engine)
{
    int r;

    // ── Vector3 (value type, 12 bytes: 3 floats) ────────────────────────
    r = engine->RegisterObjectType("Vector3", 12,
        asOBJ_VALUE | asOBJ_POD | asOBJ_APP_CLASS_ALLFLOATS | asOBJ_APP_CLASS_CAK);
    if (r < 0) fprintf(stderr, "WARN: Vector3 type = %d\n", r);

    // Properties
    REG_OBJ_PROP("Vector3", "float x"); // offset 0
    // re-register at proper offsets
    r = engine->RegisterObjectProperty("Vector3", "float y", 4);
    r = engine->RegisterObjectProperty("Vector3", "float z", 8);

    // Constructors / destructor
    REG_OBJ_BEHAVE("Vector3", asBEHAVE_CONSTRUCT, "void f()");
    REG_OBJ_BEHAVE("Vector3", asBEHAVE_CONSTRUCT, "void f(float, float, float)");
    REG_OBJ_BEHAVE("Vector3", asBEHAVE_CONSTRUCT, "void f(const Vector3 &in)");
    REG_OBJ_BEHAVE("Vector3", asBEHAVE_DESTRUCT, "void f()");

    // Methods
    REG_OBJ_METHOD("Vector3", "float Length() const");
    REG_OBJ_METHOD("Vector3", "float Length2D() const");
    REG_OBJ_METHOD("Vector3", "Vector3 Normalize() const");

    // Operators
    REG_OBJ_METHOD("Vector3", "Vector3 opAdd(const Vector3 &in) const");
    REG_OBJ_METHOD("Vector3", "Vector3 opSub(const Vector3 &in) const");
    REG_OBJ_METHOD("Vector3", "Vector3 opMul(float) const");
    REG_OBJ_METHOD("Vector3", "Vector3 opDiv(float) const");
    REG_OBJ_METHOD("Vector3", "bool opEquals(const Vector3 &in) const");
    REG_OBJ_METHOD("Vector3", "Vector3& opAssign(const Vector3 &in)");
    REG_OBJ_METHOD("Vector3", "Vector3& opAddAssign(const Vector3 &in)");
    REG_OBJ_METHOD("Vector3", "Vector3& opSubAssign(const Vector3 &in)");
    REG_OBJ_METHOD("Vector3", "Vector3& opMulAssign(float)");

    // Global Vector3 functions
    REG_GLOBAL_FUNC("Vector3 CrossProduct(const Vector3 &in, const Vector3 &in)");

    // ── Color (value type, 12 bytes: r, g, b as floats) ─────────────────
    r = engine->RegisterObjectType("Color", 12,
        asOBJ_VALUE | asOBJ_POD | asOBJ_APP_CLASS_CDAK);
    if (r < 0) fprintf(stderr, "WARN: Color type = %d\n", r);

    r = engine->RegisterObjectProperty("Color", "float r", 0);
    r = engine->RegisterObjectProperty("Color", "float g", 4);
    r = engine->RegisterObjectProperty("Color", "float b", 8);

    REG_OBJ_BEHAVE("Color", asBEHAVE_CONSTRUCT, "void f()");
    REG_OBJ_BEHAVE("Color", asBEHAVE_CONSTRUCT, "void f(float, float, float)");
    REG_OBJ_BEHAVE("Color", asBEHAVE_CONSTRUCT, "void f(const Color &in)");
    REG_OBJ_BEHAVE("Color", asBEHAVE_DESTRUCT, "void f()");

    // ── Math functions ───────────────────────────────────────────────────
    REG_GLOBAL_FUNC("float sin(float)");
    REG_GLOBAL_FUNC("float cos(float)");
    REG_GLOBAL_FUNC("float sqrt(float)");
    REG_GLOBAL_FUNC("float abs(float)");
    REG_GLOBAL_FUNC("float min(float, float)");
    REG_GLOBAL_FUNC("float max(float, float)");

    // Math constants
    engine->RegisterGlobalProperty("const float PI", (void*)&g_PI);
    engine->RegisterGlobalProperty("const float E",  (void*)&g_E);
}

//==========================================================================
// Step 3: CBaseEntity (ref type, nocount) — from ASEntityBindings.cpp
//==========================================================================
static void RegisterCBaseEntity(asIScriptEngine* engine)
{
    int r;
    REG_OBJ_TYPE("CBaseEntity", asOBJ_REF | asOBJ_NOCOUNT);

    REG_OBJ_METHOD("CBaseEntity", "Vector3 GetOrigin()");
    REG_OBJ_METHOD("CBaseEntity", "string GetClassName()");
    REG_OBJ_METHOD("CBaseEntity", "void SetOrigin(const Vector3 &in)");
    REG_OBJ_METHOD("CBaseEntity", "float GetHealth()");
    REG_OBJ_METHOD("CBaseEntity", "void SetHealth(float)");
    REG_OBJ_METHOD("CBaseEntity", "bool IsAlive()");
    REG_OBJ_METHOD("CBaseEntity", "string DisplayName()");
    REG_OBJ_METHOD("CBaseEntity", "Vector3 Center()");
    REG_OBJ_METHOD("CBaseEntity", "float Volume()");
    REG_OBJ_METHOD("CBaseEntity", "float Weight()");
    REG_OBJ_METHOD("CBaseEntity", "bool IsPlayer()");
    REG_OBJ_METHOD("CBaseEntity", "void SetNetName(const string &in)");
    REG_OBJ_METHOD("CBaseEntity", "string GetNetName()");
    REG_OBJ_METHOD("CBaseEntity", "void SetRenderMode(int)");
    REG_OBJ_METHOD("CBaseEntity", "void SetRenderAmount(int)");
    REG_OBJ_METHOD("CBaseEntity", "void SetTakeDamage(int)");
    REG_OBJ_METHOD("CBaseEntity", "void SetGodMode(bool)");
}

//==========================================================================
// Step 4: CBaseAnimating, CBasePlayerItem, CBasePlayerWeapon
//         (from ASItemBindings.cpp)
//==========================================================================
static void RegisterItemTypes(asIScriptEngine* engine)
{
    int r;

    // ── CBaseAnimating ──────────────────────────────────────────────────
    REG_OBJ_TYPE("CBaseAnimating", asOBJ_REF | asOBJ_NOCOUNT);
    REG_OBJ_METHOD("CBaseAnimating", "int LookupSequence(const string &in)");
    REG_OBJ_METHOD("CBaseAnimating", "void ResetSequenceInfo()");
    REG_OBJ_METHOD("CBaseAnimating", "void SetBodygroup(int, int)");
    REG_OBJ_METHOD("CBaseAnimating", "int GetBodygroup(int)");
    REG_OBJ_METHOD("CBaseAnimating", "float GetFrameRate() const");
    REG_OBJ_METHOD("CBaseAnimating", "bool IsSequenceFinished() const");
    REG_OBJ_METHOD("CBaseAnimating", "bool IsSequenceLooping() const");
    // Inherited CBaseEntity methods (asbind20 .base<CBaseEntity>())
    REG_OBJ_METHOD("CBaseAnimating", "Vector3 GetOrigin()");
    REG_OBJ_METHOD("CBaseAnimating", "string GetClassName()");
    REG_OBJ_METHOD("CBaseAnimating", "void SetOrigin(const Vector3 &in)");
    REG_OBJ_METHOD("CBaseAnimating", "float GetHealth()");
    REG_OBJ_METHOD("CBaseAnimating", "void SetHealth(float)");
    REG_OBJ_METHOD("CBaseAnimating", "bool IsAlive()");
    REG_OBJ_METHOD("CBaseAnimating", "string DisplayName()");
    REG_OBJ_METHOD("CBaseAnimating", "Vector3 Center()");
    REG_OBJ_METHOD("CBaseAnimating", "float Volume()");
    REG_OBJ_METHOD("CBaseAnimating", "float Weight()");
    REG_OBJ_METHOD("CBaseAnimating", "bool IsPlayer()");
    REG_OBJ_METHOD("CBaseAnimating", "void SetNetName(const string &in)");
    REG_OBJ_METHOD("CBaseAnimating", "string GetNetName()");
    REG_OBJ_METHOD("CBaseAnimating", "void SetRenderMode(int)");
    REG_OBJ_METHOD("CBaseAnimating", "void SetRenderAmount(int)");
    REG_OBJ_METHOD("CBaseAnimating", "void SetTakeDamage(int)");
    REG_OBJ_METHOD("CBaseAnimating", "void SetGodMode(bool)");

    // ── CBasePlayerItem ─────────────────────────────────────────────────
    REG_OBJ_TYPE("CBasePlayerItem", asOBJ_REF | asOBJ_NOCOUNT);
    REG_OBJ_METHOD("CBasePlayerItem", "string GetItemName() const");
    REG_OBJ_METHOD("CBasePlayerItem", "string GetWorldModel() const");
    REG_OBJ_METHOD("CBasePlayerItem", "string GetHandSpriteName() const");
    REG_OBJ_METHOD("CBasePlayerItem", "string GetTradeSpriteName() const");
    REG_OBJ_METHOD("CBasePlayerItem", "int GetItemID() const");
    REG_OBJ_METHOD("CBasePlayerItem", "uint GetValue() const");
    REG_OBJ_METHOD("CBasePlayerItem", "bool IsWielded() const");
    REG_OBJ_METHOD("CBasePlayerItem", "bool IsUseable() const");
    REG_OBJ_METHOD("CBasePlayerItem", "bool IsMSItem()");
    REG_OBJ_METHOD("CBasePlayerItem", "bool CanDrop()");
    REG_OBJ_METHOD("CBasePlayerItem", "bool Deploy()");
    REG_OBJ_METHOD("CBasePlayerItem", "void Holster()");
    REG_OBJ_METHOD("CBasePlayerItem", "void Materialize()");
    // Inherited from CBaseAnimating + CBaseEntity
    REG_OBJ_METHOD("CBasePlayerItem", "int LookupSequence(const string &in)");
    REG_OBJ_METHOD("CBasePlayerItem", "void ResetSequenceInfo()");
    REG_OBJ_METHOD("CBasePlayerItem", "void SetBodygroup(int, int)");
    REG_OBJ_METHOD("CBasePlayerItem", "int GetBodygroup(int)");
    REG_OBJ_METHOD("CBasePlayerItem", "float GetFrameRate() const");
    REG_OBJ_METHOD("CBasePlayerItem", "bool IsSequenceFinished() const");
    REG_OBJ_METHOD("CBasePlayerItem", "bool IsSequenceLooping() const");
    REG_OBJ_METHOD("CBasePlayerItem", "Vector3 GetOrigin()");
    REG_OBJ_METHOD("CBasePlayerItem", "string GetClassName()");
    REG_OBJ_METHOD("CBasePlayerItem", "void SetOrigin(const Vector3 &in)");
    REG_OBJ_METHOD("CBasePlayerItem", "float GetHealth()");
    REG_OBJ_METHOD("CBasePlayerItem", "void SetHealth(float)");
    REG_OBJ_METHOD("CBasePlayerItem", "bool IsAlive()");
    REG_OBJ_METHOD("CBasePlayerItem", "string DisplayName()");
    REG_OBJ_METHOD("CBasePlayerItem", "Vector3 Center()");
    REG_OBJ_METHOD("CBasePlayerItem", "float Volume()");
    REG_OBJ_METHOD("CBasePlayerItem", "float Weight()");
    REG_OBJ_METHOD("CBasePlayerItem", "bool IsPlayer()");
    REG_OBJ_METHOD("CBasePlayerItem", "void SetNetName(const string &in)");
    REG_OBJ_METHOD("CBasePlayerItem", "string GetNetName()");
    REG_OBJ_METHOD("CBasePlayerItem", "void SetRenderMode(int)");
    REG_OBJ_METHOD("CBasePlayerItem", "void SetRenderAmount(int)");
    REG_OBJ_METHOD("CBasePlayerItem", "void SetTakeDamage(int)");
    REG_OBJ_METHOD("CBasePlayerItem", "void SetGodMode(bool)");

    // ── CBasePlayerWeapon ───────────────────────────────────────────────
    REG_OBJ_TYPE("CBasePlayerWeapon", asOBJ_REF | asOBJ_NOCOUNT);
    REG_OBJ_METHOD("CBasePlayerWeapon", "int GetClip() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetClip(int)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "int GetPrimaryAmmoType() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "int GetSecondaryAmmoType() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "float GetNextPrimaryAttack() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetNextPrimaryAttack(float)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "float GetNextSecondaryAttack() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetNextSecondaryAttack(float)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "float GetTimeWeaponIdle() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "bool IsInReload() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "bool CanDeploy()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "bool IsUseable()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SendWeaponAnim(int, int)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "int PrimaryAmmoIndex()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "int SecondaryAmmoIndex()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "string pszAmmo1()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "string pszAmmo2()");
    // Inherited from CBasePlayerItem chain
    REG_OBJ_METHOD("CBasePlayerWeapon", "string GetItemName() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "string GetWorldModel() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "string GetHandSpriteName() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "string GetTradeSpriteName() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "int GetItemID() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "uint GetValue() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "bool IsWielded() const");
    REG_OBJ_METHOD("CBasePlayerWeapon", "bool IsMSItem()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "bool CanDrop()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "bool Deploy()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void Holster()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void Materialize()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "Vector3 GetOrigin()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "string GetClassName()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetOrigin(const Vector3 &in)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "float GetHealth()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetHealth(float)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "bool IsAlive()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "string DisplayName()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "Vector3 Center()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "float Volume()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "float Weight()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "bool IsPlayer()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetNetName(const string &in)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "string GetNetName()");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetRenderMode(int)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetRenderAmount(int)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetTakeDamage(int)");
    REG_OBJ_METHOD("CBasePlayerWeapon", "void SetGodMode(bool)");
}

//==========================================================================
// Step 5: Enums + CBaseMonster + CMSMonster + CBasePlayer
//         (from ASMonsterBindings.cpp, ASEntityBindings.cpp)
//==========================================================================
static void RegisterMonsterEnums(asIScriptEngine* engine)
{
    int r;
    // MessageColor
    REG_ENUM("MessageColor");
    REG_ENUM_VAL("MessageColor", "White",  0);
    REG_ENUM_VAL("MessageColor", "Gray",   1);
    REG_ENUM_VAL("MessageColor", "Yellow", 2);
    REG_ENUM_VAL("MessageColor", "Red",    3);
    REG_ENUM_VAL("MessageColor", "Green",  4);
    REG_ENUM_VAL("MessageColor", "Blue",   5);

    // Gender
    REG_ENUM("Gender");
    REG_ENUM_VAL("Gender", "GENDER_MALE",    0);
    REG_ENUM_VAL("Gender", "GENDER_FEMALE",  1);
    REG_ENUM_VAL("Gender", "GENDER_UNKNOWN", 2);

    // SpeechType
    REG_ENUM("SpeechType");
    REG_ENUM_VAL("SpeechType", "SPEECH_GLOBAL", 0);
    REG_ENUM_VAL("SpeechType", "SPEECH_LOCAL",  1);
    REG_ENUM_VAL("SpeechType", "SPEECH_PARTY",  2);

    // MonsterState
    REG_ENUM("MonsterState");
    REG_ENUM_VAL("MonsterState", "MONSTERSTATE_NONE",     0);
    REG_ENUM_VAL("MonsterState", "MONSTERSTATE_IDLE",     1);
    REG_ENUM_VAL("MonsterState", "MONSTERSTATE_COMBAT",   2);
    REG_ENUM_VAL("MonsterState", "MONSTERSTATE_ALERT",    3);
    REG_ENUM_VAL("MonsterState", "MONSTERSTATE_HUNT",     4);
    REG_ENUM_VAL("MonsterState", "MONSTERSTATE_PRONE",    5);
    REG_ENUM_VAL("MonsterState", "MONSTERSTATE_SCRIPT",   6);
    REG_ENUM_VAL("MonsterState", "MONSTERSTATE_PLAYDEAD", 7);
    REG_ENUM_VAL("MonsterState", "MONSTERSTATE_DEAD",     8);

    // ScriptMode
    REG_ENUM("ScriptMode");
    REG_ENUM_VAL("ScriptMode", "Legacy", 0);
    REG_ENUM_VAL("ScriptMode", "Angel",  1);
    REG_ENUM_VAL("ScriptMode", "Both",   2);
}

static void RegisterCBaseMonster(asIScriptEngine* engine)
{
    int r;
    REG_OBJ_TYPE("CBaseMonster", asOBJ_REF | asOBJ_NOCOUNT);

    // Properties
    REG_OBJ_METHOD("CBaseMonster", "float get_m_flFieldOfView() const");  // fallback: use method style
    // Direct properties registered via asbind20 .property() in real code — we use dummy offsets
    // Since we use NOCOUNT and can't register real properties on opaque types,
    // we register them as getter/setter methods instead.
    // The transpiled scripts shouldn't access these directly though.

    // Complex property accessors
    REG_OBJ_METHOD("CBaseMonster", "CBaseEntity@ get_Enemy() const");
    REG_OBJ_METHOD("CBaseMonster", "void set_Enemy(CBaseEntity@)");
    REG_OBJ_METHOD("CBaseMonster", "CBaseEntity@ get_TargetEnt() const");
    REG_OBJ_METHOD("CBaseMonster", "void set_TargetEnt(CBaseEntity@)");
    REG_OBJ_METHOD("CBaseMonster", "Vector3 get_EnemyLKP() const");
    REG_OBJ_METHOD("CBaseMonster", "void set_EnemyLKP(const Vector3 &in)");

    // Methods
    REG_OBJ_METHOD("CBaseMonster", "int BloodColor()");
    REG_OBJ_METHOD("CBaseMonster", "void Look(int)");
    REG_OBJ_METHOD("CBaseMonster", "void RunAI()");
    REG_OBJ_METHOD("CBaseMonster", "bool IsAlive()");
    REG_OBJ_METHOD("CBaseMonster", "void MonsterThink()");
    REG_OBJ_METHOD("CBaseMonster", "int IRelationship(CBaseEntity@)");
    REG_OBJ_METHOD("CBaseMonster", "void MonsterInit()");
    REG_OBJ_METHOD("CBaseMonster", "void StartMonster()");
    REG_OBJ_METHOD("CBaseMonster", "CBaseEntity@ BestVisibleEnemy()");
    REG_OBJ_METHOD("CBaseMonster", "bool FInViewCone(CBaseEntity@)");
    REG_OBJ_METHOD("CBaseMonster", "bool FInViewCone(const Vector3 &in)");
    REG_OBJ_METHOD("CBaseMonster", "void SetState(int)");
    REG_OBJ_METHOD("CBaseMonster", "void ReportAIState()");
    REG_OBJ_METHOD("CBaseMonster", "int CheckEnemy(CBaseEntity@)");
    REG_OBJ_METHOD("CBaseMonster", "void PushEnemy(CBaseEntity@, const Vector3 &in)");
    REG_OBJ_METHOD("CBaseMonster", "bool PopEnemy()");
    REG_OBJ_METHOD("CBaseMonster", "void ClearSchedule()");
    REG_OBJ_METHOD("CBaseMonster", "float ChangeYaw(int)");
    REG_OBJ_METHOD("CBaseMonster", "bool FacingIdeal()");
    REG_OBJ_METHOD("CBaseMonster", "Vector3 BodyTarget(const Vector3 &in)");
    REG_OBJ_METHOD("CBaseMonster", "void SetConditions(int)");
    REG_OBJ_METHOD("CBaseMonster", "void ClearConditions(int)");
    REG_OBJ_METHOD("CBaseMonster", "bool HasConditions(int)");
    REG_OBJ_METHOD("CBaseMonster", "bool HasAllConditions(int)");
    REG_OBJ_METHOD("CBaseMonster", "void Remember(int)");
    REG_OBJ_METHOD("CBaseMonster", "void Forget(int)");
    REG_OBJ_METHOD("CBaseMonster", "bool HasMemory(int)");
    REG_OBJ_METHOD("CBaseMonster", "bool HasAllMemories(int)");
    REG_OBJ_METHOD("CBaseMonster", "void TaskComplete()");
    REG_OBJ_METHOD("CBaseMonster", "void TaskFail()");
    REG_OBJ_METHOD("CBaseMonster", "void TaskBegin()");
    REG_OBJ_METHOD("CBaseMonster", "bool IsMoving()");
    REG_OBJ_METHOD("CBaseMonster", "void Stop()");

    // Inherited CBaseEntity methods
    REG_OBJ_METHOD("CBaseMonster", "Vector3 GetOrigin()");
    REG_OBJ_METHOD("CBaseMonster", "string GetClassName()");
    REG_OBJ_METHOD("CBaseMonster", "void SetOrigin(const Vector3 &in)");
    REG_OBJ_METHOD("CBaseMonster", "float GetHealth()");
    REG_OBJ_METHOD("CBaseMonster", "void SetHealth(float)");
    REG_OBJ_METHOD("CBaseMonster", "string DisplayName()");
    REG_OBJ_METHOD("CBaseMonster", "Vector3 Center()");
    REG_OBJ_METHOD("CBaseMonster", "float Volume()");
    REG_OBJ_METHOD("CBaseMonster", "float Weight()");
    REG_OBJ_METHOD("CBaseMonster", "bool IsPlayer()");
    REG_OBJ_METHOD("CBaseMonster", "void SetNetName(const string &in)");
    REG_OBJ_METHOD("CBaseMonster", "string GetNetName()");
    REG_OBJ_METHOD("CBaseMonster", "void SetRenderMode(int)");
    REG_OBJ_METHOD("CBaseMonster", "void SetRenderAmount(int)");
    REG_OBJ_METHOD("CBaseMonster", "void SetTakeDamage(int)");
    REG_OBJ_METHOD("CBaseMonster", "void SetGodMode(bool)");
}

static void RegisterCMSMonster(asIScriptEngine* engine)
{
    int r;
    REG_OBJ_TYPE("CMSMonster", asOBJ_REF | asOBJ_NOCOUNT);

    // Property accessors (msstring types)
    REG_OBJ_METHOD("CMSMonster", "string get_Title()");
    REG_OBJ_METHOD("CMSMonster", "void set_Title(const string &in)");
    REG_OBJ_METHOD("CMSMonster", "string get_ScriptName()");
    REG_OBJ_METHOD("CMSMonster", "void set_ScriptName(const string &in)");

    // Lifecycle
    REG_OBJ_METHOD("CMSMonster", "bool IsMSMonster()");
    REG_OBJ_METHOD("CMSMonster", "float MaxHP()");
    REG_OBJ_METHOD("CMSMonster", "float MaxMP()");
    REG_OBJ_METHOD("CMSMonster", "bool IsAlive()");

    // Economy
    REG_OBJ_METHOD("CMSMonster", "int GiveGold(int, bool)");
    REG_OBJ_METHOD("CMSMonster", "int GiveGold(int)");
    REG_OBJ_METHOD("CMSMonster", "float GiveHP(float)");
    REG_OBJ_METHOD("CMSMonster", "float GiveMP(float)");

    // Stats
    REG_OBJ_METHOD("CMSMonster", "int GetNatStat(int)");
    REG_OBJ_METHOD("CMSMonster", "int GetSkillStat(int)");
    REG_OBJ_METHOD("CMSMonster", "int GetSkillStatCount()");

    // Movement
    REG_OBJ_METHOD("CMSMonster", "float WalkSpeed()");
    REG_OBJ_METHOD("CMSMonster", "float RunSpeed()");
    REG_OBJ_METHOD("CMSMonster", "bool IsFlying()");

    // Combat
    REG_OBJ_METHOD("CMSMonster", "bool IsActing()");
    REG_OBJ_METHOD("CMSMonster", "bool IsShielding()");
    REG_OBJ_METHOD("CMSMonster", "void CancelAttack()");

    // Misc
    REG_OBJ_METHOD("CMSMonster", "float Weight()");
    REG_OBJ_METHOD("CMSMonster", "void SetSpeed()");

    // Inherited CBaseMonster methods
    REG_OBJ_METHOD("CMSMonster", "CBaseEntity@ get_Enemy() const");
    REG_OBJ_METHOD("CMSMonster", "void set_Enemy(CBaseEntity@)");
    REG_OBJ_METHOD("CMSMonster", "CBaseEntity@ get_TargetEnt() const");
    REG_OBJ_METHOD("CMSMonster", "void set_TargetEnt(CBaseEntity@)");
    REG_OBJ_METHOD("CMSMonster", "Vector3 get_EnemyLKP() const");
    REG_OBJ_METHOD("CMSMonster", "void set_EnemyLKP(const Vector3 &in)");
    REG_OBJ_METHOD("CMSMonster", "int BloodColor()");
    REG_OBJ_METHOD("CMSMonster", "void Look(int)");
    REG_OBJ_METHOD("CMSMonster", "void RunAI()");
    REG_OBJ_METHOD("CMSMonster", "void MonsterThink()");
    REG_OBJ_METHOD("CMSMonster", "int IRelationship(CBaseEntity@)");
    REG_OBJ_METHOD("CMSMonster", "void MonsterInit()");
    REG_OBJ_METHOD("CMSMonster", "void StartMonster()");
    REG_OBJ_METHOD("CMSMonster", "CBaseEntity@ BestVisibleEnemy()");
    REG_OBJ_METHOD("CMSMonster", "bool FInViewCone(CBaseEntity@)");
    REG_OBJ_METHOD("CMSMonster", "bool FInViewCone(const Vector3 &in)");
    REG_OBJ_METHOD("CMSMonster", "void SetState(int)");
    REG_OBJ_METHOD("CMSMonster", "void ReportAIState()");
    REG_OBJ_METHOD("CMSMonster", "int CheckEnemy(CBaseEntity@)");
    REG_OBJ_METHOD("CMSMonster", "void PushEnemy(CBaseEntity@, const Vector3 &in)");
    REG_OBJ_METHOD("CMSMonster", "bool PopEnemy()");
    REG_OBJ_METHOD("CMSMonster", "void ClearSchedule()");
    REG_OBJ_METHOD("CMSMonster", "float ChangeYaw(int)");
    REG_OBJ_METHOD("CMSMonster", "bool FacingIdeal()");
    REG_OBJ_METHOD("CMSMonster", "Vector3 BodyTarget(const Vector3 &in)");
    REG_OBJ_METHOD("CMSMonster", "void SetConditions(int)");
    REG_OBJ_METHOD("CMSMonster", "void ClearConditions(int)");
    REG_OBJ_METHOD("CMSMonster", "bool HasConditions(int)");
    REG_OBJ_METHOD("CMSMonster", "bool HasAllConditions(int)");
    REG_OBJ_METHOD("CMSMonster", "void Remember(int)");
    REG_OBJ_METHOD("CMSMonster", "void Forget(int)");
    REG_OBJ_METHOD("CMSMonster", "bool HasMemory(int)");
    REG_OBJ_METHOD("CMSMonster", "bool HasAllMemories(int)");
    REG_OBJ_METHOD("CMSMonster", "void TaskComplete()");
    REG_OBJ_METHOD("CMSMonster", "void TaskFail()");
    REG_OBJ_METHOD("CMSMonster", "void TaskBegin()");
    REG_OBJ_METHOD("CMSMonster", "bool IsMoving()");
    REG_OBJ_METHOD("CMSMonster", "void Stop()");
    // Inherited CBaseEntity
    REG_OBJ_METHOD("CMSMonster", "Vector3 GetOrigin()");
    REG_OBJ_METHOD("CMSMonster", "string GetClassName()");
    REG_OBJ_METHOD("CMSMonster", "void SetOrigin(const Vector3 &in)");
    REG_OBJ_METHOD("CMSMonster", "float GetHealth()");
    REG_OBJ_METHOD("CMSMonster", "void SetHealth(float)");
    REG_OBJ_METHOD("CMSMonster", "string DisplayName()");
    REG_OBJ_METHOD("CMSMonster", "Vector3 Center()");
    REG_OBJ_METHOD("CMSMonster", "float Volume()");
    REG_OBJ_METHOD("CMSMonster", "bool IsPlayer()");
    REG_OBJ_METHOD("CMSMonster", "void SetNetName(const string &in)");
    REG_OBJ_METHOD("CMSMonster", "string GetNetName()");
    REG_OBJ_METHOD("CMSMonster", "void SetRenderMode(int)");
    REG_OBJ_METHOD("CMSMonster", "void SetRenderAmount(int)");
    REG_OBJ_METHOD("CMSMonster", "void SetTakeDamage(int)");
    REG_OBJ_METHOD("CMSMonster", "void SetGodMode(bool)");
}

static void RegisterCBasePlayer(asIScriptEngine* engine)
{
    int r;
    REG_OBJ_TYPE("CBasePlayer", asOBJ_REF | asOBJ_NOCOUNT);

    // Identification
    REG_OBJ_METHOD("CBasePlayer", "string DisplayName() const");
    REG_OBJ_METHOD("CBasePlayer", "string GetName() const");
    REG_OBJ_METHOD("CBasePlayer", "int GetEntIndex() const");

    // State
    REG_OBJ_METHOD("CBasePlayer", "bool IsConnected() const");
    REG_OBJ_METHOD("CBasePlayer", "bool IsAlive() const");
    REG_OBJ_METHOD("CBasePlayer", "bool IsAdmin() const");

    // Position / health
    REG_OBJ_METHOD("CBasePlayer", "Vector3 GetOrigin() const");
    REG_OBJ_METHOD("CBasePlayer", "float GetHealth() const");

    // MS-specific
    REG_OBJ_METHOD("CBasePlayer", "string GetTitle() const");
    REG_OBJ_METHOD("CBasePlayer", "float MaxHP() const");
    REG_OBJ_METHOD("CBasePlayer", "float MaxMP() const");
    REG_OBJ_METHOD("CBasePlayer", "bool IsElite() const");
    REG_OBJ_METHOD("CBasePlayer", "string GetPartyName() const");
    REG_OBJ_METHOD("CBasePlayer", "bool IsLocalHost() const");
    REG_OBJ_METHOD("CBasePlayer", "string GetSteamID() const");

    // Inherited CBaseEntity
    REG_OBJ_METHOD("CBasePlayer", "string GetClassName() const");
    REG_OBJ_METHOD("CBasePlayer", "void SetOrigin(const Vector3 &in)");
    REG_OBJ_METHOD("CBasePlayer", "void SetHealth(float)");
    REG_OBJ_METHOD("CBasePlayer", "Vector3 Center() const");
    REG_OBJ_METHOD("CBasePlayer", "float Volume() const");
    REG_OBJ_METHOD("CBasePlayer", "float Weight() const");
    REG_OBJ_METHOD("CBasePlayer", "bool IsPlayer() const");

    // Sound / messaging
    REG_OBJ_METHOD("CBasePlayer", "void PlaySound(const string &in)");
    REG_OBJ_METHOD("CBasePlayer", "void SendInfoMsg(const string &in)");
    REG_OBJ_METHOD("CBasePlayer", "void SendEventMsg(const string &in)");
    REG_OBJ_METHOD("CBasePlayer", "void SendColoredMessage(MessageColor, const string &in)");
    REG_OBJ_METHOD("CBasePlayer", "void SendHUDInfoMessage(const string &in, const string &in)");

    // Map transition
    REG_OBJ_METHOD("CBasePlayer", "void SetTransitionFields(const string &in, const string &in, const string &in)");
    REG_OBJ_METHOD("CBasePlayer", "string GetOldTransition() const");
    REG_OBJ_METHOD("CBasePlayer", "string GetNextMap() const");
    REG_OBJ_METHOD("CBasePlayer", "string GetNextTransition() const");
    REG_OBJ_METHOD("CBasePlayer", "int GetJoinType() const");
    REG_OBJ_METHOD("CBasePlayer", "void SetJoinType(int)");
    REG_OBJ_METHOD("CBasePlayer", "bool MoveToSpawnSpot()");
    REG_OBJ_METHOD("CBasePlayer", "void SetSpawnTransition(const string &in)");
    REG_OBJ_METHOD("CBasePlayer", "string GetSpawnTransition() const");

    // Inventory
    REG_OBJ_METHOD("CBasePlayer", "CBasePlayerItem@ GetItemBySlot(int) const");
    REG_OBJ_METHOD("CBasePlayer", "CBasePlayerWeapon@ GetActiveWeapon() const");
    REG_OBJ_METHOD("CBasePlayer", "array<CBasePlayerItem@>@ GetInventory()");
    REG_OBJ_METHOD("CBasePlayer", "bool HasItem(const string &in) const");

    // Equality
    REG_OBJ_METHOD("CBasePlayer", "bool opEquals(const CBasePlayer@ other) const");
}

//==========================================================================
// Step 6: Cross-references (CBasePlayerItem::GetOwnerPlayer etc.)
//==========================================================================
static void RegisterCrossReferences(asIScriptEngine* engine)
{
    int r;
    REG_OBJ_METHOD("CBasePlayerItem", "CBasePlayer@ GetOwnerPlayer() const");
    // Also register GetOwnerMonster which exists in the real code
    REG_OBJ_METHOD("CBasePlayerItem", "CMSMonster@ GetOwnerMonster() const");
}

//==========================================================================
// Step 7: Builtin functions (from ASBuiltinFunctions.cpp + ASEngineBindings.h
//         + ASEntityBindings.cpp)
//==========================================================================
static void RegisterBuiltinFunctions(asIScriptEngine* engine)
{
    int r;

    // === Math (integer overloads from ASBuiltinFunctions) ===
    REG_GLOBAL_FUNC("int abs(int)");
    REG_GLOBAL_FUNC("int min(int, int)");
    REG_GLOBAL_FUNC("int max(int, int)");

    // === Vector utilities ===
    REG_GLOBAL_FUNC("Vector3 CreateVector(float, float, float)");
    REG_GLOBAL_FUNC("float GetVectorX(const Vector3 &in)");
    REG_GLOBAL_FUNC("float GetVectorY(const Vector3 &in)");
    REG_GLOBAL_FUNC("float GetVectorZ(const Vector3 &in)");
    REG_GLOBAL_FUNC("float Distance(const Vector3 &in, const Vector3 &in)");
    REG_GLOBAL_FUNC("float DotProduct(const Vector3 &in, const Vector3 &in)");

    // === String utilities ===
    REG_GLOBAL_FUNC("string formatFloat(float, const string &in, int, int)");
    REG_GLOBAL_FUNC("array<string>@ split(const string &in, const string &in)");

    // === Random ===
    REG_GLOBAL_FUNC("float Random(float, float)");
    REG_GLOBAL_FUNC("int RandomInt(int, int)");

    // === Logging ===
    REG_GLOBAL_FUNC("void LogMessage(const string &in)");
    REG_GLOBAL_FUNC("void DeveloperMessage(int, const string &in)");
    REG_GLOBAL_FUNC("void MS_ANGEL_INFO(const string &in)");
    REG_GLOBAL_FUNC("void MS_ANGEL_DEBUG(const string &in)");
    REG_GLOBAL_FUNC("void MS_ANGEL_ERROR(const string &in)");

    // === Angle functions ===
    REG_GLOBAL_FUNC("Vector3 CreateAngles(float, float, float)");
    REG_GLOBAL_FUNC("float GetAnglePitch(const Vector3 &in)");
    REG_GLOBAL_FUNC("float GetAngleYaw(const Vector3 &in)");
    REG_GLOBAL_FUNC("float GetAngleRoll(const Vector3 &in)");

    // === Game state (ASEngineBindings.h) ===
    REG_GLOBAL_FUNC("float GetGameTime()");
    REG_GLOBAL_FUNC("string GetCvar(const string &in)");
    REG_GLOBAL_FUNC("string GetMapName()");
    REG_GLOBAL_FUNC("int GetMaxClients()");

    // === Entity management (ASEngineBindings.h) ===
    REG_GLOBAL_FUNC("CBaseEntity@ CreateEntity(const string &in)");
    REG_GLOBAL_FUNC("void SetEntityOrigin(CBaseEntity@, const Vector3 &in)");
    REG_GLOBAL_FUNC("void SetEntityName(CBaseEntity@, const string &in)");
    REG_GLOBAL_FUNC("void SetEntityTargetName(CBaseEntity@, const string &in)");
    REG_GLOBAL_FUNC("void SetEntityHealth(CBaseEntity@, float)");
    REG_GLOBAL_FUNC("Vector3 GetEntityOrigin(CBaseEntity@)");
    REG_GLOBAL_FUNC("float GetEntityHealth(CBaseEntity@)");
    REG_GLOBAL_FUNC("int GetEntityDeadFlag(CBaseEntity@)");
    REG_GLOBAL_FUNC("string GetEntityClassName(CBaseEntity@)");
    REG_GLOBAL_FUNC("bool IsEntityDead(CBaseEntity@)");
    REG_GLOBAL_FUNC("bool IsEntityAlive(CBaseEntity@)");
    REG_GLOBAL_FUNC("bool IsValidEntity(CBaseEntity@)");

    // === Player functions (ASEngineBindings.h + ASEntityBindings.cpp) ===
    REG_GLOBAL_FUNC("string GetPlayerAuthId(CBasePlayer@)");
    REG_GLOBAL_FUNC("string GetPlayerDisplayName(CBasePlayer@)");
    REG_GLOBAL_FUNC("string GetPlayerClientAddress(CBasePlayer@)");
    REG_GLOBAL_FUNC("int GetPlayerEntIndex(CBasePlayer@)");
    REG_GLOBAL_FUNC("bool IsValidPlayer(CBasePlayer@)");
    REG_GLOBAL_FUNC("void SendPlayerMessage(CBasePlayer@, const string &in)");

    // === Convenience (ASEngineBindings.h) ===
    REG_GLOBAL_FUNC("bool TeleportEntity(CBaseEntity@, const Vector3 &in)");
    REG_GLOBAL_FUNC("void HealEntity(CBaseEntity@, float)");
    REG_GLOBAL_FUNC("void DamageEntity(CBaseEntity@, float)");
    REG_GLOBAL_FUNC("void KillEntity(CBaseEntity@)");
    REG_GLOBAL_FUNC("Vector3 GetPlayerPosition(CBasePlayer@)");
    REG_GLOBAL_FUNC("bool TeleportPlayer(CBasePlayer@, const Vector3 &in)");

    // === Sound ===
    REG_GLOBAL_FUNC("void EmitSound(CBaseEntity@, int, const string &in, float, float, int, int)");
    REG_GLOBAL_FUNC("void EmitSound(CBaseEntity@, const string &in)");
    REG_GLOBAL_FUNC("void EmitSound(CBaseEntity@, const string &in, float)");

    // === Entity global functions (ASEntityBindings.cpp RegisterGlobalFunctions) ===
    REG_GLOBAL_FUNC("string GetTimestamp()");
    REG_GLOBAL_FUNC("void ChatLog(const string &in)");
    REG_GLOBAL_FUNC("string GetPlayerCurrentMap()");
    REG_GLOBAL_FUNC("int GetCurrentPlayerID()");
    REG_GLOBAL_FUNC("void SendPlayerMessage(const string &in, const string &in, const string &in)");
    REG_GLOBAL_FUNC("array<CBasePlayer@>@ GetAllPlayers()");
    REG_GLOBAL_FUNC("int GetPlayerCount()");
    REG_GLOBAL_FUNC("CBasePlayer@ PlayerByIndex(int)");
    REG_GLOBAL_FUNC("CBasePlayer@ PlayerBySteamID(const string &in)");
    REG_GLOBAL_FUNC("bool IsConnected(CBasePlayer@)");
    REG_GLOBAL_FUNC("string GetDisplayName(CBasePlayer@)");
    REG_GLOBAL_FUNC("string GetSteamID(CBasePlayer@)");
    REG_GLOBAL_FUNC("string GetPlayerSteamID(CBasePlayer@)");
    REG_GLOBAL_FUNC("bool IsAdmin(CBasePlayer@)");
    REG_GLOBAL_FUNC("string GetClientAddress(CBasePlayer@)");
    REG_GLOBAL_FUNC("string GetPlayerQuestData(const string &in, const string &in)");
    REG_GLOBAL_FUNC("void SetPlayerQuestData(const string &in, const string &in, const string &in)");
    REG_GLOBAL_FUNC("void OpenVoteMenu(CBasePlayer@, const string &in, const array<string> &in)");
    REG_GLOBAL_FUNC("CMSMonster@ SpawnNPC(const string &in, const Vector3 &in, const array<string>@ = null, ScriptMode = Legacy)");
    REG_GLOBAL_FUNC("CBasePlayerItem@ SpawnItem(const string &in, const Vector3 &in, const array<string>@ = null)");

    // === Casting functions (ASEntityBindings + ASMonsterBindings) ===
    REG_GLOBAL_FUNC("CBaseEntity@ ToEntity(CBasePlayer@)");
    REG_GLOBAL_FUNC("CBasePlayer@ ToPlayer(CBaseEntity@)");
    REG_GLOBAL_FUNC("CBaseEntity@ StringToEntity(const string &in)");
    REG_GLOBAL_FUNC("CBasePlayer@ StringToPlayer(const string &in)");
    REG_GLOBAL_FUNC("CBaseMonster@ ToMonster(CBaseEntity@)");
    REG_GLOBAL_FUNC("CMSMonster@ ToMSMonster(CBaseEntity@)");
    REG_GLOBAL_FUNC("CMSMonster@ ToMSMonster(CBaseMonster@)");
    REG_GLOBAL_FUNC("CBaseEntity@ ToEntity(CBaseMonster@)");
    REG_GLOBAL_FUNC("CBaseEntity@ ToEntity(CMSMonster@)");

    // === Render / damage constants ===
    engine->RegisterGlobalProperty("const int kRenderNormal",       (void*)&g_kRenderNormal);
    engine->RegisterGlobalProperty("const int kRenderTransColor",   (void*)&g_kRenderTransColor);
    engine->RegisterGlobalProperty("const int kRenderTransTexture", (void*)&g_kRenderTransTexture);
    engine->RegisterGlobalProperty("const int kRenderGlow",         (void*)&g_kRenderGlow);
    engine->RegisterGlobalProperty("const int kRenderTransAlpha",   (void*)&g_kRenderTransAlpha);
    engine->RegisterGlobalProperty("const int kRenderTransAdd",     (void*)&g_kRenderTransAdd);
    engine->RegisterGlobalProperty("const int DAMAGE_NO",           (void*)&g_DAMAGE_NO);
    engine->RegisterGlobalProperty("const int DAMAGE_YES",          (void*)&g_DAMAGE_YES);
    engine->RegisterGlobalProperty("const int DAMAGE_AIM",          (void*)&g_DAMAGE_AIM);

    // === GameMaster functions (ASBuiltinFunctions.cpp RegisterGameMasterFunctions) ===
    REG_GLOBAL_FUNC("void ExecuteServerCommand(const string &in)");
    REG_GLOBAL_FUNC("bool EngineMapExists(const string &in)");
    REG_GLOBAL_FUNC("void SendPlayerMessage(const string &in, const string &in)");
    REG_GLOBAL_FUNC("void SendConsoleMessage(const string &in, const string &in)");
    REG_GLOBAL_FUNC("void SendInfoMessageToAll(const string &in, const string &in)");
    REG_GLOBAL_FUNC("void SendMessageToAllPlayers(const string &in, const string &in)");
    REG_GLOBAL_FUNC("void CallPlayerExternal(const string &in, const string &in, array<string>@)");
    REG_GLOBAL_FUNC("void CallGameMasterExternal(const string &in, array<string>@)");
    REG_GLOBAL_FUNC("bool MovePlayerToRandomSpawn(CBasePlayer@, float)");

    // Advanced systems
    REG_GLOBAL_FUNC("void InitializeAdvancedTriggerSystem()");
    REG_GLOBAL_FUNC("void InitializeHPSequenceTrigger()");
    REG_GLOBAL_FUNC("void InitializeEntitySpawner()");
    REG_GLOBAL_FUNC("void InitializeEntityCommunications()");
    REG_GLOBAL_FUNC("void ShutdownAdvancedTriggerSystem()");
    REG_GLOBAL_FUNC("void ShutdownHPSequenceTrigger()");
    REG_GLOBAL_FUNC("void ShutdownEntitySpawner()");
    REG_GLOBAL_FUNC("void ShutdownEntityCommunications()");
    REG_GLOBAL_FUNC("bool IsAdvancedTriggerSystemActive()");
    REG_GLOBAL_FUNC("bool IsHPSequenceSystemActive()");
    REG_GLOBAL_FUNC("bool IsEntitySpawnerActive()");
    REG_GLOBAL_FUNC("bool IsEntityCommSystemActive()");
    REG_GLOBAL_FUNC("int GetActiveTriggersCount()");
    REG_GLOBAL_FUNC("int GetActiveSequencesCount()");
}

//==========================================================================
// Step 8: CGameScript (from ASScriptClasses.cpp)
//==========================================================================
static void RegisterScriptClasses(asIScriptEngine* engine)
{
    // CGameScript is NOT registered as a native type here.
    // It is injected as a script-defined class (from linter_base_script.h)
    // into each module so that transpiled scripts can inherit from it.
    // See main.cpp: the base script is added as a section before each file.
    (void)engine;
}

//==========================================================================
// Step 9: Coroutines (from ASCoroutines.cpp)
//==========================================================================
static void RegisterCoroutines(asIScriptEngine* engine)
{
    int r;
    REG_GLOBAL_FUNC("int StartCoroutine(const string &in)");
    REG_GLOBAL_FUNC("void StopCoroutine(int)");
    REG_GLOBAL_FUNC("void DelaySeconds(float)");
    REG_GLOBAL_FUNC("void YieldFrame()");
    REG_GLOBAL_FUNC("bool IsCoroutineRunning(int)");
}

//==========================================================================
// Step 11: Module system (from ASModuleSystem.cpp)
//==========================================================================
static void RegisterModuleSystem(asIScriptEngine* engine)
{
    int r;
    REG_GLOBAL_FUNC("bool LoadASModule(const string &in)");
    REG_GLOBAL_FUNC("bool UnloadModule(const string &in)");
    REG_GLOBAL_FUNC("bool ReloadModule(const string &in)");
    REG_GLOBAL_FUNC("bool HasModule(const string &in)");
    REG_GLOBAL_FUNC("bool ReloadAllScriptModules()");
    REG_GLOBAL_FUNC("bool ImportModule(const string &in)");
    REG_GLOBAL_FUNC("bool ImportModule(const string &in, const string &in)");
}

//==========================================================================
// Step 12: Engine events (from ASEngineEventManager.cpp)
//==========================================================================
static void RegisterEngineEvents(asIScriptEngine* engine)
{
    int r;
    // RegisterEngineEvent uses asCALL_GENERIC with ?&in (generic type parameter)
    // We register it directly since the macro uses asCALL_GENERIC anyway
    r = engine->RegisterGlobalFunction("void RegisterEngineEvent(const string &in, ?&in)",
        asFUNCTION(DummyGeneric), asCALL_GENERIC);
    if (r < 0) fprintf(stderr, "WARN: RegisterEngineEvent = %d\n", r);
    REG_GLOBAL_FUNC("void UnregisterEngineEvent(const string &in)");
    REG_GLOBAL_FUNC("void LogEngineEventHandlers()");
}

//==========================================================================
// Master registration — mirrors ASBindings::RegisterAll() order exactly
//==========================================================================
void RegisterAllBindings(asIScriptEngine* engine)
{
    // Step 0: String type (MUST be first)
    RegisterStdString(engine);

    // Step 1: Array type
    RegisterScriptArray(engine, true);

    // Step 1.3: Dictionary type
    RegisterScriptDictionary(engine);

    // Step 1.5: String utilities (depends on array<string>)
    RegisterStdStringUtils(engine);

    // Step 2: Core types (Vector3, Color, math)
    RegisterCoreTypes(engine);

    // Step 3: CBaseEntity
    RegisterCBaseEntity(engine);

    // Step 4: Item/weapon types (before CBasePlayer)
    RegisterItemTypes(engine);

    // Step 5: Enums + monsters + CBasePlayer
    RegisterMonsterEnums(engine);
    RegisterCBaseMonster(engine);
    RegisterCMSMonster(engine);
    RegisterCBasePlayer(engine);

    // Step 6: Cross-references
    RegisterCrossReferences(engine);

    // Step 7: Builtin functions
    RegisterBuiltinFunctions(engine);

    // Step 8: Script classes (CGameScript)
    RegisterScriptClasses(engine);

    // Step 9: Coroutines
    RegisterCoroutines(engine);

    // Step 10: Memory optimization (no script-callable functions currently)
    // (RegisterMemoryOptimizationFunctions is a no-op in the real game)

    // Step 11: Module system
    RegisterModuleSystem(engine);

    // Step 12: Engine events
    RegisterEngineEvents(engine);

    fprintf(stderr, "Linter: All bindings registered successfully.\n");
}
