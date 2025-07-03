/**
 * GameMasterMapTransitions.as
 * 
 * Map transition system for GameMaster in AngelScript.
 * Handles map transitions, validation, player state preservation,
 * voting system integration, and msarea_transition entity management.
 * 
 * Ported from MSCScripts/scripts/game_master/map_transitions.script
 * with enhanced functionality and AngelScript integration.
 */

#include "gamemaster/GameMasterDataStructures.as"

namespace MS
{
    // ========================================
    // Map Transition Constants
    // ========================================
    
    const float CHANGELEVEL_DELAY = 5.0f;
    const float VOTE_TIMEOUT = 20.0f;
    const string DEFAULT_WEATHER = "clear";
    
    // Map type constants
    const string MAP_TYPE_FN_SERVER = "fn_server";
    const string MAP_TYPE_GAUNTLET = "gauntlet";
    const string MAP_TYPE_HIDDEN = "hidden";
    const string MAP_TYPE_ROOT_TOWN = "root_town";
    
    // ========================================
    // Map Transition Data Structures
    // ========================================
    
    /**
     * Structure for map transition information
     */
    class MapTransitionData
    {
        string szMapTitle;        // Display name for the map
        string szDestMap;         // Destination map BSP name
        string szLocalSpawn;      // Local transition spawn point
        string szDestSpawn;       // Destination spawn point
        string szMapType;         // Type of map (fn_server, gauntlet, etc.)
        bool bRequiresVote;       // Whether transition requires voting
        bool bIsRestricted;       // Whether map has access restrictions
        
        MapTransitionData()
        {
            szMapTitle = "";
            szDestMap = "";
            szLocalSpawn = "";
            szDestSpawn = "";
            szMapType = "";
            bRequiresVote = true;
            bIsRestricted = false;
        }
        
        MapTransitionData(const string &in title, const string &in destMap, 
                         const string &in localSpawn, const string &in destSpawn)
        {
            szMapTitle = title;
            szDestMap = destMap;
            szLocalSpawn = localSpawn;
            szDestSpawn = destSpawn;
            szMapType = "";
            bRequiresVote = true;
            bIsRestricted = false;
        }
    }
    
    /**
     * Structure for player transition state
     */
    class PlayerTransitionState
    {
        string szSteamID;         // Player Steam ID
        string szDestMap;         // Destination map
        string szCurrentSpawn;    // Current spawn point
        string szNextSpawn;       // Next spawn point
        bool bInTransition;       // Whether player is transitioning
        float flTransitionTime;   // When transition started
        
        PlayerTransitionState()
        {
            szSteamID = "";
            szDestMap = "";
            szCurrentSpawn = "";
            szNextSpawn = "";
            bInTransition = false;
            flTransitionTime = 0.0f;
        }
    }
    
    // ========================================
    // Map Transition Manager Class
    // ========================================
    
    /**
     * Manager class for map transitions
     * Provides object-oriented interface to transition functions
     */
    class MapTransitionManager
    {
        /**
         * Constructor
         */
        MapTransitionManager()
        {
            // Initialize transition system
        }
        
        /**
         * Handle transition triggered event
         */
        void GameTransitionTriggered(const string &in szMapTitle, const string &in szDestMap,
                                    const string &in szLocalSpawn, const string &in szDestSpawn)
        {
            MS::GameTransitionTriggered(szMapTitle, szDestMap, szLocalSpawn, szDestSpawn);
        }
        
        /**
         * Execute manual map change
         */
        void ExecuteManualMapChange(const string &in szDestMap, const string &in szDestSpawn = "")
        {
            MS::ExecuteManualMapChange(szDestMap, szDestSpawn);
        }
        
        /**
         * Handle delayed level change
         */
        void DelayedChangeLevel()
        {
            MS::DelayedChangeLevel();
        }
        
        /**
         * Check if map exists
         */
        bool MapExists(const string &in szMapName)
        {
            return MS::MapExists(szMapName);
        }
        
        /**
         * Check if transitions are disabled
         */
        bool AreTransitionsDisabled()
        {
            return MS::AreTransitionsDisabled();
        }
        
        /**
         * Get current destination map
         */
        string GetDestinationMap()
        {
            return MS::GetDestinationMap();
        }
    }
    
    // ========================================
    // Global Variables
    // ========================================
    
    // Transition state tracking
    bool g_bChangeLevel = false;
    bool g_bDisableTransitions = false;
    string g_szDestMap = "";
    string g_szDestTrans = "";
    bool g_bVoteInProgress = false;
    
    // Player state tracking
    dictionary g_PlayerTransitions;  // Maps Steam ID to PlayerTransitionState
    
    // Map validation cache
    dictionary g_MapExistsCache;     // Maps map name to existence boolean
    dictionary g_MapRestrictionsCache; // Maps map name to restriction data
    
    // ========================================
    // Core Map Transition Functions
    // ========================================
    
    /**
     * Main transition trigger handler
     * Called when player activates a transition
     * 
     * @param szMapTitle Display title for the destination map
     * @param szDestMap Destination BSP file name
     * @param szLocalSpawn Local transition spawn point
     * @param szDestSpawn Destination spawn point
     */
    void GameTransitionTriggered(const string &in szMapTitle, const string &in szDestMap,
                                const string &in szLocalSpawn, const string &in szDestSpawn)
    {
        MS::LogInfo("GameTransitionTriggered: " + szMapTitle + " -> " + szDestMap);
        
        // Create transition data
        MapTransitionData transData(szMapTitle, szDestMap, szLocalSpawn, szDestSpawn);
        
        // Set global destination spawn for compatibility
        g_szDestTrans = szDestSpawn;
        
        // Validate map existence
        if (!MapExists(szDestMap))
        {
            string errorMsg = szDestMap + " does not exist on this server. Perhaps this is a future transition point?";
            SendMessageToAllPlayers("green", errorMsg);
            MS::LogWarning("Map does not exist: " + szDestMap);
            return;
        }
        
        // Validate map access permissions
        if (!ValidateMapAccess(szDestMap))
        {
            string errorMsg = "Access to " + szDestMap + " is restricted.";
            SendMessageToAllPlayers("red", errorMsg);
            MS::LogWarning("Map access denied: " + szDestMap);
            return;
        }
        
        // Set transition data for all players
        SetAllPlayersTransitionData(szDestMap, szLocalSpawn, szDestSpawn);
        
        // Check if voting is required
        int nPlayerCount = GetPlayerCount();
        if (nPlayerCount > 1 && transData.bRequiresVote)
        {
            StartMapTransitionVote(transData);
        }
        else
        {
            // Single player or vote not required - change immediately
            ExecuteManualMapChange(szDestMap, szDestSpawn);
        }
    }
    
    /**
     * Execute manual map change (with optional destination spawn)
     * 
     * @param szDestMap Destination map name
     * @param szDestSpawn Optional destination spawn point
     */
    void ExecuteManualMapChange(const string &in szDestMap, const string &in szDestSpawn = "")
    {
        if (g_bChangeLevel)
        {
            MS::LogWarning("Map change already in progress, ignoring request");
            return;
        }
        
        MS::LogInfo("ExecuteManualMapChange: " + szDestMap + " spawn: " + szDestSpawn);
        
        // Disable transitions to prevent code-side spawn changes
        g_bDisableTransitions = true;
        g_bChangeLevel = true;
        
        // Set destination map
        g_szDestMap = szDestMap;
        
        // Determine final spawn point
        string szFinalSpawn = szDestSpawn;
        if (szFinalSpawn.length() == 0)
        {
            szFinalSpawn = g_szDestTrans;
        }
        
        // Set spawn points for all players
        SetAllPlayersSpawn(szFinalSpawn);
        
        // Log changelevel to server
        ExecuteServerCommand("echo Changelevel: " + szDestMap);
        
        // Reset weather system
        ResetWeatherForTransition();
        
        // Unlock server if it was locked
        if (IsServerLocked())
        {
            UnlockServer();
        }
        
        // Prepare all players for level change
        int nPlayerCount = MS::GetActivePlayerCount();
        if (nPlayerCount > 0)
        {
            PrepareAllPlayersForTransition();
        }
        
        // Display transition message
        string szMessage = "TRAVELING TO " + szDestMap;
        SendInfoMessageToAll(szMessage, "You will be reconnected shortly.");
        
        // Clear vote state
        g_bVoteInProgress = false;
        
        // Schedule actual level change
        ScheduleDelayedEvent(CHANGELEVEL_DELAY, "DelayedChangeLevel");
    }
    
    /**
     * Handle game trigger events (touch_trans_, force_map_, etc.)
     * 
     * @param szTriggerName Name of the triggered event
     */
    void GameTriggered(const string &in szTriggerName)
    {
        MS::LogInfo("GameTriggered: " + szTriggerName);
        
        if (g_bChangeLevel)
        {
            MS::LogInfo("Map change in progress, ignoring trigger: " + szTriggerName);
            return;
        }
        
        // Handle touch_trans_ triggers (invalid spawn fallback)
        if (szTriggerName.findFirst("touch_trans_") == 0)
        {
            string szMapToVote = szTriggerName.substr(11); // Remove "touch_trans_" prefix
            
            // Create vote for returning to gauntlet start
            string szVoteTitle = "Change to " + szMapToVote + "?";
            array<string> voteOptions = {"Yes!:" + szMapToVote, "No!:0"};
            
            StartGenericVote("gm_votemap", voteOptions, szVoteTitle, "Voting begins now!");
        }
        // Handle force_map_ triggers (immediate map change)
        else if (szTriggerName.findFirst("force_map_") == 0)
        {
            string szForceMap = szTriggerName.substr(10); // Remove "force_map_" prefix
            
            MS::LogInfo("Force map change to: " + szForceMap);
            ExecuteManualMapChange(szForceMap);
        }
        else
        {
            MS::LogWarning("Unknown trigger type: " + szTriggerName);
        }
    }
    
    // ========================================
    // Map Validation Functions
    // ========================================
    
    /**
     * Check if a map exists on the server
     * Uses caching for performance
     * 
     * @param szMapName Map name to check (without .bsp extension)
     * @return True if map exists
     */
    bool MapExists(const string &in szMapName)
    {
        // Check cache first
        bool bExists;
        if (g_MapExistsCache.get(szMapName, bExists))
        {
            return bExists;
        }
        
        // Query engine for map existence
        bExists = EngineMapExists(szMapName);
        
        // Cache result
        g_MapExistsCache[szMapName] = bExists;
        
        MS::LogInfo("Map existence check: " + szMapName + " = " + (bExists ? "true" : "false"));
        return bExists;
    }
    
    /**
     * Validate map access permissions
     * Checks for FN server restrictions, hidden maps, etc.
     * 
     * @param szMapName Map name to validate
     * @return True if access is allowed
     */
    bool ValidateMapAccess(const string &in szMapName)
    {
        // Check cache first
        bool bAllowed;
        if (g_MapRestrictionsCache.get(szMapName, bAllowed))
        {
            return bAllowed;
        }
        
        bAllowed = true; // Default to allowed
        
        // Check for FN server restrictions
        if (IsFNServerMap(szMapName) && !IsPlayerAllowedFNAccess())
        {
            bAllowed = false;
            MS::LogInfo("FN server access denied for map: " + szMapName);
        }
        
        // Check for hidden map restrictions
        if (IsHiddenMap(szMapName) && !IsPlayerAllowedHiddenAccess())
        {
            bAllowed = false;
            MS::LogInfo("Hidden map access denied for map: " + szMapName);
        }
        
        // Check for gauntlet restrictions
        if (IsGauntletMap(szMapName) && !ValidateGauntletAccess(szMapName))
        {
            bAllowed = false;
            MS::LogInfo("Gauntlet access denied for map: " + szMapName);
        }
        
        // Cache result
        g_MapRestrictionsCache[szMapName] = bAllowed;
        
        return bAllowed;
    }
    
    /**
     * Check if map is on FN server list
     */
    bool IsFNServerMap(const string &in szMapName)
    {
        // TODO: Implement FN server map list checking
        // This would typically check against a predefined list or server configuration
        return false;
    }
    
    /**
     * Check if map is hidden/admin-only
     */
    bool IsHiddenMap(const string &in szMapName)
    {
        // TODO: Implement hidden map checking
        // This would check against admin-only map lists
        return false;
    }
    
    /**
     * Check if map is part of a gauntlet
     */
    bool IsGauntletMap(const string &in szMapName)
    {
        // Basic gauntlet detection - look for common gauntlet prefixes
        return (szMapName.findFirst("gauntlet_") == 0 || 
                szMapName.findFirst("trial_") == 0 ||
                szMapName.findFirst("challenge_") == 0);
    }
    
    /**
     * Validate gauntlet access requirements
     */
    bool ValidateGauntletAccess(const string &in szMapName)
    {
        // TODO: Implement gauntlet-specific access validation
        // This might check player level, quest completion, etc.
        return true;
    }
    
    /**
     * Check if player has FN server access
     */
    bool IsPlayerAllowedFNAccess()
    {
        // TODO: Implement FN server access checking
        // This would check player permissions, subscription status, etc.
        return true;
    }
    
    /**
     * Check if player has hidden map access
     */
    bool IsPlayerAllowedHiddenAccess()
    {
        // TODO: Implement hidden map access checking
        // This would check admin status, special permissions, etc.
        return true;
    }
    
    // ========================================
    // Player State Management
    // ========================================
    
    /**
     * Set transition data for all players
     */
    void SetAllPlayersTransitionData(const string &in szDestMap, const string &in szLocalSpawn, const string &in szDestSpawn)
    {
        MS::LogInfo("Setting transition data for all players: " + szDestMap);
        
        // Get all active players
        array<string> playerList = MS::GetAllPlayerSteamIDs();
        
        for (uint i = 0; i < playerList.length(); i++)
        {
            SetPlayerTransitionData(playerList[i], szDestMap, szLocalSpawn, szDestSpawn);
        }
    }
    
    /**
     * Set transition data for a specific player
     */
    void SetPlayerTransitionData(const string &in szSteamID, const string &in szDestMap, 
                               const string &in szLocalSpawn, const string &in szDestSpawn)
    {
        PlayerTransitionState@ state;
        
        // Get or create player state
        if (!g_PlayerTransitions.get(szSteamID, @state))
        {
            @state = PlayerTransitionState();
            g_PlayerTransitions[szSteamID] = @state;
        }
        
        // Update transition data
        state.szSteamID = szSteamID;
        state.szDestMap = szDestMap;
        state.szCurrentSpawn = szLocalSpawn;
        state.szNextSpawn = szDestSpawn;
        state.bInTransition = true;
        state.flTransitionTime = GetGameTime();
        
        // Call external player function to set map quest data
        CallPlayerExternal(szSteamID, "ext_set_map", {szDestMap, szLocalSpawn, szDestSpawn});
        
        MS::LogInfo("Set transition data for player " + szSteamID + ": " + szDestMap);
    }
    
    /**
     * Set spawn point for all players
     */
    void SetAllPlayersSpawn(const string &in szSpawnPoint)
    {
        MS::LogInfo("Setting spawn point for all players: " + szSpawnPoint);
        
        array<string> playerList = MS::GetAllPlayerSteamIDs();
        
        for (uint i = 0; i < playerList.length(); i++)
        {
            CallPlayerExternal(playerList[i], "ext_setspawn", {szSpawnPoint});
        }
    }
    
    /**
     * Prepare all players for level change
     */
    void PrepareAllPlayersForTransition()
    {
        MS::LogInfo("Preparing all players for transition");
        
        array<string> playerList = MS::GetAllPlayerSteamIDs();
        
        for (uint i = 0; i < playerList.length(); i++)
        {
            CallPlayerExternal(playerList[i], "ext_changelevel_prep", {});
        }
    }
    
    /**
     * Clean up player transition state
     */
    void CleanupPlayerTransitionState(const string &in szSteamID)
    {
        PlayerTransitionState@ state;
        if (g_PlayerTransitions.get(szSteamID, @state))
        {
            state.bInTransition = false;
            state.flTransitionTime = 0.0f;
        }
    }
    
    // ========================================
    // Voting System Integration
    // ========================================
    
    /**
     * Start a map transition vote
     */
    void StartMapTransitionVote(const MapTransitionData &in transData)
    {
        if (g_bVoteInProgress)
        {
            MS::LogWarning("Vote already in progress, cannot start map transition vote");
            return;
        }
        
        MS::LogInfo("Starting map transition vote for: " + transData.szMapTitle);
        
        string szVoteTitle = "Travel to " + transData.szMapTitle + "?";
        array<string> voteOptions = {
            "Yes!:" + transData.szDestMap,
            "No!:0"
        };
        
        g_bVoteInProgress = true;
        
        // Call external vote system
        StartGenericVote("gm_votemap", voteOptions, szVoteTitle, "Voting begins now!");
    }
    
    /**
     * Handle map vote result
     * Called by voting system when vote completes
     * 
     * @param szOptionTitle Title of selected option
     * @param szMapDestination Map destination (0 if vote failed)
     */
    void HandleMapVoteResult(const string &in szOptionTitle, const string &in szMapDestination)
    {
        MS::LogInfo("Map vote result: " + szOptionTitle + " -> " + szMapDestination);
        
        g_bVoteInProgress = false;
        
        if (szMapDestination != "0" && szMapDestination.length() > 0)
        {
            // Vote passed - change map
            ExecuteManualMapChange(szMapDestination);
        }
        else
        {
            // Vote failed - stay on current map
            MS::LogInfo("Map transition vote failed");
        }
    }
    
    /**
     * Start a generic vote
     */
    void StartGenericVote(const string &in szCallbackEvent, const array<string> &in voteOptions,
                         const string &in szTitle, const string &in szDescription)
    {
        MS::LogInfo("Starting generic vote: " + szTitle);
        
        // Build options string
        string szOptionsString = "";
        for (uint i = 0; i < voteOptions.length(); i++)
        {
            if (i > 0) szOptionsString += ";";
            szOptionsString += voteOptions[i];
        }
        
        // Call external vote system
        CallGameMasterExternal("gm_create_vote", {szCallbackEvent, szOptionsString, szTitle, szDescription, "0"});
    }
    
    // ========================================
    // Weather and Environment Management
    // ========================================
    
    /**
     * Reset weather system for map transition
     */
    void ResetWeatherForTransition()
    {
        MS::LogInfo("Resetting weather for transition");
        
        // Clear weather lock
        SetGlobalVariable("G_WEATHER_LOCK", DEFAULT_WEATHER);
        SetGlobalVariable("global.map.weather", DEFAULT_WEATHER + ";" + DEFAULT_WEATHER + ";" + DEFAULT_WEATHER);
        SetGlobalVariable("G_OVERRIDE_WEATHER_CODE", DEFAULT_WEATHER + ";" + DEFAULT_WEATHER + ";" + DEFAULT_WEATHER);
        SetGlobalVariable("G_CUR_WEATHER", DEFAULT_WEATHER);
        SetGlobalVariable("G_MAP_ADDPARAMS", "0");
    }
    
    // ========================================
    // Server Management
    // ========================================
    
    /**
     * Check if server is locked
     */
    bool IsServerLocked()
    {
        // TODO: Implement server lock checking
        // This would check G_SERVER_LOCKED global variable
        return false;
    }
    
    /**
     * Unlock the server
     */
    void UnlockServer()
    {
        MS::LogInfo("Unlocking server for map transition");
        
        // Clear server password
        ExecuteServerCommand("sv_password \"\"");
    }
    
    // ========================================
    // Delayed Event Handling
    // ========================================
    
    /**
     * Handle delayed changelevel execution
     */
    void DelayedChangeLevel()
    {
        if (!g_bChangeLevel)
        {
            MS::LogWarning("DelayedChangeLevel called but change level flag is false");
            return;
        }
        
        if (g_szDestMap.length() == 0)
        {
            MS::LogError("DelayedChangeLevel called but destination map is empty");
            return;
        }
        
        MS::LogInfo("Executing delayed changelevel to: " + g_szDestMap);
        
        // Execute the actual changelevel command
        ExecuteServerCommand("changelevel " + g_szDestMap);
        
        // Reset state
        g_bChangeLevel = false;
        g_bDisableTransitions = false;
        g_szDestMap = "";
        g_szDestTrans = "";
    }
    
    // ========================================
    // Utility Functions
    // ========================================
    
    /**
     * Schedule a delayed event
     */
    void ScheduleDelayedEvent(float flDelay, const string &in szEventName)
    {
        // TODO: Implement event scheduling
        // This would use the engine's event scheduling system
        MS::LogInfo("Scheduling delayed event: " + szEventName + " in " + flDelay + " seconds");
    }
    
    // Note: GetCurrentTime function removed - using MS::GetGameTime() instead
    
    // Note: GetActivePlayerCount function removed - using MS::GetPlayerCount() instead
    
    // Note: GetAllPlayerSteamIDs function removed - using MS::GetAllPlayerSteamIDs() instead
    
    // ========================================
    // Engine Interface Functions (Stubs)
    // ========================================
    
    /**
     * Check if map exists via engine
     */
    bool EngineMapExists(const string &in szMapName)
    {
        // TODO: Implement engine map existence check
        // This would call the engine's $map_exists function
        return true;
    }
    
    /**
     * Execute a server command
     */
    void ExecuteServerCommand(const string &in szCommand)
    {
        MS::LogInfo("Server command: " + szCommand);
        // TODO: Implement server command execution
    }
    
    /**
     * Call external function on a player
     */
    void CallPlayerExternal(const string &in szSteamID, const string &in szFunction, const array<string> &in args)
    {
        MS::LogInfo("Player external call: " + szSteamID + " -> " + szFunction);
        // TODO: Implement player external function calls
    }
    
    /**
     * Call external function on GameMaster
     */
    void CallGameMasterExternal(const string &in szFunction, const array<string> &in args)
    {
        MS::LogInfo("GameMaster external call: " + szFunction);
        // TODO: Implement GameMaster external function calls
    }
    
    /**
     * Send message to all players
     */
    void SendMessageToAllPlayers(const string &in szColor, const string &in szMessage)
    {
        MS::LogInfo("Message to all [" + szColor + "]: " + szMessage);
        // TODO: Implement message sending
    }
    
    /**
     * Send info message to all players
     */
    void SendInfoMessageToAll(const string &in szTitle, const string &in szMessage)
    {
        MS::LogInfo("Info message [" + szTitle + "]: " + szMessage);
        // TODO: Implement info message sending
    }
    
    /**
     * Set global variable
     */
    void SetGlobalVariable(const string &in szVarName, const string &in szValue)
    {
        MS::LogInfo("Set global var: " + szVarName + " = " + szValue);
        // TODO: Implement global variable setting
    }
    
    // Note: LogInfo, LogWarning, LogError functions removed - using MS:: namespace functions instead
    
    // ========================================
    // External API Functions
    // ========================================
    
    /**
     * Initialize the map transitions system
     */
    void Initialize()
    {
        MS::LogInfo("Initializing GameMaster Map Transitions system");
        
        // Clear state
        g_bChangeLevel = false;
        g_bDisableTransitions = false;
        g_szDestMap = "";
        g_szDestTrans = "";
        g_bVoteInProgress = false;
        
        // Clear caches
        g_MapExistsCache.deleteAll();
        g_MapRestrictionsCache.deleteAll();
        g_PlayerTransitions.deleteAll();
        
        MS::LogInfo("GameMaster Map Transitions system initialized");
    }
    
    /**
     * Shutdown the map transitions system
     */
    void Shutdown()
    {
        MS::LogInfo("Shutting down GameMaster Map Transitions system");
        
        // Clear all state
        g_PlayerTransitions.deleteAll();
        g_MapExistsCache.deleteAll();
        g_MapRestrictionsCache.deleteAll();
        
        MS::LogInfo("GameMaster Map Transitions system shut down");
    }
    
    /**
     * Check if transitions are currently disabled
     */
    bool AreTransitionsDisabled()
    {
        return g_bDisableTransitions;
    }
    
    /**
     * Check if a map change is in progress
     */
    bool IsMapChangeInProgress()
    {
        return g_bChangeLevel;
    }
    
    /**
     * Get current destination map
     */
    string GetDestinationMap()
    {
        return g_szDestMap;
    }
}

// ========================================
// Global Functions for External Access
// ========================================

/**
 * Initialize map transitions system
 */
void InitializeMapTransitions()
{
    MS::Initialize();
}

// Note: game_transition_triggered function is defined in GameMaster.as to avoid conflicts

/**
 * Handle manual map change
 */
void gm_manual_map_change(const string &in szDestMap, const string &in szDestSpawn = "")
{
    MS::ExecuteManualMapChange(szDestMap, szDestSpawn);
}

/**
 * Handle game triggered event
 */
void game_triggered(const string &in szTriggerName)
{
    MS::GameTriggered(szTriggerName);
}

/**
 * Handle map vote result
 */
void gm_votemap(const string &in szOptionTitle, const string &in szMapDestination)
{
    MS::HandleMapVoteResult(szOptionTitle, szMapDestination);
}

/**
 * Check if map exists
 */
bool MapExists(const string &in szMapName)
{
    return MS::MapExists(szMapName);
}

/**
 * Check if transitions are disabled
 */
bool TransitionsDisabled()
{
    return MS::AreTransitionsDisabled();
}