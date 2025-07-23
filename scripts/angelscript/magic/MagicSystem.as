/**
 * MagicSystem.as
 * 
 * Core magic system for Master Sword Rebirth.
 * Handles spell management, casting mechanics, and magic hand systems.
 * Converted from game_master.script magic hand spell system (lines 4-11).
 */

#include "gamemaster/GameMasterDataStructures.as"
#include "gamemaster/GameMasterUtils.as"
#include "magic/SpellRegistry.as"
#include "combat/CombatSystem.as"

// LogMessage function - provided by engine
void LogMessage(const string &in message);

// Note: Using logging functions provided by the engine
// LogInfo, LogWarning, LogError, LogDebug are defined globally by the C++ engine

namespace MS
{
    /**
     * Core magic system manager
     * Handles spell registration, casting mechanics, and magic interactions
     */
    class MagicSystem
    {
        private SpellRegistry@ m_pSpellRegistry;
        private array<MagicHandCategory> m_MagicHandCategories;
        private bool m_bInitialized = false;
        
        MagicSystem()
        {
            @m_pSpellRegistry = SpellRegistry();
            InitializeMagicHandCategories();
        }
        
        /**
         * Initialize the magic system
         */
        bool Initialize()
        {
            if (m_bInitialized)
            {
                LogWarning("MagicSystem already initialized");
                return true;
            }
            
            LogInfo("Initializing MagicSystem...");
            
            // Initialize spell registry
            if (!m_pSpellRegistry.Initialize())
            {
                LogError("Failed to initialize SpellRegistry");
                return false;
            }
            
            // Register all magic hand spells
            RegisterAllMagicHandSpells();
            
            m_bInitialized = true;
            LogInfo("MagicSystem initialized successfully");
            return true;
        }
        
        /**
         * Get the spell registry
         */
        SpellRegistry@ GetSpellRegistry()
        {
            return m_pSpellRegistry;
        }
        
        /**
         * Cast a spell by name
         */
        bool CastSpell(CBasePlayer@ pPlayer, const string &in szSpellName, const Vector3 &in vecTarget = Vector3())
        {
            if (pPlayer is null)
            {
                LogError("CastSpell: Invalid player");
                return false;
            }
            
            SpellData@ pSpell = m_pSpellRegistry.FindSpellByName(szSpellName);
            if (pSpell is null)
            {
                LogWarning("CastSpell: Unknown spell '" + szSpellName + "'");
                return false;
            }
            
            return ExecuteSpellCast(pPlayer, pSpell, vecTarget);
        }
        
        /**
         * Cast a spell with target entity
         */
        bool CastSpellOnTarget(CBasePlayer@ pPlayer, const string &in szSpellName, CBaseEntity@ pTarget)
        {
            if (pPlayer is null || pTarget is null)
            {
                LogError("CastSpellOnTarget: Invalid player or target");
                return false;
            }
            
            SpellData@ pSpell = m_pSpellRegistry.FindSpellByName(szSpellName);
            if (pSpell is null)
            {
                LogWarning("CastSpellOnTarget: Unknown spell '" + szSpellName + "'");
                return false;
            }
            
            return ExecuteSpellCastOnTarget(pPlayer, pSpell, pTarget);
        }
        
        /**
         * Cast a spell by script name
         */
        bool CastSpellByScript(CBasePlayer@ pPlayer, const string &in szScriptName, const Vector3 &in vecTarget = Vector3())
        {
            if (pPlayer is null)
            {
                LogError("CastSpellByScript: Invalid player");
                return false;
            }
            
            SpellData@ pSpell = m_pSpellRegistry.FindSpellByScript(szScriptName);
            if (pSpell is null)
            {
                LogWarning("CastSpellByScript: Unknown script '" + szScriptName + "'");
                return false;
            }
            
            return ExecuteSpellCast(pPlayer, pSpell, vecTarget);
        }
        
        /**
         * Get all available spells for a player
         */
        array<SpellData@> GetAvailableSpells(CBasePlayer@ pPlayer)
        {
            array<SpellData@> availableSpells;
            
            if (pPlayer is null)
                return availableSpells;
            
            // Get all registered spells
            array<SpellData@> allSpells = m_pSpellRegistry.GetAllSpells();
            
            // Filter by player requirements (skill level, etc.)
            for (uint i = 0; i < allSpells.length(); i++)
            {
                if (CanPlayerCastSpell(pPlayer, allSpells[i]))
                {
                    availableSpells.insertLast(allSpells[i]);
                }
            }
            
            return availableSpells;
        }
        
        /**
         * Get magic hand spells by category
         */
        array<SpellData@> GetMagicHandSpells(uint nCategory)
        {
            array<SpellData@> categorySpells;
            
            if (nCategory >= m_MagicHandCategories.length())
                return categorySpells;
            
            const MagicHandCategory &in category = m_MagicHandCategories[nCategory];
            
            for (uint i = 0; i < category.scripts.length(); i++)
            {
                SpellData@ pSpell = m_pSpellRegistry.FindSpellByScript(category.scripts[i]);
                if (pSpell !is null)
                {
                    categorySpells.insertLast(pSpell);
                }
            }
            
            return categorySpells;
        }
        
        /**
         * Check if player can cast a specific spell
         */
        bool CanPlayerCastSpell(CBasePlayer@ pPlayer, SpellData@ pSpell)
        {
            if (pPlayer is null || pSpell is null)
                return false;
            
            // Check if player has learned the spell
            string szPlayerID = GetPlayerSteamID(pPlayer);
            if (!m_pSpellRegistry.CanPlayerCastSpell(szPlayerID, pSpell.szScriptName, GetGameTime()))
            {
                LogDebug("Player has not learned spell or it's on cooldown: " + pSpell.szDisplayName);
                return false;
            }
            
            // Check skill requirements
            if (pSpell.nRequiredSkillLevel > 0)
            {
                float flPlayerSkill = GetPlayerSkillLevel(pPlayer, "magic");
                if (flPlayerSkill < pSpell.nRequiredSkillLevel)
                {
                    LogDebug("Insufficient skill level for spell: " + pSpell.szDisplayName);
                    return false;
                }
            }
            
            // Check mana requirements
            if (pSpell.nManaCost > 0)
            {
                float flCurrentMana = GetPlayerMana(pPlayer);
                if (flCurrentMana < pSpell.nManaCost)
                {
                    LogDebug("Insufficient mana for spell: " + pSpell.szDisplayName);
                    return false;
                }
            }
            
            // Check energy requirements
            if (pSpell.nEnergyCost > 0)
            {
                float flCurrentEnergy = GetPlayerEnergy(pPlayer);
                if (flCurrentEnergy < pSpell.nEnergyCost)
                {
                    LogDebug("Insufficient energy for spell: " + pSpell.szDisplayName);
                    return false;
                }
            }
            
            return true;
        }
        
        /**
         * Handle spell targeting and effects
         */
        void HandleSpellEffects(CBasePlayer@ pCaster, SpellData@ pSpell, const Vector3 &in vecTarget)
        {
            if (pCaster is null || pSpell is null)
                return;
            
            LogInfo("Handling spell effects for: " + pSpell.szDisplayName);
            
            // Apply spell effects based on type
            switch (pSpell.eSpellType)
            {
                case SPELL_TYPE_PROJECTILE:
                    HandleProjectileSpell(pCaster, pSpell, vecTarget);
                    break;
                    
                case SPELL_TYPE_TARGET:
                    HandleTargetSpell(pCaster, pSpell, vecTarget);
                    break;
                    
                case SPELL_TYPE_AREA:
                    HandleAreaSpell(pCaster, pSpell, vecTarget);
                    break;
                    
                case SPELL_TYPE_SELF:
                    HandleSelfSpell(pCaster, pSpell);
                    break;
                    
                case SPELL_TYPE_SUMMON:
                    HandleSummonSpell(pCaster, pSpell, vecTarget);
                    break;
                    
                default:
                    LogWarning("Unknown spell type for: " + pSpell.szDisplayName);
                    break;
            }
        }
        
        /**
         * Handle spell effects on specific target
         */
        void HandleSpellEffectsOnTarget(CBasePlayer@ pCaster, SpellData@ pSpell, CBaseEntity@ pTarget)
        {
            if (pCaster is null || pSpell is null || pTarget is null)
                return;
            
            LogInfo("Handling spell effects for " + pSpell.szDisplayName + " on target " + pTarget.GetName());
            
            // Calculate base damage
            float flBaseDamage = CalculateSpellBaseDamage(pSpell);
            
            // Apply damage through combat system
            CombatSystem@ pCombatSystem = GetCombatSystem();
            if (pCombatSystem !is null && flBaseDamage > 0.0f)
            {
                float flActualDamage = pCombatSystem.ProcessSpellDamage(pTarget, pCaster, pSpell, flBaseDamage);
                LogInfo("Spell damage dealt: " + flActualDamage);
            }
            
            // Apply non-damage spell effects
            ApplySpellUtilityEffects(pCaster, pSpell, pTarget);
        }
        
        /**
         * Calculate base damage for a spell
         */
        float CalculateSpellBaseDamage(SpellData@ pSpell)
        {
            if (pSpell is null)
                return 0.0f;
            
            if (pSpell.flMaxDamage > pSpell.flMinDamage)
            {
                float flRange = pSpell.flMaxDamage - pSpell.flMinDamage;
                float flRandom = Random(0.0f, 1.0f);
                return pSpell.flMinDamage + (flRange * flRandom);
            }
            
            // If no damage range is specified, return a category-based default
            switch (pSpell.nCategoryID)
            {
                case 1: return Random(5.0f, 15.0f);   // Basic spells
                case 2: return Random(15.0f, 35.0f);  // Advanced spells
                case 3: return Random(35.0f, 65.0f);  // Master spells
            }
            
            return Random(5.0f, 15.0f); // Default
        }
        
        /**
         * Handle Potion of Forgetfulness usage
         * Main entry point for spell forgetting system
         */
        bool HandlePotionOfForgetfulness(CBasePlayer@ pPlayer, const string &in szPotionID = "")
        {
            if (pPlayer is null)
            {
                LogError("HandlePotionOfForgetfulness: Invalid player");
                return false;
            }
            
            if (!m_bInitialized)
            {
                LogError("HandlePotionOfForgetfulness: Magic system not initialized");
                return false;
            }
            
            LogInfo("Player " + pPlayer.GetName() + " used Potion of Forgetfulness");
            
            // Get player's learned spells
            string szPlayerID = GetPlayerSteamID(pPlayer);
            array<string> learnedSpellNames = m_pSpellRegistry.GetPlayerSpellNames(szPlayerID);
            
            if (learnedSpellNames.length() == 0)
            {
                SendPlayerMessage(pPlayer, "You have no spells to forget.");
                ShowInfoMessage(pPlayer, "Potion of Forgetfulness", "You have no spells to forget.");
                return false;
            }
            
            // Create and show the forget menu
            PotionOfForgetfulness@ potionHandler = PotionOfForgetfulness(this, pPlayer, szPotionID);
            
            // Register the handler for tracking
            MS::RegisterPotionHandler(szPlayerID, potionHandler);
            
            return potionHandler.ShowSpellForgetMenu();
        }
        
        private bool ExecuteSpellCast(CBasePlayer@ pPlayer, SpellData@ pSpell, const Vector3 &in vecTarget)
        {
            if (!CanPlayerCastSpell(pPlayer, pSpell))
            {
                LogWarning("Player cannot cast spell: " + pSpell.szDisplayName);
                return false;
            }
            
            // Check and consume resources
            if (!CheckSpellResources(pPlayer, pSpell))
            {
                return false;
            }
            
            LogInfo("Player " + pPlayer.GetName() + " casting: " + pSpell.szDisplayName);
            
            // Trigger spell preparation if needed
            if (pSpell.flPrepareTime > 0.0f)
            {
                StartSpellPreparation(pPlayer, pSpell);
            }
            
            // Consume resources
            ConsumeSpellResources(pPlayer, pSpell);
            
            // Handle spell effects
            HandleSpellEffects(pPlayer, pSpell, vecTarget);
            
            // Set spell cooldown
            string szPlayerID = GetPlayerSteamID(pPlayer);
            m_pSpellRegistry.SetSpellCooldown(szPlayerID, pSpell.szScriptName, GetGameTime());
            
            // Update combat statistics
            CombatSystem@ pCombatSystem = GetCombatSystem();
            if (pCombatSystem !is null)
            {
                pCombatSystem.HandleSpellCast(pPlayer, pSpell);
            }
            
            return true;
        }
        
        /**
         * Execute spell cast on specific target
         */
        private bool ExecuteSpellCastOnTarget(CBasePlayer@ pPlayer, SpellData@ pSpell, CBaseEntity@ pTarget)
        {
            if (!CanPlayerCastSpell(pPlayer, pSpell))
            {
                LogWarning("Player cannot cast spell: " + pSpell.szDisplayName);
                return false;
            }
            
            // Check and consume resources
            if (!CheckSpellResources(pPlayer, pSpell))
            {
                return false;
            }
            
            LogInfo("Player " + pPlayer.GetName() + " casting " + pSpell.szDisplayName + " on " + pTarget.GetName());
            
            // Consume resources
            ConsumeSpellResources(pPlayer, pSpell);
            
            // Handle spell effects on target
            HandleSpellEffectsOnTarget(pPlayer, pSpell, pTarget);
            
            // Set spell cooldown
            string szPlayerID = GetPlayerSteamID(pPlayer);
            m_pSpellRegistry.SetSpellCooldown(szPlayerID, pSpell.szScriptName, GetGameTime());
            
            // Update combat statistics
            CombatSystem@ pCombatSystem = GetCombatSystem();
            if (pCombatSystem !is null)
            {
                pCombatSystem.HandleSpellCast(pPlayer, pSpell);
            }
            
            return true;
        }
        
        private void StartSpellPreparation(CBasePlayer@ pPlayer, SpellData@ pSpell)
        {
            LogDebug("Starting spell preparation: " + pSpell.flPrepareTime + "s");
            
            // Note: This would trigger preparation animations and effects
            // For now, just log the preparation
        }
        
        private void HandleProjectileSpell(CBasePlayer@ pCaster, SpellData@ pSpell, const Vector3 &in vecTarget)
        {
            LogDebug("Handling projectile spell: " + pSpell.szDisplayName);
            
            // Create projectile that will travel to target and deal damage on impact
            CreateSpellProjectile(pCaster, pSpell, vecTarget);
        }
        
        private void HandleTargetSpell(CBasePlayer@ pCaster, SpellData@ pSpell, const Vector3 &in vecTarget)
        {
            LogDebug("Handling target spell: " + pSpell.szDisplayName);
            
            // Find target entity at the specified location
            CBaseEntity@ pTarget = FindEntityAtLocation(vecTarget);
            if (pTarget !is null)
            {
                HandleSpellEffectsOnTarget(pCaster, pSpell, pTarget);
            }
            else
            {
                LogWarning("No target found for target spell: " + pSpell.szDisplayName);
            }
        }
        
        private void HandleAreaSpell(CBasePlayer@ pCaster, SpellData@ pSpell, const Vector3 &in vecTarget)
        {
            LogDebug("Handling area spell: " + pSpell.szDisplayName);
            
            // Find all entities within the spell's area radius
            array<CBaseEntity@> targets = FindEntitiesInRadius(vecTarget, pSpell.flAreaRadius);
            
            for (uint i = 0; i < targets.length(); i++)
            {
                if (targets[i] !is null && ShouldAffectTarget(pCaster, targets[i], pSpell))
                {
                    HandleSpellEffectsOnTarget(pCaster, pSpell, targets[i]);
                }
            }
            
            // Create visual area effect
            CreateAreaSpellEffect(vecTarget, pSpell.flAreaRadius, pSpell.szDamageType);
        }
        
        private void HandleSelfSpell(CBasePlayer@ pCaster, SpellData@ pSpell)
        {
            LogDebug("Handling self spell: " + pSpell.szDisplayName);
            
            // Apply effects to the caster
            HandleSpellEffectsOnTarget(pCaster, pSpell, pCaster);
        }
        
        private void HandleSummonSpell(CBasePlayer@ pCaster, SpellData@ pSpell, const Vector3 &in vecTarget)
        {
            LogDebug("Handling summon spell: " + pSpell.szDisplayName);
            
            // Create summoned creature at target location
            CreateSummonedCreature(pCaster, pSpell, vecTarget);
        }
        
        /**
         * Check spell resource requirements
         */
        private bool CheckSpellResources(CBasePlayer@ pPlayer, SpellData@ pSpell)
        {
            // Check mana
            if (pSpell.nManaCost > 0)
            {
                float flCurrentMana = GetPlayerMana(pPlayer);
                if (flCurrentMana < pSpell.nManaCost)
                {
                    SendPlayerMessage(pPlayer, "Insufficient mana to cast " + pSpell.szDisplayName);
                    return false;
                }
            }
            
            // Check energy
            if (pSpell.nEnergyCost > 0)
            {
                float flCurrentEnergy = GetPlayerEnergy(pPlayer);
                if (flCurrentEnergy < pSpell.nEnergyCost)
                {
                    SendPlayerMessage(pPlayer, "Insufficient energy to cast " + pSpell.szDisplayName);
                    return false;
                }
            }
            
            return true;
        }
        
        /**
         * Consume spell resources
         */
        private void ConsumeSpellResources(CBasePlayer@ pPlayer, SpellData@ pSpell)
        {
            // Consume mana
            if (pSpell.nManaCost > 0)
            {
                float flCurrentMana = GetPlayerMana(pPlayer);
                SetPlayerMana(pPlayer, flCurrentMana - pSpell.nManaCost);
                LogDebug("Consumed " + pSpell.nManaCost + " mana");
            }
            
            // Consume energy
            if (pSpell.nEnergyCost > 0)
            {
                float flCurrentEnergy = GetPlayerEnergy(pPlayer);
                SetPlayerEnergy(pPlayer, flCurrentEnergy - pSpell.nEnergyCost);
                LogDebug("Consumed " + pSpell.nEnergyCost + " energy");
            }
        }
        
        /**
         * Apply non-damage spell effects
         */
        private void ApplySpellUtilityEffects(CBasePlayer@ pCaster, SpellData@ pSpell, CBaseEntity@ pTarget)
        {
            // Apply healing effects
            if (pSpell.szDamageType == "heal" || pSpell.szScriptName.findFirst("heal") != -1)
            {
                float flHealAmount = CalculateSpellBaseDamage(pSpell);
                ApplyHealing(pTarget, flHealAmount);
                LogInfo("Applied " + flHealAmount + " healing to " + pTarget.GetName());
            }
            
            // Apply buff/debuff effects based on spell type
            if (pSpell.szScriptName.findFirst("shield") != -1)
            {
                ApplyShieldEffect(pTarget, pSpell.flDuration);
            }
            else if (pSpell.szScriptName.findFirst("haste") != -1)
            {
                ApplyHasteEffect(pTarget, pSpell.flDuration);
            }
            else if (pSpell.szScriptName.findFirst("slow") != -1)
            {
                ApplySlowEffect(pTarget, pSpell.flDuration);
            }
        }
        
        private void InitializeMagicHandCategories()
        {
            // Category 1: Basic Combat Spells
            MagicHandCategory category1;
            category1.nCategoryID = 1;
            category1.szCategoryName = "Basic Combat Magic";
            category1.scripts = MAGIC_HAND_SCRIPTS1;
            category1.names = MAGIC_HAND_NAMES1;
            m_MagicHandCategories.insertLast(category1);
            
            // Category 2: Advanced Combat Spells
            MagicHandCategory category2;
            category2.nCategoryID = 2;
            category2.szCategoryName = "Advanced Combat Magic";
            category2.scripts = MAGIC_HAND_SCRIPTS2;
            category2.names = MAGIC_HAND_NAMES2;
            m_MagicHandCategories.insertLast(category2);
            
            // Category 3: Master Level Spells
            MagicHandCategory category3;
            category3.nCategoryID = 3;
            category3.szCategoryName = "Master Level Magic";
            category3.scripts = MAGIC_HAND_SCRIPTS3;
            category3.names = MAGIC_HAND_NAMES3;
            m_MagicHandCategories.insertLast(category3);
        }
        
        private void RegisterAllMagicHandSpells()
        {
            LogInfo("Registering magic hand spells...");
            
            uint nTotalRegistered = 0;
            
            // Register all categories
            for (uint cat = 0; cat < m_MagicHandCategories.length(); cat++)
            {
                const MagicHandCategory &in category = m_MagicHandCategories[cat];
                
                for (uint i = 0; i < category.scripts.length(); i++)
                {
                    if (i < category.names.length())
                    {
                        SpellData spell;
                        spell.szScriptName = category.scripts[i];
                        spell.szDisplayName = category.names[i];
                        spell.nCategoryID = category.nCategoryID;
                        spell.eSpellType = DetermineSpellType(category.scripts[i]);
                        spell.nRequiredSkillLevel = DetermineSkillRequirement(category.scripts[i]);
                        spell.nManaCost = DetermineManaCost(category.scripts[i]);
                        spell.nEnergyCost = DetermineEnergyCost(category.scripts[i]);
                        spell.flPrepareTime = DeterminePrepareTime(category.scripts[i]);
                        
                        // Set damage properties
                        DetermineSpellDamage(category.scripts[i], spell);
                        spell.szDamageType = DetermineDamageType(category.scripts[i]);
                        spell.flAreaRadius = DetermineAreaRadius(category.scripts[i]);
                        spell.flDuration = DetermineDuration(category.scripts[i]);
                        spell.flCooldown = DetermineCooldown(category.scripts[i]);
                        
                        if (m_pSpellRegistry.RegisterSpell(spell))
                        {
                            nTotalRegistered++;
                        }
                    }
                }
            }
            
            LogInfo("Registered " + nTotalRegistered + " magic hand spells");
        }
        
        private ESpellType DetermineSpellType(const string &in szScriptName)
        {
            // Determine spell type based on script name patterns
            if (szScriptName.findFirst("summon") != -1)
                return SPELL_TYPE_SUMMON;
            else if (szScriptName.findFirst("bolt") != -1 || 
                     szScriptName.findFirst("dart") != -1 ||
                     szScriptName.findFirst("ball") != -1)
                return SPELL_TYPE_PROJECTILE;
            else if (szScriptName.findFirst("wall") != -1 ||
                     szScriptName.findFirst("circle") != -1 ||
                     szScriptName.findFirst("cloud") != -1 ||
                     szScriptName.findFirst("storm") != -1 ||
                     szScriptName.findFirst("blizzard") != -1 ||
                     szScriptName.findFirst("volcano") != -1)
                return SPELL_TYPE_AREA;
            else if (szScriptName.findFirst("glow") != -1 ||
                     szScriptName.findFirst("rejuvenate") != -1 ||
                     szScriptName.findFirst("shield") != -1)
                return SPELL_TYPE_SELF;
            else if (szScriptName.findFirst("turn") != -1)
                return SPELL_TYPE_TARGET;
                
            return SPELL_TYPE_PROJECTILE; // Default
        }
        
        private uint DetermineSkillRequirement(const string &in szScriptName)
        {
            // Determine skill requirements based on spell power
            if (szScriptName.findFirst("lesser") != -1)
                return 3; // Lower skill requirement
            else if (szScriptName.findFirst("summon") != -1)
                return 8; // High skill for summoning
            else if (szScriptName.findFirst("storm") != -1 ||
                     szScriptName.findFirst("volcano") != -1 ||
                     szScriptName.findFirst("blizzard") != -1)
                return 7; // High skill for powerful spells
            else if (szScriptName.findFirst("wall") != -1 ||
                     szScriptName.findFirst("shield") != -1)
                return 5; // Medium skill for defensive spells
                
            return 4; // Default medium skill requirement
        }
        
        private uint DetermineManaCost(const string &in szScriptName)
        {
            // Determine mana cost based on spell complexity
            if (szScriptName.findFirst("summon") != -1)
                return 15; // High mana for summoning
            else if (szScriptName.findFirst("storm") != -1 ||
                     szScriptName.findFirst("volcano") != -1 ||
                     szScriptName.findFirst("blizzard") != -1)
                return 12; // High mana for powerful spells
            else if (szScriptName.findFirst("wall") != -1 ||
                     szScriptName.findFirst("circle") != -1)
                return 8; // Medium mana for area spells
            else if (szScriptName.findFirst("lesser") != -1 ||
                     szScriptName.findFirst("weak") != -1)
                return 3; // Low mana for weak spells
                
            return 5; // Default mana cost
        }
        
        private uint DetermineEnergyCost(const string &in szScriptName)
        {
            // Energy costs are generally lower than mana costs
            return DetermineManaCost(szScriptName) / 2;
        }
        
        private float DeterminePrepareTime(const string &in szScriptName)
        {
            // Determine preparation time based on spell complexity
            if (szScriptName.findFirst("summon") != -1)
                return 3.0f; // Longer prep for summoning
            else if (szScriptName.findFirst("storm") != -1 ||
                     szScriptName.findFirst("volcano") != -1 ||
                     szScriptName.findFirst("blizzard") != -1)
                return 2.5f; // Longer prep for powerful spells
            else if (szScriptName.findFirst("wall") != -1)
                return 2.0f; // Medium prep for walls
            else if (szScriptName.findFirst("lesser") != -1 ||
                     szScriptName.findFirst("weak") != -1)
                return 1.0f; // Quick prep for weak spells
                
            return 1.5f; // Default preparation time
        }
        
        /**
         * Determine spell damage range
         */
        private void DetermineSpellDamage(const string &in szScriptName, SpellData &inout spell)
        {
            // Set damage based on spell category and name
            if (szScriptName.findFirst("lesser") != -1 || szScriptName.findFirst("weak") != -1)
            {
                spell.flMinDamage = 3.0f;
                spell.flMaxDamage = 8.0f;
            }
            else if (szScriptName.findFirst("summon") != -1)
            {
                spell.flMinDamage = 0.0f; // Summons don't deal direct damage
                spell.flMaxDamage = 0.0f;
            }
            else if (szScriptName.findFirst("storm") != -1 ||
                     szScriptName.findFirst("volcano") != -1 ||
                     szScriptName.findFirst("blizzard") != -1)
            {
                spell.flMinDamage = 25.0f;
                spell.flMaxDamage = 45.0f;
            }
            else if (szScriptName.findFirst("wall") != -1)
            {
                spell.flMinDamage = 15.0f;
                spell.flMaxDamage = 25.0f;
            }
            else if (szScriptName.findFirst("bolt") != -1 || szScriptName.findFirst("dart") != -1)
            {
                spell.flMinDamage = 8.0f;
                spell.flMaxDamage = 18.0f;
            }
            else if (szScriptName.findFirst("ball") != -1)
            {
                spell.flMinDamage = 12.0f;
                spell.flMaxDamage = 22.0f;
            }
            else if (szScriptName.findFirst("heal") != -1)
            {
                spell.flMinDamage = 10.0f; // Healing amount
                spell.flMaxDamage = 25.0f;
            }
            else
            {
                // Default damage for category
                switch (spell.nCategoryID)
                {
                    case 1:
                        spell.flMinDamage = 5.0f;
                        spell.flMaxDamage = 15.0f;
                        break;
                    case 2:
                        spell.flMinDamage = 15.0f;
                        spell.flMaxDamage = 30.0f;
                        break;
                    case 3:
                        spell.flMinDamage = 30.0f;
                        spell.flMaxDamage = 50.0f;
                        break;
                }
            }
        }
        
        /**
         * Determine spell damage type
         */
        private string DetermineDamageType(const string &in szScriptName)
        {
            if (szScriptName.findFirst("fire") != -1 || szScriptName.findFirst("flame") != -1)
                return "fire";
            else if (szScriptName.findFirst("ice") != -1 || szScriptName.findFirst("frost") != -1 || szScriptName.findFirst("cold") != -1)
                return "cold";
            else if (szScriptName.findFirst("lightning") != -1 || szScriptName.findFirst("shock") != -1)
                return "lightning";
            else if (szScriptName.findFirst("poison") != -1 || szScriptName.findFirst("acid") != -1)
                return "poison";
            else if (szScriptName.findFirst("holy") != -1 || szScriptName.findFirst("light") != -1)
                return "holy";
            else if (szScriptName.findFirst("dark") != -1 || szScriptName.findFirst("shadow") != -1)
                return "dark";
            else if (szScriptName.findFirst("heal") != -1)
                return "heal";
            
            return "magic"; // Default to magic damage
        }
        
        /**
         * Determine spell area radius
         */
        private float DetermineAreaRadius(const string &in szScriptName)
        {
            if (szScriptName.findFirst("storm") != -1 || szScriptName.findFirst("blizzard") != -1)
                return 150.0f; // Large area
            else if (szScriptName.findFirst("volcano") != -1 || szScriptName.findFirst("circle") != -1)
                return 100.0f; // Medium area
            else if (szScriptName.findFirst("wall") != -1)
                return 200.0f; // Long wall area
            else if (szScriptName.findFirst("ball") != -1)
                return 50.0f; // Small explosion
                
            return 0.0f; // No area effect
        }
        
        /**
         * Determine spell duration
         */
        private float DetermineDuration(const string &in szScriptName)
        {
            if (szScriptName.findFirst("wall") != -1)
                return 30.0f; // Walls last long
            else if (szScriptName.findFirst("circle") != -1)
                return 20.0f; // Circles last medium time
            else if (szScriptName.findFirst("storm") != -1 || szScriptName.findFirst("blizzard") != -1)
                return 15.0f; // Weather effects last medium time
            else if (szScriptName.findFirst("shield") != -1 || szScriptName.findFirst("glow") != -1)
                return 60.0f; // Buffs last long
            else if (szScriptName.findFirst("summon") != -1)
                return 120.0f; // Summons last very long
                
            return 0.0f; // Instant effect
        }
        
        /**
         * Determine spell cooldown
         */
        private float DetermineCooldown(const string &in szScriptName)
        {
            if (szScriptName.findFirst("summon") != -1)
                return 30.0f; // High cooldown for summons
            else if (szScriptName.findFirst("storm") != -1 ||
                     szScriptName.findFirst("volcano") != -1 ||
                     szScriptName.findFirst("blizzard") != -1)
                return 20.0f; // High cooldown for powerful spells
            else if (szScriptName.findFirst("wall") != -1 || szScriptName.findFirst("circle") != -1)
                return 15.0f; // Medium cooldown for area spells
            else if (szScriptName.findFirst("heal") != -1)
                return 5.0f; // Low cooldown for healing
            else if (szScriptName.findFirst("lesser") != -1 || szScriptName.findFirst("weak") != -1)
                return 2.0f; // Very low cooldown for weak spells
                
            return 8.0f; // Default cooldown
        }
        
        /**
         * Get current game time (for spell system)
         */
        private float GetGameTime()
        {
            // Use the same game time function as combat system
            return ::GetGameTime();
        }
    }
    
    /**
     * Structure for magic hand category data
     */
    class MagicHandCategory
    {
        uint nCategoryID;
        string szCategoryName;
        array<string> scripts;
        array<string> names;
        
        MagicHandCategory()
        {
            nCategoryID = 0;
            szCategoryName = "";
        }
    }
    
    /**
     * Potion of Forgetfulness handler class
     * Implements the spell forgetting menu system from original game_master.script lines 525-667
     */
    class PotionOfForgetfulness
    {
        private MagicSystem@ m_pMagicSystem;
        private CBasePlayer@ m_pPlayer;
        private string m_szPotionID;
        private array<string> m_LearnedSpells;
        private array<string> m_SpellDisplayNames;
        private bool m_bMenuActive;
        private uint m_nSelectedSpellIndex;
        
        PotionOfForgetfulness(MagicSystem@ pMagicSystem, CBasePlayer@ pPlayer, const string &in szPotionID)
        {
            @m_pMagicSystem = pMagicSystem;
            @m_pPlayer = pPlayer;
            m_szPotionID = szPotionID;
            m_bMenuActive = false;
            m_nSelectedSpellIndex = 0;
        }
        
        /**
         * Show the spell forget menu to the player
         * Equivalent to original forget_spell and add_spell_callbacks functions
         */
        bool ShowSpellForgetMenu()
        {
            if (m_pPlayer is null || m_pMagicSystem is null)
            {
                LogError("PotionOfForgetfulness: Invalid player or magic system");
                return false;
            }
            
            // Get player's learned spells
            string szPlayerID = m_pMagicSystem.GetPlayerSteamID(m_pPlayer);
            SpellRegistry@ pRegistry = m_pMagicSystem.GetSpellRegistry();
            
            if (pRegistry is null)
            {
                LogError("PotionOfForgetfulness: Cannot get spell registry");
                return false;
            }
            
            // Get learned spell names for display
            m_SpellDisplayNames = pRegistry.GetPlayerSpellNames(szPlayerID);
            
            if (m_SpellDisplayNames.length() == 0)
            {
                m_pMagicSystem.SendPlayerMessage(m_pPlayer, "You have no spells to forget.");
                m_pMagicSystem.ShowInfoMessage(m_pPlayer, "Potion of Forgetfulness", "You have no spells to forget.");
                return false;
            }
            
            // Show initial message
            m_pMagicSystem.SendPlayerMessage(m_pPlayer, "Please select a spell you would like to erase from memory.");
            m_pMagicSystem.ShowInfoMessage(m_pPlayer, "Potion of Forgetfulness", "Please select a spell you would like to erase from memory.");
            
            // Show the menu
            m_bMenuActive = true;
            return ShowSpellSelectionMenu();
        }
        
        /**
         * Show the spell selection menu
         * Equivalent to original send_menu and menu system
         */
        bool ShowSpellSelectionMenu()
        {
            if (m_SpellDisplayNames.length() == 0)
                return false;
            
            LogInfo("Showing spell forget menu to " + m_pPlayer.GetName() + " with " + m_SpellDisplayNames.length() + " spells");
            
            // For now, we'll simulate a menu by showing the available spells
            string menuText = "Available spells to forget:\n";
            for (uint i = 0; i < m_SpellDisplayNames.length(); i++)
            {
                menuText += formatUint(i + 1) + ". " + m_SpellDisplayNames[i] + "\n";
            }
            menuText += "\nUse 'ms_forget_spell <number>' to select a spell.";
            
            m_pMagicSystem.SendPlayerMessage(m_pPlayer, menuText);
            
            // In a real implementation, this would create interactive menu items
            // For now, we'll log the menu creation
            LogInfo("Created forget menu for " + m_pPlayer.GetName() + " with " + m_SpellDisplayNames.length() + " options");
            
            return true;
        }
        
        /**
         * Handle spell selection from menu
         * Equivalent to original confirm_forget_spell function
         */
        bool OnSpellSelected(uint nSpellIndex)
        {
            if (!m_bMenuActive)
            {
                LogWarning("PotionOfForgetfulness: Menu not active for player " + m_pPlayer.GetName());
                return false;
            }
            
            if (nSpellIndex >= m_SpellDisplayNames.length())
            {
                LogError("PotionOfForgetfulness: Invalid spell index " + nSpellIndex);
                m_pMagicSystem.SendPlayerMessage(m_pPlayer, "Invalid spell selection.");
                return false;
            }
            
            m_nSelectedSpellIndex = nSpellIndex;
            
            // Show confirmation dialog
            string spellName = m_SpellDisplayNames[nSpellIndex];
            string confirmMsg = "Are you sure you want to forget " + spellName + "?";
            
            m_pMagicSystem.ShowInfoMessage(m_pPlayer, "Potion of Forgetfulness", confirmMsg);
            m_pMagicSystem.SendPlayerMessage(m_pPlayer, confirmMsg + " Type 'ms_confirm_forget' to confirm.");
            
            LogInfo("Player " + m_pPlayer.GetName() + " selected spell for forgetting: " + spellName);
            return true;
        }
        
        /**
         * Confirm and execute spell forgetting
         * Equivalent to original erase_spell function
         */
        bool ConfirmAndForgetSpell()
        {
            if (!m_bMenuActive)
            {
                LogWarning("PotionOfForgetfulness: Menu not active for confirmation");
                return false;
            }
            
            if (m_nSelectedSpellIndex >= m_SpellDisplayNames.length())
            {
                LogError("PotionOfForgetfulness: Invalid spell index for confirmation");
                return false;
            }
            
            // Get the spell to forget
            string szPlayerID = m_pMagicSystem.GetPlayerSteamID(m_pPlayer);
            SpellRegistry@ pRegistry = m_pMagicSystem.GetSpellRegistry();
            
            if (pRegistry is null)
            {
                LogError("PotionOfForgetfulness: Cannot get spell registry for forgetting");
                return false;
            }
            
            // Forget the spell
            bool bSuccess = pRegistry.PlayerForgetSpell(szPlayerID, m_nSelectedSpellIndex);
            
            if (bSuccess)
            {
                string spellName = m_SpellDisplayNames[m_nSelectedSpellIndex];
                string successMsg = "You have forgotten the spell " + spellName + ".";
                
                m_pMagicSystem.SendPlayerMessage(m_pPlayer, successMsg);
                m_pMagicSystem.ShowInfoMessage(m_pPlayer, "Potion of Forgetfulness", successMsg);
                
                LogInfo("Player " + m_pPlayer.GetName() + " successfully forgot spell: " + spellName);
                
                // Screen fade effect (simulated)
                LogInfo("Applying screen fade effect to " + m_pPlayer.GetName());
            }
            else
            {
                string errorMsg = "Failed to forget the selected spell.";
                m_pMagicSystem.SendPlayerMessage(m_pPlayer, errorMsg);
                m_pMagicSystem.ShowInfoMessage(m_pPlayer, "Potion of Forgetfulness", errorMsg);
                
                LogError("Failed to forget spell for player " + m_pPlayer.GetName());
            }
            
            // Clear menu state
            ClearMenuState();
            
            return bSuccess;
        }
        
        /**
         * Cancel the spell forgetting process
         * Equivalent to original game_menu_cancel function
         */
        void CancelForget()
        {
            if (m_bMenuActive)
            {
                m_pMagicSystem.SendPlayerMessage(m_pPlayer, "Spell forgetting cancelled.");
                LogInfo("Player " + m_pPlayer.GetName() + " cancelled spell forgetting");
                
                // Screen fade effect (simulated)
                LogInfo("Applying cancellation fade effect to " + m_pPlayer.GetName());
                
                ClearMenuState();
            }
        }
        
        /**
         * Get if menu is currently active
         */
        bool IsMenuActive() const
        {
            return m_bMenuActive;
        }
        
        /**
         * Get the player associated with this potion handler
         */
        CBasePlayer@ GetPlayer()
        {
            return m_pPlayer;
        }
        
        private void ClearMenuState()
        {
            m_bMenuActive = false;
            m_nSelectedSpellIndex = 0;
            m_LearnedSpells.resize(0);
            m_SpellDisplayNames.resize(0);
        }
    }
    
    // Global magic system instance
    MagicSystem@ g_pMagicSystem;
    
    // Global tracking for active potion handlers
    dictionary g_ActivePotionHandlers; // player ID -> PotionOfForgetfulness@
    
    /**
     * Initialize the global magic system
     */
    bool InitializeMagicSystem()
    {
        if (g_pMagicSystem !is null)
        {
            LogWarning("Magic system already initialized");
            return true;
        }
        
        @g_pMagicSystem = MagicSystem();
        bool bResult = g_pMagicSystem.Initialize();
        
        if (bResult)
        {
            // Clear any existing potion handlers
            g_ActivePotionHandlers.deleteAll();
            LogInfo("Potion of Forgetfulness system initialized");
        }
        
        return bResult;
    }
    
    /**
     * Get the global magic system instance
     */
    MagicSystem@ GetMagicSystem()
    {
        return g_pMagicSystem;
    }
    
    /**
     * Cleanup magic system
     */
    void ShutdownMagicSystem()
    {
        if (g_pMagicSystem !is null)
        {
            LogInfo("Shutting down magic system");
            
            // Clear all active potion handlers
            g_ActivePotionHandlers.deleteAll();
            
            @g_pMagicSystem = null;
        }
    }
    
    /**
     * Handle Potion of Forgetfulness usage (global entry point)
     * This function should be called by the item system when a player uses the potion
     */
    bool UsePotionOfForgetfulness(CBasePlayer@ pPlayer, const string &in szPotionID = "")
    {
        if (g_pMagicSystem is null)
        {
            LogError("Magic system not initialized for potion usage");
            return false;
        }
        
        return g_pMagicSystem.HandlePotionOfForgetfulness(pPlayer, szPotionID);
    }
    
    /**
     * Handle spell forget selection command
     * This should be called by console command handlers (e.g., "ms_forget_spell 3")
     */
    bool HandleForgetSpellCommand(CBasePlayer@ pPlayer, uint nSpellIndex)
    {
        if (pPlayer is null)
        {
            LogError("Invalid player for forget spell command");
            return false;
        }
        
        string szPlayerID = (g_pMagicSystem !is null) ? g_pMagicSystem.GetPlayerSteamID(pPlayer) : "";
        if (szPlayerID.isEmpty())
        {
            LogError("Cannot get player ID for forget spell command");
            return false;
        }
        
        // Find active potion handler for this player
        PotionOfForgetfulness@ pHandler;
        if (g_ActivePotionHandlers.get(szPlayerID, @pHandler))
        {
            if (pHandler !is null && pHandler.IsMenuActive())
            {
                // Convert 1-based index to 0-based
                return pHandler.OnSpellSelected(nSpellIndex - 1);
            }
        }
        
        LogWarning("No active spell forget menu for player " + pPlayer.GetName());
        return false;
    }
    
    /**
     * Handle spell forget confirmation command
     * This should be called by console command handlers (e.g., "ms_confirm_forget")
     */
    bool HandleConfirmForgetCommand(CBasePlayer@ pPlayer)
    {
        if (pPlayer is null)
        {
            LogError("Invalid player for confirm forget command");
            return false;
        }
        
        string szPlayerID = (g_pMagicSystem !is null) ? g_pMagicSystem.GetPlayerSteamID(pPlayer) : "";
        if (szPlayerID.isEmpty())
        {
            LogError("Cannot get player ID for confirm forget command");
            return false;
        }
        
        // Find active potion handler for this player
        PotionOfForgetfulness@ pHandler;
        if (g_ActivePotionHandlers.get(szPlayerID, @pHandler))
        {
            if (pHandler !is null && pHandler.IsMenuActive())
            {
                bool bResult = pHandler.ConfirmAndForgetSpell();
                
                // Remove handler after completion
                if (bResult || !pHandler.IsMenuActive())
                {
                    g_ActivePotionHandlers.delete(szPlayerID);
                }
                
                return bResult;
            }
        }
        
        LogWarning("No active spell forget confirmation for player " + pPlayer.GetName());
        return false;
    }
    
    /**
     * Cancel spell forget process for a player
     * This should be called by console command handlers (e.g., "ms_cancel_forget")
     */
    bool HandleCancelForgetCommand(CBasePlayer@ pPlayer)
    {
        if (pPlayer is null)
        {
            LogError("Invalid player for cancel forget command");
            return false;
        }
        
        string szPlayerID = (g_pMagicSystem !is null) ? g_pMagicSystem.GetPlayerSteamID(pPlayer) : "";
        if (szPlayerID.isEmpty())
        {
            LogError("Cannot get player ID for cancel forget command");
            return false;
        }
        
        // Find active potion handler for this player
        PotionOfForgetfulness@ pHandler;
        if (g_ActivePotionHandlers.get(szPlayerID, @pHandler))
        {
            if (pHandler !is null)
            {
                pHandler.CancelForget();
                g_ActivePotionHandlers.delete(szPlayerID);
                return true;
            }
        }
        
        LogWarning("No active spell forget process for player " + pPlayer.GetName());
        return false;
    }
    
    /**
     * Get active potion handler for a player (internal use)
     */
    PotionOfForgetfulness@ GetActivePotionHandler(const string &in szPlayerID)
    {
        PotionOfForgetfulness@ pHandler;
        if (g_ActivePotionHandlers.get(szPlayerID, @pHandler))
        {
            return pHandler;
        }
        return null;
    }
    
    /**
     * Register active potion handler for a player (internal use)
     */
    void RegisterPotionHandler(const string &in szPlayerID, PotionOfForgetfulness@ pHandler)
    {
        if (pHandler !is null)
        {
            g_ActivePotionHandlers.set(szPlayerID, @pHandler);
        }
    }
    
    /**
     * Clean up potion handler for a player when they disconnect
     */
    void CleanupPlayerPotionHandler(const string &in szPlayerID)
    {
        if (g_ActivePotionHandlers.exists(szPlayerID))
        {
            g_ActivePotionHandlers.delete(szPlayerID);
            LogDebug("Cleaned up potion handler for player: " + szPlayerID);
        }
    }
}

// Additional stub implementations for enhanced magic system

/**
 * Find entity at specific location (stub implementation)
 */
CBaseEntity@ FindEntityAtLocation(const Vector3 &in location)
{
    // Placeholder - would use engine's entity finding functions
    LogMessage("[DEBUG] Finding entity at location: " + location.x + ", " + location.y + ", " + location.z);
    return null; // Would return actual entity
}

/**
 * Find entities within radius (stub implementation)
 */
array<CBaseEntity@> FindEntitiesInRadius(const Vector3 &in center, float radius)
{
    array<CBaseEntity@> entities;
    // Placeholder - would use engine's area search functions
    LogMessage("[DEBUG] Finding entities within " + radius + " units of " + center.x + ", " + center.y + ", " + center.z);
    return entities; // Would return actual entities in range
}

/**
 * Check if spell should affect target (stub implementation)
 */
bool ShouldAffectTarget(CBasePlayer@ pCaster, CBaseEntity@ pTarget, SpellData@ pSpell)
{
    if (pCaster is null || pTarget is null || pSpell is null)
        return false;
    
    // Don't affect the caster unless it's a self-spell
    if (pTarget is pCaster && pSpell.eSpellType != SPELL_TYPE_SELF)
    {
        // Allow beneficial spells on self
        if (pSpell.szDamageType == "heal" || pSpell.szScriptName.findFirst("heal") != -1)
            return true;
        if (pSpell.szScriptName.findFirst("shield") != -1 || pSpell.szScriptName.findFirst("haste") != -1)
            return true;
        return false;
    }
    
    // Check team/faction restrictions here
    // For now, affect all non-caster targets
    return true;
}

/**
 * Create spell projectile (stub implementation)
 */
void CreateSpellProjectile(CBasePlayer@ pCaster, SpellData@ pSpell, const Vector3 &in target)
{
    LogMessage("[DEBUG] Creating projectile for " + pSpell.szDisplayName + " towards " + target.x + ", " + target.y + ", " + target.z);
    // Placeholder - would create actual projectile entity
}

/**
 * Create area spell effect (stub implementation)
 */
void CreateAreaSpellEffect(const Vector3 &in center, float radius, const string &in damageType)
{
    LogMessage("[DEBUG] Creating area effect (" + damageType + ") at " + center.x + ", " + center.y + ", " + center.z + " with radius " + radius);
    // Placeholder - would create visual effects
}

/**
 * Create summoned creature (stub implementation)
 */
void CreateSummonedCreature(CBasePlayer@ pCaster, SpellData@ pSpell, const Vector3 &in location)
{
    LogMessage("[DEBUG] Summoning creature from " + pSpell.szDisplayName + " at " + location.x + ", " + location.y + ", " + location.z);
    // Placeholder - would spawn actual creature entity
}

/**
 * Apply healing to entity (stub implementation)
 */
void ApplyHealing(CBaseEntity@ pTarget, float healAmount)
{
    if (pTarget is null)
        return;
    
    LogMessage("[DEBUG] Applying " + healAmount + " healing to " + pTarget.GetName());
    // Placeholder - would increase entity health
}

/**
 * Apply shield effect (stub implementation)
 */
void ApplyShieldEffect(CBaseEntity@ pTarget, float duration)
{
    if (pTarget is null)
        return;
    
    LogMessage("[DEBUG] Applying shield effect to " + pTarget.GetName() + " for " + duration + " seconds");
    // Placeholder - would apply damage absorption effect
}

/**
 * Apply haste effect (stub implementation)
 */
void ApplyHasteEffect(CBaseEntity@ pTarget, float duration)
{
    if (pTarget is null)
        return;
    
    LogMessage("[DEBUG] Applying haste effect to " + pTarget.GetName() + " for " + duration + " seconds");
    // Placeholder - would increase movement/attack speed
}

/**
 * Apply slow effect (stub implementation)
 */
void ApplySlowEffect(CBaseEntity@ pTarget, float duration)
{
    if (pTarget is null)
        return;
    
    LogMessage("[DEBUG] Applying slow effect to " + pTarget.GetName() + " for " + duration + " seconds");
    // Placeholder - would decrease movement/attack speed
}