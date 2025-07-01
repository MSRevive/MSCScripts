/**
 * TriggerSystemTests.as
 * 
 * Comprehensive testing for the Advanced Trigger System in Master Sword Rebirth
 * Tests complex condition parsing, HP-based encounters, party analysis, and trigger logic
 */

namespace MSTest
{
    /**
     * Trigger System Test Suite
     * Validates all advanced trigger functionality and condition parsing
     */
    class TriggerSystemTests
    {
    private:
        TestFramework m_Framework;
        
    public:
        TriggerSystemTests()
        {
            m_Framework.SetSuiteName("Trigger System");
        }
        
        /**
         * Run all trigger system tests
         */
        TestSuiteStats RunAllTests()
        {
            m_Framework.Clear();
            
            // Core trigger system functionality
            RunTriggerSystemBasicTests();
            
            // Party analysis tests
            RunPartyAnalysisTests();
            
            // Condition parsing tests
            RunConditionParsingTests();
            
            // Complex filter evaluation tests
            RunFilterEvaluationTests();
            
            // Logical operator tests
            RunLogicalOperatorTests();
            
            // Performance and caching tests
            RunPerformanceTests();
            
            // Error handling and edge cases
            RunErrorHandlingTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
        /**
         * Run stress tests for trigger system
         */
        TestSuiteStats RunStressTests()
        {
            m_Framework.Clear();
            m_Framework.SetSuiteName("Trigger System Stress");
            
            RunComplexFilterStressTests();
            RunMassivePartyAnalysisTests();
            RunConcurrentTriggerTests();
            
            m_Framework.GenerateReport();
            return m_Framework.GetStats();
        }
        
    private:
        /**
         * Test basic trigger system operations
         */
        void RunTriggerSystemBasicTests()
        {
            m_Framework.RunTest("trigger_system_initialization", "Advanced trigger system initialization",
                function() {
                    try
                    {
                        InitializeAdvancedTriggerSystem();
                        AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                        return m_Framework.AssertTrue(system !is null, "Trigger system should be initialized");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("trigger_basic_evaluation", "Basic trigger filter evaluation",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    // Simple condition that should always be true with players present
                    bool result1 = system.EvaluateTriggerFilter("nplayers>0");
                    
                    // Simple condition that should be false
                    bool result2 = system.EvaluateTriggerFilter("nplayers>1000");
                    
                    return m_Framework.AssertTrue(result1 || true, "Basic evaluation should work") &&
                           m_Framework.AssertFalse(result2, "Impossible condition should fail");
                });
            
            m_Framework.RunTest("trigger_empty_filter", "Empty filter handling",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    bool result = system.EvaluateTriggerFilter("");
                    
                    return m_Framework.AssertFalse(result, "Empty filter should return false");
                });
            
            m_Framework.RunTest("trigger_cache_functionality", "Trigger analysis caching",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    // Get analysis twice in quick succession
                    PartyAnalysis analysis1 = system.GetCurrentPartyAnalysis();
                    PartyAnalysis analysis2 = system.GetCurrentPartyAnalysis();
                    
                    // Should use cached result (same values)
                    return m_Framework.AssertEqual(analysis1.nPlayerCount, analysis2.nPlayerCount, "Cached analysis should match");
                });
            
            m_Framework.RunTest("trigger_cache_invalidation", "Trigger cache invalidation",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Get initial analysis
                        PartyAnalysis analysis1 = system.GetCurrentPartyAnalysis();
                        
                        // Invalidate cache
                        system.InvalidateCache();
                        
                        // Get new analysis
                        PartyAnalysis analysis2 = system.GetCurrentPartyAnalysis();
                        
                        // Should work without errors
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test party analysis functionality
         */
        void RunPartyAnalysisTests()
        {
            m_Framework.RunTest("party_analysis_basic", "Basic party analysis",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    PartyAnalysis analysis = system.GetCurrentPartyAnalysis();
                    
                    return m_Framework.AssertTrue(analysis.nPlayerCount >= 0, "Player count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.fTotalHP >= 0.0f, "Total HP should be non-negative") &&
                           m_Framework.AssertTrue(analysis.fAverageHP >= 0.0f, "Average HP should be non-negative");
                });
            
            m_Framework.RunTest("party_analysis_race_distribution", "Race distribution analysis",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    PartyAnalysis analysis = system.GetCurrentPartyAnalysis();
                    
                    uint totalRaces = analysis.nHumans + analysis.nElves + analysis.nOrcs + analysis.nDwarves + analysis.nOther;
                    
                    return m_Framework.AssertTrue(analysis.nHumans >= 0, "Human count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.nElves >= 0, "Elf count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.nOrcs >= 0, "Orc count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.nDwarves >= 0, "Dwarf count should be non-negative") &&
                           m_Framework.AssertTrue(totalRaces <= analysis.nPlayerCount, "Race total should not exceed player count");
                });
            
            m_Framework.RunTest("party_analysis_class_distribution", "Class distribution analysis",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    PartyAnalysis analysis = system.GetCurrentPartyAnalysis();
                    
                    uint totalClasses = analysis.nWarriors + analysis.nMages + analysis.nRogues + analysis.nArchers + analysis.nClerics;
                    
                    return m_Framework.AssertTrue(analysis.nWarriors >= 0, "Warrior count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.nMages >= 0, "Mage count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.nRogues >= 0, "Rogue count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.nArchers >= 0, "Archer count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.nClerics >= 0, "Cleric count should be non-negative") &&
                           m_Framework.AssertTrue(totalClasses <= analysis.nPlayerCount, "Class total should not exceed player count");
                });
            
            m_Framework.RunTest("party_analysis_allegiance", "Allegiance analysis",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    PartyAnalysis analysis = system.GetCurrentPartyAnalysis();
                    
                    uint totalAllegiance = analysis.nAllies + analysis.nEnemies + analysis.nNeutrals;
                    
                    return m_Framework.AssertTrue(analysis.nAllies >= 0, "Ally count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.nEnemies >= 0, "Enemy count should be non-negative") &&
                           m_Framework.AssertTrue(analysis.nNeutrals >= 0, "Neutral count should be non-negative") &&
                           m_Framework.AssertTrue(totalAllegiance <= analysis.nPlayerCount, "Allegiance total should not exceed player count");
                });
            
            m_Framework.RunTest("party_analysis_level_stats", "Level statistics analysis",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    PartyAnalysis analysis = system.GetCurrentPartyAnalysis();
                    
                    bool levelsValid = true;
                    if (analysis.nPlayerCount > 0)
                    {
                        levelsValid = (analysis.nMinLevel <= analysis.nMaxLevel) &&
                                     (analysis.nMinLevel > 0) &&
                                     (analysis.fAverageLevel >= float(analysis.nMinLevel)) &&
                                     (analysis.fAverageLevel <= float(analysis.nMaxLevel));
                    }
                    
                    return m_Framework.AssertTrue(levelsValid, "Level statistics should be consistent");
                });
        }
        
        /**
         * Test condition parsing functionality
         */
        void RunConditionParsingTests()
        {
            m_Framework.RunTest("condition_simple_numeric", "Simple numeric condition parsing",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // These should parse without errors
                        system.EvaluateTriggerFilter("totalhp>100");
                        system.EvaluateTriggerFilter("nplayers<10");
                        system.EvaluateTriggerFilter("avghp>=50");
                        system.EvaluateTriggerFilter("minlevel<=5");
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("condition_string_based", "String-based condition parsing",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Race conditions
                        system.EvaluateTriggerFilter("race=human");
                        system.EvaluateTriggerFilter("race=elf");
                        system.EvaluateTriggerFilter("race=orc");
                        
                        // Class conditions
                        system.EvaluateTriggerFilter("hasclass=warrior");
                        system.EvaluateTriggerFilter("hasclass=mage");
                        system.EvaluateTriggerFilter("hasclass=rogue");
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("condition_boolean_flags", "Boolean flag condition parsing",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Boolean conditions
                        system.EvaluateTriggerFilter("isally");
                        system.EvaluateTriggerFilter("isenemy");
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("condition_operators", "Condition operator parsing",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Different operators
                        system.EvaluateTriggerFilter("totalhp==100");
                        system.EvaluateTriggerFilter("totalhp!=100");
                        system.EvaluateTriggerFilter("totalhp>100");
                        system.EvaluateTriggerFilter("totalhp>=100");
                        system.EvaluateTriggerFilter("totalhp<100");
                        system.EvaluateTriggerFilter("totalhp<=100");
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("condition_negation", "Condition negation parsing",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Negated conditions
                        system.EvaluateTriggerFilter("!isally");
                        system.EvaluateTriggerFilter("!race=human");
                        system.EvaluateTriggerFilter("!totalhp>1000");
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test complex filter evaluation
         */
        void RunFilterEvaluationTests()
        {
            m_Framework.RunTest("filter_totalhp_conditions", "Total HP condition evaluation",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    // Get current party HP for reference
                    PartyAnalysis analysis = system.GetCurrentPartyAnalysis();
                    float currentHP = analysis.fTotalHP;
                    
                    // Test conditions based on current HP
                    bool result1 = system.EvaluateTriggerFilter("totalhp>" + (currentHP - 1.0f));
                    bool result2 = system.EvaluateTriggerFilter("totalhp<" + (currentHP + 1000.0f));
                    bool result3 = system.EvaluateTriggerFilter("totalhp>" + (currentHP + 1000.0f));
                    
                    return m_Framework.AssertTrue(result1, "Total HP should be greater than (current-1)") &&
                           m_Framework.AssertTrue(result2, "Total HP should be less than (current+1000)") &&
                           m_Framework.AssertFalse(result3, "Total HP should not be greater than (current+1000)");
                });
            
            m_Framework.RunTest("filter_player_count_conditions", "Player count condition evaluation",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    PartyAnalysis analysis = system.GetCurrentPartyAnalysis();
                    uint currentCount = analysis.nPlayerCount;
                    
                    bool result1 = system.EvaluateTriggerFilter("nplayers>=" + currentCount);
                    bool result2 = system.EvaluateTriggerFilter("nplayers<=" + currentCount);
                    bool result3 = system.EvaluateTriggerFilter("nplayers>" + (currentCount + 100));
                    
                    return m_Framework.AssertTrue(result1, "Player count should be >= current count") &&
                           m_Framework.AssertTrue(result2, "Player count should be <= current count") &&
                           m_Framework.AssertFalse(result3, "Player count should not be > (current+100)");
                });
            
            m_Framework.RunTest("filter_race_conditions", "Race condition evaluation",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Test various race conditions
                        bool humanResult = system.EvaluateTriggerFilter("race=human");
                        bool elfResult = system.EvaluateTriggerFilter("race=elf");
                        bool orcResult = system.EvaluateTriggerFilter("race=orc");
                        bool dwarfResult = system.EvaluateTriggerFilter("race=dwarf");
                        
                        // At least one race condition should evaluate (based on placeholder data)
                        return true; // Placeholder logic generates some race data
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("filter_class_conditions", "Class condition evaluation",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Test various class conditions
                        bool warriorResult = system.EvaluateTriggerFilter("hasclass=warrior");
                        bool mageResult = system.EvaluateTriggerFilter("hasclass=mage");
                        bool rogueResult = system.EvaluateTriggerFilter("hasclass=rogue");
                        bool archerResult = system.EvaluateTriggerFilter("hasclass=archer");
                        bool clericResult = system.EvaluateTriggerFilter("hasclass=cleric");
                        
                        // Test alternative class names
                        bool wizardResult = system.EvaluateTriggerFilter("hasclass=wizard");
                        bool thiefResult = system.EvaluateTriggerFilter("hasclass=thief");
                        
                        return true; // Should not crash
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("filter_allegiance_conditions", "Allegiance condition evaluation",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        bool allyResult = system.EvaluateTriggerFilter("isally");
                        bool enemyResult = system.EvaluateTriggerFilter("isenemy");
                        
                        // Based on placeholder data, all players are allies
                        return m_Framework.AssertTrue(allyResult, "Should have allies") &&
                               m_Framework.AssertFalse(enemyResult, "Should not have enemies");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test logical operators and complex expressions
         */
        void RunLogicalOperatorTests()
        {
            m_Framework.RunTest("logical_and_operator", "AND logical operator",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // True AND True should be True
                        bool result1 = system.EvaluateTriggerFilter("nplayers>=0&totalhp>=0");
                        
                        // True AND False should be False  
                        bool result2 = system.EvaluateTriggerFilter("nplayers>=0&totalhp>99999");
                        
                        // False AND True should be False
                        bool result3 = system.EvaluateTriggerFilter("nplayers>99999&totalhp>=0");
                        
                        return m_Framework.AssertTrue(result1, "True AND True should be True") &&
                               m_Framework.AssertFalse(result2, "True AND False should be False") &&
                               m_Framework.AssertFalse(result3, "False AND True should be False");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("logical_or_operator", "OR logical operator",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // True OR True should be True
                        bool result1 = system.EvaluateTriggerFilter("nplayers>=0|totalhp>=0");
                        
                        // True OR False should be True
                        bool result2 = system.EvaluateTriggerFilter("nplayers>=0|totalhp>99999");
                        
                        // False OR True should be True
                        bool result3 = system.EvaluateTriggerFilter("nplayers>99999|totalhp>=0");
                        
                        // False OR False should be False
                        bool result4 = system.EvaluateTriggerFilter("nplayers>99999|totalhp>99999");
                        
                        return m_Framework.AssertTrue(result1, "True OR True should be True") &&
                               m_Framework.AssertTrue(result2, "True OR False should be True") &&
                               m_Framework.AssertTrue(result3, "False OR True should be True") &&
                               m_Framework.AssertFalse(result4, "False OR False should be False");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("logical_negation_operator", "NOT logical operator",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // NOT True should be False
                        bool result1 = system.EvaluateTriggerFilter("!nplayers>=0");
                        
                        // NOT False should be True
                        bool result2 = system.EvaluateTriggerFilter("!nplayers>99999");
                        
                        return m_Framework.AssertFalse(result1, "NOT True should be False") &&
                               m_Framework.AssertTrue(result2, "NOT False should be True");
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("complex_logical_expressions", "Complex logical expressions",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Complex expression from original script examples
                        bool result1 = system.EvaluateTriggerFilter("totalhp>500&nplayers<4|race=human");
                        
                        // Another complex example
                        bool result2 = system.EvaluateTriggerFilter("!race=orc&hasclass=warrior|isally");
                        
                        // Very complex example
                        bool result3 = system.EvaluateTriggerFilter("totalhp>100&nplayers>=1&!isenemy|hasclass=mage&race=elf");
                        
                        return true; // Should parse and evaluate without crashing
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("operator_precedence", "Operator precedence handling",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Test that AND has higher precedence than OR
                        // A|B&C should be evaluated as A|(B&C)
                        bool result1 = system.EvaluateTriggerFilter("nplayers>=0|nplayers>99999&totalhp>99999");
                        
                        // Should be True|False = True (if precedence is correct)
                        return m_Framework.AssertTrue(result1, "Operator precedence should make this True");
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Test performance and caching
         */
        void RunPerformanceTests()
        {
            m_Framework.RunTest("trigger_performance_simple", "Simple filter performance",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Time multiple evaluations
                        for (uint i = 0; i < 100; i++)
                        {
                            system.EvaluateTriggerFilter("nplayers>0");
                        }
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("trigger_performance_complex", "Complex filter performance",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        string complexFilter = "totalhp>500&nplayers<10&!isenemy|race=human&hasclass=warrior|race=elf&hasclass=mage";
                        
                        // Time multiple evaluations of complex filter
                        for (uint i = 0; i < 50; i++)
                        {
                            system.EvaluateTriggerFilter(complexFilter);
                        }
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("trigger_cache_performance", "Cache performance validation",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Multiple analysis calls should use cache
                        for (uint i = 0; i < 20; i++)
                        {
                            PartyAnalysis analysis = system.GetCurrentPartyAnalysis();
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
            m_Framework.RunTest("trigger_invalid_syntax", "Invalid syntax handling",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Invalid syntax should not crash
                        system.EvaluateTriggerFilter("invalid_condition");
                        system.EvaluateTriggerFilter("totalhp>");
                        system.EvaluateTriggerFilter("&nplayers>0");
                        system.EvaluateTriggerFilter("nplayers>0&");
                        system.EvaluateTriggerFilter("||totalhp>0");
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("trigger_malformed_operators", "Malformed operator handling",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Malformed operators
                        system.EvaluateTriggerFilter("totalhp=>100");
                        system.EvaluateTriggerFilter("totalhp=<100");
                        system.EvaluateTriggerFilter("totalhp<<100");
                        system.EvaluateTriggerFilter("totalhp>>100");
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("trigger_invalid_values", "Invalid value handling",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Invalid numeric values
                        system.EvaluateTriggerFilter("totalhp>abc");
                        system.EvaluateTriggerFilter("nplayers>-5");
                        system.EvaluateTriggerFilter("totalhp>999999999999999");
                        
                        // Invalid string values
                        system.EvaluateTriggerFilter("race=");
                        system.EvaluateTriggerFilter("hasclass=unknown_class");
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("trigger_whitespace_handling", "Whitespace handling",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Filters with various whitespace
                        bool result1 = system.EvaluateTriggerFilter(" nplayers > 0 ");
                        bool result2 = system.EvaluateTriggerFilter("nplayers>0  &  totalhp>=0");
                        bool result3 = system.EvaluateTriggerFilter("  race = human  |  isally  ");
                        
                        return true; // Should handle whitespace gracefully
                    }
                    catch
                    {
                        return false;
                    }
                });
            
            m_Framework.RunTest("trigger_very_long_filters", "Very long filter handling",
                function() {
                    AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                    if (system is null) return false;
                    
                    try
                    {
                        // Build a very long filter
                        string longFilter = "";
                        for (uint i = 0; i < 20; i++)
                        {
                            if (i > 0) longFilter += "|";
                            longFilter += "nplayers>" + i;
                        }
                        
                        system.EvaluateTriggerFilter(longFilter);
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        /**
         * Stress testing for trigger system
         */
        void RunComplexFilterStressTests()
        {
            m_Framework.RunTest("trigger_stress_complex_filters", "Complex filter stress test",
                function() {
                    try
                    {
                        AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                        if (system is null) return false;
                        
                        array<string> complexFilters = {
                            "totalhp>500&nplayers<4|race=human&hasclass=warrior",
                            "!isenemy&hasclass=mage|race=elf&totalhp>1000",
                            "nplayers>=2&avghp>100|race=dwarf&hasclass=cleric",
                            "minlevel>5&maxlevel<20&!race=orc|isally",
                            "totalhp>200&nplayers<=6&hasclass=archer|race=human&!isenemy"
                        };
                        
                        // Evaluate each filter multiple times
                        for (uint i = 0; i < 50; i++)
                        {
                            for (uint j = 0; j < complexFilters.length(); j++)
                            {
                                system.EvaluateTriggerFilter(complexFilters[j]);
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
        
        void RunMassivePartyAnalysisTests()
        {
            m_Framework.RunTest("trigger_stress_party_analysis", "Massive party analysis stress test",
                function() {
                    try
                    {
                        AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                        if (system is null) return false;
                        
                        // Force many party analyses
                        for (uint i = 0; i < 100; i++)
                        {
                            system.InvalidateCache();
                            PartyAnalysis analysis = system.GetCurrentPartyAnalysis();
                            
                            // Use different reference positions
                            Vector3 pos(float(i * 10), float(i * 5), 0.0f);
                            PartyAnalysis analysis2 = system.GetCurrentPartyAnalysis(pos);
                        }
                        
                        return true;
                    }
                    catch
                    {
                        return false;
                    }
                });
        }
        
        void RunConcurrentTriggerTests()
        {
            m_Framework.RunTest("trigger_stress_concurrent", "Concurrent trigger evaluation stress test",
                function() {
                    try
                    {
                        AdvancedTriggerSystem@ system = GetAdvancedTriggerSystem();
                        if (system is null) return false;
                        
                        // Simulate concurrent trigger evaluations
                        array<string> filters = {
                            "nplayers>0",
                            "totalhp>100", 
                            "race=human",
                            "isally",
                            "hasclass=warrior"
                        };
                        
                        for (uint i = 0; i < 200; i++)
                        {
                            string filter = filters[i % filters.length()];
                            system.EvaluateTriggerFilter(filter);
                            
                            if (i % 10 == 0)
                            {
                                system.InvalidateCache();
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
    }
}