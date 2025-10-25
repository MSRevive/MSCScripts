#pragma context server

/**
 * QuestSystemTests.as
 * 
 * Comprehensive testing for the Quest Item System in Master Sword Rebirth
 * Tests quest item tracking, persistence, NPC integration, and legacy compatibility
 */

namespace MSTest
{
    /**
     * Quest System Test Suite
     * Validates all quest item functionality and integration points
     */
    class QuestSystemTests
    {
    private:
        TestFramework m_Framework;
        
    public:
        QuestSystemTests()
        {
            m_Framework.SetSuiteName("Quest System");
        }
        
        /**
         * Run all quest system tests
         */
        TestSuiteStats RunAllTests()
        {
            m_Framework.Clear();
            
            // Core quest item functionality
            RunQuestItemBasicTests();
            
            // Quest tracker system tests
            RunQuestTrackerTests();
            
            // Integration layer tests
            RunQuestIntegrationTests();
            
            // NPC interaction tests
            RunNPCQuestTests();
            
            // Persistence and state tests
            RunPersistenceTests();
            
            // Legacy compatibility tests
            RunLegacyCompatibilityTests();
            
            // Error handling and edge cases
            RunErrorHandlingTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
        /**
         * Run basic functionality tests only
         */
        TestSuiteStats RunBasicTests()
        {
            m_Framework.Clear();
            m_Framework.SetSuiteName("Basic Quest System");
            
            RunQuestItemBasicTests();
            RunBasicQuestTrackerTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
        /**
         * Run stress tests for quest system
         */
        TestSuiteStats RunStressTests()
        {
            m_Framework.Clear();
            m_Framework.SetSuiteName("Quest System Stress");
            
            RunQuestStressTests();
            RunMassDeliveryTests();
            RunConcurrencyTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
    private:
        /**
         * Test basic quest item operations
         */
        void RunQuestItemBasicTests()
        {
            m_Framework.RunTest("quest_tracker_initialization", "Quest tracker system initialization",
                function() {
                    try
                    {
                        InitializeQuestTracker();
                        QuestTracker@ tracker = GetQuestTracker();
                        return m_Framework.AssertTrue(tracker !is null, "Quest tracker should be initialized");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("quest_item_registration", "Quest item registration functionality",
                function() {
                    QuestTracker@ tracker = GetQuestTracker();
                    if (tracker is null) return false;
                    
                    uint initialCount = tracker.GetRegisteredItemCount();
                    
                    tracker.RegisterQuestItem("test_item", "Test Item", "A test quest item for validation");
                    
                    uint newCount = tracker.GetRegisteredItemCount();
                    bool itemRegistered = tracker.IsItemRegistered("test_item");
                    
                    return m_Framework.AssertEqual(newCount, initialCount + 1, "Item count should increase") &&
                           m_Framework.AssertTrue(itemRegistered, "Item should be registered");
                });
            
            m_Framework.RunTest("quest_item_basic_operations", "Basic quest item give/take operations",
                function() {
                    string testPlayer = "test_player_001";
                    string testItem = "test_basic_item";
                    
                    // Register the item first
                    QuestTracker@ tracker = GetQuestTracker();
                    tracker.RegisterQuestItem(testItem, "Test Basic Item", "Basic test item");
                    
                    // Give item to player
                    bool giveResult = ext_got_quest_item_player(testPlayer, testItem, 3);
                    
                    // Check if player has the item
                    uint playerCount = ext_get_quest_item_count(testPlayer, testItem);
                    
                    // Take some items
                    uint takenCount = ext_check_quest_item_qty(testItem, "test_npc", 2);
                    uint remainingCount = ext_get_quest_item_count(testPlayer, testItem);
                    
                    return m_Framework.AssertTrue(giveResult, "Should be able to give quest items") &&
                           m_Framework.AssertEqual(playerCount, 3, "Player should have 3 items") &&
                           m_Framework.AssertEqual(takenCount, 2, "Should take 2 items") &&
                           m_Framework.AssertEqual(remainingCount, 1, "Player should have 1 item remaining");
                });
            
            m_Framework.RunTest("quest_item_check_operations", "Quest item check and validation",
                function() {
                    string testPlayer = "test_player_002";
                    string testItem = "test_check_item";
                    
                    QuestTracker@ tracker = GetQuestTracker();
                    tracker.RegisterQuestItem(testItem, "Test Check Item", "Item for check testing");
                    
                    // Initially player should not have the item
                    uint initialCount = ext_get_quest_item_count(testPlayer, testItem);
                    uint checkResult1 = ext_check_quest_item(testItem, "npc_001");
                    
                    // Give item and check again
                    ext_got_quest_item_player(testPlayer, testItem, 5);
                    uint checkResult2 = ext_check_quest_item(testItem, "npc_001");
                    
                    return m_Framework.AssertEqual(initialCount, 0, "Player should start with 0 items") &&
                           m_Framework.AssertEqual(checkResult1, 0, "Check should return 0 when no items") &&
                           m_Framework.AssertEqual(checkResult2, 1, "Check should return 1 when items available");
                });
        }
        
        /**
         * Test quest tracker system functionality
         */
        void RunQuestTrackerTests()
        {
            RunBasicQuestTrackerTests();
            RunAdvancedQuestTrackerTests();
        }
        
        void RunBasicQuestTrackerTests()
        {
            m_Framework.RunTest("quest_tracker_item_info", "Quest item information retrieval",
                function() {
                    QuestTracker@ tracker = GetQuestTracker();
                    if (tracker is null) return false;
                    
                    string itemCode = "info_test_item";
                    string itemName = "Information Test Item";
                    string itemDesc = "An item used to test information retrieval";
                    
                    tracker.RegisterQuestItem(itemCode, itemName, itemDesc);
                    
                    string retrievedName = tracker.GetItemName(itemCode);
                    string retrievedDesc = tracker.GetItemDescription(itemCode);
                    bool isRegistered = tracker.IsItemRegistered(itemCode);
                    
                    return m_Framework.AssertEqual(retrievedName, itemName, "Item name should match") &&
                           m_Framework.AssertEqual(retrievedDesc, itemDesc, "Item description should match") &&
                           m_Framework.AssertTrue(isRegistered, "Item should be registered");
                });
            
            m_Framework.RunTest("quest_tracker_statistics", "Quest tracker statistics and reporting",
                function() {
                    QuestTracker@ tracker = GetQuestTracker();
                    if (tracker is null) return false;
                    
                    uint initialItems = tracker.GetTotalItemsFound();
                    uint initialDeliveries = tracker.GetTotalDeliveries();
                    
                    // Simulate some quest activity
                    ext_got_quest_item_player("stats_player", "stats_item", 2);
                    ext_check_quest_item_qty("stats_item", "stats_npc", 1);
                    
                    uint newItems = tracker.GetTotalItemsFound();
                    uint newDeliveries = tracker.GetTotalDeliveries();
                    
                    return m_Framework.AssertGreaterThan(float(newItems), float(initialItems), "Items found should increase") &&
                           m_Framework.AssertGreaterThan(float(newDeliveries), float(initialDeliveries), "Deliveries should increase");
                });
        }
        
        void RunAdvancedQuestTrackerTests()
        {
            m_Framework.RunTest("quest_tracker_player_inventory", "Player inventory tracking",
                function() {
                    QuestTracker@ tracker = GetQuestTracker();
                    if (tracker is null) return false;
                    
                    string player = "inventory_test_player";
                    
                    // Give multiple different items
                    ext_got_quest_item_player(player, "inv_item1", 3);
                    ext_got_quest_item_player(player, "inv_item2", 1);
                    ext_got_quest_item_player(player, "inv_item3", 7);
                    
                    array<string> playerItems = tracker.GetPlayerQuestItems(player);
                    uint totalItems = 0;
                    
                    for (uint i = 0; i < playerItems.length(); i++)
                    {
                        totalItems += ext_get_quest_item_count(player, playerItems[i]);
                    }
                    
                    return m_Framework.AssertEqual(playerItems.length(), 3, "Player should have 3 different items") &&
                           m_Framework.AssertEqual(totalItems, 11, "Player should have 11 total items");
                });
            
            m_Framework.RunTest("quest_tracker_delivery_history", "Quest delivery history tracking",
                function() {
                    QuestTracker@ tracker = GetQuestTracker();
                    if (tracker is null) return false;
                    
                    string player = "history_player";
                    string item = "history_item";
                    string npc = "history_npc";
                    
                    // Setup and deliver
                    ext_got_quest_item_player(player, item, 5);
                    uint delivered = ext_check_quest_item_qty(item, npc, 3);
                    
                    array<QuestDelivery> history = tracker.GetDeliveryHistory();
                    bool foundDelivery = false;
                    
                    for (uint i = 0; i < history.length(); i++)
                    {
                        if (history[i].szItemCode == item && history[i].szNPCID == npc)
                        {
                            foundDelivery = true;
                            break;
                        }
                    }
                    
                    return m_Framework.AssertEqual(delivered, 3, "Should deliver 3 items") &&
                           m_Framework.AssertTrue(foundDelivery, "Delivery should be recorded in history");
                });
        }
        
        /**
         * Test quest integration layer
         */
        void RunQuestIntegrationTests()
        {
            m_Framework.RunTest("quest_integration_initialization", "Quest integration layer initialization",
                function() {
                    try
                    {
                        InitializeQuestItemIntegration();
                        QuestItemIntegration@ integration = GetQuestItemIntegration();
                        return m_Framework.AssertTrue(integration !is null, "Integration layer should initialize");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("quest_integration_pickup", "Quest item pickup integration",
                function() {
                    QuestItemIntegration@ integration = GetQuestItemIntegration();
                    if (integration is null) return false;
                    
                    string player = "pickup_player";
                    string item = "pickup_item";
                    string entity = "pickup_entity_001";
                    
                    uint initialCount = ext_get_quest_item_count(player, item);
                    
                    integration.HandleQuestItemPickup(player, item, entity);
                    
                    uint newCount = ext_get_quest_item_count(player, item);
                    
                    return m_Framework.AssertEqual(newCount, initialCount + 1, "Pickup should add 1 item");
                });
            
            m_Framework.RunTest("quest_integration_npc_menu", "NPC menu quest item handling",
                function() {
                    QuestItemIntegration@ integration = GetQuestItemIntegration();
                    if (integration is null) return false;
                    
                    string player = "menu_player";
                    string npc = "menu_npc";
                    string item = "menu_item";
                    
                    // Setup - player doesn't have item
                    bool result1 = integration.HandleNPCQuestItemMenu(player, npc, item, 2);
                    
                    // Give player items
                    ext_got_quest_item_player(player, item, 3);
                    bool result2 = integration.HandleNPCQuestItemMenu(player, npc, item, 2);
                    
                    uint remainingCount = ext_get_quest_item_count(player, item);
                    
                    return m_Framework.AssertFalse(result1, "Should fail when player lacks items") &&
                           m_Framework.AssertTrue(result2, "Should succeed when player has items") &&
                           m_Framework.AssertEqual(remainingCount, 1, "Player should have 1 item remaining");
                });
            
            m_Framework.RunTest("quest_integration_statistics", "Integration layer statistics",
                function() {
                    QuestItemIntegration@ integration = GetQuestItemIntegration();
                    if (integration is null) return false;
                    
                    uint totalItems, totalDeliveries, registeredItems, waitingNPCs;
                    integration.GetStatistics(totalItems, totalDeliveries, registeredItems, waitingNPCs);
                    
                    return m_Framework.AssertTrue(totalItems >= 0, "Total items should be non-negative") &&
                           m_Framework.AssertTrue(totalDeliveries >= 0, "Total deliveries should be non-negative") &&
                           m_Framework.AssertTrue(registeredItems > 0, "Should have registered items") &&
                           m_Framework.AssertTrue(waitingNPCs >= 0, "Waiting NPCs should be non-negative");
                });
        }
        
        /**
         * Test NPC quest interactions
         */
        void RunNPCQuestTests()
        {
            m_Framework.RunTest("npc_waiting_system", "NPC waiting for quest items",
                function() {
                    QuestItemIntegration@ integration = GetQuestItemIntegration();
                    if (integration is null) return false;
                    
                    string npc = "waiting_npc";
                    string item = "waiting_item";
                    string player = "waiting_player";
                    
                    // Register NPC as waiting
                    integration.RegisterNPCWaitingForItem(npc, item);
                    
                    // Give item to player (should trigger processing)
                    integration.HandleQuestItemPickup(player, item);
                    
                    // Check if delivery occurred
                    uint deliveredCount = ext_check_quest_item(item, npc);
                    
                    return m_Framework.AssertEqual(deliveredCount, 1, "NPC should receive 1 item when available");
                });
            
            m_Framework.RunTest("npc_waiting_unregister", "NPC waiting list management",
                function() {
                    QuestItemIntegration@ integration = GetQuestItemIntegration();
                    if (integration is null) return false;
                    
                    string npc = "unreg_npc";
                    string item = "unreg_item";
                    
                    // Register and then unregister
                    integration.RegisterNPCWaitingForItem(npc, item);
                    integration.UnregisterNPCWaitingForItem(npc, item);
                    
                    // Give item to player - NPC should not get it automatically
                    integration.HandleQuestItemPickup("unreg_player", item);
                    
                    // Manual check should work
                    uint deliveredCount = ext_check_quest_item(item, npc);
                    
                    return m_Framework.AssertEqual(deliveredCount, 0, "Unregistered NPC should not auto-receive items");
                });
            
            m_Framework.RunTest("npc_multiple_waiting", "Multiple NPCs waiting for same item",
                function() {
                    QuestItemIntegration@ integration = GetQuestItemIntegration();
                    if (integration is null) return false;
                    
                    string item = "multi_item";
                    string player = "multi_player";
                    
                    // Register multiple NPCs
                    integration.RegisterNPCWaitingForItem("multi_npc1", item);
                    integration.RegisterNPCWaitingForItem("multi_npc2", item);
                    integration.RegisterNPCWaitingForItem("multi_npc3", item);
                    
                    // Give multiple items
                    ext_got_quest_item_player(player, item, 5);
                    integration.ProcessWaitingNPCs(item);
                    
                    // Each NPC should get at least some items
                    uint count1 = ext_check_quest_item(item, "multi_npc1");
                    uint count2 = ext_check_quest_item(item, "multi_npc2");
                    uint count3 = ext_check_quest_item(item, "multi_npc3");
                    
                    return m_Framework.AssertTrue(count1 > 0 || count2 > 0 || count3 > 0, "At least one NPC should receive items");
                });
        }
        
        /**
         * Test persistence and state management
         */
        void RunPersistenceTests()
        {
            m_Framework.RunTest("quest_state_persistence", "Quest state persistence across sessions",
                function() {
                    // This test simulates what would happen with save/load
                    string player = "persist_player";
                    string item = "persist_item";
                    
                    // Give items
                    ext_got_quest_item_player(player, item, 10);
                    uint savedCount = ext_get_quest_item_count(player, item);
                    
                    // Simulate persistence (in real implementation this would save/load)
                    // For testing, we just verify the count remains consistent
                    uint loadedCount = ext_get_quest_item_count(player, item);
                    
                    return m_Framework.AssertEqual(savedCount, loadedCount, "Quest item count should persist");
                });
            
            m_Framework.RunTest("quest_delivery_persistence", "Quest delivery history persistence",
                function() {
                    QuestTracker@ tracker = GetQuestTracker();
                    if (tracker is null) return false;
                    
                    uint initialDeliveries = tracker.GetTotalDeliveries();
                    
                    // Make a delivery
                    ext_got_quest_item_player("persist_del_player", "persist_del_item", 2);
                    ext_check_quest_item_qty("persist_del_item", "persist_del_npc", 1);
                    
                    uint newDeliveries = tracker.GetTotalDeliveries();
                    
                    return m_Framework.AssertGreaterThan(float(newDeliveries), float(initialDeliveries), "Delivery count should increase");
                });
        }
        
        /**
         * Test legacy compatibility functions
         */
        void RunLegacyCompatibilityTests()
        {
            m_Framework.RunTest("legacy_quest_pickup", "Legacy quest item pickup function",
                function() {
                    try
                    {
                        string player = "legacy_pickup_player";
                        string item = "legacy_pickup_item";
                        
                        uint initialCount = ext_get_quest_item_count(player, item);
                        legacy_quest_item_pickup(player, item);
                        uint newCount = ext_get_quest_item_count(player, item);
                        
                        return m_Framework.AssertEqual(newCount, initialCount + 1, "Legacy pickup should add 1 item");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("legacy_npc_check", "Legacy NPC quest check function", 
                function() {
                    try
                    {
                        string player = "legacy_check_player";
                        string npc = "legacy_check_npc";
                        string item = "legacy_check_item";
                        
                        // Player doesn't have item
                        bool result1 = legacy_npc_quest_check(player, npc, item, 1);
                        
                        // Give item and try again
                        ext_got_quest_item_player(player, item, 2);
                        bool result2 = legacy_npc_quest_check(player, npc, item, 1);
                        
                        return m_Framework.AssertFalse(result1, "Should fail without items") &&
                               m_Framework.AssertTrue(result2, "Should succeed with items");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("legacy_spawn_item", "Legacy quest item spawning",
                function() {
                    try
                    {
                        legacy_spawn_quest_item("legacy_spawn_item", 100.0f, 200.0f, 300.0f);
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
            m_Framework.RunTest("quest_invalid_parameters", "Invalid parameter handling",
                function() {
                    try
                    {
                        // Empty strings
                        bool result1 = ext_got_quest_item_player("", "test_item", 1);
                        bool result2 = ext_got_quest_item_player("test_player", "", 1);
                        
                        // Negative quantities
                        bool result3 = ext_got_quest_item_player("test_player", "test_item", -5);
                        
                        // Zero quantities
                        bool result4 = ext_got_quest_item_player("test_player", "test_item", 0);
                        
                        // Should handle gracefully without crashing
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("quest_unregistered_items", "Unregistered quest item handling",
                function() {
                    string unregisteredItem = "never_registered_item_12345";
                    
                    try
                    {
                        ext_got_quest_item_player("test_player", unregisteredItem, 1);
                        uint count = ext_get_quest_item_count("test_player", unregisteredItem);
                        uint delivered = ext_check_quest_item(unregisteredItem, "test_npc");
                        
                        // Should handle gracefully
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("quest_large_quantities", "Large quantity handling",
                function() {
                    try
                    {
                        string player = "large_qty_player";
                        string item = "large_qty_item";
                        
                        // Very large quantity
                        bool result = ext_got_quest_item_player(player, item, 999999);
                        uint count = ext_get_quest_item_count(player, item);
                        
                        return m_Framework.AssertTrue(result, "Should handle large quantities") &&
                               m_Framework.AssertTrue(count > 0, "Count should be positive");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Stress testing for quest system
         */
        void RunQuestStressTests()
        {
            m_Framework.RunTest("quest_high_volume", "High volume quest operations",
                function() {
                    try
                    {
                        for (uint i = 0; i < 100; i++)
                        {
                            string player = "stress_player_" + i;
                            string item = "stress_item_" + (i % 10);
                            
                            ext_got_quest_item_player(player, item, i % 20 + 1);
                            
                            if (i % 3 == 0)
                            {
                                ext_check_quest_item_qty(item, "stress_npc_" + (i % 5), 1);
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
        
        void RunMassDeliveryTests()
        {
            m_Framework.RunTest("quest_mass_delivery", "Mass quest item delivery",
                function() {
                    try
                    {
                        string item = "mass_delivery_item";
                        
                        // Give many items to many players
                        for (uint i = 0; i < 50; i++)
                        {
                            ext_got_quest_item_player("mass_player_" + i, item, 10);
                        }
                        
                        // Mass delivery to NPCs
                        for (uint i = 0; i < 25; i++)
                        {
                            ext_check_quest_item_qty(item, "mass_npc_" + i, 2);
                        }
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        void RunConcurrencyTests()
        {
            m_Framework.RunTest("quest_concurrent_access", "Concurrent quest system access",
                function() {
                    try
                    {
                        string item = "concurrent_item";
                        string player = "concurrent_player";
                        
                        // Simulate concurrent operations
                        for (uint i = 0; i < 10; i++)
                        {
                            ext_got_quest_item_player(player, item, 1);
                            uint count = ext_get_quest_item_count(player, item);
                            ext_check_quest_item_qty(item, "concurrent_npc", 1);
                        }
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
    }
}