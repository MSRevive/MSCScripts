/**
 * SpellRegistry.as
 * 
 * Spell registration and management system for Master Sword Rebirth.
 * Handles spell data, registration, lookup, and management operations.
 * Supports the magic hand spell system and potion of forgetfulness mechanics.
 */

#include "GameMasterUtils.as"

namespace MS
{
    /**
     * Spell types for different casting mechanics
     */
    enum ESpellType
    {
        SPELL_TYPE_PROJECTILE = 0,  // Projectiles (bolts, darts, balls)
        SPELL_TYPE_TARGET,          // Direct target spells
        SPELL_TYPE_AREA,            // Area of effect spells
        SPELL_TYPE_SELF,            // Self-cast spells (buffs, shields)
        SPELL_TYPE_SUMMON           // Summoning spells
    }
    
    /**
     * Spell data structure
     * Contains all information needed to cast and manage a spell
     */
    class SpellData
    {
        string szScriptName;        // Script file name (e.g., "magic_hand_fire_ball")
        string szDisplayName;       // Display name (e.g., "Fire Ball")
        string szDescription;       // Spell description
        ESpellType eSpellType;      // Type of spell casting
        uint nCategoryID;           // Magic hand category (1, 2, or 3)
        uint nRequiredSkillLevel;   // Minimum skill level required
        uint nManaCost;             // Mana cost to cast
        uint nEnergyCost;           // Energy cost to cast
        float flPrepareTime;        // Preparation time in seconds
        float flCooldown;           // Cooldown between casts
        float flRange;              // Maximum casting range
        bool bIsLearned;            // Whether spell is learned by default
        
        // Damage/effect properties
        float flMinDamage;          // Minimum damage
        float flMaxDamage;          // Maximum damage
        string szDamageType;        // Type of damage (fire, cold, lightning, etc.)
        float flAreaRadius;         // Area of effect radius
        float flDuration;           // Effect duration
        
        SpellData()
        {
            szScriptName = "";
            szDisplayName = "";
            szDescription = "";
            eSpellType = SPELL_TYPE_PROJECTILE;
            nCategoryID = 1;
            nRequiredSkillLevel = 1;
            nManaCost = 5;
            nEnergyCost = 2;
            flPrepareTime = 1.5f;
            flCooldown = 0.0f;
            flRange = 1024.0f;
            bIsLearned = false;
            flMinDamage = 0.0f;
            flMaxDamage = 0.0f;
            szDamageType = "";
            flAreaRadius = 0.0f;
            flDuration = 0.0f;
        }
        
        /**
         * Create a copy of this spell data
         */
        SpellData@ Clone()
        {
            SpellData@ copy = SpellData();
            copy.szScriptName = szScriptName;
            copy.szDisplayName = szDisplayName;
            copy.szDescription = szDescription;
            copy.eSpellType = eSpellType;
            copy.nCategoryID = nCategoryID;
            copy.nRequiredSkillLevel = nRequiredSkillLevel;
            copy.nManaCost = nManaCost;
            copy.nEnergyCost = nEnergyCost;
            copy.flPrepareTime = flPrepareTime;
            copy.flCooldown = flCooldown;
            copy.flRange = flRange;
            copy.bIsLearned = bIsLearned;
            copy.flMinDamage = flMinDamage;
            copy.flMaxDamage = flMaxDamage;
            copy.szDamageType = szDamageType;
            copy.flAreaRadius = flAreaRadius;
            copy.flDuration = flDuration;
            return copy;
        }
    }
    
    /**
     * Player spell data for tracking learned spells and spell slot management
     * Implements the potion of forgetfulness mechanics
     */
    class PlayerSpellData
    {
        string szPlayerID;                  // Player identifier (Steam ID)
        array<string> learnedSpells;        // List of learned spell script names
        array<float> spellCooldowns;        // Cooldown timers for each spell slot
        array<float> lastCastTimes;         // Last cast times for cooldown tracking
        uint nMaxSpellSlots;                // Maximum number of spell slots
        
        PlayerSpellData()
        {
            szPlayerID = "";
            nMaxSpellSlots = 7; // Default max spell slots
        }
        
        /**
         * Learn a new spell
         */
        bool LearnSpell(const string &in szSpellScript)
        {
            if (HasSpell(szSpellScript))
                return false; // Already learned
                
            if (learnedSpells.length() >= nMaxSpellSlots)
                return false; // No more spell slots
                
            learnedSpells.insertLast(szSpellScript);
            spellCooldowns.insertLast(0.0f);
            lastCastTimes.insertLast(0.0f);
            return true;
        }
        
        /**
         * Forget a spell (potion of forgetfulness)
         */
        bool ForgetSpell(uint nSpellIndex)
        {
            if (nSpellIndex >= learnedSpells.length())
                return false;
                
            learnedSpells.removeAt(nSpellIndex);
            spellCooldowns.removeAt(nSpellIndex);
            lastCastTimes.removeAt(nSpellIndex);
            return true;
        }
        
        /**
         * Forget a spell by script name
         */
        bool ForgetSpellByScript(const string &in szSpellScript)
        {
            for (uint i = 0; i < learnedSpells.length(); i++)
            {
                if (learnedSpells[i] == szSpellScript)
                {
                    return ForgetSpell(i);
                }
            }
            return false;
        }
        
        /**
         * Check if player has learned a spell
         */
        bool HasSpell(const string &in szSpellScript)
        {
            return learnedSpells.find(szSpellScript) != -1;
        }
        
        /**
         * Get spell index by script name
         */
        int GetSpellIndex(const string &in szSpellScript)
        {
            return learnedSpells.find(szSpellScript);
        }
        
        /**
         * Check if spell is on cooldown
         */
        bool IsSpellOnCooldown(uint nSpellIndex, float flCurrentTime)
        {
            if (nSpellIndex >= lastCastTimes.length())
                return false;
                
            if (nSpellIndex >= spellCooldowns.length())
                return false;
                
            return (flCurrentTime - lastCastTimes[nSpellIndex]) < spellCooldowns[nSpellIndex];
        }
        
        /**
         * Set spell cooldown
         */
        void SetSpellCooldown(uint nSpellIndex, float flCooldown, float flCurrentTime)
        {
            if (nSpellIndex >= spellCooldowns.length())
                return;
                
            if (nSpellIndex >= lastCastTimes.length())
                return;
                
            spellCooldowns[nSpellIndex] = flCooldown;
            lastCastTimes[nSpellIndex] = flCurrentTime;
        }
        
        /**
         * Get remaining cooldown time
         */
        float GetRemainingCooldown(uint nSpellIndex, float flCurrentTime)
        {
            if (nSpellIndex >= lastCastTimes.length() || nSpellIndex >= spellCooldowns.length())
                return 0.0f;
                
            float flElapsed = flCurrentTime - lastCastTimes[nSpellIndex];
            float flRemaining = spellCooldowns[nSpellIndex] - flElapsed;
            return (flRemaining > 0.0f) ? flRemaining : 0.0f;
        }
    }
    
    /**
     * Central spell registry and management system
     */
    class SpellRegistry
    {
        private array<SpellData@> m_RegisteredSpells;
        private dictionary m_SpellsByScript;    // script name -> SpellData@
        private dictionary m_SpellsByName;      // display name -> SpellData@
        private dictionary m_PlayerSpellData;   // player ID -> PlayerSpellData@
        private bool m_bInitialized = false;
        
        SpellRegistry()
        {
        }
        
        /**
         * Initialize the spell registry
         */
        bool Initialize()
        {
            if (m_bInitialized)
            {
                LogWarning("SpellRegistry already initialized");
                return true;
            }
            
            LogInfo("Initializing SpellRegistry...");
            
            m_RegisteredSpells.resize(0);
            m_SpellsByScript.deleteAll();
            m_SpellsByName.deleteAll();
            m_PlayerSpellData.deleteAll();
            
            m_bInitialized = true;
            LogInfo("SpellRegistry initialized successfully");
            return true;
        }
        
        /**
         * Register a new spell
         */
        bool RegisterSpell(const SpellData &in spellData)
        {
            if (!m_bInitialized)
            {
                LogError("SpellRegistry not initialized");
                return false;
            }
            
            if (spellData.szScriptName.isEmpty())
            {
                LogError("Cannot register spell with empty script name");
                return false;
            }
            
            // Check if already registered
            if (m_SpellsByScript.exists(spellData.szScriptName))
            {
                LogWarning("Spell already registered: " + spellData.szScriptName);
                return false;
            }
            
            // Create a copy of the spell data
            SpellData@ pSpell = spellData.Clone();
            
            // Add to registry
            m_RegisteredSpells.insertLast(pSpell);
            m_SpellsByScript.set(pSpell.szScriptName, @pSpell);
            
            if (!pSpell.szDisplayName.isEmpty())
            {
                m_SpellsByName.set(pSpell.szDisplayName, @pSpell);
            }
            
            LogDebug("Registered spell: " + pSpell.szDisplayName + " (" + pSpell.szScriptName + ")");
            return true;
        }
        
        /**
         * Find spell by script name
         */
        SpellData@ FindSpellByScript(const string &in szScriptName)
        {
            SpellData@ pSpell;
            if (m_SpellsByScript.get(szScriptName, @pSpell))
            {
                return pSpell;
            }
            return null;
        }
        
        /**
         * Find spell by display name
         */
        SpellData@ FindSpellByName(const string &in szDisplayName)
        {
            SpellData@ pSpell;
            if (m_SpellsByName.get(szDisplayName, @pSpell))
            {
                return pSpell;
            }
            return null;
        }
        
        /**
         * Get all registered spells
         */
        array<SpellData@> GetAllSpells()
        {
            return m_RegisteredSpells;
        }
        
        /**
         * Get spells by category
         */
        array<SpellData@> GetSpellsByCategory(uint nCategoryID)
        {
            array<SpellData@> categorySpells;
            
            for (uint i = 0; i < m_RegisteredSpells.length(); i++)
            {
                if (m_RegisteredSpells[i].nCategoryID == nCategoryID)
                {
                    categorySpells.insertLast(m_RegisteredSpells[i]);
                }
            }
            
            return categorySpells;
        }
        
        /**
         * Get number of registered spells
         */
        uint GetSpellCount()
        {
            return m_RegisteredSpells.length();
        }
        
        /**
         * Get player spell data (creates if doesn't exist)
         */
        PlayerSpellData@ GetPlayerSpellData(const string &in szPlayerID)
        {
            PlayerSpellData@ pPlayerData;
            
            if (m_PlayerSpellData.get(szPlayerID, @pPlayerData))
            {
                return pPlayerData;
            }
            
            // Create new player data
            @pPlayerData = PlayerSpellData();
            pPlayerData.szPlayerID = szPlayerID;
            m_PlayerSpellData.set(szPlayerID, @pPlayerData);
            
            LogDebug("Created spell data for player: " + szPlayerID);
            return pPlayerData;
        }
        
        /**
         * Player learns a spell
         */
        bool PlayerLearnSpell(const string &in szPlayerID, const string &in szSpellScript)
        {
            PlayerSpellData@ pPlayerData = GetPlayerSpellData(szPlayerID);
            if (pPlayerData is null)
            {
                LogError("Failed to get player spell data");
                return false;
            }
            
            SpellData@ pSpell = FindSpellByScript(szSpellScript);
            if (pSpell is null)
            {
                LogError("Unknown spell script: " + szSpellScript);
                return false;
            }
            
            if (pPlayerData.LearnSpell(szSpellScript))
            {
                LogInfo("Player " + szPlayerID + " learned spell: " + pSpell.szDisplayName);
                return true;
            }
            
            LogWarning("Player " + szPlayerID + " failed to learn spell: " + pSpell.szDisplayName);
            return false;
        }
        
        /**
         * Player forgets a spell (potion of forgetfulness implementation)
         */
        bool PlayerForgetSpell(const string &in szPlayerID, uint nSpellIndex)
        {
            PlayerSpellData@ pPlayerData = GetPlayerSpellData(szPlayerID);
            if (pPlayerData is null)
            {
                LogError("Failed to get player spell data");
                return false;
            }
            
            if (nSpellIndex >= pPlayerData.learnedSpells.length())
            {
                LogError("Invalid spell index: " + nSpellIndex);
                return false;
            }
            
            string szSpellScript = pPlayerData.learnedSpells[nSpellIndex];
            SpellData@ pSpell = FindSpellByScript(szSpellScript);
            string szSpellName = (pSpell !is null) ? pSpell.szDisplayName : szSpellScript;
            
            if (pPlayerData.ForgetSpell(nSpellIndex))
            {
                LogInfo("Player " + szPlayerID + " forgot spell: " + szSpellName);
                return true;
            }
            
            LogError("Failed to forget spell for player: " + szPlayerID);
            return false;
        }
        
        /**
         * Get player's learned spells
         */
        array<SpellData@> GetPlayerSpells(const string &in szPlayerID)
        {
            array<SpellData@> playerSpells;
            
            PlayerSpellData@ pPlayerData = GetPlayerSpellData(szPlayerID);
            if (pPlayerData is null)
                return playerSpells;
            
            for (uint i = 0; i < pPlayerData.learnedSpells.length(); i++)
            {
                SpellData@ pSpell = FindSpellByScript(pPlayerData.learnedSpells[i]);
                if (pSpell !is null)
                {
                    playerSpells.insertLast(pSpell);
                }
            }
            
            return playerSpells;
        }
        
        /**
         * Get player's learned spell scripts with display names (for potion of forgetfulness menu)
         */
        array<string> GetPlayerSpellNames(const string &in szPlayerID)
        {
            array<string> spellNames;
            
            PlayerSpellData@ pPlayerData = GetPlayerSpellData(szPlayerID);
            if (pPlayerData is null)
                return spellNames;
            
            for (uint i = 0; i < pPlayerData.learnedSpells.length(); i++)
            {
                SpellData@ pSpell = FindSpellByScript(pPlayerData.learnedSpells[i]);
                if (pSpell !is null)
                {
                    spellNames.insertLast(pSpell.szDisplayName);
                }
                else
                {
                    // Fallback to script name if spell data not found
                    spellNames.insertLast(pPlayerData.learnedSpells[i]);
                }
            }
            
            return spellNames;
        }
        
        /**
         * Check if player can cast a spell (not on cooldown)
         */
        bool CanPlayerCastSpell(const string &in szPlayerID, const string &in szSpellScript, float flCurrentTime)
        {
            PlayerSpellData@ pPlayerData = GetPlayerSpellData(szPlayerID);
            if (pPlayerData is null)
                return false;
            
            int nSpellIndex = pPlayerData.GetSpellIndex(szSpellScript);
            if (nSpellIndex == -1)
                return false; // Spell not learned
            
            return !pPlayerData.IsSpellOnCooldown(uint(nSpellIndex), flCurrentTime);
        }
        
        /**
         * Set spell on cooldown after casting
         */
        void SetSpellCooldown(const string &in szPlayerID, const string &in szSpellScript, float flCurrentTime)
        {
            PlayerSpellData@ pPlayerData = GetPlayerSpellData(szPlayerID);
            if (pPlayerData is null)
                return;
            
            SpellData@ pSpell = FindSpellByScript(szSpellScript);
            if (pSpell is null)
                return;
            
            int nSpellIndex = pPlayerData.GetSpellIndex(szSpellScript);
            if (nSpellIndex == -1)
                return;
            
            pPlayerData.SetSpellCooldown(uint(nSpellIndex), pSpell.flCooldown, flCurrentTime);
        }
        
        /**
         * Clear all player data (for cleanup)
         */
        void ClearPlayerData(const string &in szPlayerID)
        {
            if (m_PlayerSpellData.exists(szPlayerID))
            {
                m_PlayerSpellData.delete(szPlayerID);
                LogDebug("Cleared spell data for player: " + szPlayerID);
            }
        }
        
        /**
         * Get registry statistics
         */
        void PrintRegistryStats()
        {
            LogInfo("Spell Registry Statistics:");
            LogInfo("  Total spells: " + m_RegisteredSpells.length());
            LogInfo("  Active players: " + m_PlayerSpellData.getSize());
            
            // Count spells by category
            array<uint> categoryCounts(4, 0); // Categories 0-3
            for (uint i = 0; i < m_RegisteredSpells.length(); i++)
            {
                uint cat = m_RegisteredSpells[i].nCategoryID;
                if (cat < categoryCounts.length())
                {
                    categoryCounts[cat]++;
                }
            }
            
            for (uint i = 0; i < categoryCounts.length(); i++)
            {
                if (categoryCounts[i] > 0)
                {
                    LogInfo("  Category " + i + ": " + categoryCounts[i] + " spells");
                }
            }
        }
    }
}