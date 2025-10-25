#pragma context server

/**
 * AdvancedTriggerSystem.as
 * 
 * Advanced trigger filtering system that enables dynamic encounters based on party composition.
 * Restores the gm_trig_filter functionality from the original game_master.script (lines 1242-1384).
 * 
 * Key Features:
 * - Complex condition parsing: "totalhp>500&nplayers<4|race=human"
 * - Party analysis: HP, race, allegiance, player count
 * - Logical operators: AND (&), OR (|), NOT (!)
 * - Dynamic encounter scaling based on party strength
 */

namespace AdvancedTriggerSystem
{
    /**
     * Placeholder IsValidEntityLocal implementation
     * Moved out of MS namespace to avoid conflicts with engine registration
     */
    bool IsValidEntityLocal(EntityHandle hEntity)
    {
        // In a real implementation, this would check if the entity handle is valid
        return true;  // Placeholder
    }
}

namespace MS
{
    
    /**
     * Supported trigger filter condition types
     */
    enum FilterConditionType
    {
        CONDITION_NONE = 0,
        CONDITION_TOTAL_HP,      // totalhp>500
        CONDITION_AVG_HP,        // avghp<100
        CONDITION_PLAYER_COUNT,  // nplayers>4
        CONDITION_RACE,          // race=human
        CONDITION_IS_ALLY,       // isally
        CONDITION_IS_ENEMY,      // isenemy
        CONDITION_HAS_CLASS,     // hasclass=warrior
        CONDITION_MIN_LEVEL,     // minlevel>10
        CONDITION_MAX_LEVEL      // maxlevel<20
    }

    /**
     * Comparison operators for numeric conditions
     */
    enum ComparisonOperator
    {
        OP_EQUAL = 0,       // =
        OP_NOT_EQUAL,       // !=
        OP_GREATER,         // >
        OP_GREATER_EQUAL,   // >=
        OP_LESS,            // <
        OP_LESS_EQUAL       // <=
    }

    /**
     * Logical operators for combining conditions
     */
    enum LogicalOperator
    {
        LOGIC_NONE = 0,
        LOGIC_AND,     // &
        LOGIC_OR,      // |
        LOGIC_NOT      // !
    }

    /**
     * Single condition within a trigger filter
     */
    class TriggerCondition
    {
        FilterConditionType Type;
        ComparisonOperator Operator;
        float fValue;           // Numeric value for comparisons
        string szValue;         // String value for text comparisons
        bool bNegated;          // Whether this condition is negated (!)
        
        TriggerCondition()
        {
            Type = CONDITION_NONE;
            Operator = OP_EQUAL;
            fValue = 0.0f;
            szValue = "";
            bNegated = false;
        }
    }

    /**
     * Party analysis data for trigger evaluation
     */
    class PartyAnalysis
    {
        uint nPlayerCount;
        float fTotalHP;
        float fAverageHP;
        uint nMinLevel;
        uint nMaxLevel;
        float fAverageLevel;
        
        // Race counts
        uint nHumans;
        uint nElves;
        uint nOrcs;
        uint nDwarves;
        uint nOther;
        
        // Class counts
        uint nWarriors;
        uint nMages;
        uint nRogues;
        uint nArchers;
        uint nClerics;
        
        // Allegiance counts
        uint nAllies;
        uint nEnemies;
        uint nNeutrals;
        
        array<CBasePlayer@> Players;  // Reference to all analyzed players
        
        PartyAnalysis()
        {
            Reset();
        }
        
        void Reset()
        {
            nPlayerCount = 0;
            fTotalHP = 0.0f;
            fAverageHP = 0.0f;
            nMinLevel = 999;
            nMaxLevel = 0;
            fAverageLevel = 0.0f;
            
            nHumans = 0;
            nElves = 0;
            nOrcs = 0;
            nDwarves = 0;
            nOther = 0;
            
            nWarriors = 0;
            nMages = 0;
            nRogues = 0;
            nArchers = 0;
            nClerics = 0;
            
            nAllies = 0;
            nEnemies = 0;
            nNeutrals = 0;
            
            Players.resize(0);
        }
    }

    /**
     * Advanced Trigger System class
     */
    class AdvancedTriggerSystem
    {
        // System state
        bool m_bInitialized;
        
        // Party analysis cache
        PartyAnalysis m_LastAnalysis;
        float m_fLastAnalysisTime;
        float m_fAnalysisCacheTime;  // How long to cache analysis results
        
        // Parsing state
        string m_szCurrentFilter;
        uint m_nParsePosition;
        
        /**
         * Constructor
         */
        AdvancedTriggerSystem()
        {
            m_bInitialized = false;
            m_fLastAnalysisTime = 0.0f;
            m_fAnalysisCacheTime = 1.0f;  // Cache for 1 second
            m_szCurrentFilter = "";
            m_nParsePosition = 0;
        }
        
        /**
         * Initialize the trigger system
         */
        void Initialize()
        {
            MS_ANGEL_INFO("AdvancedTriggerSystem: Initializing");
            m_bInitialized = true;
            MS_ANGEL_INFO("AdvancedTriggerSystem: Initialized successfully");
        }
        
        /**
         * Shutdown the trigger system
         */
        void Shutdown()
        {
            MS_ANGEL_INFO("AdvancedTriggerSystem: Shutting down");
            m_bInitialized = false;
        }
        
        /**
         * Evaluate a trigger filter condition against current party state
         * @param szFilter Filter condition string (e.g., "totalhp>500&nplayers<4|race=human")
         * @param vecTriggerPos Position of the trigger (for range checks)
         * @return True if the condition is met
         */
        bool EvaluateTriggerFilter(const string &in szFilter)
        {
            if (!m_bInitialized || szFilter.length() == 0)
            {
                return false;
            }
            
            MS_ANGEL_DEBUG("AdvancedTriggerSystem: Evaluating filter: " + szFilter);
            
            // Get current party analysis
            PartyAnalysis analysis = GetCurrentPartyAnalysis();
            
            if (analysis.nPlayerCount == 0)
            {
                MS_ANGEL_DEBUG("AdvancedTriggerSystem: No players found, filter fails");
                return false;
            }
            
            // Parse and evaluate the filter
            return ParseAndEvaluateFilter(szFilter, analysis);
        }
        
        /**
         * Get detailed party analysis for the current game state
         * @param vecReferencePos Reference position for range-based analysis
         * @return Party analysis data
         */
        PartyAnalysis GetCurrentPartyAnalysis()
        {
            float fCurrentTime = GetGameTime();
            
            // Use cached analysis if recent enough
            if (fCurrentTime - m_fLastAnalysisTime < m_fAnalysisCacheTime)
            {
                MS_ANGEL_DEBUG("AdvancedTriggerSystem: Using cached party analysis");
                return m_LastAnalysis;
            }
            
            MS_ANGEL_DEBUG("AdvancedTriggerSystem: Performing new party analysis");
            
            // Reset analysis
            m_LastAnalysis.Reset();
            
            // Analyze all players (this would need proper player enumeration)
            // For now, we'll use placeholder logic
            AnalyzeAllPlayers(m_LastAnalysis);
            
            // Calculate derived values
            if (m_LastAnalysis.nPlayerCount > 0)
            {
                m_LastAnalysis.fAverageHP = m_LastAnalysis.fTotalHP / float(m_LastAnalysis.nPlayerCount);
                m_LastAnalysis.fAverageLevel = float(m_LastAnalysis.nMinLevel + m_LastAnalysis.nMaxLevel) / 2.0f;
            }
            
            m_fLastAnalysisTime = fCurrentTime;
            
            MS_ANGEL_INFO("AdvancedTriggerSystem: Party analysis - " + m_LastAnalysis.nPlayerCount + " players, " +
                         m_LastAnalysis.fTotalHP + " total HP, " + m_LastAnalysis.fAverageHP + " avg HP");
            
            return m_LastAnalysis;
        }
        
        /**
         * Parse and evaluate a complex filter string
         * @param szFilter Filter string to parse
         * @param analysis Party analysis to evaluate against
         * @return True if filter conditions are met
         */
        bool ParseAndEvaluateFilter(const string &in szFilter, const PartyAnalysis &in analysis)
        {
            // Set up parsing state
            m_szCurrentFilter = szFilter;
            m_nParsePosition = 0;
            
            // Parse the expression tree
            return ParseLogicalExpression(analysis);
        }
        
        /**
         * Parse logical expressions with AND/OR operators
         */
        bool ParseLogicalExpression(const PartyAnalysis &in analysis)
        {
            bool result = ParseCondition(analysis);
            
            while (m_nParsePosition < m_szCurrentFilter.length())
            {
                SkipWhitespace();
                
                if (m_nParsePosition >= m_szCurrentFilter.length())
                    break;
                    
                string c = Mid(m_szCurrentFilter, m_nParsePosition, 1);
                
                if (c == "&")  // AND operator
                {
                    m_nParsePosition++;
                    bool rightSide = ParseCondition(analysis);
                    result = result && rightSide;
                    MS_ANGEL_DEBUG("AdvancedTriggerSystem: AND operation: " + result);
                }
                else if (c == "|")  // OR operator
                {
                    m_nParsePosition++;
                    bool rightSide = ParseCondition(analysis);
                    result = result || rightSide;
                    MS_ANGEL_DEBUG("AdvancedTriggerSystem: OR operation: " + result);
                }
                else
                {
                    break;  // Unknown operator or end of expression
                }
            }
            
            return result;
        }
        
        /**
         * Parse a single condition
         */
        bool ParseCondition(const PartyAnalysis &in analysis)
        {
            SkipWhitespace();
            
            // Check for negation
            bool bNegated = false;
            if (m_nParsePosition < m_szCurrentFilter.length() && Mid(m_szCurrentFilter, m_nParsePosition, 1) == "!")
            {
                bNegated = true;
                m_nParsePosition++;
                SkipWhitespace();
            }
            
            // Parse the condition name
            string szConditionName = ParseIdentifier();
            
            if (szConditionName.length() == 0)
            {
                MS_ANGEL_ERROR("AdvancedTriggerSystem: Empty condition name");
                return false;
            }
            
            // Parse the operator and value
            ComparisonOperator op = ParseOperator();
            string szValue = ParseValue();
            
            // Evaluate the condition
            bool result = EvaluateCondition(szConditionName, op, szValue, analysis);
            
            // Apply negation if needed
            if (bNegated)
            {
                result = !result;
                MS_ANGEL_DEBUG("AdvancedTriggerSystem: Condition '" + szConditionName + "' negated: " + result);
            }
            else
            {
                MS_ANGEL_DEBUG("AdvancedTriggerSystem: Condition '" + szConditionName + "' result: " + result);
            }
            
            return result;
        }
        
        /**
         * Evaluate a single parsed condition
         */
        bool EvaluateCondition(const string &in szCondition, ComparisonOperator op, const string &in szValue, const PartyAnalysis &in analysis)
        {
            string szLowerCondition = ToLower(szCondition);
            
            // Convert value to number if needed
            float fValue = parseFloat(szValue);
            
            if (szLowerCondition == "totalhp")
            {
                return CompareFloat(analysis.fTotalHP, fValue, op);
            }
            else if (szLowerCondition == "avghp")
            {
                return CompareFloat(analysis.fAverageHP, fValue, op);
            }
            else if (szLowerCondition == "nplayers")
            {
                return CompareFloat(float(analysis.nPlayerCount), fValue, op);
            }
            else if (szLowerCondition == "minlevel")
            {
                return CompareFloat(float(analysis.nMinLevel), fValue, op);
            }
            else if (szLowerCondition == "maxlevel")
            {
                return CompareFloat(float(analysis.nMaxLevel), fValue, op);
            }
            else if (szLowerCondition == "avglevel")
            {
                return CompareFloat(analysis.fAverageLevel, fValue, op);
            }
            else if (szLowerCondition == "race")
            {
                return EvaluateRaceCondition(szValue, op, analysis);
            }
            else if (szLowerCondition == "hasclass")
            {
                return EvaluateClassCondition(szValue, op, analysis);
            }
            else if (szLowerCondition == "isally")
            {
                return analysis.nAllies > 0;
            }
            else if (szLowerCondition == "isenemy")
            {
                return analysis.nEnemies > 0;
            }
            else
            {
                MS_ANGEL_ERROR("AdvancedTriggerSystem: Unknown condition type: " + szCondition);
                return false;
            }
        }
        
        /**
         * Evaluate race-based conditions
         */
        bool EvaluateRaceCondition(const string &in szRace, ComparisonOperator op, const PartyAnalysis &in analysis)
        {
            string szLowerRace = ToLower(szRace);
            
            uint nCount = 0;
            
            if (szLowerRace == "human")
                nCount = analysis.nHumans;
            else if (szLowerRace == "elf")
                nCount = analysis.nElves;
            else if (szLowerRace == "orc")
                nCount = analysis.nOrcs;
            else if (szLowerRace == "dwarf" || szLowerRace == "dwarves")
                nCount = analysis.nDwarves;
            else
                nCount = analysis.nOther;
            
            // For race conditions, we typically check if any players of that race exist
            return (op == OP_EQUAL && nCount > 0) || 
                   (op == OP_NOT_EQUAL && nCount == 0) ||
                   (op == OP_GREATER && nCount > 0) ||
                   (op == OP_GREATER_EQUAL && nCount >= 1);
        }
        
        /**
         * Evaluate class-based conditions
         */
        bool EvaluateClassCondition(const string &in szClass, ComparisonOperator op, const PartyAnalysis &in analysis)
        {
            string szLowerClass = ToLower(szClass);
            
            uint nCount = 0;
            
            if (szLowerClass == "warrior")
                nCount = analysis.nWarriors;
            else if (szLowerClass == "mage" || szLowerClass == "wizard")
                nCount = analysis.nMages;
            else if (szLowerClass == "rogue" || szLowerClass == "thief")
                nCount = analysis.nRogues;
            else if (szLowerClass == "archer" || szLowerClass == "ranger")
                nCount = analysis.nArchers;
            else if (szLowerClass == "cleric" || szLowerClass == "priest")
                nCount = analysis.nClerics;
            
            return (op == OP_EQUAL && nCount > 0) || 
                   (op == OP_NOT_EQUAL && nCount == 0) ||
                   (op == OP_GREATER && nCount > 0) ||
                   (op == OP_GREATER_EQUAL && nCount >= 1);
        }
        
        /**
         * Invalidate the party analysis cache (call when player state changes)
         */
        void InvalidateCache()
        {
            m_fLastAnalysisTime = 0.0f;
            MS_ANGEL_DEBUG("AdvancedTriggerSystem: Party analysis cache invalidated");
        }
        
        /**
         * Get trigger system statistics
         */
        void GetTriggerStats(uint &out nTriggerChecks, uint &out nPlayerCount, float &out fTotalHP)
        {
            PartyAnalysis analysis = GetCurrentPartyAnalysis();
            nTriggerChecks = 0;  // Would track this if needed
            nPlayerCount = analysis.nPlayerCount;
            fTotalHP = analysis.fTotalHP;
        }
        
        /**
         * Analyze all players and populate the analysis structure
         */
        void AnalyzeAllPlayers(PartyAnalysis &out analysis)
        {
            // This would enumerate all players in the game
            // For now, we'll use placeholder logic
            
            // Placeholder: simulate some players for testing
            // TODO: Replace with actual player enumeration when g_PlayerManager is available
            analysis.nPlayerCount = 1; // Assume at least 1 player for testing
            if (analysis.nPlayerCount > 0)
            {
                analysis.fTotalHP = float(analysis.nPlayerCount * 100);  // Assume 100 HP per player
                
                // Simulate some race/class distribution
                analysis.nHumans = analysis.nPlayerCount / 2;
                analysis.nElves = analysis.nPlayerCount / 4;
                analysis.nOrcs = analysis.nPlayerCount / 4;
                
                analysis.nWarriors = analysis.nPlayerCount / 3;
                analysis.nMages = analysis.nPlayerCount / 3;
                analysis.nRogues = analysis.nPlayerCount / 3;
                
                analysis.nAllies = analysis.nPlayerCount;  // Assume all are allies
                
                analysis.nMinLevel = 1;
                analysis.nMaxLevel = 10;
                
                MS_ANGEL_DEBUG("AdvancedTriggerSystem: Analyzed " + analysis.nPlayerCount + " players (placeholder)");
            }
        }
        
        /**
         * Skip whitespace characters during parsing
         */
        void SkipWhitespace()
        {
            while (m_nParsePosition < m_szCurrentFilter.length())
            {
                string charStr = Mid(m_szCurrentFilter, m_nParsePosition, 1);
                if (charStr == " " || charStr == "\t")
                {
                    m_nParsePosition++;
                }
                else
                {
                    break;
                }
            }
        }
        
        /**
         * Parse an identifier (condition name)
         */
        string ParseIdentifier()
        {
            string result = "";
            
            while (m_nParsePosition < m_szCurrentFilter.length())
            {
                string charStr = Mid(m_szCurrentFilter, m_nParsePosition, 1);
                
                if ((charStr >= "a" && charStr <= "z") || (charStr >= "A" && charStr <= "Z") || 
                    (charStr >= "0" && charStr <= "9") || charStr == "_")
                {
                    result += charStr;
                    m_nParsePosition++;
                }
                else
                {
                    break;
                }
            }
            
            return result;
        }
        
        /**
         * Parse a comparison operator
         */
        ComparisonOperator ParseOperator()
        {
            SkipWhitespace();
            
            if (m_nParsePosition >= m_szCurrentFilter.length())
                return OP_EQUAL;
            
            string c1 = Mid(m_szCurrentFilter, m_nParsePosition, 1);
            string c2 = (m_nParsePosition + 1 < m_szCurrentFilter.length()) ? 
                      Mid(m_szCurrentFilter, m_nParsePosition + 1, 1) : "";
            
            if (c1 == "=" && c2 == "=")
            {
                m_nParsePosition += 2;
                return OP_EQUAL;
            }
            else if (c1 == "!" && c2 == "=")
            {
                m_nParsePosition += 2;
                return OP_NOT_EQUAL;
            }
            else if (c1 == ">" && c2 == "=")
            {
                m_nParsePosition += 2;
                return OP_GREATER_EQUAL;
            }
            else if (c1 == "<" && c2 == "=")
            {
                m_nParsePosition += 2;
                return OP_LESS_EQUAL;
            }
            else if (c1 == ">")
            {
                m_nParsePosition++;
                return OP_GREATER;
            }
            else if (c1 == "<")
            {
                m_nParsePosition++;
                return OP_LESS;
            }
            else if (c1 == "=")
            {
                m_nParsePosition++;
                return OP_EQUAL;
            }
            
            return OP_EQUAL;  // Default
        }
        
        /**
         * Parse a value (string or number)
         */
        string ParseValue()
        {
            SkipWhitespace();
            
            string result = "";
            
            while (m_nParsePosition < m_szCurrentFilter.length())
            {
                string charStr = Mid(m_szCurrentFilter, m_nParsePosition, 1);
                
                // Stop at logical operators or whitespace
                if (charStr == "&" || charStr == "|" || charStr == " " || charStr == "\t")
                {
                    break;
                }
                
                result += charStr;
                m_nParsePosition++;
            }
            
            return result;
        }
        
        /**
         * Compare two float values using the specified operator
         */
        bool CompareFloat(float fLeft, float fRight, ComparisonOperator op)
        {
            switch (op)
            {
                case OP_EQUAL:
                    return abs(fLeft - fRight) < 0.001f;  // Float equality with tolerance
                case OP_NOT_EQUAL:
                    return abs(fLeft - fRight) >= 0.001f;
                case OP_GREATER:
                    return fLeft > fRight;
                case OP_GREATER_EQUAL:
                    return fLeft >= fRight;
                case OP_LESS:
                    return fLeft < fRight;
                case OP_LESS_EQUAL:
                    return fLeft <= fRight;
            }
            return false;
        }
        
        /**
         * Get current game time
         */
        float GetGameTime()
        {
            // This would use the actual game engine time
            // For now, return a simple incremental value
            // Note: AngelScript doesn't support static variables in member functions
            return 1.0f; // Placeholder
        }
        
        /**
         * Parse a float from string
         */
        float parseFloat(const string &in szValue)
        {
            // Basic float parsing - in a real implementation this would use proper parsing
            float result = 0.0f;
            
            if (szValue.length() == 0)
                return 0.0f;
                
            // Simple numeric conversion using string operations
            for (uint i = 0; i < szValue.length(); i++)
            {
                string charStr = Mid(szValue, i, 1);
                if (charStr >= "0" && charStr <= "9")
                {
                    // Convert character to number
                    if (charStr == "0") result = result * 10.0f + 0.0f;
                    else if (charStr == "1") result = result * 10.0f + 1.0f;
                    else if (charStr == "2") result = result * 10.0f + 2.0f;
                    else if (charStr == "3") result = result * 10.0f + 3.0f;
                    else if (charStr == "4") result = result * 10.0f + 4.0f;
                    else if (charStr == "5") result = result * 10.0f + 5.0f;
                    else if (charStr == "6") result = result * 10.0f + 6.0f;
                    else if (charStr == "7") result = result * 10.0f + 7.0f;
                    else if (charStr == "8") result = result * 10.0f + 8.0f;
                    else if (charStr == "9") result = result * 10.0f + 9.0f;
                }
                else if (charStr == ".")
                {
                    // Handle decimal point (simplified)
                    break;
                }
            }
            
            return result;
        }
    }
    
    // Global trigger system instance
    AdvancedTriggerSystem@ g_AdvancedTriggerSystem = null;
    
    /**
     * Initialize the advanced trigger system
     */
    void InitializeAdvancedTriggerSystem()
    {
        if (g_AdvancedTriggerSystem is null)
        {
            @g_AdvancedTriggerSystem = AdvancedTriggerSystem();
            g_AdvancedTriggerSystem.Initialize();
            MS_ANGEL_INFO("AdvancedTriggerSystem: Global instance initialized");
        }
    }
    
    /**
     * Get the global advanced trigger system instance
     */
    AdvancedTriggerSystem@ GetAdvancedTriggerSystem()
    {
        if (g_AdvancedTriggerSystem is null)
        {
            InitializeAdvancedTriggerSystem();
        }
        return g_AdvancedTriggerSystem;
    }
    
    /**
     * Shutdown the advanced trigger system
     */
    void ShutdownAdvancedTriggerSystem()
    {
        if (g_AdvancedTriggerSystem !is null)
        {
            g_AdvancedTriggerSystem.Shutdown();
            @g_AdvancedTriggerSystem = null;
            MS_ANGEL_INFO("AdvancedTriggerSystem: Shutdown completed");
        }
    }
    
    /**
     * Convenience function for evaluating trigger filters from scripts
     * @param szFilter Filter condition string
     * @param vecTriggerPos Position of the trigger
     * @return True if conditions are met
     * Moved to avoid conflicts with engine registration
     */
    bool AdvancedTriggerSystem_EvaluateFilter(const string &in szFilter)
    {
        AdvancedTriggerSystem@ pSystem = GetAdvancedTriggerSystem();
        if (pSystem is null)
        {
            MS_ANGEL_ERROR("AdvancedTriggerSystem: System not available");
            return false;
        }
        
        return pSystem.EvaluateTriggerFilter(szFilter);
    }
}