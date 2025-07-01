/**
 * GameMasterSimple.as
 * 
 * Simple standalone GameMaster implementation that includes all necessary
 * components in a single file for testing purposes.
 * This version should work without external dependencies.
 */

// Simple logging functions
void LogInfo(const string &in message)
{
    print("[INFO] " + message);
}

void LogError(const string &in message)
{
    print("[ERROR] " + message);
}

void LogWarning(const string &in message)
{
    print("[WARNING] " + message);
}

// Simple constants (from GameMasterData_simple.as)
const uint CONST_SPAWNS_PER_SET = 8;
const uint LIGHTSYS_N_LIGHTS = 16;
const uint MAX_DELAYED_NPC_SPAWNS = 4;
const uint DEFAULT_FADE_RATE = 10;
const float DEFAULT_GOLD_SPAWN_DISTANCE = 100.0f;
const float SAYTEXT_RANGE = 64000.0f;

namespace MS
{
    /**
     * Simple GameMaster class without complex dependencies
     */
    class GameMaster
    {
        // Core properties
        string m_szName;
        uint m_nSpawnTime;
        uint m_nMapUptime;
        
        // Entity tracking
        EntityHandle m_hSelf;
        
        GameMaster()
        {
            m_szName = "The Game Master";
            m_nSpawnTime = 0;
            m_nMapUptime = 0;
            
            LogInfo("GameMaster instance created");
        }
        
        /**
         * Called when the game master entity spawns in the world
         */
        void Spawn()
        {
            LogInfo("***************** Game_Master - Spawned");
        }
        
        /**
         * Called when a player connects to the server
         */
        void OnPlayerConnect(const string &in szPlayerName)
        {
            LogInfo("GameMaster: Player connected - " + szPlayerName);
        }
        
        /**
         * Called when a player disconnects from the server
         */
        void OnPlayerDisconnect(const string &in szPlayerName)
        {
            LogInfo("GameMaster: Player disconnected - " + szPlayerName);
        }
        
        /**
         * Called when a monster is killed
         */
        void OnMonsterKilled(const string &in szMonsterName, const string &in szKillerName)
        {
            LogInfo("GameMaster: Monster killed - " + szMonsterName + " by " + szKillerName);
        }
        
        /**
         * Called when treasure is spawned
         */
        void OnTreasureSpawned(const string &in szTreasureType)
        {
            LogInfo("GameMaster: Treasure spawned - " + szTreasureType);
        }
        
        /**
         * Handles gold spew effects
         */
        void GoldSpew(float flGoldPerBag, uint nBagsPerPlayer, float flDistance, 
                     uint nMinBags, uint nMaxBags, const Vector3 &in vecPosition)
        {
            LogInfo("GameMaster: Gold spew triggered at position " + vecPosition.x + ", " + vecPosition.y + ", " + vecPosition.z);
        }
        
        /**
         * Creates an NPC with a delay
         */
        void DelayedCreateNPC(uint nNPCIndex, float flDelay, const string &in szScript, const Vector3 &in vecPosition, const Vector3 &in vecAngles)
        {
            LogInfo("GameMaster: Delayed NPC creation requested - " + szScript);
        }
        
        /**
         * Fades an entity
         */
        void FadeEntity(EntityHandle hTarget, int nRenderMode = 5, uint nStartAmount = 255)
        {
            LogInfo("GameMaster: Entity fade requested");
        }
    }
    
    // Global GameMaster instance
    GameMaster@ g_pGameMaster = null;
    
    /**
     * Initialize the GameMaster system
     */
    void InitializeGameMaster()
    {
        LogInfo("Initializing simple GameMaster system...");
        
        // Check if already initialized
        if (g_pGameMaster !is null)
        {
            LogWarning("GameMaster already initialized, destroying previous instance");
            @g_pGameMaster = null;
        }
        
        // Create new GameMaster instance
        @g_pGameMaster = GameMaster();
        
        if (g_pGameMaster !is null)
        {
            g_pGameMaster.Spawn();
            LogInfo("Simple GameMaster system initialized successfully");
        }
        else
        {
            LogError("Failed to create GameMaster instance!");
        }
    }
    
    /**
     * Shutdown the GameMaster system
     */
    void ShutdownGameMaster()
    {
        LogInfo("Shutting down simple GameMaster system...");
        
        if (g_pGameMaster !is null)
        {
            @g_pGameMaster = null;
            LogInfo("Simple GameMaster system shut down successfully");
        }
        else
        {
            LogWarning("GameMaster was not initialized");
        }
    }
    
    /**
     * Get the global GameMaster instance
     */
    GameMaster@ GetGameMasterInstance()
    {
        return g_pGameMaster;
    }
    
    /**
     * Check if GameMaster is initialized
     * Moved to avoid conflicts with engine registration
     */
    bool GameMasterUtils_IsInitialized()
    {
        return g_pGameMaster !is null;
    }
    
    // Test function to verify the system works
    void TestGameMaster()
    {
        LogInfo("Testing simple GameMaster system...");
        
        if (g_pGameMaster !is null)
        {
            g_pGameMaster.OnPlayerConnect("TestPlayer");
            g_pGameMaster.OnMonsterKilled("TestOrc", "TestPlayer");
            g_pGameMaster.OnTreasureSpawned("gold_chest");
            g_pGameMaster.GoldSpew(50.0f, 3, 150.0f, 5, 15, Vector3(100, 200, 300));
            g_pGameMaster.DelayedCreateNPC(1, 5.0f, "test_monster", Vector3(0, 0, 0), Vector3(0, 0, 0));
            g_pGameMaster.OnPlayerDisconnect("TestPlayer");
            
            LogInfo("GameMaster test completed successfully");
        }
        else
        {
            LogError("Cannot test GameMaster - not initialized");
        }
    }
}

// ========================================
// Global Functions for Engine Integration
// ========================================

/**
 * Called by the engine when the map starts
 */
void game_master_init()
{
    MS::InitializeGameMaster();
}

/**
 * Called by the engine when the map ends
 */
void game_master_shutdown()
{
    MS::ShutdownGameMaster();
}

/**
 * Legacy compatibility function
 */
void game_spawn()
{
    MS::InitializeGameMaster();
}

/**
 * Test function that can be called from console or other scripts
 */
void test_gamemaster()
{
    MS::TestGameMaster();
}