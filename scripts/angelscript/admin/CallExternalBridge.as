/**
 * CallExternalBridge.as
 * 
 * Legacy compatibility layer that translates old callexternal patterns to the new 
 * EntityCommunicationSystem. This maintains backward compatibility with existing 
 * .script files while providing the benefits of the new system.
 * 
 * Key Features:
 * - Translate legacy callexternal syntax to new system
 * - Handle parameter parsing and type conversion
 * - Support for existing script patterns
 * - Backward compatibility with .script files
 * - Automatic registration of Game Master handlers
 */

namespace MS
{
    /**
     * Convert string to lowercase for case-insensitive comparison
     */
    string StringToLower(const string &in str)
    {
        string result = "";
        for (uint i = 0; i < str.length(); i++)
        {
            uint8 c = str[i];
            if (c >= uint8(65) && c <= uint8(90))  // 'A' to 'Z'
                c = c + uint8(32);  // Convert to lowercase
            result += c;
        }
        return result;
    }
    
    /**
     * Game Master Communication Handler
     * Handles all communications directed to the GAME_MASTER target
     */
    class GameMasterCommHandler : ICommunicationHandler
    {
        uint m_nHandledMessages;
        
        GameMasterCommHandler()
        {
            m_nHandledMessages = 0;
        }
        
        /**
         * Handle a message directed to the Game Master
         */
        bool HandleMessage(const CommunicationMessage &in message)
        {
            m_nHandledMessages++;
            
            LogMessage("[DEBUG] GameMasterCommHandler: Processing " + message.szFunction + 
                      " from " + message.szSenderID);
            
            // Route to appropriate subsystem based on function name
            string function = StringToLower(message.szFunction);
            
            // Quest system functions
            if (function == "ext_got_quest_item")
            {
                return HandleQuestItemFound(message);
            }
            else if (function == "ext_check_quest_item")
            {
                return HandleQuestItemRequest(message);
            }
            else if (function == "ext_receive_quest_item")
            {
                return HandleQuestItemReceived(message);
            }
            else if (function == "ext_dump_quest_items")
            {
                return HandleDumpQuestItems(message);
            }
            
            // Critical NPC management functions
            else if (function == "gm_crit_npc_died")
            {
                return HandleCriticalNPCDeath(message);
            }
            else if (function == "register_critical_npc")
            {
                return HandleRegisterCriticalNPC(message);
            }
            
            // Admin and command functions
            else if (function == "admin_command")
            {
                return HandleAdminCommand(message);
            }
            else if (function == "player_command")
            {
                return HandlePlayerCommand(message);
            }
            
            // Trigger system functions
            else if (function == "trigger_activate")
            {
                return HandleTriggerActivate(message);
            }
            else if (function == "environmental_event")
            {
                return HandleEnvironmentalEvent(message);
            }
            
            // Map transition functions
            else if (function == "map_transition")
            {
                return HandleMapTransition(message);
            }
            else if (function == "player_spawn")
            {
                return HandlePlayerSpawn(message);
            }
            
            // Voting system functions
            else if (function == "vote_start")
            {
                return HandleVoteStart(message);
            }
            else if (function == "vote_cast")
            {
                return HandleVoteCast(message);
            }
            
            // Development and debug functions
            else if (function == "dev_test")
            {
                return HandleDevTest(message);
            }
            else if (function == "debug_info")
            {
                return HandleDebugInfo(message);
            }
            
            // Gold and treasure functions
            else if (function == "gold_spew")
            {
                return HandleGoldSpew(message);
            }
            else if (function == "treasure_spawn")
            {
                return HandleTreasureSpawn(message);
            }
            
            // Light system functions
            else if (function == "light_request")
            {
                return HandleLightRequest(message);
            }
            else if (function == "light_release")
            {
                return HandleLightRelease(message);
            }
            
            // General Game Master functions
            else if (function == "gm_message")
            {
                return HandleGameMasterMessage(message);
            }
            else if (function == "gm_event")
            {
                return HandleGameMasterEvent(message);
            }
            
            else
            {
                LogMessage("[WARNING] GameMasterCommHandler: Unknown function '" + 
                          message.szFunction + "' from " + message.szSenderID);
                return false;
            }
        }
        
        /**
         * Get handler name
         */
        string GetHandlerName()
        {
            return "Game Master Communication Handler";
        }
        
        /**
         * Get supported functions
         */
        array<string> GetSupportedFunctions()
        {
            array<string> functions = {
                "ext_got_quest_item", "ext_check_quest_item", "ext_receive_quest_item", "ext_dump_quest_items",
                "gm_crit_npc_died", "register_critical_npc",
                "admin_command", "player_command",
                "trigger_activate", "environmental_event",
                "map_transition", "player_spawn",
                "vote_start", "vote_cast",
                "dev_test", "debug_info",
                "gold_spew", "treasure_spawn",
                "light_request", "light_release",
                "gm_message", "gm_event"
            };
            return functions;
        }
        
        /**
         * Get statistics
         */
        uint GetHandledMessageCount()
        {
            return m_nHandledMessages;
        }
        
        // Quest System Handlers
        
        /**
         * Handle quest item found by player
         * Legacy: callexternal GAME_MASTER ext_got_quest_item ITEM_TYPE
         */
        bool HandleQuestItemFound(const CommunicationMessage &in message)
        {
            if (message.szParameters.length() < 1)
            {
                LogMessage("[WARNING] GameMasterCommHandler: ext_got_quest_item missing item type parameter");
                return false;
            }
            
            string itemType = message.szParameters[0];
            string playerID = message.szSenderID;
            
            // Convert entity ID to player ID if needed
            if (message.hSender.IsValid())
            {
                // TODO: Get actual player ID from entity
                playerID = GetPlayerIDFromEntity(message.hSender);
            }
            
            LogMessage("[INFO] GameMasterCommHandler: Player " + playerID + " found quest item: " + itemType);
            
            // Route to quest tracker
            QuestTracker@ questTracker = GetQuestTracker();
            if (questTracker !is null)
            {
                questTracker.PlayerFoundQuestItem(playerID, itemType);
                return true;
            }
            else
            {
                LogMessage("[ERROR] GameMasterCommHandler: QuestTracker not available");
                return false;
            }
        }
        
        /**
         * Handle NPC requesting quest items
         * Legacy: callexternal GAME_MASTER ext_check_quest_item ITEM_TYPE NPC_ID
         */
        bool HandleQuestItemRequest(const CommunicationMessage &in message)
        {
            if (message.szParameters.length() < 1)
            {
                LogMessage("[WARNING] GameMasterCommHandler: ext_check_quest_item missing parameters");
                return false;
            }
            
            string itemType = message.szParameters[0];
            string npcID = (message.szParameters.length() > 1) ? message.szParameters[1] : message.szSenderID;
            uint quantity = (message.szParameters.length() > 2) ? parseInt(message.szParameters[2]) : 1;
            
            LogMessage("[INFO] GameMasterCommHandler: NPC " + npcID + " requesting " + quantity + "x " + itemType);
            
            // Route to quest tracker
            QuestTracker@ questTracker = GetQuestTracker();
            if (questTracker !is null)
            {
                uint delivered = questTracker.NPCRequestQuestItem(itemType, npcID, quantity, true);
                LogMessage("[INFO] GameMasterCommHandler: Delivered " + delivered + "/" + quantity + " " + itemType + " to " + npcID);
                return delivered > 0;
            }
            else
            {
                LogMessage("[ERROR] GameMasterCommHandler: QuestTracker not available");
                return false;
            }
        }
        
        /**
         * Handle quest item received notification
         */
        bool HandleQuestItemReceived(const CommunicationMessage &in message)
        {
            if (message.szParameters.length() < 2)
            {
                LogMessage("[WARNING] GameMasterCommHandler: ext_receive_quest_item missing parameters");
                return false;
            }
            
            string itemType = message.szParameters[0];
            string playerID = message.szParameters[1];
            
            LogMessage("[INFO] GameMasterCommHandler: NPC " + message.szSenderID + " received " + itemType + " from " + playerID);
            
            // This is typically handled by individual NPC scripts
            // Just log the event for now
            return true;
        }
        
        /**
         * Handle dump quest items request
         */
        bool HandleDumpQuestItems(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Dumping quest items");
            
            QuestTracker@ questTracker = GetQuestTracker();
            if (questTracker !is null)
            {
                questTracker.DumpAllQuestItems();
                return true;
            }
            else
            {
                LogMessage("[ERROR] GameMasterCommHandler: QuestTracker not available");
                return false;
            }
        }
        
        // Critical NPC Management Handlers
        
        /**
         * Handle critical NPC death notification
         * Legacy: callexternal GAME_MASTER gm_crit_npc_died $get(ent_me,id) $get(ent_laststruck,id)
         */
        bool HandleCriticalNPCDeath(const CommunicationMessage &in message)
        {
            if (message.szParameters.length() < 2)
            {
                LogMessage("[WARNING] GameMasterCommHandler: gm_crit_npc_died missing parameters");
                return false;
            }
            
            string npcID = message.szParameters[0];
            string killerID = message.szParameters[1];
            
            LogMessage("[INFO] GameMasterCommHandler: Critical NPC died - " + npcID + " killed by " + killerID);
            
            // Route to critical NPC manager
            CriticalNPCManager@ critManager = GetCriticalNPCManager();
            if (critManager !is null)
            {
                critManager.CriticalNPCDied(npcID, killerID);
                return true;
            }
            else
            {
                LogMessage("[ERROR] GameMasterCommHandler: CriticalNPCManager not available");
                return false;
            }
        }
        
        /**
         * Handle critical NPC registration
         */
        bool HandleRegisterCriticalNPC(const CommunicationMessage &in message)
        {
            if (message.szParameters.length() < 3)
            {
                LogMessage("[WARNING] GameMasterCommHandler: register_critical_npc missing parameters");
                return false;
            }
            
            string npcName = message.szParameters[0];
            string npcScript = message.szParameters[1];
            string displayName = message.szParameters[2];
            string mapName = (message.szParameters.length() > 3) ? message.szParameters[3] : "";
            uint importance = (message.szParameters.length() > 4) ? parseInt(message.szParameters[4]) : 1;
            string questChain = (message.szParameters.length() > 5) ? message.szParameters[5] : "";
            
            LogMessage("[INFO] GameMasterCommHandler: Registering critical NPC: " + npcName);
            
            register_critical_npc(npcName, npcScript, displayName, mapName, importance, questChain);
            return true;
        }
        
        // Admin and Command Handlers
        
        /**
         * Handle admin command routing
         */
        bool HandleAdminCommand(const CommunicationMessage &in message)
        {
            if (message.szParameters.length() < 1)
            {
                LogMessage("[WARNING] GameMasterCommHandler: admin_command missing command parameter");
                return false;
            }
            
            string command = message.szParameters[0];
            array<string> args;
            
            for (uint i = 1; i < message.szParameters.length(); i++)
            {
                args.insertLast(message.szParameters[i]);
            }
            
            LogMessage("[INFO] GameMasterCommHandler: Admin command: " + command + " from " + message.szSenderID);
            
            // Route to admin system (would need player context)
            // For now, just log the command
            return true;
        }
        
        /**
         * Handle player command routing
         */
        bool HandlePlayerCommand(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Player command from " + message.szSenderID);
            return true;
        }
        
        // Trigger System Handlers
        
        /**
         * Handle trigger activation
         */
        bool HandleTriggerActivate(const CommunicationMessage &in message)
        {
            if (message.szParameters.length() < 1)
            {
                LogMessage("[WARNING] GameMasterCommHandler: trigger_activate missing trigger name");
                return false;
            }
            
            string triggerName = message.szParameters[0];
            string activatorID = (message.szParameters.length() > 1) ? message.szParameters[1] : message.szSenderID;
            
            LogMessage("[INFO] GameMasterCommHandler: Trigger activated: " + triggerName + " by " + activatorID);
            
            // Route to trigger system
            AdvancedTriggerSystem@ triggerSystem = GetAdvancedTriggerSystem();
            if (triggerSystem !is null)
            {
                // Trigger systems would handle this
                return true;
            }
            
            return true;
        }
        
        /**
         * Handle environmental events
         */
        bool HandleEnvironmentalEvent(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Environmental event from " + message.szSenderID);
            return true;
        }
        
        // Map and Player Management Handlers
        
        /**
         * Handle map transitions
         */
        bool HandleMapTransition(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Map transition from " + message.szSenderID);
            return true;
        }
        
        /**
         * Handle player spawn events
         */
        bool HandlePlayerSpawn(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Player spawn event from " + message.szSenderID);
            return true;
        }
        
        // Voting System Handlers
        
        /**
         * Handle vote start
         */
        bool HandleVoteStart(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Vote started by " + message.szSenderID);
            return true;
        }
        
        /**
         * Handle vote cast
         */
        bool HandleVoteCast(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Vote cast by " + message.szSenderID);
            return true;
        }
        
        // Development and Debug Handlers
        
        /**
         * Handle development test functions
         */
        bool HandleDevTest(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Dev test from " + message.szSenderID);
            return true;
        }
        
        /**
         * Handle debug info requests
         */
        bool HandleDebugInfo(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Debug info request from " + message.szSenderID);
            return true;
        }
        
        // Game Master Specific Handlers
        
        /**
         * Handle gold spew events
         */
        bool HandleGoldSpew(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Gold spew from " + message.szSenderID);
            return true;
        }
        
        /**
         * Handle treasure spawn events
         */
        bool HandleTreasureSpawn(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Treasure spawn from " + message.szSenderID);
            return true;
        }
        
        /**
         * Handle light system requests
         */
        bool HandleLightRequest(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Light request from " + message.szSenderID);
            return true;
        }
        
        /**
         * Handle light system releases
         */
        bool HandleLightRelease(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: Light release from " + message.szSenderID);
            return true;
        }
        
        /**
         * Handle general Game Master messages
         */
        bool HandleGameMasterMessage(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: GM message from " + message.szSenderID);
            return true;
        }
        
        /**
         * Handle general Game Master events
         */
        bool HandleGameMasterEvent(const CommunicationMessage &in message)
        {
            LogMessage("[INFO] GameMasterCommHandler: GM event from " + message.szSenderID);
            return true;
        }
        
        // Utility Functions
        
        /**
         * Convert entity handle to player ID
         */
        string GetPlayerIDFromEntity(EntityHandle hEntity)
        {
            if (!hEntity.IsValid())
                return "unknown";
            
            // TODO: Implement actual player ID lookup
            // This would query the entity for player information
            // For now, use a simple counter approach
            uint s_nPlayerCounter = g_GameMasterHandler !is null ? g_GameMasterHandler.m_nHandledMessages : 0;
            return "player_" + s_nPlayerCounter;
        }
        
        /**
         * Parse string to integer
         */
        int parseInt(const string &in str)
        {
            // TODO: Implement proper string to int conversion
            // For now, return 0 as default
            return 0;
        }
    }
    
    // Global Game Master handler instance
    GameMasterCommHandler@ g_GameMasterHandler = null;
    
    /**
     * Initialize the call external bridge system
     */
    void InitializeCallExternalBridge()
    {
        LogMessage("[INFO] CallExternalBridge: Initializing legacy compatibility layer");
        
        // Create Game Master handler
        if (g_GameMasterHandler is null)
        {
            @g_GameMasterHandler = GameMasterCommHandler();
        }
        
        // Register with communication system
        EntityCommunicationSystem@ commSystem = GetEntityCommunicationSystem();
        if (commSystem !is null)
        {
            commSystem.RegisterHandler("GAME_MASTER", g_GameMasterHandler);
            LogMessage("[INFO] CallExternalBridge: Game Master handler registered");
        }
        else
        {
            LogMessage("[ERROR] CallExternalBridge: Communication system not available");
        }
        
        LogMessage("[INFO] CallExternalBridge: Legacy compatibility layer initialized");
    }
    
    /**
     * Shutdown the call external bridge system
     */
    void ShutdownCallExternalBridge()
    {
        EntityCommunicationSystem@ commSystem = GetEntityCommunicationSystem();
        if (commSystem !is null)
        {
            commSystem.UnregisterHandler("GAME_MASTER");
        }
        
        @g_GameMasterHandler = null;
        LogMessage("[INFO] CallExternalBridge: Legacy compatibility layer shutdown");
    }
    
    /**
     * Get the Game Master handler statistics
     */
    uint GetGameMasterHandlerStats()
    {
        if (g_GameMasterHandler !is null)
        {
            return g_GameMasterHandler.GetHandledMessageCount();
        }
        return 0;
    }
    
    // Legacy compatibility functions
    
    /**
     * Legacy callexternal function for backward compatibility
     * This provides the same interface as the original callexternal
     */
    bool callexternal(const string &in szTarget, const string &in szFunction, 
                     const string &in szParam1 = "", const string &in szParam2 = "",
                     const string &in szParam3 = "", const string &in szParam4 = "")
    {
        return CallExternal(szTarget, szFunction, szParam1, szParam2, szParam3, szParam4);
    }
    
    /**
     * Enhanced callexternal with entity context
     */
    bool callexternal_entity(const string &in szTarget, const string &in szFunction, 
                            EntityHandle hSender,
                            const string &in szParam1 = "", const string &in szParam2 = "",
                            const string &in szParam3 = "", const string &in szParam4 = "")
    {
        return CallExternal(szTarget, szFunction, szParam1, szParam2, szParam3, szParam4, hSender);
    }
    
    /**
     * Wrapper for common quest item patterns
     */
    bool quest_item_found(const string &in szItemType, EntityHandle hPlayer = EntityHandle())
    {
        return CallExternal("GAME_MASTER", "ext_got_quest_item", szItemType, "", "", "", hPlayer);
    }
    
    /**
     * Wrapper for common NPC death patterns
     */
    bool critical_npc_died(const string &in szNPCID, const string &in szKillerID)
    {
        return CallExternal("GAME_MASTER", "gm_crit_npc_died", szNPCID, szKillerID);
    }
    
    /**
     * Wrapper for common admin command patterns
     */
    bool admin_command(const string &in szCommand, const array<string> &in args, EntityHandle hPlayer = EntityHandle())
    {
        return CallExternalArray("GAME_MASTER", "admin_command", args, hPlayer);
    }
}