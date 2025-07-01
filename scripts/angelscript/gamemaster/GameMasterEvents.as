/**
 * GameMasterEvents.as
 * 
 * Event system interfaces and event data structures for the GameMaster.
 * Provides a structured way to handle game-wide events and notifications.
 */

namespace MS
{
    // ========================================
    // Event Interfaces
    // ========================================
    
    /**
     * Interface for game master event handlers
     */
    interface IGameMasterEvents
    {
        /**
         * Called when a player connects to the server
         */
        void OnPlayerConnect(CBasePlayer@ pPlayer);
        
        /**
         * Called when a player disconnects from the server
         */
        void OnPlayerDisconnect(CBasePlayer@ pPlayer);
        
        /**
         * Called when a monster is killed
         */
        void OnMonsterKilled(CBaseEntity@ pMonster, CBaseEntity@ pKiller);
        
        /**
         * Called when treasure is spawned
         */
        void OnTreasureSpawned(CBaseEntity@ pTreasure);
    }
    
    /**
     * Interface for map transition events
     */
    interface IMapTransitionEvents
    {
        /**
         * Called before a map transition
         */
        void OnMapTransitionStart(const string &in szNextMap);
        
        /**
         * Called after a map transition completes
         */
        void OnMapTransitionComplete();
        
        /**
         * Called when players are being transferred
         */
        void OnPlayersTransferring(array<CBasePlayer@>@ players);
    }
    
    /**
     * Interface for voting system events
     */
    interface IVoteEvents
    {
        /**
         * Called when a vote is initiated
         */
        void OnVoteStarted(const string &in szVoteType, const string &in szInitiator);
        
        /**
         * Called when a player casts a vote
         */
        void OnVoteCast(CBasePlayer@ pPlayer, bool bYesVote);
        
        /**
         * Called when a vote completes
         */
        void OnVoteComplete(bool bPassed, uint nYesVotes, uint nNoVotes);
    }
    
    /**
     * Interface for damage tracking events
     */
    interface IDamageEvents
    {
        /**
         * Called when damage is dealt
         */
        void OnDamageDealt(CBaseEntity@ pAttacker, CBaseEntity@ pVictim, 
                          float flDamage, int iDamageType);
        
        /**
         * Called when healing is performed
         */
        void OnHealingDone(CBaseEntity@ pHealer, CBaseEntity@ pTarget, 
                          float flAmount);
    }
    
    // ========================================
    // Event Data Structures
    // ========================================
    
    /**
     * Player connection event data
     */
    class PlayerConnectionEvent
    {
        CBasePlayer@ pPlayer;
        string szSteamID;
        string szIPAddress;
        float flConnectTime;
        
        PlayerConnectionEvent(CBasePlayer@ player)
        {
            @pPlayer = player;
            szSteamID = player.GetSteamID();
            szIPAddress = player.GetIPAddress();
            flConnectTime = GetGameTime();
        }
    }
    
    /**
     * Monster death event data
     */
    class MonsterDeathEvent
    {
        CBaseEntity@ pMonster;
        CBaseEntity@ pKiller;
        Vector3 vecDeathPosition;
        float flDeathTime;
        int iDamageType;
        float flTotalDamage;
        
        MonsterDeathEvent(CBaseEntity@ monster, CBaseEntity@ killer)
        {
            @pMonster = monster;
            @pKiller = killer;
            vecDeathPosition = monster.GetOrigin();
            flDeathTime = GetGameTime();
            iDamageType = 0;
            flTotalDamage = 0.0f;
        }
    }
    
    /**
     * Treasure spawn event data
     */
    class TreasureSpawnEvent
    {
        CBaseEntity@ pTreasure;
        Vector3 vecSpawnPosition;
        float flSpawnTime;
        string szTreasureType;
        float flValue;
        
        TreasureSpawnEvent(CBaseEntity@ treasure)
        {
            @pTreasure = treasure;
            vecSpawnPosition = treasure.GetOrigin();
            flSpawnTime = GetGameTime();
            szTreasureType = treasure.GetClassName();
            flValue = 0.0f;
        }
    }
    
    /**
     * Map transition event data
     */
    class MapTransitionEvent
    {
        string szCurrentMap;
        string szNextMap;
        array<CBasePlayer@> aTransferringPlayers;
        float flTransitionTime;
        bool bForced;
        
        MapTransitionEvent(const string &in current, const string &in next)
        {
            szCurrentMap = current;
            szNextMap = next;
            flTransitionTime = GetGameTime();
            bForced = false;
        }
    }
    
    /**
     * Vote event data
     */
    class VoteEvent
    {
        string szVoteType;
        string szInitiator;
        string szTarget;
        float flStartTime;
        float flDuration;
        uint nRequiredVotes;
        array<string> aYesVoters;
        array<string> aNoVoters;
        
        VoteEvent(const string &in type, const string &in initiator)
        {
            szVoteType = type;
            szInitiator = initiator;
            szTarget = "";
            flStartTime = GetGameTime();
            flDuration = 30.0f; // Default 30 second vote
            nRequiredVotes = 0;
        }
        
        bool HasPlayerVoted(const string &in szPlayerID)
        {
            return (aYesVoters.find(szPlayerID) >= 0 || 
                    aNoVoters.find(szPlayerID) >= 0);
        }
        
        uint GetYesVotes() { return aYesVoters.length(); }
        uint GetNoVotes() { return aNoVoters.length(); }
        uint GetTotalVotes() { return GetYesVotes() + GetNoVotes(); }
    }
    
    /**
     * Damage event data
     */
    class DamageEvent
    {
        CBaseEntity@ pAttacker;
        CBaseEntity@ pVictim;
        float flDamage;
        int iDamageType;
        Vector3 vecDamagePosition;
        Vector3 vecDamageForce;
        float flTime;
        
        DamageEvent()
        {
            @pAttacker = null;
            @pVictim = null;
            flDamage = 0.0f;
            iDamageType = 0;
            vecDamagePosition = Vector3();
            vecDamageForce = Vector3();
            flTime = GetGameTime();
        }
    }
    
    // ========================================
    // Event Manager
    // ========================================
    
    /**
     * Central event manager for GameMaster events
     */
    class GameMasterEventManager
    {
        private array<IGameMasterEvents@> m_GameMasterListeners;
        private array<IMapTransitionEvents@> m_MapTransitionListeners;
        private array<IVoteEvents@> m_VoteListeners;
        private array<IDamageEvents@> m_DamageListeners;
        /**
         * Register a game master event listener
         */
        void RegisterGameMasterListener(IGameMasterEvents@ listener)
        {
            if (listener !is null && m_GameMasterListeners.find(listener) < 0)
            {
                m_GameMasterListeners.insertLast(listener);
            }
        }
        
        /**
         * Unregister a game master event listener
         */
        void UnregisterGameMasterListener(IGameMasterEvents@ listener)
        {
            int index = m_GameMasterListeners.find(listener);
            if (index >= 0)
            {
                m_GameMasterListeners.removeAt(index);
            }
        }
        
        /**
         * Fire player connection event
         */
        void FirePlayerConnect(CBasePlayer@ pPlayer)
        {
            PlayerConnectionEvent event(pPlayer);
            
            for (uint i = 0; i < m_GameMasterListeners.length(); i++)
            {
                m_GameMasterListeners[i].OnPlayerConnect(pPlayer);
            }
            
            LogMessage("[INFO] Player connected: " + pPlayer.GetName() + 
                         " [" + event.szSteamID + "] from " + event.szIPAddress);
        }
        
        /**
         * Fire player disconnection event
         */
        void FirePlayerDisconnect(CBasePlayer@ pPlayer)
        {
            for (uint i = 0; i < m_GameMasterListeners.length(); i++)
            {
                m_GameMasterListeners[i].OnPlayerDisconnect(pPlayer);
            }
        }
        
        /**
         * Fire monster killed event
         */
        void FireMonsterKilled(CBaseEntity@ pMonster, CBaseEntity@ pKiller)
        {
            MonsterDeathEvent event(pMonster, pKiller);
            
            for (uint i = 0; i < m_GameMasterListeners.length(); i++)
            {
                m_GameMasterListeners[i].OnMonsterKilled(pMonster, pKiller);
            }
        }
        
        /**
         * Fire treasure spawned event
         */
        void FireTreasureSpawned(CBaseEntity@ pTreasure)
        {
            TreasureSpawnEvent event(pTreasure);
            
            for (uint i = 0; i < m_GameMasterListeners.length(); i++)
            {
                m_GameMasterListeners[i].OnTreasureSpawned(pTreasure);
            }
        }
        
        // Similar methods for other event types...
    }
    
    /**
     * Global event manager instance
     */
    GameMasterEventManager g_EventManager;
    
    /**
     * Get the global event manager
     */
    GameMasterEventManager@ GetEventManager()
    {
        return @g_EventManager;
    }
    
    // ========================================
    // Event Helper Functions
    // ========================================
    
    /**
     * Broadcast a message to all players
     */
    void BroadcastMessage(const string &in szMessage, bool bReliable = true)
    {
        array<CBasePlayer@> players = GetAllPlayers();
        for (uint i = 0; i < players.length(); i++)
        {
            if (players[i] !is null)
            {
                players[i].SendMessage(szMessage, bReliable);
            }
        }
    }
    
    /**
     * Broadcast a sound to all players
     */
    void BroadcastSound(const string &in szSound, float flVolume = 1.0f)
    {
        array<CBasePlayer@> players = GetAllPlayers();
        for (uint i = 0; i < players.length(); i++)
        {
            if (players[i] !is null)
            {
                players[i].EmitSound(szSound, flVolume);
            }
        }
    }
    
    /**
     * Log an event to the server log
     */
    void LogEvent(const string &in szEventType, const string &in szDetails)
    {
        string szTimestamp = GetTimestamp();
        string szLogEntry = "[" + szTimestamp + "] EVENT: " + szEventType + " - " + szDetails;
        
        LogMessage("[INFO] " + szLogEntry);
        
        if (GetCvar("ms_chatlog") != "0")
        {
            ChatLog(szLogEntry);
        }
    }
}