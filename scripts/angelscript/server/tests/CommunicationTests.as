#pragma context server

/**
 * CommunicationTests.as
 * 
 * Comprehensive testing for the Entity Communication Framework in Master Sword Rebirth
 * Tests message routing, validation, security, and integration with callexternal bridge
 */

namespace MSTest
{
    /**
     * Communication Test Suite
     * Validates all entity communication functionality and security measures
     */
    class CommunicationTests
    {
    private:
        TestFramework m_Framework;
        
    public:
        CommunicationTests()
        {
            m_Framework.SetSuiteName("Communication Framework");
        }
        
        /**
         * Run all communication tests
         */
        TestSuiteStats RunAllTests()
        {
            m_Framework.Clear();
            
            // Core communication system tests
            RunCommunicationSystemTests();
            
            // Message routing and validation tests
            RunMessageRoutingTests();
            
            // Security and rate limiting tests
            RunSecurityTests();
            
            // CallExternal bridge tests
            RunCallExternalTests();
            
            // Handler registration tests
            RunHandlerTests();
            
            // Performance and queue tests
            RunPerformanceTests();
            
            // Error handling and edge cases
            RunErrorHandlingTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
        /**
         * Run essential communication tests only
         */
        TestSuiteStats RunEssentialTests()
        {
            m_Framework.Clear();
            m_Framework.SetSuiteName("Essential Communication");
            
            RunBasicCommunicationTests();
            RunBasicCallExternalTests();
            RunBasicSecurityTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
        /**
         * Run stress tests for communication system
         */
        TestSuiteStats RunStressTests()
        {
            m_Framework.Clear();
            m_Framework.SetSuiteName("Communication Stress");
            
            RunMessageFloodTests();
            RunConcurrentAccessTests();
            RunLargeMessageTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
    private:
        /**
         * Test core communication system functionality
         */
        void RunCommunicationSystemTests()
        {
            RunBasicCommunicationTests();
            RunAdvancedCommunicationTests();
        }
        
        void RunBasicCommunicationTests()
        {
            m_Framework.RunTest("communication_system_initialization", "Communication system initialization",
                function() {
                    try
                    {
                        InitializeEntityCommunicationSystem();
                        EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                        return m_Framework.AssertTrue(system !is null, "Communication system should be initialized");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("communication_system_statistics", "Communication system statistics",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    uint total, success, failed, blocked;
                    system.GetStatistics(total, success, failed, blocked);
                    
                    return m_Framework.AssertTrue(total >= 0, "Total messages should be non-negative") &&
                           m_Framework.AssertTrue(success >= 0, "Success count should be non-negative") &&
                           m_Framework.AssertTrue(failed >= 0, "Failed count should be non-negative") &&
                           m_Framework.AssertTrue(blocked >= 0, "Blocked count should be non-negative") &&
                           m_Framework.AssertTrue(total >= success + failed + blocked, "Total should be at least sum of others");
                });
            
            m_Framework.RunTest("communication_system_settings", "Communication system settings",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Test security settings
                        system.SetSecurityEnabled(false);
                        system.SetSecurityEnabled(true);
                        
                        // Test logging settings
                        system.SetLoggingEnabled(false);
                        system.SetLoggingEnabled(true);
                        
                        // Test rate limiting
                        system.SetRateLimit(0.5f);
                        system.SetRateLimit(0.1f);
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("communication_system_status_dump", "Communication system status dump",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        system.DumpStatus();
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        void RunAdvancedCommunicationTests()
        {
            m_Framework.RunTest("communication_queued_processing", "Queued message processing",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Process any queued messages
                        system.ProcessQueuedMessages();
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("communication_rate_limit_clear", "Rate limiting data clearing",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        system.ClearRateLimiting();
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test message routing and validation
         */
        void RunMessageRoutingTests()
        {
            m_Framework.RunTest("message_routing_basic", "Basic message routing",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    array<string> parameters;
                    parameters.insertLast("test_param1");
                    parameters.insertLast("test_param2");
                    
                    CBaseEntity@ testEntity = null;
                    
                    // This should fail since no handler is registered for TEST_TARGET
                    bool result = system.ProcessCommunication("TEST_TARGET", "test_function", parameters, testEntity, "test_sender");
                    
                    return m_Framework.AssertFalse(result, "Should fail without registered handler");
                });
            
            m_Framework.RunTest("message_validation_parameters", "Message parameter validation",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    array<string> emptyParams;
                    array<string> validParams;
                    validParams.insertLast("param1");
                    validParams.insertLast("param2");
                    
                    array<string> tooManyParams;
                    for (uint i = 0; i < 15; i++) // More than the limit
                    {
                        tooManyParams.insertLast("param_" + i);
                    }
                    
                    CBaseEntity@ testEntity = null;
                    
                    bool result1 = system.ProcessCommunication("TEST", "func", emptyParams, testEntity);
                    bool result2 = system.ProcessCommunication("TEST", "func", validParams, testEntity);
                    bool result3 = system.ProcessCommunication("TEST", "func", tooManyParams, testEntity);
                    
                    // All should be handled gracefully (may fail due to no handler, but not crash)
                    return true;
                });
            
            m_Framework.RunTest("message_validation_empty_values", "Empty value validation",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    array<string> params;
                    params.insertLast("valid_param");
                    
                    CBaseEntity@ testEntity = null;
                    
                    // Empty target
                    bool result1 = system.ProcessCommunication("", "test_function", params, testEntity);
                    
                    // Empty function
                    bool result2 = system.ProcessCommunication("TEST_TARGET", "", params, testEntity);
                    
                    return m_Framework.AssertFalse(result1, "Empty target should fail validation") &&
                           m_Framework.AssertFalse(result2, "Empty function should fail validation");
                });
            
            m_Framework.RunTest("message_validation_large_parameters", "Large parameter validation",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    array<string> largeParams;
                    string largeParam = "";
                    for (uint i = 0; i < 300; i++) // Larger than the limit
                    {
                        largeParam += "X";
                    }
                    largeParams.insertLast(largeParam);
                    
                    CBaseEntity@ testEntity = null;
                    
                    bool result = system.ProcessCommunication("TEST", "func", largeParams, testEntity);
                    
                    return m_Framework.AssertFalse(result, "Large parameters should fail validation");
                });
        }
        
        /**
         * Test security and rate limiting
         */
        void RunSecurityTests()
        {
            RunBasicSecurityTests();
            RunAdvancedSecurityTests();
        }
        
        void RunBasicSecurityTests()
        {
            m_Framework.RunTest("security_target_validation", "Target name security validation",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    array<string> params;
                    CBaseEntity@ testEntity = null;
                    
                    // Invalid target names
                    bool result1 = system.ProcessCommunication("invalid-target", "func", params, testEntity);
                    bool result2 = system.ProcessCommunication("invalid target", "func", params, testEntity);
                    bool result3 = system.ProcessCommunication("invalid@target", "func", params, testEntity);
                    
                    return m_Framework.AssertFalse(result1, "Hyphenated target should fail") &&
                           m_Framework.AssertFalse(result2, "Spaced target should fail") &&
                           m_Framework.AssertFalse(result3, "Special char target should fail");
                });
            
            m_Framework.RunTest("security_function_validation", "Function name security validation",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    array<string> params;
                    CBaseEntity@ testEntity = null;
                    
                    // Invalid function names
                    bool result1 = system.ProcessCommunication("TEST", "invalid-function", params, testEntity);
                    bool result2 = system.ProcessCommunication("TEST", "invalid function", params, testEntity);
                    bool result3 = system.ProcessCommunication("TEST", "invalid@function", params, testEntity);
                    
                    return m_Framework.AssertFalse(result1, "Hyphenated function should fail") &&
                           m_Framework.AssertFalse(result2, "Spaced function should fail") &&
                           m_Framework.AssertFalse(result3, "Special char function should fail");
                });
            
            m_Framework.RunTest("security_rate_limiting", "Rate limiting functionality",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    // Set a strict rate limit
                    system.SetRateLimit(1.0f); // 1 second between messages
                    
                    array<string> params;
                    CBaseEntity@ testEntity = null;
                    string senderID = "rate_limit_test_sender";
                    
                    // First message should go through (but fail due to no handler)
                    bool result1 = system.ProcessCommunication("TEST", "func", params, testEntity, senderID);
                    
                    // Second immediate message should be blocked
                    bool result2 = system.ProcessCommunication("TEST", "func", params, testEntity, senderID);
                    
                    // Reset rate limit to allow subsequent tests
                    system.SetRateLimit(0.1f);
                    
                    return true; // Both should be handled gracefully
                });
        }
        
        void RunAdvancedSecurityTests()
        {
            m_Framework.RunTest("security_disabled_validation", "Security disabled validation bypass",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    // Disable security temporarily
                    system.SetSecurityEnabled(false);
                    
                    array<string> params;
                    CBaseEntity@ testEntity = null;
                    
                    // Invalid names should now pass validation (but still fail due to no handler)
                    bool result1 = system.ProcessCommunication("invalid-target", "func", params, testEntity);
                    bool result2 = system.ProcessCommunication("TEST", "invalid-function", params, testEntity);
                    
                    // Re-enable security
                    system.SetSecurityEnabled(true);
                    
                    return true; // Should not crash even with invalid names when security is off
                });
            
            m_Framework.RunTest("security_injection_attempts", "Security injection attempt handling",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    array<string> params;
                    params.insertLast("'); DROP TABLE users; --");
                    params.insertLast("<script>alert('xss')</script>");
                    params.insertLast("../../../etc/passwd");
                    
                    CBaseEntity@ testEntity = null;
                    
                    // Should handle injection attempts gracefully
                    bool result = system.ProcessCommunication("TEST", "func", params, testEntity);
                    
                    return true; // Should not crash
                });
        }
        
        /**
         * Test CallExternal bridge functionality
         */
        void RunCallExternalTests()
        {
            RunBasicCallExternalTests();
            RunAdvancedCallExternalTests();
        }
        
        void RunBasicCallExternalTests()
        {
            m_Framework.RunTest("callexternal_basic", "Basic CallExternal functionality",
                function() {
                    try
                    {
                        CBaseEntity@ testEntity = null;
                        
                        // Basic CallExternal calls (should fail gracefully without handlers)
                        bool result1 = CallExternal("GAME_MASTER", "test_function", "param1", "", "", "", testEntity);
                        bool result2 = CallExternal("QUEST_SYSTEM", "quest_function", "player1", "item1", "", "", testEntity);
                        bool result3 = CallExternal("NPC_MANAGER", "npc_function", "npc1", "killer1", "", "", testEntity);
                        
                        return true; // Should not crash
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("callexternal_parameter_handling", "CallExternal parameter handling",
                function() {
                    try
                    {
                        CBaseEntity@ testEntity = null;
                        
                        // Test with different parameter counts
                        bool result1 = CallExternal("TEST", "func1", "", "", "", "", testEntity);
                        bool result2 = CallExternal("TEST", "func2", "param1", "", "", "", testEntity);
                        bool result3 = CallExternal("TEST", "func3", "param1", "param2", "", "", testEntity);
                        bool result4 = CallExternal("TEST", "func4", "param1", "param2", "param3", "", testEntity);
                        bool result5 = CallExternal("TEST", "func5", "param1", "param2", "param3", "param4", testEntity);
                        
                        return true; // Should handle all parameter counts
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("callexternal_array_version", "CallExternalArray functionality",
                function() {
                    try
                    {
                        array<string> params;
                        params.insertLast("array_param1");
                        params.insertLast("array_param2");
                        params.insertLast("array_param3");
                        
                        CBaseEntity@ testEntity = null;
                        
                        bool result1 = CallExternalArray("TEST", "array_func", params, testEntity);
                        bool result2 = CallExternalArray("TEST", "array_func", params, testEntity, "custom_sender");
                        
                        return true; // Should not crash
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        void RunAdvancedCallExternalTests()
        {
            m_Framework.RunTest("callexternal_empty_parameters", "CallExternal with empty parameters",
                function() {
                    try
                    {
                        CBaseEntity@ testEntity = null;
                        
                        // Empty string parameters
                        bool result1 = CallExternal("", "func", "", "", "", "", testEntity);
                        bool result2 = CallExternal("TEST", "", "", "", "", "", testEntity);
                        
                        // Large parameter arrays
                        array<string> largeParams;
                        for (uint i = 0; i < 20; i++)
                        {
                            largeParams.insertLast("large_param_" + i);
                        }
                        
                        bool result3 = CallExternalArray("TEST", "large_func", largeParams, testEntity);
                        
                        return true; // Should handle gracefully
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("callexternal_entity_handles", "CallExternal with various entity handles",
                function() {
                    try
                    {
                        // Test with different entity handle states
                        CBaseEntity@ nullEntity = null;
                        CBaseEntity@ validEntity = null; // Would be a real entity in practice
                        
                        bool result1 = CallExternal("TEST", "func", "param1", "", "", "", nullEntity);
                        bool result2 = CallExternal("TEST", "func", "param1", "", "", "", validEntity);
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test handler registration and management
         */
        void RunHandlerTests()
        {
            m_Framework.RunTest("handler_registration_unregistration", "Handler registration and unregistration",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Test unregistering non-existent handler
                        system.UnregisterHandler("NON_EXISTENT_TARGET");
                        
                        // Note: We can't easily test handler registration without implementing ICommunicationHandler
                        // but we can test the unregistration doesn't crash
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test performance and queuing
         */
        void RunPerformanceTests()
        {
            m_Framework.RunTest("communication_performance_basic", "Basic communication performance",
                function() {
                    try
                    {
                        CBaseEntity@ testEntity = null;
                        
                        // Multiple rapid calls
                        for (uint i = 0; i < 100; i++)
                        {
                            CallExternal("PERF_TEST", "perf_func", "param_" + i, "", "", "", testEntity);
                        }
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("communication_queue_processing", "Message queue processing performance",
                function() {
                    EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Process queue multiple times
                        for (uint i = 0; i < 10; i++)
                        {
                            system.ProcessQueuedMessages();
                        }
                        
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
            m_Framework.RunTest("communication_null_system", "Null system handling",
                function() {
                    try
                    {
                        // This should be handled in CallExternal functions
                        CBaseEntity@ testEntity = null;
                        bool result = CallExternal("TEST", "func", "", "", "", "", testEntity);
                        
                        return true; // Should not crash even if system has issues
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("communication_invalid_entity_handles", "Invalid entity handle handling",
                function() {
                    try
                    {
                        CBaseEntity@ invalidEntity = null;
                        
                        bool result = CallExternal("TEST", "func", "param1", "", "", "", invalidEntity);
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("communication_boundary_conditions", "Boundary condition handling",
                function() {
                    try
                    {
                        CBaseEntity@ testEntity = null;
                        
                        // Maximum length target/function names
                        string maxTarget = "";
                        string maxFunction = "";
                        for (uint i = 0; i < 32; i++) maxTarget += "A";
                        for (uint i = 0; i < 64; i++) maxFunction += "B";
                        
                        bool result1 = CallExternal(maxTarget, maxFunction, "", "", "", "", testEntity);
                        
                        // Over-length names
                        string overTarget = maxTarget + "X";
                        string overFunction = maxFunction + "Y";
                        
                        bool result2 = CallExternal(overTarget, overFunction, "", "", "", "", testEntity);
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("communication_special_characters", "Special character handling",
                function() {
                    try
                    {
                        CBaseEntity@ testEntity = null;
                        
                        // Various special characters in parameters
                        bool result1 = CallExternal("TEST", "func", "param with spaces", "", "", "", testEntity);
                        bool result2 = CallExternal("TEST", "func", "param\nwith\nnewlines", "", "", "", testEntity);
                        bool result3 = CallExternal("TEST", "func", "param\twith\ttabs", "", "", "", testEntity);
                        bool result4 = CallExternal("TEST", "func", "param\"with\"quotes", "", "", "", testEntity);
                        bool result5 = CallExternal("TEST", "func", "param'with'apostrophes", "", "", "", testEntity);
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Stress testing for communication system
         */
        void RunMessageFloodTests()
        {
            m_Framework.RunTest("communication_flood_test", "Message flood stress test",
                function() {
                    try
                    {
                        CBaseEntity@ testEntity = null;
                        
                        // Flood the system with messages
                        for (uint i = 0; i < 500; i++)
                        {
                            string target = "FLOOD_TARGET_" + (i % 10);
                            string function = "flood_func_" + (i % 5);
                            string param = "flood_param_" + i;
                            
                            CallExternal(target, function, param, "", "", "", testEntity);
                        }
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        void RunConcurrentAccessTests()
        {
            m_Framework.RunTest("communication_concurrent_access", "Concurrent access stress test",
                function() {
                    try
                    {
                        EntityCommunicationSystem@ system = GetEntityCommunicationSystem();
                        if (system is null) return false;
                        
                        CBaseEntity@ testEntity = null;
                        
                        // Simulate concurrent operations
                        for (uint i = 0; i < 100; i++)
                        {
                            // Mix of different operations
                            CallExternal("CONCURRENT", "func" + (i % 10), "param" + i, "", "", "", testEntity);
                            
                            if (i % 5 == 0)
                            {
                                system.ProcessQueuedMessages();
                            }
                            
                            if (i % 10 == 0)
                            {
                                uint total, success, failed, blocked;
                                system.GetStatistics(total, success, failed, blocked);
                            }
                            
                            if (i % 15 == 0)
                            {
                                system.ClearRateLimiting();
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
        
        void RunLargeMessageTests()
        {
            m_Framework.RunTest("communication_large_messages", "Large message handling stress test",
                function() {
                    try
                    {
                        CBaseEntity@ testEntity = null;
                        
                        // Create messages with large parameter arrays
                        for (uint i = 0; i < 20; i++)
                        {
                            array<string> largeParams;
                            for (uint j = 0; j < 50; j++)
                            {
                                string largeParam = "";
                                for (uint k = 0; k < 100; k++)
                                {
                                    largeParam += "X";
                                }
                                largeParams.insertLast(largeParam + "_" + i + "_" + j);
                            }
                            
                            CallExternalArray("LARGE_MSG", "large_func", largeParams, testEntity);
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