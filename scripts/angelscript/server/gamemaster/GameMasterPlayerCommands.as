#pragma context server

/**
 * GameMasterPlayerCommands.as
 * 
 * Player command handling system for GameMaster voting functionality.
 * Handles player command parsing, permission checking, rate limiting, 
 * map validation, and user feedback for voting commands.
 * 
 * Ported from player_vote.script and integrated with AngelScript GameMaster system.
 */

#include "server/gamemaster/GameMasterDataStructures.as"

namespace MS
{
    // ========================================
    // Constants and Configuration
    // ========================================
    
    /**
     * Map vote delay constant (in seconds)
     */
    const float MAP_VOTE_DELAY = 10.0f;
    
    /**
     * Map list constants - these would normally be loaded from server config
     * For now using hardcoded values matching the original script behavior
     */
    namespace MapLists
    {
        // Hidden maps that require finding entrances
        const array<string> HIDDEN_MAPS = {
            "challs", "keledrosruins", "nashalrath", "undermines", "underpath", "undercliffs"
        };
        
        // Maze maps that require navigation
        const array<string> MAZE_MAPS = {
            "goblintown"
        };
        
        // Gauntlet maps that require starting from beginning
        const array<string> GAUNTLET_MAPS = {
            "highlands_msc", "lostcastle_msc", "skycastle", "orcplace2_beta", "ww2b", "ww3d", 
            "old_helena", "lodagond-2", "lodagond-3", "lodagond-4", "nashalrath", "the_wall2"
        };
        
        // Gauntlet starting maps
        const array<string> GAUNTLET_START_MAPS = {
            "lowlands", "lodagond-1", "ww1", "the_wall", "old_helena", "nashalrath"
        };
        
        // Unconnected maps (not accessible through normal transitions)
        const array<string> UNCONNECTED_MAPS_1 = {
            "ms_quest", "char_recover", "guildmaster", "cleicert", "foutpost", "lodagond-1", 
            "island1", "lostcaverns", "ms_underworldv2", "orc_arena", "pvp_archery", "pvp_arena", 
            "unrest", "unrest2", "unrest2_beta1", "ww1", "pvp_canyons", "canyons", "ocean_crossing", 
            "smugglers_cove", "isles_dread1"
        };
        
        const array<string> UNCONNECTED_MAPS_2 = {
            "kfortress", "gertenheld_cave", "islesofdread2_old", "the_wall", "catacombs", 
            "bloodshrine", "ms_soccer", "shender_east", "nightmare_edana", "m2_quest", "gertenhell"
        };
        
        // Maps not allowed on FN servers
        const array<string> FN_RESTRICTED_MAPS = {
            "test_scripts"
        };
        
        // Root town maps
        const array<string> ROOT_TOWNS = {
            "edana", "deralia", "helena"
        };
    }
    
    // ========================================
    // Player Command Manager Class
    // ========================================
    
    /**
     * Manages all player voting commands and validation
     */
    class PlayerCommandManager
    {
        // Vote system state
        private bool m_bVoteBusy = false;
        private string m_szCurrentVoteID = "";
        private float m_flLastVoteTime = 0.0f;
        
        // Player records for rate limiting and permissions
        private dictionary m_dPlayerRecords;  // PlayerVoteRecord objects keyed by Steam ID
        
        // Server configuration cache
        private bool m_bMapVotesEnabled = true;
        private bool m_bPvpVotesEnabled = true;
        private bool m_bLockVotesEnabled = true;
        private bool m_bFarmingAllowed = false;
        private string m_szVoteMapType = "all";  // all|root|nonfn
        
        /**
         * Constructor
         */
        PlayerCommandManager()
        {
            LogInfo("PlayerCommandManager: Initializing command system...");
            RefreshServerConfig();
        }
        
        /**
         * Main entry point for handling player commands
         * Equivalent to game_playercmd from original script
         */
        void HandlePlayerCommand(const string &in playerID, const string &in playerName, 
                               const array<string> &in args)
        {
            try
            {
                if (args.length() < 1)
                {
                    LogInfo("PlayerCommandManager: No arguments provided");
                    return;
                }

                string steamID = args[0];
                if (steamID.isEmpty())
                {
                    LogWarning("PlayerCommandManager: Command call from seemingly no one. Steam ID is empty.");
                    return;
                }

                // Check if this is args.length() == 1 (just steam ID) - skip silently
                if (args.length() < 2)
                {
                    return;
                }

                string command = args[1];
                
                // Special handling for menu option commands from vote menus
                // These come from the C++ engine when a player clicks a vote menu option
                if (command == "menuoption")
                {
                    // menuoption format: args[0]=steamID, args[1]="menuoption", args[2]=entityIndex, args[3]=optionIndex
                    // The C++ side will also call game_vote_menu_callback with the option data
                    // We let it pass through to the C++ system which will trigger the callback
                    LogInfo("PlayerCommandManager: menuoption command received - letting C++ handle callback");
                    return;
                }
                
                // Other legacy menu commands
                if (command == "menuselect" || command == "closemenu")
                {
                    // Silently ignore these - they're handled by the legacy script system
                    return;
                }
                    
                LogInfo("PlayerCommandManager: Processing command from " + playerName + 
                       " - " + steamID);
                
                // Check if this is a vote command
                if (command.length() >= 4 && command.substr(0, 4) == "vote")
                {
                    LogInfo("PlayerCommandManager: Calling ProcessVoteCommand");
                    ProcessVoteCommand(playerID, playerName, args);
                    LogInfo("PlayerCommandManager: ProcessVoteCommand completed");
                }
                else
                {
                    LogInfo("PlayerCommandManager: Command '" + command + "' is not a vote command (ignored)");
                }
            }
            catch
            {
                LogError("PlayerCommandManager: Exception in HandlePlayerCommand - player: " + playerName + 
                        ", args: " + (args.length() > 0 ? args[0] : "none"));
            }
        }
        
        /**
         * Process vote-related commands
         * Equivalent to check_vote_options from original script
         */
        private void ProcessVoteCommand(const string &in playerID, const string &in playerName,
                                      const array<string> &in args)
        {
            try
            {
                LogInfo("PlayerCommandManager: ProcessVoteCommand started for " + playerName);
                
                // First check if player can vote at all
                if (!CanPlayerVote(playerID))
                {
                    LogInfo("PlayerCommandManager: Player " + playerName + " cannot vote");
                    GameMasterPlayerUtils::SendPlayerMessage(playerID, "You are not allowed to vote at this time.");
                    return;
                }
            
                string command = args[1];
                if (command == "votemap" && args.length() == 3)
                {
                    LogInfo("PlayerCommandManager: Processing vote command: " + command + " " + args[2]);

                    LogInfo("PlayerCommandManager: Calling HandleVoteMapCommand");
                    HandleVoteMapCommand(playerID, playerName, args);
                    LogInfo("PlayerCommandManager: HandleVoteMapCommand completed");
                }
                else if (command == "votepvp")
                {
                    LogInfo("PlayerCommandManager: Calling HandleVotePvpCommand");
                    HandleVotePvpCommand(playerID, playerName, args);
                    LogInfo("PlayerCommandManager: HandleVotePvpCommand completed");
                }
                else if (command == "votelock")
                {
                    LogInfo("PlayerCommandManager: Calling HandleVoteLockCommand");
                    HandleVoteLockCommand(playerID, playerName, args);
                    LogInfo("PlayerCommandManager: HandleVoteLockCommand completed");
                }
                else
                {
                    LogInfo("PlayerCommandManager: Unknown vote command: " + command);
                }
                // Note: votekick and voteban are commented out in original script
                // else if (command == "votekick")
                // {
                //     HandleVoteKickCommand(playerID, playerName, args);
                // }
                // else if (command == "voteban")
                // {
                //     HandleVoteBanCommand(playerID, playerName, args);
                // }
            }
            catch
            {
                LogError("PlayerCommandManager: Exception in ProcessVoteCommand - player: " + playerName + 
                        ", command: " + (args.length() > 0 ? args[0] : "none"));
            }
        }
        
        /**
         * Handle votemap command
         * Equivalent to player_votemap from original script
         */
        private void HandleVoteMapCommand(const string &in playerID, const string &in playerName,
                                        const array<string> &in args)
        {
            // Check if map votes are enabled
            if (!m_bMapVotesEnabled)
            {
                string message = "VOTEMAP: This server does not allow map votes.";
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            // Check if vote system is busy
            if (m_bVoteBusy)
            {
                string message = "Votemap: Vote system is busy.";
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            // Check minimum time since map start
            float currentTime = GetGameTime();
            if (currentTime < MAP_VOTE_DELAY)
            {
                string message = "Votemap: You cannot start a map vote for the first " + 
                               formatInt(int(MAP_VOTE_DELAY)) + " seconds, except by transition.";
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            string mapName = MS::ToLower(args[2]);
            
            // Validate the requested map
            MapValidationResult validation = ValidateMapForVoting(mapName, playerID);
            if (!validation.bIsValid)
            {
                GameMasterPlayerUtils::SendPlayerMessage(playerID, "Votemap: " + validation.GetResultDescription());
                GameMasterPlayerUtils::SendConsoleMessage(playerID, validation.GetResultDescription());
                return;
            }
            
            // Create the map vote
            CreateMapVote(playerID, playerName, mapName);
        }
        
        /**
         * Handle votepvp command
         * Equivalent to player_votepvp from original script
         */
        private void HandleVotePvpCommand(const string &in playerID, const string &in playerName,
                                        const array<string> &in args)
        {
            // Check if PvP votes are enabled
            if (!m_bPvpVotesEnabled)
            {
                string message = "VOTEPVP: This server does not allow PVP votes.";
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            // Check if vote system is busy
            if (m_bVoteBusy)
            {
                string message = "votepvp - Vote system is busy.";
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            // Check minimum player count (skip in developer mode)
            uint playerCount = GetCurrentPlayerCount();
            if (playerCount < 2 && !IsDeveloperMode())
            {
                string message = "VOTEPVP: Requires at least 2 players to vote for PVP.";
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            // Create the PvP vote
            CreatePvpVote(playerID, playerName);
        }
        
        /**
         * Handle votelock command
         * Equivalent to player_votelock from original script
         */
        private void HandleVoteLockCommand(const string &in playerID, const string &in playerName,
                                         const array<string> &in args)
        {
            // Check if server is already locked
            if (IsServerLocked())
            {
                string password = GetServerPassword();
                string message = "Server is already vote locked.";
                if (!password.isEmpty())
                {
                    message += " ( Password: " + password + " )";
                }
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            // Check if lock votes are enabled
            if (!m_bLockVotesEnabled)
            {
                string message = "This server does not allow votes to lock the server.";
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            // Check minimum player count
            uint playerCount = GetCurrentPlayerCount();
            if (playerCount < 3 && !IsDeveloperMode())
            {
                string message = "Need at least three players to start a vote to lock the server.";
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            // Check if vote system is busy
            if (m_bVoteBusy)
            {
                string message = "Vote system is busy.";
                GameMasterPlayerUtils::SendPlayerMessage(playerID, message);
                GameMasterPlayerUtils::SendConsoleMessage(playerID, message);
                return;
            }
            
            // Create the server lock vote
            CreateServerLockVote(playerID, playerName);
        }
        
        /**
         * Validate a map for voting
         * Implements all the validation logic from the original script
         */
        private MapValidationResult ValidateMapForVoting(const string &in mapName, 
                                                       const string &in playerID)
        {
            MapValidationResult result;
            result.Initialize(mapName, playerID);
            
            // Check if map exists on server
            if (!MS::MapExists(mapName))
            {
                result.SetFailure(MAP_NOT_FOUND, "Map not found on this server.");
                return result;
            }
            
            // Check if voting for current map is allowed
            string currentMap = MS::ToLower(GetCurrentMapName());
            if (currentMap == mapName && !m_bFarmingAllowed)
            {
                result.SetFailure(MAP_CURRENT_MAP, "You cannot vote for the map you are currently on.");
                return result;
            }
            
            // Check FN server restrictions
            if (IsOnFNServer() && MapLists::FN_RESTRICTED_MAPS.find(mapName) >= 0)
            {
                result.SetFailure(MAP_FN_RESTRICTED, 
                                "This is a special utility map that cannot be used on [FN]");
                return result;
            }
            
            // Check server vote type restrictions
            if (m_szVoteMapType == "root")
            {
                bool isAllowed = false;
                
                // Check if it's a root town
                if (MapLists::ROOT_TOWNS.find(mapName) >= 0)
                    isAllowed = true;
                    
                // Check if it's an unconnected map
                if (MapLists::UNCONNECTED_MAPS_1.find(mapName) >= 0 ||
                    MapLists::UNCONNECTED_MAPS_2.find(mapName) >= 0)
                    isAllowed = true;
                
                if (!isAllowed)
                {
                    result.SetFailure(MAP_PERMISSION_DENIED,
                                    "You may only vote for root towns (edana, deralia, helena) and disconnected maps on this server.");
                    return result;
                }
            }
            
            // Check hidden map restrictions
            if (MapLists::HIDDEN_MAPS.find(mapName) >= 0)
            {
                // Allow voting for current map even if hidden (player already found it)
                if (currentMap != mapName)
                {
                    result.SetFailure(MAP_HIDDEN, "This is a hidden map, you must find the entrance.");
                    return result;
                }
            }
            
            // Check maze restrictions
            if (MapLists::MAZE_MAPS.find(mapName) >= 0)
            {
                string playerQuestMap = GameMasterPlayerUtils::GetPlayerQuestData(playerID, "m");
                if (playerQuestMap != mapName)
                {
                    result.SetFailure(MAP_MAZE_RESTRICTED,
                                    "This map is hidden within a maze, you must navigate the maze to find its entrance.");
                    return result;
                }
                else
                {
                    // Player qualifies, send confirmation message
                    GameMasterPlayerUtils::SendPlayerMessage(playerID, "Votemap: You can vote for this hidden map as you still qualify.");
                }
            }
            
            // Check gauntlet restrictions
            if (MapLists::GAUNTLET_MAPS.find(mapName) >= 0)
            {
                string playerQuestMap = GameMasterPlayerUtils::GetPlayerQuestData(playerID, "m");
                string validatedMap = GameMasterPlayerUtils::GetPlayerQuestData(playerID, "mv");
                
                if (playerQuestMap != mapName || validatedMap != mapName)
                {
                    result.SetFailure(MAP_GAUNTLET_RESTRICTED,
                                    "This map is part of a gauntlet series, you must begin at the start of the series.");
                    return result;
                }
                else
                {
                    // Player qualifies, send confirmation message
                    GameMasterPlayerUtils::SendPlayerMessage(playerID, "Votemap: You can vote for this gauntlet map as you still qualify.");
                }
            }
            
            // If we got here, the map is valid
            result.SetSuccess();
            return result;
        }
        
        /**
         * Create a map vote
         */
        private void CreateMapVote(const string &in playerID, const string &in playerName,
                                 const string &in mapName)
        {
            string voteTitle = "Change to " + mapName + "?";
            string voteOptions = "Yes!:" + mapName + ";No!:0";
            
            LogInfo("PlayerCommandManager: Creating map vote for " + mapName + " initiated by " + playerName);
            
            // Call the GameMaster voting system via the VoteManager
            MS::VoteManager@ voteManager = MS::GetVoteManager();
            if (voteManager !is null)
            {
                bool success = voteManager.CreateMapVote(playerID, mapName);
                if (success)
                {
                    m_bVoteBusy = true;
                    m_szCurrentVoteID = "map_" + formatInt(int(GetGameTime()));
                    LogInfo("PlayerCommandManager: Map vote created successfully");
                }
                else
                {
                    LogError("PlayerCommandManager: Failed to create map vote");
                    GameMasterPlayerUtils::SendPlayerMessage(playerID, "Failed to create vote. Try again later.");
                }
            }
            else
            {
                LogError("PlayerCommandManager: VoteManager is null!");
            }
        }
        
        /**
         * Create a PvP vote
         */
        private void CreatePvpVote(const string &in playerID, const string &in playerName)
        {
            bool bEnablePvp = !IsServerPvpEnabled();
            
            LogInfo("PlayerCommandManager: Creating PvP vote initiated by " + playerName + " (enable: " + bEnablePvp + ")");
            
            // Call the GameMaster voting system via the VoteManager
            MS::VoteManager@ voteManager = MS::GetVoteManager();
            if (voteManager !is null)
            {
                bool success = voteManager.CreatePvpVote(playerID, bEnablePvp);
                if (success)
                {
                    m_bVoteBusy = true;
                    m_szCurrentVoteID = "pvp_" + formatInt(int(GetGameTime()));
                    LogInfo("PlayerCommandManager: PvP vote created successfully");
                }
                else
                {
                    LogError("PlayerCommandManager: Failed to create PvP vote");
                    GameMasterPlayerUtils::SendPlayerMessage(playerID, "Failed to create vote. Try again later.");
                }
            }
            else
            {
                LogError("PlayerCommandManager: VoteManager is null!");
            }
        }
        
        /**
         * Create a server lock vote
         */
        private void CreateServerLockVote(const string &in playerID, const string &in playerName)
        {
            LogInfo("PlayerCommandManager: Creating server lock vote initiated by " + playerName);
            
            // Call the GameMaster voting system via the VoteManager
            MS::VoteManager@ voteManager = MS::GetVoteManager();
            if (voteManager !is null)
            {
                bool success = voteManager.CreateServerLockVote(playerID);
                if (success)
                {
                    m_bVoteBusy = true;
                    m_szCurrentVoteID = "lock_" + formatInt(int(GetGameTime()));
                    LogInfo("PlayerCommandManager: Server lock vote created successfully");
                }
                else
                {
                    LogError("PlayerCommandManager: Failed to create server lock vote");
                    GameMasterPlayerUtils::SendPlayerMessage(playerID, "Failed to create vote. Try again later.");
                }
            }
            else
            {
                LogError("PlayerCommandManager: VoteManager is null!");
            }
        }
        
        /**
         * Show map list to player
         * Equivalent to list_custom_maps from original script
         */
        private void ShowMapList(const string &in playerID)
        {
            GameMasterPlayerUtils::SendPlayerMessage(playerID, "Votemap: You can vote for specific maps by typing votemap [mapname] in main chat.");
            GameMasterPlayerUtils::SendPlayerMessage(playerID, "Check your console (~) for a list of maps not connected to the world.");
            
            GameMasterPlayerUtils::SendConsoleMessage(playerID, "Votemap: You can vote for specific maps by typing votemap [mapname] in main chat.");
            GameMasterPlayerUtils::SendConsoleMessage(playerID, "Here's a list of maps you may vote for that are not otherwise reachable:");
            GameMasterPlayerUtils::SendConsoleMessage(playerID, "=========== DISCONNECTED MAPS ===========");
            
            // Show unconnected maps
            for (uint i = 0; i < MapLists::UNCONNECTED_MAPS_1.length(); i++)
            {
                string mapName = MapLists::UNCONNECTED_MAPS_1[i];
                if (MS::MapExists(mapName))
                {
                    GameMasterPlayerUtils::SendConsoleMessage(playerID, mapName);
                }
            }
            
            for (uint i = 0; i < MapLists::UNCONNECTED_MAPS_2.length(); i++)
            {
                string mapName = MapLists::UNCONNECTED_MAPS_2[i];
                if (MS::MapExists(mapName))
                {
                    GameMasterPlayerUtils::SendConsoleMessage(playerID, mapName);
                }
            }
        }
        
        /**
         * Check if a player can vote (rate limiting and permissions)
         */
        private bool CanPlayerVote(const string &in playerID)
        {
            PlayerVoteRecord@ record = GetPlayerRecord(playerID);
            if (record is null)
                return true;  // New players can vote
                
            return record.CanVoteNow();
        }
        
        /**
         * Get or create player vote record
         */
        private PlayerVoteRecord@ GetPlayerRecord(const string &in playerID)
        {
            PlayerVoteRecord@ record;
            if (m_dPlayerRecords.get(playerID, @record))
            {
                return record;
            }
            return null;
        }
        
        /**
         * Update or create player record
         */
        void UpdatePlayerRecord(const string &in playerID, const string &in playerName,
                              const string &in ipAddress)
        {
            PlayerVoteRecord@ record = GetPlayerRecord(playerID);
            if (record is null)
            {
                @record = PlayerVoteRecord();
                record.Initialize(playerID, playerName, ipAddress);
                @m_dPlayerRecords[playerID] = record;
            }
            else
            {
                record.UpdateConnection(playerName, ipAddress);
            }
        }
        
        /**
         * Refresh server configuration from CVars
         */
        private void RefreshServerConfig()
        {
            m_bMapVotesEnabled = GameMasterPlayerUtils::GetServerCVar("msvote_map_enable", "1") == "1";
            m_bPvpVotesEnabled = GameMasterPlayerUtils::GetServerCVar("msvote_pvp_enable", "1") == "1";
            m_bLockVotesEnabled = GameMasterPlayerUtils::GetServerCVar("msvote_lock_enable", "1") == "1";
            m_bFarmingAllowed = GameMasterPlayerUtils::GetServerCVar("msvote_farm_all_day", "0") == "1";
            m_szVoteMapType = GameMasterPlayerUtils::GetServerCVar("msvote_map_type", "all");
            
            LogInfo("PlayerCommandManager: Server config refreshed - Map votes: " + 
                   (m_bMapVotesEnabled ? "enabled" : "disabled"));
        }
        
        /**
         * Set vote system busy state
         */
        void SetVoteBusy(bool busy, const string &in voteID = "")
        {
            m_bVoteBusy = busy;
            m_szCurrentVoteID = voteID;
            m_flLastVoteTime = GetGameTime();
        }
        
        /**
         * Check if vote system is busy
         */
        bool IsVoteBusy()
        {
            return m_bVoteBusy;
        }
    }
    
    // ========================================
    // Global Player Command Manager Instance
    // ========================================
    
    PlayerCommandManager@ g_PlayerCommandManager = null;
    
    /**
     * Initialize the player command system
     */
    void InitializePlayerCommands()
    {
        LogInfo("Initializing Player Command System...");
        @g_PlayerCommandManager = PlayerCommandManager();
        LogInfo("Player Command System initialized successfully");
    }
    
    /**
     * Shutdown the player command system
     */
    void ShutdownPlayerCommands()
    {
        LogInfo("Shutting down Player Command System...");
        @g_PlayerCommandManager = null;
    }
    
    /**
     * Get the global player command manager
     */
    PlayerCommandManager@ GetPlayerCommandManager()
    {
        return g_PlayerCommandManager;
    }
    
    // ========================================
    // Bridge Functions for Command System Integration
    // ========================================
    
    /**
     * Bridge function for command system integration
     * Processes a single command with parsed arguments
     */
    void ProcessPlayerCommandBridge(const string &in playerID, const string &in playerName, 
                                   const string &in command, const array<string> &in args)
    {
        if (g_PlayerCommandManager is null)
        {
            LogError("ProcessPlayerCommandBridge: PlayerCommandManager not initialized");
            return;
        }
        
        // Build full arguments array with command as first element
        array<string> fullArgs;
        fullArgs.insertLast(command);
        for (uint i = 0; i < args.length(); i++)
        {
            fullArgs.insertLast(args[i]);
        }
        
        g_PlayerCommandManager.HandlePlayerCommand(playerID, playerName, fullArgs);
    }
    
    /**
     * Check if the player command system is ready
     */
    bool IsPlayerCommandSystemReady()
    {
        return g_PlayerCommandManager !is null;
    }
    
    /**
     * Get player voting eligibility
     */
    bool CanPlayerVoteNow(const string &in playerID)
    {
        if (g_PlayerCommandManager is null)
            return false;
            
        // This would check the player's voting record and permissions
        // For now, return true as a basic implementation
        return true;
    }
    
    // ========================================
    // Player Command Handler Class (Compatibility Wrapper)
    // ========================================
    
    /**
     * Wrapper class for PlayerCommandManager to provide the interface expected by GameMaster
     * This provides compatibility between the expected interface and actual implementation
     */
    class PlayerCommandHandler
    {
        private PlayerCommandManager@ m_pManager;
        
        /**
         * Constructor
         */
        PlayerCommandHandler()
        {
            @m_pManager = GetPlayerCommandManager();
        }
        
        /**
         * Set vote manager for integration
         */
        void SetVoteManager(VoteManager@ voteManager)
        {
            // TODO: Set up integration with vote manager if needed
        }
        
        /**
         * Set transition manager for integration
         */
        void SetTransitionManager(MapTransitionManager@ transitionManager)
        {
            // TODO: Set up integration with transition manager if needed
        }
        
        /**
         * Process player command - main entry point
         */
        void ProcessPlayerCommand(const string &in playerName, const string &in command, const array<string> &in args)
        {
            if (m_pManager !is null)
            {
                // Create a new args array with the command as the first element
                array<string> fullArgs;
                fullArgs.insertLast(command);
                for (uint i = 0; i < args.length(); i++)
                {
                    fullArgs.insertLast(args[i]);
                }
                
                // For now, use empty playerID since we only have playerName
                // TODO: Look up playerID from playerName if needed
                m_pManager.HandlePlayerCommand("", playerName, fullArgs);
            }
        }
        
        /**
         * Check if vote is busy
         */
        bool IsVoteBusy()
        {
            if (m_pManager !is null)
                return m_pManager.IsVoteBusy();
            return false;
        }
    }
}

// ========================================
// Global Functions for Engine Integration
// ========================================

/**
 * Main entry point for player commands from the engine
 * This would be called by the engine when players type commands
 */
void HandlePlayerCommand(string playerID, string playerName, string command, 
                        string param1 = "", string param2 = "", string param3 = "",
                        string param4 = "", string param5 = "")
{
    if (MS::g_PlayerCommandManager is null)
    {
        LogMessage("[ERROR] PlayerCommandManager not initialized");
        return;
    }
    
    try
    {
        // Build argument array
        array<string> args;
        args.insertLast(command);
        if (!param1.isEmpty()) args.insertLast(param1);
        if (!param2.isEmpty()) args.insertLast(param2);
        if (!param3.isEmpty()) args.insertLast(param3);
        if (!param4.isEmpty()) args.insertLast(param4);
        if (!param5.isEmpty()) args.insertLast(param5);
        
        LogMessage("[VOTE] Calling PlayerCommandManager.HandlePlayerCommand with " + formatInt(args.length()) + " args");
        MS::g_PlayerCommandManager.HandlePlayerCommand(playerID, playerName, args);
        LogMessage("[VOTE] PlayerCommandManager.HandlePlayerCommand completed successfully");
    }
    catch
    {
        LogMessage("[ERROR] Exception in HandlePlayerCommand - player: " + playerName + ", command: " + command);
        LogMessage("[ERROR] Parameters: param1='" + param1 + "', param2='" + param2 + "', param3='" + param3 + "'");
    }
}

// Recursion protection for HandlePlayerSayText
int g_HandleSayTextDepth = 0;
const int MAX_SAY_TEXT_DEPTH = 2;

/**
 * Handle player commands from chat
 * This handles the say_text command routing
 * Enhanced with comprehensive validation to prevent crashes
 */
void HandlePlayerSayText(string playerID, string playerName, string text)
{
    // Recursion protection
    g_HandleSayTextDepth++;
    
    if (g_HandleSayTextDepth > MAX_SAY_TEXT_DEPTH)
    {
        LogMessage("[VOTE] ERROR: HandlePlayerSayText recursion detected (depth=" + formatInt(g_HandleSayTextDepth) + ") - blocking to prevent infinite loop");
        LogMessage("[VOTE] Player: " + playerName + ", Text: '" + text + "'");
        g_HandleSayTextDepth--;
        return;
    }
    
    if (g_HandleSayTextDepth > 1)
    {
        LogMessage("[VOTE] WARNING: HandlePlayerSayText nested call detected (depth=" + formatInt(g_HandleSayTextDepth) + ") for player " + playerName);
    }
    
    LogMessage("[VOTE] HandlePlayerSayText called - validating parameters...");
    
    // Enhanced parameter validation
    if (playerID.isEmpty())
    {
        LogMessage("[VOTE] ERROR: HandlePlayerSayText received empty playerID - blocking");
        g_HandleSayTextDepth--;
        return;
    }
    
    if (playerName.isEmpty())
    {
        LogMessage("[VOTE] ERROR: HandlePlayerSayText received empty playerName - blocking");
        g_HandleSayTextDepth--;
        return;
    }
    
    if (text.isEmpty())
    {
        LogMessage("[VOTE] ERROR: HandlePlayerSayText received empty text - blocking");
        g_HandleSayTextDepth--;
        return;
    }
    
    // Additional length validation
    if (playerID.length() > 127)
    {
        LogMessage("[VOTE] ERROR: HandlePlayerSayText playerID too long (" + formatInt(playerID.length()) + ") - blocking");
        g_HandleSayTextDepth--;
        return;
    }
    
    if (playerName.length() > 255)
    {
        LogMessage("[VOTE] ERROR: HandlePlayerSayText playerName too long (" + formatInt(playerName.length()) + ") - blocking");
        g_HandleSayTextDepth--;
        return;
    }
    
    if (text.length() > 511)
    {
        LogMessage("[VOTE] ERROR: HandlePlayerSayText text too long (" + formatInt(text.length()) + ") - blocking");
        g_HandleSayTextDepth--;
        return;
    }
    
    LogMessage("[VOTE] HandlePlayerSayText validation passed for " + playerName + ": '" + text + "'");
    
    // Safe text processing with exception handling
    array<string> tokens;
    try
    {
        // Split the text into command and parameters
        tokens = text.split(" ");
        if (tokens.length() == 0)
        {
            LogMessage("[VOTE] ERROR: HandlePlayerSayText text split resulted in empty array - blocking");
            g_HandleSayTextDepth--;
            return;
        }
    }
    catch
    {
        LogMessage("[VOTE] ERROR: Exception during text.split() in HandlePlayerSayText - text: '" + text + "'");
        g_HandleSayTextDepth--;
        return;
    }
    
    // Validate that we have a command
    if (tokens.length() > 0)
    {
        string command = tokens[0];
        if (command.length() < 4)
        {
            LogMessage("[VOTE] HandlePlayerSayText command too short: '" + command + "'");
            g_HandleSayTextDepth--;
            return;
        }
        
        // Check if this is a vote command with safe substring operation
        string commandPrefix;
        try
        {
            commandPrefix = command.substr(0, 4);
        }
        catch
        {
            LogMessage("[VOTE] ERROR: Exception during command.substr() in HandlePlayerSayText - command: '" + command + "'");
            g_HandleSayTextDepth--;
            return;
        }
        
        if (commandPrefix == "vote")
        {
            LogMessage("[VOTE] Processing vote command: " + command + " from " + playerName);
            
            try
            {
                HandlePlayerCommand(playerID, playerName, tokens);
                LogMessage("[VOTE] HandlePlayerCommand completed successfully");
            }
            catch
            {
                LogMessage("[VOTE] ERROR: Exception in HandlePlayerCommand - player: " + playerName + ", command: " + command);
            }
        }
        else
        {
            LogMessage("[VOTE] HandlePlayerSayText command not a vote command: '" + commandPrefix + "'");
        }
    }
    else
    {
        LogMessage("[VOTE] HandlePlayerSayText no tokens found in text: '" + text + "'");
    }
    
    // Decrement recursion counter
    g_HandleSayTextDepth--;
}

/**
 * Notify that a vote has completed
 * Called by the GameMaster voting system
 */
void OnVoteCompleted(string voteType, bool passed)
{
    if (MS::g_PlayerCommandManager !is null)
    {
        MS::g_PlayerCommandManager.SetVoteBusy(false, "");
    }
    
    LogMessage("[INFO] Vote completed: " + voteType + " - " + (passed ? "PASSED" : "FAILED"));
}

/**
 * Update player record when they connect
 */
void OnPlayerConnectForVoting(string playerID, string playerName, string ipAddress)
{
    if (MS::g_PlayerCommandManager !is null)
    {
        MS::g_PlayerCommandManager.UpdatePlayerRecord(playerID, playerName, ipAddress);
    }
}

// ========================================
// Utility Functions (Stubs - to be implemented by engine)
// ========================================

/**
 * These functions need to be implemented by the engine or other parts of the system
 * They are placeholders for the actual functionality
 */

// Note: MapExists function is defined in GameMasterMapTransitions.as to avoid conflicts

string GetCurrentMapName()
{
    return GetMapName();
}

bool IsOnFNServer()
{
    // Check server hostname or specific FN server CVar
    string hostname = GetCvar("hostname");
    string fnMarker = GetCvar("ms_fn_server");
    return (hostname.findFirst("[FN]") >= 0 || fnMarker == "1");
}

bool IsDeveloperMode()
{
    // Check developer CVar
    string devMode = GetCvar("developer");
    string msDevMode = GetCvar("ms_developer");
    return (devMode == "1" || msDevMode == "1");
}

uint GetCurrentPlayerCount()
{
    return uint(GetPlayerCount());
}

bool IsServerLocked()
{
    // Check if server has a password set
    string password = GetCvar("sv_password");
    return !password.isEmpty();
}

string GetServerPassword()
{
    return GetCvar("sv_password");
}

bool IsServerPvpEnabled()
{
    // Check Master Sword PvP CVar
    string pvpMode = GetCvar("ms_pvp");
    return (pvpMode == "1");
}

namespace GameMasterPlayerUtils
{
    string GetPlayerQuestData(const string &in playerID, const string &in key)
    {
        return ::GetPlayerQuestData(playerID, key);
    }

    string GetServerCVar(const string &in cvarName, const string &in defaultValue)
    {
        string result = GetCvar(cvarName);
        if (result.length() == 0)
            return defaultValue;
        return result;
    }

    void SendPlayerMessage(const string &in playerID, const string &in message)
    {
        ::SendPlayerMessage(playerID, message);  // Call global scope function to avoid recursion
    }

    void SendConsoleMessage(const string &in playerID, const string &in message)
    {
        ::SendConsoleMessage(playerID, message);  // Call global scope function to avoid recursion
    }
}

void CreateVote(const string &in callbackEvent, const string &in options,
               const string &in title, const string &in description, bool silent)
{
    // Get the GameMaster instance and create vote through VoteManager
    GameMaster@ gm = GetGameMaster();
    if (gm !is null)
    {
        MS::VoteManager@ voteManager = gm.GetVoteManager();
        if (voteManager !is null)
        {
            // Pass options string directly to VoteManager
            voteManager.CreateVote(callbackEvent, options, title, description, silent);
            LogMessage("[VOTE] Created vote: " + title);
        }
        else
        {
            LogMessage("[ERROR] VoteManager not available for vote creation");
        }
    }
    else
    {
        LogMessage("[ERROR] GameMaster not available for vote creation");
    }
}

// Note: GetGameTime function is defined in GameMasterUtils.as to avoid conflicts