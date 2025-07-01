/**
 * GameMasterInit.as
 * 
 * Initialization script for the GameMaster system.
 * This script sets up the global GameMaster instance and
 * connects it to the game engine.
 */

#include "gamemaster/GameMaster.as"

namespace MS
{
    // Global GameMaster instance
    GameMaster@ g_pGameMaster = null;
    
    /**
     * Initialize the GameMaster system
     * Called by the game engine when the map loads
     */
    void InitializeGameMaster()
    {
        LogInfo("Initializing GameMaster system...");
        
        // Check if already initialized
        if (g_pGameMaster !is null)
        {
            LogWarning("GameMaster already initialized, destroying previous instance");
            @g_pGameMaster = null;
        }
        
        // Initialize supporting systems first
        // TODO: Re-enable these systems once they are fully tested
        // InitializeAdvancedTriggerSystem();
        // InitializeHPSequenceTrigger();
        // InitializeEntitySpawner();
        
        // Initialize entity communication system
        // InitializeEntityCommunications();
        
        LogInfo("GameMaster: Skipping advanced systems initialization for now");
        
        // Create new GameMaster instance
        @g_pGameMaster = GameMaster();
        
        if (g_pGameMaster !is null)
        {
            // Initialize the GameMaster
            g_pGameMaster.Spawn();
            
            // Register engine event handlers
            RegisterGameMasterEngineEvents();
            
            LogInfo("GameMaster system initialized successfully");
        }
        else
        {
            LogError("Failed to create GameMaster instance!");
        }
    }
    
    /**
     * Shutdown the GameMaster system
     * Called when the map unloads
     */
    void ShutdownGameMaster()
    {
        LogInfo("Shutting down GameMaster system...");
        
        if (g_pGameMaster !is null)
        {
            // Clean shutdown
            @g_pGameMaster = null;
            LogInfo("GameMaster system shut down successfully");
        }
        else
        {
            LogWarning("GameMaster was not initialized");
        }
        
        // Shutdown supporting systems
        // TODO: Re-enable these shutdowns when systems are active
        // ShutdownEntityCommunications();
        // ShutdownHPSequenceTrigger();
        // ShutdownAdvancedTriggerSystem();
        // ShutdownEntitySpawner();
    }
    
    /**
     * Get the global GameMaster instance
     */
    GameMaster@ GetGameMasterInstance()
    {
        return g_pGameMaster;
    }
    
    /**
     * Check if GameMaster is initialized
     * Moved to avoid conflicts with engine registration
     */
    bool GameMasterUtils_IsInitialized()
    {
        return g_pGameMaster !is null;
    }
    
    // ========================================
    // Engine Event Registration
    // ========================================
    
    /**
     * Register GameMaster event handlers with the engine event system
     */
    void RegisterGameMasterEngineEvents()
    {
        LogInfo("GameMaster: Registering engine event handlers...");
        
        // Register the GameMaster engine event handlers
        RegisterEngineEvent("OnEnginePlayerConnect", OnEnginePlayerConnect);
        RegisterEngineEvent("OnEnginePlayerDisconnect", OnEnginePlayerDisconnect);
        RegisterEngineEvent("OnEngineMonsterKilled", OnEngineMonsterKilled);
        RegisterEngineEvent("OnEngineTreasureSpawned", OnEngineTreasureSpawned);
        
        LogInfo("GameMaster: Engine event handlers registered successfully!");
    }
    
    // ========================================
    // Engine Event Callbacks
    // ========================================
    
    /**
     * Called when a player connects
     * This would be hooked up to the engine's player connect event
     */
    void OnEnginePlayerConnect(const string &in szPlayerName, const string &in szSteamID)
    {
        if (g_pGameMaster !is null)
        {
            g_pGameMaster.OnPlayerConnect(szPlayerName);

            LogInfo("Player:" + szPlayerName + " has connected!");
        }
    }
    
    /**
     * Called when a player disconnects
     */
    void OnEnginePlayerDisconnect(const string &in szPlayerName, const string &in szSteamID)
    {
        if (g_pGameMaster !is null)
        {
            g_pGameMaster.OnPlayerDisconnect(szPlayerName);
        }
    }
    
    /**
     * Called when a monster is killed
     */
    void OnEngineMonsterKilled(const string &in szMonsterName, const string &in szKillerName,
                              const Vector3 &in vecDeathPos)
    {
        if (g_pGameMaster !is null)
        {
            g_pGameMaster.OnMonsterKilled(szMonsterName, szKillerName);
            
            // Trigger gold spew if monster had gold
            // This is just an example - real implementation would check monster data
            bool containsBoss = false;
            for (uint i = 0; i <= szMonsterName.length() - 4; i++)
            {
                if (szMonsterName.substr(i, 4) == "boss")
                {
                    containsBoss = true;
                    break;
                }
            }
            if (containsBoss)
            {
                g_pGameMaster.GoldSpew(100.0f, 3, 150.0f, 8, 25, vecDeathPos);
            }
        }
    }
    
    /**
     * Called when treasure is spawned
     */
    void OnEngineTreasureSpawned(const string &in szTreasureType, const Vector3 &in vecPos)
    {
        if (g_pGameMaster !is null)
        {
            g_pGameMaster.OnTreasureSpawned(szTreasureType);
        }
    }
    
    // ========================================
    // Utility Functions for External Scripts
    // ========================================
    
    /**
     * Trigger gold spew from external scripts
     */
    void TriggerGoldSpew(float flGoldPerBag, uint nBagsPerPlayer, float flDistance,
                        uint nMinBags, uint nMaxBags, const Vector3 &in vecPosition)
    {
        if (g_pGameMaster !is null)
        {
            g_pGameMaster.GoldSpew(flGoldPerBag, nBagsPerPlayer, flDistance, nMinBags, nMaxBags, vecPosition);
        }
        else
        {
            LogError("Cannot trigger gold spew: GameMaster not initialized");
        }
    }
    
    /**
     * Request delayed NPC creation
     */
    void RequestDelayedNPC(float flDelay, const string &in szScript, const Vector3 &in vecPos,
                          const Vector3 &in vecAngles = Vector3())
    {
        if (g_pGameMaster !is null)
        {
            g_pGameMaster.DelayedCreateNPC(0, flDelay, szScript, vecPos, vecAngles);
        }
        else
        {
            LogError("Cannot create delayed NPC: GameMaster not initialized");
        }
    }
    
    /**
     * Request entity fade
     */
    void RequestEntityFade(EntityHandle hTarget, int nRenderMode = 5, uint nStartAmount = 255)
    {
        if (g_pGameMaster !is null)
        {
            g_pGameMaster.FadeEntity(hTarget, nRenderMode, nStartAmount);
        }
        else
        {
            LogError("Cannot fade entity: GameMaster not initialized");
        }
    }
    
    // ========================================
    // Advanced Trigger System Functions
    // ========================================
    
    /**
     * Evaluate a trigger filter condition
     * TODO: Re-enable when AdvancedTriggerSystem is ready
     * Moved to avoid conflicts with engine registration
     */
    bool GameMasterUtils_EvaluateTrigger(const string &in szFilter, const Vector3 &in vecPos = Vector3(0,0,0))
    {
        LogInfo("GameMasterUtils_EvaluateTrigger called but AdvancedTriggerSystem not available");
        return false; // Placeholder - always return false for now
        // return EvaluateTriggerFilter(szFilter, vecPos);
    }
    
    /**
     * Create an HP sequence trigger
     * TODO: Re-enable when HPSequenceTrigger is ready
     */
    int CreateHPSequence(const string &in szName, const Vector3 &in vecPos, float fRadius = 500.0f)
    {
        LogInfo("CreateHPSequence called but HPSequenceTrigger not available");
        return -1; // Placeholder - return failure
        // return CreateClassicHPSequence(szName, vecPos, fRadius);
    }
    
    /**
     * Add a custom HP threshold to a sequence
     * TODO: Re-enable when HPSequenceTrigger is ready
     */
    void AddHPThreshold(int nSequenceIndex, float fMinHP, float fMaxHP, const string &in szSpawnScript, 
                       uint nSpawnCount = 1, const string &in szMessage = "")
    {
        LogInfo("AddHPThreshold called but HPSequenceTrigger not available");
        // HPSequenceTrigger@ pSystem = GetHPSequenceTrigger();
        // if (pSystem is null)
        // {
        //     LogError("Cannot add HP threshold: HPSequenceTrigger not initialized");
        //     return;
        // }
        // 
        // HPThreshold threshold(fMinHP, fMaxHP, szSpawnScript, nSpawnCount);
        // threshold.szTriggerMessage = szMessage;
        // pSystem.AddThreshold(@threshold);
    }
    
    /**
     * Reset an HP sequence trigger
     * TODO: Re-enable when HPSequenceTrigger is ready
     */
    void ResetHPSequence(int nSequenceIndex)
    {
        LogInfo("ResetHPSequence called but HPSequenceTrigger not available");
        // HPSequenceTrigger@ pSystem = GetHPSequenceTrigger();
        // if (pSystem !is null)
        // {
        //     pSystem.ResetSequence();
        // }
    }
    
    /**
     * Enable/disable an HP sequence trigger
     * TODO: Re-enable when HPSequenceTrigger is ready
     */
    void SetHPSequenceEnabled(int nSequenceIndex, bool bEnabled)
    {
        LogInfo("SetHPSequenceEnabled called but HPSequenceTrigger not available");
        // HPSequenceTrigger@ pSystem = GetHPSequenceTrigger();
        // if (pSystem !is null)
        // {
        //     pSystem.SetSequenceEnabled(bEnabled);
        // }
    }
}

// ========================================
// Global Functions for Engine Integration
// ========================================

/**
 * Called by the engine when the map starts
 */
void game_master_init()
{
    MS::InitializeGameMaster();
}

/**
 * Called by the engine when the map ends
 */
void game_master_shutdown()
{
    MS::ShutdownGameMaster();
}

/**
 * Legacy compatibility function
 */
void game_spawn()
{
    // This mimics the original { game_spawn } event
    MS::InitializeGameMaster();
}