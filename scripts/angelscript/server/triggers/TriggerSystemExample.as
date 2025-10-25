#pragma context server

/**
 * TriggerSystemExample.as
 * 
 * Example script demonstrating how to use the Advanced Trigger System
 * and HP Sequence Triggers for dynamic encounter scaling.
 * 
 * This script shows how to:
 * 1. Set up complex trigger conditions
 * 2. Create HP-based encounter sequences
 * 3. Use the admin commands for testing
 */

namespace MS
{
    /**
     * Example trigger system setup
     */
    void InitializeExampleTriggers()
    {
        MS_ANGEL_INFO("TriggerSystemExample: Setting up example triggers");
        
        // Example 1: Simple HP threshold trigger
        SetupSimpleHPTrigger();
        
        // Example 2: Complex condition trigger
        SetupComplexConditionTrigger();
        
        // Example 3: Multi-zone HP sequence
        SetupMultiZoneEncounters();
        
        MS_ANGEL_INFO("TriggerSystemExample: Example triggers configured");
    }
    
    /**
     * Example 1: Simple HP threshold trigger
     * Creates a basic HP sequence at a specific location
     */
    void SetupSimpleHPTrigger()
    {
        Vector3 triggerPos = Vector3(1000, 2000, 100);  // Example position
        float radius = 300.0f;
        
        // Create a classic HP sequence (with built-in thresholds)
        int seqIndex = CreateClassicHPSequence("example_dungeon_entrance", triggerPos, radius);
        
        if (seqIndex >= 0)
        {
            MS_ANGEL_INFO("TriggerSystemExample: Created simple HP trigger at dungeon entrance");
        }
        else
        {
            MS_ANGEL_ERROR("TriggerSystemExample: Failed to create simple HP trigger");
        }
    }
    
    /**
     * Example 2: Complex condition trigger using filter expressions
     */
    void SetupComplexConditionTrigger()
    {
        // Example complex conditions that could be evaluated:
        
        // 1. Check if party has enough total HP and at least 2 players
        string condition1 = "totalhp>600&nplayers>=2";
        
        // 2. Check for specific race combinations
        string condition2 = "race=human|race=elf";
        
        // 3. Check for balanced party (negation example)
        string condition3 = "!race=orc&hasclass=warrior&hasclass=mage";
        
        // 4. Level-based conditions
        string condition4 = "minlevel>=5&maxlevel<=15";
        
        // These conditions would be used in map scripts like:
        // if (EvaluateTriggerFilter(condition1))
        // {
        //     // Spawn appropriate encounter
        // }
        
        MS_ANGEL_INFO("TriggerSystemExample: Complex trigger conditions configured:");
        MS_ANGEL_INFO("  Condition 1: " + condition1);
        MS_ANGEL_INFO("  Condition 2: " + condition2);
        MS_ANGEL_INFO("  Condition 3: " + condition3);
        MS_ANGEL_INFO("  Condition 4: " + condition4);
    }
    
    /**
     * Example 3: Multi-zone HP sequence setup
     * Creates multiple HP sequences for different areas
     */
    void SetupMultiZoneEncounters()
    {
        // Beginner area - lower HP thresholds
        int beginnerSeq = CreateCustomHPSequence("beginner_forest", Vector3(500, 500, 0), 400.0f);
        if (beginnerSeq >= 0)
        {
            // Add custom thresholds for beginner area
            AddHPThreshold(beginnerSeq, 50.0f, 150.0f, "monsters/wolf_pup", 1, "A young wolf appears...");
            AddHPThreshold(beginnerSeq, 150.0f, 250.0f, "monsters/wolf", 2, "Wolves emerge from the forest!");
            AddHPThreshold(beginnerSeq, 250.0f, 400.0f, "monsters/wolf_alpha", 1, "The alpha wolf arrives to defend its pack!");
        }
        
        // Intermediate area - medium HP thresholds
        int intermediateSeq = CreateCustomHPSequence("dark_caverns", Vector3(2000, 1500, -100), 500.0f);
        if (intermediateSeq >= 0)
        {
            AddHPThreshold(intermediateSeq, 300.0f, 500.0f, "monsters/cave_bat", 3, "Bats swarm from the darkness...");
            AddHPThreshold(intermediateSeq, 500.0f, 800.0f, "monsters/cave_spider", 2, "Giant spiders descend from above!");
            AddHPThreshold(intermediateSeq, 800.0f, 1200.0f, "monsters/cave_troll", 1, "A massive troll blocks your path!");
        }
        
        // Advanced area - high HP thresholds
        int advancedSeq = CreateCustomHPSequence("dragon_lair", Vector3(3000, 3000, 200), 600.0f);
        if (advancedSeq >= 0)
        {
            AddHPThreshold(advancedSeq, 800.0f, 1200.0f, "monsters/drake_wyrmling", 2, "Young drakes guard the entrance...");
            AddHPThreshold(advancedSeq, 1200.0f, 1800.0f, "monsters/drake_adult", 1, "An adult drake challenges your party!");
            AddHPThreshold(advancedSeq, 1800.0f, 0.0f, "monsters/ancient_dragon", 1, "The ancient dragon awakens from its slumber!");
        }
        
        MS_ANGEL_INFO("TriggerSystemExample: Multi-zone encounters configured:");
        MS_ANGEL_INFO("  Beginner Forest: " + beginnerSeq);
        MS_ANGEL_INFO("  Dark Caverns: " + intermediateSeq);
        MS_ANGEL_INFO("  Dragon Lair: " + advancedSeq);
    }
    
    /**
     * Create a custom HP sequence (simpler than the classic one)
     */
    int CreateCustomHPSequence(const string &in szName, const Vector3 &in vecPos, float fRadius)
    {
        HPSequenceTrigger@ pSystem = GetHPSequenceTrigger();
        if (pSystem is null)
        {
            MS_ANGEL_ERROR("TriggerSystemExample: HPSequenceTrigger system not available");
            return -1;
        }
        
        return pSystem.CreateHPSequence(szName, vecPos, fRadius);
    }
    
    /**
     * Example admin command usage
     */
    void DemonstrateAdminCommands()
    {
        MS_ANGEL_INFO("TriggerSystemExample: Admin command examples:");
        MS_ANGEL_INFO("  testtrigger \"totalhp>500&nplayers>1\" - Test if party meets conditions");
        MS_ANGEL_INFO("  createhpseq my_trigger 300 - Create HP sequence at your position");
        MS_ANGEL_INFO("  partyinfo - Show current party analysis");
        MS_ANGEL_INFO("  triggerstatus - Show trigger system statistics");
        MS_ANGEL_INFO("  listhpseq - List all HP sequences");
        MS_ANGEL_INFO("  resethpseq 0 - Reset HP sequence #0");
        MS_ANGEL_INFO("  resethpseq all - Reset all HP sequences");
    }
    
    /**
     * Example usage in map scripts
     */
    void ExampleMapScriptUsage()
    {
        MS_ANGEL_INFO("TriggerSystemExample: Map script usage examples:");
        
        // Example 1: Simple trigger check in a map script
        if (AdvancedTriggerSystem_EvaluateFilter("totalhp>400"))
        {
            MS_ANGEL_INFO("Party has enough HP for advanced encounter");
            // Spawn advanced monsters
        }
        
        // Example 2: Race-based branching
        if (AdvancedTriggerSystem_EvaluateFilter("race=human"))
        {
            MS_ANGEL_INFO("Human party detected - spawning orc enemies");
            // Spawn orc enemies (lore-appropriate)
        }
        else if (AdvancedTriggerSystem_EvaluateFilter("race=orc"))
        {
            MS_ANGEL_INFO("Orc party detected - spawning human enemies");
            // Spawn human enemies
        }
        
        // Example 3: Complex party composition check
        if (AdvancedTriggerSystem_EvaluateFilter("nplayers>=3&hasclass=warrior&hasclass=mage"))
        {
            MS_ANGEL_INFO("Balanced party detected - spawning tactical encounter");
            // Spawn encounter requiring both physical and magical damage
        }
        
        // Example 4: Level-appropriate content
        if (AdvancedTriggerSystem_EvaluateFilter("minlevel>=10"))
        {
            MS_ANGEL_INFO("High-level party - enabling epic encounters");
            // Enable high-level content
        }
    }
    
    /**
     * Stress test the trigger systems
     */
    void StressTriggerSystems()
    {
        MS_ANGEL_INFO("TriggerSystemExample: Running stress test...");
        
        // Test multiple rapid evaluations
        array<string> testConditions = {
            "totalhp>100",
            "totalhp>200&nplayers>1",
            "race=human|race=elf",
            "hasclass=warrior&hasclass=mage",
            "minlevel>=5&maxlevel<=20",
            "nplayers>=2&totalhp>300",
            "!race=orc&hasclass=cleric",
            "avghp>80&nplayers<=4"
        };
        
        for (uint i = 0; i < testConditions.length(); i++)
        {
            bool result = AdvancedTriggerSystem_EvaluateFilter(testConditions[i]);
            MS_ANGEL_DEBUG("Test condition " + i + ": '" + testConditions[i] + "' = " + result);
        }
        
        MS_ANGEL_INFO("TriggerSystemExample: Stress test completed");
    }
}

/**
 * Global initialization function
 * Call this from map scripts to set up example triggers
 */
void InitializeExampleTriggerSystems()
{
    MS::InitializeExampleTriggers();
    MS::DemonstrateAdminCommands();
    MS::ExampleMapScriptUsage();
}

/**
 * Global test function for debugging
 */
void TestTriggerSystems()
{
    MS::StressTriggerSystems();
}