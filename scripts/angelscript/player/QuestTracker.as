/**
 * QuestTracker.as
 * 
 * Quest item tracking and management system for Master Sword Rebirth
 * Handles quest item collection, validation, and NPC interactions
 * 
 * Converted from game_master.script lines 1744-1813 (quest item system)
 */

namespace MS
{
    // Stub implementations for missing utility functions
    
    /**
     * Get the current map name for a player
     * Uses registered C++ function
     */
    string GetPlayerCurrentMap(const string &in szPlayerID)
    {
        // Use the registered global function if available
        return ::GetMapName();
    }
    
    /**
     * Send a message to a specific player
     * Displays informational messages about quest items
     */
    void SendQuestPlayerMessage(const string &in szPlayerID, const string &in szTitle, const string &in szMessage)
    {
        // Call the real C++ SendPlayerMessage function
        ::SendQuestPlayerMessage(szPlayerID, szTitle, szMessage);
        
        // Also log for debugging/tracking
        LogMessage("[QUEST MSG] Sent to " + szPlayerID + " - " + szTitle + ": " + szMessage);
    }
    
    /**
     * Call NPC to receive quest item
     * Executes the ext_receive_quest_item event on the NPC
     */
    void CallNPCReceiveQuestItem(const string &in szNPCID, const string &in szItemCode, const string &in szPlayerID)
    {
        LogMessage("CallNPCReceiveQuestItem - NPC: " + szNPCID + ", Item: " + szItemCode + ", Player: " + szPlayerID);
        
        // TODO: This should call the NPC's ext_receive_quest_item event
        // Example: callexternal(szNPCID, "ext_receive_quest_item", szItemCode, szPlayerID);
        
        // For now, we'll simulate the call by finding the NPC entity
        CBaseEntity@ pNPC = FindEntityByName(szNPCID);
        if (pNPC !is null)
        {
            LogMessage("Found NPC entity " + szNPCID + " - calling ext_receive_quest_item");
            // TODO: Execute the event on the NPC entity
        }
        else
        {
            LogMessage("[WARNING] Could not find NPC entity: " + szNPCID);
        }
    }
    
    /**
     * Get the current player ID from context
     * Uses Steam ID for persistent tracking across map changes
     */
    string GetCurrentPlayerID()
    {
        // Get the current player ID from the C++ context system
        int playerID = ::GetCurrentPlayerID();
        if (playerID == -1)
        {
            LogMessage("[WARNING] No player context set, returning default ID");
            return "STEAM_0:1:12345"; // Fallback for testing
        }
        
        // Convert entity index to Steam ID by looking up the player
        // This is a simplified approach - in practice we'd cache Steam IDs
        return "PLAYER_" + playerID; // Use entity index as identifier
    }
    
    /**
     * Get Steam ID from player entity or name
     * This is critical for persistent quest item storage
     */
    string GetPlayerSteamID(const string &in szPlayerID)
    {
        // If already a Steam ID, return as-is
        if (szPlayerID.substr(0, 6) == "STEAM_" || szPlayerID.substr(0, 7) == "PLAYER_")
            return szPlayerID; 
            
        // For now, treat as player name and convert to standard format
        // In a full implementation, this would lookup actual Steam IDs
        return "PLAYER_NAME_" + szPlayerID;
    }
    
    // Note: Using logging functions provided by the engine
    // LogInfo, LogWarning, LogError, LogDebug are defined globally by the C++ engine
    /**
     * Quest item data structure
     */
    class QuestItem
    {
        string szItemCode;            // Unique item identifier
        string szDisplayName;         // Human-readable name
        string szDescription;         // Item description
        bool bConsumable;             // Whether item is consumed when used
        uint nStackSize;              // How many can be stacked
        float flSpawnChance;          // Chance to spawn (0.0-1.0)
        string szSpawnLocation;       // Where this item can spawn
        
        QuestItem()
        {
            szItemCode = "";
            szDisplayName = "";
            szDescription = "";
            bConsumable = true;
            nStackSize = 1;
            flSpawnChance = 1.0f;
            szSpawnLocation = "";
        }
        
        QuestItem(const string &in code, const string &in name)
        {
            szItemCode = code;
            szDisplayName = name;
            szDescription = "";
            bConsumable = true;
            nStackSize = 1;
            flSpawnChance = 1.0f;
            szSpawnLocation = "";
        }
    }
    
    /**
     * Player quest item entry
     */
    class PlayerQuestItem
    {
        string szItemCode;            // Item code
        uint nQuantity;               // How many the player has
        float flFoundTime;            // When the item was found
        string szFoundLocation;       // Where it was found
        
        PlayerQuestItem()
        {
            szItemCode = "";
            nQuantity = 0;
            flFoundTime = 0.0f;
            szFoundLocation = "";
        }
        
        PlayerQuestItem(const string &in code, uint quantity = 1)
        {
            szItemCode = code;
            nQuantity = quantity;
            flFoundTime = GetGameTime();
            szFoundLocation = "";
        }
    }
    
    /**
     * Quest item request from an NPC
     */
    class QuestItemRequest
    {
        string szItemCode;            // Required item code
        string szCallerID;            // NPC making the request
        uint nQuantityRequired;       // How many items needed
        bool bConsumeItems;           // Whether to consume items when delivered
        string szRewardScript;        // Script to call when items delivered
        
        QuestItemRequest()
        {
            szItemCode = "";
            szCallerID = "";
            nQuantityRequired = 1;
            bConsumeItems = true;
            szRewardScript = "";
        }
    }
    
    /**
     * Quest Tracker system class
     * Based on game_master.script lines 1744-1813
     */
    class QuestTracker
    {
        // Quest item registry
        array<QuestItem> m_QuestItems;
        
        // Player quest item inventories (keyed by player ID)
        dictionary m_PlayerInventories; // string -> array<PlayerQuestItem>
        
        // Pending requests from NPCs
        array<QuestItemRequest> m_PendingRequests;
        
        // System state
        bool m_bInitialized;
        uint m_nTotalItemsFound;
        uint m_nTotalDeliveries;
        /**
         * Constructor - Initialize the quest tracker
         */
        QuestTracker()
        {
            m_bInitialized = false;
            m_nTotalItemsFound = 0;
            m_nTotalDeliveries = 0;
            
            InitializeQuestTracker();
        }
        
        /**
         * Initialize the quest tracking system
         */
        void InitializeQuestTracker()
        {
            LogMessage("QuestTracker: Initializing quest item tracking system");
            
            // Register default quest items
            RegisterDefaultQuestItems();
            
            m_bInitialized = true;
            LogMessage("QuestTracker: Initialized with " + m_QuestItems.length() + " quest items");
        }
        
        /**
         * Register default quest items
         */
        void RegisterDefaultQuestItems()
        {
            // Register common quest items (these would be loaded from config)
            RegisterQuestItem("stick_dynamite", "Stick of Dynamite", "A stick of dynamite with a broken fuse");
            RegisterQuestItem("ancient_rune", "Ancient Rune", "A mysterious rune carved in stone");
            RegisterQuestItem("crystal_shard", "Crystal Shard", "A fragment of magical crystal");
            RegisterQuestItem("herb_bundle", "Herb Bundle", "A collection of medicinal herbs");
            RegisterQuestItem("scroll_fragment", "Scroll Fragment", "Part of an ancient scroll");
            
            LogMessage("[DEBUG] QuestTracker: Registered " + m_QuestItems.length() + " default quest items");
        }
        
        /**
         * Register a quest item type
         * @param szCode Unique item code
         * @param szName Display name
         * @param szDesc Description (optional)
         */
        void RegisterQuestItem(const string &in szCode, const string &in szName, const string &in szDesc = "")
        {
            // Check if item already exists
            for (uint i = 0; i < m_QuestItems.length(); i++)
            {
                if (m_QuestItems[i].szItemCode == szCode)
                {
                    LogMessage("[WARNING] QuestTracker: Quest item '" + szCode + "' already registered");
                    return;
                }
            }
            
            QuestItem newItem(szCode, szName);
            newItem.szDescription = szDesc;
            m_QuestItems.insertLast(newItem);
            
            LogMessage("[DEBUG] QuestTracker: Registered quest item '" + szCode + "' - " + szName);
        }
        
        /**
         * Player finds a quest item
         * Based on ext_got_quest_item from lines 1746-1761
         * @param szPlayerID Player identifier (converted to Steam ID internally)
         * @param szItemCode Item code found
         * @param nQuantity How many items found
         */
        void PlayerFoundQuestItem(const string &in szPlayerID, const string &in szItemCode, uint nQuantity = 1)
        {
            if (!m_bInitialized)
            {
                LogMessage("[ERROR] QuestTracker: System not initialized");
                return;
            }
            
            // Validate item code
            bool bValidItem = false;
            string szItemName = szItemCode;
            for (uint i = 0; i < m_QuestItems.length(); i++)
            {
                if (m_QuestItems[i].szItemCode == szItemCode)
                {
                    bValidItem = true;
                    szItemName = m_QuestItems[i].szDisplayName;
                    break;
                }
            }
            
            if (!bValidItem)
            {
                LogMessage("[WARNING] QuestTracker: Unknown quest item '" + szItemCode + "' found by " + szPlayerID);
                // Register it automatically for flexibility
                RegisterQuestItem(szItemCode, szItemCode, "Automatically registered quest item");
                szItemName = szItemCode;
            }
            
            // Convert player ID to Steam ID for persistent storage
            string steamID = GetPlayerSteamID(szPlayerID);
            
            // Get or create player inventory
            array<PlayerQuestItem> playerItems;
            if (m_PlayerInventories.exists(steamID))
            {
                m_PlayerInventories.get(steamID, playerItems);
            }
            
            // Check if player already has this item
            bool bFound = false;
            for (uint i = 0; i < playerItems.length(); i++)
            {
                if (playerItems[i].szItemCode == szItemCode)
                {
                    playerItems[i].nQuantity += nQuantity;
                    bFound = true;
                    break;
                }
            }
            
            // Add new entry if not found
            if (!bFound)
            {
                PlayerQuestItem newEntry(szItemCode, nQuantity);
                newEntry.szFoundLocation = GetPlayerCurrentMap(szPlayerID);
                playerItems.insertLast(newEntry);
            }
            
            // Store updated inventory using Steam ID
            m_PlayerInventories.set(steamID, playerItems);
            m_nTotalItemsFound += nQuantity;
            
            LogMessage("[INFO] QuestTracker: Player " + szPlayerID + " (" + steamID + ") found " + nQuantity + "x " + szItemName);
            
            // Save quest item data to persistent storage
            SavePlayerQuestItems(steamID);
            
            // Special handling for specific items (from lines 1755-1760)
            if (szItemCode == "stick_dynamite")
            {
                string mapName = GetPlayerCurrentMap(szPlayerID);
                // Convert to lowercase manually
                string lowerMapName = "";
                for (uint k = 0; k < mapName.length(); k++)
                {
                    uint8 c = mapName[k];
                    if (c >= uint8(65) && c <= uint8(90))  // 'A' to 'Z'
                        c = c + uint8(32);  // Convert to lowercase
                    lowerMapName += c;
                }
                mapName = lowerMapName;
                if (mapName.substr(0, 5) == "rmine") // Starts with 'rmine'
                {
                    SendQuestPlayerMessage(szPlayerID, "Stick of Dynamite", 
                                    "Hrmmm... the fuse is broken... but maybe we can use this, somewhere...");
                }
            }
            
            // Notify any waiting NPCs
            ProcessPendingRequests(szItemCode);
        }
        
        /**
         * NPC requests quest items from players
         * Based on ext_check_quest_item from lines 1772-1788
         * @param szItemCode Required item code
         * @param szCallerID NPC making the request
         * @param nRequired Number of items required
         * @param bConsume Whether to consume the items
         * @return Number of items that could be provided
         */
        uint NPCRequestQuestItem(const string &in szItemCode, const string &in szCallerID, 
                                uint nRequired = 1, bool bConsume = true)
        {
            LogMessage("[INFO] QuestTracker: NPC " + szCallerID + " requesting " + nRequired + "x " + szItemCode);
            
            uint nTotalAvailable = 0;
            array<string> playersWithItems;
            
            // Check all players for this item
            array<string> playerIDs = m_PlayerInventories.getKeys();
            for (uint i = 0; i < playerIDs.length(); i++)
            {
                array<PlayerQuestItem> playerItems;
                m_PlayerInventories.get(playerIDs[i], playerItems);
                
                for (uint j = 0; j < playerItems.length(); j++)
                {
                    if (playerItems[j].szItemCode == szItemCode)
                    {
                        nTotalAvailable += playerItems[j].nQuantity;
                        playersWithItems.insertLast(playerIDs[i]);
                        break;
                    }
                }
            }
            
            if (nTotalAvailable == 0)
            {
                LogMessage("[INFO] QuestTracker: No players have " + szItemCode + " for NPC " + szCallerID);
                return 0;
            }
            
            uint nDelivered = 0;
            uint nStillNeeded = nRequired;
            
            // Deliver items from players (consume if requested)
            for (uint i = 0; i < playersWithItems.length() && nStillNeeded > 0; i++)
            {
                string playerID = playersWithItems[i];
                array<PlayerQuestItem> playerItems;
                m_PlayerInventories.get(playerID, playerItems);
                
                for (uint j = 0; j < playerItems.length(); j++)
                {
                    if (playerItems[j].szItemCode == szItemCode && nStillNeeded > 0)
                    {
                        uint nTaken = (playerItems[j].nQuantity < nStillNeeded) ? 
                                     playerItems[j].nQuantity : nStillNeeded;
                        
                        if (bConsume)
                        {
                            playerItems[j].nQuantity -= nTaken;
                            if (playerItems[j].nQuantity == 0)
                            {
                                playerItems.removeAt(j);
                                j--; // Adjust index after removal
                            }
                        }
                        
                        nDelivered += nTaken;
                        nStillNeeded -= nTaken;
                        
                        LogMessage("[INFO] QuestTracker: Delivered " + nTaken + "x " + szItemCode + 
                               " from player " + playerID + " to NPC " + szCallerID);
                        
                        // Notify the NPC for each item delivered
                        for (uint k = 0; k < nTaken; k++)
                        {
                            CallNPCReceiveQuestItem(szCallerID, szItemCode, playerID);
                        }
                        
                        break;
                    }
                }
                
                // Update player inventory and save to persistent storage
                m_PlayerInventories.set(playerID, playerItems);
                SavePlayerQuestItems(playerID);
            }
            
            m_nTotalDeliveries += nDelivered;
            LogMessage("[INFO] QuestTracker: Delivered " + nDelivered + "/" + nRequired + " " + szItemCode + " to " + szCallerID);
            
            return nDelivered;
        }
        
        /**
         * Get the number of quest items a player has
         * @param szPlayerID Player identifier
         * @param szItemCode Item code to check
         * @return Number of items the player has
         */
        uint GetPlayerQuestItemCount(const string &in szPlayerID, const string &in szItemCode)
        {
            string steamID = GetPlayerSteamID(szPlayerID);
            if (!m_PlayerInventories.exists(steamID))
                return 0;
                
            array<PlayerQuestItem> playerItems;
            m_PlayerInventories.get(steamID, playerItems);
            
            for (uint i = 0; i < playerItems.length(); i++)
            {
                if (playerItems[i].szItemCode == szItemCode)
                {
                    return playerItems[i].nQuantity;
                }
            }
            
            return 0;
        }
        
        /**
         * Get all quest items for a player
         * @param szPlayerID Player identifier
         * @return Array of quest items the player has
         */
        array<PlayerQuestItem> GetPlayerQuestItems(const string &in szPlayerID)
        {
            array<PlayerQuestItem> result;
            string steamID = GetPlayerSteamID(szPlayerID);
            
            if (m_PlayerInventories.exists(steamID))
            {
                m_PlayerInventories.get(steamID, result);
            }
            
            return result;
        }
        
        /**
         * Remove quest items from a player
         * @param szPlayerID Player identifier
         * @param szItemCode Item code to remove
         * @param nQuantity How many to remove
         * @return Number actually removed
         */
        uint RemovePlayerQuestItem(const string &in szPlayerID, const string &in szItemCode, uint nQuantity)
        {
            string steamID = GetPlayerSteamID(szPlayerID);
            if (!m_PlayerInventories.exists(steamID))
                return 0;
                
            array<PlayerQuestItem> playerItems;
            m_PlayerInventories.get(steamID, playerItems);
            
            for (uint i = 0; i < playerItems.length(); i++)
            {
                if (playerItems[i].szItemCode == szItemCode)
                {
                    uint nRemoved = (playerItems[i].nQuantity < nQuantity) ? 
                                   playerItems[i].nQuantity : nQuantity;
                    
                    playerItems[i].nQuantity -= nRemoved;
                    if (playerItems[i].nQuantity == 0)
                    {
                        playerItems.removeAt(i);
                    }
                    
                    m_PlayerInventories.set(steamID, playerItems);
                    SavePlayerQuestItems(steamID);
                    LogMessage("[INFO] QuestTracker: Removed " + nRemoved + "x " + szItemCode + " from player " + szPlayerID);
                    
                    return nRemoved;
                }
            }
            
            return 0;
        }
        
        /**
         * Process pending requests when new items are found
         */
        void ProcessPendingRequests(const string &in szItemCode)
        {
            // Check if any NPCs are waiting for this item
            for (int i = int(m_PendingRequests.length()) - 1; i >= 0; i--)
            {
                if (m_PendingRequests[i].szItemCode == szItemCode)
                {
                    uint nDelivered = NPCRequestQuestItem(m_PendingRequests[i].szItemCode, 
                                                         m_PendingRequests[i].szCallerID,
                                                         m_PendingRequests[i].nQuantityRequired,
                                                         m_PendingRequests[i].bConsumeItems);
                    
                    if (nDelivered >= m_PendingRequests[i].nQuantityRequired)
                    {
                        // Request fulfilled, remove it
                        m_PendingRequests.removeAt(i);
                    }
                    else
                    {
                        // Partially fulfilled, update required quantity
                        m_PendingRequests[i].nQuantityRequired -= nDelivered;
                    }
                }
            }
        }
        
        /**
         * Dump all quest items for debugging
         * Based on ext_dump_quest_items from lines 1807-1813
         */
        void DumpAllQuestItems()
        {
            LogMessage("[INFO] QuestTracker: === Quest Item Dump ===");
            LogMessage("[INFO] Total items found: " + m_nTotalItemsFound + ", Total deliveries: " + m_nTotalDeliveries);
            
            array<string> playerIDs = m_PlayerInventories.getKeys();
            for (uint i = 0; i < playerIDs.length(); i++)
            {
                LogMessage("[INFO] Player " + playerIDs[i] + ":");
                
                array<PlayerQuestItem> playerItems;
                m_PlayerInventories.get(playerIDs[i], playerItems);
                
                if (playerItems.length() == 0)
                {
                    LogMessage("[INFO]   No quest items");
                }
                else
                {
                    for (uint j = 0; j < playerItems.length(); j++)
                    {
                        LogMessage("[INFO]   " + playerItems[j].nQuantity + "x " + playerItems[j].szItemCode);
                    }
                }
            }
            
            LogMessage("[INFO] QuestTracker: === End Quest Item Dump ===");
        }
        
        /**
         * Get quest tracker statistics
         */
        uint GetTotalItemsFound() { return m_nTotalItemsFound; }
        uint GetTotalDeliveries() { return m_nTotalDeliveries; }
        uint GetRegisteredItemCount() { return m_QuestItems.length(); }
        uint GetPlayerCount() { return m_PlayerInventories.getSize(); }
        
        /**
         * Clear all quest items for a player (for testing/admin)
         */
        void ClearPlayerQuestItems(const string &in szPlayerID)
        {
            string steamID = GetPlayerSteamID(szPlayerID);
            if (m_PlayerInventories.exists(steamID))
            {
                array<PlayerQuestItem> emptyItems;
                m_PlayerInventories.set(steamID, emptyItems);
                SavePlayerQuestItems(steamID);
                LogMessage("[INFO] QuestTracker: Cleared all quest items for player " + szPlayerID);
            }
        }
        
        /**
         * Save player quest items to persistent storage
         * This would write to a file for persistence across map changes
         */
        void SavePlayerQuestItems(const string &in szSteamID)
        {
            // TODO: Implement file I/O when available
            // This should save to a file like: quest_items_STEAMID.dat
            LogMessage("[DEBUG] QuestTracker: Would save quest items for Steam ID: " + szSteamID);
            
            /*
            string filename = "quest_items_" + szSteamID + ".dat";
            CFile@ pFile = OpenFile(filename, "w");
            if (pFile !is null)
            {
                array<PlayerQuestItem> playerItems;
                if (m_PlayerInventories.exists(szSteamID))
                {
                    m_PlayerInventories.Get(szSteamID, playerItems);
                    pFile.Write(playerItems.length());
                    for (uint i = 0; i < playerItems.length(); i++)
                    {
                        pFile.Write(playerItems[i].szItemCode);
                        pFile.Write(playerItems[i].nQuantity);
                        pFile.Write(playerItems[i].flFoundTime);
                        pFile.Write(playerItems[i].szFoundLocation);
                    }
                }
                pFile.Close();
            }
            */
        }
        
        /**
         * Load player quest items from persistent storage
         * This would read from a file for persistence across map changes
         */
        void LoadPlayerQuestItems(const string &in szSteamID)
        {
            // TODO: Implement file I/O when available
            LogMessage("[DEBUG] QuestTracker: Would load quest items for Steam ID: " + szSteamID);
            
            /*
            string filename = "quest_items_" + szSteamID + ".dat";
            CFile@ pFile = OpenFile(filename, "r");
            if (pFile !is null)
            {
                uint itemCount = pFile.ReadUInt();
                array<PlayerQuestItem> playerItems;
                
                for (uint i = 0; i < itemCount; i++)
                {
                    PlayerQuestItem item;
                    item.szItemCode = pFile.ReadString();
                    item.nQuantity = pFile.ReadUInt();
                    item.flFoundTime = pFile.ReadFloat();
                    item.szFoundLocation = pFile.ReadString();
                    playerItems.insertLast(item);
                }
                
                m_PlayerInventories.Set(szSteamID, playerItems);
                pFile.Close();
                
                LogInfo("QuestTracker: Loaded " + itemCount + " quest items for Steam ID: " + szSteamID);
            }
            */
        }
    }
    
    // Global quest tracker instance
    QuestTracker@ g_QuestTracker = null;
    
    /**
     * Initialize the quest tracker
     */
    void InitializeQuestTracker()
    {
        if (g_QuestTracker is null)
        {
            @g_QuestTracker = QuestTracker();
            LogMessage("QuestTracker: Initialized successfully");
        }
        else
        {
            LogMessage("[WARNING] QuestTracker: Already initialized");
        }
    }
    
    /**
     * Get the global quest tracker instance
     */
    QuestTracker@ GetQuestTracker()
    {
        if (g_QuestTracker is null)
        {
            InitializeQuestTracker();
        }
        return g_QuestTracker;
    }
    
    /**
     * Shutdown the quest tracker
     */
    void ShutdownQuestTracker()
    {
        if (g_QuestTracker !is null)
        {
            LogMessage("QuestTracker: Shutting down");
            @g_QuestTracker = null;
        }
    }
    
    // Utility functions for external script compatibility
    
    /**
     * External function for when a player finds a quest item
     * Compatible with legacy ext_got_quest_item calls
     * Called from quest item entities when picked up
     */
    void ext_got_quest_item(const string &in szItemCode)
    {
        // This would be called with proper player context from the C++ side
        string playerID = GetCurrentPlayerID(); 
        GetQuestTracker().PlayerFoundQuestItem(playerID, szItemCode);
    }
    
    /**
     * External function for when a player finds a quest item (with player ID)
     * Enhanced version for explicit player identification
     */
    void ext_got_quest_item_player(const string &in szPlayerID, const string &in szItemCode, uint nQuantity = 1)
    {
        GetQuestTracker().PlayerFoundQuestItem(szPlayerID, szItemCode, nQuantity);
    }
    
    /**
     * External function for NPC quest item requests
     * Compatible with legacy ext_check_quest_item calls
     * Returns number of items that could be provided
     */
    uint ext_check_quest_item(const string &in szItemCode, const string &in szCallerID)
    {
        return GetQuestTracker().NPCRequestQuestItem(szItemCode, szCallerID, 1, true);
    }
    
    /**
     * External function for NPC quest item requests with quantity
     * Enhanced version allowing multiple items to be requested
     */
    uint ext_check_quest_item_qty(const string &in szItemCode, const string &in szCallerID, uint nRequired)
    {
        return GetQuestTracker().NPCRequestQuestItem(szItemCode, szCallerID, nRequired, true);
    }
    
    /**
     * External function for NPC quest item requests without consumption
     * Check if items are available without removing them
     */
    uint ext_check_quest_item_peek(const string &in szItemCode, const string &in szCallerID, uint nRequired = 1)
    {
        return GetQuestTracker().NPCRequestQuestItem(szItemCode, szCallerID, nRequired, false);
    }
    
    /**
     * External function called by NPCs when they receive quest items
     * This is called automatically by the quest tracker when items are delivered
     * NPCs can override this to implement custom behavior
     */
    void ext_receive_quest_item(const string &in szItemCode, const string &in szPlayerID)
    {
        LogMessage("[INFO] ext_receive_quest_item: " + szItemCode + " from player " + szPlayerID);
        // This is typically overridden by individual NPC scripts
        // Default behavior is just to log the event
    }
    
    /**
     * External function to dump quest items
     * Compatible with legacy ext_dump_quest_items calls
     */
    void ext_dump_quest_items()
    {
        GetQuestTracker().DumpAllQuestItems();
    }
    
    /**
     * External function to get quest item count for a player
     * Useful for scripting conditions
     */
    uint ext_get_quest_item_count(const string &in szPlayerID, const string &in szItemCode)
    {
        return GetQuestTracker().GetPlayerQuestItemCount(szPlayerID, szItemCode);
    }
    
    /**
     * External function to remove quest items from a player
     * For admin/scripting purposes
     */
    uint ext_remove_quest_item(const string &in szPlayerID, const string &in szItemCode, uint nQuantity = 1)
    {
        return GetQuestTracker().RemovePlayerQuestItem(szPlayerID, szItemCode, nQuantity);
    }
    
    /**
     * External function to register a new quest item type
     * For dynamic quest item creation
     */
    void ext_register_quest_item(const string &in szCode, const string &in szName, const string &in szDesc = "")
    {
        GetQuestTracker().RegisterQuestItem(szCode, szName, szDesc);
    }
    
    /**
     * External function to clear all quest items for a player
     * For admin/reset purposes
     */
    void ext_clear_player_quest_items(const string &in szPlayerID)
    {
        GetQuestTracker().ClearPlayerQuestItems(szPlayerID);
    }
}