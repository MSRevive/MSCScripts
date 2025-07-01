/**
 * GameMasterData.as
 * 
 * Data structures and constants used by the GameMaster system.
 * Contains all the global constants, enumerations, and data structures
 * that were previously defined as global variables in game_master.script.
 */

namespace MS
{
    // ========================================
    // Constants
    // ========================================
    
    /**
     * Number of spawn slots per set
     */
    const uint CONST_SPAWNS_PER_SET = 8;
    
    /**
     * Number of lights in the light system
     */
    const uint LIGHTSYS_N_LIGHTS = 16;
    
    /**
     * Maximum number of delayed NPC spawns
     */
    const uint MAX_DELAYED_NPC_SPAWNS = 4;
    
    /**
     * Default fade rate for entity fading
     */
    const uint DEFAULT_FADE_RATE = 10;
    
    /**
     * Default gold bag spawn distance
     */
    const float DEFAULT_GOLD_SPAWN_DISTANCE = 100.0f;
    
    /**
     * Chat log range for say text
     */
    const float SAYTEXT_RANGE = 64000.0f;
    
    // ========================================
    // Magic Hand Script Lists
    // ========================================
    
    /**
     * Get magic hand scripts - Group 1
     */
    array<string> GetMagicHandScripts1()
    {
        array<string> scripts;
        scripts.insertLast("magic_hand_acid_bolt");
        scripts.insertLast("magic_hand_blizzard");
        scripts.insertLast("magic_hand_div_glow");
        scripts.insertLast("magic_hand_div_rejuvenate");
        scripts.insertLast("magic_hand_fire_ball");
        scripts.insertLast("magic_hand_fire_dart");
        scripts.insertLast("magic_hand_fire_wall");
        scripts.insertLast("magic_hand_frost_bolt");
        scripts.insertLast("magic_hand_healing_circle");
        scripts.insertLast("magic_hand_ice_blast");
        scripts.insertLast("magic_hand_ice_shield");
        return scripts;
    }
    
    // Global arrays for compatibility with original script patterns
    const array<string> MAGIC_HAND_SCRIPTS1 = GetMagicHandScripts1();
    const array<string> MAGIC_HAND_NAMES1 = GetMagicHandNames1();
    
    /**
     * Get magic hand scripts - Group 2
     */
    array<string> GetMagicHandScripts2()
    {
        array<string> scripts;
        scripts.insertLast("magic_hand_ice_shield_lesser");
        scripts.insertLast("magic_hand_ice_wall");
        scripts.insertLast("magic_hand_lightning_chain");
        scripts.insertLast("magic_hand_lightning_storm");
        scripts.insertLast("magic_hand_lightning_weak");
        scripts.insertLast("magic_hand_poison");
        scripts.insertLast("magic_hand_poison_cloud");
        scripts.insertLast("magic_hand_summon_fangtooth");
        scripts.insertLast("magic_hand_summon_guard");
        scripts.insertLast("magic_hand_summon_rat");
        return scripts;
    }
    
    // Global arrays for compatibility with original script patterns
    const array<string> MAGIC_HAND_SCRIPTS2 = GetMagicHandScripts2();
    const array<string> MAGIC_HAND_NAMES2 = GetMagicHandNames2();
    
    /**
     * Get magic hand scripts - Group 3
     */
    array<string> GetMagicHandScripts3()
    {
        array<string> scripts;
        scripts.insertLast("magic_hand_summon_undead");
        scripts.insertLast("magic_hand_turn_undead");
        scripts.insertLast("magic_hand_volcano");
        return scripts;
    }
    
    // Global arrays for compatibility with original script patterns
    const array<string> MAGIC_HAND_SCRIPTS3 = GetMagicHandScripts3();
    const array<string> MAGIC_HAND_NAMES3 = GetMagicHandNames3();
    
    /**
     * Get magic hand display names - Group 1
     */
    array<string> GetMagicHandNames1()
    {
        array<string> names;
        names.insertLast("Acidic Bolt");
        names.insertLast("Blizzard");
        names.insertLast("Glow");
        names.insertLast("Rejuvenate");
        names.insertLast("Fire Ball");
        names.insertLast("Fire Dart");
        names.insertLast("Fire Wall");
        names.insertLast("Frost Bolt");
        names.insertLast("Healing Circle");
        names.insertLast("Ice Blast");
        names.insertLast("Ice Shield");
        return names;
    }
    
    /**
     * Get magic hand display names - Group 2
     */
    array<string> GetMagicHandNames2()
    {
        array<string> names;
        names.insertLast("Lesser Ice Shield");
        names.insertLast("Ice Wall");
        names.insertLast("Chain Lighting");
        names.insertLast("Lightning Storm");
        names.insertLast("Erratic Lightning");
        names.insertLast("Poison Dart");
        names.insertLast("Poison Cloud");
        names.insertLast("Summon Fangtooth");
        names.insertLast("Summon Guardian");
        names.insertLast("Summon Rat");
        return names;
    }
    
    /**
     * Get magic hand display names - Group 3
     */
    array<string> GetMagicHandNames3()
    {
        array<string> names;
        names.insertLast("Summon Undead");
        names.insertLast("Rebuke Undead");
        names.insertLast("Volcano");
        return names;
    }
    
    /**
     * Get countdown sound files
     */
    array<string> GetCountdownSounds()
    {
        array<string> sounds;
        sounds.insertLast("vox/ten.wav");
        sounds.insertLast("vox/nine.wav");
        sounds.insertLast("vox/eight.wav");
        sounds.insertLast("vox/seven.wav");
        sounds.insertLast("vox/six.wav");
        sounds.insertLast("vox/five.wav");
        sounds.insertLast("vox/four.wav");
        sounds.insertLast("vox/three.wav");
        sounds.insertLast("vox/two.wav");
        sounds.insertLast("vox/one.wav");
        sounds.insertLast("vox/zero.wav");
        return sounds;
    }
    
    // ========================================
    // Data Structures
    // ========================================
    
    /**
     * Structure for delayed NPC spawn information
     */
    class GameMasterNPCSpawn
    {
        string szScript;          // Script name for the NPC
        Vector3 vecPosition;      // Spawn position
        Vector3 vecAngles;        // Spawn angles
        EntityHandle hOwner;      // Owner entity
        EntityHandle hEnemy;      // Initial enemy target
        float flParam1;           // Additional parameter 1
        float flParam2;           // Additional parameter 2
        
        GameMasterNPCSpawn()
        {
            szScript = "";
            vecPosition = Vector3();
            vecAngles = Vector3();
            hOwner = EntityHandle();
            hEnemy = EntityHandle();
            flParam1 = 0.0f;
            flParam2 = 0.0f;
        }
    }
    
    /**
     * Structure for light system data
     */
    class LightSystemData
    {
        EntityHandle hOwner;      // Owner of this light
        int nColor;              // Light color (-1 = unused)
        float flRadius;          // Light radius (-1 = unused)
        
        LightSystemData()
        {
            hOwner = EntityHandle();
            nColor = -1;
            flRadius = -1.0f;
        }
    }
    
    /**
     * Structure for player damage tracking (legacy system)
     */
    class PlayerDamageData
    {
        string szSteamID;        // Player's Steam ID
        float flTotalDamage;     // Total damage dealt
        uint nKills;             // Number of kills
        uint nDeaths;            // Number of deaths
        
        PlayerDamageData()
        {
            szSteamID = "";
            flTotalDamage = 0.0f;
            nKills = 0;
            nDeaths = 0;
        }
    }
    
    /**
     * Demon rage tracking data
     */
    class DemonRageData
    {
        string szPlayerID;       // Player identifier
        uint nUses;              // Number of uses
        float flLastUseTime;     // Last use timestamp
        
        DemonRageData()
        {
            szPlayerID = "";
            nUses = 0;
            flLastUseTime = 0.0f;
        }
    }
    
    /**
     * Treasure spawn configuration
     */
    class TreasureSpawnConfig
    {
        float flMinGold;         // Minimum gold amount
        float flMaxGold;         // Maximum gold amount
        float flItemChance;      // Chance of item spawn (0-1)
        uint nMinItems;          // Minimum items
        uint nMaxItems;          // Maximum items
        
        TreasureSpawnConfig()
        {
            flMinGold = 0.0f;
            flMaxGold = 0.0f;
            flItemChance = 0.0f;
            nMinItems = 0;
            nMaxItems = 0;
        }
    }
    
    // ========================================
    // Global Accessors (simulating global variables)
    // ========================================
    
    /**
     * Global game master entity handle
     */
    EntityHandle g_hGameMaster;
    
    /**
     * Number of game masters spawned
     */
    uint g_nGameMasters = 0;
    
    /**
     * Map uptime in minutes
     */
    uint g_nMapUptime = 0;
    
    /**
     * Get the global game master entity
     */
    CBaseEntity@ GetGameMasterEntity()
    {
        if (g_hGameMaster.IsValid())
        {
            return cast<CBaseEntity@>(g_hGameMaster.Get());
        }
        return null;
    }
    
    /**
     * Set the global game master entity
     */
    void SetGlobalGameMaster(EntityHandle hGameMaster)
    {
        g_hGameMaster = hGameMaster;
    }
    
    /**
     * Get the current number of game masters
     */
    uint GetGlobalGameMasterCount()
    {
        return g_nGameMasters;
    }
    
    /**
     * Increment the game master count
     */
    void IncrementGlobalGameMasters()
    {
        g_nGameMasters++;
    }
    
    /**
     * Get the current map uptime in minutes
     */
    uint GetGlobalMapUptime()
    {
        return g_nMapUptime;
    }
    
    /**
     * Set the map uptime
     */
    void SetGlobalMapUptime(uint nUptime)
    {
        g_nMapUptime = nUptime;
    }
    
    // ========================================
    // Utility Functions
    // ========================================
    
    /**
     * Get all magic hand scripts combined
     */
    array<string> GetAllMagicHandScripts()
    {
        array<string> allScripts;
        
        // Add all elements from scripts group 1
        array<string> scripts1 = GetMagicHandScripts1();
        for (uint i = 0; i < scripts1.length(); i++)
            allScripts.insertLast(scripts1[i]);
            
        // Add all elements from scripts group 2
        array<string> scripts2 = GetMagicHandScripts2();
        for (uint i = 0; i < scripts2.length(); i++)
            allScripts.insertLast(scripts2[i]);
            
        // Add all elements from scripts group 3
        array<string> scripts3 = GetMagicHandScripts3();
        for (uint i = 0; i < scripts3.length(); i++)
            allScripts.insertLast(scripts3[i]);
            
        return allScripts;
    }
    
    /**
     * Get all magic hand names combined
     */
    array<string> GetAllMagicHandNames()
    {
        array<string> allNames;
        
        // Add all elements from names group 1
        array<string> names1 = GetMagicHandNames1();
        for (uint i = 0; i < names1.length(); i++)
            allNames.insertLast(names1[i]);
            
        // Add all elements from names group 2
        array<string> names2 = GetMagicHandNames2();
        for (uint i = 0; i < names2.length(); i++)
            allNames.insertLast(names2[i]);
            
        // Add all elements from names group 3
        array<string> names3 = GetMagicHandNames3();
        for (uint i = 0; i < names3.length(); i++)
            allNames.insertLast(names3[i]);
            
        return allNames;
    }
    
    /**
     * Find magic hand script by name
     */
    string FindMagicHandScript(const string &in szName)
    {
        array<string> allNames = GetAllMagicHandNames();
        array<string> allScripts = GetAllMagicHandScripts();
        
        for (uint i = 0; i < allNames.length(); i++)
        {
            if (allNames[i] == szName)
            {
                return allScripts[i];
            }
        }
        
        return "";
    }
}