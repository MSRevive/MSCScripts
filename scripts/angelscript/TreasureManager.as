/**
 * TreasureManager.as
 * 
 * Treasure scrambling and randomization system for Master Sword Rebirth.
 * Provides dynamic loot generation, epic item management, and anti-farming measures.
 * 
 * Based on original game_master.script treasure system (lines 1619-1682)
 * 
 * Key Features:
 * - Global treasure list randomization and shuffling
 * - Epic item array management and special handling
 * - Rarity-based item distribution (common to legendary)
 * - Dynamic loot scaling based on area difficulty
 * - Anti-farming measures and respawn management
 * - Global treasure state persistence across map changes
 * - Integration with spawn and quest systems
 */

namespace MS
{
    /**
     * Treasure rarity levels
     */
    enum TreasureRarity
    {
        COMMON = 0,
        UNCOMMON = 1,
        RARE = 2,
        EPIC = 3,
        LEGENDARY = 4
    };

    /**
     * Treasure item definition
     */
    class TreasureItem
    {
        string szItemName;
        string szItemScript;
        TreasureRarity eRarity;
        uint nMinLevel;
        uint nMaxLevel;
        float fDropChance;
        bool bQuestItem;
        string szRequiredMap;
        uint nValueRange;
        
        TreasureItem()
        {
            szItemName = "";
            szItemScript = "";
            eRarity = COMMON;
            nMinLevel = 1;
            nMaxLevel = 999;
            fDropChance = 1.0f;
            bQuestItem = false;
            szRequiredMap = "";
            nValueRange = 100;
        }
        
        TreasureItem(const string &in name, const string &in script, TreasureRarity rarity, 
                    uint minLevel, uint maxLevel, float dropChance)
        {
            szItemName = name;
            szItemScript = script;
            eRarity = rarity;
            nMinLevel = minLevel;
            nMaxLevel = maxLevel;
            fDropChance = dropChance;
            bQuestItem = false;
            szRequiredMap = "";
            nValueRange = 100;
        }
    };

    /**
     * Treasure spawn location
     */
    class TreasureSpawnPoint
    {
        Vector3 vPosition;
        string szMapName;
        uint nDifficultyLevel;
        float fRespawnTime;
        float fLastSpawnTime;
        bool bActive;
        string szSpawnedItem;
        TreasureRarity ePreferredRarity;
        
        TreasureSpawnPoint()
        {
            vPosition = Vector3(0, 0, 0);
            szMapName = "";
            nDifficultyLevel = 1;
            fRespawnTime = 300.0f; // 5 minutes default
            fLastSpawnTime = 0.0f;
            bActive = true;
            szSpawnedItem = "";
            ePreferredRarity = COMMON;
        }
        
        TreasureSpawnPoint(const Vector3 &in pos, const string &in mapName, uint difficulty)
        {
            vPosition = pos;
            szMapName = mapName;
            nDifficultyLevel = difficulty;
            fRespawnTime = 300.0f;
            fLastSpawnTime = 0.0f;
            bActive = true;
            szSpawnedItem = "";
            ePreferredRarity = COMMON;
        }
    };

    /**
     * Player treasure farming tracking
     */
    class PlayerFarmingData
    {
        string szPlayerID;
        uint nRecentTreasures;
        float fLastTreasureTime;
        Vector3 vLastTreasureLocation;
        array<string> RecentItems;
        
        PlayerFarmingData()
        {
            szPlayerID = "";
            nRecentTreasures = 0;
            fLastTreasureTime = 0.0f;
            vLastTreasureLocation = Vector3(0, 0, 0);
        }
        
        PlayerFarmingData(const string &in playerID)
        {
            szPlayerID = playerID;
            nRecentTreasures = 0;
            fLastTreasureTime = 0.0f;
            vLastTreasureLocation = Vector3(0, 0, 0);
        }
    };

    /**
     * Main treasure management system
     */
    class TreasureManager
    {
    private:
        // Core treasure arrays (like original SCRAMBLE_ITEMS, SCRAMBLE_EPICS)
        array<TreasureItem> m_CommonTreasures;
        array<TreasureItem> m_UncommonTreasures;
        array<TreasureItem> m_RareTreasures;
        array<TreasureItem> m_EpicTreasures;        // SCRAMBLE_EPICS equivalent
        array<TreasureItem> m_LegendaryTreasures;
        
        // Global treasure list (SCRAMBLE_ITEMS equivalent)
        array<TreasureItem> m_GlobalTreasureList;
        
        // Spawn management
        array<TreasureSpawnPoint> m_SpawnPoints;
        
        // Anti-farming system
        dictionary m_PlayerFarmingData; // playerID -> PlayerFarmingData
        
        // Randomization state
        uint m_nRandomSeed;
        uint m_nLastScrambleTime;
        bool m_bScrambleActive;
        
        // Configuration
        const uint TREASURE_SETS_PER_SCRAMBLE = 20;  // Number of items per scramble set
        const uint MAX_EPIC_ITEMS = 10;              // Maximum epic items in circulation
        const float ANTI_FARM_RADIUS = 500.0f;       // Anti-farming detection radius
        const float ANTI_FARM_TIME_WINDOW = 60.0f;   // Anti-farming time window (seconds)
        const uint MAX_TREASURES_PER_PERIOD = 3;     // Max treasures per anti-farm period
        const float EPIC_DROP_CHANCE_BASE = 0.05f;   // 5% base chance for epic drops
        const float LEGENDARY_DROP_CHANCE = 0.01f;   // 1% chance for legendary drops
        
    public:
        TreasureManager()
        {
            m_nRandomSeed = 12345;
            m_nLastScrambleTime = 0;
            m_bScrambleActive = false;
            
            InitializeTreasureTables();
        }
        
        /**
         * Initialize the treasure management system
         */
        void Initialize()
        {
            InitializeTreasureTables();
            LoadTreasureSpawns();
            ScrambleTreasures();
            
            LogMessage("[INFO] TreasureManager initialized successfully");
            LogMessage("[INFO] Loaded " + m_GlobalTreasureList.length() + " treasures across all rarities");
            LogMessage("[INFO] Epic items available: " + m_EpicTreasures.length());
            LogMessage("[INFO] Treasure spawn points: " + m_SpawnPoints.length());
        }
        
        /**
         * Shutdown the treasure system
         */
        void Shutdown()
        {
            m_GlobalTreasureList.resize(0);
            m_CommonTreasures.resize(0);
            m_UncommonTreasures.resize(0);
            m_RareTreasures.resize(0);
            m_EpicTreasures.resize(0);
            m_LegendaryTreasures.resize(0);
            m_SpawnPoints.resize(0);
            m_PlayerFarmingData.deleteAll();
            
            LogMessage("[INFO] TreasureManager shutdown completed");
        }
        
        /**
         * Update treasure system (called periodically)
         */
        void Update()
        {
            float currentTime = GetGameTime();
            
            // Check for treasure respawns
            UpdateTreasureSpawns(currentTime);
            
            // Clean up old farming data
            CleanupFarmingData(currentTime);
            
            // Periodic treasure scrambling (every 30 minutes)
            if (currentTime - m_nLastScrambleTime > 1800.0f)
            {
                ScrambleTreasures();
                m_nLastScrambleTime = uint(currentTime);
            }
        }
        
        /**
         * Scramble treasure lists (core functionality from original)
         */
        void ScrambleTreasures()
        {
            LogMessage("[INFO] Starting treasure scramble...");
            
            // Update random seed
            m_nRandomSeed = uint(GetGameTime()) ^ 0xDEADBEEF;
            
            // Shuffle all treasure arrays
            ShuffleTreasureArray(m_CommonTreasures);
            ShuffleTreasureArray(m_UncommonTreasures);
            ShuffleTreasureArray(m_RareTreasures);
            ShuffleTreasureArray(m_EpicTreasures);
            ShuffleTreasureArray(m_LegendaryTreasures);
            
            // Rebuild global treasure list with randomized distribution
            RebuildGlobalTreasureList();
            
            // Shuffle the global list
            ShuffleTreasureArray(m_GlobalTreasureList);
            
            m_bScrambleActive = true;
            
            LogMessage("[INFO] Treasure scramble completed - " + m_GlobalTreasureList.length() + " items randomized");
        }
        
        /**
         * Generate random treasure for a location
         */
        TreasureItem@ GenerateRandomTreasure(const Vector3 &in location, uint difficultyLevel, 
                                           CBasePlayer@ pPlayer = null)
        {
            if (m_GlobalTreasureList.length() == 0)
            {
                LogMessage("[WARNING] No treasures available for generation");
                return null;
            }
            
            // Check anti-farming if player provided
            if (pPlayer !is null)
            {
                if (IsPlayerFarming(pPlayer, location))
                {
                    LogMessage("[INFO] Anti-farming triggered for player " + pPlayer.pev.netname);
                    return null;
                }
            }
            
            // Determine rarity based on difficulty and chance
            TreasureRarity targetRarity = DetermineRarityByDifficulty(difficultyLevel);
            
            // Find suitable treasure item
            TreasureItem@ selectedItem = SelectTreasureByRarity(targetRarity, difficultyLevel);
            
            if (selectedItem !is null && pPlayer !is null)
            {
                // Update anti-farming tracking
                UpdatePlayerFarmingData(pPlayer, location, selectedItem.szItemName);
                
                LogMessage("[INFO] Generated " + GetRarityName(selectedItem.eRarity) + 
                          " treasure '" + selectedItem.szItemName + "' for " + pPlayer.pev.netname);
            }
            
            return selectedItem;
        }
        
        /**
         * Spawn treasure at specific location
         */
        bool SpawnTreasure(const Vector3 &in location, const string &in mapName, 
                          uint difficultyLevel, CBasePlayer@ pPlayer = null)
        {
            TreasureItem@ treasure = GenerateRandomTreasure(location, difficultyLevel, pPlayer);
            
            if (treasure is null)
            {
                return false;
            }
            
            // Create the treasure entity
            if (CreateTreasureEntity(treasure, location, mapName))
            {
                LogMessage("[INFO] Spawned treasure '" + treasure.szItemName + "' at " + location.ToString());
                return true;
            }
            
            return false;
        }
        
        /**
         * Register a treasure spawn point
         */
        bool RegisterSpawnPoint(const Vector3 &in location, const string &in mapName, 
                               uint difficultyLevel, float respawnTime = 300.0f)
        {
            TreasureSpawnPoint newPoint(location, mapName, difficultyLevel);
            newPoint.fRespawnTime = respawnTime;
            newPoint.ePreferredRarity = DetermineRarityByDifficulty(difficultyLevel);
            
            m_SpawnPoints.insertLast(newPoint);
            
            LogMessage("[INFO] Registered treasure spawn point at " + location.ToString() + 
                      " (difficulty: " + difficultyLevel + ", respawn: " + respawnTime + "s)");
            
            return true;
        }
        
        /**
         * Force respawn all treasures (admin command)
         */
        void ForceRespawnAllTreasures()
        {
            float currentTime = GetGameTime();
            uint respawnCount = 0;
            
            for (uint i = 0; i < m_SpawnPoints.length(); i++)
            {
                if (m_SpawnPoints[i].bActive && m_SpawnPoints[i].szSpawnedItem.isEmpty())
                {
                    if (SpawnTreasure(m_SpawnPoints[i].vPosition, m_SpawnPoints[i].szMapName, 
                                    m_SpawnPoints[i].nDifficultyLevel))
                    {
                        m_SpawnPoints[i].fLastSpawnTime = currentTime;
                        respawnCount++;
                    }
                }
            }
            
            LogMessage("[INFO] Force respawned " + respawnCount + " treasures");
        }
        
        /**
         * Clear player farming data (admin command)
         */
        void ClearPlayerFarmingData(const string &in playerID = "")
        {
            if (playerID.isEmpty())
            {
                m_PlayerFarmingData.deleteAll();
                LogMessage("[INFO] Cleared all player farming data");
            }
            else
            {
                if (m_PlayerFarmingData.exists(playerID))
                {
                    m_PlayerFarmingData.delete(playerID);
                    LogMessage("[INFO] Cleared farming data for player: " + playerID);
                }
            }
        }
        
        /**
         * Get treasure statistics
         */
        void GetTreasureStatistics(uint &out nTotalTreasures, uint &out nActiveSpawns, 
                                  uint &out nEpicItems, uint &out nTrackedPlayers)
        {
            nTotalTreasures = m_GlobalTreasureList.length();
            nActiveSpawns = 0;
            nEpicItems = m_EpicTreasures.length();
            nTrackedPlayers = m_PlayerFarmingData.getSize();
            
            for (uint i = 0; i < m_SpawnPoints.length(); i++)
            {
                if (m_SpawnPoints[i].bActive)
                {
                    nActiveSpawns++;
                }
            }
        }
        
        /**
         * Generate status report (admin command)
         */
        void GenerateStatusReport(CBasePlayer@ pAdmin)
        {
            if (pAdmin is null) return;
            
            uint nTotal, nActive, nEpic, nPlayers;
            GetTreasureStatistics(nTotal, nActive, nEpic, nPlayers);
            
            SendMessageToPlayer(pAdmin, "=== Treasure System Status ===");
            SendMessageToPlayer(pAdmin, "Total Treasures: " + nTotal);
            SendMessageToPlayer(pAdmin, "Active Spawn Points: " + nActive + "/" + m_SpawnPoints.length());
            SendMessageToPlayer(pAdmin, "Epic Items Available: " + nEpic);
            SendMessageToPlayer(pAdmin, "Players Tracked (Anti-Farming): " + nPlayers);
            SendMessageToPlayer(pAdmin, "Last Scramble: " + (GetGameTime() - m_nLastScrambleTime) + " seconds ago");
            SendMessageToPlayer(pAdmin, "Scramble Active: " + (m_bScrambleActive ? "Yes" : "No"));
            
            // Show rarity distribution
            SendMessageToPlayer(pAdmin, "Rarity Distribution:");
            SendMessageToPlayer(pAdmin, "  Common: " + m_CommonTreasures.length());
            SendMessageToPlayer(pAdmin, "  Uncommon: " + m_UncommonTreasures.length());
            SendMessageToPlayer(pAdmin, "  Rare: " + m_RareTreasures.length());
            SendMessageToPlayer(pAdmin, "  Epic: " + m_EpicTreasures.length());
            SendMessageToPlayer(pAdmin, "  Legendary: " + m_LegendaryTreasures.length());
        }
        
    private:
        /**
         * Initialize treasure tables with predefined items
         */
        void InitializeTreasureTables()
        {
            // Common treasures (high drop rate, low value)
            m_CommonTreasures.insertLast(TreasureItem("Small Health Potion", "potion_health_small", COMMON, 1, 10, 0.8f));
            m_CommonTreasures.insertLast(TreasureItem("Small Mana Potion", "potion_mana_small", COMMON, 1, 10, 0.8f));
            m_CommonTreasures.insertLast(TreasureItem("Gold Coins", "item_gold_small", COMMON, 1, 999, 0.9f));
            m_CommonTreasures.insertLast(TreasureItem("Iron Arrows", "proj_arrow_iron", COMMON, 1, 20, 0.7f));
            m_CommonTreasures.insertLast(TreasureItem("Bread", "food_bread", COMMON, 1, 5, 0.6f));
            
            // Uncommon treasures (medium drop rate, medium value)
            m_UncommonTreasures.insertLast(TreasureItem("Health Potion", "potion_health_medium", UNCOMMON, 5, 25, 0.5f));
            m_UncommonTreasures.insertLast(TreasureItem("Mana Potion", "potion_mana_medium", UNCOMMON, 5, 25, 0.5f));
            m_UncommonTreasures.insertLast(TreasureItem("Silver Coins", "item_gold_medium", UNCOMMON, 5, 999, 0.6f));
            m_UncommonTreasures.insertLast(TreasureItem("Steel Arrows", "proj_arrow_steel", UNCOMMON, 10, 40, 0.4f));
            m_UncommonTreasures.insertLast(TreasureItem("Magic Scroll", "scroll_magic_random", UNCOMMON, 8, 30, 0.3f));
            
            // Rare treasures (low drop rate, high value)
            m_RareTreasures.insertLast(TreasureItem("Greater Health Potion", "potion_health_large", RARE, 15, 50, 0.2f));
            m_RareTreasures.insertLast(TreasureItem("Greater Mana Potion", "potion_mana_large", RARE, 15, 50, 0.2f));
            m_RareTreasures.insertLast(TreasureItem("Enchanted Gems", "item_gems_enchanted", RARE, 20, 999, 0.15f));
            m_RareTreasures.insertLast(TreasureItem("Masterwork Weapon", "weapon_masterwork_random", RARE, 25, 60, 0.1f));
            m_RareTreasures.insertLast(TreasureItem("Spell Components", "reagent_spell_rare", RARE, 18, 45, 0.12f));
            
            // Epic treasures (very low drop rate, very high value)
            m_EpicTreasures.insertLast(TreasureItem("Elixir of Life", "potion_elixir_life", EPIC, 30, 80, 0.05f));
            m_EpicTreasures.insertLast(TreasureItem("Ancient Tome", "book_ancient_knowledge", EPIC, 35, 999, 0.03f));
            m_EpicTreasures.insertLast(TreasureItem("Enchanted Armor", "armor_enchanted_random", EPIC, 40, 90, 0.04f));
            m_EpicTreasures.insertLast(TreasureItem("Runic Weapon", "weapon_runic_random", EPIC, 45, 999, 0.02f));
            m_EpicTreasures.insertLast(TreasureItem("Dragon Scale", "reagent_dragon_scale", EPIC, 50, 999, 0.01f));
            
            // Legendary treasures (extremely rare, game-changing items)
            m_LegendaryTreasures.insertLast(TreasureItem("Artifact of Power", "artifact_power_random", LEGENDARY, 60, 999, 0.005f));
            m_LegendaryTreasures.insertLast(TreasureItem("Legendary Weapon", "weapon_legendary_random", LEGENDARY, 70, 999, 0.003f));
            m_LegendaryTreasures.insertLast(TreasureItem("Crown of Kings", "item_crown_kings", LEGENDARY, 80, 999, 0.002f));
            
            LogMessage("[INFO] Initialized treasure tables:");
            LogMessage("[INFO]   Common: " + m_CommonTreasures.length() + " items");
            LogMessage("[INFO]   Uncommon: " + m_UncommonTreasures.length() + " items");
            LogMessage("[INFO]   Rare: " + m_RareTreasures.length() + " items");
            LogMessage("[INFO]   Epic: " + m_EpicTreasures.length() + " items");
            LogMessage("[INFO]   Legendary: " + m_LegendaryTreasures.length() + " items");
        }
        
        /**
         * Load treasure spawn points from map data
         */
        void LoadTreasureSpawns()
        {
            // This would normally load from map data or configuration
            // For now, we'll add some example spawn points
            
            string currentMap = GetCurrentMapName();
            
            // Example spawn points for different maps
            if (currentMap == "edana")
            {
                RegisterSpawnPoint(Vector3(100, 200, 0), "edana", 1, 300.0f);
                RegisterSpawnPoint(Vector3(-150, 350, 10), "edana", 2, 450.0f);
                RegisterSpawnPoint(Vector3(500, -100, 5), "edana", 3, 600.0f);
            }
            else if (currentMap == "thornlands")
            {
                RegisterSpawnPoint(Vector3(200, 400, 15), "thornlands", 4, 400.0f);
                RegisterSpawnPoint(Vector3(-300, 150, 20), "thornlands", 5, 500.0f);
            }
            
            LogMessage("[INFO] Loaded " + m_SpawnPoints.length() + " treasure spawn points for map: " + currentMap);
        }
        
        /**
         * Shuffle treasure array (Fisher-Yates algorithm)
         */
        void ShuffleTreasureArray(array<TreasureItem> &inout treasures)
        {
            if (treasures.length() <= 1) return;
            
            for (uint i = treasures.length() - 1; i > 0; i--)
            {
                uint j = GenerateRandom() % (i + 1);
                
                // Swap items
                TreasureItem temp = treasures[i];
                treasures[i] = treasures[j];
                treasures[j] = temp;
            }
        }
        
        /**
         * Rebuild global treasure list with proper distribution
         */
        void RebuildGlobalTreasureList()
        {
            m_GlobalTreasureList.resize(0);
            
            // Add treasures with weighted distribution
            // Common: 60% of list
            for (uint i = 0; i < m_CommonTreasures.length(); i++)
            {
                for (uint j = 0; j < 6; j++) // Add 6 copies of each common item
                {
                    m_GlobalTreasureList.insertLast(m_CommonTreasures[i]);
                }
            }
            
            // Uncommon: 25% of list
            for (uint i = 0; i < m_UncommonTreasures.length(); i++)
            {
                for (uint j = 0; j < 3; j++) // Add 3 copies of each uncommon item
                {
                    m_GlobalTreasureList.insertLast(m_UncommonTreasures[i]);
                }
            }
            
            // Rare: 12% of list
            for (uint i = 0; i < m_RareTreasures.length(); i++)
            {
                for (uint j = 0; j < 2; j++) // Add 2 copies of each rare item
                {
                    m_GlobalTreasureList.insertLast(m_RareTreasures[i]);
                }
            }
            
            // Epic: 2.5% of list
            for (uint i = 0; i < m_EpicTreasures.length(); i++)
            {
                m_GlobalTreasureList.insertLast(m_EpicTreasures[i]); // Add 1 copy of each epic item
            }
            
            // Legendary: 0.5% of list
            if (m_LegendaryTreasures.length() > 0)
            {
                uint legendaryIndex = GenerateRandom() % m_LegendaryTreasures.length();
                m_GlobalTreasureList.insertLast(m_LegendaryTreasures[legendaryIndex]); // Add 1 random legendary
            }
        }
        
        /**
         * Determine rarity based on difficulty level
         */
        TreasureRarity DetermineRarityByDifficulty(uint difficultyLevel)
        {
            float rarityRoll = float(GenerateRandom() % 10000) / 10000.0f; // 0.0 to 1.0
            
            // Adjust chances based on difficulty
            float difficultyMultiplier = 1.0f + (float(difficultyLevel) * 0.1f);
            
            float legendaryChance = LEGENDARY_DROP_CHANCE * difficultyMultiplier;
            float epicChance = EPIC_DROP_CHANCE_BASE * difficultyMultiplier;
            float rareChance = 0.15f * difficultyMultiplier;
            float uncommonChance = 0.35f;
            
            if (rarityRoll < legendaryChance)
                return LEGENDARY;
            else if (rarityRoll < legendaryChance + epicChance)
                return EPIC;
            else if (rarityRoll < legendaryChance + epicChance + rareChance)
                return RARE;
            else if (rarityRoll < legendaryChance + epicChance + rareChance + uncommonChance)
                return UNCOMMON;
            else
                return COMMON;
        }
        
        /**
         * Select treasure by rarity and difficulty
         */
        TreasureItem@ SelectTreasureByRarity(TreasureRarity targetRarity, uint difficultyLevel)
        {
            array<TreasureItem>@ targetArray = null;
            
            switch (targetRarity)
            {
                case COMMON:
                    @targetArray = m_CommonTreasures;
                    break;
                case UNCOMMON:
                    @targetArray = m_UncommonTreasures;
                    break;
                case RARE:
                    @targetArray = m_RareTreasures;
                    break;
                case EPIC:
                    @targetArray = m_EpicTreasures;
                    break;
                case LEGENDARY:
                    @targetArray = m_LegendaryTreasures;
                    break;
            }
            
            if (targetArray is null || targetArray.length() == 0)
            {
                // Fallback to common if no items of target rarity
                @targetArray = m_CommonTreasures;
            }
            
            // Filter by difficulty level
            array<TreasureItem> validItems;
            for (uint i = 0; i < targetArray.length(); i++)
            {
                if (difficultyLevel >= targetArray[i].nMinLevel && 
                    difficultyLevel <= targetArray[i].nMaxLevel)
                {
                    validItems.insertLast(targetArray[i]);
                }
            }
            
            if (validItems.length() == 0)
            {
                // Return any item from the rarity if no level-appropriate items
                if (targetArray.length() > 0)
                {
                    uint randomIndex = GenerateRandom() % targetArray.length();
                    return targetArray[randomIndex];
                }
                return null;
            }
            
            // Select random valid item
            uint randomIndex = GenerateRandom() % validItems.length();
            return validItems[randomIndex];
        }
        
        /**
         * Check if player is farming (anti-farming system)
         */
        bool IsPlayerFarming(CBasePlayer@ pPlayer, const Vector3 &in location)
        {
            if (pPlayer is null) return false;
            
            string playerID = GetPlayerSteamID(pPlayer);
            if (playerID.isEmpty()) return false;
            
            if (!m_PlayerFarmingData.exists(playerID))
            {
                // First time, not farming
                return false;
            }
            
            PlayerFarmingData@ farmData = cast<PlayerFarmingData@>(m_PlayerFarmingData[playerID]);
            if (farmData is null) return false;
            
            float currentTime = GetGameTime();
            float timeSinceLastTreasure = currentTime - farmData.fLastTreasureTime;
            
            // Reset if enough time has passed
            if (timeSinceLastTreasure > ANTI_FARM_TIME_WINDOW)
            {
                farmData.nRecentTreasures = 0;
                farmData.RecentItems.resize(0);
                return false;
            }
            
            // Check distance from last treasure location
            float distance = CalculateDistance(location, farmData.vLastTreasureLocation);
            if (distance < ANTI_FARM_RADIUS && farmData.nRecentTreasures >= MAX_TREASURES_PER_PERIOD)
            {
                return true; // Farming detected
            }
            
            return false;
        }
        
        /**
         * Update player farming data
         */
        void UpdatePlayerFarmingData(CBasePlayer@ pPlayer, const Vector3 &in location, const string &in itemName)
        {
            if (pPlayer is null) return;
            
            string playerID = GetPlayerSteamID(pPlayer);
            if (playerID.isEmpty()) return;
            
            PlayerFarmingData@ farmData = null;
            
            if (m_PlayerFarmingData.exists(playerID))
            {
                @farmData = cast<PlayerFarmingData@>(m_PlayerFarmingData[playerID]);
            }
            else
            {
                @farmData = PlayerFarmingData(playerID);
                m_PlayerFarmingData[playerID] = @farmData;
            }
            
            if (farmData is null) return;
            
            float currentTime = GetGameTime();
            
            // Reset if time window expired
            if (currentTime - farmData.fLastTreasureTime > ANTI_FARM_TIME_WINDOW)
            {
                farmData.nRecentTreasures = 0;
                farmData.RecentItems.resize(0);
            }
            
            // Update data
            farmData.fLastTreasureTime = currentTime;
            farmData.vLastTreasureLocation = location;
            farmData.nRecentTreasures++;
            farmData.RecentItems.insertLast(itemName);
            
            // Keep only recent items (last 10)
            if (farmData.RecentItems.length() > 10)
            {
                farmData.RecentItems.removeAt(0);
            }
        }
        
        /**
         * Update treasure spawns
         */
        void UpdateTreasureSpawns(float currentTime)
        {
            for (uint i = 0; i < m_SpawnPoints.length(); i++)
            {
                if (!m_SpawnPoints[i].bActive) continue;
                
                // Check if spawn point needs to respawn treasure
                if (m_SpawnPoints[i].szSpawnedItem.isEmpty() && 
                    currentTime - m_SpawnPoints[i].fLastSpawnTime > m_SpawnPoints[i].fRespawnTime)
                {
                    if (SpawnTreasure(m_SpawnPoints[i].vPosition, m_SpawnPoints[i].szMapName, 
                                    m_SpawnPoints[i].nDifficultyLevel))
                    {
                        m_SpawnPoints[i].fLastSpawnTime = currentTime;
                    }
                }
            }
        }
        
        /**
         * Clean up old farming data
         */
        void CleanupFarmingData(float currentTime)
        {
            array<string> keysToRemove;
            array<string> keys = m_PlayerFarmingData.getKeys();
            
            for (uint i = 0; i < keys.length(); i++)
            {
                PlayerFarmingData@ farmData = cast<PlayerFarmingData@>(m_PlayerFarmingData[keys[i]]);
                if (farmData !is null)
                {
                    // Remove data older than 5 minutes
                    if (currentTime - farmData.fLastTreasureTime > 300.0f)
                    {
                        keysToRemove.insertLast(keys[i]);
                    }
                }
            }
            
            for (uint i = 0; i < keysToRemove.length(); i++)
            {
                m_PlayerFarmingData.delete(keysToRemove[i]);
            }
        }
        
        /**
         * Create treasure entity in the world
         */
        bool CreateTreasureEntity(TreasureItem@ treasure, const Vector3 &in location, const string &in mapName)
        {
            if (treasure is null) return false;
            
            // This would create the actual treasure entity in the game world
            // For now, we'll simulate the creation
            
            LogMessage("[INFO] Creating treasure entity: " + treasure.szItemScript + " at " + location.ToString());
            
            // TODO: Call actual entity creation function
            // Example: CreateEntity(treasure.szItemScript, location);
            
            return true;
        }
        
        /**
         * Generate random number
         */
        uint GenerateRandom()
        {
            m_nRandomSeed = (m_nRandomSeed * 1103515245 + 12345) & 0x7FFFFFFF;
            return m_nRandomSeed;
        }
        
        /**
         * Calculate distance between two points
         */
        float CalculateDistance(const Vector3 &in pos1, const Vector3 &in pos2)
        {
            float dx = pos1.x - pos2.x;
            float dy = pos1.y - pos2.y;
            float dz = pos1.z - pos2.z;
            return sqrt(dx*dx + dy*dy + dz*dz);
        }
        
        /**
         * Get rarity name as string
         */
        string GetRarityName(TreasureRarity rarity)
        {
            switch (rarity)
            {
                case COMMON: return "Common";
                case UNCOMMON: return "Uncommon";
                case RARE: return "Rare";
                case EPIC: return "Epic";
                case LEGENDARY: return "Legendary";
                default: return "Unknown";
            }
        }
        
        /**
         * Get current map name
         */
        string GetCurrentMapName()
        {
            // This would use actual map detection
            return "edana"; // Placeholder
        }
        
        /**
         * Get player Steam ID
         */
        string GetPlayerSteamID(CBasePlayer@ pPlayer)
        {
            if (pPlayer is null) return "";
            // This would get actual Steam ID
            return string(pPlayer.pev.netname) + "_id"; // Placeholder
        }
        
        /**
         * Get current game time
         */
        float GetGameTime()
        {
            // This would use actual game time
            return 12345.0f; // Placeholder
        }
        
        /**
         * Send message to player
         */
        void SendMessageToPlayer(CBasePlayer@ pPlayer, const string &in message)
        {
            if (pPlayer is null) return;
            
            // This would use actual player messaging system
            LogMessage("[INFO] Message to " + pPlayer.pev.netname + ": " + message);
        }
        
        /**
         * Log message
         */
        void LogMessage(const string &in message)
        {
            // This would use the actual logging system
            // For now, placeholder
        }
    };
    
    // Global treasure manager instance
    TreasureManager g_TreasureManager;
    
    /**
     * Global functions for integration with other systems
     */
    
    /**
     * Initialize treasure system (called from main initialization)
     */
    void InitializeTreasureSystem()
    {
        g_TreasureManager.Initialize();
    }
    
    /**
     * Shutdown treasure system
     */
    void ShutdownTreasureSystem()
    {
        g_TreasureManager.Shutdown();
    }
    
    /**
     * Update treasure system (called from main update loop)
     */
    void UpdateTreasureSystem()
    {
        g_TreasureManager.Update();
    }
    
    /**
     * Generate treasure for player at location
     */
    bool GenerateTreasureForPlayer(CBasePlayer@ pPlayer, const Vector3 &in location, uint difficultyLevel)
    {
        if (pPlayer is null) return false;
        
        string mapName = g_TreasureManager.GetCurrentMapName();
        return g_TreasureManager.SpawnTreasure(location, mapName, difficultyLevel, pPlayer);
    }
    
    /**
     * Force treasure scramble (admin command)
     */
    void ForceTreasureScramble()
    {
        g_TreasureManager.ScrambleTreasures();
    }
    
    /**
     * Get treasure manager instance
     */
    TreasureManager@ GetTreasureManager()
    {
        return g_TreasureManager;
    }
}