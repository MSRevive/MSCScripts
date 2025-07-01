/**
 * CombatSystem.as
 * 
 * Combat mechanics and damage tracking system for Master Sword Rebirth.
 * Handles damage calculation, combat events, and combat-related functions.
 * Integrates with the magic system for spell damage and effects.
 */

#include "gamemaster/GameMasterData.as"
#include "gamemaster/GameMasterUtils.as"
#include "magic/SpellRegistry.as"

namespace MS
{
    /**
     * Damage types for different attack methods
     */
    enum EDamageType
    {
        DAMAGE_TYPE_NONE = 0,
        DAMAGE_TYPE_SLASH,      // Slashing weapons
        DAMAGE_TYPE_PIERCE,     // Piercing weapons
        DAMAGE_TYPE_BLUNT,      // Blunt weapons
        DAMAGE_TYPE_FIRE,       // Fire damage
        DAMAGE_TYPE_COLD,       // Cold/ice damage
        DAMAGE_TYPE_LIGHTNING,  // Lightning damage
        DAMAGE_TYPE_POISON,     // Poison damage
        DAMAGE_TYPE_ACID,       // Acid damage
        DAMAGE_TYPE_HOLY,       // Holy damage
        DAMAGE_TYPE_DARK,       // Dark damage
        DAMAGE_TYPE_MAGIC       // Generic magic damage
    }
    
    /**
     * Status effect types
     */
    enum EStatusEffect
    {
        STATUS_EFFECT_NONE = 0,
        STATUS_EFFECT_POISON,       // Damage over time from poison
        STATUS_EFFECT_BURN,         // Fire damage over time
        STATUS_EFFECT_FREEZE,       // Movement and action speed reduction
        STATUS_EFFECT_SHOCK,        // Lightning stun effect
        STATUS_EFFECT_BLIND,        // Vision reduction
        STATUS_EFFECT_SLOW,         // Movement speed reduction
        STATUS_EFFECT_WEAKEN,       // Damage reduction
        STATUS_EFFECT_CURSE,        // Multiple negative effects
        STATUS_EFFECT_REGENERATION, // Health regeneration
        STATUS_EFFECT_SHIELD,       // Damage absorption
        STATUS_EFFECT_HASTE,        // Speed increase
        STATUS_EFFECT_STRENGTH      // Damage increase
    }
    
    /**
     * Resistance types for damage mitigation
     */
    enum EResistanceType
    {
        RESISTANCE_PHYSICAL = 0,    // Physical damage resistance
        RESISTANCE_FIRE,            // Fire damage resistance
        RESISTANCE_COLD,            // Cold damage resistance
        RESISTANCE_LIGHTNING,       // Lightning damage resistance
        RESISTANCE_POISON,          // Poison damage resistance
        RESISTANCE_ACID,            // Acid damage resistance
        RESISTANCE_HOLY,            // Holy damage resistance
        RESISTANCE_DARK,            // Dark damage resistance
        RESISTANCE_MAGIC            // Magic damage resistance
    }
    
    /**
     * Combat event types
     */
    enum ECombatEvent
    {
        COMBAT_EVENT_DAMAGE_DEALT,
        COMBAT_EVENT_DAMAGE_TAKEN,
        COMBAT_EVENT_KILL,
        COMBAT_EVENT_DEATH,
        COMBAT_EVENT_SPELL_CAST,
        COMBAT_EVENT_BLOCK,
        COMBAT_EVENT_DODGE,
        COMBAT_EVENT_CRITICAL_HIT
    }
    
    /**
     * Status effect data
     */
    class StatusEffect
    {
        EStatusEffect eType;        // Type of status effect
        float flDuration;           // Duration in seconds
        float flStrength;           // Effect strength/intensity
        float flTickRate;           // How often effect applies (for DoT)
        float flLastTick;           // Last time effect was applied
        EntityHandle hSource;       // Entity that caused the effect
        string szEffectName;        // Display name of effect
        
        StatusEffect()
        {
            eType = STATUS_EFFECT_NONE;
            flDuration = 0.0f;
            flStrength = 0.0f;
            flTickRate = 1.0f;
            flLastTick = 0.0f;
            hSource = EntityHandle();
            szEffectName = "";
        }
        
        StatusEffect(EStatusEffect type, float duration, float strength, const string &in name)
        {
            eType = type;
            flDuration = duration;
            flStrength = strength;
            flTickRate = 1.0f;
            flLastTick = 0.0f;
            hSource = EntityHandle();
            szEffectName = name;
        }
    }
    
    /**
     * Entity resistance data
     */
    class ResistanceData
    {
        float flPhysicalResist;     // Physical damage resistance (0.0-1.0)
        float flFireResist;         // Fire damage resistance
        float flColdResist;         // Cold damage resistance
        float flLightningResist;    // Lightning damage resistance
        float flPoisonResist;       // Poison damage resistance
        float flAcidResist;         // Acid damage resistance
        float flHolyResist;         // Holy damage resistance
        float flDarkResist;         // Dark damage resistance
        float flMagicResist;        // Magic damage resistance
        
        ResistanceData()
        {
            flPhysicalResist = 0.0f;
            flFireResist = 0.0f;
            flColdResist = 0.0f;
            flLightningResist = 0.0f;
            flPoisonResist = 0.0f;
            flAcidResist = 0.0f;
            flHolyResist = 0.0f;
            flDarkResist = 0.0f;
            flMagicResist = 0.0f;
        }
        
        /**
         * Get resistance for specific damage type
         */
        float GetResistance(EDamageType damageType)
        {
            switch (damageType)
            {
                case DAMAGE_TYPE_SLASH:
                case DAMAGE_TYPE_PIERCE:
                case DAMAGE_TYPE_BLUNT:
                    return flPhysicalResist;
                case DAMAGE_TYPE_FIRE:
                    return flFireResist;
                case DAMAGE_TYPE_COLD:
                    return flColdResist;
                case DAMAGE_TYPE_LIGHTNING:
                    return flLightningResist;
                case DAMAGE_TYPE_POISON:
                    return flPoisonResist;
                case DAMAGE_TYPE_ACID:
                    return flAcidResist;
                case DAMAGE_TYPE_HOLY:
                    return flHolyResist;
                case DAMAGE_TYPE_DARK:
                    return flDarkResist;
                case DAMAGE_TYPE_MAGIC:
                    return flMagicResist;
            }
            return 0.0f;
        }
    }
    
    /**
     * Damage information structure
     */
    class DamageInfo
    {
        float flDamage;             // Amount of damage
        EDamageType eDamageType;    // Type of damage
        Vector3 vecDamageOrigin;    // Origin point of damage
        Vector3 vecDamageForce;     // Force applied by damage
        EntityHandle hAttacker;     // Entity that caused damage
        EntityHandle hWeapon;       // Weapon or spell entity
        string szDamageSource;      // Source description (spell name, weapon name)
        bool bIsCritical;           // Whether this was a critical hit
        bool bIsSpellDamage;        // Whether this is from a spell
        float flArmorPenetration;   // Armor penetration factor (0.0-1.0)
        float flCriticalChance;     // Chance for critical hit (0.0-1.0)
        float flCriticalMultiplier; // Critical hit damage multiplier
        array<StatusEffect> statusEffects; // Status effects to apply
        
        DamageInfo()
        {
            flDamage = 0.0f;
            eDamageType = DAMAGE_TYPE_NONE;
            vecDamageOrigin = Vector3();
            vecDamageForce = Vector3();
            hAttacker = EntityHandle();
            hWeapon = EntityHandle();
            szDamageSource = "";
            bIsCritical = false;
            bIsSpellDamage = false;
            flArmorPenetration = 0.0f;
            flCriticalChance = 0.05f;    // 5% base critical chance
            flCriticalMultiplier = 2.0f; // 2x damage on critical
        }
    }
    
    /**
     * Combat statistics for tracking
     */
    class CombatStats
    {
        string szPlayerID;          // Player identifier
        float flTotalDamageDealt;   // Total damage dealt
        float flTotalDamageTaken;   // Total damage taken
        uint nKills;                // Number of kills
        uint nDeaths;               // Number of deaths
        uint nSpellsCast;           // Number of spells cast
        uint nCriticalHits;         // Number of critical hits
        uint nBlockedAttacks;       // Number of blocked attacks
        float flLastCombatTime;     // Last time engaged in combat
        
        CombatStats()
        {
            szPlayerID = "";
            flTotalDamageDealt = 0.0f;
            flTotalDamageTaken = 0.0f;
            nKills = 0;
            nDeaths = 0;
            nSpellsCast = 0;
            nCriticalHits = 0;
            nBlockedAttacks = 0;
            flLastCombatTime = 0.0f;
        }
        
        /**
         * Reset all statistics
         */
        void Reset()
        {
            flTotalDamageDealt = 0.0f;
            flTotalDamageTaken = 0.0f;
            nKills = 0;
            nDeaths = 0;
            nSpellsCast = 0;
            nCriticalHits = 0;
            nBlockedAttacks = 0;
            flLastCombatTime = 0.0f;
        }
    }
    
    /**
     * Combat event data for logging and tracking
     */
    class CombatEvent
    {
        ECombatEvent eEventType;    // Type of combat event
        float flTimestamp;          // When the event occurred
        EntityHandle hSource;       // Source entity
        EntityHandle hTarget;       // Target entity
        float flValue;              // Damage amount or other value
        string szDescription;       // Event description
        
        CombatEvent()
        {
            eEventType = COMBAT_EVENT_DAMAGE_DEALT;
            flTimestamp = 0.0f;
            hSource = EntityHandle();
            hTarget = EntityHandle();
            flValue = 0.0f;
            szDescription = "";
        }
    }
    
    /**
     * Core combat system manager
     */
    class CombatSystem
    {
        private dictionary m_PlayerStats;       // Player ID -> CombatStats@
        private array<CombatEvent> m_CombatLog; // Recent combat events
        private uint m_nMaxLogEntries;          // Maximum log entries to keep
        private bool m_bInitialized = false;
        
        CombatSystem()
        {
            m_nMaxLogEntries = 1000; // Keep last 1000 combat events
        }
        
        /**
         * Initialize the combat system
         */
        bool Initialize()
        {
            if (m_bInitialized)
            {
                LogMessage("[WARNING] CombatSystem already initialized");
                return true;
            }
            
            LogMessage("[INFO] Initializing CombatSystem...");
            
            m_PlayerStats.deleteAll();
            m_CombatLog.resize(0);
            
            m_bInitialized = true;
            LogMessage("[INFO] CombatSystem initialized successfully");
            return true;
        }
        
        /**
         * Process damage dealt to an entity
         */
        float ProcessDamage(CBaseEntity@ pTarget, const DamageInfo &in damageInfo)
        {
            if (pTarget is null)
            {
                LogMessage("[ERROR] ProcessDamage: Invalid target");
                return 0.0f;
            }
            
            if (damageInfo.flDamage <= 0.0f)
                return 0.0f;
            
            float flFinalDamage = CalculateFinalDamage(pTarget, damageInfo);
            
            // Apply damage to target
            ApplyDamageToEntity(pTarget, flFinalDamage, damageInfo);
            
            // Update combat statistics
            UpdateCombatStats(damageInfo, flFinalDamage);
            
            // Log combat event
            LogCombatEvent(COMBAT_EVENT_DAMAGE_DEALT, damageInfo.hAttacker, 
                          EntityHandle(pTarget), flFinalDamage, 
                          "Damage: " + flFinalDamage + " (" + damageInfo.szDamageSource + ")");
            
            LogMessage("[DEBUG] Damage processed: " + flFinalDamage + " to " + pTarget.GetName());
            
            return flFinalDamage;
        }
        
        /**
         * Process spell damage (integrates with magic system)
         */
        float ProcessSpellDamage(CBaseEntity@ pTarget, CBaseEntity@ pCaster, SpellData@ pSpell, float flBaseDamage)
        {
            if (pTarget is null || pCaster is null || pSpell is null)
                return 0.0f;
            
            DamageInfo damageInfo;
            damageInfo.flDamage = flBaseDamage;
            damageInfo.eDamageType = GetDamageTypeFromString(pSpell.szDamageType);
            damageInfo.hAttacker = EntityHandle(pCaster);
            damageInfo.szDamageSource = pSpell.szDisplayName;
            damageInfo.bIsSpellDamage = true;
            damageInfo.vecDamageOrigin = pCaster.GetOrigin();
            
            // Calculate spell-specific damage modifiers
            float flSpellDamage = CalculateSpellDamage(pCaster, pSpell, flBaseDamage);
            damageInfo.flDamage = flSpellDamage;
            
            return ProcessDamage(pTarget, damageInfo);
        }
        
        /**
         * Get combat statistics for a player
         */
        CombatStats@ GetPlayerStats(const string &in szPlayerID)
        {
            CombatStats@ pStats;
            
            if (m_PlayerStats.get(szPlayerID, @pStats))
            {
                return pStats;
            }
            
            // Create new stats
            @pStats = CombatStats();
            pStats.szPlayerID = szPlayerID;
            m_PlayerStats.set(szPlayerID, @pStats);
            
            LogMessage("[DEBUG] Created combat stats for player: " + szPlayerID);
            return pStats;
        }
        
        /**
         * Handle player death
         */
        void HandlePlayerDeath(CBasePlayer@ pPlayer, CBaseEntity@ pKiller)
        {
            if (pPlayer is null)
                return;
            
            string szPlayerID = pPlayer.GetSteamID();
            CombatStats@ pStats = GetPlayerStats(szPlayerID);
            pStats.nDeaths++;
            pStats.flLastCombatTime = GetGameTime();
            
            // Update killer stats if it's a player
            CBasePlayer@ pKillerPlayer = cast<CBasePlayer@>(pKiller);
            if (pKillerPlayer !is null)
            {
                string szKillerID = pKillerPlayer.GetSteamID();
                CombatStats@ pKillerStats = GetPlayerStats(szKillerID);
                pKillerStats.nKills++;
                pKillerStats.flLastCombatTime = GetGameTime();
                
                LogCombatEvent(COMBAT_EVENT_KILL, EntityHandle(pKillerPlayer), 
                              EntityHandle(pPlayer), 1.0f, 
                              pKillerPlayer.GetName() + " killed " + pPlayer.GetName());
            }
            
            LogCombatEvent(COMBAT_EVENT_DEATH, EntityHandle(pPlayer), 
                          EntityHandle(pKiller), 1.0f, 
                          pPlayer.GetName() + " died");
            
            LogMessage("[INFO] Player death: " + pPlayer.GetName());
        }
        
        /**
         * Handle spell casting event
         */
        void HandleSpellCast(CBasePlayer@ pPlayer, SpellData@ pSpell)
        {
            if (pPlayer is null || pSpell is null)
                return;
            
            string szPlayerID = pPlayer.GetSteamID();
            CombatStats@ pStats = GetPlayerStats(szPlayerID);
            pStats.nSpellsCast++;
            pStats.flLastCombatTime = GetGameTime();
            
            LogCombatEvent(COMBAT_EVENT_SPELL_CAST, EntityHandle(pPlayer), 
                          EntityHandle(), 1.0f, 
                          pPlayer.GetName() + " cast " + pSpell.szDisplayName);
            
            LogMessage("[DEBUG] Spell cast: " + pPlayer.GetName() + " -> " + pSpell.szDisplayName);
        }
        
        /**
         * Check if damage should be blocked/reduced
         */
        bool CheckDamageBlocking(CBaseEntity@ pTarget, const DamageInfo &in damageInfo)
        {
            if (pTarget is null)
                return false;
            
            // Check for shield blocking
            // Note: This would integrate with the shield system
            
            // Check for spell immunity/resistance
            if (damageInfo.bIsSpellDamage)
            {
                // Check for magic resistance
                return CheckMagicResistance(pTarget, damageInfo.eDamageType);
            }
            
            return false;
        }
        
        /**
         * Get recent combat events
         */
        array<CombatEvent> GetRecentCombatEvents(uint nMaxEvents = 50)
        {
            array<CombatEvent> recentEvents;
            
            uint nStartIndex = (m_CombatLog.length() > nMaxEvents) ? 
                              (m_CombatLog.length() - nMaxEvents) : 0;
            
            for (uint i = nStartIndex; i < m_CombatLog.length(); i++)
            {
                recentEvents.insertLast(m_CombatLog[i]);
            }
            
            return recentEvents;
        }
        
        /**
         * Clear combat statistics for a player
         */
        void ClearPlayerStats(const string &in szPlayerID)
        {
            if (m_PlayerStats.exists(szPlayerID))
            {
                m_PlayerStats.delete(szPlayerID);
                LogMessage("[DEBUG] Cleared combat stats for player: " + szPlayerID);
            }
        }
        
        /**
         * Reset all combat statistics
         */
        void ResetAllStats()
        {
            m_PlayerStats.deleteAll();
            m_CombatLog.resize(0);
            LogMessage("[INFO] Reset all combat statistics");
        }
        
        private float CalculateFinalDamage(CBaseEntity@ pTarget, const DamageInfo &in damageInfo)
        {
            float flDamage = damageInfo.flDamage;
            
            // Check for blocking/immunity
            if (CheckDamageBlocking(pTarget, damageInfo))
            {
                flDamage *= 0.5f; // Reduce damage by half if blocked
                
                // Update block statistics for players
                CBasePlayer@ pPlayer = cast<CBasePlayer@>(pTarget);
                if (pPlayer !is null)
                {
                    string szPlayerID = pPlayer.GetSteamID();
                    CombatStats@ pStats = GetPlayerStats(szPlayerID);
                    pStats.nBlockedAttacks++;
                }
            }
            
            // Apply armor reduction
            flDamage = ApplyArmorReduction(pTarget, flDamage, damageInfo);
            
            // Apply resistance/vulnerability
            flDamage = ApplyDamageTypeModifiers(pTarget, flDamage, damageInfo.eDamageType);
            
            // Critical hit multiplier
            if (damageInfo.bIsCritical)
            {
                flDamage *= 2.0f; // Double damage for critical hits
                
                // Update critical hit statistics
                CBaseEntity@ pAttacker = damageInfo.hAttacker.Get();
                CBasePlayer@ pPlayer = cast<CBasePlayer@>(pAttacker);
                if (pPlayer !is null)
                {
                    string szPlayerID = pPlayer.GetSteamID();
                    CombatStats@ pStats = GetPlayerStats(szPlayerID);
                    pStats.nCriticalHits++;
                }
            }
            
            return (flDamage > 0.0f) ? flDamage : 0.0f;
        }
        
        private float CalculateSpellDamage(CBaseEntity@ pCaster, SpellData@ pSpell, float flBaseDamage)
        {
            float flSpellDamage = flBaseDamage;
            
            // Apply spell power modifiers based on caster's skill
            CBasePlayer@ pPlayer = cast<CBasePlayer@>(pCaster);
            if (pPlayer !is null)
            {
                // Note: This would integrate with the actual skill system
                // For now, apply a basic modifier
                float flSkillMultiplier = 1.0f; // Would be based on spell skill level
                flSpellDamage *= flSkillMultiplier;
            }
            
            // Random damage variation
            if (pSpell.flMaxDamage > pSpell.flMinDamage)
            {
                float flRange = pSpell.flMaxDamage - pSpell.flMinDamage;
                float flRandom = Random(0.0f, 1.0f);
                flSpellDamage = pSpell.flMinDamage + (flRange * flRandom);
            }
            
            return flSpellDamage;
        }
        
        private void ApplyDamageToEntity(CBaseEntity@ pTarget, float flDamage, const DamageInfo &in damageInfo)
        {
            if (pTarget is null || flDamage <= 0.0f)
                return;
            
            // Apply the damage to the entity
            // Note: This would call the actual game damage function
            LogMessage("[DEBUG] Applying " + flDamage + " damage to " + pTarget.GetName());
            
            // For now, just log the damage
            // In the actual implementation, this would call pTarget->TakeDamage() or equivalent
        }
        
        private float ApplyArmorReduction(CBaseEntity@ pTarget, float flDamage, const DamageInfo &in damageInfo)
        {
            // Note: This would integrate with the actual armor system
            // For now, just apply basic armor reduction based on damage type
            
            float flArmorReduction = 0.0f;
            
            // Physical damage types get armor reduction
            if (damageInfo.eDamageType == DAMAGE_TYPE_SLASH ||
                damageInfo.eDamageType == DAMAGE_TYPE_PIERCE ||
                damageInfo.eDamageType == DAMAGE_TYPE_BLUNT)
            {
                flArmorReduction = 0.1f; // 10% base armor reduction
            }
            
            // Apply armor penetration
            flArmorReduction *= (1.0f - damageInfo.flArmorPenetration);
            
            return flDamage * (1.0f - flArmorReduction);
        }
        
        private float ApplyDamageTypeModifiers(CBaseEntity@ pTarget, float flDamage, EDamageType eDamageType)
        {
            // Note: This would check for resistances/vulnerabilities
            // For now, return damage as-is
            return flDamage;
        }
        
        private bool CheckMagicResistance(CBaseEntity@ pTarget, EDamageType eDamageType)
        {
            // Note: This would check for spell immunity/resistance
            // For now, no resistance
            return false;
        }
        
        private EDamageType GetDamageTypeFromString(const string &in szDamageType)
        {
            if (szDamageType == "fire")
                return DAMAGE_TYPE_FIRE;
            else if (szDamageType == "cold" || szDamageType == "ice")
                return DAMAGE_TYPE_COLD;
            else if (szDamageType == "lightning")
                return DAMAGE_TYPE_LIGHTNING;
            else if (szDamageType == "poison")
                return DAMAGE_TYPE_POISON;
            else if (szDamageType == "acid")
                return DAMAGE_TYPE_ACID;
            else if (szDamageType == "holy")
                return DAMAGE_TYPE_HOLY;
            else if (szDamageType == "dark")
                return DAMAGE_TYPE_DARK;
            else if (szDamageType == "magic")
                return DAMAGE_TYPE_MAGIC;
            
            return DAMAGE_TYPE_MAGIC; // Default to magic damage
        }
        
        private void UpdateCombatStats(const DamageInfo &in damageInfo, float flFinalDamage)
        {
            // Update attacker stats
            CBaseEntity@ pAttacker = damageInfo.hAttacker.Get();
            CBasePlayer@ pAttackerPlayer = cast<CBasePlayer@>(pAttacker);
            if (pAttackerPlayer !is null)
            {
                string szAttackerID = pAttackerPlayer.GetSteamID();
                CombatStats@ pStats = GetPlayerStats(szAttackerID);
                pStats.flTotalDamageDealt += flFinalDamage;
                pStats.flLastCombatTime = GetGameTime();
            }
        }
        
        private void LogCombatEvent(ECombatEvent eEventType, EntityHandle hSource, EntityHandle hTarget, 
                                   float flValue, const string &in szDescription)
        {
            CombatEvent event;
            event.eEventType = eEventType;
            event.flTimestamp = GetGameTime();
            event.hSource = hSource;
            event.hTarget = hTarget;
            event.flValue = flValue;
            event.szDescription = szDescription;
            
            m_CombatLog.insertLast(event);
            
            // Trim log if it gets too large
            if (m_CombatLog.length() > m_nMaxLogEntries)
            {
                uint nRemoveCount = m_CombatLog.length() - m_nMaxLogEntries;
                for (uint i = 0; i < nRemoveCount; i++)
                {
                    m_CombatLog.removeAt(0);
                }
            }
        }
    }
    
    // Global combat system instance
    CombatSystem@ g_pCombatSystem;
    
    /**
     * Initialize the global combat system
     */
    bool InitializeCombatSystem()
    {
        if (g_pCombatSystem !is null)
        {
            LogMessage("[WARNING] Combat system already initialized");
            return true;
        }
        
        @g_pCombatSystem = CombatSystem();
        return g_pCombatSystem.Initialize();
    }
    
    /**
     * Get the global combat system instance
     */
    CombatSystem@ GetCombatSystem()
    {
        return g_pCombatSystem;
    }
    
    /**
     * Cleanup combat system
     */
    void ShutdownCombatSystem()
    {
        if (g_pCombatSystem !is null)
        {
            LogMessage("[INFO] Shutting down combat system");
            @g_pCombatSystem = null;
        }
    }
    
    /**
     * Helper function to create damage info for spells
     */
    DamageInfo CreateSpellDamageInfo(CBaseEntity@ pCaster, SpellData@ pSpell, float flDamage, const Vector3 &in vecOrigin = Vector3())
    {
        DamageInfo damageInfo;
        damageInfo.flDamage = flDamage;
        damageInfo.eDamageType = GetDamageTypeFromString(pSpell.szDamageType);
        damageInfo.hAttacker = EntityHandle(pCaster);
        damageInfo.szDamageSource = pSpell.szDisplayName;
        damageInfo.bIsSpellDamage = true;
        damageInfo.vecDamageOrigin = (vecOrigin == Vector3()) ? pCaster.GetOrigin() : vecOrigin;
        return damageInfo;
    }
    
    /**
     * Helper function to get damage type from string (exposed for external use)
     */
    EDamageType GetDamageTypeFromString(const string &in szDamageType)
    {
        if (szDamageType == "fire")
            return DAMAGE_TYPE_FIRE;
        else if (szDamageType == "cold" || szDamageType == "ice")
            return DAMAGE_TYPE_COLD;
        else if (szDamageType == "lightning")
            return DAMAGE_TYPE_LIGHTNING;
        else if (szDamageType == "poison")
            return DAMAGE_TYPE_POISON;
        else if (szDamageType == "acid")
            return DAMAGE_TYPE_ACID;
        else if (szDamageType == "holy")
            return DAMAGE_TYPE_HOLY;
        else if (szDamageType == "dark")
            return DAMAGE_TYPE_DARK;
        else if (szDamageType == "magic")
            return DAMAGE_TYPE_MAGIC;
        
        return DAMAGE_TYPE_MAGIC; // Default to magic damage
    }
}

// Stub implementations for missing engine functions
// These provide basic functionality when engine functions are not available

/**
 * Get current game time (stub implementation)
 */
float GetGameTime()
{
    // Return a basic timestamp - in real implementation this would come from the engine
    return 0.0f; // Placeholder - engine should provide actual game time
}

/**
 * Generate random float between min and max (stub implementation)
 */
float Random(float flMin, float flMax)
{
    // Basic random implementation - in real implementation this would use engine's RNG
    // For now, return the midpoint as a placeholder
    return (flMin + flMax) * 0.5f; // Placeholder - engine should provide actual random
}