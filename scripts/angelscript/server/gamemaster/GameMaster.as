#pragma context server

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
// Core data structures and utilities
#include "server/gamemaster/GameMasterDataStructures.as"
#include "server/gamemaster/GameMasterUtils.as"
#include "server/gamemaster/GameMasterEvents.as"

// New voting and transition systems
#include "server/gamemaster/GameMasterVoting.as"
#include "server/gamemaster/GameMasterMapTransitions.as"
#include "server/gamemaster/GameMasterPlayerCommands.as"

module GameMaster
{
    // Core properties
    string m_szName;
    uint m_nSpawnTime;
    uint m_nMapUptime;
    
    // Entity tracking
    CBaseEntity@ m_hSelf;
    
    // New integrated systems
    MS::VoteManager@ m_VoteManager = null;
    MS::MapTransitionManager@ m_TransitionManager = null;
    MS::PlayerCommandHandler@ m_CommandHandler = null;

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
        
        // Initialize new integrated systems
        InitializeVotingSystem();
        InitializeTransitionSystem();
        
        // Initialize player command manager (must be before PlayerCommandSystem)
        MS::InitializePlayerCommands();
        InitializePlayerCommandSystem();
        
        // Initialize supporting systems
        InitializeAdvancedTriggerSystem();
        InitializeHPSequenceTrigger();
        InitializeEntitySpawner();
        InitializeEntityCommunications();
        
        LogInfo("GameMaster: All systems initialized successfully");
        
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
        
        // Shutdown new systems first
        ShutdownPlayerCommandSystem();
        MS::ShutdownPlayerCommands();
        ShutdownTransitionSystem();
        ShutdownVotingSystem();
        
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
        ShutdownEntityCommunications();
        ShutdownHPSequenceTrigger();
        ShutdownAdvancedTriggerSystem();
        ShutdownEntitySpawner();
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
    // New System Initialization Functions
    // ========================================
    
    /**
     * Initialize the voting system
     */
    void InitializeVotingSystem()
    {
        // Use the global singleton VoteManager instead of creating a new instance
        // This ensures votes persist across GameMaster recreation (e.g. after level changes)
        @m_VoteManager = MS::GetVoteManager();
        
        if (m_VoteManager is null)
        {
            LogError("GameMaster: CRITICAL - Failed to get global VoteManager instance!");
            return;
        }
        
        // Only initialize if not already initialized (preserves existing votes)
        if (!m_VoteManager.IsInitialized())
        {
            m_VoteManager.Initialize();
            LogInfo("GameMaster: Voting system initialized for the first time");
        }
        else
        {
            LogInfo("GameMaster: Using existing VoteManager instance (preserves active votes)");
        }
        
        LogInfo("GameMaster: VoteManager Think() will be called automatically via GameThink()");
    }
    
    /**
     * Initialize the map transition system
     */
    void InitializeTransitionSystem()
    {
        @m_TransitionManager = MS::MapTransitionManager();
        LogInfo("GameMaster: Map transition system initialized");
    }
    
    /**
     * Initialize the player command system
     */
    void InitializePlayerCommandSystem()
    {
        @m_CommandHandler = MS::PlayerCommandHandler();
        if (m_VoteManager !is null && m_TransitionManager !is null)
        {
            m_CommandHandler.SetVoteManager(m_VoteManager);
            m_CommandHandler.SetTransitionManager(m_TransitionManager);
        }
        LogInfo("GameMaster: Player command system initialized");
    }
    
    // ========================================
    // System Shutdown Functions
    // ========================================
    
    void ShutdownVotingSystem()
    {
        if (m_VoteManager !is null)
        {
            @m_VoteManager = null;
            LogInfo("GameMaster: Voting system shut down");
        }
    }
    
    void ShutdownTransitionSystem()
    {
        if (m_TransitionManager !is null)
        {
            @m_TransitionManager = null;
            LogInfo("GameMaster: Transition system shut down");
        }
    }
    
    void ShutdownPlayerCommandSystem()
    {
        if (m_CommandHandler !is null)
        {
            @m_CommandHandler = null;
            LogInfo("GameMaster: Player command system shut down");
        }
    }
    
    // ========================================
    // Public API for External Access
    // ========================================
    
    MS::VoteManager@ GetVoteManager()
    {
        return m_VoteManager;
    }
    
    MS::MapTransitionManager@ GetTransitionManager()
    {
        return m_TransitionManager;
    }
    
    MS::PlayerCommandHandler@ GetCommandHandler()
    {
        return m_CommandHandler;
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
    void FadeEntity(CBaseEntity@ hTarget, int nRenderMode = 5, uint nStartAmount = 255)
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
        LogMessage("[REGISTER] Registering TestSimpleFunction");
        RegisterEngineEvent("TestSimpleFunction", TestSimpleFunction);
        LogMessage("[REGISTER] TestSimpleFunction registration completed");
        
        // Register GameMaster's event handlers directly with the engine
        LogMessage("[REGISTER] Registering OnEnginePlayerConnect -> OnEnginePlayerConnect");
        RegisterEngineEvent("OnEnginePlayerConnect", OnEnginePlayerConnect);
        LogMessage("[REGISTER] OnEnginePlayerConnect registration completed");
        
        LogMessage("[REGISTER] Registering OnEnginePlayerDisconnect -> OnEnginePlayerDisconnect");
        RegisterEngineEvent("OnEnginePlayerDisconnect", OnEnginePlayerDisconnect);
        LogMessage("[REGISTER] OnEnginePlayerDisconnect registration completed");
        
        LogMessage("[REGISTER] Registering OnEngineMonsterKilled -> OnEngineMonsterKilled");
        RegisterEngineEvent("OnEngineMonsterKilled", OnEngineMonsterKilled);
        LogMessage("[REGISTER] OnEngineMonsterKilled registration completed");
        
        LogMessage("[REGISTER] Registering OnEngineTreasureSpawned -> OnEngineTreasureSpawned");
        RegisterEngineEvent("OnEngineTreasureSpawned", OnEngineTreasureSpawned);
        LogMessage("[REGISTER] OnEngineTreasureSpawned registration completed");
        
        LogMessage("[REGISTER] Registering OnEnginePlayerSayText -> OnEnginePlayerSayText");
        RegisterEngineEvent("OnEnginePlayerSayText", OnEnginePlayerSayText);
        LogMessage("[REGISTER] OnEnginePlayerSayText registration completed");
        
        LogInfo("GameMaster: Engine event handlers registered successfully!");
        LogMessage("[DEBUG] GameMaster: All event handlers registration complete");
        
        // Log the registered engine event handlers
        LogMessage("[DEBUG] GameMaster: Calling LogEngineEventHandlers() to verify registration");
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
 * Called by the engine when ServerActivate fires
 * This is the new entry point for spawning the game_master NPC entity
 */
void ServerActivate()
{
    LogMessage("[ANGELSCRIPT] ===== ServerActivate() CALLED =====");
    MS_ANGEL_INFO("ServerActivate: Spawning game_master NPC entity...");
    
    // Spawn the game_master NPC at far coordinates (same as legacy C++ code)
    // Using Angel mode to avoid requiring a legacy MSCScript file
    // SpawnNPC now directly returns CMSMonster@ for MS-specific functionality
    CMSMonster@ pGameMaster = SpawnNPC("game_master", Vector3(20000, -10000, -20000), null, Angel);
    
    if (pGameMaster !is null)
    {
        MS_ANGEL_INFO("ServerActivate: game_master NPC spawned successfully as CMSMonster");
        LogMessage("[ANGELSCRIPT] game_master entity spawned: " + pGameMaster.GetClassName());
        
        // Configure game_master properties after spawn
        MS_ANGEL_INFO("ServerActivate: Configuring game_master entity properties...");
        
        // Set netname AFTER Spawn (required for entity lookups by C++)
        pGameMaster.SetNetName("-game_master");
        LogMessage("[ANGELSCRIPT] Set netname to: " + pGameMaster.GetNetName());
        
        // Set health values
        pGameMaster.SetHealth(1.0f);
        
        // Set render properties (invisible)
        pGameMaster.SetRenderMode(kRenderTransTexture);
        pGameMaster.SetRenderAmount(0);
        
        // Set god mode and damage properties
        pGameMaster.SetGodMode(true);
        pGameMaster.SetTakeDamage(DAMAGE_NO);
        
        pGameMaster.m_Menu_Autoopen = false;
        
        MS_ANGEL_INFO("ServerActivate: game_master entity fully configured");
        LogMessage("[ANGELSCRIPT] game_master entity ready for C++ to find via netname: " + pGameMaster.GetNetName());
    }
    else
    {
        MS_ANGEL_ERROR("ServerActivate: CRITICAL - Failed to spawn game_master NPC or cast to CMSMonster!");
        LogMessage("[ANGELSCRIPT] ERROR: Failed to spawn game_master entity or entity is not an MSMonster!");
    }
    
    // After spawning the entity, initialize the GameMaster AngelScript module if needed
    if (g_GameMasterInstance is null)
    {
        LogMessage("[ANGELSCRIPT] ServerActivate: Creating GameMaster module instance...");
        @g_GameMasterInstance = GameMaster();
        LogMessage("[ANGELSCRIPT] ServerActivate: GameMaster module instance created");
    }
    else
    {
        LogMessage("[ANGELSCRIPT] ServerActivate: GameMaster module instance already exists");
    }
    
    LogMessage("[ANGELSCRIPT] ===== ServerActivate() COMPLETED =====");
}

/**
 * Called by the engine when the map starts
 * Maintained for backward compatibility with legacy code
 * Note: The new module system auto-instantiates, but this provides fallback


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

/**
 * Called when a player sends a chat message
 * Server has already validated this is a vote command
 * Enhanced with comprehensive null/empty validation to prevent crashes
 */
void OnEnginePlayerSayText(const string &in szPlayerName, const string &in szSteamID, const string &in szText)
{
    LogMessage("[ANGELSCRIPT] OnEnginePlayerSayText called - starting validation...");
    
    // Comprehensive parameter validation to prevent crashes
    // Check for empty/null player name
    if (szPlayerName.isEmpty())
    {
        LogMessage("[ANGELSCRIPT] ERROR: OnEnginePlayerSayText received empty player name - blocking");
        return;
    }
    
    // Check for empty/null Steam ID  
    if (szSteamID.isEmpty())
    {
        LogMessage("[ANGELSCRIPT] ERROR: OnEnginePlayerSayText received empty Steam ID - blocking");
        return;
    }
    
    // Check for empty/null text (most critical)
    if (szText.isEmpty())
    {
        LogMessage("[ANGELSCRIPT] ERROR: OnEnginePlayerSayText received empty text - blocking");
        return;
    }
    
    // Additional validation for reasonable parameter lengths
    if (szPlayerName.length() > 255)
    {
        LogMessage("[ANGELSCRIPT] ERROR: OnEnginePlayerSayText player name too long (" + formatInt(szPlayerName.length()) + ") - blocking");
        return;
    }
    
    if (szSteamID.length() > 127)
    {
        LogMessage("[ANGELSCRIPT] ERROR: OnEnginePlayerSayText Steam ID too long (" + formatInt(szSteamID.length()) + ") - blocking");
        return;
    }
    
    if (szText.length() > 511)
    {
        LogMessage("[ANGELSCRIPT] ERROR: OnEnginePlayerSayText text too long (" + formatInt(szText.length()) + ") - blocking");
        return;
    }
    
    // Additional safety checks for valid string content
    // Check if strings contain only valid printable characters (basic validation)
    for (uint i = 0; i < szText.length(); i++)
    {
        uint8 c = szText[i];
        if (c < 32 && c != 9 && c != 10 && c != 13) // Allow tab, newline, carriage return
        {
            LogMessage("[ANGELSCRIPT] ERROR: OnEnginePlayerSayText text contains invalid character (" + formatInt(c) + ") at position " + formatInt(i) + " - blocking");
            return;
        }
    }
    
    // Log successful validation
    LogMessage("[ANGELSCRIPT] OnEnginePlayerSayText validation passed for " + szPlayerName + ": '" + szText + "'");
    
    // Route to the HandlePlayerSayText function in PlayerCommands with additional safety
    try
    {
        HandlePlayerSayText(szSteamID, szPlayerName, szText);
        LogMessage("[ANGELSCRIPT] OnEnginePlayerSayText completed successfully");
    }
    catch
    {
        LogMessage("[ANGELSCRIPT] ERROR: Exception in HandlePlayerSayText - player: " + szPlayerName + ", text: " + szText);
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
void RequestEntityFade(CBaseEntity@ hTarget, int nRenderMode = 5, uint nStartAmount = 255)
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

// ========================================
// Integration Helper Functions
// ========================================

/**
 * Handle player commands - integrated with new command system
 */
void HandlePlayerCommand(const string &in szPlayerName, const string &in szCommand, const array<string> &in args)
{
    GameMaster@ gm = GetGameMaster();
    if (gm !is null && gm.GetCommandHandler() !is null)
    {
        gm.GetCommandHandler().ProcessPlayerCommand(szPlayerName, szCommand, args);
    }
}

/**
 * Handle map transition triggers - integrated with new transition system
 */
void HandleMapTransition(const string &in szDestName, const string &in szDestMap, const string &in szLocalSpawn, const string &in szDestSpawn)
{
    GameMaster@ gm = GetGameMaster();
    if (gm !is null && gm.GetTransitionManager() !is null)
    {
        gm.GetTransitionManager().GameTransitionTriggered(szDestName, szDestMap, szLocalSpawn, szDestSpawn);
    }
}

/**
 * Legacy script compatibility functions
 */
void game_transition_triggered(const string &in szDestName, const string &in szDestMap, const string &in szLocalSpawn, const string &in szDestSpawn)
{
    HandleMapTransition(szDestName, szDestMap, szLocalSpawn, szDestSpawn);
}

void game_playercmd(const string &in szPlayerName, const string &in szCommand)
{
    array<string> args;
    // Split command into parts for processing
    HandlePlayerCommand(szPlayerName, szCommand, args);
}

/**
 * Legacy compatibility function for delayed changelevel
 */
void delay_changelevel()
{
    GameMaster@ gm = GetGameMaster();
    if (gm !is null && gm.GetTransitionManager() !is null)
    {
        // Get DEST_MAP from legacy variable and execute change
        gm.GetTransitionManager().DelayedChangeLevel();
    }
}

// ========================================
// Game Think Loop
// ========================================

// Static variable to track last think time (once per frame, not per player)
float g_flLastGameThinkTime = 0.0f;

// Static flag to prevent recursive calls
bool g_bInGameThink = false;

/**
 * Called every frame by the engine for each player
 * Used to update the VoteManager and other systems that need periodic updates
 * Note: This is called once per player, so we throttle it to run once per frame
 */
void GameThink() // This will be moved and renamed in the future
{
    // Prevent recursive calls (can happen during GameMaster recreation)
    if (g_bInGameThink)
    {
        LogMessage("[ANGELSCRIPT] GameThink: Recursive call detected - skipping");
        return;
    }
    
    // Set the flag to indicate we're inside GameThink
    g_bInGameThink = true;
    
    // Only run once per frame, not once per player
    float currentTime = GetGameTime();
    if (currentTime <= g_flLastGameThinkTime)
    {
        g_bInGameThink = false;
        return;
    }
    
    g_flLastGameThinkTime = currentTime;
    
    // CRITICAL: Check if GameMaster exists, recreate if needed (after level change)
    GameMaster@ gm = GetGameMaster();
    if (gm is null)
    {
        // GameMaster was destroyed (probably by level change) - recreate it
        LogMessage("[ANGELSCRIPT] GameThink: GameMaster is null - recreating instance!");
        CreateGameMasterInstance();
        @gm = GetGameMaster();
        
        if (gm is null)
        {
            LogMessage("[ANGELSCRIPT] GameThink: ERROR - Failed to recreate GameMaster!");
            g_bInGameThink = false;
            return;
        }
        
        LogMessage("[ANGELSCRIPT] GameThink: GameMaster successfully recreated!");
    }
        
    // Update VoteManager
    MS::VoteManager@ voteManager = gm.GetVoteManager();
    if (voteManager !is null)
    {
        voteManager.Think();
    }
    
    // Update other systems that need periodic ticks here
    
    // Clear the flag before returning
    g_bInGameThink = false;
}

// ========================================
// Vote Menu Callback Handler
// ========================================

/**
 * Called when a player selects an option from the vote menu
 * This is called by the C++ menu system when MOT_CALLBACK type menus are selected
 * @param szPlayerEntity Entity string for the player (format: "ent:#index")
 * @param szOptionData The Data field from the menu option (option title in vote menus)
 */
void game_vote_menu_callback(const string &in szPlayerEntity, const string &in szOptionData)
{
    LogMessage("[ANGELSCRIPT] game_vote_menu_callback called!");
    LogMessage("[ANGELSCRIPT]   Player Entity: " + szPlayerEntity);
    LogMessage("[ANGELSCRIPT]   Option Data: " + szOptionData);
    
    // Extract player entity index from format "ent:#index"
    if (szPlayerEntity.length() < 4 || szPlayerEntity.substr(0, 4) != "ent:")
    {
        LogMessage("[ANGELSCRIPT] ERROR: Invalid player entity format: " + szPlayerEntity);
        return;
    }
    
    // Parse entity index
    int entityIndex = -1;
    string indexStr = szPlayerEntity.substr(4); // Skip "ent:"
    
    // Convert string to int manually since we don't have atoi in AngelScript
    for (uint i = 0; i < indexStr.length(); i++)
    {
        uint8 c = indexStr[i];
        if (c >= 48 && c <= 57) // '0' to '9'
        {
            if (entityIndex == -1)
                entityIndex = 0;
            entityIndex = entityIndex * 10 + int(c - 48);
        }
        else
        {
            break;
        }
    }
    
    if (entityIndex < 0)
    {
        LogMessage("[ANGELSCRIPT] ERROR: Could not parse entity index from: " + szPlayerEntity);
        return;
    }
    
    LogMessage("[ANGELSCRIPT] Parsed entity index: " + formatInt(entityIndex));
    
    // Get the player from the entity index
    CBasePlayer@ pPlayer = PlayerByIndex(entityIndex);
    if (pPlayer is null)
    {
        LogMessage("[ANGELSCRIPT] ERROR: Could not find player at index " + formatInt(entityIndex));
        return;
    }
    
    string playerSteamID = GetSteamID(pPlayer);
    string playerName = GetDisplayName(pPlayer);
    
    LogMessage("[ANGELSCRIPT] Player found: " + playerName + " (SteamID: " + playerSteamID + ")");
    LogMessage("[ANGELSCRIPT] Selected option: " + szOptionData);
    
    // Check if option data is empty (menu expired)
    if (szOptionData.isEmpty())
    {
        LogMessage("[ANGELSCRIPT] Empty option data - menu has expired");
        SendMessageToAllPlayers("yellow", playerName + ": That vote has already ended.");
        return;
    }
    
    // Forward to the VoteManager to process the vote
    GameMaster@ gm = GetGameMaster();
    if (gm is null)
    {
        // GameMaster was destroyed (probably by level change) - try to recreate it
        LogMessage("[ANGELSCRIPT] game_vote_menu_callback: GameMaster is null - attempting to recreate!");
        CreateGameMasterInstance();
        @gm = GetGameMaster();
        
        if (gm is null)
        {
            LogMessage("[ANGELSCRIPT] ERROR: GameMaster instance is null and could not be recreated!");
            return;
        }
        
        LogMessage("[ANGELSCRIPT] game_vote_menu_callback: GameMaster successfully recreated!");
    }
    
    MS::VoteManager@ voteManager = gm.GetVoteManager();
    if (voteManager !is null)
    {
        LogMessage("[ANGELSCRIPT] Forwarding vote to VoteManager...");
        bool success = voteManager.ProcessMenuSelection(playerSteamID, szOptionData);
        
        if (success)
        {
            LogMessage("[ANGELSCRIPT] Vote processed successfully!");
        }
        else
        {
            LogMessage("[ANGELSCRIPT] ERROR: Vote processing failed!");
        }
    }
    else
    {
        LogMessage("[ANGELSCRIPT] ERROR: VoteManager is null!");
    }
}