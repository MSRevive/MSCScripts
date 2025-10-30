#pragma context server

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

#include "server/gamemaster/GameMasterDataStructures.as"

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
        LogInfo("GameTransitionTriggered: " + szMapTitle + " -> " + szDestMap);
        
        // Create transition data
        MapTransitionData transData(szMapTitle, szDestMap, szLocalSpawn, szDestSpawn);
        
        // Set global destination spawn for compatibility
        g_szDestTrans = szDestSpawn;
        
        // Validate map existence
        if (!MapExists(szDestMap))
        {
            string errorMsg = szDestMap + " does not exist on this server. Perhaps this is a future transition point?";
            SendMessageToAllPlayers("green", errorMsg);
            LogWarning("Map does not exist: " + szDestMap);
            return;
        }
        
        // Validate map access permissions
        if (!ValidateMapAccess(szDestMap))
        {
            string errorMsg = "Access to " + szDestMap + " is restricted.";
            SendMessageToAllPlayers("red", errorMsg);
            LogWarning("Map access denied: " + szDestMap);
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
            LogWarning("Map change already in progress, ignoring request");
            return;
        }
        
        LogInfo("ExecuteManualMapChange: " + szDestMap + " spawn: " + szDestSpawn);
        
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
        
        // Log changelevel to server console
        ExecuteServerCommand("echo Changelevel: " + szDestMap);
        
        // Reset weather system
        ResetWeatherForTransition();
        
        // Unlock server if it was locked
        if (IsServerLocked())
        {
            UnlockServer();
        }
        
        // Prepare all players for level change
        int nPlayerCount = GetActivePlayerCount();
        if (nPlayerCount > 0)
        {
            PrepareAllPlayersForTransition();
        }
        
        // Display transition message
        string szMessage = "Traveling to " + szDestMap + "!";
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
        LogInfo("GameTriggered: " + szTriggerName);
        
        if (g_bChangeLevel)
        {
            LogInfo("Map change in progress, ignoring trigger: " + szTriggerName);
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
            
            LogInfo("Force map change to: " + szForceMap);
            ExecuteManualMapChange(szForceMap);
        }
        else
        {
            LogWarning("Unknown trigger type: " + szTriggerName);
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
        
        LogInfo("Map existence check: " + szMapName + " = " + (bExists ? "true" : "false"));
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
            LogInfo("FN server access denied for map: " + szMapName);
        }
        
        // Check for hidden map restrictions
        if (IsHiddenMap(szMapName) && !IsPlayerAllowedHiddenAccess())
        {
            bAllowed = false;
            LogInfo("Hidden map access denied for map: " + szMapName);
        }
        
        // Check for gauntlet restrictions
        if (IsGauntletMap(szMapName) && !ValidateGauntletAccess(szMapName))
        {
            bAllowed = false;
            LogInfo("Gauntlet access denied for map: " + szMapName);
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
        LogInfo("Setting transition data for all players: " + szDestMap);
        
        // Get all active players
        array<string> playerList = GetAllPlayerSteamIDs();
        
        for (uint i = 0; i < playerList.length(); i++)
        {
            SetPlayerTransitionData(playerList[i], szDestMap, szLocalSpawn, szDestSpawn);
        }
    }
    
    /**
     * Set transition data for a specific player using AngelScript quest data
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
        
        // Save map and spawn data to player quest data (AngelScript version of ext_set_map)
        // This replaces: quest set ent_me m <mapname>
        string szMapLower = ToLower(szDestMap);
        SetPlayerQuestData(szSteamID, "m", szMapLower);
        
        // This replaces: quest set ent_me d <spawn>
        SetPlayerQuestData(szSteamID, "d", szLocalSpawn);
        
        // Set the next transition spawn point for after map change
        SetPlayerQuestData(szSteamID, "next_trans", szDestSpawn);
        
        LogInfo("Set transition data for player " + szSteamID + ": " + szDestMap + " -> " + szLocalSpawn);
    }
    
    /**
     * Set spawn point for all players using AngelScript quest data
     */
    void SetAllPlayersSpawn(const string &in szSpawnPoint)
    {
        LogInfo("Setting spawn point for all players: " + szSpawnPoint);
        
        array<string> playerList = GetAllPlayerSteamIDs();
        
        for (uint i = 0; i < playerList.length(); i++)
        {
            // Save spawn point to player quest data (replaces: quest set ent_me d <spawn>)
            SetPlayerQuestData(playerList[i], "d", szSpawnPoint);
        }
    }
    
    /**
     * Prepare all players for level change
     */
    void PrepareAllPlayersForTransition()
    {
        LogInfo("Preparing all players for transition");
        
        array<string> playerList = GetAllPlayerSteamIDs();
        
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
            LogWarning("Vote already in progress, cannot start map transition vote");
            return;
        }
        
        LogInfo("Starting map transition vote for: " + transData.szMapTitle);
        
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
        LogInfo("Map vote result: " + szOptionTitle + " -> " + szMapDestination);
        
        g_bVoteInProgress = false;
        
        if (szMapDestination != "0" && szMapDestination.length() > 0)
        {
            // Vote passed - change map
            ExecuteManualMapChange(szMapDestination);
        }
        else
        {
            // Vote failed - stay on current map
            LogInfo("Map transition vote failed");
        }
    }
    
    /**
     * Start a generic vote using the AngelScript VoteManager
     */
    void StartGenericVote(const string &in szCallbackEvent, const array<string> &in voteOptions,
                         const string &in szTitle, const string &in szDescription)
    {
        LogInfo("Starting generic vote: " + szTitle);
        
        // Build options string (semicolon-separated)
        string szOptionsString = "";
        for (uint i = 0; i < voteOptions.length(); i++)
        {
            if (i > 0) szOptionsString += ";";
            szOptionsString += voteOptions[i];
        }
        
        // Call AngelScript voting system
        bool success = MS::gm_create_vote(szCallbackEvent, szOptionsString, szTitle, szDescription, false);
        
        if (!success)
        {
            LogError("Failed to create vote: " + szTitle);
            g_bVoteInProgress = false;
        }
    }
    
    // ========================================
    // Weather and Environment Management
    // ========================================
    
    /**
     * Reset weather system for map transition
     */
    void ResetWeatherForTransition()
    {
        LogInfo("Resetting weather for transition");
        
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
        LogInfo("Unlocking server for map transition");
        
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
            LogWarning("DelayedChangeLevel called but change level flag is false");
            return;
        }
        
        if (g_szDestMap.length() == 0)
        {
            LogError("DelayedChangeLevel called but destination map is empty");
            return;
        }
        
        LogInfo("Executing delayed changelevel to: " + g_szDestMap);
        
        // Execute the actual changelevel command (newline required by engine)
        ExecuteServerCommand("changelevel " + g_szDestMap + "\n");
        
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
     * Schedule a delayed event using the global scheduler
     * 
     * @param flDelay Delay in seconds before execution
     * @param szEventName Name of the event function to call
     * 
     * Uses the MS::Scheduler system to schedule delayed function execution.
     * The callback function must be accessible in the global scope.
     */
    void ScheduleDelayedEvent(float flDelay, const string &in szEventName)
    {
        LogInfo("Scheduling delayed event: " + szEventName + " in " + flDelay + " seconds");
        
        // Use the MS Scheduler system to schedule the event
        // The scheduler will call the named function after the delay
        array<string> emptyParams;
        string taskID = MS::g_Scheduler.ScheduleTask(flDelay, szEventName, emptyParams, true);
        
        if (taskID.length() > 0)
        {
            LogInfo("Event scheduled successfully with task ID: " + taskID);
        }
        else
        {
            LogError("Failed to schedule event: " + szEventName);
        }
    }
    
    // Note: GetCurrentTime function removed - using GetGameTime() instead
    
    // Note: GetActivePlayerCount function removed - using GetPlayerCount() instead
    
    // Note: GetAllPlayerSteamIDs function removed - using MS::GetAllPlayerSteamIDs() instead
    
    // ========================================
    // Engine Interface Functions
    // ========================================
    
    /**
     * Check if map exists via engine
     * 
     * @param szMapName Map name to check (without .bsp extension)
     * @return True if map exists on server
     * 
     * Calls the C++ engine function to check if the map file exists
     * in the maps/ directory on the server.
     */
    bool EngineMapExists(const string &in szMapName)
    {
        LogInfo("EngineMapExists: Checking " + szMapName);
        
        // Call the global AngelScript function exposed from C++
        // This checks the actual file system for the map file
        bool exists = ::EngineMapExists(szMapName);
        
        LogInfo("EngineMapExists: Map '" + szMapName + "' " + (exists ? "exists" : "does not exist"));
        return exists;
    }
    
    /**
     * Execute a server command
     * 
     * @param szCommand Server console command to execute
     * 
     * Security Note: This function is protected by the C++ implementation
     * which blocks dangerous commands like quit, exit, and rcon_password
     */
    void ExecuteServerCommand(const string &in szCommand)
    {
        LogInfo("Executing server command: " + szCommand);
        
        // Call the global AngelScript function exposed from C++
        // This is registered in ASBuiltinFunctions.cpp as AS_ExecuteServerCommand
        ::ExecuteServerCommand(szCommand);
    }
    
    /**
     * Call external function on a player
     * 
     * @param szSteamID Player's Steam ID
     * @param szFunction Name of the player script function to call
     * @param args Array of string arguments to pass to the function
     */
    void CallPlayerExternal(const string &in szSteamID, const string &in szFunction, array<string>@ args)
    {
        LogInfo("Player external call: " + szSteamID + " -> " + szFunction);
        
        // Call the global AngelScript function exposed from C++
        // This is registered in ASBuiltinFunctions.cpp as AS_CallPlayerExternal
        ::CallPlayerExternal(szSteamID, szFunction, args);
    }
    
    /**
     * Call external function on GameMaster
     * 
     * @param szFunction Name of the GameMaster script function to call
     * @param args Array of string arguments to pass to the function
     */
    void CallGameMasterExternal(const string &in szFunction, array<string>@ args)
    {
        LogInfo("GameMaster external call: " + szFunction);
        
        // Call the global AngelScript function exposed from C++
        // This is registered in ASBuiltinFunctions.cpp as AS_CallGameMasterExternal
        ::CallGameMasterExternal(szFunction, args);
    }
    
    /**
     * Convert color string to MessageColor enum
     * 
     * @param szColor Color name (red, green, blue, yellow, white, gray)
     * @return MessageColor enum value
     */
    MessageColor StringToMessageColor(const string &in szColor)
    {
        string colorLower = ToLower(szColor);
        
        if (colorLower == "red")
            return MessageColor::Red;
        else if (colorLower == "green")
            return MessageColor::Green;
        else if (colorLower == "blue")
            return MessageColor::Blue;
        else if (colorLower == "yellow")
            return MessageColor::Yellow;
        else if (colorLower == "gray" || colorLower == "grey")
            return MessageColor::Gray;
        else
            return MessageColor::White; // Default to white
    }
    
    /**
     * Send colored message to all players
     * 
     * @param szColor Color name (red, green, blue, yellow, etc.)
     * @param szMessage Message text to send
     */
    void SendMessageToAllPlayers(const string &in szColor, const string &in szMessage)
    {
        LogInfo("Sending message to all players [" + szColor + "]: " + szMessage);
        
        // Convert color string to enum
        MessageColor color = StringToMessageColor(szColor);
        
        // Get all players and send message to each
        array<CBasePlayer@>@ players = GetAllPlayers();
        
        if (players is null)
        {
            LogWarning("SendMessageToAllPlayers: GetAllPlayers returned null");
            return;
        }
        
        for (uint i = 0; i < players.length(); i++)
        {
            CBasePlayer@ player = players[i];
            if (player !is null && player.IsConnected())
            {
                player.SendColoredMessage(color, szMessage);
            }
        }
    }
    
    /**
     * Send info message to all players (with title)
     * 
     * @param szTitle Title of the info message
     * @param szMessage Message body text
     */
    void SendInfoMessageToAll(const string &in szTitle, const string &in szMessage)
    {
        LogInfo("Sending info message to all: " + szTitle + " - " + szMessage);
        
        // Get all players and send message to each
        array<CBasePlayer@>@ players = GetAllPlayers();
        
        if (players is null)
        {
            LogWarning("SendInfoMessageToAll: GetAllPlayers returned null");
            return;
        }
        
        for (uint i = 0; i < players.length(); i++)
        {
            CBasePlayer@ player = players[i];
            if (player !is null && player.IsConnected())
            {
                // Send title in yellow
                player.SendColoredMessage(MessageColor::Yellow, szTitle);
                // Send message in white
                player.SendColoredMessage(MessageColor::White, szMessage);
            }
        }
    }
    
    /**
     * Set global game variable
     * 
     * @param szVarName Name of the global variable
     * @param szValue Value to set (as string)
     * 
     * Note: This sets variables in the global script system that persist
     * across map changes and are accessible by all scripts
     */
    void SetGlobalVariable(const string &in szVarName, const string &in szValue)
    {
        LogInfo("Setting global variable: " + szVarName + " = " + szValue);
        
        // Use the quest data system to set global variables
        // The $set system variables are stored in the global game script
        // We can use SetPlayerQuestData with a special prefix for global vars
        // Or use the GameMaster external system to set global variables
        
        array<string> args = {szVarName, szValue};
        CallGameMasterExternal("gm_set_global_var", args);
    }
    
    // ========================================
    // Helper Utility Functions
    // ========================================
    
    /**
     * Get all player Steam IDs
     * 
     * @return Array of Steam IDs for all connected players
     */
    array<string> GetAllPlayerSteamIDs()
    {
        array<string> steamIDs;
        
        // Get all players from the engine
        array<CBasePlayer@>@ players = GetAllPlayers();
        
        if (players is null)
        {
            LogWarning("GetAllPlayerSteamIDs: GetAllPlayers returned null");
            return steamIDs;
        }
        
        // Extract Steam IDs from player objects
        for (uint i = 0; i < players.length(); i++)
        {
            CBasePlayer@ player = players[i];
            if (player !is null && player.IsConnected())
            {
                string steamID = player.GetSteamID();
                if (steamID.length() > 0 && steamID != "STEAM_ID_INVALID")
                {
                    steamIDs.insertLast(steamID);
                }
                else if (steamID == "STEAM_ID_INVALID")
                {
                    LogWarning("GetAllPlayerSteamIDs: Skipping player with invalid Steam ID");
                }
            }
        }
        
        LogInfo("GetAllPlayerSteamIDs: Found " + steamIDs.length() + " players");
        return steamIDs;
    }
    
    // ========================================
    // MS Namespace Helper Functions
    // ========================================
    
    /**
     * Log info message
     */
    void LogInfo(const string &in szMessage)
    {
        // Use the global logging function from AngelScript
        ::LogMessage("[MapTransitions] " + szMessage);
    }
    
    /**
     * Log warning message
     */
    void LogWarning(const string &in szMessage)
    {
        // Use the global logging function from AngelScript
        ::LogMessage("[MapTransitions WARNING] " + szMessage);
    }
    
    /**
     * Log error message
     */
    void LogError(const string &in szMessage)
    {
        // Use the global logging function from AngelScript
        ::LogMessage("[MapTransitions ERROR] " + szMessage);
    }
    
    /**
     * Get active player count
     */
    int GetActivePlayerCount()
    {
        // Use the global player count function
        return ::GetPlayerCount();
    }
    
    /**
     * Get current game time
     */
    float GetGameTime()
    {
        // Use the global game time function
        return ::GetGameTime();
    }
    
    // ========================================
    // External API Functions
    // ========================================
    
    /**
     * Initialize the map transitions system
     */
    void Initialize()
    {
        LogInfo("Initializing GameMaster Map Transitions system");
        
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
        
        LogInfo("GameMaster Map Transitions system initialized");
    }
    
    /**
     * Shutdown the map transitions system
     */
    void Shutdown()
    {
        LogInfo("Shutting down GameMaster Map Transitions system");
        
        // Clear all state
        g_PlayerTransitions.deleteAll();
        g_MapExistsCache.deleteAll();
        g_MapRestrictionsCache.deleteAll();
        
        LogInfo("GameMaster Map Transitions system shut down");
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

// ========================================
// Global Wrapper Functions for C++ Integration
// ========================================

/**
 * Handle map vote result
 * Called from voting system when vote completes
 */
void gm_votemap(const string &in szOptionTitle, const string &in szMapDestination)
{
    MS::HandleMapVoteResult(szOptionTitle, szMapDestination);
}

/**
 * Check if map exists (utility function)
 */
bool MapExists(const string &in szMapName)
{
    return MS::MapExists(szMapName);
}

/**
 * Check if transitions are disabled (utility function)
 */
bool TransitionsDisabled()
{
    return MS::AreTransitionsDisabled();
}

/**
 * Global wrapper for GameTransitionTriggered (PascalCase version)
 * Called from C++ when msarea_transition is activated
 */
void GameTransitionTriggered(const string &in szMapTitle, const string &in szDestMap,
                             const string &in szLocalSpawn, const string &in szDestSpawn)
{
    MS::GameTransitionTriggered(szMapTitle, szDestMap, szLocalSpawn, szDestSpawn);
}

/**
 * Global wrapper for ExecuteManualMapChange (PascalCase version)
 * Called from C++ when trigger_changelevel or mstrig_changelevel is activated
 */
void ExecuteManualMapChange(const string &in szDestMap, const string &in szDestSpawn = "")
{
    MS::ExecuteManualMapChange(szDestMap, szDestSpawn);
}

/**
 * Global wrapper for GameTriggered (PascalCase version)
 * Called from C++ when FireTargets is called with special trigger names
 */
void GameTriggered(const string &in szTriggerName)
{
    MS::GameTriggered(szTriggerName);
}

void OnPlayerTransitionEntered(const string &in szPlayerName, const string &in szDestName, const string &in szDestMap, const string &in szDestSpawn, const string &in szDestTrans, const string &in szSteamID)
{
    CBasePlayer@ player = PlayerBySteamID(szSteamID);
    if (player !is null)
    {
        string message = "You have entered the transition to " + szDestName + "!";
        string voteMessage = "If you wish to ";
        int nPlayerCount = GetPlayerCount();

        if (nPlayerCount > 1)
        {
            voteMessage += "initiate a vote to transition press (enter) to begin.";
        }
        else
        {
            voteMessage += "transition press (enter).";
        }
        
        player.SendColoredMessage(MessageColor::Yellow, message);
        player.SendColoredMessage(MessageColor::Yellow, voteMessage);
    }
}

/**
 * Global wrapper for DelayedChangeLevel
 * Called after delay when map change is scheduled
 */
void DelayedChangeLevel()
{
    MS::DelayedChangeLevel();
}