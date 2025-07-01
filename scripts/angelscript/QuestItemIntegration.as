/**
 * QuestItemIntegration.as
 * 
 * Integration layer between the AngelScript quest item system and
 * the existing legacy script system. Provides compatibility functions
 * and demonstrates proper usage patterns.
 * 
 * This module bridges the gap between the old .script files and the new
 * AngelScript quest tracking system.
 */

namespace MS
{
    /**
     * Quest Item Integration Manager
     * Handles interfacing between AngelScript and legacy script systems
     */
    class QuestItemIntegration
    {
    private:
        // Track NPCs waiting for quest items
        dictionary m_WaitingNPCs; // string (item_code) -> array<string> (npc_ids)
        
        // Track active quest item spawns
        array<string> m_ActiveQuestItems;
        
        bool m_bInitialized;
        
    public:
        QuestItemIntegration()
        {
            m_bInitialized = false;
        }
        
        /**
         * Initialize the integration system
         */
        void Initialize()
        {
            if (m_bInitialized)
                return;
                
            LogInfo("QuestItemIntegration: Initializing quest item integration layer");
            
            // Ensure quest tracker is initialized
            InitializeQuestTracker();
            
            // Register common quest items from the original script
            RegisterCommonQuestItems();
            
            m_bInitialized = true;
            LogInfo("QuestItemIntegration: Initialization complete");
        }
        
        /**
         * Register quest items commonly used by the legacy script system
         */
        void RegisterCommonQuestItems()
        {
            QuestTracker@ tracker = GetQuestTracker();
            
            // Items from the original game_master.script
            tracker.RegisterQuestItem("stick_dynamite", "Stick of Dynamite", 
                "A stick of dynamite with a broken fuse - useful somewhere in the mines");
            
            // Common quest items from various scripts
            tracker.RegisterQuestItem("tnt", "TNT", "Explosive material for clearing obstacles");
            tracker.RegisterQuestItem("ancient_rune", "Ancient Rune", "A mysterious rune carved in stone");
            tracker.RegisterQuestItem("crystal_shard", "Crystal Shard", "A fragment of magical crystal");
            tracker.RegisterQuestItem("herb_bundle", "Herb Bundle", "A collection of medicinal herbs");
            tracker.RegisterQuestItem("scroll_fragment", "Scroll Fragment", "Part of an ancient scroll");
            tracker.RegisterQuestItem("iron_ore", "Iron Ore", "Raw iron for smithing");
            tracker.RegisterQuestItem("gold_nugget", "Gold Nugget", "A small nugget of pure gold");
            tracker.RegisterQuestItem("magic_essence", "Magic Essence", "Concentrated magical energy");
            tracker.RegisterQuestItem("dragon_scale", "Dragon Scale", "A scale from an ancient dragon");
            tracker.RegisterQuestItem("demon_blood", "Demon Blood", "Dark ichor from defeated demons");
            
            LogInfo("QuestItemIntegration: Registered " + tracker.GetRegisteredItemCount() + " common quest items");
        }
        
        /**
         * Handle quest item pickup from legacy script system
         * Called when a player interacts with a quest item entity
         */
        void HandleQuestItemPickup(const string &in szPlayerID, const string &in szItemCode, 
                                  const string &in szItemEntityID = "")
        {
            LogInfo("QuestItemIntegration: Player " + szPlayerID + " picked up " + szItemCode);
            
            // Add the quest item to the player's inventory
            ext_got_quest_item_player(szPlayerID, szItemCode, 1);
            
            // Remove the entity from the world if specified
            if (szItemEntityID != "")
            {
                CBaseEntity@ pEntity = FindEntityByName(szItemEntityID);
                if (pEntity !is null)
                {
                    // TODO: Remove entity or make it inactive
                    LogInfo("QuestItemIntegration: Removing quest item entity " + szItemEntityID);
                }
            }
            
            // Check if any NPCs are waiting for this item
            ProcessWaitingNPCs(szItemCode);
        }
        
        /**
         * Register an NPC as waiting for a specific quest item
         * This allows NPCs to be notified when players find the items they need
         */
        void RegisterNPCWaitingForItem(const string &in szNPCID, const string &in szItemCode)
        {
            array<string> waitingNPCs;
            
            if (m_WaitingNPCs.Exists(szItemCode))
            {
                m_WaitingNPCs.Get(szItemCode, waitingNPCs);
            }
            
            // Check if NPC is already waiting
            bool bAlreadyWaiting = false;
            for (uint i = 0; i < waitingNPCs.length(); i++)
            {
                if (waitingNPCs[i] == szNPCID)
                {
                    bAlreadyWaiting = true;
                    break;
                }
            }
            
            if (!bAlreadyWaiting)
            {
                waitingNPCs.insertLast(szNPCID);
                m_WaitingNPCs.Set(szItemCode, waitingNPCs);
                LogInfo("QuestItemIntegration: NPC " + szNPCID + " is now waiting for " + szItemCode);
            }
        }
        
        /**
         * Remove NPC from waiting list for a quest item
         */
        void UnregisterNPCWaitingForItem(const string &in szNPCID, const string &in szItemCode)
        {
            if (!m_WaitingNPCs.Exists(szItemCode))
                return;
                
            array<string> waitingNPCs;
            m_WaitingNPCs.Get(szItemCode, waitingNPCs);
            
            for (uint i = 0; i < waitingNPCs.length(); i++)
            {
                if (waitingNPCs[i] == szNPCID)
                {
                    waitingNPCs.removeAt(i);
                    m_WaitingNPCs.Set(szItemCode, waitingNPCs);
                    LogInfo("QuestItemIntegration: NPC " + szNPCID + " no longer waiting for " + szItemCode);
                    break;
                }
            }
        }
        
        /**
         * Process NPCs waiting for a specific item when it becomes available
         */
        void ProcessWaitingNPCs(const string &in szItemCode)
        {
            if (!m_WaitingNPCs.Exists(szItemCode))
                return;
                
            array<string> waitingNPCs;
            m_WaitingNPCs.Get(szItemCode, waitingNPCs);
            
            for (uint i = 0; i < waitingNPCs.length(); i++)
            {
                string npcID = waitingNPCs[i];
                LogInfo("QuestItemIntegration: Notifying NPC " + npcID + " that " + szItemCode + " is available");
                
                // Try to deliver the item to the NPC
                uint nDelivered = ext_check_quest_item(szItemCode, npcID);
                if (nDelivered > 0)
                {
                    LogInfo("QuestItemIntegration: Delivered " + nDelivered + " " + szItemCode + " to NPC " + npcID);
                }
            }
        }
        
        /**
         * Create a quest item entity in the world
         * For dynamic quest item spawning
         */
        void SpawnQuestItem(const string &in szItemCode, const Vector3 &in vecPosition, 
                           const string &in szMapName = "")
        {
            LogInfo("QuestItemIntegration: Spawning quest item " + szItemCode + " at " + 
                   vecPosition.x + "," + vecPosition.y + "," + vecPosition.z);
            
            // TODO: Create the actual quest item entity
            // This would use CreateNPC or similar to spawn the quest item
            // Example: CreateNPC("other/qitem", vecPosition, Vector3(), EntityHandle(), EntityHandle(), 0.0f, 0.0f);
            
            m_ActiveQuestItems.insertLast(szItemCode);
        }
        
        /**
         * Handle NPC menu interaction for quest item delivery
         * This is called from NPC menu scripts when players interact
         */
        bool HandleNPCQuestItemMenu(const string &in szPlayerID, const string &in szNPCID, 
                                   const string &in szItemCode, uint nRequired = 1)
        {
            uint nAvailable = ext_get_quest_item_count(szPlayerID, szItemCode);
            
            if (nAvailable >= nRequired)
            {
                // Player has the required items
                uint nDelivered = ext_check_quest_item_qty(szItemCode, szNPCID, nRequired);
                if (nDelivered >= nRequired)
                {
                    LogInfo("QuestItemIntegration: Player " + szPlayerID + " delivered " + 
                           nDelivered + " " + szItemCode + " to NPC " + szNPCID);
                    return true;
                }
            }
            else
            {
                // Player doesn't have enough items
                LogInfo("QuestItemIntegration: Player " + szPlayerID + " needs " + 
                       (nRequired - nAvailable) + " more " + szItemCode);
                       
                // Register NPC as waiting for this item
                RegisterNPCWaitingForItem(szNPCID, szItemCode);
            }
            
            return false;
        }
        
        /**
         * Get quest item statistics for debugging
         */
        void GetStatistics(uint &out nTotalItemsFound, uint &out nTotalDeliveries, 
                          uint &out nRegisteredItems, uint &out nWaitingNPCs)
        {
            QuestTracker@ tracker = GetQuestTracker();
            nTotalItemsFound = tracker.GetTotalItemsFound();
            nTotalDeliveries = tracker.GetTotalDeliveries();
            nRegisteredItems = tracker.GetRegisteredItemCount();
            nWaitingNPCs = m_WaitingNPCs.GetSize();
        }
        
        /**
         * Dump integration status for debugging
         */
        void DumpStatus()
        {
            LogInfo("QuestItemIntegration: === Integration Status ===");
            
            uint nTotalItemsFound, nTotalDeliveries, nRegisteredItems, nWaitingNPCs;
            GetStatistics(nTotalItemsFound, nTotalDeliveries, nRegisteredItems, nWaitingNPCs);
            
            LogInfo("Total items found: " + nTotalItemsFound);
            LogInfo("Total deliveries: " + nTotalDeliveries);  
            LogInfo("Registered items: " + nRegisteredItems);
            LogInfo("NPCs waiting for items: " + nWaitingNPCs);
            LogInfo("Active quest items in world: " + m_ActiveQuestItems.length());
            
            LogInfo("QuestItemIntegration: === End Status ===");
        }
    }
    
    // Global integration instance
    QuestItemIntegration@ g_QuestItemIntegration = null;
    
    /**
     * Initialize the quest item integration system
     */
    void InitializeQuestItemIntegration()
    {
        if (g_QuestItemIntegration is null)
        {
            @g_QuestItemIntegration = QuestItemIntegration();
            g_QuestItemIntegration.Initialize();
            LogMessage("QuestItemIntegration: System initialized successfully");
        }
        else
        {
            LogWarning("QuestItemIntegration: Already initialized");
        }
    }
    
    /**
     * Get the global integration instance
     */
    QuestItemIntegration@ GetQuestItemIntegration()
    {
        if (g_QuestItemIntegration is null)
        {
            InitializeQuestItemIntegration();
        }
        return g_QuestItemIntegration;
    }
    
    // ========================================
    // Legacy Script Compatibility Functions
    // ========================================
    
    /**
     * Legacy function for quest item pickup
     * Called from quest item entities in the legacy script system
     */
    void legacy_quest_item_pickup(const string &in szPlayerID, const string &in szItemCode)
    {
        GetQuestItemIntegration().HandleQuestItemPickup(szPlayerID, szItemCode);
    }
    
    /**
     * Legacy function for NPC quest item check
     * Called from NPC menu scripts
     */
    bool legacy_npc_quest_check(const string &in szPlayerID, const string &in szNPCID, 
                               const string &in szItemCode, uint nRequired = 1)
    {
        return GetQuestItemIntegration().HandleNPCQuestItemMenu(szPlayerID, szNPCID, szItemCode, nRequired);
    }
    
    /**
     * Legacy function to spawn quest items
     * Called from map initialization or dynamic quest systems
     */
    void legacy_spawn_quest_item(const string &in szItemCode, float flX, float flY, float flZ)
    {
        Vector3 vecPos(flX, flY, flZ);
        GetQuestItemIntegration().SpawnQuestItem(szItemCode, vecPos);
    }
    
    /**
     * Legacy function to register NPC waiting for items
     * Called from NPC scripts that need specific quest items
     */
    void legacy_npc_wait_for_item(const string &in szNPCID, const string &in szItemCode)
    {
        GetQuestItemIntegration().RegisterNPCWaitingForItem(szNPCID, szItemCode);
    }
}