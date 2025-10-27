#pragma context server

/**
 * GameMasterVoting.as
 * 
 * Core voting system for GameMaster in AngelScript.
 * Provides complete vote management including creation, tracking, tallying,
 * player eligibility checking, menu integration, and callback systems.
 * 
 * Ported from vote_generic.script with modern AngelScript architecture.
 * 
 * Author: Agent 1 - Voting Framework Architect
 */

// Include the shared scheduler system
#include "shared/Scheduler.as"

namespace MS
{
    // ========================================
    // Scheduler Callback Handler
    // ========================================
    
    /**
     * Handles scheduled callbacks from the scheduler system
     */
    class VoteSchedulerCallbackHandler : ISchedulerCallback
    {
        void OnScheduledCallback(const string &in szCallbackName, const array<string> &in params)
        {
            LogMessage("[VoteSchedulerCallback] Executing: " + szCallbackName);
            
            if (szCallbackName == "ExecuteMapChange")
            {
                if (params.length() > 0)
                    ExecuteMapChangeNow(params[0]);
            }
            else if (szCallbackName == "ExecutePvpChange")
            {
                if (params.length() > 0)
                    ExecutePvpChangeNow(params[0]);
            }
            else if (szCallbackName == "ExecuteKickPlayer")
            {
                if (params.length() >= 2)
                    ExecuteKickPlayerNow(params[0], params[1]);
            }
            else if (szCallbackName == "ExecuteBanPlayer")
            {
                if (params.length() >= 2)
                    ExecuteBanPlayerNow(params[0], params[1]);
            }
            else if (szCallbackName == "DelayedChangeLevel")
            {
                // Call the global DelayedChangeLevel function which handles map transitions
                ::DelayedChangeLevel();
            }
        }
        
        // Actual execution functions
        private void ExecuteMapChangeNow(const string &in szMap)
        {
            LogMessage("[VoteSchedulerCallback] Changing map to: " + szMap);
            SendMessageToAllPlayers("00FF00", "Map changing to " + szMap + " NOW!");
            
            string szCommand = "changelevel " + szMap + "\n";
            ExecuteServerCommand(szCommand);
        }
        
        private void ExecutePvpChangeNow(const string &in szEnabled)
        {
            bool bEnable = (szEnabled == "1" || szEnabled == "true");
            string szCommand = "ms_pklevel " + (bEnable ? "1" : "0") + "\n";
            ExecuteServerCommand(szCommand);
            
            SendMessageToAllPlayers("00FF00", "PvP mode is now " + (bEnable ? "ENABLED" : "DISABLED") + "!");
        }
        
        private void ExecuteKickPlayerNow(const string &in szPlayerID, const string &in szPlayerName)
        {
            CBasePlayer@ pPlayer = FindPlayerBySteamID(szPlayerID);
            if (pPlayer is null)
            {
                int nIndex = parseUInt(szPlayerID);
                if (nIndex > 0)
                    @pPlayer = PlayerByIndex(nIndex);
            }
            
            if (pPlayer !is null)
            {
                int nIndex = pPlayer.GetEntIndex();
                string szCommand = "kick #" + nIndex + "\n";
                ExecuteServerCommand(szCommand);
                
                SendMessageToAllPlayers("FF0000", "Player " + szPlayerName + " has been kicked from the server");
            }
        }
        
        private void ExecuteBanPlayerNow(const string &in szSteamID, const string &in szPlayerName)
        {
            string szCommand = "banid 0 " + szSteamID + " kick\n";
            ExecuteServerCommand(szCommand);
            ExecuteServerCommand("writeid\n");
            
            SendMessageToAllPlayers("FF0000", "Player " + szPlayerName + " has been banned from the server");
        }
        
        private CBasePlayer@ FindPlayerBySteamID(const string &in szSteamID)
        {
            if (szSteamID.isEmpty())
                return null;
            
            int nPlayerCount = GetPlayerCount();
            for (int i = 1; i <= nPlayerCount; i++)
            {
                CBasePlayer@ pPlayer = PlayerByIndex(i);
                if (pPlayer !is null && IsConnected(pPlayer))
                {
                    if (GetSteamID(pPlayer) == szSteamID)
                        return pPlayer;
                }
            }
            
            return null;
        }
    }
    
    // Global callback handler instance
    VoteSchedulerCallbackHandler g_VoteCallbackHandler;
    
    // ========================================
    // Core Vote Manager Class
    // ========================================
    
    /**
     * Central vote management system
     * Handles all aspects of vote lifecycle from creation to completion
     */
    class VoteManager
    {
        private VoteData@ m_pCurrentVote;           // Active vote data
        private dictionary m_PlayerRecords;         // Player voting history
        private array<DelayedAction@> m_DelayedActions; // Scheduled actions
        private bool m_bInitialized;                // Initialization state
        private float m_flLastThinkTime;            // Last update time
        
        // Vote configuration
        private float m_flDefaultDuration;          // Default vote duration
        private float m_flVoteCooldown;             // Time between votes
        private float m_flLastVoteEndTime;          // When last vote ended
        private uint m_nMinPlayers;                 // Minimum players for voting
        private float m_flPassThreshold;            // Vote pass percentage
        
        /**
         * Constructor
         */
        VoteManager()
        {
            @m_pCurrentVote = null;
            m_bInitialized = false;
            m_flLastThinkTime = 0.0f;
            
            // Default configuration
            m_flDefaultDuration = 30.0f;  // 30 second votes
            m_flVoteCooldown = 5.0f;      // 5 second cooldown between votes
            m_flLastVoteEndTime = 0.0f;
            m_nMinPlayers = 1;
            m_flPassThreshold = 0.5f;     // 50% needed to pass
        }
        
        /**
         * Initialize the vote manager
         */
        bool Initialize()
        {
            if (m_bInitialized)
            {
                LogInfo("VoteManager: Already initialized, skipping re-initialization");
                return true;
            }
                
            LogInfo("VoteManager: Initializing voting system...");
            
            // Initialize the scheduler system
            if (!InitializeScheduler())
            {
                LogError("VoteManager: Failed to initialize scheduler");
                return false;
            }
            
            // Register our callback handler with the scheduler
            GetScheduler().RegisterCallbackHandler(@g_VoteCallbackHandler);
            LogInfo("VoteManager: Registered callback handler with scheduler");
            
            // Note: VoteManager doesn't need to register with event manager
            // It has its own event methods that are called directly
            
            // IMPORTANT: Only clear state on first initialization
            // Don't clear if there's an active vote (could happen during reconnect)
            if (!IsVoteActive())
            {
                @m_pCurrentVote = null;
                m_PlayerRecords.deleteAll();
                m_DelayedActions.resize(0);
                LogInfo("VoteManager: Cleared existing state (no active vote)");
            }
            else
            {
                LogInfo("VoteManager: Preserving active vote during initialization");
            }
            
            m_bInitialized = true;
            LogInfo("VoteManager: Voting system initialized successfully");
            return true;
        }
        
        /**
         * Shutdown the vote manager
         */
        void Shutdown()
        {
            if (!m_bInitialized)
                return;
                
            LogInfo("VoteManager: Shutting down voting system...");
            
            // Cancel any active vote
            if (IsVoteActive())
            {
                CancelVote("System shutdown");
            }
            
            // Shutdown scheduler
            ShutdownScheduler();
            LogInfo("VoteManager: Scheduler shutdown complete");
            
            // Clear all data
            @m_pCurrentVote = null;
            m_PlayerRecords.deleteAll();
            m_DelayedActions.resize(0);
            
            m_bInitialized = false;
            LogInfo("VoteManager: Voting system shutdown complete");
        }
        
        /**
         * Update the vote manager (called regularly)
         */
        void Think()
        {
            if (!m_bInitialized)
                return;
                
            float currentTime = GetGameTime();
            
            // Update at most once per frame
            if (currentTime - m_flLastThinkTime < 0.1f)
                return;
                
            m_flLastThinkTime = currentTime;
            
            // Update scheduler system
            UpdateScheduler();
            
            // Process active vote
            if (IsVoteActive())
            {
                UpdateActiveVote();
            }
            
            // Process delayed actions
            UpdateDelayedActions();
        }
        
        // ========================================
        // Vote Creation and Management
        // ========================================
        
        /**
         * Create a new vote
         * @param szCallbackEvent Event to call when vote completes
         * @param szOptions Token-separated vote options "option1:data1;option2:data2"
         * @param szTitle Vote title displayed to players
         * @param szDescription Optional vote description
         * @param bSilent Whether to suppress vote announcements
         * @return true if vote was created successfully
         */
        bool CreateVote(const string &in szCallbackEvent, const string &in szOptions,
                       const string &in szTitle, const string &in szDescription = "",
                       bool bSilent = false)
        {
            if (!m_bInitialized)
            {
                LogError("VoteManager: Cannot create vote - system not initialized");
                return false;
            }
            
            if (IsVoteActive())
            {
                LogWarning("VoteManager: Cannot create vote - another vote is active");
                return false;
            }
            
            if (GetPlayerCount() == 0)
            {
                LogWarning("VoteManager: Cannot create vote - no players connected");
                return false;
            }
            
            // Check cooldown
            float currentTime = GetGameTime();
            if (currentTime - m_flLastVoteEndTime < m_flVoteCooldown)
            {
                LogWarning("VoteManager: Vote is in cooldown period");
                return false;
            }
            
            // Create vote data
            @m_pCurrentVote = VoteData();
            string voteID = "vote_" + int(currentTime * 1000);
            m_pCurrentVote.Initialize(voteID, VOTE_CUSTOM, szTitle, "system", "GameMaster");
            
            m_pCurrentVote.szDescription = szDescription;
            m_pCurrentVote.bSilent = bSilent;
            m_pCurrentVote.flDuration = m_flDefaultDuration;
            m_pCurrentVote.szCallbackEvent = szCallbackEvent;
            
            // Parse vote options
            if (!ParseVoteOptions(szOptions))
            {
                LogError("VoteManager: Failed to parse vote options");
                @m_pCurrentVote = null;
                return false;
            }
            
            // Set up eligible voters
            PopulateEligibleVoters();
            
            // Calculate required votes
            CalculateVoteRequirements();
            
            LogInfo("VoteManager: Created vote '" + szTitle + "' with " + 
                   m_pCurrentVote.aEligibleVoters.length() + " eligible voters");
            
            // Send vote to players
            return SendVoteToPlayers();
        }
        
        /**
         * Create a specialized map vote
         */
        bool CreateMapVote(const string &in szInitiatorID, const string &in szTargetMap)
        {
            string initiatorName = GetPlayerName(szInitiatorID);
            if (initiatorName.isEmpty())
            {
                LogError("VoteManager: Cannot create map vote - invalid initiator");
                return false;
            }
            
            string title = "MAP CHANGE: " + szTargetMap;
            string description = initiatorName + " wants to change the map to " + szTargetMap;
            string options = "Yes!:" + szTargetMap + ";No!:0";
            
            @m_pCurrentVote = VoteData();
            string voteID = "mapvote_" + int(GetGameTime() * 1000);
            m_pCurrentVote.Initialize(voteID, VOTE_MAP, title, szInitiatorID, initiatorName);
            m_pCurrentVote.szDescription = description;
            m_pCurrentVote.szTargetData = szTargetMap;
            m_pCurrentVote.szCallbackEvent = "gm_votemap";
            
            ParseVoteOptions(options);
            PopulateEligibleVoters();
            CalculateVoteRequirements();
            
            return SendVoteToPlayers();
        }
        
        /**
         * Create a kick vote
         */
        bool CreateKickVote(const string &in szInitiatorID, const string &in szTargetID)
        {
            string initiatorName = GetPlayerName(szInitiatorID);
            string targetName = GetPlayerName(szTargetID);
            
            if (initiatorName.isEmpty() || targetName.isEmpty())
            {
                LogError("VoteManager: Cannot create kick vote - invalid player IDs");
                return false;
            }
            
            string title = "KICK: " + targetName;
            string description = initiatorName + " has started a kick vote against " + targetName;
            string options = "Yes!:kick;" + szTargetID + ";No!:0";
            
            @m_pCurrentVote = VoteData();
            string voteID = "kickvote_" + int(GetGameTime() * 1000);
            m_pCurrentVote.Initialize(voteID, VOTE_KICK, title, szInitiatorID, initiatorName);
            m_pCurrentVote.szDescription = description;
            m_pCurrentVote.szTargetID = szTargetID;
            m_pCurrentVote.szCallbackEvent = "gm_votekick_result";
            
            ParseVoteOptions(options);
            PopulateEligibleVoters();
            
            // Remove target from eligible voters
            int targetIndex = m_pCurrentVote.aEligibleVoters.find(szTargetID);
            if (targetIndex >= 0)
            {
                m_pCurrentVote.aEligibleVoters.removeAt(targetIndex);
            }
            
            CalculateVoteRequirements();
            
            return SendVoteToPlayers();
        }
        
        /**
         * Create a ban vote
         */
        bool CreateBanVote(const string &in szInitiatorID, const string &in szTargetID)
        {
            string initiatorName = GetPlayerName(szInitiatorID);
            string targetName = GetPlayerName(szTargetID);
            
            if (initiatorName.isEmpty() || targetName.isEmpty())
            {
                LogError("VoteManager: Cannot create ban vote - invalid player IDs");
                return false;
            }
            
            string title = "BAN: " + targetName;
            string description = initiatorName + " has started a ban vote against " + targetName;
            string options = "Yes!:ban;" + szTargetID + ";No!:0";
            
            @m_pCurrentVote = VoteData();
            string voteID = "banvote_" + int(GetGameTime() * 1000);
            m_pCurrentVote.Initialize(voteID, VOTE_BAN, title, szInitiatorID, initiatorName);
            m_pCurrentVote.szDescription = description;
            m_pCurrentVote.szTargetID = szTargetID;
            m_pCurrentVote.szCallbackEvent = "gm_voteban_result";
            
            ParseVoteOptions(options);
            PopulateEligibleVoters();
            
            // Remove target from eligible voters
            int targetIndex = m_pCurrentVote.aEligibleVoters.find(szTargetID);
            if (targetIndex >= 0)
            {
                m_pCurrentVote.aEligibleVoters.removeAt(targetIndex);
            }
            
            CalculateVoteRequirements();
            
            return SendVoteToPlayers();
        }
        
        /**
         * Create a PvP toggle vote
         */
        bool CreatePvpVote(const string &in szInitiatorID, bool bEnablePvp)
        {
            string initiatorName = GetPlayerName(szInitiatorID);
            if (initiatorName.isEmpty())
            {
                LogError("VoteManager: Cannot create PvP vote - invalid initiator");
                return false;
            }
            
            string action = bEnablePvp ? "ENABLE" : "DISABLE";
            string title = "PVP " + action;
            string description = initiatorName + " wants to " + MS::ToLower(action) + " PvP mode";
            string options = "Yes!:" + (bEnablePvp ? "1" : "0") + ";No!:keep";
            
            @m_pCurrentVote = VoteData();
            string voteID = "pvpvote_" + int(GetGameTime() * 1000);
            m_pCurrentVote.Initialize(voteID, VOTE_PVP, title, szInitiatorID, initiatorName);
            m_pCurrentVote.szDescription = description;
            m_pCurrentVote.szTargetData = bEnablePvp ? "1" : "0";
            m_pCurrentVote.szCallbackEvent = "gm_votepvp";
            
            ParseVoteOptions(options);
            PopulateEligibleVoters();
            CalculateVoteRequirements();
            
            return SendVoteToPlayers();
        }
        
        /**
         * Create a server lock vote
         */
        bool CreateServerLockVote(const string &in szInitiatorID)
        {
            string initiatorName = GetPlayerName(szInitiatorID);
            if (initiatorName.isEmpty())
            {
                LogError("VoteManager: Cannot create lock vote - invalid initiator");
                return false;
            }
            
            string title = "LOCK SERVER";
            string description = initiatorName + " wants to lock the server with a password";
            string options = "Yes!:1;No!:0";
            
            @m_pCurrentVote = VoteData();
            string voteID = "lockvote_" + int(GetGameTime() * 1000);
            m_pCurrentVote.Initialize(voteID, VOTE_LOCK, title, szInitiatorID, initiatorName);
            m_pCurrentVote.szDescription = description;
            m_pCurrentVote.szCallbackEvent = "gm_votelock";
            
            ParseVoteOptions(options);
            PopulateEligibleVoters();
            CalculateVoteRequirements();
            
            return SendVoteToPlayers();
        }
        
        // ========================================
        // Vote State Management
        // ========================================
        
        /**
         * Cast a vote for a player
         */
        bool CastVote(const string &in szPlayerID, uint nOptionIndex)
        {
            if (!IsVoteActive())
            {
                LogWarning("VoteManager: Cannot cast vote - no active vote");
                return false;
            }
            
            if (!m_pCurrentVote.IsPlayerEligible(szPlayerID))
            {
                LogWarning("VoteManager: Player " + szPlayerID + " is not eligible to vote");
                return false;
            }
            
            if (m_pCurrentVote.HasPlayerVoted(szPlayerID))
            {
                LogWarning("VoteManager: Player " + szPlayerID + " has already voted");
                return false;
            }
            
            if (nOptionIndex >= m_pCurrentVote.aVoteOptions.length())
            {
                LogError("VoteManager: Invalid vote option index " + nOptionIndex);
                return false;
            }
            
            // Cast the vote
            if (!m_pCurrentVote.CastVote(szPlayerID, nOptionIndex))
            {
                LogError("VoteManager: Failed to cast vote for player " + szPlayerID);
                return false;
            }
            
            // Update player record
            UpdatePlayerVoteRecord(szPlayerID, nOptionIndex);
            
            // Announce vote if not silent
            if (!m_pCurrentVote.bSilent)
            {
                string playerName = GetPlayerName(szPlayerID);
                string optionTitle = m_pCurrentVote.aOptionTitles[nOptionIndex];
                string announcement = playerName + " votes " + optionTitle;
                BroadcastMessage(announcement);
            }
            
            LogInfo("VoteManager: Player " + szPlayerID + " voted for option " + nOptionIndex);
            
            // Check if vote should end early
            if (m_pCurrentVote.ShouldEndEarly())
            {
                ScheduleDelayedAction("end_vote", 0.1f, array<string>());
            }
            
            return true;
        }
        
        /**
         * Cancel a player's participation in vote (equivalent to abstaining)
         */
        bool CancelPlayerVote(const string &in szPlayerID)
        {
            if (!IsVoteActive())
                return false;
                
            int voterIndex = m_pCurrentVote.aEligibleVoters.find(szPlayerID);
            if (voterIndex < 0)
                return false;
                
            // Remove from eligible voters (equivalent to abstaining)
            m_pCurrentVote.aEligibleVoters.removeAt(voterIndex);
            
            // Check if vote should end early
            if (m_pCurrentVote.ShouldEndEarly())
            {
                ScheduleDelayedAction("end_vote", 0.1f, array<string>());
            }
            
            return true;
        }
        
        /**
         * Cancel the current vote
         */
        void CancelVote(const string &in szReason = "Vote cancelled")
        {
            if (!IsVoteActive())
                return;
                
            LogInfo("VoteManager: Cancelling vote - " + szReason);
            
            m_pCurrentVote.eResult = VOTE_CANCELLED;
            BroadcastMessage("Vote cancelled: " + szReason);
            
            // Clean up
            m_flLastVoteEndTime = GetGameTime();
            @m_pCurrentVote = null;
        }
        
        /**
         * End the current vote and tally results
         */
        void TallyVotes()
        {
            if (!IsVoteActive())
            {
                LogError("VoteManager: TallyVotes() called but no active vote!");
                return;
            }
                
            LogInfo("VoteManager: TallyVotes() called for '" + m_pCurrentVote.szTitle + "'");
            LogInfo("VoteManager:   Total votes cast: " + formatInt(m_pCurrentVote.GetTotalVotesCast()));
            LogInfo("VoteManager:   Eligible voters: " + formatInt(m_pCurrentVote.aEligibleVoters.length()));
            
            // Finalize the vote
            VoteResult result = m_pCurrentVote.Finalize();
            
            // Get winning option
            uint winningIndex = m_pCurrentVote.nWinningOption;
            string winningTitle = "";
            string winningData = "";
            
            if (winningIndex < m_pCurrentVote.aOptionTitles.length())
            {
                winningTitle = m_pCurrentVote.aOptionTitles[winningIndex];
                winningData = m_pCurrentVote.aOptionData[winningIndex];
            }
            
            // Announce results
            string resultMessage = "The people have spoken!";
            BroadcastMessage(resultMessage, winningTitle);
            
            // Execute callback
            if (!m_pCurrentVote.szCallbackEvent.isEmpty())
            {
                ExecuteVoteCallback(m_pCurrentVote.szCallbackEvent, winningTitle, winningData);
            }
            
            // Update vote initiator's record
            if (!m_pCurrentVote.szInitiatorID.isEmpty())
            {
                bool passed = (result == VOTE_PASSED);
                UpdatePlayerInitiationRecord(m_pCurrentVote.szInitiatorID, passed);
            }
            
            // Clean up
            LogInfo("VoteManager: Vote completed with result: " + formatInt(int(result)) + " - CLEARING m_pCurrentVote");
            m_flLastVoteEndTime = GetGameTime();
            @m_pCurrentVote = null;
        }
        
        // ========================================
        // Menu System Integration
        // ========================================
        
        /**
         * Get vote menu options for a player
         */
        array<string>@ GetVoteMenuOptions(const string &in szPlayerID)
        {
            array<string> options;
            
            if (!IsVoteActive() || !m_pCurrentVote.IsPlayerEligible(szPlayerID) ||
                m_pCurrentVote.HasPlayerVoted(szPlayerID))
            {
                return @options;
            }
            
            // Return copy of vote options
            for (uint i = 0; i < m_pCurrentVote.aOptionTitles.length(); i++)
            {
                options.insertLast(m_pCurrentVote.aOptionTitles[i]);
            }
            
            return @options;
        }
        
        /**
         * Process menu selection from player
         */
        bool ProcessMenuSelection(const string &in szPlayerID, const string &in szOptionData)
        {
            LogInfo("VoteManager: ProcessMenuSelection called for player " + szPlayerID + " with option '" + szOptionData + "'");
            
            // Debug vote state
            if (m_pCurrentVote is null)
            {
                LogError("VoteManager: m_pCurrentVote is null!");
                
                // Notify player that the vote has ended
                CBasePlayer@ pPlayer = GetPlayerBySteamID(szPlayerID);
                if (pPlayer !is null)
                {
                    SendMessageToAllPlayers("yellow", GetDisplayName(pPlayer) + ": That vote has already ended.");
                }
                
                return false;
            }
            
            LogInfo("VoteManager: Current vote exists, result = " + formatInt(m_pCurrentVote.eResult));
            
            if (!IsVoteActive())
            {
                LogError("VoteManager: Vote is not active (result != VOTE_PENDING)");
                
                // Notify player that the vote has expired
                CBasePlayer@ pPlayer = GetPlayerBySteamID(szPlayerID);
                if (pPlayer !is null)
                {
                    SendMessageToAllPlayers("yellow", GetDisplayName(pPlayer) + ": That vote has expired.");
                }
                
                return false;
            }
            
            LogInfo("VoteManager: Active vote found, checking " + formatInt(m_pCurrentVote.aOptionTitles.length()) + " options");
                
            // Find option index by matching the title (what the menu displays)
            // The menu sends back the title that was shown to the player
            uint optionIndex = 0;
            bool found = false;
            
            for (uint i = 0; i < m_pCurrentVote.aOptionTitles.length(); i++)
            {
                LogInfo("VoteManager: Option " + formatInt(i) + " title='" + m_pCurrentVote.aOptionTitles[i] + "' data='" + m_pCurrentVote.aOptionData[i] + "'");
                if (m_pCurrentVote.aOptionTitles[i] == szOptionData)
                {
                    optionIndex = i;
                    found = true;
                    LogInfo("VoteManager: Found matching option at index " + formatInt(optionIndex));
                    break;
                }
            }
            
            if (!found)
            {
                LogError("VoteManager: Invalid menu option data: '" + szOptionData + "' - no match found in titles");
                return false;
            }
            
            LogInfo("VoteManager: Calling CastVote for player " + szPlayerID + " with option " + formatInt(optionIndex));
            bool result = CastVote(szPlayerID, optionIndex);
            LogInfo("VoteManager: CastVote returned " + (result ? "true" : "false"));
            return result;
        }
        
        // ========================================
        // Player Management
        // ========================================
        
        /**
         * Handle player disconnection
         */
        void OnPlayerDisconnect(const string &in szPlayerID)
        {
            if (!IsVoteActive())
                return;
                
            // Remove from eligible voters
            int voterIndex = m_pCurrentVote.aEligibleVoters.find(szPlayerID);
            if (voterIndex >= 0)
            {
                m_pCurrentVote.aEligibleVoters.removeAt(voterIndex);
                
                // Check if vote should end early
                if (m_pCurrentVote.ShouldEndEarly())
                {
                    ScheduleDelayedAction("end_vote", 0.1f, array<string>());
                }
            }
        }
        
        /**
         * Check if a player can vote
         */
        bool CanPlayerVote(const string &in szPlayerID)
        {
            PlayerVoteRecord@ record = GetPlayerRecord(szPlayerID);
            if (record is null)
                return true;  // New players can vote
                
            return record.CanVoteNow();
        }
        
        /**
         * Check if a player can initiate votes
         */
        bool CanPlayerInitiate(const string &in szPlayerID)
        {
            PlayerVoteRecord@ record = GetPlayerRecord(szPlayerID);
            if (record is null)
                return true;  // New players can initiate
                
            return record.CanInitiateNow();
        }
        
        // ========================================
        // State Queries
        // ========================================
        
        /**
         * Check if a vote is currently active
         */
        bool IsVoteActive()
        {
            return m_pCurrentVote !is null && m_pCurrentVote.eResult == VOTE_PENDING;
        }
        
        /**
         * Check if VoteManager is initialized
         */
        bool IsInitialized()
        {
            return m_bInitialized;
        }
        
        /**
         * Get current vote data (read-only)
         */
        VoteData@ GetCurrentVote()
        {
            return @m_pCurrentVote;
        }
        
        /**
         * Get vote time remaining
         */
        float GetTimeRemaining()
        {
            if (!IsVoteActive())
                return 0.0f;
                
            return max(0.0f, m_pCurrentVote.flEndTime - GetGameTime());
        }
        
        /**
         * Get vote progress information
         */
        void GetVoteProgress(string &out szTitle, string &out szDescription,
                            array<string> &out aOptions, array<uint> &out aTallies,
                            float &out flTimeRemaining)
        {
            if (!IsVoteActive())
            {
                szTitle = "";
                szDescription = "";
                aOptions.resize(0);
                aTallies.resize(0);
                flTimeRemaining = 0.0f;
                return;
            }
            
            szTitle = m_pCurrentVote.szTitle;
            szDescription = m_pCurrentVote.szDescription;
            
            aOptions.resize(0);
            aTallies.resize(0);
            
            for (uint i = 0; i < m_pCurrentVote.aOptionTitles.length(); i++)
            {
                aOptions.insertLast(m_pCurrentVote.aOptionTitles[i]);
                aTallies.insertLast(m_pCurrentVote.aVoteTallies[i]);
            }
            
            flTimeRemaining = GetTimeRemaining();
        }
        
        // ========================================
        // IVoteEvents Implementation
        // ========================================
        
        void OnVoteStarted(const string &in szVoteType, const string &in szInitiator)
        {
            LogEvent("VoteStarted", szVoteType + " initiated by " + szInitiator);
        }
        
        void OnVoteCast(CBasePlayer@ pPlayer, bool bYesVote)
        {
            if (pPlayer !is null)
            {
                string vote = bYesVote ? "Yes" : "No";
                LogEvent("VoteCast", pPlayer.GetName() + " voted " + vote);
            }
        }
        
        void OnVoteComplete(bool bPassed, uint nYesVotes, uint nNoVotes)
        {
            string result = bPassed ? "PASSED" : "FAILED";
            LogEvent("VoteComplete", "Vote " + result + " (" + nYesVotes + " yes, " + nNoVotes + " no)");
        }
        
        // ========================================
        // Private Helper Methods
        // ========================================
        
        private bool ParseVoteOptions(const string &in szOptions)
        {
            if (szOptions.isEmpty())
            {
                LogError("VoteManager: Empty vote options string");
                return false;
            }
            
            array<string> optionPairs = MS::Split(szOptions, ";");
            
            for (uint i = 0; i < optionPairs.length(); i++)
            {
                string pair = optionPairs[i];
                int colonPos = pair.findFirst(":");
                
                if (colonPos < 0)
                {
                    LogError("VoteManager: Invalid option format: " + pair);
                    return false;
                }
                
                string title = pair.substr(0, colonPos);
                string data = pair.substr(colonPos + 1);
                
                m_pCurrentVote.AddOption(pair, title, data);
            }
            
            if (m_pCurrentVote.aVoteOptions.length() == 0)
            {
                LogError("VoteManager: No valid vote options parsed");
                return false;
            }
            
            return true;
        }
        
        private void PopulateEligibleVoters()
        {
            m_pCurrentVote.aEligibleVoters.resize(0);
            
            array<CBasePlayer@> players = GetAllPlayers();
            LogInfo("VoteManager: PopulateEligibleVoters - found " + formatInt(players.length()) + " players");
            
            for (uint i = 0; i < players.length(); i++)
            {
                CBasePlayer@ player = players[i];
                if (player !is null && IsConnected(player))
                {
                    string playerID = GetSteamID(player);
                    bool canVote = CanPlayerVote(playerID);
                    LogInfo("VoteManager:   Player " + GetDisplayName(player) + " (ID: " + playerID + ") - canVote: " + (canVote ? "YES" : "NO"));
                    
                    if (canVote)
                    {
                        m_pCurrentVote.aEligibleVoters.insertLast(playerID);
                    }
                }
                else
                {
                    LogInfo("VoteManager:   Player at index " + formatInt(i) + " is " + (player is null ? "NULL" : "NOT CONNECTED"));
                }
            }
            
            LogInfo("VoteManager: PopulateEligibleVoters - total eligible: " + formatInt(m_pCurrentVote.aEligibleVoters.length()));
            
            // CRITICAL: If no eligible voters, the vote is invalid
            if (m_pCurrentVote.aEligibleVoters.length() == 0)
            {
                LogError("VoteManager: CRITICAL ERROR - No eligible voters found! Vote will fail.");
            }
        }
        
        private void CalculateVoteRequirements()
        {
            uint eligibleCount = m_pCurrentVote.aEligibleVoters.length();
            
            m_pCurrentVote.nMinVoters = max(uint(1), eligibleCount / 2);  // At least half must vote
            m_pCurrentVote.nRequiredVotes = max(uint(1), uint(eligibleCount * m_flPassThreshold));
            
            LogInfo("VoteManager: CalculateVoteRequirements - eligible: " + formatInt(eligibleCount) + 
                    ", minVoters: " + formatInt(m_pCurrentVote.nMinVoters) + 
                    ", requiredVotes: " + formatInt(m_pCurrentVote.nRequiredVotes));
        }
        
        private bool SendVoteToPlayers()
        {
            if (!IsVoteActive())
                return false;
            
            LogInfo("VoteManager: SendVoteToPlayers() - Initial vote state:");
            LogInfo("VoteManager:   Title: " + m_pCurrentVote.szTitle);
            LogInfo("VoteManager:   Eligible voters: " + formatInt(m_pCurrentVote.aEligibleVoters.length()));
            LogInfo("VoteManager:   Votes already cast: " + formatInt(m_pCurrentVote.GetTotalVotesCast()));
            LogInfo("VoteManager:   Duration: " + formatFloat(m_pCurrentVote.flDuration) + "s");
            LogInfo("VoteManager:   End time: " + formatFloat(m_pCurrentVote.flEndTime));
                
            // Announce vote start
            if (!m_pCurrentVote.bSilent)
            {
                BroadcastMessage(m_pCurrentVote.szTitle, m_pCurrentVote.szDescription);
            }
            
            // Send initial ballot immediately instead of using delayed action system
            LogInfo("VoteManager: Sending ballots immediately to " + formatInt(m_pCurrentVote.aEligibleVoters.length()) + " players");
            SendBallotsToPlayers();
            
            // Schedule vote end
            ScheduleDelayedAction("end_vote", m_pCurrentVote.flDuration, array<string>());
            
            LogInfo("VoteManager: Vote sent to players");
            return true;
        }
        
        private void UpdateActiveVote()
        {
            if (!IsVoteActive())
                return;
            
            LogInfo("VoteManager: UpdateActiveVote() checking vote status...");
            LogInfo("VoteManager:   Eligible voters: " + formatInt(m_pCurrentVote.aEligibleVoters.length()));
            LogInfo("VoteManager:   Votes cast: " + formatInt(m_pCurrentVote.GetTotalVotesCast()));
            LogInfo("VoteManager:   End time: " + formatInt(int(m_pCurrentVote.flEndTime)));
            LogInfo("VoteManager:   Current time: " + formatInt(int(GetGameTime())));
                
            // Check for expiration
            if (m_pCurrentVote.HasExpired())
            {
                LogInfo("VoteManager: Vote has EXPIRED - calling TallyVotes()");
                TallyVotes();
                return;
            }
            
            // Check for early completion
            if (m_pCurrentVote.ShouldEndEarly())
            {
                LogInfo("VoteManager: Vote should END EARLY - calling TallyVotes()");
                TallyVotes();
                return;
            }
            
            LogInfo("VoteManager: Vote is still active, no action needed");
        }
        
        private void UpdateDelayedActions()
        {
            for (int i = int(m_DelayedActions.length()) - 1; i >= 0; i--)
            {
                DelayedAction@ action = m_DelayedActions[i];
                
                if (action.ShouldExecute())
                {
                    ExecuteDelayedAction(action);
                    
                    if (action.ShouldRepeat())
                    {
                        action.ScheduleNext();
                    }
                    else
                    {
                        m_DelayedActions.removeAt(i);
                    }
                }
            }
        }
        
        private void ScheduleDelayedAction(const string &in szActionType, float flDelay,
                                         array<string>@ aParams)
        {
            DelayedAction action;
            action.szActionID = szActionType + "_" + int(GetGameTime() * 1000);
            action.szActionType = szActionType;
            action.flExecuteTime = GetGameTime() + flDelay;
            
            if (aParams !is null)
            {
                for (uint i = 0; i < aParams.length(); i++)
                {
                    action.aParameters.insertLast(aParams[i]);
                }
            }
            
            m_DelayedActions.insertLast(action);
        }
        
        private void ExecuteDelayedAction(DelayedAction@ action)
        {
            if (action.szActionType == "send_ballots")
            {
                SendBallotsToPlayers();
            }
            else if (action.szActionType == "end_vote")
            {
                TallyVotes();
            }
        }
        
        private void SendBallotsToPlayers()
        {
            if (!IsVoteActive())
                return;
                
            for (uint i = 0; i < m_pCurrentVote.aEligibleVoters.length(); i++)
            {
                string playerID = m_pCurrentVote.aEligibleVoters[i];
                
                if (!m_pCurrentVote.HasPlayerVoted(playerID))
                {
                    SendVoteMenuToPlayer(playerID);
                }
            }
        }
        
        private void SendVoteMenuToPlayer(const string &in szPlayerID)
        {
            LogInfo("VoteManager: SendVoteMenuToPlayer called for " + szPlayerID);
            
            if (!IsVoteActive())
            {
                LogWarning("VoteManager: No active vote when SendVoteMenuToPlayer called");
                return;
            }
                
            // Find the player by Steam ID
            CBasePlayer@ pPlayer = null;
            array<CBasePlayer@> players = GetAllPlayers();
            LogInfo("VoteManager: Searching through " + formatInt(players.length()) + " players");
            for (uint i = 0; i < players.length(); i++)
            {
                if (players[i] !is null && GetSteamID(players[i]) == szPlayerID)
                {
                    @pPlayer = players[i];
                    LogInfo("VoteManager: Found player " + GetDisplayName(pPlayer));
                    break;
                }
            }
            
            if (pPlayer is null)
            {
                LogWarning("VoteManager: Could not find player " + szPlayerID + " to send vote menu");
                return;
            }
            
            // Build the menu title
            string menuTitle = m_pCurrentVote.szTitle;
            LogInfo("VoteManager: Menu title: " + menuTitle);
            
            // Build the options array
            array<string> menuOptions;
            for (uint i = 0; i < m_pCurrentVote.aOptionTitles.length(); i++)
            {
                menuOptions.insertLast(m_pCurrentVote.aOptionTitles[i]);
            }
            LogInfo("VoteManager: Built " + formatInt(menuOptions.length()) + " menu options");
            
            // Open the vote menu on the client
            LogInfo("VoteManager: About to call OpenVoteMenu for " + GetDisplayName(pPlayer));
            OpenVoteMenu(pPlayer, menuTitle, menuOptions);
            LogInfo("VoteManager: OpenVoteMenu call completed for player " + GetDisplayName(pPlayer));
        }
        
        private void ExecuteVoteCallback(const string &in szEvent, const string &in szTitle,
                                       const string &in szData)
        {
            LogInfo("VoteManager: Executing callback '" + szEvent + "' with data '" + szData + "'");
            
            // Legacy callback handling for specific vote types
            if (szEvent == "gm_votemap")
            {
                HandleMapVoteCallback(szTitle, szData);
            }
            else if (szEvent == "gm_votepvp")
            {
                HandlePvpVoteCallback(szTitle, szData);
            }
            else if (szEvent == "gm_votelock")
            {
                HandleLockVoteCallback(szTitle, szData);
            }
            else if (szEvent == "gm_votekick_result")
            {
                HandleKickVoteCallback(szTitle, szData);
            }
            else if (szEvent == "gm_voteban_result")
            {
                HandleBanVoteCallback(szTitle, szData);
            }
            
            // Generic callback system would go here
            // CallEvent(szEvent, szTitle, szData);
        }
        
        private void HandleMapVoteCallback(const string &in szTitle, const string &in szData)
        {
            if (szData != "0")
            {
                LogInfo("VoteManager: Map vote passed - changing to " + szData);
                // Schedule map change
                ScheduleMapChange(szData);
            }
            else
            {
                LogInfo("VoteManager: Map vote failed");
            }
        }
        
        private void HandlePvpVoteCallback(const string &in szTitle, const string &in szData)
        {
            if (szData == "1")
            {
                LogInfo("VoteManager: PvP vote passed - enabling PvP");
                // Schedule PvP enable with countdown
                SchedulePvpChange(true);
            }
            else if (szData == "0")
            {
                LogInfo("VoteManager: PvP vote passed - disabling PvP");
                // Schedule PvP disable with countdown
                SchedulePvpChange(false);
            }
        }
        
        private void HandleLockVoteCallback(const string &in szTitle, const string &in szData)
        {
            if (szData == "1")
            {
                LogInfo("VoteManager: Server lock vote passed");
                // Generate random password and lock server
                LockServer();
            }
            else
            {
                LogInfo("VoteManager: Server lock vote failed");
            }
        }
        
        private void HandleKickVoteCallback(const string &in szTitle, const string &in szData)
        {
            if (MS::StartsWith(szData, "kick;"))
            {
                string targetID = szData.substr(5);
                LogInfo("VoteManager: Kick vote passed for player " + targetID);
                // Execute kick
                KickPlayer(targetID);
            }
        }
        
        private void HandleBanVoteCallback(const string &in szTitle, const string &in szData)
        {
            if (MS::StartsWith(szData, "ban;"))
            {
                string targetID = szData.substr(4);
                LogInfo("VoteManager: Ban vote passed for player " + targetID);
                // Execute ban
                BanPlayer(targetID);
            }
        }
        
        private PlayerVoteRecord@ GetPlayerRecord(const string &in szPlayerID)
        {
            PlayerVoteRecord@ record;
            if (!m_PlayerRecords.get(szPlayerID, @record))
            {
                @record = PlayerVoteRecord();
                record.Initialize(szPlayerID, GetPlayerName(szPlayerID), GetPlayerIP(szPlayerID));
                @m_PlayerRecords[szPlayerID] = @record;
            }
            return @record;
        }
        
        private void UpdatePlayerVoteRecord(const string &in szPlayerID, uint nChoice)
        {
            PlayerVoteRecord@ record = GetPlayerRecord(szPlayerID);
            if (record !is null && IsVoteActive())
            {
                record.RecordVote(m_pCurrentVote.szVoteID, nChoice);
            }
        }
        
        private void UpdatePlayerInitiationRecord(const string &in szPlayerID, bool bPassed)
        {
            PlayerVoteRecord@ record = GetPlayerRecord(szPlayerID);
            if (record !is null)
            {
                record.RecordInitiation(bPassed);
            }
        }
        
        // ========================================
        // Game Integration Functions
        // ========================================
        
        /**
         * Get player name by Steam ID or player index
         */
        private string GetPlayerName(const string &in szPlayerID) 
        {
            // Try to find player by Steam ID first
            CBasePlayer@ pPlayer = FindPlayerBySteamID(szPlayerID);
            if (pPlayer !is null)
            {
                return GetDisplayName(pPlayer);
            }
            
            // Try to parse as player index
            int nIndex = parseUInt(szPlayerID);
            if (nIndex > 0)
            {
                @pPlayer = PlayerByIndex(nIndex);
                if (pPlayer !is null)
                {
                    return GetDisplayName(pPlayer);
                }
            }
            
            return "Player";
        }
        
        /**
         * Get player IP address
         */
        private string GetPlayerIP(const string &in szPlayerID) 
        {
            CBasePlayer@ pPlayer = FindPlayerBySteamID(szPlayerID);
            if (pPlayer !is null)
            {
                return GetClientAddress(pPlayer);
            }
            
            int nIndex = parseUInt(szPlayerID);
            if (nIndex > 0)
            {
                @pPlayer = PlayerByIndex(nIndex);
                if (pPlayer !is null)
                {
                    return GetClientAddress(pPlayer);
                }
            }
            
            return "Unknown";
        }
        
        /**
         * Schedule a map change after a brief delay
         */
        private void ScheduleMapChange(const string &in szMap) 
        {
            if (szMap.isEmpty())
            {
                LogError("ScheduleMapChange: Empty map name");
                return;
            }
            
            LogInfo("Scheduling map change to: " + szMap);
            
            // Broadcast initial map change message
            BroadcastMessage("Map will change to " + szMap + " in 10 seconds!");
            
            // Schedule the actual changelevel command with countdown
            array<string> params;
            params.insertLast(szMap);
            
            // Countdown at 10, 5, 3, 2, 1 seconds
            array<float> countdownTimes = {10.0f, 5.0f, 3.0f, 2.0f, 1.0f};
            
            string szTaskID = GetScheduler().ScheduleTaskWithCountdown(
                10.0f,                      // Delay
                "ExecuteMapChange",         // Callback name
                params,                     // Parameters
                countdownTimes,             // Countdown times
                true                        // Server only
            );
            
            if (!szTaskID.isEmpty())
            {
                LogInfo("Map change scheduled with task ID: " + szTaskID);
            }
            else
            {
                LogError("Failed to schedule map change");
            }
        }
        
        /**
         * Schedule PvP mode change
         */
        private void SchedulePvpChange(bool bEnable) 
        {
            LogInfo("Scheduling PvP change: " + (bEnable ? "ENABLED" : "DISABLED"));
            
            string szMessage = "PvP mode will be " + (bEnable ? "enabled" : "disabled") + " in 5 seconds!";
            BroadcastMessage(szMessage);
            
            // Schedule PvP change with countdown
            array<string> params;
            params.insertLast(bEnable ? "1" : "0");
            
            array<float> countdownTimes = {5.0f, 3.0f, 2.0f, 1.0f};
            
            string szTaskID = GetScheduler().ScheduleTaskWithCountdown(
                5.0f,
                "ExecutePvpChange",
                params,
                countdownTimes,
                true
            );
            
            if (!szTaskID.isEmpty())
            {
                LogInfo("PvP change scheduled with task ID: " + szTaskID);
            }
        }
        
        /**
         * Lock the server with a random password
         */
        private void LockServer() 
        {
            LogInfo("Locking server...");
            
            // Generate a simple random password
            string szPassword = GenerateRandomPassword(8);
            
            // Set server password
            string szCommand = "sv_password " + szPassword + "\n";
            ServerCommand(szCommand);
            
            LogInfo("Server locked with password: " + szPassword);
            
            // Broadcast to admins only (for now broadcast to all)
            BroadcastMessage("Server has been locked. Password: " + szPassword);
        }
        
        /**
         * Generate a random password
         */
        private string GenerateRandomPassword(int nLength)
        {
            string szChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            string szPassword = "";
            
            for (int i = 0; i < nLength; i++)
            {
                int nIndex = int(Random(0, float(szChars.length() - 1)));
                szPassword += szChars[nIndex];
            }
            
            return szPassword;
        }
        
        /**
         * Kick a player from the server
         */
        private void KickPlayer(const string &in szPlayerID) 
        {
            LogInfo("Kicking player: " + szPlayerID);
            
            CBasePlayer@ pPlayer = FindPlayerBySteamID(szPlayerID);
            if (pPlayer is null)
            {
                // Try parsing as index
                int nIndex = parseUInt(szPlayerID);
                if (nIndex > 0)
                {
                    @pPlayer = PlayerByIndex(nIndex);
                }
            }
            
            if (pPlayer !is null)
            {
                string szPlayerName = GetDisplayName(pPlayer);
                
                BroadcastMessage("Player " + szPlayerName + " will be kicked in 3 seconds!");
                
                // Schedule kick with countdown
                array<string> params;
                params.insertLast(szPlayerID);
                params.insertLast(szPlayerName);
                
                array<float> countdownTimes = {3.0f, 2.0f, 1.0f};
                
                string szTaskID = GetScheduler().ScheduleTaskWithCountdown(
                    3.0f,
                    "ExecuteKickPlayer",
                    params,
                    countdownTimes,
                    true
                );
                
                if (!szTaskID.isEmpty())
                {
                    LogInfo("Kick scheduled for player " + szPlayerName + " with task ID: " + szTaskID);
                }
            }
            else
            {
                LogError("KickPlayer: Could not find player with ID: " + szPlayerID);
            }
        }
        
        /**
         * Ban a player from the server
         */
        private void BanPlayer(const string &in szPlayerID) 
        {
            LogInfo("Banning player: " + szPlayerID);
            
            CBasePlayer@ pPlayer = FindPlayerBySteamID(szPlayerID);
            if (pPlayer is null)
            {
                // Try parsing as index
                int nIndex = parseUInt(szPlayerID);
                if (nIndex > 0)
                {
                    @pPlayer = PlayerByIndex(nIndex);
                }
            }
            
            if (pPlayer !is null)
            {
                string szPlayerName = GetDisplayName(pPlayer);
                string szSteamID = GetSteamID(pPlayer);
                
                BroadcastMessage("Player " + szPlayerName + " will be banned in 3 seconds!");
                
                // Schedule ban with countdown
                array<string> params;
                params.insertLast(szSteamID);
                params.insertLast(szPlayerName);
                
                array<float> countdownTimes = {3.0f, 2.0f, 1.0f};
                
                string szTaskID = GetScheduler().ScheduleTaskWithCountdown(
                    3.0f,
                    "ExecuteBanPlayer",
                    params,
                    countdownTimes,
                    true
                );
                
                if (!szTaskID.isEmpty())
                {
                    LogInfo("Ban scheduled for player " + szPlayerName + " with task ID: " + szTaskID);
                }
            }
            else
            {
                LogError("BanPlayer: Could not find player with ID: " + szPlayerID);
            }
        }
        
        /**
         * Broadcast a message to all players
         */
        private void BroadcastMessage(const string &in szMessage, const string &in szDetails = "") 
        {
            string szFullMessage = szMessage;
            if (!szDetails.isEmpty())
            {
                szFullMessage += " - " + szDetails;
            }
            
            LogInfo("BROADCAST: " + szFullMessage);
            
            // Send message to all players
            SendMessageToAllPlayers("FFFFFF", szFullMessage);
        }
        
        /**
         * Helper function to find player by Steam ID
         */
        private CBasePlayer@ FindPlayerBySteamID(const string &in szSteamID)
        {
            if (szSteamID.isEmpty())
            {
                return null;
            }
            
            int nPlayerCount = GetPlayerCount();
            for (int i = 1; i <= nPlayerCount; i++)
            {
                CBasePlayer@ pPlayer = PlayerByIndex(i);
                if (pPlayer !is null && IsConnected(pPlayer))
                {
                    if (GetSteamID(pPlayer) == szSteamID)
                    {
                        return pPlayer;
                    }
                }
            }
            
            return null;
        }
        
        /**
         * Execute a server command
         * Wrapper for the engine's ExecuteServerCommand function
         */
        private void ServerCommand(const string &in szCommand)
        {
            // Call the engine's ExecuteServerCommand function
            // This is now properly exposed via ASBuiltinFunctions
            ExecuteServerCommand(szCommand);
        }
    }
    
    // ========================================
    // Global Vote Manager Instance
    // ========================================
    
    VoteManager g_VoteManager;
    
    /**
     * Get the global vote manager instance
     */
    VoteManager@ GetVoteManager()
    {
        return @g_VoteManager;
    }
    
    // ========================================
    // Public API Functions
    // ========================================
    
    /**
     * Initialize the voting system
     */
    bool InitializeVotingSystem()
    {
        return g_VoteManager.Initialize();
    }
    
    /**
     * Shutdown the voting system
     */
    void ShutdownVotingSystem()
    {
        g_VoteManager.Shutdown();
    }
    
    /**
     * Update the voting system (call from main game loop)
     */
    void UpdateVotingSystem()
    {
        g_VoteManager.Think();
    }
    
    /**
     * Legacy script compatibility function
     */
    bool gm_create_vote(const string &in szCallbackEvent, const string &in szOptions,
                       const string &in szTitle, const string &in szDescription = "",
                       bool bSilent = false)
    {
        return g_VoteManager.CreateVote(szCallbackEvent, szOptions, szTitle, szDescription, bSilent);
    }
    
    /**
     * Legacy script compatibility function - send vote to players
     */
    void gm_send_vote()
    {
        // This functionality is now handled automatically in CreateVote
        LogInfo("gm_send_vote: Vote distribution is handled automatically");
    }
    
    /**
     * Legacy script compatibility function - count votes
     */
    void gm_gvote_count(const string &in szPlayerID, const string &in szOptionData)
    {
        g_VoteManager.ProcessMenuSelection(szPlayerID, szOptionData);
    }
    
    /**
     * Legacy script compatibility function - tally votes
     */
    void gm_tally_votes()
    {
        g_VoteManager.TallyVotes();
    }
}