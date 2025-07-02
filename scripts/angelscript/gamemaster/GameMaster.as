/**
 * GameMaster.as
 * 
 * The main GameMaster module that manages server-wide game logic,
 * event handling, and coordination between different game systems.
 * 
 * Converted from game_master.script and merged with GameMasterInit.as
 * Now uses the new module syntax for automatic discovery and loading.
 */

// Include directives now supported with pak file integration
// Using simplified data for initial testing
#include "gamemaster/GameMasterData.as"
// TODO: Re-enable these when advanced systems are ready
#include "gamemaster/GameMasterUtils.as" 
#include "gamemaster/GameMasterEvents.as"

module GameMaster
{
    // Core properties
    string m_szName;
    uint m_nSpawnTime;
    uint m_nMapUptime;
    
    // Entity tracking
    EntityHandle m_hSelf;

    // ========================================
    // Simplified Logging Functions
    // ========================================
    
    /**
     * Simple logging functions for minimal GameMaster
     * TODO: Remove these when GameMasterUtils.as is re-enabled
     */
    void LogInfo(const string &in message)
    {
        // Use engine logging function
        LogMessage("[INFO] " + message);
    }
    
    void LogError(const string &in message)
    {
        LogMessage("[ERROR] " + message);
    }
    
    void LogWarning(const string &in message)
    {
        LogMessage("[WARNING] " + message);
    }
    
    // ========================================
    // Module Global Variables
    // ========================================
    
    // Module-level instance reference
    GameMaster@ m_GameMaster = null;
    
    // ========================================
    // Module Auto-Instantiation (New Constructor Approach)
    // ========================================
    
    /**
     * GameMaster constructor - automatically called when module loads
     * This replaces the old Init() function approach
     */
    
    // ========================================
    // GameMaster System Management
    // ========================================
    
    /**
     * Initialize the GameMaster system
     * Called by the constructor and legacy compatibility functions
     */
    void InitializeGameMaster()
    {
        LogInfo("Initializing GameMaster system...");
        
        // Check if already initialized
        if (m_GameMaster !is null)
        {
            LogWarning("GameMaster already initialized, destroying previous instance");
            @m_GameMaster = null;
        }
        
        // Initialize supporting systems first
        // TODO: Re-enable these systems once they are fully tested
        // InitializeAdvancedTriggerSystem();
        // InitializeHPSequenceTrigger();
        // InitializeEntitySpawner();
        
        // Initialize entity communication system
        // InitializeEntityCommunications();
        
        LogInfo("GameMaster: Skipping advanced systems initialization for now");
        
        // Initialize other systems that don't require the instance
        RegisterGameMasterEngineEvents();
        
        LogInfo("GameMaster system initialized successfully");
    }
    
    /**
     * Shutdown the GameMaster system
     * Called when the map unloads
     */
    void ShutdownGameMaster()
    {
        LogInfo("Shutting down GameMaster system...");
        
        if (m_GameMaster !is null)
        {
            // Clean shutdown
            @m_GameMaster = null;
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
        return m_GameMaster;
    }
    
    /**
     * Check if GameMaster is initialized
     * Moved to avoid conflicts with engine registration
     */
    bool GameMasterUtils_IsInitialized()
    {
        return m_GameMaster !is null;
    }
    
    // ========================================
    // GameMaster Module Implementation
    // ========================================
    // The Game Master entity that exists once per server and manages
    // all global game state and events.
    
    // GameMaster properties and methods (now module-level)
        
    GameMaster()
    {
        m_szName = "The Game Master";
        m_nSpawnTime = 0;
        m_nMapUptime = 0;

        LogMessage("[ANGELSCRIPT] ===== GameMaster constructor STARTED =====");
        LogInfo("[ANGELSCRIPT] GameMaster constructor called - initializing module...");
        
        // Set the module instance to this instance
        @m_GameMaster = this;
        LogMessage("[ANGELSCRIPT] Module-level instance set");
        
        // Set the global instance reference for backward compatibility
        @g_GameMasterInstance = this;
        LogMessage("[ANGELSCRIPT] Global instance reference set");
        
        // Also set g_GameMaster if it exists (from the auto-generated wrapper)
        @g_GameMaster = this;
        LogMessage("[ANGELSCRIPT] Auto-generated wrapper instance updated");
        
        // Initialize the GameMaster system (previously done in Init())
        LogMessage("[ANGELSCRIPT] About to call InitializeGameMaster()");
        InitializeGameMaster();
        LogMessage("[ANGELSCRIPT] InitializeGameMaster() completed");
        
        // Call Spawn to complete initialization
        LogMessage("[ANGELSCRIPT] About to call Spawn()");
        Spawn();
        LogMessage("[ANGELSCRIPT] Spawn() completed");
        
        LogMessage("[ANGELSCRIPT] ===== GameMaster constructor COMPLETED =====");
        
        // Debug instance states after constructor
        DebugGameMasterInstances();
    }

    /**
     * Called when the game master entity spawns in the world
     */
    void Spawn()
    {
        LogInfo("***************** Game_Master - Spawned");
    }

    // ========================================
    // Event Handler Methods
    // ========================================

    /**
     * Called when a player connects to the server
     */
    void OnPlayerConnect(const string &in szPlayerName)
    {
        LogMessage("[ANGELSCRIPT] GameMaster.OnPlayerConnect called for " + szPlayerName);
        LogInfo("[ANGELSCRIPT] GameMaster: Player connected - " + szPlayerName);
        // TODO: Implement actual player connection handling
        LogMessage("[ANGELSCRIPT] GameMaster.OnPlayerConnect completed for " + szPlayerName);
    }

    /**
     * Called when a player disconnects from the server
     */
    void OnPlayerDisconnect(const string &in szPlayerName)
    {
        LogInfo("GameMaster: Player disconnected - " + szPlayerName);
        // TODO: Implement actual player disconnection handling
    }

    /**
     * Called when a monster is killed
     */
    void OnMonsterKilled(const string &in szMonsterName, const string &in szKillerName)
    {
        LogInfo("GameMaster: Monster killed - " + szMonsterName + " by " + szKillerName);
        // TODO: Implement actual monster death handling
    }

    /**
     * Called when treasure is spawned
     */
    void OnTreasureSpawned(const string &in szTreasureType)
    {
        LogInfo("GameMaster: Treasure spawned - " + szTreasureType);
        // TODO: Implement actual treasure spawn handling
    }

    /**
     * Handles gold spew effects
     */
    void GoldSpew(float flGoldPerBag, uint nBagsPerPlayer, float flDistance, 
                 uint nMinBags, uint nMaxBags, const Vector3 &in vecPosition)
    {
        LogInfo("GameMaster: Gold spew triggered at position " + vecPosition.x + ", " + vecPosition.y + ", " + vecPosition.z);
        // TODO: Implement actual gold spew effect
    }

    /**
     * Creates an NPC with a delay
     */
    void DelayedCreateNPC(uint nNPCIndex, float flDelay, const string &in szScript, const Vector3 &in vecPosition, const Vector3 &in vecAngles)
    {
        LogInfo("GameMaster: Delayed NPC creation requested - " + szScript);
        // TODO: Implement actual delayed NPC creation
    }

    /**
     * Fades an entity
     */
    void FadeEntity(EntityHandle hTarget, int nRenderMode = 5, uint nStartAmount = 255)
    {
        LogInfo("GameMaster: Entity fade requested");
        // TODO: Implement actual entity fading
    }

    
    // ========================================
    // Engine Event Registration
    // ========================================
    
    /**
     * Register GameMaster event handlers with the engine event system
     */
    void RegisterGameMasterEngineEvents()
    {
        LogInfo("GameMaster: Registering engine event handlers directly...");
        LogMessage("[DEBUG] GameMaster: About to register event handlers");
        
        // First test with a simple function to verify registration works
        RegisterEngineEvent("TestSimpleFunction", TestSimpleFunction);
        LogMessage("[DEBUG] GameMaster: Registered TestSimpleFunction handler");
        
        // Register GameMaster's event handlers directly with the engine
        RegisterEngineEvent("OnEnginePlayerConnect", OnEnginePlayerConnect);
        LogMessage("[DEBUG] GameMaster: Registered OnEnginePlayerConnect handler");
        
        RegisterEngineEvent("OnEnginePlayerDisconnect", OnEnginePlayerDisconnect);
        LogMessage("[DEBUG] GameMaster: Registered OnEnginePlayerDisconnect handler");
        
        RegisterEngineEvent("OnEngineMonsterKilled", OnEngineMonsterKilled);
        LogMessage("[DEBUG] GameMaster: Registered OnEngineMonsterKilled handler");
        
        RegisterEngineEvent("OnEngineTreasureSpawned", OnEngineTreasureSpawned);
        LogMessage("[DEBUG] GameMaster: Registered OnEngineTreasureSpawned handler");
        
        LogInfo("GameMaster: Engine event handlers registered successfully!");
        LogMessage("[DEBUG] GameMaster: All event handlers registration complete");
        
        // Log the registered engine event handlers
        LogEngineEventHandlers();
    }
    
    // Event handler methods are now handled by the global functions below
    // which call into the GameMaster instance methods
    
    // ========================================
    // Engine Event Callbacks (moved to global scope below)
    // ========================================
    
    // ========================================
    // Utility Functions for External Scripts (moved to global scope below)
    // ========================================
    
    // ========================================
    // Advanced Trigger System Functions (moved to global scope below)
    // ========================================
}

// Module-level instance reference set by constructor
GameMaster@ g_GameMasterInstance = null;

// Global accessor function to get the GameMaster instance
GameMaster@ GetGameMaster()
{
    // First check g_GameMasterInstance (set by constructor)
    if (g_GameMasterInstance !is null)
        return g_GameMasterInstance;
    
    // Fallback to auto-generated g_GameMaster from module wrapper
    if (g_GameMaster !is null)
        return g_GameMaster;
        
    return null;
}

// Debug function to print instance states
void DebugGameMasterInstances()
{
    LogMessage("[ANGELSCRIPT] === GameMaster Instance Debug ===");
    
    if (g_GameMasterInstance !is null)
    {
        LogMessage("[ANGELSCRIPT] g_GameMasterInstance: VALID instance found");
    }
    else
    {
        LogMessage("[ANGELSCRIPT] g_GameMasterInstance: NULL");
    }
    
    if (g_GameMaster !is null)
    {
        LogMessage("[ANGELSCRIPT] g_GameMaster: VALID instance found");
    }
    else
    {
        LogMessage("[ANGELSCRIPT] g_GameMaster: NULL");
    }
    
    GameMaster@ current = GetGameMaster();
    if (current !is null)
    {
        LogMessage("[ANGELSCRIPT] GetGameMaster(): VALID instance returned");
    }
    else
    {
        LogMessage("[ANGELSCRIPT] GetGameMaster(): NULL returned");
    }
    
    LogMessage("[ANGELSCRIPT] ====================================");
}

// Function to manually create the GameMaster instance
void CreateGameMasterInstance()
{
    if (g_GameMasterInstance is null)
    {
        LogMessage("[ANGELSCRIPT] Creating new GameMaster instance...");
        @g_GameMasterInstance = GameMaster();
        LogMessage("[ANGELSCRIPT] GameMaster instance created successfully");
    }
    else
    {
        LogMessage("[ANGELSCRIPT] GameMaster instance already exists - using existing instance");
    }
}

// ========================================
// Global Functions for Engine Integration
// (Outside module scope for global accessibility)
// ========================================

/**
 * Called by the engine when the map starts
 * Maintained for backward compatibility with legacy code
 * Note: The new module system auto-instantiates, but this provides fallback
 */
void game_master_init()
{
    LogMessage("[ANGELSCRIPT] game_master_init() called from C++ engine!");
    
    // Check if instance already exists
    if (g_GameMasterInstance is null)
    {
        LogMessage("[ANGELSCRIPT] GameMaster instance not found - creating new instance");
        @g_GameMasterInstance = GameMaster();
        LogMessage("[ANGELSCRIPT] GameMaster instance created!");
    }
    else
    {
        LogMessage("[ANGELSCRIPT] GameMaster instance already exists!");
    }
    
    // Verify the instance is accessible via GetGameMaster()
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        LogMessage("[ANGELSCRIPT] GameMaster instance verified and accessible!");
    }
    else
    {
        LogMessage("[ANGELSCRIPT] ERROR: GameMaster instance is null after verification!");
    }
    
    // Debug all instance states
    DebugGameMasterInstances();
}

/**
 * Called by the engine when the map ends
 * Maintained for backward compatibility with legacy code
 */
void game_master_shutdown()
{
    LogMessage("[ANGELSCRIPT] game_master_shutdown() called");
    @g_GameMasterInstance = null;
}

/**
 * Legacy compatibility function
 * Maintained for backward compatibility with legacy code
 */
void game_spawn()
{
    // This mimics the original { game_spawn } event
    LogMessage("[ANGELSCRIPT] game_spawn() called from C++ engine!");
    
    // Ensure GameMaster exists
    if (g_GameMasterInstance is null)
    {
        LogMessage("[ANGELSCRIPT] Creating GameMaster instance in game_spawn");
        @g_GameMasterInstance = GameMaster();
    }
    
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        LogMessage("[ANGELSCRIPT] GameMaster instance found, triggering spawn event...");
        gm.Spawn();
    }
    else
    {
        LogMessage("[ANGELSCRIPT] ERROR: GameMaster instance not found during spawn!");
    }
}

// ========================================
// Engine Event Callbacks (Global Functions)
// ========================================

/**
 * Simple test function with no parameters to verify the event system works
 */
void TestSimpleFunction()
{
    LogMessage("[ANGELSCRIPT] SUCCESS: TestSimpleFunction called! Event system is working!");
}

/**
 * Test function to verify LogMessage works
 */
void TestLogMessage()
{
    LogMessage("[TEST] LogMessage is working!");
    LogMessage("[TEST] This is a test message from AngelScript");
}

/**
 * Called when a player connects
 * This would be hooked up to the engine's player connect event
 */
void OnEnginePlayerConnect(string szPlayerName, string szSteamID)
{
    // Start with basic logging to confirm handler execution
    LogMessage("[ANGELSCRIPT] ====== OnEnginePlayerConnect START ======");
    
    // Log the received parameters
    LogMessage("[ANGELSCRIPT] Player: " + szPlayerName + ", SteamID: " + szSteamID);
    
    // Debug instance states when event is fired
    DebugGameMasterInstances();
    
    // Try to get GameMaster instance
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        LogMessage("[ANGELSCRIPT] GameMaster instance found - calling OnPlayerConnect");
        gm.OnPlayerConnect(szPlayerName);
        LogMessage("[ANGELSCRIPT] OnPlayerConnect call completed successfully");
    }
    else
    {
        LogMessage("[ANGELSCRIPT] ERROR: GameMaster instance is null!");
    }
    
    LogMessage("[ANGELSCRIPT] ====== OnEnginePlayerConnect END ======");
}

/**
 * Called when a player disconnects
 */
void OnEnginePlayerDisconnect(const string &in szPlayerName, const string &in szSteamID)
{
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        gm.OnPlayerDisconnect(szPlayerName);
    }
}

/**
 * Called when a monster is killed
 */
void OnEngineMonsterKilled(const string &in szMonsterName, const string &in szKillerName, const Vector3 &in vecDeathPos)
{
    LogMessage("HANDLER: OnEngineMonsterKilled - " + szMonsterName + " killed by " + szKillerName);
    
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        gm.OnMonsterKilled(szMonsterName, szKillerName);
        
        // Trigger gold spew if monster had gold
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
            LogMessage("HANDLER: Boss detected, triggering gold spew");
            gm.GoldSpew(100.0f, 3, 150.0f, 8, 25, vecDeathPos);
        }
    }
}

/**
 * Called when treasure is spawned
 */
void OnEngineTreasureSpawned(const string &in szTreasureType, const Vector3 &in vecPos)
{
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        gm.OnTreasureSpawned(szTreasureType);
    }
}

// ========================================
// Utility Functions for External Scripts (Global Functions)
// ========================================

/**
 * Trigger gold spew from external scripts
 */
void TriggerGoldSpew(float flGoldPerBag, uint nBagsPerPlayer, float flDistance,
                    uint nMinBags, uint nMaxBags, const Vector3 &in vecPosition)
{
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        gm.GoldSpew(flGoldPerBag, nBagsPerPlayer, flDistance, nMinBags, nMaxBags, vecPosition);
    }
    else
    {
        LogMessage("[ERROR] Cannot trigger gold spew: GameMaster not initialized");
    }
}

/**
 * Request delayed NPC creation
 */
void RequestDelayedNPC(float flDelay, const string &in szScript, const Vector3 &in vecPos,
                      const Vector3 &in vecAngles = Vector3())
{
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        gm.DelayedCreateNPC(0, flDelay, szScript, vecPos, vecAngles);
    }
    else
    {
        LogMessage("[ERROR] Cannot create delayed NPC: GameMaster not initialized");
    }
}

/**
 * Request entity fade
 */
void RequestEntityFade(EntityHandle hTarget, int nRenderMode = 5, uint nStartAmount = 255)
{
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        gm.FadeEntity(hTarget, nRenderMode, nStartAmount);
    }
    else
    {
        LogMessage("[ERROR] Cannot fade entity: GameMaster not initialized");
    }
}