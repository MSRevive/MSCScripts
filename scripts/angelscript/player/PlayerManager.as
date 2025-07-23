/**
 * PlayerManager.as
 * 
 * Manages player tracking, admin functionality, and player-related
 * game events. Converted from player management functions in game_master.script.
 * 
 * Key Features:
 * - Player join/leave tracking
 * - Admin privilege management
 * - Developer mode support
 * - Player state tracking
 */

namespace MS
{
    /**
     * Player management and admin system
     */
    class PlayerManager
    {
    private:
        // Admin system
        array<string> m_AdminList;
        array<string> m_AdminAuth;
        bool m_bNoAdminsFound = true;
        
        // Developer mode tracking
        string m_szDevPlayer = "";
        bool m_bDeveloperMode = false;
        
        // Player tracking
        bool m_bHadPlayer = false;
        array<EntityHandle> m_PlayerList;
        
        // Light system synchronization
        uint m_nLightSyncPlayer = 0;
        
    public:
        PlayerManager()
        {
            // Initialize arrays
            m_AdminList.resize(0);
            m_AdminAuth.resize(0);
            m_PlayerList.resize(0);
        }
        
        /**
         * Initialize the player management system
         */
        void Initialize()
        {
            LoadAdminList();
            LogMessage("[INFO] PlayerManager initialized successfully");
        }
        
        /**
         * Shutdown the player management system
         */
        void Shutdown()
        {
            m_AdminList.resize(0);
            m_AdminAuth.resize(0);
            m_PlayerList.resize(0);
            LogMessage("[INFO] PlayerManager shutdown completed");
        }
        
        /**
         * Handle player joining the server
         * Converted from player_joined event
         */
        void OnPlayerJoined(CBasePlayer@ pPlayer)
        {
            if (pPlayer is null) return;
            
            m_bHadPlayer = true;
            
            // Add to player list if not already present
            EntityHandle hPlayer = EntityHandle(pPlayer);
            if (m_PlayerList.find(hPlayer) < 0)
            {
                m_PlayerList.insertLast(hPlayer);
            }
            
            // Sync lighting system for new player
            SyncLightsForPlayer(pPlayer.entindex());
            
            // Log player join with chat logging if enabled
            if (GetCvar("ms_chatlog") == "1")
            {
                string joinMsg = GetTimestamp() + " PLAYER_JOINED: " + pPlayer.pev.netname + 
                               " [" + GetPlayerSteamID(pPlayer) + "] [PlayerCount: " + 
                               GetPlayerCount() + "]";
                LogMessage("[INFO] " + joinMsg);
            }
            
            LogMessage("[INFO] Player joined: " + string(pPlayer.pev.netname));
        }
        
        /**
         * Handle player leaving the server
         * Converted from player_left event
         */
        void OnPlayerLeft(CBasePlayer@ pPlayer)
        {
            if (pPlayer is null) return;
            
            // Remove from player list
            EntityHandle hPlayer = EntityHandle(pPlayer);
            int index = m_PlayerList.find(hPlayer);
            if (index >= 0)
            {
                m_PlayerList.removeAt(index);
            }
            
            // Log player leave with chat logging if enabled
            if (GetCvar("ms_chatlog") == "1")
            {
                string leaveMsg = GetTimestamp() + " PLAYER_LEFT: " + pPlayer.pev.netname + 
                                " [" + GetPlayerSteamID(pPlayer) + "] [PlayerCountNow: " + 
                                GetPlayerCount() + " active]";
                LogMessage("[INFO] " + leaveMsg);
            }
            
            LogMessage("[INFO] Player left: " + string(pPlayer.pev.netname));
        }
        
        /**
         * Handle player chat/speech events
         * Converted from game_playerspeak
         */
        void OnPlayerSpeak(CBasePlayer@ pPlayer, const string &in type, const string &in text)
        {
            if (pPlayer is null) return;
            
            if (m_bDeveloperMode)
            {
                LogMessage("[INFO] Player " + string(pPlayer.pev.netname) + " said [" + type + "]: " + text);
            }
            
            // Chat logging if enabled
            if (GetCvar("ms_chatlog") == "1")
            {
                string chatMsg = GetTimestamp() + " [" + GetPlayerSteamID(pPlayer) + "] " +
                               pPlayer.pev.netname + "(" + type + "): " + text;
                LogMessage("[INFO] " + chatMsg);
            }
        }
        
        /**
         * Set developer player
         */
        void SetDeveloperPlayer(const string &in playerName)
        {
            m_szDevPlayer = playerName;
            LogMessage("[INFO] Developer player set to: " + playerName);
        }
        
        /**
         * Get developer player name
         */
        string GetDeveloperPlayer() const
        {
            return m_szDevPlayer;
        }
        
        /**
         * Enable/disable developer mode
         */
        void SetDeveloperMode(bool enabled)
        {
            m_bDeveloperMode = enabled;
            LogMessage("[INFO] Developer mode " + (enabled ? "enabled" : "disabled"));
        }
        
        /**
         * Check if developer mode is active
         */
        bool IsDeveloperMode() const
        {
            return m_bDeveloperMode;
        }
        
        /**
         * Check if player is an admin
         */
        bool IsPlayerAdmin(CBasePlayer@ pPlayer)
        {
            if (pPlayer is null) return false;
            
            string steamID = GetPlayerSteamID(pPlayer);
            return m_AdminList.find(steamID) >= 0;
        }
        
        /**
         * Get admin authority level for player
         */
        string GetPlayerAdminAuth(CBasePlayer@ pPlayer)
        {
            if (pPlayer is null) return "";
            
            string steamID = GetPlayerSteamID(pPlayer);
            int index = m_AdminList.find(steamID);
            
            if (index >= 0 && index < int(m_AdminAuth.length()))
            {
                return m_AdminAuth[index];
            }
            
            return "";
        }
        
        /**
         * Check if player has specific admin privilege
         */
        bool HasAdminPrivilege(CBasePlayer@ pPlayer, const string &in privilege)
        {
            string auth = GetPlayerAdminAuth(pPlayer);
            return auth.find(privilege) >= 0;
        }
        
        /**
         * Get current player count
         */
        uint GetPlayerCount() const
        {
            return m_PlayerList.length();
        }
        
        /**
         * Get list of active players
         */
        array<CBasePlayer@> GetActivePlayers()
        {
            array<CBasePlayer@> players;
            
            for (uint i = 0; i < m_PlayerList.length(); i++)
            {
                CBasePlayer@ pPlayer = cast<CBasePlayer@>(m_PlayerList[i].GetEntity());
                if (pPlayer !is null && pPlayer.IsAlive())
                {
                    players.insertLast(pPlayer);
                }
            }
            
            return players;
        }
        
        /**
         * Sync lighting system for a specific player
         * Converted from gm_lights_sync
         */
        void SyncLightsForPlayer(uint playerIndex)
        {
            m_nLightSyncPlayer = playerIndex;
            LogMessage("[INFO] Syncing lights for player index: " + playerIndex);
            
            // This would integrate with the light system from GameMaster
            // For now, we'll just log the request
        }
        
    private:
        /**
         * Load admin list from admins.txt
         * Converted from admin_load_list
         */
        void LoadAdminList()
        {
            m_AdminList.resize(0);
            m_AdminAuth.resize(0);
            m_bNoAdminsFound = true;
            
            // Note: File reading would need to be implemented with proper file I/O
            // For now, we'll simulate the loading process
            LogMessage("[INFO] Loading admin list from admins.txt");
            
            // This is a placeholder - actual implementation would read from file
            // Format: STEAM_ID permissions (rcon, cvar, all)
            
            // Example entries that would be read from file:
            // AddAdmin("STEAM_1:0:12345678", "standard_rcon_cvar_");
            // AddAdmin("STEAM_1:0:87654321", "standard_cvar_");
            
            if (m_AdminList.length() > 0)
            {
                m_bNoAdminsFound = false;
                LogMessage("[INFO] Loaded " + m_AdminList.length() + " admins from file");
            }
            else
            {
                LogMessage("[WARNING] No admins found in admins.txt");
            }
        }
        
        /**
         * Add an admin to the list
         */
        void AddAdmin(const string &in steamID, const string &in auth)
        {
            if (steamID.length() == 0) return;
            
            // Check if already exists
            int index = m_AdminList.find(steamID);
            if (index >= 0)
            {
                // Update existing admin
                m_AdminAuth[index] = auth;
            }
            else
            {
                // Add new admin
                m_AdminList.insertLast(steamID);
                m_AdminAuth.insertLast(auth);
            }
            
            LogMessage("[INFO] Added admin: " + steamID + " with auth: " + auth);
            m_bNoAdminsFound = false;
        }
        
        /**
         * Get player's Steam ID (connects to real C++ implementation)
         */
        string GetPlayerSteamID(CBasePlayer@ pPlayer)
        {
            if (pPlayer is null) return "";
            // Call the real C++ function that gets Steam ID from engine
            return pPlayer.GetSteamID();
        }
        
        /**
         * Get formatted timestamp
         */
        string GetTimestamp()
        {
            // Use the real C++ GetTimestamp function if available, fallback to game time
            float gameTime = ::GetGameTime();
            return "[" + formatf("%.2f", gameTime) + "]"; 
        }
        
        /**
         * Get current game time as string
         */
        string GetGameTimeString()
        {
            // Get actual game time from engine
            float gameTime = ::GetGameTime();
            return formatf("%.2f", gameTime);
        }
    };
    
    // Global player manager instance
    PlayerManager g_PlayerManager;
}