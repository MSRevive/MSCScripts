/**
 * EntityCommunicationInit.as
 * 
 * Initialization and integration helper for the Entity Communication System.
 * This file sets up the communication framework and connects it with all the
 * existing game systems (QuestTracker, CriticalNPCManager, AdminSystem, etc.).
 * 
 * This should be called from GameMasterInit.as to ensure proper initialization order.
 */

#include "admin/EntityCommunicationSystem.as"
#include "admin/CallExternalBridge.as"
#include "player/QuestTracker.as"
#include "world/CriticalNPCManager.as"
#include "triggers/AdvancedTriggerSystem.as"

namespace MS
{
    /**
     * Initialize the complete entity communication framework
     * Call this from the main Game Master initialization
     */
    void InitializeEntityCommunications()
    {
        LogMessage("[INFO] EntityCommunicationInit: Starting entity communication framework initialization");
        
        try
        {
            // Step 1: Initialize the core communication system
            LogMessage("[INFO] EntityCommunicationInit: [1/4] Initializing communication system");
            InitializeEntityCommunicationSystem();
            
            // Step 2: Initialize the legacy compatibility bridge
            LogMessage("[INFO] EntityCommunicationInit: [2/4] Initializing legacy compatibility bridge");
            InitializeCallExternalBridge();
            
            // Step 3: Register additional system handlers
            LogMessage("[INFO] EntityCommunicationInit: [3/4] Registering system handlers");
            RegisterSystemHandlers();
            
            // Step 4: Validate initialization
            LogMessage("[INFO] EntityCommunicationInit: [4/4] Validating initialization");
            ValidateInitialization();
            
            LogMessage("[INFO] EntityCommunicationInit: Entity communication framework initialized successfully");
            
            // Dump system status for verification
            EntityCommunicationSystem@ commSystem = GetEntityCommunicationSystem();
            if (commSystem !is null)
            {
                commSystem.DumpStatus();
            }
        }
        catch
        {
            LogMessage("[ERROR] EntityCommunicationInit: Failed to initialize entity communication framework");
        }
    }
    
    /**
     * Shutdown the entity communication framework
     */
    void ShutdownEntityCommunications()
    {
        LogMessage("[INFO] EntityCommunicationInit: Shutting down entity communication framework");
        
        try
        {
            // Shutdown in reverse order
            ShutdownCallExternalBridge();
            ShutdownEntityCommunicationSystem();
            
            LogMessage("[INFO] EntityCommunicationInit: Entity communication framework shutdown complete");
        }
        catch
        {
            LogMessage("[ERROR] EntityCommunicationInit: Error during communication framework shutdown");
        }
    }
    
    /**
     * Register handlers for additional systems
     */
    void RegisterSystemHandlers()
    {
        EntityCommunicationSystem@ commSystem = GetEntityCommunicationSystem();
        if (commSystem is null)
        {
            LogMessage("[ERROR] EntityCommunicationInit: Communication system not available for handler registration");
            return;
        }
        
        // Additional handlers could be registered here for future systems
        // For now, the Game Master handler covers most functionality
        
        LogMessage("[INFO] EntityCommunicationInit: System handlers registered");
    }
    
    /**
     * Validate that the communication system is working correctly
     */
    void ValidateInitialization()
    {
        EntityCommunicationSystem@ commSystem = GetEntityCommunicationSystem();
        if (commSystem is null)
        {
            LogMessage("[ERROR] EntityCommunicationInit: Communication system validation failed - system is null");
            return;
        }
        
        // Test basic functionality
        array<string> testParams = { "test_item" };
        bool testResult = commSystem.ProcessCommunication("GAME_MASTER", "ext_got_quest_item", 
                                                          testParams, EntityHandle(), "validation_test");
        
        if (testResult)
        {
            LogMessage("[INFO] EntityCommunicationInit: Communication system validation passed");
        }
        else
        {
            LogMessage("[WARNING] EntityCommunicationInit: Communication system validation failed - test message not processed");
        }
        
        // Get statistics
        uint nTotal, nSuccess, nFailed, nBlocked;
        commSystem.GetStatistics(nTotal, nSuccess, nFailed, nBlocked);
        LogMessage("[INFO] EntityCommunicationInit: Validation stats - Total: " + nTotal + 
                  ", Success: " + nSuccess + ", Failed: " + nFailed + ", Blocked: " + nBlocked);
    }
    
    /**
     * Test the communication system with various scenarios
     * This can be called by admin commands for debugging
     */
    void TestCommunicationSystem()
    {
        LogMessage("[INFO] EntityCommunicationInit: Running communication system tests");
        
        EntityCommunicationSystem@ commSystem = GetEntityCommunicationSystem();
        if (commSystem is null)
        {
            LogMessage("[ERROR] EntityCommunicationInit: Cannot test - communication system not available");
            return;
        }
        
        uint nTestsPassed = 0;
        uint nTestsTotal = 0;
        
        // Test 1: Quest item found
        nTestsTotal++;
        array<string> questParams = { "test_item_1" };
        if (commSystem.ProcessCommunication("GAME_MASTER", "ext_got_quest_item", questParams, EntityHandle(), "test_player_1"))
        {
            nTestsPassed++;
            LogMessage("[INFO] Test 1 PASSED: Quest item found");
        }
        else
        {
            LogMessage("[ERROR] Test 1 FAILED: Quest item found");
        }
        
        // Test 2: Critical NPC death
        nTestsTotal++;
        array<string> npcParams = { "test_npc_1", "test_player_1" };
        if (commSystem.ProcessCommunication("GAME_MASTER", "gm_crit_npc_died", npcParams, EntityHandle(), "test_npc_1"))
        {
            nTestsPassed++;
            LogMessage("[INFO] Test 2 PASSED: Critical NPC death");
        }
        else
        {
            LogMessage("[ERROR] Test 2 FAILED: Critical NPC death");
        }
        
        // Test 3: Invalid target (should fail)
        nTestsTotal++;
        array<string> invalidParams = { "test" };
        if (!commSystem.ProcessCommunication("INVALID_TARGET", "test_function", invalidParams, EntityHandle(), "test_sender"))
        {
            nTestsPassed++;
            LogMessage("[INFO] Test 3 PASSED: Invalid target properly rejected");
        }
        else
        {
            LogMessage("[ERROR] Test 3 FAILED: Invalid target not rejected");
        }
        
        // Test 4: Rate limiting (send multiple messages quickly)
        nTestsTotal++;
        commSystem.SetRateLimit(1.0f); // 1 second rate limit
        
        array<string> rateParams = { "rate_test_1" };
        bool firstResult = commSystem.ProcessCommunication("GAME_MASTER", "ext_got_quest_item", rateParams, EntityHandle(), "rate_test_sender");
        bool secondResult = commSystem.ProcessCommunication("GAME_MASTER", "ext_got_quest_item", rateParams, EntityHandle(), "rate_test_sender");
        
        if (firstResult && !secondResult)
        {
            nTestsPassed++;
            LogMessage("[INFO] Test 4 PASSED: Rate limiting working correctly");
        }
        else
        {
            LogMessage("[ERROR] Test 4 FAILED: Rate limiting not working correctly");
        }
        
        // Reset rate limit
        commSystem.SetRateLimit(0.1f);
        commSystem.ClearRateLimiting();
        
        // Test 5: Legacy callexternal function
        nTestsTotal++;
        if (callexternal("GAME_MASTER", "ext_got_quest_item", "legacy_test_item"))
        {
            nTestsPassed++;
            LogMessage("[INFO] Test 5 PASSED: Legacy callexternal function");
        }
        else
        {
            LogMessage("[ERROR] Test 5 FAILED: Legacy callexternal function");
        }
        
        // Report results
        LogMessage("[INFO] EntityCommunicationInit: Communication system tests complete");
        LogMessage("[INFO] Tests passed: " + nTestsPassed + "/" + nTestsTotal);
        
        if (nTestsPassed == nTestsTotal)
        {
            LogMessage("[INFO] EntityCommunicationInit: All tests PASSED - system is working correctly");
        }
        else
        {
            LogMessage("[WARNING] EntityCommunicationInit: Some tests FAILED - system may have issues");
        }
        
        // Get final statistics
        uint nTotal, nSuccess, nFailed, nBlocked;
        commSystem.GetStatistics(nTotal, nSuccess, nFailed, nBlocked);
        LogMessage("[INFO] EntityCommunicationInit: Final test stats - Total: " + nTotal + 
                  ", Success: " + nSuccess + ", Failed: " + nFailed + ", Blocked: " + nBlocked);
    }
    
    /**
     * Get communication system status for admin commands
     */
    void GetCommunicationStatus()
    {
        LogMessage("[INFO] EntityCommunicationInit: === COMMUNICATION SYSTEM STATUS ===");
        
        EntityCommunicationSystem@ commSystem = GetEntityCommunicationSystem();
        if (commSystem !is null)
        {
            uint nTotal, nSuccess, nFailed, nBlocked;
            commSystem.GetStatistics(nTotal, nSuccess, nFailed, nBlocked);
            
            LogMessage("[INFO] Communication System: ACTIVE");
            LogMessage("[INFO] Total Messages: " + nTotal);
            LogMessage("[INFO] Successful: " + nSuccess);
            LogMessage("[INFO] Failed: " + nFailed);
            LogMessage("[INFO] Blocked: " + nBlocked);
            
            if (nTotal > 0)
            {
                float successRate = (float(nSuccess) / float(nTotal)) * 100.0f;
                LogMessage("[INFO] Success Rate: " + successRate + "%");
            }
        }
        else
        {
            LogMessage("[ERROR] Communication System: NOT AVAILABLE");
        }
        
        // Game Master handler status
        uint gmHandlerStats = GetGameMasterHandlerStats();
        LogMessage("[INFO] Game Master Handler Messages: " + gmHandlerStats);
        
        LogMessage("[INFO] === END COMMUNICATION STATUS ===");
    }
    
    /**
     * Configure communication system settings
     * Can be called with admin commands to adjust behavior
     */
    void ConfigureCommunicationSystem(float flRateLimit = 0.1f, bool bSecurityEnabled = true, bool bLoggingEnabled = true)
    {
        EntityCommunicationSystem@ commSystem = GetEntityCommunicationSystem();
        if (commSystem is null)
        {
            LogMessage("[ERROR] EntityCommunicationInit: Cannot configure - communication system not available");
            return;
        }
        
        commSystem.SetRateLimit(flRateLimit);
        commSystem.SetSecurityEnabled(bSecurityEnabled);
        commSystem.SetLoggingEnabled(bLoggingEnabled);
        
        LogMessage("[INFO] EntityCommunicationInit: System configured - Rate Limit: " + flRateLimit + 
                  "s, Security: " + (bSecurityEnabled ? "ON" : "OFF") + 
                  ", Logging: " + (bLoggingEnabled ? "ON" : "OFF"));
    }
    
    /**
     * Emergency reset of the communication system
     * Can be called if the system gets into a bad state
     */
    void ResetCommunicationSystem()
    {
        LogMessage("[WARNING] EntityCommunicationInit: Performing emergency reset of communication system");
        
        try
        {
            // Shutdown current system
            ShutdownEntityCommunications();
            
            // Wait a moment (in real implementation, this would be a timer)
            // For now, just reinitialize immediately
            
            // Reinitialize
            InitializeEntityCommunications();
            
            LogMessage("[INFO] EntityCommunicationInit: Communication system reset complete");
        }
        catch
        {
            LogMessage("[ERROR] EntityCommunicationInit: Failed to reset communication system");
        }
    }
    
    // External interface functions for integration with other systems
    
    /**
     * Send a quest item found message (convenience function)
     */
    bool SendQuestItemFound(const string &in szItemType, const string &in szPlayerID)
    {
        return CallExternal("GAME_MASTER", "ext_got_quest_item", szItemType, "", "", "", EntityHandle());
    }
    
    /**
     * Send a critical NPC death message (convenience function)
     */
    bool SendCriticalNPCDeath(const string &in szNPCID, const string &in szKillerID)
    {
        return CallExternal("GAME_MASTER", "gm_crit_npc_died", szNPCID, szKillerID);
    }
    
    /**
     * Send an admin command message (convenience function)
     */
    bool SendAdminCommand(const string &in szCommand, const array<string> &in args)
    {
        return CallExternalArray("GAME_MASTER", "admin_command", args, EntityHandle());
    }
    
    /**
     * Send a trigger activation message (convenience function)
     */
    bool SendTriggerActivation(const string &in szTriggerName, const string &in szActivatorID)
    {
        return CallExternal("GAME_MASTER", "trigger_activate", szTriggerName, szActivatorID);
    }
}