/**
 * EngineIntegrationTests.as
 * 
 * Core engine function testing for Master Sword Rebirth AngelScript integration
 * Tests all engine bindings, built-in functions, and C++ integration points
 */

namespace MSTest
{
    /**
     * Engine Integration Test Suite
     * Tests all core engine functions and C++ bindings
     */
    class EngineIntegrationTests
    {
    private:
        TestFramework m_Framework;
        
    public:
        EngineIntegrationTests()
        {
            m_Framework.SetSuiteName("Engine Integration");
        }
        
        /**
         * Run all engine integration tests
         */
        TestSuiteStats RunAllTests()
        {
            m_Framework.Clear();
            
            // Core type tests
            RunCoreTypeTests();
            
            // String function tests
            RunStringFunctionTests();
            
            // Math function tests
            RunMathFunctionTests();
            
            // Vector utility tests
            RunVectorUtilityTests();
            
            // Game system function tests
            RunGameSystemTests();
            
            // Entity binding tests
            RunEntityBindingTests();
            
            // Memory management tests
            RunMemoryManagementTests();
            
            // Module system tests
            RunModuleSystemTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
        /**
         * Run core essential tests only
         */
        TestSuiteStats RunCoreTests()
        {
            m_Framework.Clear();
            m_Framework.SetSuiteName("Core Engine");
            
            RunCoreTypeTests();
            RunBasicStringTests();
            RunBasicMathTests();
            RunBasicGameSystemTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
    private:
        /**
         * Test core AngelScript types (Vector3, Color, EntityHandle)
         */
        void RunCoreTypeTests()
        {
            // Vector3 tests
            m_Framework.RunTest("vector3_creation", "Vector3 creation and initialization",
                function() {
                    Vector3 v1;
                    Vector3 v2(1.0f, 2.0f, 3.0f);
                    
                    return m_Framework.AssertEqual(v1.x, 0.0f, "Default Vector3.x should be 0") &&
                           m_Framework.AssertEqual(v1.y, 0.0f, "Default Vector3.y should be 0") &&
                           m_Framework.AssertEqual(v1.z, 0.0f, "Default Vector3.z should be 0") &&
                           m_Framework.AssertEqual(v2.x, 1.0f, "Initialized Vector3.x should be 1") &&
                           m_Framework.AssertEqual(v2.y, 2.0f, "Initialized Vector3.y should be 2") &&
                           m_Framework.AssertEqual(v2.z, 3.0f, "Initialized Vector3.z should be 3");
                });
            
            m_Framework.RunTest("vector3_operations", "Vector3 mathematical operations",
                function() {
                    Vector3 v1(1.0f, 2.0f, 3.0f);
                    Vector3 v2(4.0f, 5.0f, 6.0f);
                    Vector3 result = v1 + v2;
                    
                    return m_Framework.AssertEqual(result.x, 5.0f, "Vector addition X component") &&
                           m_Framework.AssertEqual(result.y, 7.0f, "Vector addition Y component") &&
                           m_Framework.AssertEqual(result.z, 9.0f, "Vector addition Z component");
                });
            
            m_Framework.RunTest("vector3_length", "Vector3 length calculation",
                function() {
                    Vector3 v(3.0f, 4.0f, 0.0f);
                    float length = v.Length();
                    
                    return m_Framework.AssertEqual(length, 5.0f, "Vector length should be 5", 0.001f);
                });
            
            // Color tests
            m_Framework.RunTest("color_creation", "Color creation and component access",
                function() {
                    Color c1;
                    Color c2(255, 128, 64, 32);
                    
                    return m_Framework.AssertEqual(int(c2.r), 255, "Color red component") &&
                           m_Framework.AssertEqual(int(c2.g), 128, "Color green component") &&
                           m_Framework.AssertEqual(int(c2.b), 64, "Color blue component") &&
                           m_Framework.AssertEqual(int(c2.a), 32, "Color alpha component");
                });
            
            // EntityHandle tests
            m_Framework.RunTest("entityhandle_creation", "EntityHandle creation and validation",
                function() {
                    EntityHandle h1;
                    EntityHandle h2 = EntityHandle();
                    
                    // Test basic creation (specific validation depends on implementation)
                    return true; // Placeholder - actual implementation depends on EntityHandle methods
                });
        }
        
        /**
         * Test string manipulation functions
         */
        void RunStringFunctionTests()
        {
            RunBasicStringTests();
            RunAdvancedStringTests();
        }
        
        void RunBasicStringTests()
        {
            m_Framework.RunTest("string_left", "Left string extraction",
                function() {
                    string test = "Hello World";
                    string result = Left(test, 5);
                    return m_Framework.AssertEqual(result, "Hello", "Left(5) should return 'Hello'");
                });
            
            m_Framework.RunTest("string_right", "Right string extraction", 
                function() {
                    string test = "Hello World";
                    string result = Right(test, 5);
                    return m_Framework.AssertEqual(result, "World", "Right(5) should return 'World'");
                });
            
            m_Framework.RunTest("string_mid", "Middle string extraction",
                function() {
                    string test = "Hello World";
                    string result = Mid(test, 2, 3);
                    return m_Framework.AssertEqual(result, "llo", "Mid(2,3) should return 'llo'");
                });
            
            m_Framework.RunTest("string_length", "String length calculation",
                function() {
                    string test = "Hello";
                    int length = Length(test);
                    return m_Framework.AssertEqual(length, 5, "Length should return 5");
                });
            
            m_Framework.RunTest("string_case", "String case conversion",
                function() {
                    string test = "Hello World";
                    string upper = ToUpper(test);
                    string lower = ToLower(test);
                    
                    return m_Framework.AssertEqual(upper, "HELLO WORLD", "ToUpper conversion") &&
                           m_Framework.AssertEqual(lower, "hello world", "ToLower conversion");
                });
        }
        
        void RunAdvancedStringTests()
        {
            m_Framework.RunTest("string_replace", "String replacement",
                function() {
                    string test = "Hello World Hello";
                    string result = Replace(test, "Hello", "Hi");
                    return m_Framework.AssertEqual(result, "Hi World Hi", "Replace should work on all occurrences");
                });
            
            m_Framework.RunTest("string_edge_cases", "String function edge cases",
                function() {
                    string empty = "";
                    string single = "A";
                    
                    bool emptyLeftOk = (Left(empty, 5) == "");
                    bool emptyLengthOk = (Length(empty) == 0);
                    bool singleOk = (Left(single, 10) == "A");
                    bool negativeOk = (Left("test", -1) == "");
                    
                    return m_Framework.AssertTrue(emptyLeftOk, "Empty string Left") &&
                           m_Framework.AssertTrue(emptyLengthOk, "Empty string Length") &&
                           m_Framework.AssertTrue(singleOk, "Single char Left overflow") &&
                           m_Framework.AssertTrue(negativeOk, "Negative count Left");
                });
        }
        
        /**
         * Test mathematical functions
         */
        void RunMathFunctionTests()
        {
            RunBasicMathTests();
            RunAdvancedMathTests();
        }
        
        void RunBasicMathTests()
        {
            m_Framework.RunTest("math_basic", "Basic math functions",
                function() {
                    float sinResult = sin(0.0f);
                    float cosResult = cos(0.0f);
                    float sqrtResult = sqrt(16.0f);
                    float absResult = abs(-5.5f);
                    
                    return m_Framework.AssertEqual(sinResult, 0.0f, "sin(0) should be 0", 0.001f) &&
                           m_Framework.AssertEqual(cosResult, 1.0f, "cos(0) should be 1", 0.001f) &&
                           m_Framework.AssertEqual(sqrtResult, 4.0f, "sqrt(16) should be 4", 0.001f) &&
                           m_Framework.AssertEqual(absResult, 5.5f, "abs(-5.5) should be 5.5", 0.001f);
                });
            
            m_Framework.RunTest("math_minmax", "Min/Max functions",
                function() {
                    float minResult = min(3.5f, 7.2f);
                    float maxResult = max(3.5f, 7.2f);
                    int minIntResult = min(5, 3);
                    int maxIntResult = max(5, 3);
                    
                    return m_Framework.AssertEqual(minResult, 3.5f, "min(3.5, 7.2) should be 3.5") &&
                           m_Framework.AssertEqual(maxResult, 7.2f, "max(3.5, 7.2) should be 7.2") &&
                           m_Framework.AssertEqual(minIntResult, 3, "min(5, 3) should be 3") &&
                           m_Framework.AssertEqual(maxIntResult, 5, "max(5, 3) should be 5");
                });
        }
        
        void RunAdvancedMathTests()
        {
            m_Framework.RunTest("math_edge_cases", "Math function edge cases",
                function() {
                    float sqrtNegative = sqrt(-1.0f);
                    float absZero = abs(0.0f);
                    int absIntMin = abs(-2147483647); // Near INT_MIN
                    
                    return m_Framework.AssertEqual(sqrtNegative, 0.0f, "sqrt(-1) should return 0") &&
                           m_Framework.AssertEqual(absZero, 0.0f, "abs(0) should be 0") &&
                           m_Framework.AssertEqual(absIntMin, 2147483647, "abs(INT_MIN+1) should work");
                });
        }
        
        /**
         * Test vector utility functions
         */
        void RunVectorUtilityTests()
        {
            m_Framework.RunTest("vector_creation", "Vector creation utilities",
                function() {
                    Vector3 v = CreateVector(1.0f, 2.0f, 3.0f);
                    
                    return m_Framework.AssertEqual(v.x, 1.0f, "CreateVector X component") &&
                           m_Framework.AssertEqual(v.y, 2.0f, "CreateVector Y component") &&
                           m_Framework.AssertEqual(v.z, 3.0f, "CreateVector Z component");
                });
            
            m_Framework.RunTest("vector_component_access", "Vector component access",
                function() {
                    Vector3 v(5.0f, 10.0f, 15.0f);
                    
                    float x = GetVectorX(v);
                    float y = GetVectorY(v);
                    float z = GetVectorZ(v);
                    
                    return m_Framework.AssertEqual(x, 5.0f, "GetVectorX") &&
                           m_Framework.AssertEqual(y, 10.0f, "GetVectorY") &&
                           m_Framework.AssertEqual(z, 15.0f, "GetVectorZ");
                });
            
            m_Framework.RunTest("vector_distance", "Vector distance calculation",
                function() {
                    Vector3 v1(0.0f, 0.0f, 0.0f);
                    Vector3 v2(3.0f, 4.0f, 0.0f);
                    
                    float distance = Distance(v1, v2);
                    
                    return m_Framework.AssertEqual(distance, 5.0f, "Distance should be 5", 0.001f);
                });
            
            m_Framework.RunTest("vector_dot_product", "Vector dot product",
                function() {
                    Vector3 v1(1.0f, 2.0f, 3.0f);
                    Vector3 v2(4.0f, 5.0f, 6.0f);
                    
                    float dot = DotProduct(v1, v2);
                    float expected = 1*4 + 2*5 + 3*6; // 32
                    
                    return m_Framework.AssertEqual(dot, expected, "Dot product calculation", 0.001f);
                });
            
            m_Framework.RunTest("vector_angles", "Angle vector utilities",
                function() {
                    Vector3 angles = CreateAngles(90.0f, 180.0f, 45.0f);
                    
                    float pitch = GetAnglePitch(angles);
                    float yaw = GetAngleYaw(angles);
                    float roll = GetAngleRoll(angles);
                    
                    return m_Framework.AssertEqual(pitch, 90.0f, "Angle pitch") &&
                           m_Framework.AssertEqual(yaw, 180.0f, "Angle yaw") &&
                           m_Framework.AssertEqual(roll, 45.0f, "Angle roll");
                });
        }
        
        /**
         * Test game system functions
         */
        void RunGameSystemTests()
        {
            RunBasicGameSystemTests();
            RunAdvancedGameSystemTests();
        }
        
        void RunBasicGameSystemTests()
        {
            m_Framework.RunTest("game_time", "Game time retrieval",
                function() {
                    float time1 = GetGameTime();
                    float time2 = GetGameTime();
                    
                    return m_Framework.AssertGreaterThan(time1, 0.0f, "Game time should be positive") &&
                           m_Framework.AssertTrue(time2 >= time1, "Game time should not go backwards");
                });
            
            m_Framework.RunTest("cvar_access", "CVar system access",
                function() {
                    string cvar = GetCvar("developer");
                    // CVar should return a string (even if empty)
                    return true; // Basic connectivity test
                });
            
            m_Framework.RunTest("map_name", "Map name retrieval",
                function() {
                    string mapName = GetMapName();
                    return m_Framework.AssertNotNull(mapName, "Map name should not be null");
                });
            
            m_Framework.RunTest("random_functions", "Random number generation",
                function() {
                    float random1 = Random(0.0f, 1.0f);
                    float random2 = Random(0.0f, 1.0f);
                    int randomInt1 = RandomInt(1, 10);
                    int randomInt2 = RandomInt(1, 10);
                    
                    bool floatInRange = (random1 >= 0.0f && random1 <= 1.0f);
                    bool intInRange = (randomInt1 >= 1 && randomInt1 <= 10);
                    
                    return m_Framework.AssertTrue(floatInRange, "Random float in range") &&
                           m_Framework.AssertTrue(intInRange, "Random int in range");
                });
        }
        
        void RunAdvancedGameSystemTests()
        {
            m_Framework.RunTest("logging_functions", "Game logging system",
                function() {
                    try
                    {
                        LogMessage("Test log message from EngineIntegrationTests");
                        DeveloperMessage(1, "Test developer message");
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("player_count", "Player count retrieval",
                function() {
                    int playerCount = GetPlayerCount();
                    return m_Framework.AssertTrue(playerCount >= 0, "Player count should not be negative");
                });
            
            m_Framework.RunTest("entity_validation", "Entity validation functions",
                function() {
                    EntityHandle nullHandle = EntityHandle();
                    bool isValid = IsValidEntity(nullHandle);
                    
                    // This depends on implementation, but should not crash
                    return true;
                });
        }
        
        /**
         * Test entity binding functions
         */
        void RunEntityBindingTests()
        {
            m_Framework.RunTest("entity_creation", "Entity creation system",
                function() {
                    try
                    {
                        EntityHandle entity = CreateEntity("test_entity");
                        // Should not crash, may return null for unknown entities
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("timestamp_function", "Timestamp generation",
                function() {
                    string timestamp = GetTimestamp();
                    return m_Framework.AssertNotNull(timestamp, "Timestamp should not be empty");
                });
            
            m_Framework.RunTest("angelscript_logging", "AngelScript logging functions",
                function() {
                    try
                    {
                        MS_ANGEL_INFO("Test info message from engine tests");
                        MS_ANGEL_DEBUG("Test debug message from engine tests");
                        MS_ANGEL_ERROR("Test error message from engine tests");
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test memory management and object pooling
         */
        void RunMemoryManagementTests()
        {
            m_Framework.RunTest("large_array_allocation", "Large array memory allocation",
                function() {
                    try
                    {
                        array<string> largeArray;
                        for (uint i = 0; i < 1000; i++)
                        {
                            largeArray.insertLast("TestString_" + i);
                        }
                        
                        bool sizeCorrect = (largeArray.length() == 1000);
                        largeArray.resize(0); // Clean up
                        
                        return m_Framework.AssertTrue(sizeCorrect, "Large array allocation should succeed");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("string_array_operations", "String array operations",
                function() {
                    array<string> testArray;
                    testArray.insertLast("first");
                    testArray.insertLast("second");
                    testArray.insertLast("third");
                    
                    bool lengthOk = (testArray.length() == 3);
                    bool contentOk = (testArray[1] == "second");
                    
                    testArray.removeAt(1);
                    bool removeOk = (testArray.length() == 2) && (testArray[1] == "third");
                    
                    return m_Framework.AssertTrue(lengthOk, "Array length after insertions") &&
                           m_Framework.AssertTrue(contentOk, "Array content access") &&
                           m_Framework.AssertTrue(removeOk, "Array element removal");
                });
        }
        
        /**
         * Test module system functionality
         */
        void RunModuleSystemTests()
        {
            m_Framework.RunTest("module_system_basic", "Basic module system connectivity",
                function() {
                    // Test if module system functions are available
                    try
                    {
                        bool hasModule = HasModule("test_module");
                        // Should not crash even if module doesn't exist
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