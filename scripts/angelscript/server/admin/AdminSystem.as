#pragma context server

/**
 * AdminSystem.as
 * 
 * Administrative commands and developer tools. Handles admin privileges,
 * developer mode features, and special administrative functionality.
 * 
 * Key Features:
 * - Admin command processing
 * - Developer mode tools
 * - Spawn point management commands
 * - Player management commands
 * - Server debugging tools
 */

namespace MS
{
    /**
     * Administrative command system
     */
    class AdminSystem
    {
        // Admin command tracking
        array<string> m_RecentCommands;
        uint m_nMaxRecentCommands = 10;
        
        // Developer mode state
        bool m_bDevModeEnabled = false;
        string m_szCurrentDevPlayer = "";
        
        // Command aliases
        ::dictionary m_CommandAliases;
        AdminSystem()
        {
            InitializeCommandAliases();
        }
        
        /**
         * Initialize the admin system
         */
        void Initialize()
        {
            InitializeCommandAliases();
            CheckDeveloperMode();
            LogMessage("[INFO] AdminSystem initialized successfully");
        }
        
        /**
         * Shutdown the admin system
         */
        void Shutdown()
        {
            m_RecentCommands.resize(0);
            m_CommandAliases.deleteAll();
            LogMessage("[INFO] AdminSystem shutdown completed");
        }
        
        /**
         * Process admin command
         */
        bool ProcessCommand(CBasePlayer@ pPlayer, const string &in command, const array<string> &in args)
        {
            if (pPlayer is null) return false;
            
            // Check if player has admin privileges
            if (!g_PlayerManager.IsPlayerAdmin(pPlayer))
            {
                LogMessage("[WARNING] Non-admin player " + pPlayer.pev.netname + " attempted command: " + command);
                return false;
            }
            
            // Log command usage
            LogCommand(pPlayer, command, args);
            
            // Process the command
            string lowerCommand = command.toLowerCase();
            
            // Spawn point commands
            if (lowerCommand == "addspawn" || lowerCommand == "setspawn")
            {
                return HandleAddSpawnCommand(pPlayer, args);
            }
            else if (lowerCommand == "listspawns" || lowerCommand == "spawns")
            {
                return HandleListSpawnsCommand(pPlayer, args);
            }
            else if (lowerCommand == "testspawn")
            {
                return HandleTestSpawnCommand(pPlayer, args);
            }
            else if (lowerCommand == "clearspawns")
            {
                return HandleClearSpawnsCommand(pPlayer, args);
            }
            
            // Player management commands
            else if (lowerCommand == "kick")
            {
                return HandleKickCommand(pPlayer, args);
            }
            else if (lowerCommand == "ban")
            {
                return HandleBanCommand(pPlayer, args);
            }
            else if (lowerCommand == "listplayers")
            {
                return HandleListPlayersCommand(pPlayer, args);
            }
            
            // Developer mode commands
            else if (lowerCommand == "devmode")
            {
                return HandleDevModeCommand(pPlayer, args);
            }
            else if (lowerCommand == "setdev")
            {
                return HandleSetDevCommand(pPlayer, args);
            }
            
            // Server management
            else if (lowerCommand == "reload")
            {
                return HandleReloadCommand(pPlayer, args);
            }
            else if (lowerCommand == "status")
            {
                return HandleStatusCommand(pPlayer, args);
            }
            
            // Item/entity commands
            else if (lowerCommand == "give")
            {
                return HandleGiveCommand(pPlayer, args);
            }
            else if (lowerCommand == "spawn")
            {
                return HandleSpawnEntityCommand(pPlayer, args);
            }
            
            // Utility commands
            else if (lowerCommand == "teleport" || lowerCommand == "tp")
            {
                return HandleTeleportCommand(pPlayer, args);
            }
            else if (lowerCommand == "god")
            {
                return HandleGodModeCommand(pPlayer, args);
            }
            else if (lowerCommand == "noclip")
            {
                return HandleNoclipCommand(pPlayer, args);
            }
            
            // Critical NPC management commands
            else if (lowerCommand == "critnpc")
            {
                return HandleCriticalNPCCommand(pPlayer, args);
            }
            else if (lowerCommand == "respawnnpc")
            {
                return HandleRespawnNPCCommand(pPlayer, args);
            }
            else if (lowerCommand == "npcstatus")
            {
                return HandleNPCStatusCommand(pPlayer, args);
            }
            
            // Trigger system commands
            else if (lowerCommand == "testtrigger" || lowerCommand == "trigtest")
            {
                return HandleTestTriggerCommand(pPlayer, args);
            }
            else if (lowerCommand == "createhpseq" || lowerCommand == "hpseq")
            {
                return HandleCreateHPSeqCommand(pPlayer, args);
            }
            else if (lowerCommand == "resethpseq")
            {
                return HandleResetHPSeqCommand(pPlayer, args);
            }
            else if (lowerCommand == "listhpseq")
            {
                return HandleListHPSeqCommand(pPlayer, args);
            }
            else if (lowerCommand == "triggerstatus")
            {
                return HandleTriggerStatusCommand(pPlayer, args);
            }
            else if (lowerCommand == "partyinfo")
            {
                return HandlePartyInfoCommand(pPlayer, args);
            }
            
            // Magic system commands
            else if (lowerCommand == "testpotion" || lowerCommand == "potiontest")
            {
                return HandleTestPotionCommand(pPlayer, args);
            }
            else if (lowerCommand == "forgetspell")
            {
                return HandleForgetSpellSelectCommand(pPlayer, args);
            }
            else if (lowerCommand == "confirmforget")
            {
                return HandleConfirmForgetCommand(pPlayer, args);
            }
            else if (lowerCommand == "cancelforget")
            {
                return HandleCancelForgetCommand(pPlayer, args);
            }
            else if (lowerCommand == "listspells")
            {
                return HandleListSpellsCommand(pPlayer, args);
            }
            else if (lowerCommand == "learnspell")
            {
                return HandleLearnSpellCommand(pPlayer, args);
            }
            
            // Treasure system commands
            else if (lowerCommand == "treasurestatus" || lowerCommand == "trstatus")
            {
                return HandleTreasureStatusCommand(pPlayer, args);
            }
            else if (lowerCommand == "scrambletreasure" || lowerCommand == "trscramble")
            {
                return HandleScrambleTreasureCommand(pPlayer, args);
            }
            else if (lowerCommand == "addtreasurespawn" || lowerCommand == "trspawn")
            {
                return HandleAddTreasureSpawnCommand(pPlayer, args);
            }
            else if (lowerCommand == "respawntreasures" || lowerCommand == "trrespawn")
            {
                return HandleRespawnTreasuresCommand(pPlayer, args);
            }
            else if (lowerCommand == "clearfarmdata" || lowerCommand == "trfarm")
            {
                return HandleClearFarmDataCommand(pPlayer, args);
            }
            else if (lowerCommand == "generatetreasure" || lowerCommand == "trgen")
            {
                return HandleGenerateTreasureCommand(pPlayer, args);
            }
            
            // Help command
            else if (lowerCommand == "help" || lowerCommand == "commands")
            {
                return HandleHelpCommand(pPlayer, args);
            }
            
            else
            {
                SendMessageToPlayer(pPlayer, "Unknown admin command: " + command + ". Type 'help' for available commands.");
                return false;
            }
        }
        
        /**
         * Check if developer mode should be enabled
         * Converted from dev mode checks in game_master.script
         */
        void CheckDeveloperMode()
        {
            // Check cvar setting
            string devMode = GetCvar("ms_dev_mode");
            
            // Don't allow dev mode on central/FN servers
            string hostname = GetCvar("hostname");
            if (hostname.find("FN") >= 0 || GetCvar("ms_central") == "1")
            {
                if (devMode == "1")
                {
                    LogMessage("[ERROR] ms_dev_mode not allowed on [FN] servers");
                    return;
                }
            }
            
            m_bDevModeEnabled = (devMode == "1");
            g_PlayerManager.SetDeveloperMode(m_bDevModeEnabled);
            
            if (m_bDevModeEnabled)
            {
                LogMessage("[INFO] Developer mode enabled");
            }
        }
        
        /**
         * Get whether developer mode is active
         */
        bool IsDeveloperMode()
        {
            return m_bDevModeEnabled;
        }
        
        /**
         * Set developer player
         */
        void SetDeveloperPlayer(const string &in playerName)
        {
            m_szCurrentDevPlayer = playerName;
            g_PlayerManager.SetDeveloperPlayer(playerName);
            LogMessage("[INFO] Developer player set to: " + playerName);
        }
        
        /**
         * Get current developer player
         */
        string GetDeveloperPlayer()
        {
            return m_szCurrentDevPlayer;
        }
        /**
         * Initialize command aliases
         */
        void InitializeCommandAliases()
        {
            m_CommandAliases["tp"] = "teleport";
            m_CommandAliases["spawns"] = "listspawns";
            m_CommandAliases["players"] = "listplayers";
            m_CommandAliases["dev"] = "devmode";
        }
        
        /**
         * Log command usage
         */
        void LogCommand(CBasePlayer@ pPlayer, const string &in command, const array<string> &in args)
        {
            string logEntry = pPlayer.pev.netname + " used admin command: " + command;
            
            if (args.length() > 0)
            {
                logEntry += " with args: ";
                for (uint i = 0; i < args.length(); i++)
                {
                    if (i > 0) logEntry += ", ";
                    logEntry += args[i];
                }
            }
            
            LogMessage("[INFO] " + logEntry);
            
            // Add to recent commands
            m_RecentCommands.insertLast(logEntry);
            if (m_RecentCommands.length() > m_nMaxRecentCommands)
            {
                m_RecentCommands.removeAt(0);
            }
        }
        
        // Command handlers
        
        /**
         * Handle addspawn command
         */
        bool HandleAddSpawnCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            Vector3 spawnPos;
            
            if (args.length() >= 3)
            {
                // Use provided coordinates
                spawnPos.x = parseFloat(args[0]);
                spawnPos.y = parseFloat(args[1]);
                spawnPos.z = parseFloat(args[2]);
            }
            else
            {
                // Use player's current position
                spawnPos = Vector3(pPlayer.pev.origin.x, pPlayer.pev.origin.y, pPlayer.pev.origin.z);
            }
            
            if (g_SpawnSystem.AddSpawnPoint(spawnPos))
            {
                SendMessageToPlayer(pPlayer, "Spawn point added at: " + spawnPos.ToString());
                return true;
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Failed to add spawn point (maximum reached?)");
                return false;
            }
        }
        
        /**
         * Handle listspawns command
         */
        bool HandleListSpawnsCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            g_SpawnSystem.ListSpawnPoints(pPlayer);
            return true;
        }
        
        /**
         * Handle testspawn command
         */
        bool HandleTestSpawnCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (args.length() < 1)
            {
                SendMessageToPlayer(pPlayer, "Usage: testspawn <point_number>");
                return false;
            }
            
            uint pointIndex = parseInt(args[0]);
            
            if (g_SpawnSystem.TestSpawnPoint(pPlayer, pointIndex))
            {
                SendMessageToPlayer(pPlayer, "Teleported to spawn point #" + pointIndex);
                return true;
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Invalid spawn point index: " + pointIndex);
                return false;
            }
        }
        
        /**
         * Handle clearspawns command
         */
        bool HandleClearSpawnsCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "rcon"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires rcon)");
                return false;
            }
            
            g_SpawnSystem.ClearAllSpawnPoints();
            SendMessageToPlayer(pPlayer, "All spawn points cleared");
            return true;
        }
        
        /**
         * Handle kick command
         */
        bool HandleKickCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (args.length() < 1)
            {
                SendMessageToPlayer(pPlayer, "Usage: kick <player_name> [reason]");
                return false;
            }
            
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges");
                return false;
            }
            
            // Implementation would find and kick the specified player
            SendMessageToPlayer(pPlayer, "Kick command processed for: " + args[0]);
            return true;
        }
        
        /**
         * Handle ban command
         */
        bool HandleBanCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "rcon"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires rcon)");
                return false;
            }
            
            if (args.length() < 1)
            {
                SendMessageToPlayer(pPlayer, "Usage: ban <player_name> [duration] [reason]");
                return false;
            }
            
            // Implementation would ban the specified player
            SendMessageToPlayer(pPlayer, "Ban command processed for: " + args[0]);
            return true;
        }
        
        /**
         * Handle listplayers command
         */
        bool HandleListPlayersCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            array<CBasePlayer@> players = g_PlayerManager.GetActivePlayers();
            
            SendMessageToPlayer(pPlayer, "Active players (" + players.length() + "):");
            
            for (uint i = 0; i < players.length(); i++)
            {
                if (players[i] !is null)
                {
                    string playerInfo = "[" + i + "] " + players[i].pev.netname;
                    if (g_PlayerManager.IsPlayerAdmin(players[i]))
                    {
                        playerInfo += " (Admin)";
                    }
                    SendMessageToPlayer(pPlayer, playerInfo);
                }
            }
            
            return true;
        }
        
        /**
         * Handle devmode command
         */
        bool HandleDevModeCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "rcon"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires rcon)");
                return false;
            }
            
            if (args.length() > 0)
            {
                string mode = args[0].toLowerCase();
                if (mode == "on" || mode == "1" || mode == "true")
                {
                    m_bDevModeEnabled = true;
                    g_PlayerManager.SetDeveloperMode(true);
                    SendMessageToPlayer(pPlayer, "Developer mode enabled");
                }
                else if (mode == "off" || mode == "0" || mode == "false")
                {
                    m_bDevModeEnabled = false;
                    g_PlayerManager.SetDeveloperMode(false);
                    SendMessageToPlayer(pPlayer, "Developer mode disabled");
                }
                else
                {
                    SendMessageToPlayer(pPlayer, "Usage: devmode <on|off>");
                    return false;
                }
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Developer mode is: " + (m_bDevModeEnabled ? "enabled" : "disabled"));
            }
            
            return true;
        }
        
        /**
         * Handle setdev command
         */
        bool HandleSetDevCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "rcon"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires rcon)");
                return false;
            }
            
            if (args.length() > 0)
            {
                SetDeveloperPlayer(args[0]);
                SendMessageToPlayer(pPlayer, "Developer player set to: " + args[0]);
            }
            else
            {
                SetDeveloperPlayer(pPlayer.pev.netname);
                SendMessageToPlayer(pPlayer, "Developer player set to yourself");
            }
            
            return true;
        }
        
        /**
         * Handle reload command
         */
        bool HandleReloadCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "rcon"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires rcon)");
                return false;
            }
            
            SendMessageToPlayer(pPlayer, "Reload command executed");
            return true;
        }
        
        /**
         * Handle status command
         */
        bool HandleStatusCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            string status = "Server Status:\n";
            status += "Players: " + g_PlayerManager.GetPlayerCount() + "\n";
            status += "Spawn Points: " + g_SpawnSystem.GetSpawnPointCount() + "\n";
            status += "Developer Mode: " + (m_bDevModeEnabled ? "enabled" : "disabled") + "\n";
            status += "Map: " + GetCurrentMapName();
            
            SendMessageToPlayer(pPlayer, status);
            return true;
        }
        
        /**
         * Handle give command
         */
        bool HandleGiveCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "cvar"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires cvar)");
                return false;
            }
            
            if (args.length() < 2)
            {
                SendMessageToPlayer(pPlayer, "Usage: give <player> <item> [amount]");
                return false;
            }
            
            SendMessageToPlayer(pPlayer, "Give command processed: " + args[1] + " to " + args[0]);
            return true;
        }
        
        /**
         * Handle spawn entity command
         */
        bool HandleSpawnEntityCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "cvar"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires cvar)");
                return false;
            }
            
            if (args.length() < 1)
            {
                SendMessageToPlayer(pPlayer, "Usage: spawn <entity_name>");
                return false;
            }
            
            SendMessageToPlayer(pPlayer, "Spawn entity command processed: " + args[0]);
            return true;
        }
        
        /**
         * Handle teleport command
         */
        bool HandleTeleportCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (args.length() >= 3)
            {
                // Teleport to coordinates
                Vector3 dest = Vector3(parseFloat(args[0]), parseFloat(args[1]), parseFloat(args[2]));
                SendMessageToPlayer(pPlayer, "Teleported to: " + dest.ToString());
            }
            else if (args.length() == 1)
            {
                // Teleport to player
                SendMessageToPlayer(pPlayer, "Teleported to player: " + args[0]);
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Usage: teleport <x> <y> <z> OR teleport <player>");
                return false;
            }
            
            return true;
        }
        
        /**
         * Handle god mode command
         */
        bool HandleGodModeCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "cvar"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires cvar)");
                return false;
            }
            
            SendMessageToPlayer(pPlayer, "God mode toggled");
            return true;
        }
        
        /**
         * Handle noclip command
         */
        bool HandleNoclipCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "cvar"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires cvar)");
                return false;
            }
            
            SendMessageToPlayer(pPlayer, "Noclip toggled");
            return true;
        }
        
        /**
         * Handle critical NPC command
         */
        bool HandleCriticalNPCCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            if (args.length() < 1)
            {
                SendMessageToPlayer(pPlayer, "Usage: critnpc <list|register|remove|reset> [params...]");
                return false;
            }
            
            string subCommand = args[0].toLowerCase();
            
            if (subCommand == "list")
            {
                CriticalNPCManager@ critManager = GetCriticalNPCManager();
                if (critManager !is null)
                {
                    critManager.GenerateStatusReport(pPlayer);
                }
                return true;
            }
            else if (subCommand == "register" && args.length() >= 3)
            {
                string npcName = args[1];
                string npcScript = args[2];
                string displayName = (args.length() > 3) ? args[3] : npcName;
                string questChain = (args.length() > 4) ? args[4] : "";
                
                register_critical_npc(npcName, npcScript, displayName, GetCurrentMapName(), 1, questChain);
                SendMessageToPlayer(pPlayer, "Registered critical NPC: " + npcName);
                return true;
            }
            else if (subCommand == "remove" && args.length() >= 2)
            {
                remove_crit_npc(args[1]);
                SendMessageToPlayer(pPlayer, "Removed NPC from critical list: " + args[1]);
                return true;
            }
            else if (subCommand == "reset")
            {
                reset_critical_list();
                SendMessageToPlayer(pPlayer, "Critical NPC list reset to initial state");
                return true;
            }
            
            SendMessageToPlayer(pPlayer, "Usage: critnpc <list|register|remove|reset> [params...]");
            return false;
        }
        
        /**
         * Handle respawn NPC command
         */
        bool HandleRespawnNPCCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "cvar"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires cvar)");
                return false;
            }
            
            if (args.length() < 1)
            {
                SendMessageToPlayer(pPlayer, "Usage: respawnnpc <npc_name> [x] [y] [z]");
                return false;
            }
            
            string npcName = args[0];
            Vector3 spawnPos = Vector3();
            
            if (args.length() >= 4)
            {
                spawnPos.x = parseFloat(args[1]);
                spawnPos.y = parseFloat(args[2]);
                spawnPos.z = parseFloat(args[3]);
            }
            else
            {
                // Use player's current position
                spawnPos = Vector3(pPlayer.pev.origin.x, pPlayer.pev.origin.y, pPlayer.pev.origin.z);
            }
            
            if (respawn_critical_npc(npcName, spawnPos))
            {
                SendMessageToPlayer(pPlayer, "Successfully respawned critical NPC: " + npcName + " at " + spawnPos.ToString());
                return true;
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Failed to respawn NPC: " + npcName + " (not registered or cannot respawn)");
                return false;
            }
        }
        
        /**
         * Handle NPC status command
         */
        bool HandleNPCStatusCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            CriticalNPCManager@ critManager = GetCriticalNPCManager();
            if (critManager !is null)
            {
                critManager.GenerateStatusReport(pPlayer);
                
                if (args.length() > 0 && args[0].toLowerCase() == "clear" && 
                    g_PlayerManager.HasAdminPrivilege(pPlayer, "rcon"))
                {
                    clear_critical_death_history();
                    SendMessageToPlayer(pPlayer, "Death history cleared");
                }
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Critical NPC Manager not available");
            }
            
            return true;
        }
        
        /**
         * Handle test trigger command
         */
        bool HandleTestTriggerCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            if (args.length() < 1)
            {
                SendMessageToPlayer(pPlayer, "Usage: testtrigger <filter_condition>");
                SendMessageToPlayer(pPlayer, "Examples: testtrigger \"totalhp>500\"");
                SendMessageToPlayer(pPlayer, "          testtrigger \"nplayers>2&race=human\"");
                return false;
            }
            
            string filter = args[0];
            Vector3 playerPos = Vector3(pPlayer.pev.origin.x, pPlayer.pev.origin.y, pPlayer.pev.origin.z);
            
            bool result = AdvancedTriggerSystem_EvaluateFilter(filter, playerPos);
            
            SendMessageToPlayer(pPlayer, "Trigger filter '" + filter + "' result: " + (result ? "TRUE" : "FALSE"));
            
            return true;
        }
        
        /**
         * Handle create HP sequence command
         */
        bool HandleCreateHPSeqCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "cvar"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires cvar)");
                return false;
            }
            
            if (args.length() < 1)
            {
                SendMessageToPlayer(pPlayer, "Usage: createhpseq <name> [radius]");
                SendMessageToPlayer(pPlayer, "Creates an HP sequence trigger at your current position");
                return false;
            }
            
            string seqName = args[0];
            float radius = 500.0f;
            
            if (args.length() > 1)
            {
                radius = parseFloat(args[1]);
            }
            
            Vector3 playerPos = Vector3(pPlayer.pev.origin.x, pPlayer.pev.origin.y, pPlayer.pev.origin.z);
            
            int seqIndex = CreateClassicHPSequence(seqName, playerPos, radius);
            
            if (seqIndex >= 0)
            {
                SendMessageToPlayer(pPlayer, "Created HP sequence '" + seqName + "' at your position (radius: " + radius + ")");
                SendMessageToPlayer(pPlayer, "Sequence index: " + seqIndex);
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Failed to create HP sequence: " + seqName);
            }
            
            return true;
        }
        
        /**
         * Handle reset HP sequence command
         */
        bool HandleResetHPSeqCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            if (args.length() < 1)
            {
                SendMessageToPlayer(pPlayer, "Usage: resethpseq <sequence_index|all>");
                return false;
            }
            
            string target = args[0].toLowerCase();
            
            if (target == "all")
            {
                HPSequenceTrigger@ pSystem = GetHPSequenceTrigger();
                if (pSystem !is null)
                {
                    pSystem.ResetAllSequences();
                    SendMessageToPlayer(pPlayer, "Reset all HP sequences");
                }
            }
            else
            {
                int seqIndex = parseInt(target);
                ResetHPSequence(seqIndex);
                SendMessageToPlayer(pPlayer, "Reset HP sequence " + seqIndex);
            }
            
            return true;
        }
        
        /**
         * Handle list HP sequences command
         */
        bool HandleListHPSeqCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            HPSequenceTrigger@ pSystem = GetHPSequenceTrigger();
            if (pSystem !is null)
            {
                pSystem.DumpSequenceInfo();
                SendMessageToPlayer(pPlayer, "HP sequence info logged to console");
            }
            else
            {
                SendMessageToPlayer(pPlayer, "HP sequence system not available");
            }
            
            return true;
        }
        
        /**
         * Handle trigger status command
         */
        bool HandleTriggerStatusCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            // Get HP sequence stats
            HPSequenceTrigger@ pHPSystem = GetHPSequenceTrigger();
            if (pHPSystem !is null)
            {
                uint nActiveSeq, nTotalTriggers, nSeqTriggered;
                pHPSystem.GetStatistics(nActiveSeq, nTotalTriggers, nSeqTriggered);
                
                SendMessageToPlayer(pPlayer, "HP Sequences: " + nActiveSeq + " active, " + 
                                   nTotalTriggers + " total triggers, " + nSeqTriggered + " sequences triggered");
            }
            
            // Get advanced trigger stats
            AdvancedTriggerSystem@ pTrigSystem = GetAdvancedTriggerSystem();
            if (pTrigSystem !is null)
            {
                uint nTriggerChecks, nPlayerCount;
                float fTotalHP;
                pTrigSystem.GetTriggerStats(nTriggerChecks, nPlayerCount, fTotalHP);
                
                SendMessageToPlayer(pPlayer, "Current party: " + nPlayerCount + " players, " + 
                                   fTotalHP + " total HP");
            }
            
            return true;
        }
        
        /**
         * Handle party info command
         */
        bool HandlePartyInfoCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            AdvancedTriggerSystem@ pSystem = GetAdvancedTriggerSystem();
            if (pSystem !is null)
            {
                Vector3 playerPos = Vector3(pPlayer.pev.origin.x, pPlayer.pev.origin.y, pPlayer.pev.origin.z);
                PartyAnalysis analysis = pSystem.GetCurrentPartyAnalysis(playerPos);
                
                SendMessageToPlayer(pPlayer, "=== Party Analysis ===");
                SendMessageToPlayer(pPlayer, "Players: " + analysis.nPlayerCount);
                SendMessageToPlayer(pPlayer, "Total HP: " + analysis.fTotalHP);
                SendMessageToPlayer(pPlayer, "Average HP: " + analysis.fAverageHP);
                SendMessageToPlayer(pPlayer, "Level range: " + analysis.nMinLevel + " - " + analysis.nMaxLevel);
                SendMessageToPlayer(pPlayer, "Races: " + analysis.nHumans + " humans, " + analysis.nElves + " elves, " + 
                                   analysis.nOrcs + " orcs, " + analysis.nDwarves + " dwarves");
                SendMessageToPlayer(pPlayer, "Classes: " + analysis.nWarriors + " warriors, " + analysis.nMages + " mages, " + 
                                   analysis.nRogues + " rogues, " + analysis.nArchers + " archers");
                SendMessageToPlayer(pPlayer, "Allegiance: " + analysis.nAllies + " allies, " + analysis.nEnemies + " enemies");
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Advanced trigger system not available");
            }
            
            return true;
        }
        
        /**
         * Handle test potion command (admin/dev command for testing Potion of Forgetfulness)
         */
        bool HandleTestPotionCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!IsPlayerDeveloper(pPlayer))
            {
                SendMessageToPlayer(pPlayer, "This command requires developer privileges");
                return false;
            }
            
            SendMessageToPlayer(pPlayer, "Testing Potion of Forgetfulness system...");
            
            // Use the magic system's Potion of Forgetfulness handler
            if (MS::UsePotionOfForgetfulness(pPlayer, "test_potion_admin"))
            {
                SendMessageToPlayer(pPlayer, "Potion of Forgetfulness activated successfully");
                return true;
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Failed to activate Potion of Forgetfulness");
                return false;
            }
        }
        
        /**
         * Handle forget spell selection command
         */
        bool HandleForgetSpellSelectCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (args.length() < 2)
            {
                SendMessageToPlayer(pPlayer, "Usage: forgetspell <number>");
                return false;
            }
            
            // Parse spell index
            uint nSpellIndex = parseUInt(args[1]);
            if (nSpellIndex == 0)
            {
                SendMessageToPlayer(pPlayer, "Invalid spell number. Use a number from 1-7.");
                return false;
            }
            
            // Call the magic system handler
            if (MS::HandleForgetSpellCommand(pPlayer, nSpellIndex))
            {
                SendMessageToPlayer(pPlayer, "Spell selected for forgetting");
                return true;
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Failed to select spell for forgetting");
                return false;
            }
        }
        
        /**
         * Handle confirm forget command
         */
        bool HandleConfirmForgetCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            // Call the magic system handler
            if (MS::HandleConfirmForgetCommand(pPlayer))
            {
                SendMessageToPlayer(pPlayer, "Spell forgetting confirmed");
                return true;
            }
            else
            {
                SendMessageToPlayer(pPlayer, "No active spell forgetting to confirm");
                return false;
            }
        }
        
        /**
         * Handle cancel forget command
         */
        bool HandleCancelForgetCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            // Call the magic system handler
            if (MS::HandleCancelForgetCommand(pPlayer))
            {
                SendMessageToPlayer(pPlayer, "Spell forgetting cancelled");
                return true;
            }
            else
            {
                SendMessageToPlayer(pPlayer, "No active spell forgetting to cancel");
                return false;
            }
        }
        
        /**
         * Handle list spells command (admin/dev command)
         */
        bool HandleListSpellsCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!IsPlayerDeveloper(pPlayer))
            {
                SendMessageToPlayer(pPlayer, "This command requires developer privileges");
                return false;
            }
            
            MS::MagicSystem@ pMagicSystem = MS::GetMagicSystem();
            if (pMagicSystem is null)
            {
                SendMessageToPlayer(pPlayer, "Magic system not initialized");
                return false;
            }
            
            MS::SpellRegistry@ pRegistry = pMagicSystem.GetSpellRegistry();
            if (pRegistry is null)
            {
                SendMessageToPlayer(pPlayer, "Spell registry not available");
                return false;
            }
            
            string szPlayerID = pMagicSystem.GetPlayerSteamID(pPlayer);
            array<string> learnedSpells = pRegistry.GetPlayerSpellNames(szPlayerID);
            
            if (learnedSpells.length() == 0)
            {
                SendMessageToPlayer(pPlayer, "You have no learned spells");
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Your learned spells (" + learnedSpells.length() + " total):");
                for (uint i = 0; i < learnedSpells.length(); i++)
                {
                    SendMessageToPlayer(pPlayer, "  " + (i + 1) + ". " + learnedSpells[i]);
                }
            }
            
            return true;
        }
        
        /**
         * Handle learn spell command (admin/dev command)
         */
        bool HandleLearnSpellCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!IsPlayerDeveloper(pPlayer))
            {
                SendMessageToPlayer(pPlayer, "This command requires developer privileges");
                return false;
            }
            
            if (args.length() < 2)
            {
                SendMessageToPlayer(pPlayer, "Usage: learnspell <spell_script_name>");
                SendMessageToPlayer(pPlayer, "Example: learnspell magic_hand_fire_ball");
                return false;
            }
            
            MS::MagicSystem@ pMagicSystem = MS::GetMagicSystem();
            if (pMagicSystem is null)
            {
                SendMessageToPlayer(pPlayer, "Magic system not initialized");
                return false;
            }
            
            MS::SpellRegistry@ pRegistry = pMagicSystem.GetSpellRegistry();
            if (pRegistry is null)
            {
                SendMessageToPlayer(pPlayer, "Spell registry not available");
                return false;
            }
            
            string szSpellScript = args[1];
            string szPlayerID = pMagicSystem.GetPlayerSteamID(pPlayer);
            
            if (pRegistry.PlayerLearnSpell(szPlayerID, szSpellScript))
            {
                SendMessageToPlayer(pPlayer, "Successfully learned spell: " + szSpellScript);
                return true;
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Failed to learn spell: " + szSpellScript);
                return false;
            }
        }
        
        /**
         * Handle help command
         */
        bool HandleHelpCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            array<string> helpText = {
                "Available Admin Commands:",
                "Spawn Management: addspawn, listspawns, testspawn, clearspawns",
                "Player Management: kick, ban, listplayers",
                "Developer: devmode, setdev",
                "Server: reload, status",
                "Items: give, spawn",
                "Utility: teleport, god, noclip",
                "Critical NPCs: critnpc, respawnnpc, npcstatus",
                "Trigger Systems: testtrigger, createhpseq, resethpseq, listhpseq, triggerstatus, partyinfo",
                "Magic System: testpotion, forgetspell, confirmforget, cancelforget, listspells, learnspell",
                "Treasure System: treasurestatus, scrambletreasure, addtreasurespawn, respawntreasures, clearfarmdata, generatetreasure",
                "Type 'help <command>' for detailed info"
            };
            
            for (uint i = 0; i < helpText.length(); i++)
            {
                SendMessageToPlayer(pPlayer, helpText[i]);
            }
            
            return true;
        }
        
        /**
         * Send message to specific player
         */
        void SendMessageToPlayer(CBasePlayer@ pPlayer, const string &in message)
        {
            if (pPlayer is null) return;
            
            // This would use the actual player messaging system
            // For now, we'll log it
            LogMessage("[INFO] Message to " + pPlayer.pev.netname + ": " + message);
        }
        
        /**
         * Get current map name
         */
        string GetCurrentMapName()
        {
            return "edana"; // Placeholder
        }
        
        /**
         * Parse string to float
         */
        float parseFloat(const string &in str)
        {
            // Placeholder implementation
            return 0.0f;
        }
        
        /**
         * Parse string to int
         */
        int parseInt(const string &in str)
        {
            // Placeholder implementation
            return 0;
        }
        
        /**
         * Handle treasure status command
         */
        bool HandleTreasureStatusCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            MS::TreasureManager@ pTreasureManager = MS::GetTreasureManager();
            if (pTreasureManager !is null)
            {
                pTreasureManager.GenerateStatusReport(pPlayer);
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Treasure system not available");
            }
            
            return true;
        }
        
        /**
         * Handle scramble treasure command
         */
        bool HandleScrambleTreasureCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "cvar"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires cvar)");
                return false;
            }
            
            MS::ForceTreasureScramble();
            SendMessageToPlayer(pPlayer, "Treasure scramble initiated - all treasure lists randomized");
            
            return true;
        }
        
        /**
         * Handle add treasure spawn command
         */
        bool HandleAddTreasureSpawnCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "cvar"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires cvar)");
                return false;
            }
            
            Vector3 spawnPos;
            uint difficulty = 1;
            float respawnTime = 300.0f;
            
            if (args.length() >= 3)
            {
                // Use provided coordinates
                spawnPos.x = parseFloat(args[0]);
                spawnPos.y = parseFloat(args[1]);
                spawnPos.z = parseFloat(args[2]);
                
                if (args.length() >= 4)
                {
                    difficulty = parseUInt(args[3]);
                }
                
                if (args.length() >= 5)
                {
                    respawnTime = parseFloat(args[4]);
                }
            }
            else
            {
                // Use player's current position
                spawnPos = Vector3(pPlayer.pev.origin.x, pPlayer.pev.origin.y, pPlayer.pev.origin.z);
                
                if (args.length() >= 1)
                {
                    difficulty = parseUInt(args[0]);
                }
                
                if (args.length() >= 2)
                {
                    respawnTime = parseFloat(args[1]);
                }
            }
            
            MS::TreasureManager@ pTreasureManager = MS::GetTreasureManager();
            if (pTreasureManager !is null)
            {
                string mapName = GetCurrentMapName();
                if (pTreasureManager.RegisterSpawnPoint(spawnPos, mapName, difficulty, respawnTime))
                {
                    SendMessageToPlayer(pPlayer, "Treasure spawn point added at " + spawnPos.ToString() + 
                                       " (difficulty: " + difficulty + ", respawn: " + respawnTime + "s)");
                    return true;
                }
            }
            
            SendMessageToPlayer(pPlayer, "Failed to add treasure spawn point");
            return false;
        }
        
        /**
         * Handle respawn treasures command
         */
        bool HandleRespawnTreasuresCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            MS::TreasureManager@ pTreasureManager = MS::GetTreasureManager();
            if (pTreasureManager !is null)
            {
                pTreasureManager.ForceRespawnAllTreasures();
                SendMessageToPlayer(pPlayer, "All treasure respawn points activated");
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Treasure system not available");
            }
            
            return true;
        }
        
        /**
         * Handle clear farm data command
         */
        bool HandleClearFarmDataCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "standard"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires standard)");
                return false;
            }
            
            string targetPlayer = "";
            if (args.length() > 0)
            {
                targetPlayer = args[0];
            }
            
            MS::TreasureManager@ pTreasureManager = MS::GetTreasureManager();
            if (pTreasureManager !is null)
            {
                pTreasureManager.ClearPlayerFarmingData(targetPlayer);
                
                if (targetPlayer.isEmpty())
                {
                    SendMessageToPlayer(pPlayer, "Cleared all player anti-farming data");
                }
                else
                {
                    SendMessageToPlayer(pPlayer, "Cleared anti-farming data for player: " + targetPlayer);
                }
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Treasure system not available");
            }
            
            return true;
        }
        
        /**
         * Handle generate treasure command
         */
        bool HandleGenerateTreasureCommand(CBasePlayer@ pPlayer, const array<string> &in args)
        {
            if (!g_PlayerManager.HasAdminPrivilege(pPlayer, "cvar"))
            {
                SendMessageToPlayer(pPlayer, "Insufficient privileges (requires cvar)");
                return false;
            }
            
            Vector3 spawnPos;
            uint difficulty = 1;
            
            if (args.length() >= 3)
            {
                // Use provided coordinates
                spawnPos.x = parseFloat(args[0]);
                spawnPos.y = parseFloat(args[1]);
                spawnPos.z = parseFloat(args[2]);
                
                if (args.length() >= 4)
                {
                    difficulty = parseUInt(args[3]);
                }
            }
            else
            {
                // Use player's current position
                spawnPos = Vector3(pPlayer.pev.origin.x, pPlayer.pev.origin.y, pPlayer.pev.origin.z);
                
                if (args.length() >= 1)
                {
                    difficulty = parseUInt(args[0]);
                }
            }
            
            if (MS::GenerateTreasureForPlayer(pPlayer, spawnPos, difficulty))
            {
                SendMessageToPlayer(pPlayer, "Treasure generated at " + spawnPos.ToString() + 
                                   " (difficulty: " + difficulty + ")");
                return true;
            }
            else
            {
                SendMessageToPlayer(pPlayer, "Failed to generate treasure (anti-farming protection may be active)");
                return false;
            }
        }
        
        /**
         * Parse string to unsigned int
         */
        uint parseUInt(const string &in str)
        {
            // Placeholder implementation
            return 1;
        }
    };
    
    // Global admin system instance
    AdminSystem g_AdminSystem;
}