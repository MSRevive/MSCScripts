#pragma context server

/**
 * test_quest_system.as
 * 
 * Test script to demonstrate and validate the quest item system
 * This script can be loaded to verify that all quest item functions work correctly
 */

namespace MS
{
    /**
     * Test the quest item system functionality
     */
    void TestQuestSystem()
    {
        LogMessage("=== Quest Item System Test ===");
        
        // Initialize the systems
        InitializeQuestTracker();
        InitializeQuestItemIntegration();
        
        // Test 1: Register a test quest item
        LogMessage("Test 1: Registering test quest item");
        ext_register_quest_item("test_gem", "Test Gem", "A gem used for testing the quest system");
        
        // Test 2: Player finds quest item
        LogMessage("Test 2: Player finds quest item");
        string testPlayerID = "STEAM_0:1:12345";
        ext_got_quest_item_player(testPlayerID, "test_gem", 3);
        
        // Test 3: Check player inventory
        LogMessage("Test 3: Checking player inventory");
        uint gemCount = ext_get_quest_item_count(testPlayerID, "test_gem");
        LogMessage("Player has " + gemCount + " test gems");
        
        // Test 4: NPC requests quest items
        LogMessage("Test 4: NPC requests quest items");
        string testNPCID = "test_npc_001";
        uint delivered = ext_check_quest_item_qty("test_gem", testNPCID, 2);
        LogMessage("Delivered " + delivered + " gems to NPC");
        
        // Test 5: Check remaining inventory
        LogMessage("Test 5: Checking remaining inventory");
        gemCount = ext_get_quest_item_count(testPlayerID, "test_gem");
        LogMessage("Player now has " + gemCount + " test gems");
        
        // Test 6: Test specific item behavior (dynamite)
        LogMessage("Test 6: Testing dynamite behavior");
        ext_got_quest_item_player(testPlayerID, "stick_dynamite", 1);
        
        // Test 7: Dump all quest items
        LogMessage("Test 7: Dumping all quest items");
        ext_dump_quest_items();
        
        // Test 8: Integration system test
        LogMessage("Test 8: Testing integration system");
        QuestItemIntegration@ integration = GetQuestItemIntegration();
        integration.DumpStatus();
        
        // Test 9: Test NPC waiting system
        LogMessage("Test 9: Testing NPC waiting system");
        integration.RegisterNPCWaitingForItem("waiting_npc", "rare_item");
        ext_got_quest_item_player(testPlayerID, "rare_item", 1);
        
        // Test 10: Clear test data
        LogMessage("Test 10: Clearing test data");
        ext_clear_player_quest_items(testPlayerID);
        
        LogMessage("=== Quest Item System Test Complete ===");
    }
    
    /**
     * Test quest item persistence simulation
     */
    void TestQuestPersistence()
    {
        LogMessage("=== Quest Persistence Test ===");
        
        QuestTracker@ tracker = GetQuestTracker();
        string testPlayerID = "STEAM_0:1:99999";
        
        // Add some quest items
        tracker.PlayerFoundQuestItem(testPlayerID, "crystal_shard", 5);
        tracker.PlayerFoundQuestItem(testPlayerID, "dragon_scale", 2);
        tracker.PlayerFoundQuestItem(testPlayerID, "ancient_rune", 1);
        
        // Simulate save/load (this would use actual file I/O when available)
        tracker.DumpAllQuestItems();
        
        LogMessage("=== Quest Persistence Test Complete ===");
    }
    
    /**
     * Demonstrate quest item integration with legacy scripts
     */
    void TestLegacyIntegration()
    {
        LogMessage("=== Legacy Integration Test ===");
        
        QuestItemIntegration@ integration = GetQuestItemIntegration();
        string testPlayerID = "STEAM_0:1:54321";
        string testNPCID = "legacy_npc";
        
        // Simulate legacy quest item pickup
        legacy_quest_item_pickup(testPlayerID, "iron_ore");
        legacy_quest_item_pickup(testPlayerID, "iron_ore"); // Player finds 2
        
        // Simulate NPC waiting for the item
        legacy_npc_wait_for_item(testNPCID, "iron_ore");
        
        // Simulate NPC menu interaction
        bool success = legacy_npc_quest_check(testPlayerID, testNPCID, "iron_ore", 2);
        LogMessage("Legacy NPC quest check result: " + (success ? "SUCCESS" : "FAILED"));
        
        // Simulate spawning a quest item
        legacy_spawn_quest_item("gold_nugget", 100.0f, 200.0f, 300.0f);
        
        integration.DumpStatus();
        
        LogMessage("=== Legacy Integration Test Complete ===");
    }
    
    /**
     * Run all quest system tests
     */
    void RunAllQuestTests()
    {
        LogMessage("======================================");
        LogMessage("Starting Quest Item System Tests");
        LogMessage("======================================");
        
        TestQuestSystem();
        TestQuestPersistence();
        TestLegacyIntegration();
        
        LogMessage("======================================");
        LogMessage("All Quest Item System Tests Complete");
        LogMessage("======================================");
    }
}

// Auto-run tests when this module is loaded
void main()
{
    MS::RunAllQuestTests();
}