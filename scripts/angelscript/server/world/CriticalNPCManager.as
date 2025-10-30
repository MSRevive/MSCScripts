#pragma context server

/**
 * CriticalNPCManager.as
 * 
 * Critical NPC tracking and management system for Master Sword Rebirth
 * Prevents quest-breaking scenarios by monitoring essential NPCs
 * 
 * Based on original game_master.script lines 425-459:
 * - gm_crit_npc_died - Track critical NPC deaths
 * - remove_crit_npc - Remove from global critical list  
 * - crit_count_remaining - Report remaining critical NPCs
 */

namespace MS
{
    /**
     * Critical NPC death record for tracking and recovery
     */
    class CriticalNPCDeath
    {
        string szNPCName;           // Name of the dead NPC
        string szNPCScript;         // Script identifier
        string szKillerID;          // Who/what killed the NPC
        string szKillerName;        // Killer's display name
        bool bFriendlyFire;         // Whether killed by a player
        Vector3 vecDeathLocation;   // Where the NPC died
        string szMapName;           // Which map it happened on
        float flDeathTime;          // When the death occurred
        bool bQuestCritical;        // Whether this was quest-breaking
        
        CriticalNPCDeath()
        {
            szNPCName = "";
            szNPCScript = "";
            szKillerID = "";
            szKillerName = "";
            bFriendlyFire = false;
            vecDeathLocation = Vector3();
            szMapName = "";
            flDeathTime = 0.0f;
            bQuestCritical = false;
        }
        
        CriticalNPCDeath(const string &in npcName, const string &in npcScript, 
                        const string &in killerID, const string &in killerName)
        {
            szNPCName = npcName;
            szNPCScript = npcScript;
            szKillerID = killerID;
            szKillerName = killerName;
            bFriendlyFire = IsPlayerID(killerID);
            vecDeathLocation = Vector3(); // Will be set by caller
            szMapName = GetMapName();
            flDeathTime = GetGameTime();
            bQuestCritical = true; // Assume quest-critical until proven otherwise
        }
        
        bool IsPlayerID(const string &in id)
        {
            // Check if this looks like a player ID (Steam ID format)
            return id.substr(0, 6) == "STEAM_" || id.substr(0, 6) == "Player";
        }
    }
    
    /**
     * Critical NPC registration data
     */
    class CriticalNPCEntry
    {
        string szNPCName;           // Unique NPC identifier
        string szNPCScript;         // Script name for respawning
        string szDisplayName;       // Human-readable name
        string szMapName;           // Which map this NPC is on
        Vector3 vecSpawnLocation;   // Where to respawn if needed
        Vector3 vecSpawnAngles;     // Spawn orientation
        string szQuestChain;        // Which quest chain depends on this NPC
        int nPriority;              // Importance level (1=critical, 2=important, 3=optional)
        bool bCanRespawn;           // Whether this NPC can be respawned by admins
        bool bCurrentlyAlive;       // Whether currently tracked as alive
        
        CriticalNPCEntry()
        {
            szNPCName = "";
            szNPCScript = "";
            szDisplayName = "";
            szMapName = "";
            vecSpawnLocation = Vector3();
            vecSpawnAngles = Vector3();
            szQuestChain = "";
            nPriority = 1;
            bCanRespawn = true;
            bCurrentlyAlive = true;
        }
        
        CriticalNPCEntry(const string &in name, const string &in script, const string &in displayName)
        {
            szNPCName = name;
            szNPCScript = script;
            szDisplayName = displayName;
            szMapName = GetMapName();
            vecSpawnLocation = Vector3();
            vecSpawnAngles = Vector3();
            szQuestChain = "";
            nPriority = 1;
            bCanRespawn = true;
            bCurrentlyAlive = true;
        }
    }
    
    /**
     * Critical NPC Manager - tracks essential NPCs for quest chains
     */
    class CriticalNPCManager
    {
        // NPC registrations and tracking
        array<CriticalNPCEntry> m_RegisteredNPCs;
        array<string> m_GlobalCriticalList;        // Active critical NPCs (token string format)
        
        // Death tracking and history
        array<CriticalNPCDeath> m_DeathHistory;
        uint m_nMaxDeathHistory = 100;
        
        // System state
        bool m_bInitialized;
        uint m_nTotalCriticalDeaths;
        uint m_nFriendlyFireDeaths;
        
        // Current death processing state (from original script)
        string m_szProcessingDeadNPC;
        string m_szProcessingKiller;
        
        // Statistics
        uint m_nQuestChainsProtected;
        uint m_nAdminInterventions;
        /**
         * Constructor - Initialize the critical NPC manager
         */
        CriticalNPCManager()
        {
            m_bInitialized = false;
            m_nTotalCriticalDeaths = 0;
            m_nFriendlyFireDeaths = 0;
            m_nQuestChainsProtected = 0;
            m_nAdminInterventions = 0;
            m_szProcessingDeadNPC = "";
            m_szProcessingKiller = "";
            
            InitializeCriticalNPCManager();
        }
        
        /**
         * Initialize the critical NPC management system
         */
        void InitializeCriticalNPCManager()
        {
            LogMessage("[INFO] CriticalNPCManager: Initializing critical NPC tracking system");
            
            // Load default critical NPCs for common quest chains
            RegisterDefaultCriticalNPCs();
            
            // Initialize global critical list from existing game state if available
            InitializeGlobalCriticalList();
            
            m_bInitialized = true;
            LogMessage("[INFO] CriticalNPCManager: Initialized with " + m_RegisteredNPCs.length() + " registered critical NPCs");
        }
        
        /**
         * Register default critical NPCs for common quest chains
         */
        void RegisterDefaultCriticalNPCs()
        {
            // Register common quest-critical NPCs
            // These should be loaded from configuration in a real implementation
            
            RegisterCriticalNPC("helena_elder", "helena/helena_elder", "Helena Elder", "helena", 1, "helena_main_quest");
            RegisterCriticalNPC("deralia_mayor", "deralia/mayor", "Mayor of Deralia", "deralia", 1, "deralia_main_quest");
            RegisterCriticalNPC("edana_blacksmith", "edana/blacksmith", "Edana Blacksmith", "edana", 2, "weapon_upgrades");
            RegisterCriticalNPC("keledros", "the_wall/keledros", "Keledros the Keeper", "the_wall", 1, "wall_access_quest");
            RegisterCriticalNPC("thothie", "developer/thothie", "Thothie", "developer", 1, "developer_quests");
            
            LogMessage("[INFO] CriticalNPCManager: Registered " + m_RegisteredNPCs.length() + " default critical NPCs");
        }
        
        /**
         * Initialize global critical list from existing game state
         */
        void InitializeGlobalCriticalList()
        {
            // Check if global critical list exists and populate it
            string existingList = GetGlobalVariable("G_CRITICAL_NPCS");
            if (existingList.length() > 0)
            {
                // Parse existing critical NPC list
                LoadCriticalListFromString(existingList);
                LogMessage("[INFO] CriticalNPCManager: Loaded existing critical list with " + m_GlobalCriticalList.length() + " NPCs");
            }
            else
            {
                // Initialize new critical list from registered NPCs
                BuildInitialCriticalList();
                LogMessage("[INFO] CriticalNPCManager: Built initial critical list with " + m_GlobalCriticalList.length() + " NPCs");
            }
        }
        
        /**
         * Register a critical NPC for tracking
         * @param szName Unique NPC identifier
         * @param szScript Script name for respawning
         * @param szDisplayName Human-readable name
         * @param szMap Map where NPC is located
         * @param nPriority Importance level (1=critical, 2=important, 3=optional)
         * @param szQuestChain Quest chain that depends on this NPC
         */
        void RegisterCriticalNPC(const string &in szName, const string &in szScript, 
                               const string &in szDisplayName, const string &in szMap,
                               int nPriority = 1, const string &in szQuestChain = "")
        {
            // Check if already registered
            for (uint i = 0; i < m_RegisteredNPCs.length(); i++)
            {
                if (m_RegisteredNPCs[i].szNPCName == szName)
                {
                    LogMessage("[WARNING] CriticalNPCManager: NPC '" + szName + "' already registered");
                    return;
                }
            }
            
            CriticalNPCEntry newEntry(szName, szScript, szDisplayName);
            newEntry.szMapName = szMap;
            newEntry.nPriority = nPriority;
            newEntry.szQuestChain = szQuestChain;
            
            m_RegisteredNPCs.insertLast(newEntry);
            
            // Add to global critical list if priority 1 or 2
            if (nPriority <= 2)
            {
                AddToGlobalCriticalList(szName);
            }
            
            LogMessage("[INFO] CriticalNPCManager: Registered critical NPC '" + szName + "' - " + szDisplayName + 
                   " (Priority " + nPriority + ")");
        }
        
        /**
         * Critical NPC died - process death and update tracking
         * Based on original gm_crit_npc_died event (lines 425-433)
         * @param szNPCName Name of the dead NPC
         * @param szKillerID Who/what killed the NPC
         */
        void CriticalNPCDied(const string &in szNPCName, const string &in szKillerID)
        {
            LogMessage("[WARNING] CriticalNPCManager: Critical NPC death reported - " + szNPCName + " killed by " + szKillerID);
            
            // Store processing state (from original script pattern)
            m_szProcessingDeadNPC = szNPCName;
            m_szProcessingKiller = szKillerID;
            
            // Remove from global critical list
            RemoveFromCriticalList(szNPCName);
            
            // Record the death
            RecordNPCDeath(szNPCName, szKillerID);
            
            // Report remaining critical NPCs (with small delay like original)
            ReportRemainingCriticalNPCs();
            
            // Check for quest chain impact
            CheckQuestChainImpact(szNPCName);
            
            m_nTotalCriticalDeaths++;
        }
        
        /**
         * Remove NPC from critical list
         * Based on original remove_crit_npc event (lines 435-438)
         * @param szNPCName Name of NPC to remove
         */
        void RemoveFromCriticalList(const string &in szNPCName)
        {
            // Remove from global critical list (token-based like original)
            for (int i = int(m_GlobalCriticalList.length()) - 1; i >= 0; i--)
            {
                if (m_GlobalCriticalList[i] == szNPCName)
                {
                    m_GlobalCriticalList.removeAt(i);
                    LogMessage("[INFO] CriticalNPCManager: Removed '" + szNPCName + "' from critical list");
                    break;
                }
            }
            
            // Update registration status
            for (uint i = 0; i < m_RegisteredNPCs.length(); i++)
            {
                if (m_RegisteredNPCs[i].szNPCName == szNPCName)
                {
                    m_RegisteredNPCs[i].bCurrentlyAlive = false;
                    break;
                }
            }
            
            // Update global variable
            UpdateGlobalCriticalList();
        }
        
        /**
         * Report remaining critical NPCs with status message
         * Based on original crit_count_remaining event (lines 440-459)
         */
        void ReportRemainingCriticalNPCs()
        {
            uint nRemaining = m_GlobalCriticalList.length();
            string szMessage = "";
            string szReason = "";
            
            // Generate status message (from original script logic)
            if (nRemaining > 1)
            {
                szMessage = "" + nRemaining + " Critical NPCs Remain!";
            }
            else if (nRemaining == 1)
            {
                szMessage = "Only One Critical NPC Remains!";
            }
            else if (nRemaining == 0)
            {
                szMessage = "All Critical NPCs slain!";
            }
            
            // Check for friendly fire (from original script logic)
            bool bFriendlyFire = IsPlayerID(m_szProcessingKiller);
            if (bFriendlyFire)
            {
                szReason = GetNPCDisplayName(m_szProcessingDeadNPC) + " WAS SLAIN BY FRIENDLY FIRE! (" + 
                          GetPlayerName(m_szProcessingKiller) + ")!";
                m_nFriendlyFireDeaths++;
            }
            
            // Send message to all players
            if (szMessage.length() > 0)
            {
                SendMessageToAllPlayers("Critical NPC Status", szMessage + " " + szReason);
                LogMessage("[WARNING] CriticalNPCManager: " + szMessage + " " + szReason);
            }
        }
        
        /**
         * Record an NPC death for history and analysis
         */
        void RecordNPCDeath(const string &in szNPCName, const string &in szKillerID)
        {
            string szNPCScript = GetNPCScript(szNPCName);
            string szKillerName = GetPlayerName(szKillerID);
            
            CriticalNPCDeath deathRecord(szNPCName, szNPCScript, szKillerID, szKillerName);
            
            // Set additional details
            CBaseEntity@ pNPC = FindEntityByName(szNPCName);
            if (pNPC !is null)
            {
                // Use GetOrigin() method instead of direct pev access
                deathRecord.vecDeathLocation = pNPC.GetOrigin();
            }
            
            // Check if this death breaks quest chains
            deathRecord.bQuestCritical = IsQuestCritical(szNPCName);
            
            m_DeathHistory.insertLast(deathRecord);
            
            // Maintain history size limit
            if (m_DeathHistory.length() > m_nMaxDeathHistory)
            {
                m_DeathHistory.removeAt(0);
            }
            
            LogMessage("[ERROR] CriticalNPCManager: Recorded death of " + szNPCName + " killed by " + szKillerName + 
                    " at (" + deathRecord.vecDeathLocation.x + ", " + deathRecord.vecDeathLocation.y + ", " + deathRecord.vecDeathLocation.z + ")");
        }
        
        /**
         * Check if an NPC death impacts quest chains
         */
        void CheckQuestChainImpact(const string &in szNPCName)
        {
            for (uint i = 0; i < m_RegisteredNPCs.length(); i++)
            {
                if (m_RegisteredNPCs[i].szNPCName == szNPCName)
                {
                    if (m_RegisteredNPCs[i].szQuestChain.length() > 0)
                    {
                        LogMessage("[ERROR] CriticalNPCManager: QUEST CHAIN IMPACT - '" + m_RegisteredNPCs[i].szQuestChain + 
                                "' may be broken due to death of " + szNPCName);
                        
                        // Alert admins about quest chain impact
                        string alertMsg = "QUEST ALERT: " + m_RegisteredNPCs[i].szQuestChain + 
                                         " quest chain affected by death of " + m_RegisteredNPCs[i].szDisplayName;
                        SendAdminAlert(alertMsg);
                        
                        m_nQuestChainsProtected++;
                    }
                    break;
                }
            }
        }
        
        /**
         * Get all registered critical NPCs
         */
        array<CriticalNPCEntry> GetRegisteredNPCs()
        {
            return m_RegisteredNPCs;
        }
        
        /**
         * Get current critical NPC list
         */
        array<string> GetCurrentCriticalList()
        {
            return m_GlobalCriticalList;
        }
        
        /**
         * Get NPC death history
         */
        array<CriticalNPCDeath> GetDeathHistory()
        {
            return m_DeathHistory;
        }
        
        /**
         * Get statistics
         */
        uint GetTotalCriticalDeaths() { return m_nTotalCriticalDeaths; }
        uint GetFriendlyFireDeaths() { return m_nFriendlyFireDeaths; }
        uint GetQuestChainsProtected() { return m_nQuestChainsProtected; }
        uint GetAdminInterventions() { return m_nAdminInterventions; }
        uint GetRegisteredNPCCount() { return m_RegisteredNPCs.length(); }
        uint GetActiveCriticalCount() { return m_GlobalCriticalList.length(); }
        
        /**
         * Admin function: Respawn a critical NPC
         */
        bool RespawnCriticalNPC(const string &in szNPCName, const Vector3 &in vecLocation = Vector3())
        {
            for (uint i = 0; i < m_RegisteredNPCs.length(); i++)
            {
                if (m_RegisteredNPCs[i].szNPCName == szNPCName)
                {
                    if (!m_RegisteredNPCs[i].bCanRespawn)
                    {
                        LogMessage("[WARNING] CriticalNPCManager: NPC '" + szNPCName + "' cannot be respawned");
                        return false;
                    }
                    
                    Vector3 spawnPos;
                    if (vecLocation.Length() > 0)
                        spawnPos = vecLocation;
                    else
                        spawnPos = m_RegisteredNPCs[i].vecSpawnLocation;
                    
                    // Create the NPC
                    CreateNPC(m_RegisteredNPCs[i].szNPCScript, spawnPos, m_RegisteredNPCs[i].vecSpawnAngles);
                    
                    // Update tracking
                    m_RegisteredNPCs[i].bCurrentlyAlive = true;
                    AddToGlobalCriticalList(szNPCName);
                    
                    LogMessage("[INFO] CriticalNPCManager: Respawned critical NPC '" + szNPCName + "' at (" + spawnPos.x + ", " + spawnPos.y + ", " + spawnPos.z + ")");
                    m_nAdminInterventions++;
                    return true;
                }
            }
            
            LogMessage("[ERROR] CriticalNPCManager: Cannot respawn unknown NPC '" + szNPCName + "'");
            return false;
        }
        
        /**
         * Admin function: Get detailed status report
         */
        void GenerateStatusReport(CBasePlayer@ pAdmin)
        {
            if (pAdmin is null) return;
            
            SendMessageToPlayer(pAdmin, "=== Critical NPC Manager Status ===");
            SendMessageToPlayer(pAdmin, "Registered NPCs: " + GetRegisteredNPCCount());
            SendMessageToPlayer(pAdmin, "Currently Critical: " + GetActiveCriticalCount());
            SendMessageToPlayer(pAdmin, "Total Deaths: " + GetTotalCriticalDeaths());
            SendMessageToPlayer(pAdmin, "Friendly Fire Deaths: " + GetFriendlyFireDeaths());
            SendMessageToPlayer(pAdmin, "Quest Chains Protected: " + GetQuestChainsProtected());
            SendMessageToPlayer(pAdmin, "Admin Interventions: " + GetAdminInterventions());
            
            SendMessageToPlayer(pAdmin, "");
            SendMessageToPlayer(pAdmin, "Active Critical NPCs:");
            for (uint i = 0; i < m_GlobalCriticalList.length(); i++)
            {
                string displayName = GetNPCDisplayName(m_GlobalCriticalList[i]);
                SendMessageToPlayer(pAdmin, "  " + m_GlobalCriticalList[i] + " (" + displayName + ")");
            }
            
            if (m_DeathHistory.length() > 0)
            {
                SendMessageToPlayer(pAdmin, "");
                SendMessageToPlayer(pAdmin, "Recent Deaths (last 5):");
                uint startIdx = (m_DeathHistory.length() > 5) ? m_DeathHistory.length() - 5 : 0;
                for (uint i = startIdx; i < m_DeathHistory.length(); i++)
                {
                    CriticalNPCDeath death = m_DeathHistory[i];
                    string msg = "  " + death.szNPCName + " killed by " + death.szKillerName;
                    if (death.bFriendlyFire) msg += " (FRIENDLY FIRE)";
                    SendMessageToPlayer(pAdmin, msg);
                }
            }
        }
        
        /**
         * Admin function: Clear death history
         */
        void ClearDeathHistory()
        {
            m_DeathHistory.resize(0);
            LogMessage("[INFO] CriticalNPCManager: Death history cleared by admin");
        }
        
        /**
         * Admin function: Reset critical list from registrations
         */
        void ResetCriticalList()
        {
            BuildInitialCriticalList();
            
            // Mark all registered NPCs as alive
            for (uint i = 0; i < m_RegisteredNPCs.length(); i++)
            {
                m_RegisteredNPCs[i].bCurrentlyAlive = true;
            }
            
            LogMessage("[INFO] CriticalNPCManager: Critical list reset to initial state");
        }
        
        /**
         * Build initial critical list from registered NPCs
         */
        void BuildInitialCriticalList()
        {
            m_GlobalCriticalList.resize(0);
            
            for (uint i = 0; i < m_RegisteredNPCs.length(); i++)
            {
                if (m_RegisteredNPCs[i].nPriority <= 2) // Only priority 1 and 2
                {
                    m_GlobalCriticalList.insertLast(m_RegisteredNPCs[i].szNPCName);
                }
            }
            
            UpdateGlobalCriticalList();
        }
        
        /**
         * Load critical list from token string format
         */
        void LoadCriticalListFromString(const string &in criticalList)
        {
            m_GlobalCriticalList.resize(0);
            
            // Parse token-separated string
            array<string> tokens = criticalList.split(";");
            for (uint i = 0; i < tokens.length(); i++)
            {
                if (tokens[i].length() > 0)
                {
                    m_GlobalCriticalList.insertLast(tokens[i]);
                }
            }
        }
        
        /**
         * Add NPC to global critical list
         */
        void AddToGlobalCriticalList(const string &in szNPCName)
        {
            // Check if already in list
            for (uint i = 0; i < m_GlobalCriticalList.length(); i++)
            {
                if (m_GlobalCriticalList[i] == szNPCName)
                    return; // Already in list
            }
            
            m_GlobalCriticalList.insertLast(szNPCName);
            UpdateGlobalCriticalList();
        }
        
        /**
         * Update global variable with current critical list
         */
        void UpdateGlobalCriticalList()
        {
            string criticalListString = "";
            for (uint i = 0; i < m_GlobalCriticalList.length(); i++)
            {
                if (i > 0) criticalListString += ";";
                criticalListString += m_GlobalCriticalList[i];
            }
            
            SetGlobalVariable("G_CRITICAL_NPCS", criticalListString);
        }
        
        /**
         * Get NPC display name
         */
        string GetNPCDisplayName(const string &in szNPCName)
        {
            for (uint i = 0; i < m_RegisteredNPCs.length(); i++)
            {
                if (m_RegisteredNPCs[i].szNPCName == szNPCName)
                {
                    return m_RegisteredNPCs[i].szDisplayName;
                }
            }
            return szNPCName; // Fallback to NPC name
        }
        
        /**
         * Get NPC script name
         */
        string GetNPCScript(const string &in szNPCName)
        {
            for (uint i = 0; i < m_RegisteredNPCs.length(); i++)
            {
                if (m_RegisteredNPCs[i].szNPCName == szNPCName)
                {
                    return m_RegisteredNPCs[i].szNPCScript;
                }
            }
            return szNPCName; // Fallback
        }
        
        /**
         * Check if NPC is quest critical
         */
        bool IsQuestCritical(const string &in szNPCName)
        {
            for (uint i = 0; i < m_RegisteredNPCs.length(); i++)
            {
                if (m_RegisteredNPCs[i].szNPCName == szNPCName)
                {
                    return m_RegisteredNPCs[i].nPriority <= 2;
                }
            }
            return false;
        }
        
        /**
         * Check if ID is a player ID
         */
        bool IsPlayerID(const string &in id)
        {
            return id.substr(0, 6) == "STEAM_" || id.substr(0, 6) == "Player";
        }
        
        /**
         * Get player name from ID
         */
        string GetPlayerName(const string &in szPlayerID)
        {
            // TODO: Implement proper player name lookup
            if (IsPlayerID(szPlayerID))
            {
                return "Player(" + szPlayerID + ")";
            }
            return szPlayerID;
        }
        
        /**
         * Send alert to all admins
         */
        void SendAdminAlert(const string &in message)
        {
            // TODO: Implement admin-only messaging
            LogMessage("[ERROR] ADMIN ALERT: " + message);
            SendMessageToAllPlayers("Critical NPC Alert", message);
        }
        
        /**
         * Send message to all players
         */
        void SendMessageToAllPlayers(const string &in title, const string &in message)
        {
            LogMessage("[BROADCAST] " + title + ": " + message);
            
            // Get all players and send message to each
            array<CBasePlayer@>@ players = GetAllPlayers();
            
            if (players is null)
            {
                LogMessage("[CriticalNPCManager] SendMessageToAllPlayers: GetAllPlayers returned null");
                return;
            }
            
            for (uint i = 0; i < players.length(); i++)
            {
                CBasePlayer@ player = players[i];
                if (player !is null && player.IsConnected())
                {
                    // Send title in red for critical alerts
                    player.SendColoredMessage(MessageColor::Red, title);
                    // Send message in yellow
                    player.SendColoredMessage(MessageColor::Yellow, message);
                }
            }
        }
        
        /**
         * Send message to specific player
         */
        void SendMessageToPlayer(CBasePlayer@ pPlayer, const string &in message)
        {
            if (pPlayer is null) return;
            
            LogMessage("[MSG to " + pPlayer.GetName() + "] " + message);
            
            // Send message in yellow
            if (pPlayer.IsConnected())
            {
                pPlayer.SendColoredMessage(MessageColor::Yellow, message);
            }
        }
    }
    
    // Global critical NPC manager instance
    CriticalNPCManager@ g_CriticalNPCManager = null;
    
    /**
     * Initialize the critical NPC manager
     */
    void InitializeCriticalNPCManager()
    {
        if (g_CriticalNPCManager is null)
        {
            @g_CriticalNPCManager = CriticalNPCManager();
            LogMessage("CriticalNPCManager: Initialized successfully");
        }
        else
        {
            LogMessage("[WARNING] CriticalNPCManager: Already initialized");
        }
    }
    
    /**
     * Get the global critical NPC manager instance
     */
    CriticalNPCManager@ GetCriticalNPCManager()
    {
        if (g_CriticalNPCManager is null)
        {
            InitializeCriticalNPCManager();
        }
        return g_CriticalNPCManager;
    }
    
    /**
     * Shutdown the critical NPC manager
     */
    void ShutdownCriticalNPCManager()
    {
        if (g_CriticalNPCManager !is null)
        {
            LogMessage("CriticalNPCManager: Shutting down");
            @g_CriticalNPCManager = null;
        }
    }
    
    // External functions for compatibility with original script
    
    /**
     * External function for critical NPC death reporting
     * Compatible with original gm_crit_npc_died event
     * Called when a critical NPC dies
     */
    void gm_crit_npc_died(const string &in szNPCName, const string &in szKillerID)
    {
        GetCriticalNPCManager().CriticalNPCDied(szNPCName, szKillerID);
    }
    
    /**
     * External function to manually remove NPC from critical list
     * Compatible with original remove_crit_npc logic
     */
    void remove_crit_npc(const string &in szNPCName)
    {
        GetCriticalNPCManager().RemoveFromCriticalList(szNPCName);
    }
    
    /**
     * External function to get count of remaining critical NPCs
     * Compatible with original crit_count_remaining functionality
     */
    uint crit_count_remaining()
    {
        return GetCriticalNPCManager().GetActiveCriticalCount();
    }
    
    /**
     * External function to register a new critical NPC
     * Enhanced version for dynamic NPC registration
     */
    void register_critical_npc(const string &in szName, const string &in szScript, 
                              const string &in szDisplayName, const string &in szMap = "",
                              int nPriority = 1, const string &in szQuestChain = "")
    {
        GetCriticalNPCManager().RegisterCriticalNPC(szName, szScript, szDisplayName, szMap, nPriority, szQuestChain);
    }
    
    /**
     * External function to respawn a critical NPC (admin only)
     */
    bool respawn_critical_npc(const string &in szNPCName, const Vector3 &in vecLocation = Vector3())
    {
        return GetCriticalNPCManager().RespawnCriticalNPC(szNPCName, vecLocation);
    }
    
    /**
     * External function to get critical NPC status (admin only)
     */
    void get_critical_npc_status(CBasePlayer@ pAdmin)
    {
        GetCriticalNPCManager().GenerateStatusReport(pAdmin);
    }
    
    /**
     * External function to reset critical list (admin only)
     */
    void reset_critical_list()
    {
        GetCriticalNPCManager().ResetCriticalList();
    }
    
    /**
     * External function to clear death history (admin only)
     */
    void clear_critical_death_history()
    {
        GetCriticalNPCManager().ClearDeathHistory();
    }
    
    // Placeholder implementations for missing functions
    string GetGlobalVariable(const string &in varName)
    {
        // TODO: Implement global variable access
        return "";
    }
    
    void SetGlobalVariable(const string &in varName, const string &in value)
    {
        // TODO: Implement global variable setting
        LogMessage("[DEBUG] SetGlobalVariable: " + varName + " = " + value);
    }
    
    CBaseEntity@ FindEntityByName(const string &in name)
    {
        // TODO: Implement entity lookup
        return null;
    }
    
    void CreateNPC(const string &in script, const Vector3 &in pos, const Vector3 &in angles = Vector3())
    {
        // TODO: Implement NPC creation
        LogMessage("[DEBUG] CreateNPC: " + script + " at (" + pos.x + ", " + pos.y + ", " + pos.z + ")");
    }
    
    string GetMapName()
    {
        // TODO: Implement map name lookup
        return "unknown_map";
    }
    
    float GetGameTime()
    {
        // TODO: Implement game time lookup
        return 0.0f;
    }
    
    // Note: Using logging functions provided by the engine
    // LogInfo, LogWarning, LogError, LogDebug are defined globally by the C++ engine
}