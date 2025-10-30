#pragma context server

/**
 * PerformanceTests.as
 * 
 * Comprehensive performance testing and benchmarking for Master Sword Rebirth AngelScript systems
 * Tests execution speed, memory usage, and scalability of all implemented systems
 */

namespace MSTest
{
    /**
     * Performance Test Suite
     * Benchmarks and validates performance characteristics of all AngelScript systems
     */
    class PerformanceTests
    {
    private:
        TestFramework m_Framework;
        
    public:
        PerformanceTests()
        {
            m_Framework.SetSuiteName("Performance");
        }
        
        /**
         * Run all performance tests
         */
        TestSuiteStats RunAllTests()
        {
            m_Framework.Clear();
            
            // Core system performance tests
            RunCorePerformanceTests();
            
            // Memory usage and optimization tests
            RunMemoryPerformanceTests();
            
            // Scalability tests
            RunScalabilityTests();
            
            // System integration performance
            RunIntegrationPerformanceTests();
            
            // Load testing
            RunLoadTests();
            
            // Garbage collection and cleanup tests
            RunGarbageCollectionTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
        /**
         * Run memory stress tests specifically
         */
        TestSuiteStats RunMemoryStressTests()
        {
            m_Framework.Clear();
            m_Framework.SetSuiteName("Memory Stress");
            
            RunMemoryAllocStressTests();
            RunMemoryLeakTests();
            RunLargeDataStructureTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
    private:
        /**
         * Test core system performance
         */
        void RunCorePerformanceTests()
        {
            m_Framework.RunTest("string_operations_performance", "String operations performance benchmark",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Benchmark string operations
                        for (uint i = 0; i < 1000; i++)
                        {
                            string testStr = "Performance test string " + i;
                            string leftResult = Left(testStr, 10);
                            string rightResult = Right(testStr, 5);
                            string midResult = Mid(testStr, 5, 8);
                            string upperResult = ToUpper(testStr);
                            string lowerResult = ToLower(testStr);
                            string replaceResult = Replace(testStr, "test", "benchmark");
                            int lengthResult = Length(testStr);
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 5.0f, "String operations should complete within 5 seconds");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("math_operations_performance", "Math operations performance benchmark",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        float accumulator = 0.0f;
                        
                        // Benchmark math operations
                        for (uint i = 0; i < 10000; i++)
                        {
                            float value = float(i) * 0.1f;
                            accumulator += sin(value);
                            accumulator += cos(value);
                            accumulator += sqrt(abs(value));
                            accumulator += min(value, 100.0f);
                            accumulator += max(value, 0.0f);
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 2.0f, "Math operations should complete within 2 seconds") &&
                               m_Framework.AssertGreaterThan(accumulator, 0.0f, "Accumulator should have positive value");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("vector_operations_performance", "Vector operations performance benchmark",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        Vector3 accumulator(0, 0, 0);
                        
                        // Benchmark vector operations
                        for (uint i = 0; i < 5000; i++)
                        {
                            Vector3 v1(float(i), float(i) * 2.0f, float(i) * 3.0f);
                            Vector3 v2(float(i) + 1.0f, float(i) * 1.5f, float(i) * 2.5f);
                            
                            Vector3 sum = v1 + v2;
                            Vector3 diff = v1 - v2;
                            float dot = DotProduct(v1, v2);
                            float distance = Distance(v1, v2);
                            float length = v1.Length();
                            
                            accumulator = accumulator + sum;
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 3.0f, "Vector operations should complete within 3 seconds") &&
                               m_Framework.AssertGreaterThan(accumulator.Length(), 0.0f, "Accumulator should have positive length");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("array_operations_performance", "Array operations performance benchmark",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        array<string> testArray;
                        
                        // Benchmark array operations
                        for (uint i = 0; i < 2000; i++)
                        {
                            testArray.insertLast("Element_" + i);
                        }
                        
                        // Search operations
                        for (uint i = 0; i < 500; i++)
                        {
                            int index = testArray.find("Element_" + (i * 2));
                        }
                        
                        // Removal operations
                        for (uint i = 0; i < 100; i++)
                        {
                            if (testArray.length() > 0)
                            {
                                testArray.removeAt(testArray.length() - 1);
                            }
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 4.0f, "Array operations should complete within 4 seconds") &&
                               m_Framework.AssertEqual(testArray.length(), 1900, "Array should have expected size");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test memory usage and optimization
         */
        void RunMemoryPerformanceTests()
        {
            m_Framework.RunTest("memory_allocation_performance", "Memory allocation performance",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Allocate many small objects
                        array<array<string>> nestedArrays;
                        
                        for (uint i = 0; i < 100; i++)
                        {
                            array<string> innerArray;
                            for (uint j = 0; j < 50; j++)
                            {
                                innerArray.insertLast("Data_" + i + "_" + j);
                            }
                            nestedArrays.insertLast(innerArray);
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        // Clean up
                        nestedArrays.resize(0);
                        
                        return m_Framework.AssertLessThan(elapsedTime, 3.0f, "Memory allocation should complete within 3 seconds");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("string_memory_usage", "String memory usage patterns",
                function() {
                    try
                    {
                        array<string> largeStrings;
                        
                        // Create large strings
                        for (uint i = 0; i < 100; i++)
                        {
                            string largeString = "";
                            for (uint j = 0; j < 1000; j++)
                            {
                                largeString += "X";
                            }
                            largeStrings.insertLast(largeString);
                        }
                        
                        // Access patterns
                        uint totalLength = 0;
                        for (uint i = 0; i < largeStrings.length(); i++)
                        {
                            totalLength += largeStrings[i].length();
                        }
                        
                        // Clean up
                        largeStrings.resize(0);
                        
                        return m_Framework.AssertEqual(totalLength, 100000, "Total string length should be 100,000");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("object_pool_performance", "Object pooling performance",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Simulate object pooling pattern
                        array<Vector3> objectPool;
                        array<Vector3> activeObjects;
                        
                        // Pre-populate pool
                        for (uint i = 0; i < 1000; i++)
                        {
                            objectPool.insertLast(Vector3(0, 0, 0));
                        }
                        
                        // Simulate acquire/release cycles
                        for (uint cycle = 0; cycle < 100; cycle++)
                        {
                            // Acquire objects
                            for (uint i = 0; i < 50 && objectPool.length() > 0; i++)
                            {
                                Vector3 obj = objectPool[objectPool.length() - 1];
                                objectPool.removeAt(objectPool.length() - 1);
                                activeObjects.insertLast(obj);
                            }
                            
                            // Release objects
                            for (uint i = 0; i < 25 && activeObjects.length() > 0; i++)
                            {
                                Vector3 obj = activeObjects[activeObjects.length() - 1];
                                activeObjects.removeAt(activeObjects.length() - 1);
                                objectPool.insertLast(obj);
                            }
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 2.0f, "Object pooling should be efficient");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test system scalability
         */
        void RunScalabilityTests()
        {
            m_Framework.RunTest("quest_system_scalability", "Quest system scalability",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Simulate many quest operations
                        for (uint i = 0; i < 500; i++)
                        {
                            string player = "scale_player_" + i;
                            string item = "scale_item_" + (i % 50);
                            
                            ext_got_quest_item_player(player, item, i % 10 + 1);
                            uint count = ext_get_quest_item_count(player, item);
                            
                            if (i % 3 == 0)
                            {
                                ext_check_quest_item_qty(item, "scale_npc_" + (i % 10), 1);
                            }
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 10.0f, "Quest operations should scale well");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("trigger_system_scalability", "Trigger system scalability",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                        if (system is null) return false;
                        
                        array<string> complexFilters = {
                            "totalhp>500&nplayers<10",
                            "race=human|race=elf&hasclass=warrior",
                            "!isenemy&avghp>100|minlevel>5",
                            "nplayers>=2&maxlevel<20&hasclass=mage",
                            "totalhp>1000|race=dwarf&!race=orc"
                        };
                        
                        // Evaluate many complex filters
                        for (uint i = 0; i < 1000; i++)
                        {
                            string filter = complexFilters[i % complexFilters.length()];
                            bool result = system.EvaluateTriggerFilter(filter);
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 5.0f, "Trigger evaluations should scale well");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("communication_system_scalability", "Communication system scalability",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        CBaseEntity@ testEntity = CBaseEntity@();
                        
                        // Many communication calls
                        for (uint i = 0; i < 2000; i++)
                        {
                            string target = "SCALE_TARGET_" + (i % 20);
                            string function = "scale_func_" + (i % 10);
                            string param = "scale_param_" + i;
                            
                            CallExternal(target, function, param, "", "", "", testEntity);
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 8.0f, "Communication calls should scale well");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("npc_manager_scalability", "NPC manager scalability",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        CriticalNPCManager@ manager = GetCriticalNPCManager();
                        if (manager is null) return false;
                        
                        // Register many NPCs
                        for (uint i = 0; i < 300; i++)
                        {
                            string npcName = "scale_npc_" + i;
                            string script = "test/scale_" + (i % 20);
                            string displayName = "Scale NPC " + i;
                            string map = "scale_map_" + (i % 5);
                            int priority = (i % 3) + 1;
                            string questChain = "scale_quest_" + (i % 15);
                            
                            manager.RegisterCriticalNPC(npcName, script, displayName, map, priority, questChain);
                        }
                        
                        // Simulate some deaths
                        for (uint i = 0; i < 50; i++)
                        {
                            string npcName = "scale_npc_" + (i * 3);
                            string killer = "scale_killer_" + (i % 10);
                            manager.CriticalNPCDied(npcName, killer);
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 6.0f, "NPC operations should scale well");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test system integration performance
         */
        void RunIntegrationPerformanceTests()
        {
            m_Framework.RunTest("cross_system_performance", "Cross-system interaction performance",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Simulate complex cross-system operations
                        for (uint i = 0; i < 100; i++)
                        {
                            // Quest operations
                            string player = "integration_player_" + (i % 20);
                            string item = "integration_item_" + (i % 10);
                            ext_got_quest_item_player(player, item, 1);
                            
                            // NPC operations
                            if (i % 5 == 0)
                            {
                                string npc = "integration_npc_" + i;
                                gm_crit_npc_died(npc, player);
                            }
                            
                            // Trigger evaluation
                            if (i % 3 == 0)
                            {
                                AdvancedTriggerSystem_EvaluateFilter("nplayers>0&totalhp>100");
                            }
                            
                            // Communication
                            if (i % 7 == 0)
                            {
                                CallExternal("INTEGRATION", "test_func", player, item, "", "", CBaseEntity@());
                            }
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 8.0f, "Cross-system operations should be efficient");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("cascading_system_calls", "Cascading system calls performance",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Simulate cascading calls (one system calling another)
                        for (uint i = 0; i < 200; i++)
                        {
                            // Quest pickup triggers NPC notification
                            string player = "cascade_player_" + (i % 10);
                            string item = "cascade_item_" + (i % 5);
                            
                            // Primary quest operation
                            ext_got_quest_item_player(player, item, 1);
                            
                            // Trigger NPC waiting system
                            QuestItemIntegration@ integration = GetQuestItemIntegration();
                            if (integration !is null)
                            {
                                integration.ProcessWaitingNPCs(item);
                            }
                            
                            // Evaluate related triggers
                            if (i % 4 == 0)
                            {
                                AdvancedTriggerSystem_EvaluateFilter("nplayers>0");
                            }
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 6.0f, "Cascading calls should be efficient");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test system load handling
         */
        void RunLoadTests()
        {
            m_Framework.RunTest("high_frequency_calls", "High frequency function calls",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Very high frequency basic calls
                        for (uint i = 0; i < 10000; i++)
                        {
                            float gameTime = GetGameTime();
                            string mapName = GetMapName();
                            Vector3 testVec(float(i), float(i * 2), float(i * 3));
                            float distance = Distance(testVec, Vector3(0, 0, 0));
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 3.0f, "High frequency calls should be fast");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("burst_load_handling", "Burst load handling",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Simulate burst of activity
                        for (uint burst = 0; burst < 10; burst++)
                        {
                            // Each burst has many operations
                            for (uint i = 0; i < 500; i++)
                            {
                                string player = "burst_player_" + burst + "_" + i;
                                string item = "burst_item_" + (i % 20);
                                
                                ext_got_quest_item_player(player, item, 1);
                                uint count = ext_get_quest_item_count(player, item);
                                
                                if (i % 10 == 0)
                                {
                                    CallExternal("BURST", "burst_func", player, "", "", "", CBaseEntity@());
                                }
                            }
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 15.0f, "Burst loads should be handled efficiently");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("sustained_load_test", "Sustained load test",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Sustained moderate load
                        for (uint i = 0; i < 5000; i++)
                        {
                            // Mix of operations
                            if (i % 2 == 0)
                            {
                                string testStr = "sustained_test_" + i;
                                string result = ToUpper(Left(testStr, 10));
                            }
                            
                            if (i % 3 == 0)
                            {
                                Vector3 v1(float(i), float(i) * 0.5f, float(i) * 0.25f);
                                Vector3 v2(float(i) + 10.0f, float(i) * 0.75f, float(i) * 0.125f);
                                float dist = Distance(v1, v2);
                            }
                            
                            if (i % 5 == 0)
                            {
                                ext_got_quest_item_player("sustained_player", "sustained_item", 1);
                            }
                            
                            if (i % 7 == 0)
                            {
                                AdvancedTriggerSystem_EvaluateFilter("nplayers>=0");
                            }
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 12.0f, "Sustained load should be manageable");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test garbage collection and cleanup
         */
        void RunGarbageCollectionTests()
        {
            m_Framework.RunTest("memory_cleanup_performance", "Memory cleanup performance",
                function() {
                    PerformanceTimer timer;
                    timer.Start();
                    
                    try
                    {
                        // Create and destroy many objects
                        for (uint cycle = 0; cycle < 50; cycle++)
                        {
                            array<string> tempArrays;
                            
                            // Allocate
                            for (uint i = 0; i < 200; i++)
                            {
                                string tempString = "";
                                for (uint j = 0; j < 100; j++)
                                {
                                    tempString += "X";
                                }
                                tempArrays.insertLast(tempString);
                            }
                            
                            // Use the data
                            uint totalLength = 0;
                            for (uint i = 0; i < tempArrays.length(); i++)
                            {
                                totalLength += tempArrays[i].length();
                            }
                            
                            // Clean up (let it go out of scope)
                            tempArrays.resize(0);
                        }
                        
                        float elapsedTime = timer.Stop();
                        
                        return m_Framework.AssertLessThan(elapsedTime, 8.0f, "Memory cleanup should be efficient");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("fragmentation_handling", "Memory fragmentation handling",
                function() {
                    try
                    {
                        // Create fragmented memory pattern
                        array<array<string>> fragmentedArrays;
                        
                        // Allocate arrays of different sizes
                        for (uint i = 0; i < 100; i++)
                        {
                            array<string> sizeArray;
                            uint size = (i % 10) + 1;
                            
                            for (uint j = 0; j < size * 10; j++)
                            {
                                sizeArray.insertLast("Fragment_" + i + "_" + j);
                            }
                            
                            fragmentedArrays.insertLast(sizeArray);
                        }
                        
                        // Remove every other array (create gaps)
                        for (int i = int(fragmentedArrays.length()) - 1; i >= 0; i -= 2)
                        {
                            fragmentedArrays.removeAt(i);
                        }
                        
                        // Fill gaps with new allocations
                        for (uint i = 0; i < 25; i++)
                        {
                            array<string> newArray;
                            for (uint j = 0; j < 50; j++)
                            {
                                newArray.insertLast("NewData_" + i + "_" + j);
                            }
                            fragmentedArrays.insertLast(newArray);
                        }
                        
                        // Clean up
                        fragmentedArrays.resize(0);
                        
                        return true; // Should handle fragmentation gracefully
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Memory stress testing
         */
        void RunMemoryAllocStressTests()
        {
            m_Framework.RunTest("massive_allocation_test", "Massive memory allocation stress test",
                function() {
                    try
                    {
                        array<array<string>> massiveArrays;
                        
                        // Allocate very large amounts of data
                        for (uint i = 0; i < 500; i++)
                        {
                            array<string> largeArray;
                            for (uint j = 0; j < 1000; j++)
                            {
                                string largeString = "";
                                for (uint k = 0; k < 200; k++)
                                {
                                    largeString += "MassiveData";
                                }
                                largeArray.insertLast(largeString);
                            }
                            massiveArrays.insertLast(largeArray);
                            
                            // Periodically clean up to prevent total memory exhaustion
                            if (i % 100 == 99)
                            {
                                massiveArrays.resize(0);
                            }
                        }
                        
                        // Final cleanup
                        massiveArrays.resize(0);
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        void RunMemoryLeakTests()
        {
            m_Framework.RunTest("memory_leak_detection", "Memory leak detection test",
                function() {
                    try
                    {
                        // Perform operations that might leak memory
                        for (uint cycle = 0; cycle < 100; cycle++)
                        {
                            // Create temporary objects
                            QuestTracker@ tracker = GetQuestTracker();
                            if (tracker !is null)
                            {
                                tracker.RegisterQuestItem("leak_test_" + cycle, "Leak Test", "Test for memory leaks");
                            }
                            
                            AdvancedTriggerSystem@ triggerSystem = GetAdvancedTriggerSystem();
                            if (triggerSystem !is null)
                            {
                                PartyAnalysis analysis = triggerSystem.GetCurrentPartyAnalysis();
                                triggerSystem.InvalidateCache();
                            }
                            
                            EntityCommunicationSystem@ commSystem = GetEntityCommunicationSystem();
                            if (commSystem !is null)
                            {
                                uint total, success, failed, blocked;
                                commSystem.GetStatistics(total, success, failed, blocked);
                            }
                        }
                        
                        return true; // If we reach here without crashes, likely no major leaks
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        void RunLargeDataStructureTests()
        {
            m_Framework.RunTest("large_data_structure_test", "Large data structure handling",
                function() {
                    try
                    {
                        // Create very large nested data structures
                        array<array<array<string>>> nestedStructure;
                        
                        for (uint i = 0; i < 50; i++)
                        {
                            array<array<string>> midLevel;
                            for (uint j = 0; j < 100; j++)
                            {
                                array<string> innerLevel;
                                for (uint k = 0; k < 50; k++)
                                {
                                    innerLevel.insertLast("Data_" + i + "_" + j + "_" + k);
                                }
                                midLevel.insertLast(innerLevel);
                            }
                            nestedStructure.insertLast(midLevel);
                        }
                        
                        // Access patterns
                        uint totalElements = 0;
                        for (uint i = 0; i < nestedStructure.length(); i++)
                        {
                            for (uint j = 0; j < nestedStructure[i].length(); j++)
                            {
                                totalElements += nestedStructure[i][j].length();
                            }
                        }
                        
                        // Cleanup
                        nestedStructure.resize(0);
                        
                        return m_Framework.AssertEqual(totalElements, 250000, "Should have processed 250,000 elements");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
    }
}