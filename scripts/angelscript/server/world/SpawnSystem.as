#pragma context server

/**
 * SpawnSystem.as
 * 
 * Manages player spawn points and respawn logic. Converted from spawn point
 * management functions in game_master.script (lines 692-875).
 * 
 * Key Features:
 * - Segmented spawn point storage (9 arrays of 8 points each)
 * - Random spawn point selection
 * - Admin spawn point management
 * - Developer spawn testing commands
 */

namespace MS
{
    /**
     * Spawn point management system
     */
    class SpawnSystem
    {
    private:
        // Constants
        const uint SPAWNS_PER_SET = 8;  // CONST_SPAWNS_PER_SET from original
        const uint MAX_SPAWN_SETS = 9;  // Total number of spawn point arrays
        
        // Spawn point storage (segmented arrays like original)
        array<Vector3> m_SpawnPoints1;
        array<Vector3> m_SpawnPoints2;
        array<Vector3> m_SpawnPoints3;
        array<Vector3> m_SpawnPoints4;
        array<Vector3> m_SpawnPoints5;
        array<Vector3> m_SpawnPoints6;
        array<Vector3> m_SpawnPoints7;
        array<Vector3> m_SpawnPoints8;
        array<Vector3> m_SpawnPoints9;
        
        // Tracking
        uint m_nSpawnPoints = 0;  // N_SPAWN_POINTS from original
        Vector3 m_vLastSpawnPoint;  // GM_SPAWN_POINT from original
        
        // Developer commands
        EntityHandle m_hDevTarget;
        
    public:
        SpawnSystem()
        {
            // Initialize all spawn point arrays
            InitializeSpawnArrays();
        }
        
        /**
         * Initialize the spawn system
         */
        void Initialize()
        {
            InitializeSpawnArrays();
            LogMessage("[INFO] SpawnSystem initialized successfully");
        }
        
        /**
         * Shutdown the spawn system
         */
        void Shutdown()
        {
            ClearAllSpawnPoints();
            LogMessage("[INFO] SpawnSystem shutdown completed");
        }
        
        /**
         * Add a spawn point to the system
         * Converted from set_spawn_point function
         */
        bool AddSpawnPoint(const Vector3 &in origin)
        {
            if (m_nSpawnPoints == 0)
            {
                InitializeSpawnArrays();
            }
            
            LogMessage("[INFO] Adding spawn point #" + m_nSpawnPoints + " at " + origin.ToString());
            
            // Determine which array to add to based on current count
            uint spawnsPerSet = SPAWNS_PER_SET;
            uint nextSpawnSet = SPAWNS_PER_SET;
            
            // Set 1 (0-7)
            if (m_nSpawnPoints <= spawnsPerSet)
            {
                if (m_nSpawnPoints <= nextSpawnSet)
                {
                    m_SpawnPoints1.insertLast(origin);
                    m_nSpawnPoints++;
                    return true;
                }
            }
            
            // Set 2 (8-15)
            nextSpawnSet += SPAWNS_PER_SET;
            if (m_nSpawnPoints > spawnsPerSet && m_nSpawnPoints <= nextSpawnSet)
            {
                m_SpawnPoints2.insertLast(origin);
                m_nSpawnPoints++;
                return true;
            }
            
            // Set 3 (16-23)
            spawnsPerSet += SPAWNS_PER_SET;
            nextSpawnSet += SPAWNS_PER_SET;
            if (m_nSpawnPoints > spawnsPerSet && m_nSpawnPoints <= nextSpawnSet)
            {
                m_SpawnPoints3.insertLast(origin);
                m_nSpawnPoints++;
                return true;
            }
            
            // Set 4 (24-31)
            spawnsPerSet += SPAWNS_PER_SET;
            nextSpawnSet += SPAWNS_PER_SET;
            if (m_nSpawnPoints > spawnsPerSet && m_nSpawnPoints <= nextSpawnSet)
            {
                m_SpawnPoints4.insertLast(origin);
                m_nSpawnPoints++;
                return true;
            }
            
            // Set 5 (32-39)
            spawnsPerSet += SPAWNS_PER_SET;
            nextSpawnSet += SPAWNS_PER_SET;
            if (m_nSpawnPoints > spawnsPerSet && m_nSpawnPoints <= nextSpawnSet)
            {
                m_SpawnPoints5.insertLast(origin);
                m_nSpawnPoints++;
                return true;
            }
            
            // Set 6 (40-47)
            spawnsPerSet += SPAWNS_PER_SET;
            nextSpawnSet += SPAWNS_PER_SET;
            if (m_nSpawnPoints > spawnsPerSet && m_nSpawnPoints <= nextSpawnSet)
            {
                m_SpawnPoints6.insertLast(origin);
                m_nSpawnPoints++;
                return true;
            }
            
            // Set 7 (48-55)
            spawnsPerSet += SPAWNS_PER_SET;
            nextSpawnSet += SPAWNS_PER_SET;
            if (m_nSpawnPoints > spawnsPerSet && m_nSpawnPoints <= nextSpawnSet)
            {
                m_SpawnPoints7.insertLast(origin);
                m_nSpawnPoints++;
                return true;
            }
            
            // Set 8 (56-63)
            spawnsPerSet += SPAWNS_PER_SET;
            nextSpawnSet += SPAWNS_PER_SET;
            if (m_nSpawnPoints > spawnsPerSet && m_nSpawnPoints <= nextSpawnSet)
            {
                m_SpawnPoints8.insertLast(origin);
                m_nSpawnPoints++;
                return true;
            }
            
            // Set 9 (64-71)
            spawnsPerSet += SPAWNS_PER_SET;
            nextSpawnSet += SPAWNS_PER_SET;
            if (m_nSpawnPoints > spawnsPerSet && m_nSpawnPoints <= nextSpawnSet)
            {
                m_SpawnPoints9.insertLast(origin);
                m_nSpawnPoints++;
                return true;
            }
            
            LogMessage("[ERROR] Maximum spawn points reached (72 points max)");
            return false;
        }
        
        /**
         * Find and teleport player to random spawn point
         * Converted from find_spawn_point function
         */
        bool TeleportToSpawnPoint(CBasePlayer@ pPlayer)
        {
            if (pPlayer is null || m_nSpawnPoints == 0)
            {
                return false;
            }
            
            Vector3 spawnPoint = GetRandomSpawnPoint();
            if (spawnPoint == Vector3(0, 0, 0))
            {
                return false;
            }
            
            // Store the selected spawn point
            m_vLastSpawnPoint = spawnPoint;
            
            // Teleport the player (would need proper implementation)
            // For now, we'll use a placeholder call
            TeleportPlayer(pPlayer, spawnPoint);
            
            if (g_PlayerManager.IsDeveloperMode())
            {
                LogMessage("[INFO] Teleported " + string(pPlayer.pev.netname) + " to spawn point: " + spawnPoint.ToString());
            }
            
            return true;
        }
        
        /**
         * Get a random spawn point
         * Core logic from find_spawn_point
         */
        Vector3 GetRandomSpawnPoint()
        {
            if (m_nSpawnPoints == 0)
            {
                return Vector3(0, 0, 0);
            }
            
            // Get random point index (0 to N_SPAWN_POINTS-1)
            uint maxIndex = m_nSpawnPoints - 1;
            uint rndPoint = Random(0, maxIndex);
            uint originalPoint = rndPoint;
            uint rndPointSetIdx = rndPoint;
            
            // Calculate which set and index within set
            if (rndPoint >= SPAWNS_PER_SET)
            {
                rndPointSetIdx = rndPoint / SPAWNS_PER_SET;
                uint multiIdx = rndPointSetIdx * SPAWNS_PER_SET;
                rndPoint = rndPoint - multiIdx;
            }
            else
            {
                rndPointSetIdx = 0;
            }
            
            // Get spawn point from appropriate array
            Vector3 spawnPoint = GetSpawnPointFromSet(rndPointSetIdx, rndPoint);
            
            if (g_PlayerManager.IsDeveloperMode())
            {
                LogMessage("[INFO] Selected spawn point #" + originalPoint + " (set " + rndPointSetIdx + ", index " + rndPoint + "): " + spawnPoint.ToString());
            }
            
            return spawnPoint;
        }
        
        /**
         * Test spawn to specific point (admin command)
         * Converted from dev_test_spawn
         */
        bool TestSpawnPoint(CBasePlayer@ pPlayer, uint pointIndex)
        {
            if (pPlayer is null || m_nSpawnPoints == 0 || pointIndex >= m_nSpawnPoints)
            {
                return false;
            }
            
            uint rndPoint = pointIndex;
            uint originalPoint = rndPoint;
            uint rndPointSetIdx = rndPoint;
            
            // Calculate which set and index within set
            if (rndPoint >= SPAWNS_PER_SET)
            {
                rndPointSetIdx = rndPoint / SPAWNS_PER_SET;
                uint multiIdx = rndPointSetIdx * SPAWNS_PER_SET;
                rndPoint = rndPoint - multiIdx;
            }
            else
            {
                rndPointSetIdx = 0;
            }
            
            Vector3 spawnPoint = GetSpawnPointFromSet(rndPointSetIdx, rndPoint);
            
            if (spawnPoint != Vector3(0, 0, 0))
            {
                TeleportPlayer(pPlayer, spawnPoint);
                
                if (g_PlayerManager.IsDeveloperMode())
                {
                    LogMessage("[INFO] Test spawn #" + originalPoint + " (set " + rndPointSetIdx + ", index " + rndPoint + "): " + spawnPoint.ToString());
                }
                
                return true;
            }
            
            return false;
        }
        
        /**
         * List all spawn points (admin command)
         * Converted from dev_cat_points
         */
        void ListSpawnPoints(CBasePlayer@ pAdmin)
        {
            if (pAdmin is null) return;
            
            LogMessage("[INFO] Total spawn points: " + m_nSpawnPoints);
            LogMessage("[INFO] Listing spawn points for admin: " + string(pAdmin.pev.netname));
            
            // List points from each set
            for (uint i = 0; i < m_nSpawnPoints; i++)
            {
                uint setIdx = i / SPAWNS_PER_SET;
                uint pointIdx = i % SPAWNS_PER_SET;
                
                Vector3 point = GetSpawnPointFromSet(setIdx, pointIdx);
                
                string msg = "Point #" + i + " (set " + setIdx + ", index " + pointIdx + "): " + point.ToString();
                LogMessage("[INFO] " + msg);
                
                // Send message to admin (would need proper implementation)
                // SendMessageToPlayer(pAdmin, msg);
            }
        }
        
        /**
         * Get total number of spawn points
         */
        uint GetSpawnPointCount() const
        {
            return m_nSpawnPoints;
        }
        
        /**
         * Get last used spawn point
         */
        Vector3 GetLastSpawnPoint() const
        {
            return m_vLastSpawnPoint;
        }
        
        /**
         * Clear all spawn points
         */
        void ClearAllSpawnPoints()
        {
            m_SpawnPoints1.resize(0);
            m_SpawnPoints2.resize(0);
            m_SpawnPoints3.resize(0);
            m_SpawnPoints4.resize(0);
            m_SpawnPoints5.resize(0);
            m_SpawnPoints6.resize(0);
            m_SpawnPoints7.resize(0);
            m_SpawnPoints8.resize(0);
            m_SpawnPoints9.resize(0);
            
            m_nSpawnPoints = 0;
            m_vLastSpawnPoint = Vector3(0, 0, 0);
            
            LogMessage("[INFO] All spawn points cleared");
        }
        
        /**
         * Register treasure spawn points based on player spawn points
         * Creates treasure spawn points near player spawn areas
         */
        void RegisterTreasureSpawns()
        {
            if (m_nSpawnPoints == 0)
            {
                LogMessage("[WARNING] No player spawn points available for treasure spawn registration");
                return;
            }
            
            LogMessage("[INFO] Registering treasure spawn points based on player spawns...");
            
            uint treasureSpawnsAdded = 0;
            string currentMap = GetCurrentMapName();
            
            // Create treasure spawns near each player spawn point
            for (uint i = 0; i < m_nSpawnPoints; i++)
            {
                Vector3 playerSpawn = GetSpawnPointByIndex(i);
                if (playerSpawn == Vector3(0, 0, 0)) continue;
                
                // Create treasure spawns in a radius around the player spawn
                array<Vector3> treasurePositions = GenerateTreasurePositionsAroundSpawn(playerSpawn);
                
                for (uint j = 0; j < treasurePositions.length(); j++)
                {
                    uint difficulty = CalculateDifficultyForSpawn(i, treasurePositions[j]);
                    float respawnTime = 300.0f + (difficulty * 60.0f); // 5-15 minutes based on difficulty
                    
                    // Register with treasure manager
                    if (RegisterTreasureSpawnPoint(treasurePositions[j], currentMap, difficulty, respawnTime))
                    {
                        treasureSpawnsAdded++;
                    }
                }
            }
            
            LogMessage("[INFO] Registered " + treasureSpawnsAdded + " treasure spawn points based on " + 
                      m_nSpawnPoints + " player spawn points");
        }
        
        /**
         * Spawn treasures near a specific spawn point when player spawns
         */
        void SpawnTreasuresNearSpawnPoint(const Vector3 &in spawnPoint, CBasePlayer@ pPlayer)
        {
            if (pPlayer is null) return;
            
            // Generate random treasures in the area with chance based on map and time
            float treasureChance = 0.3f; // 30% chance base
            
            // Check if enough time has passed since last treasure generation in this area
            if (ShouldGenerateTreasureForArea(spawnPoint))
            {
                float rnd = Random(0, 100) / 100.0f;
                if (rnd < treasureChance)
                {
                    Vector3 treasurePos = GenerateRandomPositionNearSpawn(spawnPoint, 200.0f);
                    uint difficulty = 1; // Default difficulty for spawn area treasures
                    
                    if (GenerateTreasureAtLocation(treasurePos, difficulty, pPlayer))
                    {
                        LogMessage("[INFO] Generated spawn-area treasure for " + pPlayer.pev.netname + 
                                  " near " + spawnPoint.ToString());
                    }
                }
            }
        }
        
        /**
         * Get spawn point by index
         */
        Vector3 GetSpawnPointByIndex(uint index)
        {
            if (index >= m_nSpawnPoints) return Vector3(0, 0, 0);
            
            uint setIdx = index / SPAWNS_PER_SET;
            uint pointIdx = index % SPAWNS_PER_SET;
            
            return GetSpawnPointFromSet(setIdx, pointIdx);
        }
        
        /**
         * Get all spawn points as array
         */
        array<Vector3> GetAllSpawnPoints()
        {
            array<Vector3> allSpawns;
            
            for (uint i = 0; i < m_nSpawnPoints; i++)
            {
                Vector3 spawn = GetSpawnPointByIndex(i);
                if (spawn != Vector3(0, 0, 0))
                {
                    allSpawns.insertLast(spawn);
                }
            }
            
            return allSpawns;
        }
        
    private:
        /**
         * Initialize all spawn point arrays
         */
        void InitializeSpawnArrays()
        {
            if (m_nSpawnPoints == 0)
            {
                m_SpawnPoints1.resize(0);
                m_SpawnPoints2.resize(0);
                m_SpawnPoints3.resize(0);
                m_SpawnPoints4.resize(0);
                m_SpawnPoints5.resize(0);
                m_SpawnPoints6.resize(0);
                m_SpawnPoints7.resize(0);
                m_SpawnPoints8.resize(0);
                m_SpawnPoints9.resize(0);
            }
        }
        
        /**
         * Get spawn point from specific set and index
         */
        Vector3 GetSpawnPointFromSet(uint setIndex, uint pointIndex)
        {
            switch (setIndex)
            {
                case 0:
                    if (pointIndex < m_SpawnPoints1.length())
                        return m_SpawnPoints1[pointIndex];
                    break;
                case 1:
                    if (pointIndex < m_SpawnPoints2.length())
                        return m_SpawnPoints2[pointIndex];
                    break;
                case 2:
                    if (pointIndex < m_SpawnPoints3.length())
                        return m_SpawnPoints3[pointIndex];
                    break;
                case 3:
                    if (pointIndex < m_SpawnPoints4.length())
                        return m_SpawnPoints4[pointIndex];
                    break;
                case 4:
                    if (pointIndex < m_SpawnPoints5.length())
                        return m_SpawnPoints5[pointIndex];
                    break;
                case 5:
                    if (pointIndex < m_SpawnPoints6.length())
                        return m_SpawnPoints6[pointIndex];
                    break;
                case 6:
                    if (pointIndex < m_SpawnPoints7.length())
                        return m_SpawnPoints7[pointIndex];
                    break;
                case 7:
                    if (pointIndex < m_SpawnPoints8.length())
                        return m_SpawnPoints8[pointIndex];
                    break;
                case 8:
                    if (pointIndex < m_SpawnPoints9.length())
                        return m_SpawnPoints9[pointIndex];
                    break;
            }
            
            return Vector3(0, 0, 0);
        }
        
        /**
         * Teleport player to specified location
         * Placeholder for actual teleportation implementation
         */
        void TeleportPlayer(CBasePlayer@ pPlayer, const Vector3 &in destination)
        {
            if (pPlayer is null) return;
            
            // This would call the actual teleportation function
            // In the original: callexternal PARAM1 ext_send_tele_point GM_SPAWN_POINT
            // For now, we'll just log the action
            LogMessage("[INFO] Teleporting player " + string(pPlayer.pev.netname) + " to " + destination.ToString());
        }
        
        /**
         * Generate random number in range
         */
        uint Random(uint min, uint max)
        {
            if (min >= max) return min;
            // This would use proper random number generation
            // For now, placeholder implementation
            return min + (GetGameTime() % (max - min + 1));
        }
        
        /**
         * Get current game time for random seed
         */
        uint GetGameTime()
        {
            // Placeholder - would use actual game time
            return 12345;
        }
        
        /**
         * Generate treasure positions around a spawn point
         */
        array<Vector3> GenerateTreasurePositionsAroundSpawn(const Vector3 &in spawnPoint)
        {
            array<Vector3> positions;
            
            // Generate 2-4 treasure positions in a radius around the spawn
            uint numPositions = 2 + (Random(0, 2)); // 2-4 positions
            float radius = 150.0f + (Random(0, 100)); // 150-250 radius
            
            for (uint i = 0; i < numPositions; i++)
            {
                float angle = (float(i) / float(numPositions)) * 6.28318f; // 2*PI
                float distance = radius * (0.5f + (Random(0, 50) / 100.0f)); // 50-100% of radius
                
                Vector3 treasurePos = spawnPoint;
                treasurePos.x += cos(angle) * distance;
                treasurePos.y += sin(angle) * distance;
                treasurePos.z += Random(-10, 10); // Small Z variation
                
                positions.insertLast(treasurePos);
            }
            
            return positions;
        }
        
        /**
         * Calculate difficulty for a treasure spawn based on spawn index and position
         */
        uint CalculateDifficultyForSpawn(uint spawnIndex, const Vector3 &in position)
        {
            // Base difficulty on spawn point index (later spawns = higher difficulty)
            uint baseDifficulty = 1 + (spawnIndex / 8); // Every 8 spawns increases difficulty
            
            // Add random variation
            uint variation = Random(0, 2); // 0-2 variation
            
            return baseDifficulty + variation;
        }
        
        /**
         * Register treasure spawn point with treasure manager
         */
        bool RegisterTreasureSpawnPoint(const Vector3 &in position, const string &in mapName, 
                                       uint difficulty, float respawnTime)
        {
            // This would call the TreasureManager to register the spawn point
            // For now, simulate the registration
            LogMessage("[INFO] Registering treasure spawn: " + position.ToString() + 
                      " (difficulty: " + difficulty + ", respawn: " + respawnTime + "s)");
            
            // TODO: Call actual TreasureManager registration
            // MS::GetTreasureManager().RegisterSpawnPoint(position, mapName, difficulty, respawnTime);
            
            return true;
        }
        
        /**
         * Check if treasure should be generated for an area
         */
        bool ShouldGenerateTreasureForArea(const Vector3 &in spawnPoint)
        {
            // Simple time-based check - in real implementation would track per-area
            uint currentTime = GetGameTime();
            uint lastGenTime = currentTime - 300; // 5 minutes ago
            
            return (currentTime - lastGenTime) > 180; // 3 minutes minimum between generations
        }
        
        /**
         * Generate random position near spawn point
         */
        Vector3 GenerateRandomPositionNearSpawn(const Vector3 &in spawnPoint, float maxDistance)
        {
            float angle = (Random(0, 360) / 360.0f) * 6.28318f; // Random angle
            float distance = Random(50, uint(maxDistance)); // Random distance
            
            Vector3 newPos = spawnPoint;
            newPos.x += cos(angle) * distance;
            newPos.y += sin(angle) * distance;
            newPos.z += Random(-5, 5); // Small Z variation
            
            return newPos;
        }
        
        /**
         * Generate treasure at specific location
         */
        bool GenerateTreasureAtLocation(const Vector3 &in position, uint difficulty, CBasePlayer@ pPlayer)
        {
            // This would call the TreasureManager to generate treasure
            // For now, simulate the generation
            LogMessage("[INFO] Generating treasure at " + position.ToString() + 
                      " (difficulty: " + difficulty + ") for " + 
                      (pPlayer !is null ? pPlayer.pev.netname : "unknown"));
            
            // TODO: Call actual TreasureManager generation
            // return MS::GenerateTreasureForPlayer(pPlayer, position, difficulty);
            
            return true;
        }
        
        /**
         * Get current map name
         */
        string GetCurrentMapName()
        {
            // This would use actual map detection
            return "edana"; // Placeholder
        }
    };
    
    // Global spawn system instance
    SpawnSystem g_SpawnSystem;
}