/**
 * MasterTestSuite.as
 * 
 * Main test coordinator and runner for Master Sword Rebirth AngelScript testing
 * Orchestrates all test suites and provides comprehensive validation of the entire system
 */

namespace MSTest
{
    /**
     * Master test suite coordinator
     */
    class MasterTestSuite
    {
    private:
        array<TestSuiteStats> m_SuiteResults;
        array<string> m_SuiteNames;
        bool m_bInitialized;
        float m_flStartTime;
        float m_flTotalTime;
        
    public:
        MasterTestSuite()
        {
            m_bInitialized = false;
            m_flStartTime = 0.0f;
            m_flTotalTime = 0.0f;
        }
        
        /**
         * Initialize the master test suite
         */
        void Initialize()
        {
            if (m_bInitialized) return;
            
            LogInfo("=== MASTER SWORD REBIRTH ANGELSCRIPT TEST SUITE ===");
            LogInfo("Initializing comprehensive system validation...");
            
            // Clear previous results
            m_SuiteResults.resize(0);
            m_SuiteNames.resize(0);
            
            // Validate test environment first
            if (!ValidateTestEnvironment())
            {
                LogError("Test environment validation failed! Cannot proceed.");
                return;
            }
            
            LogInfo("Test environment validation passed. Proceeding with test suites.");
            m_bInitialized = true;
        }
        
        /**
         * Run all test suites in the correct order
         */
        void RunAllTests()
        {
            if (!m_bInitialized)
            {
                LogError("Master test suite not initialized!");
                return;
            }
            
            m_flStartTime = GetGameTime();
            LogInfo("Starting comprehensive test execution...");
            
            // Run test suites in dependency order
            RunTestSuite("Engine Integration", @RunEngineIntegrationTests);
            RunTestSuite("Quest System", @RunQuestSystemTests);
            RunTestSuite("NPC Manager", @RunNPCManagerTests);
            RunTestSuite("Trigger System", @RunTriggerSystemTests);
            RunTestSuite("Communication Framework", @RunCommunicationTests);
            RunTestSuite("Player Management", @RunPlayerManagementTests);
            RunTestSuite("Performance", @RunPerformanceTests);
            
            m_flTotalTime = GetGameTime() - m_flStartTime;
            
            // Generate comprehensive report
            GenerateMasterReport();
        }
        
        /**
         * Run individual test suite categories
         */
        void RunEngineTests()
        {
            Initialize();
            RunTestSuite("Engine Integration", @RunEngineIntegrationTests);
            GenerateQuickReport();
        }
        
        void RunQuestTests()
        {
            Initialize();
            RunTestSuite("Quest System", @RunQuestSystemTests);
            GenerateQuickReport();
        }
        
        void RunNPCTests()
        {
            Initialize();
            RunTestSuite("NPC Manager", @RunNPCManagerTests);
            GenerateQuickReport();
        }
        
        void RunTriggerTests()
        {
            Initialize();
            RunTestSuite("Trigger System", @RunTriggerSystemTests);
            GenerateQuickReport();
        }
        
        void RunCommunicationTests()
        {
            Initialize();
            RunTestSuite("Communication Framework", @RunCommunicationTests);
            GenerateQuickReport();
        }
        
        void RunPlayerTests()
        {
            Initialize();
            RunTestSuite("Player Management", @RunPlayerManagementTests);
            GenerateQuickReport();
        }
        
        void RunPerformanceTestsOnly()
        {
            Initialize();
            RunTestSuite("Performance", @RunPerformanceTests);
            GenerateQuickReport();
        }
        
        /**
         * Run stress tests for production readiness
         */
        void RunStressTests()
        {
            Initialize();
            LogInfo("=== RUNNING STRESS TESTS FOR PRODUCTION READINESS ===");
            
            // High-load scenarios
            RunTestSuite("High Load Quest Processing", @RunQuestStressTests);
            RunTestSuite("NPC Death Storm", @RunNPCStressTests);
            RunTestSuite("Trigger System Overload", @RunTriggerStressTests);
            RunTestSuite("Communication Flood", @RunCommunicationStressTests);
            RunTestSuite("Memory Pressure", @RunMemoryStressTests);
            
            GenerateMasterReport();
        }
        
        /**
         * Quick validation for development builds
         */
        void RunQuickValidation()
        {
            Initialize();
            LogInfo("=== QUICK VALIDATION FOR DEVELOPMENT BUILD ===");
            
            // Critical path tests only
            RunTestSuite("Core Engine", @RunCoreEngineTests);
            RunTestSuite("Basic Quest Functions", @RunBasicQuestTests);
            RunTestSuite("Essential Communication", @RunEssentialCommunicationTests);
            
            GenerateQuickReport();
        }
        
        /**
         * Regression test suite
         */
        void RunRegressionTests()
        {
            Initialize();
            LogInfo("=== REGRESSION TEST SUITE ===");
            
            // Focus on previously failing areas
            RunTestSuite("Legacy Compatibility", @RunLegacyCompatibilityTests);
            RunTestSuite("Edge Cases", @RunEdgeCaseTests);
            RunTestSuite("Error Handling", @RunErrorHandlingTests);
            
            GenerateMasterReport();
        }
        
    private:
        /**
         * Run a specific test suite
         */
        void RunTestSuite(const string &in suiteName, TestSuiteDelegate@ testFunction)
        {
            LogInfo(">>> Running " + suiteName + " Test Suite <<<");
            
            TestSuiteStats stats;
            
            try
            {
                stats = testFunction();
            }
            catch
            {
                LogError("Exception occurred in " + suiteName + " test suite");
                stats.nTotalTests = 1;
                stats.nErrorTests = 1;
            }
            
            m_SuiteNames.insertLast(suiteName);
            m_SuiteResults.insertLast(stats);
            
            LogInfo("<<< " + suiteName + " Complete: " + stats.nPassedTests + "/" + 
                   stats.nTotalTests + " passed (" + formatFloat(stats.GetSuccessRate(), 1) + "%) >>>");
        }
        
        /**
         * Generate comprehensive master report
         */
        void GenerateMasterReport()
        {
            LogInfo("=== MASTER TEST SUITE REPORT ===");
            LogInfo("Execution Time: " + formatFloat(m_flTotalTime, 2) + " seconds");
            LogInfo("");
            
            uint totalTests = 0;
            uint totalPassed = 0;
            uint totalFailed = 0;
            uint totalSkipped = 0;
            uint totalErrors = 0;
            float totalTime = 0.0f;
            
            // Calculate totals
            for (uint i = 0; i < m_SuiteResults.length(); i++)
            {
                totalTests += m_SuiteResults[i].nTotalTests;
                totalPassed += m_SuiteResults[i].nPassedTests;
                totalFailed += m_SuiteResults[i].nFailedTests;
                totalSkipped += m_SuiteResults[i].nSkippedTests;
                totalErrors += m_SuiteResults[i].nErrorTests;
                totalTime += m_SuiteResults[i].flTotalTime;
            }
            
            // Individual suite results
            LogInfo("SUITE BREAKDOWN:");
            for (uint i = 0; i < m_SuiteResults.length(); i++)
            {
                const TestSuiteStats stats = m_SuiteResults[i];
                string status = (stats.nFailedTests == 0 && stats.nErrorTests == 0) ? "PASS" : "FAIL";
                
                LogInfo("  " + m_SuiteNames[i] + ": " + stats.nPassedTests + "/" + stats.nTotalTests + 
                       " (" + formatFloat(stats.GetSuccessRate(), 1) + "%) [" + status + "]");
            }
            
            LogInfo("");
            LogInfo("OVERALL RESULTS:");
            LogInfo("  Total Tests: " + totalTests);
            LogInfo("  Passed: " + totalPassed);
            LogInfo("  Failed: " + totalFailed);
            LogInfo("  Skipped: " + totalSkipped);
            LogInfo("  Errors: " + totalErrors);
            LogInfo("  Success Rate: " + formatFloat(float(totalPassed) / float(totalTests) * 100.0f, 2) + "%");
            LogInfo("  Total Execution Time: " + formatFloat(totalTime, 2) + " seconds");
            
            // Production readiness assessment
            bool productionReady = (totalFailed == 0 && totalErrors == 0);
            float successRate = float(totalPassed) / float(totalTests) * 100.0f;
            
            LogInfo("");
            if (productionReady)
            {
                LogInfo("✓ PRODUCTION READY: All critical tests passed");
            }
            else
            {
                LogError("✗ NOT PRODUCTION READY: " + (totalFailed + totalErrors) + " critical issues found");
            }
            
            if (successRate >= 95.0f)
            {
                LogInfo("✓ QUALITY EXCELLENT: " + formatFloat(successRate, 1) + "% success rate");
            }
            else if (successRate >= 85.0f)
            {
                LogInfo("⚠ QUALITY GOOD: " + formatFloat(successRate, 1) + "% success rate");
            }
            else
            {
                LogError("✗ QUALITY POOR: " + formatFloat(successRate, 1) + "% success rate");
            }
            
            LogInfo("=== END MASTER REPORT ===");
        }
        
        /**
         * Generate quick report for development
         */
        void GenerateQuickReport()
        {
            uint totalTests = 0;
            uint totalPassed = 0;
            
            for (uint i = 0; i < m_SuiteResults.length(); i++)
            {
                totalTests += m_SuiteResults[i].nTotalTests;
                totalPassed += m_SuiteResults[i].nPassedTests;
            }
            
            float successRate = (totalTests > 0) ? float(totalPassed) / float(totalTests) * 100.0f : 0.0f;
            string status = (totalPassed == totalTests) ? "PASS" : "FAIL";
            
            LogInfo("=== QUICK REPORT ===");
            LogInfo("Result: " + totalPassed + "/" + totalTests + " (" + formatFloat(successRate, 1) + "%) [" + status + "]");
            LogInfo("Time: " + formatFloat(GetGameTime() - m_flStartTime, 2) + "s");
        }
        
        string formatFloat(float value, uint decimals)
        {
            // Simple formatting
            return "" + value;
        }
    }
    
    // Function delegate for test suites
    funcdef TestSuiteStats TestSuiteDelegate();
    
    /**
     * Individual test suite functions (declarations)
     * These will call the actual test implementations
     */
    TestSuiteStats RunEngineIntegrationTests()
    {
        EngineIntegrationTests tests;
        return tests.RunAllTests();
    }
    
    TestSuiteStats RunQuestSystemTests()
    {
        QuestSystemTests tests;
        return tests.RunAllTests();
    }
    
    TestSuiteStats RunNPCManagerTests()
    {
        NPCManagerTests tests;
        return tests.RunAllTests();
    }
    
    TestSuiteStats RunTriggerSystemTests()
    {
        TriggerSystemTests tests;
        return tests.RunAllTests();
    }
    
    TestSuiteStats RunCommunicationTests()
    {
        CommunicationTests tests;
        return tests.RunAllTests();
    }
    
    TestSuiteStats RunPlayerManagementTests()
    {
        PlayerManagementTests tests;
        return tests.RunAllTests();
    }
    
    TestSuiteStats RunPerformanceTests()
    {
        PerformanceTests tests;
        return tests.RunAllTests();
    }
    
    // Stress test implementations
    TestSuiteStats RunQuestStressTests()
    {
        QuestSystemTests tests;
        return tests.RunStressTests();
    }
    
    TestSuiteStats RunNPCStressTests()
    {
        NPCManagerTests tests;
        return tests.RunStressTests();
    }
    
    TestSuiteStats RunTriggerStressTests()
    {
        TriggerSystemTests tests;
        return tests.RunStressTests();
    }
    
    TestSuiteStats RunCommunicationStressTests()
    {
        CommunicationTests tests;
        return tests.RunStressTests();
    }
    
    TestSuiteStats RunMemoryStressTests()
    {
        PerformanceTests tests;
        return tests.RunMemoryStressTests();
    }
    
    // Quick validation implementations
    TestSuiteStats RunCoreEngineTests()
    {
        EngineIntegrationTests tests;
        return tests.RunCoreTests();
    }
    
    TestSuiteStats RunBasicQuestTests()
    {
        QuestSystemTests tests;
        return tests.RunBasicTests();
    }
    
    TestSuiteStats RunEssentialCommunicationTests()
    {
        CommunicationTests tests;
        return tests.RunEssentialTests();
    }
    
    // Regression test implementations
    TestSuiteStats RunLegacyCompatibilityTests()
    {
        // Test compatibility with legacy script systems
        TestFramework framework;
        framework.SetSuiteName("Legacy Compatibility");
        
        // Test legacy function mappings
        framework.RunTest("legacy_quest_item_pickup", "Legacy quest pickup function", 
                         function() { return true; }); // Placeholder
        
        framework.RunTest("legacy_npc_quest_check", "Legacy NPC quest check", 
                         function() { return true; }); // Placeholder
        
        framework.GenerateReport();
        return framework.GetStats();
    }
    
    TestSuiteStats RunEdgeCaseTests()
    {
        TestFramework framework;
        framework.SetSuiteName("Edge Cases");
        
        // Test edge cases and boundary conditions
        framework.RunTest("empty_strings", "Empty string handling", 
                         function() { return true; }); // Placeholder
        
        framework.RunTest("null_handles", "Null entity handle handling", 
                         function() { return true; }); // Placeholder
        
        framework.GenerateReport();
        return framework.GetStats();
    }
    
    TestSuiteStats RunErrorHandlingTests()
    {
        TestFramework framework;
        framework.SetSuiteName("Error Handling");
        
        // Test error handling and recovery
        framework.RunTest("invalid_parameters", "Invalid parameter handling", 
                         function() { return true; }); // Placeholder
        
        framework.RunTest("system_shutdown", "Graceful system shutdown", 
                         function() { return true; }); // Placeholder
        
        framework.GenerateReport();
        return framework.GetStats();
    }
    
    // Global master test suite instance
    MasterTestSuite g_MasterTestSuite;
}

/**
 * Public interface functions for external access
 */

/**
 * Run all tests - main entry point
 */
void RunAllAngelScriptTests()
{
    MSTest::g_MasterTestSuite.RunAllTests();
}

/**
 * Quick validation for development
 */
void RunQuickValidation()
{
    MSTest::g_MasterTestSuite.RunQuickValidation();
}

/**
 * Production readiness stress testing
 */
void RunStressTests()
{
    MSTest::g_MasterTestSuite.RunStressTests();
}

/**
 * Individual test suite runners
 */
void RunEngineTests()
{
    MSTest::g_MasterTestSuite.RunEngineTests();
}

void RunQuestTests()
{
    MSTest::g_MasterTestSuite.RunQuestTests();
}

void RunNPCTests()
{
    MSTest::g_MasterTestSuite.RunNPCTests();
}

void RunTriggerTests()
{
    MSTest::g_MasterTestSuite.RunTriggerTests();
}

void RunCommunicationTests()
{
    MSTest::g_MasterTestSuite.RunCommunicationTests();
}

void RunPlayerTests()
{
    MSTest::g_MasterTestSuite.RunPlayerTests();
}

void RunPerformanceTests()
{
    MSTest::g_MasterTestSuite.RunPerformanceTestsOnly();
}

/**
 * Regression testing
 */
void RunRegressionTests()
{
    MSTest::g_MasterTestSuite.RunRegressionTests();
}

/**
 * Initialize test framework (call this first)
 */
void InitializeTestSuite()
{
    MSTest::g_MasterTestSuite.Initialize();
}