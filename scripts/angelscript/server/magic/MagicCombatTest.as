#pragma context server

/**
 * MagicCombatTest.as
 * 
 * Test script demonstrating the Magic & Combat Systems integration.
 * Shows how the converted magic hand spell system and potion of forgetfulness work.
 */

#include "server/gamemaster/GameMasterUtils.as"
#include "server/magic/MagicSystem.as"
#include "server/combat/CombatSystem.as"

namespace MS
{
    /**
     * Test class for Magic & Combat Systems
     */
    class MagicCombatTest
    {
        /**
         * Run all tests
         */
        void RunAllTests()
        {
            LogInfo("=== Magic & Combat Systems Test ===");
            
            TestMagicSystemInitialization();
            TestSpellRegistration();
            TestPlayerSpellManagement();
            TestPotionOfForgetfulness();
            TestCombatSystem();
            TestSpellCombatIntegration();
            
            LogInfo("=== Test Complete ===");
        }
        
        private void TestMagicSystemInitialization()
        {
            LogInfo("Testing Magic System Initialization...");
            
            // Initialize magic system
            bool bResult = InitializeMagicSystem();
            if (bResult)
            {
                LogInfo("✓ Magic system initialized successfully");
            }
            else
            {
                LogError("✗ Magic system initialization failed");
                return;
            }
            
            // Get magic system instance
            MagicSystem@ pMagicSystem = GetMagicSystem();
            if (pMagicSystem !is null)
            {
                LogInfo("✓ Magic system instance retrieved");
            }
            else
            {
                LogError("✗ Failed to get magic system instance");
            }
            
            // Initialize combat system
            bResult = InitializeCombatSystem();
            if (bResult)
            {
                LogInfo("✓ Combat system initialized successfully");
            }
            else
            {
                LogError("✗ Combat system initialization failed");
            }
        }
        
        private void TestSpellRegistration()
        {
            LogInfo("Testing Spell Registration...");
            
            MagicSystem@ pMagicSystem = GetMagicSystem();
            if (pMagicSystem is null)
            {
                LogError("Magic system not available");
                return;
            }
            
            SpellRegistry@ pRegistry = pMagicSystem.GetSpellRegistry();
            if (pRegistry is null)
            {
                LogError("Spell registry not available");
                return;
            }
            
            // Check magic hand spells registration
            uint nTotalSpells = pRegistry.GetSpellCount();
            LogInfo("✓ Total registered spells: " + nTotalSpells);
            
            // Test finding specific spells
            SpellData@ pFireBall = pRegistry.FindSpellByScript("magic_hand_fire_ball");
            if (pFireBall !is null)
            {
                LogInfo("✓ Found Fire Ball spell: " + pFireBall.szDisplayName);
            }
            else
            {
                LogWarning("✗ Fire Ball spell not found");
            }
            
            SpellData@ pIceShield = pRegistry.FindSpellByName("Ice Shield");
            if (pIceShield !is null)
            {
                LogInfo("✓ Found Ice Shield by name: " + pIceShield.szScriptName);
            }
            else
            {
                LogWarning("✗ Ice Shield spell not found by name");
            }
            
            // Test category retrieval
            for (uint cat = 1; cat <= 3; cat++)
            {
                array<SpellData@> categorySpells = pRegistry.GetSpellsByCategory(cat);
                LogInfo("✓ Category " + cat + " has " + categorySpells.length() + " spells");
            }
            
            // Print registry statistics
            pRegistry.PrintRegistryStats();
        }
        
        private void TestPlayerSpellManagement()
        {
            LogInfo("Testing Player Spell Management...");
            
            MagicSystem@ pMagicSystem = GetMagicSystem();
            SpellRegistry@ pRegistry = pMagicSystem.GetSpellRegistry();
            
            string szTestPlayerID = "test_player_123";
            
            // Test learning spells
            bool bResult = pRegistry.PlayerLearnSpell(szTestPlayerID, "magic_hand_fire_ball");
            if (bResult)
            {
                LogInfo("✓ Player learned Fire Ball");
            }
            else
            {
                LogWarning("✗ Failed to learn Fire Ball");
            }
            
            bResult = pRegistry.PlayerLearnSpell(szTestPlayerID, "magic_hand_ice_shield");
            if (bResult)
            {
                LogInfo("✓ Player learned Ice Shield");
            }
            
            bResult = pRegistry.PlayerLearnSpell(szTestPlayerID, "magic_hand_lightning_storm");
            if (bResult)
            {
                LogInfo("✓ Player learned Lightning Storm");
            }
            
            // Get player's learned spells
            array<SpellData@> playerSpells = pRegistry.GetPlayerSpells(szTestPlayerID);
            LogInfo("✓ Player has " + playerSpells.length() + " learned spells");
            
            // List player's spells
            array<string> spellNames = pRegistry.GetPlayerSpellNames(szTestPlayerID);
            for (uint i = 0; i < spellNames.length(); i++)
            {
                LogInfo("  Slot " + i + ": " + spellNames[i]);
            }
        }
        
        private void TestPotionOfForgetfulness()
        {
            LogInfo("Testing Potion of Forgetfulness...");
            
            SpellRegistry@ pRegistry = GetMagicSystem().GetSpellRegistry();
            string szTestPlayerID = "test_player_123";
            
            // Get initial spell count
            array<string> spellNames = pRegistry.GetPlayerSpellNames(szTestPlayerID);
            uint nInitialCount = spellNames.length();
            LogInfo("Initial spells: " + nInitialCount);
            
            if (nInitialCount > 0)
            {
                // Forget the first spell (index 0)
                string szSpellToForget = spellNames[0];
                bool bResult = pRegistry.PlayerForgetSpell(szTestPlayerID, 0);
                
                if (bResult)
                {
                    LogInfo("✓ Successfully forgot spell: " + szSpellToForget);
                    
                    // Verify spell was removed
                    array<string> updatedNames = pRegistry.GetPlayerSpellNames(szTestPlayerID);
                    uint nNewCount = updatedNames.length();
                    
                    if (nNewCount == nInitialCount - 1)
                    {
                        LogInfo("✓ Spell count reduced correctly: " + nNewCount);
                    }
                    else
                    {
                        LogError("✗ Spell count incorrect after forgetting");
                    }
                }
                else
                {
                    LogError("✗ Failed to forget spell");
                }
            }
            else
            {
                LogWarning("No spells to forget");
            }
        }
        
        private void TestCombatSystem()
        {
            LogInfo("Testing Combat System...");
            
            CombatSystem@ pCombatSystem = GetCombatSystem();
            if (pCombatSystem is null)
            {
                LogError("Combat system not available");
                return;
            }
            
            string szTestPlayerID = "test_player_123";
            
            // Get player stats
            CombatStats@ pStats = pCombatSystem.GetPlayerStats(szTestPlayerID);
            if (pStats !is null)
            {
                LogInfo("✓ Player stats retrieved");
                LogInfo("  Damage dealt: " + pStats.flTotalDamageDealt);
                LogInfo("  Kills: " + pStats.nKills);
                LogInfo("  Deaths: " + pStats.nDeaths);
                LogInfo("  Spells cast: " + pStats.nSpellsCast);
            }
            else
            {
                LogError("✗ Failed to get player stats");
            }
            
            // Test damage processing (simulated)
            DamageInfo damageInfo;
            damageInfo.flDamage = 25.0f;
            damageInfo.eDamageType = DAMAGE_TYPE_FIRE;
            damageInfo.szDamageSource = "Fire Ball";
            damageInfo.bIsSpellDamage = true;
            
            // Note: We can't actually process damage without real entities
            LogInfo("✓ Damage info structure created successfully");
        }
        
        private void TestSpellCombatIntegration()
        {
            LogInfo("Testing Spell-Combat Integration...");
            
            MagicSystem@ pMagicSystem = GetMagicSystem();
            CombatSystem@ pCombatSystem = GetCombatSystem();
            SpellRegistry@ pRegistry = pMagicSystem.GetSpellRegistry();
            
            // Get a test spell
            SpellData@ pFireBall = pRegistry.FindSpellByScript("magic_hand_fire_ball");
            if (pFireBall !is null)
            {
                LogInfo("✓ Testing with Fire Ball spell");
                LogInfo("  Spell type: " + uint(pFireBall.eSpellType));
                LogInfo("  Mana cost: " + pFireBall.nManaCost);
                LogInfo("  Prepare time: " + pFireBall.flPrepareTime);
                LogInfo("  Damage type: " + pFireBall.szDamageType);
                
                // Test damage type conversion
                EDamageType eDamageType = GetDamageTypeFromString(pFireBall.szDamageType);
                LogInfo("  Converted damage type: " + uint(eDamageType));
            }
            else
            {
                LogWarning("Fire Ball spell not available for testing");
            }
            
            // Test creating spell damage info
            if (pFireBall !is null)
            {
                DamageInfo spellDamage = CreateSpellDamageInfo(null, pFireBall, 30.0f);
                LogInfo("✓ Spell damage info created");
                LogInfo("  Damage: " + spellDamage.flDamage);
                LogInfo("  Source: " + spellDamage.szDamageSource);
                LogInfo("  Is spell damage: " + spellDamage.bIsSpellDamage);
            }
        }
    }
    
    /**
     * Global test instance
     */
    MagicCombatTest@ g_pMagicCombatTest;
    
    /**
     * Initialize and run magic/combat tests
     */
    void RunMagicCombatTests()
    {
        if (g_pMagicCombatTest is null)
        {
            @g_pMagicCombatTest = MagicCombatTest();
        }
        
        g_pMagicCombatTest.RunAllTests();
    }
    
    /**
     * Test function for demonstrating magic hand spell conversion
     */
    void DemoMagicHandSpells()
    {
        LogInfo("=== Magic Hand Spell Conversion Demo ===");
        
        MagicSystem@ pMagicSystem = GetMagicSystem();
        if (pMagicSystem is null)
        {
            LogError("Magic system not initialized");
            return;
        }
        
        // Show original script arrays from game_master.script (lines 4-11)
        LogInfo("Original Magic Hand Scripts from game_master.script:");
        LogInfo("MAGIC_HAND_SCRIPTS1 (11 spells):");
        for (uint i = 0; i < MAGIC_HAND_SCRIPTS1.length(); i++)
        {
            LogInfo("  " + MAGIC_HAND_SCRIPTS1[i] + " -> " + MAGIC_HAND_NAMES1[i]);
        }
        
        LogInfo("MAGIC_HAND_SCRIPTS2 (10 spells):");
        for (uint i = 0; i < MAGIC_HAND_SCRIPTS2.length(); i++)
        {
            LogInfo("  " + MAGIC_HAND_SCRIPTS2[i] + " -> " + MAGIC_HAND_NAMES2[i]);
        }
        
        LogInfo("MAGIC_HAND_SCRIPTS3 (3 spells):");
        for (uint i = 0; i < MAGIC_HAND_SCRIPTS3.length(); i++)
        {
            LogInfo("  " + MAGIC_HAND_SCRIPTS3[i] + " -> " + MAGIC_HAND_NAMES3[i]);
        }
        
        // Show converted spell data
        SpellRegistry@ pRegistry = pMagicSystem.GetSpellRegistry();
        LogInfo("Converted to AngelScript SpellRegistry:");
        LogInfo("Total spells registered: " + pRegistry.GetSpellCount());
        
        // Demo spell casting simulation
        LogInfo("=== Spell Casting Demo ===");
        
        // Note: In real implementation, these would be called with actual player entities
        LogInfo("Simulating spell cast: Fire Ball");
        // pMagicSystem.CastSpell(pPlayer, "Fire Ball", targetLocation);
        
        LogInfo("Simulating spell cast by script: magic_hand_ice_shield");
        // pMagicSystem.CastSpellByScript(pPlayer, "magic_hand_ice_shield");
        
        LogInfo("=== Demo Complete ===");
    }
}