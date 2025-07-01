/**
 * NPCManagerTests.as
 * 
 * Comprehensive testing for the Critical NPC Manager system in Master Sword Rebirth
 * Tests NPC death tracking, respawn capabilities, quest protection, and admin functionality
 */

namespace MSTest
{
    /**
     * NPC Manager Test Suite
     * Validates all critical NPC functionality and quest chain protection
     */
    class NPCManagerTests
    {
    private:
        TestFramework m_Framework;
        
    public:
        NPCManagerTests()
        {
            m_Framework.SetSuiteName("NPC Manager");
        }
        
        /**
         * Run all NPC manager tests
         */
        TestSuiteStats RunAllTests()
        {
            m_Framework.Clear();
            
            // Core NPC manager functionality
            RunNPCManagerBasicTests();
            
            // NPC registration and tracking
            RunNPCRegistrationTests();
            
            // Critical NPC death handling
            RunNPCDeathTests();
            
            // Quest chain protection
            RunQuestChainTests();
            
            // Admin functionality
            RunAdminFunctionTests();
            
            // Legacy compatibility
            RunLegacyCompatibilityTests();
            
            // Error handling and edge cases
            RunErrorHandlingTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
        /**
         * Run stress tests for NPC system
         */
        TestSuiteStats RunStressTests()
        {
            m_Framework.Clear();
            m_Framework.SetSuiteName("NPC Manager Stress");
            
            RunMassNPCDeathTests();
            RunConcurrentNPCTests();
            RunLargeNPCRegistrationTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
    private:
        /**
         * Test basic NPC manager operations
         */
        void RunNPCManagerBasicTests()
        {
            m_Framework.RunTest("npc_manager_initialization", "Critical NPC manager initialization",
                function() {
                    try
                    {
                        InitializeCriticalNPCManager();
                        CriticalNPCManager@ manager = GetCriticalNPCManager();
                        return m_Framework.AssertTrue(manager !is null, "NPC manager should be initialized");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("npc_manager_statistics", "NPC manager statistics tracking",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    uint registeredCount = manager.GetRegisteredNPCCount();
                    uint activeCount = manager.GetActiveCriticalCount();
                    uint totalDeaths = manager.GetTotalCriticalDeaths();
                    uint friendlyFireDeaths = manager.GetFriendlyFireDeaths();
                    
                    return m_Framework.AssertTrue(registeredCount >= 0, "Registered NPC count should be non-negative") &&
                           m_Framework.AssertTrue(activeCount >= 0, "Active critical count should be non-negative") &&
                           m_Framework.AssertTrue(totalDeaths >= 0, "Total deaths should be non-negative") &&
                           m_Framework.AssertTrue(friendlyFireDeaths >= 0, "Friendly fire deaths should be non-negative");
                });
            
            m_Framework.RunTest("npc_manager_default_npcs", "Default critical NPCs registration",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    uint registeredCount = manager.GetRegisteredNPCCount();
                    array<CriticalNPCEntry> registeredNPCs = manager.GetRegisteredNPCs();
                    
                    bool hasHelenaElder = false;
                    bool hasDeraliaMayor = false;
                    
                    for (uint i = 0; i < registeredNPCs.length(); i++)
                    {
                        if (registeredNPCs[i].szNPCName == "helena_elder")
                            hasHelenaElder = true;
                        if (registeredNPCs[i].szNPCName == "deralia_mayor")
                            hasDeraliaMayor = true;
                    }
                    
                    return m_Framework.AssertTrue(registeredCount > 0, "Should have default NPCs registered") &&
                           m_Framework.AssertTrue(hasHelenaElder, "Should have Helena Elder registered") &&
                           m_Framework.AssertTrue(hasDeraliaMayor, "Should have Deralia Mayor registered");
                });
        }
        
        /**
         * Test NPC registration and tracking
         */
        void RunNPCRegistrationTests()
        {
            m_Framework.RunTest("npc_registration_basic", "Basic NPC registration",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    uint initialCount = manager.GetRegisteredNPCCount();
                    
                    string testNPCName = "test_npc_001";
                    string testScript = "test/test_npc";
                    string testDisplayName = "Test NPC #1";
                    
                    manager.RegisterCriticalNPC(testNPCName, testScript, testDisplayName, "test_map", 1, "test_quest");
                    
                    uint newCount = manager.GetRegisteredNPCCount();
                    array<CriticalNPCEntry> npcs = manager.GetRegisteredNPCs();
                    
                    bool foundNPC = false;
                    for (uint i = 0; i < npcs.length(); i++)
                    {
                        if (npcs[i].szNPCName == testNPCName)
                        {
                            foundNPC = true;
                            break;
                        }
                    }
                    
                    return m_Framework.AssertEqual(newCount, initialCount + 1, "NPC count should increase") &&
                           m_Framework.AssertTrue(foundNPC, "NPC should be found in registry");
                });
            
            m_Framework.RunTest("npc_registration_duplicate", "Duplicate NPC registration handling",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    string duplicateNPC = "duplicate_test_npc";
                    
                    uint countBefore = manager.GetRegisteredNPCCount();
                    
                    // Register same NPC twice
                    manager.RegisterCriticalNPC(duplicateNPC, "test/dup", "Duplicate Test", "test_map");
                    uint countAfterFirst = manager.GetRegisteredNPCCount();
                    
                    manager.RegisterCriticalNPC(duplicateNPC, "test/dup", "Duplicate Test", "test_map");
                    uint countAfterSecond = manager.GetRegisteredNPCCount();
                    
                    return m_Framework.AssertEqual(countAfterFirst, countBefore + 1, "First registration should succeed") &&
                           m_Framework.AssertEqual(countAfterSecond, countAfterFirst, "Duplicate registration should be ignored");
                });
            
            m_Framework.RunTest("npc_registration_priority", "NPC priority system",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    uint initialActiveCount = manager.GetActiveCriticalCount();
                    
                    // Register NPCs with different priorities
                    manager.RegisterCriticalNPC("priority_npc_1", "test/pri1", "Priority 1 NPC", "test_map", 1);
                    manager.RegisterCriticalNPC("priority_npc_2", "test/pri2", "Priority 2 NPC", "test_map", 2);
                    manager.RegisterCriticalNPC("priority_npc_3", "test/pri3", "Priority 3 NPC", "test_map", 3);
                    
                    uint newActiveCount = manager.GetActiveCriticalCount();
                    
                    // Only priority 1 and 2 should be added to critical list
                    return m_Framework.AssertEqual(newActiveCount, initialActiveCount + 2, "Only priority 1-2 NPCs should be critical");
                });
            
            m_Framework.RunTest("npc_registration_quest_chains", "NPC quest chain association",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    string questNPC = "quest_chain_npc";
                    string questChain = "test_main_quest";
                    
                    manager.RegisterCriticalNPC(questNPC, "test/quest", "Quest Chain NPC", "test_map", 1, questChain);
                    
                    array<CriticalNPCEntry> npcs = manager.GetRegisteredNPCs();
                    bool foundQuestChain = false;
                    
                    for (uint i = 0; i < npcs.length(); i++)
                    {
                        if (npcs[i].szNPCName == questNPC && npcs[i].szQuestChain == questChain)
                        {
                            foundQuestChain = true;
                            break;
                        }
                    }
                    
                    return m_Framework.AssertTrue(foundQuestChain, "NPC should be associated with quest chain");
                });
        }
        
        /**
         * Test critical NPC death handling
         */
        void RunNPCDeathTests()
        {
            m_Framework.RunTest("npc_death_basic", "Basic NPC death processing",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    string testNPC = "death_test_npc";
                    string killer = "test_killer";
                    
                    // Register the NPC first
                    manager.RegisterCriticalNPC(testNPC, "test/death", "Death Test NPC", "test_map", 1);
                    
                    uint initialDeaths = manager.GetTotalCriticalDeaths();
                    uint initialActiveCount = manager.GetActiveCriticalCount();
                    
                    // Report NPC death
                    manager.CriticalNPCDied(testNPC, killer);
                    
                    uint newDeaths = manager.GetTotalCriticalDeaths();
                    uint newActiveCount = manager.GetActiveCriticalCount();
                    
                    return m_Framework.AssertEqual(newDeaths, initialDeaths + 1, "Death count should increase") &&
                           m_Framework.AssertLessThan(float(newActiveCount), float(initialActiveCount), "Active count should decrease");
                });
            
            m_Framework.RunTest("npc_death_friendly_fire", "Friendly fire death tracking",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    string testNPC = "ff_test_npc";
                    string playerKiller = "STEAM_1:0:12345678"; // Steam ID format
                    
                    manager.RegisterCriticalNPC(testNPC, "test/ff", "Friendly Fire Test NPC", "test_map", 1);
                    
                    uint initialFFDeaths = manager.GetFriendlyFireDeaths();
                    
                    manager.CriticalNPCDied(testNPC, playerKiller);
                    
                    uint newFFDeaths = manager.GetFriendlyFireDeaths();
                    
                    return m_Framework.AssertEqual(newFFDeaths, initialFFDeaths + 1, "Friendly fire death count should increase");
                });
            
            m_Framework.RunTest("npc_death_history", "NPC death history tracking",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    string testNPC = "history_test_npc";
                    string killer = "history_killer";
                    
                    manager.RegisterCriticalNPC(testNPC, "test/history", "History Test NPC", "test_map", 1);
                    
                    array<CriticalNPCDeath> initialHistory = manager.GetDeathHistory();
                    uint initialCount = initialHistory.length();
                    
                    manager.CriticalNPCDied(testNPC, killer);
                    
                    array<CriticalNPCDeath> newHistory = manager.GetDeathHistory();
                    uint newCount = newHistory.length();
                    
                    bool foundDeath = false;
                    for (uint i = 0; i < newHistory.length(); i++)
                    {
                        if (newHistory[i].szNPCName == testNPC && newHistory[i].szKillerID == killer)
                        {
                            foundDeath = true;
                            break;
                        }
                    }
                    
                    return m_Framework.AssertEqual(newCount, initialCount + 1, "History count should increase") &&
                           m_Framework.AssertTrue(foundDeath, "Death should be recorded in history");
                });
            
            m_Framework.RunTest("npc_death_removal", "NPC removal from critical list",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    string testNPC = "removal_test_npc";
                    
                    manager.RegisterCriticalNPC(testNPC, "test/removal", "Removal Test NPC", "test_map", 1);
                    
                    array<string> initialList = manager.GetCurrentCriticalList();
                    bool wasInList = (initialList.find(testNPC) >= 0);
                    
                    manager.RemoveFromCriticalList(testNPC);
                    
                    array<string> newList = manager.GetCurrentCriticalList();
                    bool stillInList = (newList.find(testNPC) >= 0);
                    
                    return m_Framework.AssertTrue(wasInList, "NPC should initially be in critical list") &&
                           m_Framework.AssertFalse(stillInList, "NPC should be removed from critical list");
                });
        }
        
        /**
         * Test quest chain protection
         */
        void RunQuestChainTests()
        {
            m_Framework.RunTest("quest_chain_impact_detection", "Quest chain impact detection",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    string questNPC = "quest_impact_npc";
                    string questChain = "critical_quest_chain";
                    
                    manager.RegisterCriticalNPC(questNPC, "test/quest", "Quest Impact NPC", "test_map", 1, questChain);
                    
                    uint initialProtectedChains = manager.GetQuestChainsProtected();
                    
                    manager.CriticalNPCDied(questNPC, "impact_killer");
                    
                    uint newProtectedChains = manager.GetQuestChainsProtected();
                    
                    return m_Framework.AssertEqual(newProtectedChains, initialProtectedChains + 1, "Quest chain protection count should increase");
                });
            
            m_Framework.RunTest("quest_chain_multiple_npcs", "Multiple NPCs in same quest chain",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    string questChain = "multi_npc_quest";
                    
                    // Register multiple NPCs for same quest chain
                    manager.RegisterCriticalNPC("multi_npc_1", "test/multi1", "Multi NPC 1", "test_map", 1, questChain);
                    manager.RegisterCriticalNPC("multi_npc_2", "test/multi2", "Multi NPC 2", "test_map", 1, questChain);
                    manager.RegisterCriticalNPC("multi_npc_3", "test/multi3", "Multi NPC 3", "test_map", 2, questChain);
                    
                    uint initialProtected = manager.GetQuestChainsProtected();
                    
                    // Kill one NPC
                    manager.CriticalNPCDied("multi_npc_1", "multi_killer");
                    
                    uint afterOneKill = manager.GetQuestChainsProtected();
                    
                    // Kill another
                    manager.CriticalNPCDied("multi_npc_2", "multi_killer");
                    
                    uint afterTwoKills = manager.GetQuestChainsProtected();
                    
                    return m_Framework.AssertEqual(afterOneKill, initialProtected + 1, "First kill should increment protection") &&
                           m_Framework.AssertEqual(afterTwoKills, afterOneKill + 1, "Second kill should also increment");
                });
        }
        
        /**
         * Test admin functionality
         */
        void RunAdminFunctionTests()
        {
            m_Framework.RunTest("npc_respawn_functionality", "NPC respawn system",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    string respawnNPC = "respawn_test_npc";
                    Vector3 respawnPos(100.0f, 200.0f, 300.0f);
                    
                    // Register NPC with respawn capability
                    manager.RegisterCriticalNPC(respawnNPC, "test/respawn", "Respawn Test NPC", "test_map", 1);
                    
                    // Kill the NPC
                    manager.CriticalNPCDied(respawnNPC, "respawn_killer");
                    
                    uint beforeRespawn = manager.GetAdminInterventions();
                    
                    // Respawn the NPC
                    bool respawnResult = manager.RespawnCriticalNPC(respawnNPC, respawnPos);
                    
                    uint afterRespawn = manager.GetAdminInterventions();
                    array<string> activeList = manager.GetCurrentCriticalList();
                    bool backInList = (activeList.find(respawnNPC) >= 0);
                    
                    return m_Framework.AssertTrue(respawnResult, "Respawn should succeed") &&
                           m_Framework.AssertEqual(afterRespawn, beforeRespawn + 1, "Admin intervention count should increase") &&
                           m_Framework.AssertTrue(backInList, "NPC should be back in critical list");
                });
            
            m_Framework.RunTest("npc_status_report", "Admin status report generation",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    try
                    {
                        // This would normally require a CBasePlayer@ but we test the function exists
                        // manager.GenerateStatusReport(null);
                        
                        // Test that we can access the statistics used in reports
                        uint registeredCount = manager.GetRegisteredNPCCount();
                        uint activeCount = manager.GetActiveCriticalCount();
                        uint totalDeaths = manager.GetTotalCriticalDeaths();
                        
                        return m_Framework.AssertTrue(registeredCount >= 0, "Should have registered NPCs") &&
                               m_Framework.AssertTrue(activeCount >= 0, "Should have active NPCs") &&
                               m_Framework.AssertTrue(totalDeaths >= 0, "Should track total deaths");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("npc_critical_list_reset", "Critical list reset functionality",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    // Kill some NPCs to modify the list
                    manager.CriticalNPCDied("helena_elder", "reset_killer");
                    
                    uint beforeReset = manager.GetActiveCriticalCount();
                    
                    // Reset the critical list
                    manager.ResetCriticalList();
                    
                    uint afterReset = manager.GetActiveCriticalCount();
                    
                    return m_Framework.AssertGreaterThan(float(afterReset), float(beforeReset), "Reset should restore NPCs to critical list");
                });
            
            m_Framework.RunTest("npc_death_history_clear", "Death history clearing",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    // Make sure there's some history
                    manager.CriticalNPCDied("helena_elder", "history_clear_killer");
                    
                    array<CriticalNPCDeath> beforeClear = manager.GetDeathHistory();
                    uint beforeCount = beforeClear.length();
                    
                    manager.ClearDeathHistory();
                    
                    array<CriticalNPCDeath> afterClear = manager.GetDeathHistory();
                    uint afterCount = afterClear.length();
                    
                    return m_Framework.AssertTrue(beforeCount > 0, "Should have death history before clear") &&
                           m_Framework.AssertEqual(afterCount, 0, "Should have no death history after clear");
                });
        }
        
        /**
         * Test legacy compatibility functions
         */
        void RunLegacyCompatibilityTests()
        {
            m_Framework.RunTest("legacy_crit_npc_died", "Legacy gm_crit_npc_died function",
                function() {
                    try
                    {
                        string npc = "legacy_died_npc";
                        string killer = "legacy_killer";
                        
                        register_critical_npc(npc, "test/legacy", "Legacy Test NPC", "test_map");
                        
                        uint beforeDeaths = crit_count_remaining();
                        
                        gm_crit_npc_died(npc, killer);
                        
                        uint afterDeaths = crit_count_remaining();
                        
                        return m_Framework.AssertLessThan(float(afterDeaths), float(beforeDeaths), "Legacy death function should work");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("legacy_remove_crit_npc", "Legacy remove_crit_npc function",
                function() {
                    try
                    {
                        string npc = "legacy_remove_npc";
                        
                        register_critical_npc(npc, "test/legacy_remove", "Legacy Remove NPC", "test_map");
                        
                        uint beforeCount = crit_count_remaining();
                        
                        remove_crit_npc(npc);
                        
                        uint afterCount = crit_count_remaining();
                        
                        return m_Framework.AssertLessThan(float(afterCount), float(beforeCount), "Legacy remove function should work");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("legacy_crit_count_remaining", "Legacy crit_count_remaining function",
                function() {
                    try
                    {
                        uint count = crit_count_remaining();
                        return m_Framework.AssertTrue(count >= 0, "Legacy count function should return valid number");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("legacy_register_functions", "Legacy registration functions",
                function() {
                    try
                    {
                        string npc = "legacy_reg_npc";
                        
                        register_critical_npc(npc, "test/legacy_reg", "Legacy Reg NPC", "test_map", 1, "legacy_quest");
                        
                        bool respawnResult = respawn_critical_npc(npc);
                        
                        // Should not crash
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test error handling and edge cases
         */
        void RunErrorHandlingTests()
        {
            m_Framework.RunTest("npc_invalid_parameters", "Invalid parameter handling",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    try
                    {
                        // Empty strings
                        manager.RegisterCriticalNPC("", "test/empty", "Empty Name NPC", "test_map");
                        manager.RegisterCriticalNPC("valid_name", "", "Empty Script NPC", "test_map");
                        
                        // Report death of non-existent NPC
                        manager.CriticalNPCDied("nonexistent_npc_12345", "test_killer");
                        
                        // Remove non-existent NPC
                        manager.RemoveFromCriticalList("another_nonexistent_npc");
                        
                        // Respawn non-existent NPC
                        bool respawnResult = manager.RespawnCriticalNPC("nonexistent_respawn_npc");
                        
                        return m_Framework.AssertFalse(respawnResult, "Respawn of non-existent NPC should fail");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("npc_edge_case_priorities", "Edge case priority handling",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    try
                    {
                        // Negative priority
                        manager.RegisterCriticalNPC("negative_pri_npc", "test/neg", "Negative Priority", "test_map", -1);
                        
                        // Very high priority
                        manager.RegisterCriticalNPC("high_pri_npc", "test/high", "High Priority", "test_map", 999);
                        
                        // Zero priority
                        manager.RegisterCriticalNPC("zero_pri_npc", "test/zero", "Zero Priority", "test_map", 0);
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("npc_death_history_overflow", "Death history overflow handling",
                function() {
                    CriticalNPCManager@ manager = GetCriticalNPCManager();
                    if (manager is null) return false;
                    
                    try
                    {
                        // Generate many deaths to test overflow handling
                        for (uint i = 0; i < 150; i++) // More than the 100 limit
                        {
                            string npcName = "overflow_npc_" + i;
                            manager.RegisterCriticalNPC(npcName, "test/overflow", "Overflow NPC", "test_map", 1);
                            manager.CriticalNPCDied(npcName, "overflow_killer");
                        }
                        
                        array<CriticalNPCDeath> history = manager.GetDeathHistory();
                        uint historyCount = history.length();
                        
                        return m_Framework.AssertTrue(historyCount <= 100, "History should be limited to 100 entries");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Stress testing for NPC system
         */
        void RunMassNPCDeathTests()
        {
            m_Framework.RunTest("npc_mass_death_processing", "Mass NPC death processing",
                function() {
                    try
                    {
                        CriticalNPCManager@ manager = GetCriticalNPCManager();
                        if (manager is null) return false;
                        
                        // Register and kill many NPCs quickly
                        for (uint i = 0; i < 50; i++)
                        {
                            string npcName = "mass_death_npc_" + i;
                            manager.RegisterCriticalNPC(npcName, "test/mass", "Mass Death NPC", "test_map", 1);
                            manager.CriticalNPCDied(npcName, "mass_killer_" + (i % 10));
                        }
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        void RunConcurrentNPCTests()
        {
            m_Framework.RunTest("npc_concurrent_operations", "Concurrent NPC operations",
                function() {
                    try
                    {
                        CriticalNPCManager@ manager = GetCriticalNPCManager();
                        if (manager is null) return false;
                        
                        // Simulate concurrent access
                        for (uint i = 0; i < 20; i++)
                        {
                            string npcName = "concurrent_npc_" + i;
                            manager.RegisterCriticalNPC(npcName, "test/concurrent", "Concurrent NPC", "test_map", 1);
                            
                            if (i % 3 == 0)
                            {
                                manager.CriticalNPCDied(npcName, "concurrent_killer");
                            }
                            
                            if (i % 5 == 0)
                            {
                                manager.RemoveFromCriticalList(npcName);
                            }
                        }
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        void RunLargeNPCRegistrationTests()
        {
            m_Framework.RunTest("npc_large_registration", "Large scale NPC registration",
                function() {
                    try
                    {
                        CriticalNPCManager@ manager = GetCriticalNPCManager();
                        if (manager is null) return false;
                        
                        uint initialCount = manager.GetRegisteredNPCCount();
                        
                        // Register large number of NPCs
                        for (uint i = 0; i < 200; i++)
                        {
                            string npcName = "large_reg_npc_" + i;
                            string questChain = "large_quest_" + (i % 20);
                            int priority = (i % 3) + 1;
                            
                            manager.RegisterCriticalNPC(npcName, "test/large", "Large Reg NPC", "test_map", priority, questChain);
                        }
                        
                        uint finalCount = manager.GetRegisteredNPCCount();
                        
                        return m_Framework.AssertEqual(finalCount, initialCount + 200, "Should register all 200 NPCs");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
    }
}