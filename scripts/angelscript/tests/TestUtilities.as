/**
 * TestUtilities.as
 * 
 * Test framework and utility functions for Master Sword Rebirth AngelScript testing
 * Provides standardized testing infrastructure, assertion functions, and performance measurement
 */

namespace MSTest
{
    /**
     * Test result enumeration
     */
    enum TestResult
    {
        TEST_PASS = 0,
        TEST_FAIL,
        TEST_SKIP,
        TEST_ERROR
    }
    
    /**
     * Test case information
     */
    class TestCase
    {
        string szName;
        string szDescription;
        TestResult result;
        string szFailureReason;
        float flExecutionTime;
        bool bSkipped;
        
        TestCase()
        {
            szName = "";
            szDescription = "";
            result = TEST_PASS;
            szFailureReason = "";
            flExecutionTime = 0.0f;
            bSkipped = false;
        }
        
        TestCase(const string &in name, const string &in description)
        {
            szName = name;
            szDescription = description;
            result = TEST_PASS;
            szFailureReason = "";
            flExecutionTime = 0.0f;
            bSkipped = false;
        }
    }
    
    /**
     * Test suite statistics
     */
    class TestSuiteStats
    {
        uint nTotalTests;
        uint nPassedTests;
        uint nFailedTests;
        uint nSkippedTests;
        uint nErrorTests;
        float flTotalTime;
        
        TestSuiteStats()
        {
            nTotalTests = 0;
            nPassedTests = 0;
            nFailedTests = 0;
            nSkippedTests = 0;
            nErrorTests = 0;
            flTotalTime = 0.0f;
        }
        
        float GetSuccessRate() const
        {
            if (nTotalTests == 0) return 0.0f;
            return float(nPassedTests) / float(nTotalTests) * 100.0f;
        }
    }
    
    /**
     * Performance measurement helper
     */
    class PerformanceTimer
    {
    private:
        float m_flStartTime;
        bool m_bRunning;
        
    public:
        PerformanceTimer()
        {
            m_flStartTime = 0.0f;
            m_bRunning = false;
        }
        
        void Start()
        {
            m_flStartTime = GetGameTime();
            m_bRunning = true;
        }
        
        float Stop()
        {
            if (!m_bRunning) return 0.0f;
            
            float flEndTime = GetGameTime();
            m_bRunning = false;
            return flEndTime - m_flStartTime;
        }
        
        float GetElapsed() const
        {
            if (!m_bRunning) return 0.0f;
            return GetGameTime() - m_flStartTime;
        }
    }
    
    /**
     * Test framework class
     */
    class TestFramework
    {
    private:
        array<TestCase> m_TestCases;
        TestSuiteStats m_Stats;
        string m_szCurrentSuite;
        bool m_bVerbose;
        
    public:
        TestFramework()
        {
            m_szCurrentSuite = "Unknown";
            m_bVerbose = true;
        }
        
        void SetSuiteName(const string &in suiteName)
        {
            m_szCurrentSuite = suiteName;
        }
        
        void SetVerbose(bool verbose)
        {
            m_bVerbose = verbose;
        }
        
        /**
         * Assert functions for testing
         */
        bool AssertTrue(bool condition, const string &in message)
        {
            if (!condition)
            {
                LogFailure("AssertTrue failed: " + message);
                return false;
            }
            return true;
        }
        
        bool AssertFalse(bool condition, const string &in message)
        {
            if (condition)
            {
                LogFailure("AssertFalse failed: " + message);
                return false;
            }
            return true;
        }
        
        bool AssertEqual(int expected, int actual, const string &in message)
        {
            if (expected != actual)
            {
                LogFailure("AssertEqual failed: " + message + " (expected: " + expected + ", actual: " + actual + ")");
                return false;
            }
            return true;
        }
        
        bool AssertEqual(float expected, float actual, const string &in message, float tolerance = 0.001f)
        {
            if (abs(expected - actual) > tolerance)
            {
                LogFailure("AssertEqual failed: " + message + " (expected: " + expected + ", actual: " + actual + ")");
                return false;
            }
            return true;
        }
        
        bool AssertEqual(const string &in expected, const string &in actual, const string &in message)
        {
            if (expected != actual)
            {
                LogFailure("AssertEqual failed: " + message + " (expected: '" + expected + "', actual: '" + actual + "')");
                return false;
            }
            return true;
        }
        
        bool AssertNotNull(const string &in value, const string &in message)
        {
            if (value.length() == 0)
            {
                LogFailure("AssertNotNull failed: " + message + " (value is empty)");
                return false;
            }
            return true;
        }
        
        bool AssertGreaterThan(float value, float threshold, const string &in message)
        {
            if (value <= threshold)
            {
                LogFailure("AssertGreaterThan failed: " + message + " (" + value + " <= " + threshold + ")");
                return false;
            }
            return true;
        }
        
        bool AssertLessThan(float value, float threshold, const string &in message)
        {
            if (value >= threshold)
            {
                LogFailure("AssertLessThan failed: " + message + " (" + value + " >= " + threshold + ")");
                return false;
            }
            return true;
        }
        
        /**
         * Run a test case
         */
        void RunTest(const string &in testName, const string &in description, const TestDelegate &in testFunction)
        {
            TestCase testCase(testName, description);
            PerformanceTimer timer;
            
            LogInfo("Running test: " + testName);
            
            timer.Start();
            
            try
            {
                bool result = testFunction();
                testCase.result = result ? TEST_PASS : TEST_FAIL;
            }
            catch
            {
                testCase.result = TEST_ERROR;
                testCase.szFailureReason = "Exception thrown during test execution";
            }
            
            testCase.flExecutionTime = timer.Stop();
            
            // Update statistics
            m_Stats.nTotalTests++;
            m_Stats.flTotalTime += testCase.flExecutionTime;
            
            switch (testCase.result)
            {
                case TEST_PASS:
                    m_Stats.nPassedTests++;
                    if (m_bVerbose) LogInfo("  PASS - " + description + " (" + testCase.flExecutionTime + "s)");
                    break;
                case TEST_FAIL:
                    m_Stats.nFailedTests++;
                    LogError("  FAIL - " + description + " (" + testCase.flExecutionTime + "s)");
                    break;
                case TEST_SKIP:
                    m_Stats.nSkippedTests++;
                    if (m_bVerbose) LogInfo("  SKIP - " + description);
                    break;
                case TEST_ERROR:
                    m_Stats.nErrorTests++;
                    LogError("  ERROR - " + description + " (" + testCase.flExecutionTime + "s)");
                    break;
            }
            
            m_TestCases.insertLast(testCase);
        }
        
        /**
         * Skip a test with reason
         */
        void SkipTest(const string &in testName, const string &in reason)
        {
            TestCase testCase(testName, reason);
            testCase.result = TEST_SKIP;
            testCase.bSkipped = true;
            testCase.szFailureReason = reason;
            
            m_Stats.nTotalTests++;
            m_Stats.nSkippedTests++;
            m_TestCases.insertLast(testCase);
            
            if (m_bVerbose) LogInfo("SKIP - " + testName + ": " + reason);
        }
        
        /**
         * Generate test report
         */
        void GenerateReport()
        {
            LogInfo("=== TEST SUITE REPORT: " + m_szCurrentSuite + " ===");
            LogInfo("Total Tests: " + m_Stats.nTotalTests);
            LogInfo("Passed: " + m_Stats.nPassedTests);
            LogInfo("Failed: " + m_Stats.nFailedTests);
            LogInfo("Skipped: " + m_Stats.nSkippedTests);
            LogInfo("Errors: " + m_Stats.nErrorTests);
            LogInfo("Success Rate: " + formatFloat(m_Stats.GetSuccessRate(), 2) + "%");
            LogInfo("Total Time: " + formatFloat(m_Stats.flTotalTime, 3) + "s");
            
            if (m_Stats.nFailedTests > 0 || m_Stats.nErrorTests > 0)
            {
                LogError("=== FAILURES AND ERRORS ===");
                for (uint i = 0; i < m_TestCases.length(); i++)
                {
                    if (m_TestCases[i].result == TEST_FAIL || m_TestCases[i].result == TEST_ERROR)
                    {
                        LogError("  " + m_TestCases[i].szName + ": " + m_TestCases[i].szFailureReason);
                    }
                }
            }
            
            LogInfo("=== END REPORT ===");
        }
        
        /**
         * Get test statistics
         */
        TestSuiteStats GetStats() const
        {
            return m_Stats;
        }
        
        /**
         * Clear all test results
         */
        void Clear()
        {
            m_TestCases.resize(0);
            m_Stats = TestSuiteStats();
        }
        
        /**
         * Check if all tests passed
         */
        bool AllTestsPassed() const
        {
            return m_Stats.nFailedTests == 0 && m_Stats.nErrorTests == 0;
        }
        
    private:
        void LogFailure(const string &in message)
        {
            LogError("[TEST] " + message);
        }
    }
    
    // Function delegate for test functions
    funcdef bool TestDelegate();
    
    /**
     * Utility functions for common test operations
     */
    
    /**
     * Create a test vector with known values
     */
    Vector3 CreateTestVector(float x = 1.0f, float y = 2.0f, float z = 3.0f)
    {
        return Vector3(x, y, z);
    }
    
    /**
     * Create a test color with known values
     */
    Color CreateTestColor(uint8 r = 255, uint8 g = 128, uint8 b = 64, uint8 a = 255)
    {
        return Color(r, g, b, a);
    }
    
    /**
     * Generate a random test string
     */
    string GenerateRandomString(uint length = 10)
    {
        string result = "";
        for (uint i = 0; i < length; i++)
        {
            result += char(RandomInt(65, 90)); // A-Z
        }
        return result;
    }
    
    /**
     * Generate test data for performance testing
     */
    array<string> GenerateTestStringArray(uint count = 100)
    {
        array<string> testData;
        for (uint i = 0; i < count; i++)
        {
            testData.insertLast("TestString_" + i + "_" + GenerateRandomString(5));
        }
        return testData;
    }
    
    /**
     * Stress test helper - runs a function multiple times
     */
    bool StressTest(const TestDelegate &in testFunction, uint iterations = 1000)
    {
        for (uint i = 0; i < iterations; i++)
        {
            if (!testFunction())
            {
                LogError("Stress test failed at iteration " + i);
                return false;
            }
        }
        return true;
    }
    
    /**
     * Memory pressure test - allocates arrays to test memory handling
     */
    bool MemoryPressureTest()
    {
        try
        {
            array<array<string>> testArrays;
            for (uint i = 0; i < 100; i++)
            {
                array<string> largeArray;
                for (uint j = 0; j < 1000; j++)
                {
                    largeArray.insertLast("TestData_" + i + "_" + j);
                }
                testArrays.insertLast(largeArray);
            }
            
            // Clean up
            testArrays.resize(0);
            return true;
        }
        catch
        {
            LogError("Memory pressure test failed with exception");
            return false;
        }
    }
    
    /**
     * Format float with specified decimal places
     */
    string formatFloat(float value, uint decimals = 2)
    {
        // Simple float formatting
        string result = "" + int(value);
        
        if (decimals > 0)
        {
            result += ".";
            float fractional = value - int(value);
            for (uint i = 0; i < decimals; i++)
            {
                fractional *= 10.0f;
                result += int(fractional) % 10;
            }
        }
        
        return result;
    }
    
    /**
     * Test-specific logging functions that integrate with MSLogger
     */
    void TestLogInfo(const string &in message)
    {
        MS_ANGEL_INFO("[TEST] " + message);
    }
    
    void TestLogError(const string &in message)
    {
        MS_ANGEL_ERROR("[TEST] " + message);
    }
    
    void TestLogDebug(const string &in message)
    {
        MS_ANGEL_DEBUG("[TEST] " + message);
    }
    
    /**
     * Test environment validation
     */
    bool ValidateTestEnvironment()
    {
        TestFramework framework;
        framework.SetSuiteName("Environment Validation");
        
        // Test basic AngelScript functions
        bool hasBasicFunctions = true;
        hasBasicFunctions = hasBasicFunctions && framework.AssertNotNull("test", "String creation test");
        hasBasicFunctions = hasBasicFunctions && framework.AssertEqual(2 + 2, 4, "Basic math test");
        
        // Test MSLogger integration
        bool hasLogging = true;
        try
        {
            MS_ANGEL_INFO("Test logging message");
            hasLogging = true;
        }
        catch
        {
            hasLogging = false;
        }
        
        framework.AssertTrue(hasLogging, "MSLogger integration test");
        
        LogInfo("Test environment validation completed");
        return hasBasicFunctions && hasLogging;
    }
    
    // Global test framework instance
    TestFramework g_TestFramework;
}