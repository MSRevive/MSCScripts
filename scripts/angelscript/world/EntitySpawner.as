/**
 * EntitySpawner.as
 * 
 * NPC and monster spawning system for Master Sword Rebirth
 * Handles entity lifecycle management, spawn scheduling, and dynamic spawning
 * 
 * Converted from game_master.script NPC spawning logic
 */

namespace MS
{
    // Stub implementations for missing entity functions
    // These are placeholder implementations until proper entity system is connected
    
    /**
     * Check if entity handle is valid (stub implementation)
     */
    bool IsValidEntity(EntityHandle hEntity)
    {
        // Placeholder implementation - in real system would check handle validity
        return true;  // Assume all handles are valid for now
    }
    
    /**
     * Create an entity (stub implementation)
     */
    EntityHandle CreateEntity(const string &in szScript, float fPosX, float fPosY, float fPosZ, float fAngX, float fAngY, float fAngZ)
    {
        MS_ANGEL_INFO("CreateEntity stub called: " + szScript + " at (" + fPosX + "," + fPosY + "," + fPosZ + ")");
        return EntityHandle(); // Return invalid handle for now
    }
    
    /**
     * Set entity name (stub implementation)
     */
    void SetEntityName(EntityHandle hEntity, const string &in szName)
    {
        MS_ANGEL_INFO("SetEntityName stub called: " + szName);
    }
    
    /**
     * Set entity target name (stub implementation)
     */
    void SetEntityTargetName(EntityHandle hEntity, const string &in szTargetName)
    {
        MS_ANGEL_INFO("SetEntityTargetName stub called: " + szTargetName);
    }
    
    /**
     * Set entity health (stub implementation)
     */
    void SetEntityHealth(EntityHandle hEntity, float flHealth)
    {
        MS_ANGEL_INFO("SetEntityHealth stub called: " + flHealth);
    }
    
    /**
     * Check if entity is dead (stub implementation)
     * Moved to avoid conflicts with engine registration
     */
    bool EntitySpawner_IsEntityDead(EntityHandle hEntity)
    {
        MS_ANGEL_DEBUG("EntitySpawner_IsEntityDead stub called - returning false");
        return false; // Return false for now (entity is alive)
    }
    
    /**
     * Spawn data for delayed entity creation
     */
    class EntitySpawnData
    {
        string szScript;              // Script to spawn (e.g., "monsters/orc")
        float fPositionX;             // Spawn position X
        float fPositionY;             // Spawn position Y
        float fPositionZ;             // Spawn position Z
        float fAnglesX;               // Spawn angles X
        float fAnglesY;               // Spawn angles Y
        float fAnglesZ;               // Spawn angles Z
        string szName;                // Entity name (optional)
        string szTargetName;          // Target name for entity (optional)
        float flHealth;               // Override health (-1 = default)
        uint nMaxCount;               // Maximum entities of this type
        float flRespawnDelay;         // Respawn delay in seconds
        bool bRespawn;                // Whether this entity should respawn
        
        EntitySpawnData()
        {
            szScript = "";
            fPositionX = 0.0f;
            fPositionY = 0.0f;
            fPositionZ = 0.0f;
            fAnglesX = 0.0f;
            fAnglesY = 0.0f;
            fAnglesZ = 0.0f;
            szName = "";
            szTargetName = "";
            flHealth = -1.0f;
            nMaxCount = 1;
            flRespawnDelay = 60.0f;
            bRespawn = false;
        }
    }
    
    /**
     * Spawn slot for managing delayed spawns
     */
    class SpawnSlot
    {
        bool bActive;                 // Whether this slot is in use
        float flSpawnTime;            // Time when entity should spawn
        EntitySpawnData SpawnData;    // Data for the entity to spawn
        EntityHandle hSpawnedEntity;  // Handle to spawned entity (for tracking)
        uint nSpawnedCount;           // How many times this has spawned
        
        SpawnSlot()
        {
            bActive = false;
            flSpawnTime = 0.0f;
            SpawnData = EntitySpawnData();
            hSpawnedEntity = EntityHandle();
            nSpawnedCount = 0;
        }
    }
    
    /**
     * Spawn group for managing multiple related entities
     */
    class SpawnGroup
    {
        string szGroupName;           // Name of this spawn group
        array<EntitySpawnData> Entities; // Entities in this group
        array<EntityHandle> SpawnedEntities; // Currently spawned entities
        float flGroupSpawnDelay;      // Delay between entity spawns in group
        bool bSpawnSequentially;      // Spawn all at once or sequentially
        bool bAllMustDie;             // All must die before respawn
        uint nMaxActive;              // Maximum active entities from this group
        
        SpawnGroup()
        {
            szGroupName = "";
            Entities.resize(0);
            SpawnedEntities.resize(0);
            flGroupSpawnDelay = 1.0f;
            bSpawnSequentially = false;
            bAllMustDie = false;
            nMaxActive = 10;
        }
    }
    
    /**
     * Entity Spawner system class
     */
    class EntitySpawner
    {
        // Configuration constants (not const in AngelScript classes)
        uint MAX_SPAWN_SLOTS = 16;
        uint MAX_SPAWN_GROUPS = 8;
        
        // Spawn slot management
        array<SpawnSlot> m_SpawnSlots;
        uint m_nActiveSlots;
        
        // Spawn group management
        array<SpawnGroup> m_SpawnGroups;
        uint m_nActiveGroups;
        
        // System state
        bool m_bInitialized;
        bool m_bSpawningEnabled;
        float m_flLastUpdateTime;
        
        // Statistics
        uint m_nTotalSpawned;
        uint m_nCurrentlyAlive;
        /**
         * Constructor - Initialize the entity spawner
         */
        EntitySpawner()
        {
            m_bInitialized = false;
            m_bSpawningEnabled = true;
            m_nActiveSlots = 0;
            m_nActiveGroups = 0;
            m_flLastUpdateTime = GetGameTime();
            m_nTotalSpawned = 0;
            m_nCurrentlyAlive = 0;
            
            InitializeSpawner();
        }
        
        /**
         * Initialize the spawner system
         */
        void InitializeSpawner()
        {
            MS_ANGEL_INFO("EntitySpawner: Initializing with " + MAX_SPAWN_SLOTS + " slots and " + MAX_SPAWN_GROUPS + " groups");
            
            // Initialize spawn slots
            m_SpawnSlots.resize(MAX_SPAWN_SLOTS);
            for (uint i = 0; i < MAX_SPAWN_SLOTS; i++)
            {
                m_SpawnSlots[i] = SpawnSlot();
            }
            
            // Initialize spawn groups
            m_SpawnGroups.resize(MAX_SPAWN_GROUPS);
            for (uint i = 0; i < MAX_SPAWN_GROUPS; i++)
            {
                SpawnGroup newGroup;
                m_SpawnGroups[i] = newGroup;
            }
            
            m_bInitialized = true;
            MS_ANGEL_INFO("EntitySpawner: Initialized successfully");
        }
        
        /**
         * Schedule a delayed entity spawn
         * @param flDelay Delay in seconds before spawning
         * @param SpawnData Entity spawn data
         * @return Spawn slot index, or -1 if no slots available
         */
        int ScheduleDelayedSpawn(float flDelay, const EntitySpawnData &in SpawnData)
        {
            if (!m_bInitialized || !m_bSpawningEnabled)
            {
                MS_ANGEL_ERROR("EntitySpawner: Cannot schedule spawn - system not ready");
                return -1;
            }
            
            // Find available spawn slot
            for (uint i = 0; i < MAX_SPAWN_SLOTS; i++)
            {
                if (!m_SpawnSlots[i].bActive)
                {
                    m_SpawnSlots[i].bActive = true;
                    m_SpawnSlots[i].flSpawnTime = GetGameTime() + flDelay;
                    m_SpawnSlots[i].SpawnData = SpawnData;
                    m_SpawnSlots[i].nSpawnedCount = 0;
                    m_nActiveSlots++;
                    
                    MS_ANGEL_INFO("EntitySpawner: Scheduled " + SpawnData.szScript + " to spawn in " + 
                           flDelay + " seconds (slot " + i + ")");
                    
                    return int(i);
                }
            }
            
            MS_ANGEL_ERROR("EntitySpawner: No available spawn slots (all " + MAX_SPAWN_SLOTS + " in use)");
            return -1;
        }
        
        /**
         * Spawn an entity immediately
         * @param SpawnData Entity spawn data
         * @return Handle to spawned entity, or invalid handle if failed
         */
        EntityHandle SpawnEntityImmediate(const EntitySpawnData &in SpawnData)
        {
            if (!m_bSpawningEnabled)
            {
                MS_ANGEL_ERROR("EntitySpawner: Spawning is disabled");
                return EntityHandle();
            }
            
            MS_ANGEL_INFO("EntitySpawner: Spawning " + SpawnData.szScript + " at " + 
                   SpawnData.fPositionX + "," + SpawnData.fPositionY + "," + SpawnData.fPositionZ);
            
            // Create the entity (this would call the actual engine spawn function)
            EntityHandle hEntity = CreateEntity(SpawnData.szScript, SpawnData.fPositionX, SpawnData.fPositionY, SpawnData.fPositionZ, SpawnData.fAnglesX, SpawnData.fAnglesY, SpawnData.fAnglesZ);
            
            if (IsValidEntity(hEntity))
            {
                // Set entity properties
                if (SpawnData.szName.length() > 0)
                {
                    SetEntityName(hEntity, SpawnData.szName);
                }
                
                if (SpawnData.szTargetName.length() > 0)
                {
                    SetEntityTargetName(hEntity, SpawnData.szTargetName);
                }
                
                if (SpawnData.flHealth > 0.0f)
                {
                    SetEntityHealth(hEntity, SpawnData.flHealth);
                }
                
                m_nTotalSpawned++;
                m_nCurrentlyAlive++;
                
                MS_ANGEL_INFO("EntitySpawner: Successfully spawned " + SpawnData.szScript + " (Total: " + m_nTotalSpawned + ")");
            }
            else
            {
                MS_ANGEL_ERROR("EntitySpawner: Failed to spawn " + SpawnData.szScript);
            }
            
            return hEntity;
        }
        
        /**
         * Create a spawn group
         * @param szGroupName Name for the spawn group
         * @return Group index, or -1 if no groups available
         */
        int CreateSpawnGroup(const string &in szGroupName)
        {
            // Find available group slot
            for (uint i = 0; i < MAX_SPAWN_GROUPS; i++)
            {
                if (m_SpawnGroups[i].szGroupName.length() == 0)
                {
                    m_SpawnGroups[i].szGroupName = szGroupName;
                    m_SpawnGroups[i].Entities.resize(0);
                    m_SpawnGroups[i].SpawnedEntities.resize(0);
                    m_nActiveGroups++;
                    
                    MS_ANGEL_INFO("EntitySpawner: Created spawn group '" + szGroupName + "' (index " + i + ")");
                    return int(i);
                }
            }
            
            MS_ANGEL_ERROR("EntitySpawner: No available spawn group slots");
            return -1;
        }
        
        /**
         * Add entity to spawn group
         * @param nGroupIndex Group index
         * @param SpawnData Entity to add
         */
        void AddEntityToGroup(int nGroupIndex, const EntitySpawnData &in SpawnData)
        {
            if (nGroupIndex < 0 || nGroupIndex >= int(MAX_SPAWN_GROUPS))
            {
                MS_ANGEL_ERROR("EntitySpawner: Invalid group index " + nGroupIndex);
                return;
            }
            
            if (m_SpawnGroups[nGroupIndex].szGroupName.length() == 0)
            {
                MS_ANGEL_ERROR("EntitySpawner: Group " + nGroupIndex + " is not active");
                return;
            }
            
            m_SpawnGroups[nGroupIndex].Entities.insertLast(SpawnData);
            MS_ANGEL_INFO("EntitySpawner: Added " + SpawnData.szScript + " to group '" + 
                   m_SpawnGroups[nGroupIndex].szGroupName + "'");
        }
        
        /**
         * Spawn all entities in a group
         * @param nGroupIndex Group index
         * @param flDelay Delay between spawns if sequential
         */
        void SpawnGroup(int nGroupIndex, float flDelay = 0.0f)
        {
            if (nGroupIndex < 0 || nGroupIndex >= int(MAX_SPAWN_GROUPS))
            {
                MS_ANGEL_ERROR("EntitySpawner: Invalid group index " + nGroupIndex);
                return;
            }
            
            SpawnGroup@ group = @m_SpawnGroups[nGroupIndex];
            if (group.szGroupName.length() == 0)
            {
                MS_ANGEL_ERROR("EntitySpawner: Group " + nGroupIndex + " is not active");
                return;
            }
            
            MS_ANGEL_INFO("EntitySpawner: Spawning group '" + group.szGroupName + "' (" + 
                   group.Entities.length() + " entities)");
            
            for (uint i = 0; i < group.Entities.length(); i++)
            {
                if (group.bSpawnSequentially && i > 0)
                {
                    // Schedule delayed spawn for sequential spawning
                    ScheduleDelayedSpawn(flDelay * i, group.Entities[i]);
                }
                else
                {
                    // Spawn immediately
                    EntityHandle hEntity = SpawnEntityImmediate(group.Entities[i]);
                    if (IsValidEntity(hEntity))
                    {
                        group.SpawnedEntities.insertLast(hEntity);
                    }
                }
            }
        }
        
        /**
         * Update the spawner system (call periodically)
         * @param flDeltaTime Time since last update
         */
        void Update(float flDeltaTime)
        {
            if (!m_bInitialized)
                return;
                
            float flCurrentTime = GetGameTime();
            
            // Process delayed spawns
            for (uint i = 0; i < MAX_SPAWN_SLOTS; i++)
            {
                if (m_SpawnSlots[i].bActive && flCurrentTime >= m_SpawnSlots[i].flSpawnTime)
                {
                    // Time to spawn this entity
                    EntityHandle hEntity = SpawnEntityImmediate(m_SpawnSlots[i].SpawnData);
                    
                    if (IsValidEntity(hEntity))
                    {
                        m_SpawnSlots[i].hSpawnedEntity = hEntity;
                        m_SpawnSlots[i].nSpawnedCount++;
                        
                        // Check if this is a respawning entity
                        if (m_SpawnSlots[i].SpawnData.bRespawn)
                        {
                            // Keep slot active for respawn tracking
                            MS_ANGEL_DEBUG("EntitySpawner: Respawning entity will be tracked for respawn");
                        }
                        else
                        {
                            // Clear the slot
                            m_SpawnSlots[i] = SpawnSlot();
                            m_nActiveSlots--;
                        }
                    }
                    else
                    {
                        MS_ANGEL_ERROR("EntitySpawner: Failed to spawn scheduled entity " + 
                                m_SpawnSlots[i].SpawnData.szScript);
                        // Clear failed slot
                        m_SpawnSlots[i] = SpawnSlot();
                        m_nActiveSlots--;
                    }
                }
            }
            
            // Process respawn tracking
            ProcessRespawnTracking();
            
            // Clean up dead entity handles in groups
            CleanupSpawnGroups();
            
            m_flLastUpdateTime = flCurrentTime;
        }
        
        /**
         * Process respawn tracking for entities that should respawn
         */
        void ProcessRespawnTracking()
        {
            for (uint i = 0; i < MAX_SPAWN_SLOTS; i++)
            {
                if (m_SpawnSlots[i].bActive && m_SpawnSlots[i].SpawnData.bRespawn)
                {
                    // Check if the spawned entity is still alive
                    if (IsValidEntity(m_SpawnSlots[i].hSpawnedEntity))
                    {
                        if (EntitySpawner_IsEntityDead(m_SpawnSlots[i].hSpawnedEntity))
                        {
                            // Entity died, schedule respawn
                            m_SpawnSlots[i].flSpawnTime = GetGameTime() + m_SpawnSlots[i].SpawnData.flRespawnDelay;
                            m_SpawnSlots[i].hSpawnedEntity = EntityHandle(); // Clear dead handle
                            m_nCurrentlyAlive--;
                            
                            MS_ANGEL_INFO("EntitySpawner: Entity " + m_SpawnSlots[i].SpawnData.szScript + 
                                   " died, respawning in " + m_SpawnSlots[i].SpawnData.flRespawnDelay + " seconds");
                        }
                    }
                    else if (IsValidEntity(m_SpawnSlots[i].hSpawnedEntity))
                    {
                        // Entity was removed/deleted, schedule respawn
                        m_SpawnSlots[i].flSpawnTime = GetGameTime() + m_SpawnSlots[i].SpawnData.flRespawnDelay;
                        m_SpawnSlots[i].hSpawnedEntity = EntityHandle();
                        m_nCurrentlyAlive--;
                        
                        MS_ANGEL_INFO("EntitySpawner: Entity " + m_SpawnSlots[i].SpawnData.szScript + 
                               " was removed, respawning in " + m_SpawnSlots[i].SpawnData.flRespawnDelay + " seconds");
                    }
                }
            }
        }
        
        /**
         * Clean up dead entity handles in spawn groups
         */
        void CleanupSpawnGroups()
        {
            for (uint i = 0; i < MAX_SPAWN_GROUPS; i++)
            {
                if (m_SpawnGroups[i].szGroupName.length() > 0)
                {
                    // Remove dead/invalid entities from the spawned list
                    for (int j = int(m_SpawnGroups[i].SpawnedEntities.length()) - 1; j >= 0; j--)
                    {
                        if (!IsValidEntity(m_SpawnGroups[i].SpawnedEntities[j]) || 
                            EntitySpawner_IsEntityDead(m_SpawnGroups[i].SpawnedEntities[j]))
                        {
                            m_SpawnGroups[i].SpawnedEntities.removeAt(j);
                            m_nCurrentlyAlive--;
                        }
                    }
                }
            }
        }
        
        /**
         * Cancel a scheduled spawn
         * @param nSlot Spawn slot to cancel
         */
        void CancelScheduledSpawn(int nSlot)
        {
            if (nSlot < 0 || nSlot >= int(MAX_SPAWN_SLOTS))
            {
                MS_ANGEL_ERROR("EntitySpawner: Invalid spawn slot " + nSlot);
                return;
            }
            
            if (m_SpawnSlots[nSlot].bActive)
            {
                MS_ANGEL_INFO("EntitySpawner: Cancelled scheduled spawn " + m_SpawnSlots[nSlot].SpawnData.szScript);
                m_SpawnSlots[nSlot] = SpawnSlot();
                m_nActiveSlots--;
            }
        }
        
        /**
         * Enable or disable spawning
         */
        void SetSpawningEnabled(bool bEnabled)
        {
            m_bSpawningEnabled = bEnabled;
            MS_ANGEL_INFO("EntitySpawner: Spawning " + (bEnabled ? "enabled" : "disabled"));
        }
        
        /**
         * Get spawner statistics
         */
        uint GetTotalSpawned() const { return m_nTotalSpawned; }
        uint GetCurrentlyAlive() const { return m_nCurrentlyAlive; }
        uint GetActiveSlots() const { return m_nActiveSlots; }
        uint GetActiveGroups() const { return m_nActiveGroups; }
        
        /**
         * Debug function to dump spawner state
         */
        void DumpSpawnerInfo()
        {
            MS_ANGEL_INFO("EntitySpawner: Status - " + m_nActiveSlots + "/" + MAX_SPAWN_SLOTS + 
                   " active slots, " + m_nCurrentlyAlive + " entities alive");
            MS_ANGEL_INFO("EntitySpawner: Total spawned: " + m_nTotalSpawned + ", Active groups: " + m_nActiveGroups);
            
            for (uint i = 0; i < MAX_SPAWN_SLOTS; i++)
            {
                if (m_SpawnSlots[i].bActive)
                {
                    float timeLeft = m_SpawnSlots[i].flSpawnTime - GetGameTime();
                    MS_ANGEL_INFO("  Slot " + i + ": " + m_SpawnSlots[i].SpawnData.szScript + 
                           " (spawn in " + timeLeft + "s, count: " + m_SpawnSlots[i].nSpawnedCount + ")");
                }
            }
        }
    }
    
    // Global entity spawner instance
    EntitySpawner@ g_EntitySpawner = null;
    
    /**
     * Initialize the entity spawner
     */
    void InitializeEntitySpawner()
    {
        if (g_EntitySpawner is null)
        {
            @g_EntitySpawner = EntitySpawner();
            MS_ANGEL_INFO("EntitySpawner: Global instance initialized successfully");
        }
        else
        {
            MS_ANGEL_ERROR("EntitySpawner: Already initialized");
        }
    }
    
    /**
     * Get the global entity spawner instance
     */
    EntitySpawner@ GetEntitySpawner()
    {
        if (g_EntitySpawner is null)
        {
            InitializeEntitySpawner();
        }
        return g_EntitySpawner;
    }
    
    /**
     * Shutdown the entity spawner
     */
    void ShutdownEntitySpawner()
    {
        if (g_EntitySpawner !is null)
        {
            MS_ANGEL_INFO("EntitySpawner: Shutting down");
            @g_EntitySpawner = null;
        }
    }
}