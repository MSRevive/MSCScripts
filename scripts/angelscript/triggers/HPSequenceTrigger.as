/**
 * HPSequenceTrigger.as
 * 
 * HP Sequence Trigger system for progressive encounter spawning based on party strength.
 * Restores the gm_trigger_hpseq functionality from the original game_master.script (lines 1697-1738).
 * 
 * Key Features:
 * - Progressive spawn triggers based on total party HP
 * - Sequential encounter escalation
 * - Dynamic difficulty adjustment
 * - Configurable HP thresholds and spawn sequences
 */

#include "triggers/AdvancedTriggerSystem.as"
#include "world/EntitySpawner.as"

namespace MS
{
    /**
     * HP threshold configuration for sequential spawning
     */
    class HPThreshold
    {
        float fMinHP;               // Minimum HP to trigger this level
        float fMaxHP;               // Maximum HP for this level (0 = no max)
        string szSpawnScript;       // Entity/group to spawn
        uint nSpawnCount;          // Number of entities to spawn
        float fSpawnDelay;         // Delay between spawns (for multiple entities)
        float fSpawnOffsetX;       // X offset from trigger position
        float fSpawnOffsetY;       // Y offset from trigger position
        float fSpawnOffsetZ;       // Z offset from trigger position
        bool bOnlyOnce;            // Only trigger once per threshold
        string szTriggerMessage;   // Message to display when triggered
        
        HPThreshold()
        {
            fMinHP = 0.0f;
            fMaxHP = 0.0f;
            szSpawnScript = "";
            nSpawnCount = 1;
            fSpawnDelay = 1.0f;
            fSpawnOffsetX = 0.0f;
            fSpawnOffsetY = 0.0f;
            fSpawnOffsetZ = 0.0f;
            bOnlyOnce = true;
            szTriggerMessage = "";
        }
        
        HPThreshold(float minHP, float maxHP, const string &in spawnScript, uint spawnCount = 1)
        {
            fMinHP = minHP;
            fMaxHP = maxHP;
            szSpawnScript = spawnScript;
            nSpawnCount = spawnCount;
            fSpawnDelay = 1.0f;
            fSpawnOffsetX = 0.0f;
            fSpawnOffsetY = 0.0f;
            fSpawnOffsetZ = 0.0f;
            bOnlyOnce = true;
            szTriggerMessage = "";
        }
    }
    
    /**
     * HP Sequence Trigger configuration
     */
    class HPSequenceConfig
    {
        string szTriggerName;           // Name/ID of this sequence
        float fTriggerPosX;             // X position of the trigger
        float fTriggerPosY;             // Y position of the trigger
        float fTriggerPosZ;             // Z position of the trigger
        float fTriggerRadius;           // Radius to check for players
        array<HPThreshold> Thresholds;  // HP thresholds and their spawns
        bool bEnabled;                  // Whether this sequence is active
        bool bResetOnEmpty;             // Reset when no players in range
        uint nCurrentThreshold;         // Current active threshold index
        array<bool> ThresholdTriggered; // Which thresholds have been triggered
        float fLastCheckTime;           // Last time we checked player HP
        float fCheckInterval;           // How often to check (seconds)
        
        HPSequenceConfig()
        {
            szTriggerName = "";
            fTriggerPosX = 0.0f;
            fTriggerPosY = 0.0f;
            fTriggerPosZ = 0.0f;
            fTriggerRadius = 500.0f;
            Thresholds.resize(0);
            bEnabled = true;
            bResetOnEmpty = true;
            nCurrentThreshold = 0;
            ThresholdTriggered.resize(0);
            fLastCheckTime = 0.0f;
            fCheckInterval = 1.0f;  // Check every second
        }
        
        void AddThreshold(const HPThreshold &in threshold)
        {
            Thresholds.insertLast(threshold);
            ThresholdTriggered.insertLast(false);
        }
        
        void SortThresholds()
        {
            // Sort thresholds by minimum HP (ascending)
            for (uint i = 0; i < Thresholds.length() - 1; i++)
            {
                for (uint j = i + 1; j < Thresholds.length(); j++)
                {
                    if (Thresholds[i].fMinHP > Thresholds[j].fMinHP)
                    {
                        // Swap thresholds
                        HPThreshold temp = Thresholds[i];
                        Thresholds[i] = Thresholds[j];
                        Thresholds[j] = temp;
                        
                        // Swap triggered flags
                        bool tempFlag = ThresholdTriggered[i];
                        ThresholdTriggered[i] = ThresholdTriggered[j];
                        ThresholdTriggered[j] = tempFlag;
                    }
                }
            }
        }
        
        void Reset()
        {
            nCurrentThreshold = 0;
            for (uint i = 0; i < ThresholdTriggered.length(); i++)
            {
                ThresholdTriggered[i] = false;
            }
            MS_ANGEL_DEBUG("HPSequenceConfig: Reset trigger '" + szTriggerName + "'");
        }
    }

    /**
     * HP Sequence Trigger System class
     */
    class HPSequenceTrigger
    {
        // System state
        bool m_bInitialized;
        bool m_bEnabled;
        
        // Sequence storage
        array<HPSequenceConfig> m_Sequences;
        uint m_nActiveSequences;
        
        // Update timing
        float m_fLastUpdateTime;
        float m_fUpdateInterval;
        
        // Statistics
        uint m_nTotalTriggers;
        uint m_nSequencesTriggered;
        
        // Integration with other systems
        AdvancedTriggerSystem@ m_pTriggerSystem;
        EntitySpawner@ m_pEntitySpawner;
        
        /**
         * Constructor
         */
        HPSequenceTrigger()
        {
            m_bInitialized = false;
            m_bEnabled = true;
            m_nActiveSequences = 0;
            m_fLastUpdateTime = 0.0f;
            m_fUpdateInterval = 0.5f;  // Update twice per second
            m_nTotalTriggers = 0;
            m_nSequencesTriggered = 0;
            @m_pTriggerSystem = null;
            @m_pEntitySpawner = null;
        }
        
        /**
         * Initialize the HP sequence trigger system
         */
        void Initialize()
        {
            MS_ANGEL_INFO("HPSequenceTrigger: Initializing");
            
            // Get references to other systems
            @m_pTriggerSystem = GetAdvancedTriggerSystem();
            @m_pEntitySpawner = GetEntitySpawner();
            
            if (m_pTriggerSystem is null)
            {
                MS_ANGEL_ERROR("HPSequenceTrigger: AdvancedTriggerSystem not available");
            }
            
            if (m_pEntitySpawner is null)
            {
                MS_ANGEL_ERROR("HPSequenceTrigger: EntitySpawner not available");
            }
            
            m_Sequences.resize(0);
            m_bInitialized = true;
            
            MS_ANGEL_INFO("HPSequenceTrigger: Initialized successfully");
        }
        
        /**
         * Shutdown the system
         */
        void Shutdown()
        {
            MS_ANGEL_INFO("HPSequenceTrigger: Shutting down");
            m_Sequences.resize(0);
            m_nActiveSequences = 0;
            m_bInitialized = false;
        }
        
        /**
         * Create a new HP sequence trigger
         * @param szName Name/ID of the sequence
         * @param vecPos Position of the trigger
         * @param fRadius Radius to check for players
         * @return Index of the created sequence, or -1 if failed
         */
        int CreateHPSequence(const string &in szName, float fPosX, float fPosY, float fPosZ, float fRadius = 500.0f)
        {
            if (!m_bInitialized)
            {
                MS_ANGEL_ERROR("HPSequenceTrigger: System not initialized");
                return -1;
            }
            
            // Check if sequence with this name already exists
            for (uint i = 0; i < m_Sequences.length(); i++)
            {
                if (m_Sequences[i].szTriggerName == szName)
                {
                    MS_ANGEL_ERROR("HPSequenceTrigger: Sequence '" + szName + "' already exists");
                    return -1;
                }
            }
            
            HPSequenceConfig newSeq;
            newSeq.szTriggerName = szName;
            newSeq.fTriggerPosX = fPosX;
            newSeq.fTriggerPosY = fPosY;
            newSeq.fTriggerPosZ = fPosZ;
            newSeq.fTriggerRadius = fRadius;
            
            m_Sequences.insertLast(newSeq);
            m_nActiveSequences++;
            
            MS_ANGEL_INFO("HPSequenceTrigger: Created sequence '" + szName + "' at " + 
                         fPosX + "," + fPosY + "," + fPosZ + " (radius: " + fRadius + ")");
            
            return int(m_Sequences.length() - 1);
        }
        
        /**
         * Add an HP threshold to a sequence
         * @param nSequenceIndex Index of the sequence
         * @param threshold HP threshold configuration
         */
        void AddThreshold(int nSequenceIndex, const HPThreshold &in threshold)
        {
            if (nSequenceIndex < 0 || nSequenceIndex >= int(m_Sequences.length()))
            {
                MS_ANGEL_ERROR("HPSequenceTrigger: Invalid sequence index " + nSequenceIndex);
                return;
            }
            
            m_Sequences[nSequenceIndex].AddThreshold(threshold);
            
            MS_ANGEL_INFO("HPSequenceTrigger: Added threshold (HP: " + threshold.fMinHP + "-" + 
                         threshold.fMaxHP + ", spawn: " + threshold.szSpawnScript + ") to sequence '" + 
                         m_Sequences[nSequenceIndex].szTriggerName + "'");
        }
        
        /**
         * Configure a complete HP sequence with multiple thresholds
         * Recreates the original gm_trigger_hpseq functionality
         */
        int ConfigureClassicHPSequence(const string &in szName, float fPosX, float fPosY, float fPosZ, float fRadius = 500.0f)
        {
            int nSeqIndex = CreateHPSequence(szName, fPosX, fPosY, fPosZ, fRadius);
            if (nSeqIndex == -1)
                return -1;
            
            // Classic HP thresholds based on original game_master.script
            
            // Low HP encounters (100-300 HP)
            HPThreshold lowHP1(100.0f, 200.0f, "monsters/weak_orc", 1);
            lowHP1.szTriggerMessage = "A lone orc appears, drawn by your presence...";
            AddThreshold(nSeqIndex, lowHP1);
            
            HPThreshold lowHP2(200.0f, 300.0f, "monsters/orc_warrior", 2);
            lowHP2.szTriggerMessage = "Orc warriors emerge from the shadows!";
            lowHP2.fSpawnDelay = 2.0f;
            AddThreshold(nSeqIndex, lowHP2);
            
            // Medium HP encounters (300-600 HP)
            HPThreshold medHP1(300.0f, 450.0f, "monsters/orc_shaman", 1);
            medHP1.szTriggerMessage = "An orc shaman senses your growing power...";
            AddThreshold(nSeqIndex, medHP1);
            
            HPThreshold medHP2(450.0f, 600.0f, "monsters/orc_squad", 3);
            medHP2.szTriggerMessage = "A full orc squad responds to the threat!";
            medHP2.fSpawnDelay = 1.5f;
            AddThreshold(nSeqIndex, medHP2);
            
            // High HP encounters (600-1000 HP)
            HPThreshold highHP1(600.0f, 800.0f, "monsters/orc_captain", 1);
            highHP1.szTriggerMessage = "An orc captain arrives to challenge your party!";
            AddThreshold(nSeqIndex, highHP1);
            
            HPThreshold highHP2(800.0f, 1000.0f, "monsters/orc_elite_squad", 4);
            highHP2.szTriggerMessage = "Elite orc warriors surround your party!";
            highHP2.fSpawnDelay = 1.0f;
            AddThreshold(nSeqIndex, highHP2);
            
            // Very high HP encounters (1000+ HP)
            HPThreshold veryHighHP1(1000.0f, 1500.0f, "monsters/orc_warlord", 1);
            veryHighHP1.szTriggerMessage = "The orc warlord himself comes to face you!";
            AddThreshold(nSeqIndex, veryHighHP1);
            
            HPThreshold veryHighHP2(1500.0f, 0.0f, "monsters/orc_army", 6);  // 0 = no max
            veryHighHP2.szTriggerMessage = "An entire orc army mobilizes against your powerful party!";
            veryHighHP2.fSpawnDelay = 0.5f;
            AddThreshold(nSeqIndex, veryHighHP2);
            
            // Sort thresholds by HP
            m_Sequences[nSeqIndex].SortThresholds();
            
            MS_ANGEL_INFO("HPSequenceTrigger: Configured classic HP sequence '" + szName + "' with " + 
                         m_Sequences[nSeqIndex].Thresholds.length() + " thresholds");
            
            return nSeqIndex;
        }
        
        /**
         * Update all HP sequence triggers (call periodically)
         * @param fDeltaTime Time since last update
         */
        void Update(float fDeltaTime)
        {
            if (!m_bInitialized || !m_bEnabled)
                return;
            
            float fCurrentTime = GetGameTime();
            
            if (fCurrentTime - m_fLastUpdateTime < m_fUpdateInterval)
                return;  // Not time to update yet
            
            // Update all active sequences
            for (uint i = 0; i < m_Sequences.length(); i++)
            {
                if (m_Sequences[i].bEnabled)
                {
                    UpdateSequence(m_Sequences[i]);
                }
            }
            
            m_fLastUpdateTime = fCurrentTime;
        }
        
        /**
         * Update a single HP sequence
         */
        void UpdateSequence(HPSequenceConfig &inout sequence)
        {
            float fCurrentTime = GetGameTime();
            
            if (fCurrentTime - sequence.fLastCheckTime < sequence.fCheckInterval)
                return;  // Not time to check this sequence yet
            
            // Get party analysis for players in range
            PartyAnalysis analysis = GetPartyAnalysisInRange(sequence.fTriggerPosX, sequence.fTriggerPosY, sequence.fTriggerPosZ, sequence.fTriggerRadius);
            
            if (analysis.nPlayerCount == 0)
            {
                // No players in range
                if (sequence.bResetOnEmpty)
                {
                    // Reset the sequence when players leave
                    if (sequence.nCurrentThreshold > 0)
                    {
                        MS_ANGEL_INFO("HPSequenceTrigger: Resetting sequence '" + sequence.szTriggerName + "' - no players in range");
                        sequence.Reset();
                    }
                }
                sequence.fLastCheckTime = fCurrentTime;
                return;
            }
            
            // Check if we should trigger any thresholds
            CheckAndTriggerThresholds(sequence, analysis);
            
            sequence.fLastCheckTime = fCurrentTime;
        }
        
        /**
         * Check and trigger appropriate thresholds based on party HP
         */
        void CheckAndTriggerThresholds(HPSequenceConfig &inout sequence, const PartyAnalysis &in analysis)
        {
            float fTotalHP = analysis.fTotalHP;
            
            // Find the highest threshold that should be triggered
            int nHighestThreshold = -1;
            
            for (uint i = 0; i < sequence.Thresholds.length(); i++)
            {
                HPThreshold@ threshold = @sequence.Thresholds[i];
                
                // Check if HP is in range for this threshold
                bool bInRange = (fTotalHP >= threshold.fMinHP);
                if (threshold.fMaxHP > 0.0f)
                {
                    bInRange = bInRange && (fTotalHP <= threshold.fMaxHP);
                }
                
                if (bInRange)
                {
                    nHighestThreshold = int(i);
                }
            }
            
            // Trigger thresholds that haven't been triggered yet
            if (nHighestThreshold >= 0)
            {
                for (int i = 0; i <= nHighestThreshold; i++)
                {
                    if (!sequence.ThresholdTriggered[i])
                    {
                        TriggerThreshold(sequence, i, analysis);
                        sequence.ThresholdTriggered[i] = true;
                        sequence.nCurrentThreshold = uint(i + 1);
                        m_nTotalTriggers++;
                        
                        // Only trigger one threshold per update to avoid spam
                        break;
                    }
                }
            }
        }
        
        /**
         * Trigger a specific threshold
         */
        void TriggerThreshold(HPSequenceConfig &inout sequence, uint nThresholdIndex, const PartyAnalysis &in analysis)
        {
            if (nThresholdIndex >= sequence.Thresholds.length())
                return;
            
            HPThreshold@ threshold = @sequence.Thresholds[nThresholdIndex];
            
            MS_ANGEL_INFO("HPSequenceTrigger: Triggering threshold " + nThresholdIndex + " in sequence '" + 
                         sequence.szTriggerName + "' (HP: " + analysis.fTotalHP + ", spawn: " + threshold.szSpawnScript + ")");
            
            // Display trigger message if configured
            if (threshold.szTriggerMessage.length() > 0)
            {
                // This would send a message to players in range
                // For now, we'll just log it
                MS_ANGEL_INFO("TRIGGER MESSAGE: " + threshold.szTriggerMessage);
            }
            
            // Spawn entities
            if (threshold.szSpawnScript.length() > 0 && m_pEntitySpawner !is null)
            {
                for (uint i = 0; i < threshold.nSpawnCount; i++)
                {
                    // Calculate spawn position with offset and some randomization
                    float baseX = sequence.fTriggerPosX + threshold.fSpawnOffsetX;
                    float baseY = sequence.fTriggerPosY + threshold.fSpawnOffsetY;
                    float baseZ = sequence.fTriggerPosZ + threshold.fSpawnOffsetZ;
                    
                    // Add some randomization to spawn position
                    float fRandomRadius = 100.0f;  // 100 unit radius
                    float fAngle = float(i) * (360.0f / float(threshold.nSpawnCount));  // Spread around circle
                    float spawnX = baseX + cos(fAngle * 3.14159f / 180.0f) * fRandomRadius;
                    float spawnY = baseY + sin(fAngle * 3.14159f / 180.0f) * fRandomRadius;
                    
                    EntitySpawnData spawnData;
                    spawnData.szScript = threshold.szSpawnScript;
                    spawnData.fPositionX = spawnX;
                    spawnData.fPositionY = spawnY;
                    spawnData.fPositionZ = baseZ;
                    spawnData.fAnglesX = 0;
                    spawnData.fAnglesY = fAngle;
                    spawnData.fAnglesZ = 0;
                    spawnData.szName = threshold.szSpawnScript + "_hp_seq_" + nThresholdIndex + "_" + i;
                    
                    if (i == 0)
                    {
                        // Spawn first entity immediately
                        m_pEntitySpawner.SpawnEntityImmediate(spawnData);
                    }
                    else
                    {
                        // Schedule delayed spawn for subsequent entities
                        m_pEntitySpawner.ScheduleDelayedSpawn(threshold.fSpawnDelay * i, spawnData);
                    }
                }
            }
            
            m_nSequencesTriggered++;
        }
        
        /**
         * Get party analysis for players within a specific range
         */
        PartyAnalysis GetPartyAnalysisInRange(float fCenterX, float fCenterY, float fCenterZ, float fRadius)
        {
            // This would need proper player enumeration and range checking
            // For now, we'll use the global trigger system with some modifications
            
            if (m_pTriggerSystem !is null)
            {
                return m_pTriggerSystem.GetCurrentPartyAnalysis();
            }
            
            // Fallback: return empty analysis
            PartyAnalysis emptyAnalysis;
            return emptyAnalysis;
        }
        
        /**
         * Enable or disable a specific sequence
         */
        void SetSequenceEnabled(int nSequenceIndex, bool bEnabled)
        {
            if (nSequenceIndex < 0 || nSequenceIndex >= int(m_Sequences.length()))
            {
                MS_ANGEL_ERROR("HPSequenceTrigger: Invalid sequence index " + nSequenceIndex);
                return;
            }
            
            m_Sequences[nSequenceIndex].bEnabled = bEnabled;
            MS_ANGEL_INFO("HPSequenceTrigger: Sequence '" + m_Sequences[nSequenceIndex].szTriggerName + 
                         "' " + (bEnabled ? "enabled" : "disabled"));
        }
        
        /**
         * Reset a specific sequence
         */
        void ResetSequence(int nSequenceIndex)
        {
            if (nSequenceIndex < 0 || nSequenceIndex >= int(m_Sequences.length()))
            {
                MS_ANGEL_ERROR("HPSequenceTrigger: Invalid sequence index " + nSequenceIndex);
                return;
            }
            
            m_Sequences[nSequenceIndex].Reset();
            MS_ANGEL_INFO("HPSequenceTrigger: Reset sequence '" + m_Sequences[nSequenceIndex].szTriggerName + "'");
        }
        
        /**
         * Reset all sequences
         */
        void ResetAllSequences()
        {
            for (uint i = 0; i < m_Sequences.length(); i++)
            {
                m_Sequences[i].Reset();
            }
            MS_ANGEL_INFO("HPSequenceTrigger: Reset all " + m_Sequences.length() + " sequences");
        }
        
        /**
         * Enable or disable the entire system
         */
        void SetEnabled(bool bEnabled)
        {
            m_bEnabled = bEnabled;
            MS_ANGEL_INFO("HPSequenceTrigger: System " + (bEnabled ? "enabled" : "disabled"));
        }
        
        /**
         * Get system statistics
         */
        void GetStatistics(uint &out nActiveSequences, uint &out nTotalTriggers, uint &out nSequencesTriggered)
        {
            nActiveSequences = m_nActiveSequences;
            nTotalTriggers = m_nTotalTriggers;
            nSequencesTriggered = m_nSequencesTriggered;
        }
        
        /**
         * Debug function to dump all sequences
         */
        void DumpSequenceInfo()
        {
            MS_ANGEL_INFO("HPSequenceTrigger: " + m_Sequences.length() + " total sequences, " + 
                         m_nActiveSequences + " active");
            MS_ANGEL_INFO("HPSequenceTrigger: " + m_nTotalTriggers + " total triggers, " + 
                         m_nSequencesTriggered + " sequences triggered");
            
            for (uint i = 0; i < m_Sequences.length(); i++)
            {
                HPSequenceConfig@ seq = @m_Sequences[i];
                MS_ANGEL_INFO("  Sequence " + i + " '" + seq.szTriggerName + "': " + 
                             seq.Thresholds.length() + " thresholds, current: " + seq.nCurrentThreshold + 
                             ", enabled: " + seq.bEnabled);
            }
        }
        
        /**
         * Get current game time
         */
        float GetGameTime()
        {
            // Placeholder implementation
            return 12345.0f;
        }
    }
    
    // Global HP sequence trigger system instance
    HPSequenceTrigger@ g_HPSequenceTrigger = null;
    
    /**
     * Initialize the HP sequence trigger system
     */
    void InitializeHPSequenceTrigger()
    {
        if (g_HPSequenceTrigger is null)
        {
            @g_HPSequenceTrigger = HPSequenceTrigger();
            g_HPSequenceTrigger.Initialize();
            MS_ANGEL_INFO("HPSequenceTrigger: Global instance initialized");
        }
    }
    
    /**
     * Get the global HP sequence trigger system instance
     */
    HPSequenceTrigger@ GetHPSequenceTrigger()
    {
        if (g_HPSequenceTrigger is null)
        {
            InitializeHPSequenceTrigger();
        }
        return g_HPSequenceTrigger;
    }
    
    /**
     * Shutdown the HP sequence trigger system
     */
    void ShutdownHPSequenceTrigger()
    {
        if (g_HPSequenceTrigger !is null)
        {
            g_HPSequenceTrigger.Shutdown();
            @g_HPSequenceTrigger = null;
            MS_ANGEL_INFO("HPSequenceTrigger: Shutdown completed");
        }
    }
    
    /**
     * Convenience function to create a classic HP sequence from scripts
     * @param szName Name of the sequence
     * @param vecPos Position of the trigger
     * @param fRadius Trigger radius
     * @return Sequence index or -1 if failed
     */
    int CreateClassicHPSequence(const string &in szName, float fPosX, float fPosY, float fPosZ, float fRadius = 500.0f)
    {
        HPSequenceTrigger@ pSystem = GetHPSequenceTrigger();
        if (pSystem is null)
        {
            MS_ANGEL_ERROR("HPSequenceTrigger: System not available");
            return -1;
        }
        
        return pSystem.ConfigureClassicHPSequence(szName, fPosX, fPosY, fPosZ, fRadius);
    }
}