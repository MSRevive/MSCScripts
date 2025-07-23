/**
 * GameMasterDataStructures.as
 * 
 * Core data structures for the GameMaster voting and map transition systems.
 * Provides foundational classes that other agents will depend on for implementing
 * voting, map transitions, and player management features.
 */

namespace MS
{
    // ========================================
    // Enumerations
    // ========================================
    
    /**
     * Vote result enumeration
     */
    enum VoteResult
    {
        VOTE_PENDING = 0,
        VOTE_PASSED,
        VOTE_FAILED,
        VOTE_CANCELLED,
        VOTE_EXPIRED
    }
    
    /**
     * Vote type enumeration  
     */
    enum VoteType
    {
        VOTE_MAP = 0,
        VOTE_KICK,
        VOTE_BAN,
        VOTE_LOCK,
        VOTE_PVP,
        VOTE_CUSTOM
    }
    
    /**
     * Map validation result codes
     */
    enum MapValidationCode
    {
        MAP_VALID = 0,
        MAP_NOT_FOUND,
        MAP_HIDDEN,
        MAP_GAUNTLET_RESTRICTED,
        MAP_MAZE_RESTRICTED,
        MAP_FN_RESTRICTED,
        MAP_CURRENT_MAP,
        MAP_PERMISSION_DENIED
    }
    
    /**
     * Player vote permissions
     */
    enum VotePermission
    {
        PERM_NONE = 0,
        PERM_VOTE = 1,
        PERM_INITIATE = 2,
        PERM_ADMIN = 4,
        PERM_ALL = 7
    }
    
    // ========================================
    // Vote Data Structures
    // ========================================
    
    /**
     * Core voting data structure
     * Manages all aspects of an active vote including state, options, tallies, and callbacks
     */
    class VoteData
    {
        // Basic vote information
        string szVoteID;                    // Unique identifier for this vote
        VoteType eVoteType;                // Type of vote (map, kick, ban, etc.)
        string szTitle;                    // Display title for the vote
        string szDescription;              // Optional description text
        string szInitiatorID;              // Steam ID of player who started the vote
        string szInitiatorName;            // Display name of initiator
        string szTargetID;                 // Target player ID (for kick/ban votes)
        string szTargetData;               // Additional target data (map name, etc.)
        
        // Vote options and results
        array<string> aVoteOptions;        // Array of vote option strings (e.g., "Yes!:mapname", "No!:0")
        array<string> aOptionTitles;       // Display titles for each option
        array<string> aOptionData;         // Data associated with each option
        array<uint> aVoteTallies;          // Vote count for each option
        
        // Eligible voters and tracking
        array<string> aEligibleVoters;     // Steam IDs of players who can vote
        array<string> aVotesCast;          // Steam IDs of players who have voted
        array<uint> aVoterChoices;         // Choice index for each voter (parallel to aVotesCast)
        
        // Timing and state
        float flStartTime;                 // When the vote started (game time)
        float flDuration;                  // How long the vote should last
        float flEndTime;                   // When the vote will/did end
        VoteResult eResult;                // Current result state
        uint nWinningOption;               // Index of winning option
        bool bSilent;                      // Whether to suppress vote announcements
        bool bEarlyEnd;                    // Whether vote ended early (all voted)
        
        // Callback information
        string szCallbackEvent;            // Event to call when vote completes
        string szCallbackScript;           // Script containing callback event
        
        // Vote requirements
        uint nMinVoters;                   // Minimum voters required
        uint nRequiredVotes;               // Votes needed to pass (calculated)
        float flPassThreshold;             // Percentage needed to pass (0.5 = 50%)
        
        /**
         * Default constructor
         */
        VoteData()
        {
            szVoteID = "";
            eVoteType = VOTE_CUSTOM;
            szTitle = "";
            szDescription = "";
            szInitiatorID = "";
            szInitiatorName = "";
            szTargetID = "";
            szTargetData = "";
            
            flStartTime = 0.0f;
            flDuration = 30.0f;  // Default 30 second votes
            flEndTime = 0.0f;
            eResult = VOTE_PENDING;
            nWinningOption = 0;
            bSilent = false;
            bEarlyEnd = false;
            
            szCallbackEvent = "";
            szCallbackScript = "";
            
            nMinVoters = 1;
            nRequiredVotes = 1;
            flPassThreshold = 0.5f;
        }
        
        /**
         * Initialize vote with basic parameters
         */
        void Initialize(const string &in voteID, VoteType type, const string &in title,
                       const string &in initiatorID, const string &in initiatorName)
        {
            szVoteID = voteID;
            eVoteType = type;
            szTitle = title;
            szInitiatorID = initiatorID;
            szInitiatorName = initiatorName;
            flStartTime = GetGameTime();
            flEndTime = flStartTime + flDuration;
            eResult = VOTE_PENDING;
        }
        
        /**
         * Add a vote option
         */
        void AddOption(const string &in optionText, const string &in title, const string &in data)
        {
            aVoteOptions.insertLast(optionText);
            aOptionTitles.insertLast(title);
            aOptionData.insertLast(data);
            aVoteTallies.insertLast(0);
        }
        
        /**
         * Check if a player has already voted
         */
        bool HasPlayerVoted(const string &in playerID)
        {
            return aVotesCast.find(playerID) >= 0;
        }
        
        /**
         * Check if a player is eligible to vote
         */
        bool IsPlayerEligible(const string &in playerID)
        {
            return aEligibleVoters.find(playerID) >= 0;
        }
        
        /**
         * Cast a vote for a player
         */
        bool CastVote(const string &in playerID, uint optionIndex)
        {
            if (HasPlayerVoted(playerID) || !IsPlayerEligible(playerID) || 
                optionIndex >= aVoteTallies.length())
                return false;
                
            aVotesCast.insertLast(playerID);
            aVoterChoices.insertLast(optionIndex);
            aVoteTallies[optionIndex]++;
            
            return true;
        }
        
        /**
         * Get total votes cast
         */
        uint GetTotalVotesCast()
        {
            return aVotesCast.length();
        }
        
        /**
         * Get vote tally for an option
         */
        uint GetOptionTally(uint optionIndex)
        {
            if (optionIndex >= aVoteTallies.length())
                return 0;
            return aVoteTallies[optionIndex];
        }
        
        /**
         * Calculate winning option (handles ties)
         */
        uint CalculateWinner()
        {
            if (aVoteTallies.length() == 0)
                return 0;
                
            uint maxVotes = 0;
            array<uint> winners;
            
            // Find all options with the highest vote count
            for (uint i = 0; i < aVoteTallies.length(); i++)
            {
                if (aVoteTallies[i] > maxVotes)
                {
                    maxVotes = aVoteTallies[i];
                    winners.resize(0);
                    winners.insertLast(i);
                }
                else if (aVoteTallies[i] == maxVotes)
                {
                    winners.insertLast(i);
                }
            }
            
            // Handle ties - default to last option (usually "No" option)
            if (winners.length() == 0 || winners.length() == aVoteTallies.length())
            {
                return aVoteTallies.length() - 1;
            }
            else if (winners.length() > 1)
            {
                // Tie-breaker: choose randomly or default to last
                return winners[winners.length() - 1];  // Could use random here
            }
            
            return winners[0];
        }
        
        /**
         * Check if vote should end early (all eligible voters have voted)
         */
        bool ShouldEndEarly()
        {
            return GetTotalVotesCast() >= aEligibleVoters.length();
        }
        
        /**
         * Check if vote has expired
         */
        bool HasExpired()
        {
            return GetGameTime() >= flEndTime;
        }
        
        /**
         * Finalize the vote and determine result
         */
        VoteResult Finalize()
        {
            if (eResult != VOTE_PENDING)
                return eResult;
                
            nWinningOption = CalculateWinner();
            uint totalVotes = GetTotalVotesCast();
            
            if (totalVotes < nMinVoters)
            {
                eResult = VOTE_FAILED;
            }
            else
            {
                uint winningVotes = GetOptionTally(nWinningOption);
                float passRate = float(winningVotes) / float(totalVotes);
                
                eResult = (passRate >= flPassThreshold) ? VOTE_PASSED : VOTE_FAILED;
            }
            
            return eResult;
        }
    }
    
    // ========================================
    // Map Transition Data Structures
    // ========================================
    
    /**
     * Map transition data structure
     * Contains all information needed for transitioning between maps
     */
    class TransitionData
    {
        // Destination information
        string szDestinationMap;           // Target map name
        string szDestinationTitle;         // Display name for destination
        string szCurrentMap;               // Current map name
        string szTransitionID;             // Unique identifier for this transition
        
        // Spawn point information
        string szDestinationSpawn;         // Target spawn point name
        string szOriginSpawn;              // Origin spawn point (for return transitions)
        Vector3 vecSpawnPosition;          // Exact spawn coordinates (if not using named spawn)
        Vector3 vecSpawnAngles;            // Spawn orientation
        
        // Transition trigger information
        string szTriggerName;              // Name of trigger that initiated transition
        string szTriggerType;              // Type of trigger (touch_trans_, force_map_, etc.)
        EntityHandle hTriggerEntity;       // Handle to triggering entity
        
        // Player state management
        array<string> aTransferringPlayers; // Steam IDs of players being transferred
        array<Vector3> aPlayerPositions;    // Player positions before transition
        array<Vector3> aPlayerAngles;       // Player orientations before transition
        dictionary dPlayerData;             // Additional per-player data
        
        // Transition settings
        bool bForceTransition;             // Whether to skip voting
        bool bPreserveInventory;           // Whether players keep items
        bool bPreserveStats;               // Whether players keep stats/progress
        float flTransitionDelay;           // Delay before actual map change
        float flFadeTime;                  // Screen fade duration
        
        // Validation and permissions
        bool bRequiresVote;                // Whether transition needs vote
        bool bValidated;                   // Whether destination has been validated
        MapValidationCode eValidationResult; // Result of validation check
        string szValidationMessage;        // Human-readable validation message
        
        // Timing
        float flInitiationTime;            // When transition was initiated
        float flScheduledTime;             // When transition will execute
        
        /**
         * Default constructor
         */
        TransitionData()
        {
            szDestinationMap = "";
            szDestinationTitle = "";
            szCurrentMap = "";
            szTransitionID = "";
            
            szDestinationSpawn = "";
            szOriginSpawn = "";
            vecSpawnPosition = Vector3();
            vecSpawnAngles = Vector3();
            
            szTriggerName = "";
            szTriggerType = "";
            hTriggerEntity = EntityHandle();
            
            bForceTransition = false;
            bPreserveInventory = true;
            bPreserveStats = true;
            flTransitionDelay = 5.0f;
            flFadeTime = 2.0f;
            
            bRequiresVote = true;
            bValidated = false;
            eValidationResult = MAP_VALID;
            szValidationMessage = "";
            
            flInitiationTime = 0.0f;
            flScheduledTime = 0.0f;
        }
        
        /**
         * Initialize transition data
         */
        void Initialize(const string &in destination, const string &in current,
                       const string &in transitionID)
        {
            szDestinationMap = destination;
            szCurrentMap = current;
            szTransitionID = transitionID;
            flInitiationTime = GetGameTime();
            flScheduledTime = flInitiationTime + flTransitionDelay;
        }
        
        /**
         * Add a player to the transition
         */
        void AddPlayer(const string &in playerID, const Vector3 &in position, 
                      const Vector3 &in angles)
        {
            if (aTransferringPlayers.find(playerID) < 0)
            {
                aTransferringPlayers.insertLast(playerID);
                aPlayerPositions.insertLast(position);
                aPlayerAngles.insertLast(angles);
            }
        }
        
        /**
         * Remove a player from the transition
         */
        void RemovePlayer(const string &in playerID)
        {
            int index = aTransferringPlayers.find(playerID);
            if (index >= 0)
            {
                aTransferringPlayers.removeAt(index);
                aPlayerPositions.removeAt(index);
                aPlayerAngles.removeAt(index);
                dPlayerData.delete(playerID);
            }
        }
        
        /**
         * Get number of transferring players
         */
        uint GetPlayerCount()
        {
            return aTransferringPlayers.length();
        }
        
        /**
         * Set additional data for a player
         */
        void SetPlayerData(const string &in playerID, const string &in key, 
                          const string &in value)
        {
            string dictKey = playerID + ":" + key;
            dPlayerData[dictKey] = value;
        }
        
        /**
         * Get additional data for a player
         */
        string GetPlayerData(const string &in playerID, const string &in key)
        {
            string dictKey = playerID + ":" + key;
            string result;
            if (dPlayerData.get(dictKey, result))
                return result;
            return "";
        }
        
        /**
         * Check if transition is ready to execute
         */
        bool IsReadyToExecute()
        {
            return bValidated && 
                   eValidationResult == MAP_VALID && 
                   GetGameTime() >= flScheduledTime &&
                   GetPlayerCount() > 0;
        }
    }
    
    // ========================================
    // Player Vote Record
    // ========================================
    
    /**
     * Player voting history and permissions
     * Tracks individual player voting behavior and permissions
     */
    class PlayerVoteRecord
    {
        // Player identification
        string szPlayerID;                 // SteamID or unique identifier
        string szPlayerName;               // Display name
        string szIPAddress;                // IP address for tracking
        
        // Vote permissions
        VotePermission ePermissions;       // What vote actions player can perform
        bool bCanVote;                     // Can participate in votes
        bool bCanInitiate;                 // Can start votes
        bool bIsAdmin;                     // Has admin privileges
        bool bIsBanned;                    // Banned from voting
        
        // Vote history
        array<string> aVoteHistory;        // List of vote IDs participated in
        array<uint> aVoteChoices;          // Choices made (parallel to history)
        array<float> aVoteTimes;           // When votes were cast
        uint nVotesInitiated;              // Number of votes started by this player
        uint nVotesPassed;                 // Number of player's initiated votes that passed
        uint nVotesFailed;                 // Number of player's initiated votes that failed
        
        // Timing restrictions
        float flLastVoteTime;              // Last time player voted
        float flLastInitiateTime;          // Last time player started a vote
        float flVoteCooldown;              // Minimum time between votes
        float flInitiateCooldown;          // Minimum time between initiating votes
        
        // Behavior tracking
        uint nConsecutiveFailures;        // Failed vote initiations in a row
        float flTrustScore;                // Trust rating (0.0 - 1.0)
        array<string> aRecentTargets;      // Recent kick/ban targets
        
        // Connection information
        float flFirstSeen;                 // When player first connected
        float flLastSeen;                  // When player last connected
        uint nConnectionCount;             // Number of times connected
        
        /**
         * Default constructor
         */
        PlayerVoteRecord()
        {
            szPlayerID = "";
            szPlayerName = "";
            szIPAddress = "";
            
            ePermissions = PERM_VOTE;
            bCanVote = true;
            bCanInitiate = true;
            bIsAdmin = false;
            bIsBanned = false;
            
            nVotesInitiated = 0;
            nVotesPassed = 0;
            nVotesFailed = 0;
            
            flLastVoteTime = 0.0f;
            flLastInitiateTime = 0.0f;
            flVoteCooldown = 5.0f;    // 5 second vote cooldown
            flInitiateCooldown = 30.0f; // 30 second initiate cooldown
            
            nConsecutiveFailures = 0;
            flTrustScore = 1.0f;
            
            flFirstSeen = 0.0f;
            flLastSeen = 0.0f;
            nConnectionCount = 0;
        }
        
        /**
         * Initialize player record
         */
        void Initialize(const string &in playerID, const string &in playerName, 
                       const string &in ipAddress)
        {
            szPlayerID = playerID;
            szPlayerName = playerName;
            szIPAddress = ipAddress;
            flFirstSeen = GetGameTime();
            flLastSeen = flFirstSeen;
            nConnectionCount = 1;
        }
        
        /**
         * Update connection information
         */
        void UpdateConnection(const string &in playerName, const string &in ipAddress)
        {
            szPlayerName = playerName;
            szIPAddress = ipAddress;
            flLastSeen = GetGameTime();
            nConnectionCount++;
        }
        
        /**
         * Check if player can vote right now
         */
        bool CanVoteNow()
        {
            if (bIsBanned || !bCanVote)
                return false;
                
            float currentTime = GetGameTime();
            return (currentTime - flLastVoteTime) >= flVoteCooldown;
        }
        
        /**
         * Check if player can initiate a vote right now
         */
        bool CanInitiateNow()
        {
            if (bIsBanned || !bCanInitiate)
                return false;
                
            float currentTime = GetGameTime();
            return (currentTime - flLastInitiateTime) >= flInitiateCooldown;
        }
        
        /**
         * Record a vote cast by this player
         */
        void RecordVote(const string &in voteID, uint choice)
        {
            aVoteHistory.insertLast(voteID);
            aVoteChoices.insertLast(choice);
            aVoteTimes.insertLast(GetGameTime());
            flLastVoteTime = GetGameTime();
        }
        
        /**
         * Record a vote initiated by this player
         */
        void RecordInitiation(bool passed)
        {
            nVotesInitiated++;
            flLastInitiateTime = GetGameTime();
            
            if (passed)
            {
                nVotesPassed++;
                nConsecutiveFailures = 0;
                flTrustScore = min(1.0f, flTrustScore + 0.1f);
            }
            else
            {
                nVotesFailed++;
                nConsecutiveFailures++;
                flTrustScore = max(0.0f, flTrustScore - 0.1f);
            }
        }
        
        /**
         * Add a recent target (for kick/ban tracking)
         */
        void AddRecentTarget(const string &in targetID)
        {
            aRecentTargets.insertLast(targetID);
            
            // Keep only last 10 targets
            if (aRecentTargets.length() > 10)
            {
                aRecentTargets.removeAt(0);
            }
        }
        
        /**
         * Check if player recently targeted someone
         */
        bool HasRecentlyTargeted(const string &in targetID)
        {
            return aRecentTargets.find(targetID) >= 0;
        }
        
        /**
         * Get vote success rate
         */
        float GetSuccessRate()
        {
            if (nVotesInitiated == 0)
                return 1.0f;
            return float(nVotesPassed) / float(nVotesInitiated);
        }
        
        /**
         * Apply penalty for bad behavior
         */
        void ApplyPenalty(float severityMultiplier = 1.0f)
        {
            flTrustScore = max(0.0f, flTrustScore - (0.2f * severityMultiplier));
            flVoteCooldown = min(60.0f, flVoteCooldown + (5.0f * severityMultiplier));
            flInitiateCooldown = min(300.0f, flInitiateCooldown + (30.0f * severityMultiplier));
            
            // Disable voting privileges if trust score gets too low
            if (flTrustScore < 0.2f)
            {
                bCanInitiate = false;
            }
            if (flTrustScore < 0.1f)
            {
                bCanVote = false;
            }
        }
        
        /**
         * Restore voting privileges
         */
        void RestorePrivileges()
        {
            bCanVote = true;
            bCanInitiate = true;
            flTrustScore = min(1.0f, flTrustScore + 0.3f);
            flVoteCooldown = 5.0f;
            flInitiateCooldown = 30.0f;
            nConsecutiveFailures = 0;
        }
    }
    
    // ========================================
    // Map Validation Result
    // ========================================
    
    /**
     * Result of map validation check
     * Contains detailed information about whether a map can be transitioned to
     */
    class MapValidationResult
    {
        // Basic validation info
        string szMapName;                  // Map being validated
        MapValidationCode eResultCode;     // Validation result code
        bool bIsValid;                     // Whether map can be used
        string szErrorMessage;             // Human-readable error message
        string szValidatorID;              // ID of player who requested validation
        
        // Map properties
        bool bMapExists;                   // Whether map file exists on server
        bool bIsHidden;                    // Whether map is marked as hidden
        bool bIsGauntlet;                  // Whether map is part of gauntlet
        bool bIsMaze;                      // Whether map is part of maze
        bool bIsCurrent;                   // Whether this is the current map
        bool bIsFNRestricted;              // Whether map is restricted on FN servers
        
        // Permission checking
        bool bRequiresPermission;          // Whether special permission is needed
        bool bPlayerHasPermission;         // Whether requesting player has permission
        string szPermissionRequired;        // What permission is needed
        
        // Gauntlet/maze specific
        string szRequiredQuestMap;         // Map player must have in quest data
        string szRequiredValidatedMap;     // Map that must be validated
        bool bPlayerQualifies;             // Whether player meets requirements
        
        // Server restrictions
        string szVoteTypeRestriction;      // Server's vote type setting (all/root/nonfn)
        bool bFarmingAllowed;              // Whether voting for current map is allowed
        array<string> aAllowedMaps;        // Maps specifically allowed
        array<string> aRestrictedMaps;     // Maps specifically restricted
        
        // Additional context
        float flValidationTime;            // When validation was performed
        string szServerType;               // Type of server (FN, private, etc.)
        dictionary dAdditionalData;        // Extra validation data
        
        /**
         * Default constructor
         */
        MapValidationResult()
        {
            szMapName = "";
            eResultCode = MAP_VALID;
            bIsValid = false;
            szErrorMessage = "";
            szValidatorID = "";
            
            bMapExists = false;
            bIsHidden = false;
            bIsGauntlet = false;
            bIsMaze = false;
            bIsCurrent = false;
            bIsFNRestricted = false;
            
            bRequiresPermission = false;
            bPlayerHasPermission = false;
            szPermissionRequired = "";
            
            szRequiredQuestMap = "";
            szRequiredValidatedMap = "";
            bPlayerQualifies = false;
            
            szVoteTypeRestriction = "all";
            bFarmingAllowed = false;
            
            flValidationTime = 0.0f;
            szServerType = "";
        }
        
        /**
         * Initialize validation result
         */
        void Initialize(const string &in mapName, const string &in validatorID)
        {
            szMapName = mapName;
            szValidatorID = validatorID;
            flValidationTime = GetGameTime();
        }
        
        /**
         * Set validation failure with code and message
         */
        void SetFailure(MapValidationCode code, const string &in message)
        {
            eResultCode = code;
            bIsValid = false;
            szErrorMessage = message;
        }
        
        /**
         * Set validation success
         */
        void SetSuccess()
        {
            eResultCode = MAP_VALID;
            bIsValid = true;
            szErrorMessage = "";
        }
        
        /**
         * Set additional validation data
         */
        void SetAdditionalData(const string &in key, const string &in value)
        {
            dAdditionalData[key] = value;
        }
        
        /**
         * Get additional validation data
         */
        string GetAdditionalData(const string &in key)
        {
            string result;
            if (dAdditionalData.get(key, result))
                return result;
            return "";
        }
        
        /**
         * Get human-readable result description
         */
        string GetResultDescription()
        {
            if (bIsValid)
                return "Map '" + szMapName + "' is valid for transition.";
                
            switch (eResultCode)
            {
                case MAP_NOT_FOUND:
                    return "Map '" + szMapName + "' does not exist on this server.";
                case MAP_HIDDEN:
                    return "Map '" + szMapName + "' is hidden - you must find the entrance.";
                case MAP_GAUNTLET_RESTRICTED:
                    return "Map '" + szMapName + "' is part of a gauntlet - you must start from the beginning.";
                case MAP_MAZE_RESTRICTED:
                    return "Map '" + szMapName + "' is hidden in a maze - you must navigate to find it.";
                case MAP_FN_RESTRICTED:
                    return "Map '" + szMapName + "' cannot be used on FN servers.";
                case MAP_CURRENT_MAP:
                    return "You cannot vote for the map you are currently on.";
                case MAP_PERMISSION_DENIED:
                    return "You do not have permission to access map '" + szMapName + "'.";
                default:
                    return szErrorMessage.isEmpty() ? "Map validation failed." : szErrorMessage;
            }
        }
        
        /**
         * Check if this is a temporary restriction that might change
         */
        bool IsTemporaryRestriction()
        {
            return eResultCode == MAP_CURRENT_MAP;
        }
        
        /**
         * Check if this is a player-specific restriction
         */
        bool IsPlayerSpecific()
        {
            return eResultCode == MAP_GAUNTLET_RESTRICTED || 
                   eResultCode == MAP_MAZE_RESTRICTED ||
                   eResultCode == MAP_PERMISSION_DENIED;
        }
    }
    
    // ========================================
    // Utility Data Structures
    // ========================================
    
    /**
     * Vote option data structure
     * Represents a single voting option with associated data
     */
    class VoteOption
    {
        string szDisplayText;              // Text shown to players
        string szOptionData;               // Data associated with this option
        string szTooltip;                  // Optional tooltip/description
        bool bIsDefault;                   // Whether this is the default choice
        uint nVoteCount;                   // Current vote count for this option
        
        VoteOption()
        {
            szDisplayText = "";
            szOptionData = "";
            szTooltip = "";
            bIsDefault = false;
            nVoteCount = 0;
        }
        
        VoteOption(const string &in display, const string &in data)
        {
            szDisplayText = display;
            szOptionData = data;
            szTooltip = "";
            bIsDefault = false;
            nVoteCount = 0;
        }
    }
    
    /**
     * Time-based delay structure
     * Used for managing timed events and delays
     */
    class DelayedAction
    {
        string szActionID;                 // Unique identifier
        string szActionType;               // Type of action
        float flExecuteTime;               // When to execute
        array<string> aParameters;         // Action parameters
        bool bRepeating;                   // Whether action repeats
        float flRepeatInterval;            // Repeat interval if repeating
        uint nMaxRepeats;                  // Maximum number of repeats
        uint nCurrentRepeats;              // Current repeat count
        
        DelayedAction()
        {
            szActionID = "";
            szActionType = "";
            flExecuteTime = 0.0f;
            bRepeating = false;
            flRepeatInterval = 0.0f;
            nMaxRepeats = 0;
            nCurrentRepeats = 0;
        }
        
        bool ShouldExecute()
        {
            return GetGameTime() >= flExecuteTime;
        }
        
        bool ShouldRepeat()
        {
            return bRepeating && (nMaxRepeats == 0 || nCurrentRepeats < nMaxRepeats);
        }
        
        void ScheduleNext()
        {
            if (ShouldRepeat())
            {
                flExecuteTime = GetGameTime() + flRepeatInterval;
                nCurrentRepeats++;
            }
        }
    }
    
    // ========================================
    // Magic Hand Script Data (Legacy Compatibility)
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
    
    // Global arrays for compatibility with original script patterns
    const array<string> MAGIC_HAND_SCRIPTS1 = GetMagicHandScripts1();
    const array<string> MAGIC_HAND_NAMES1 = GetMagicHandNames1();
    const array<string> MAGIC_HAND_SCRIPTS2 = GetMagicHandScripts2();
    const array<string> MAGIC_HAND_NAMES2 = GetMagicHandNames2();
    const array<string> MAGIC_HAND_SCRIPTS3 = GetMagicHandScripts3();
    const array<string> MAGIC_HAND_NAMES3 = GetMagicHandNames3();
    
    /**
     * Find magic hand script in any group
     */
    string FindMagicHandScript(const string& scriptName)
    {
        // Check Group 1
        array<string> scripts1 = GetMagicHandScripts1();
        for (uint i = 0; i < scripts1.length(); i++)
        {
            if (scripts1[i] == scriptName)
                return scripts1[i];
        }
        
        // Check Group 2
        array<string> scripts2 = GetMagicHandScripts2();
        for (uint i = 0; i < scripts2.length(); i++)
        {
            if (scripts2[i] == scriptName)
                return scripts2[i];
        }
        
        // Check Group 3
        array<string> scripts3 = GetMagicHandScripts3();
        for (uint i = 0; i < scripts3.length(); i++)
        {
            if (scripts3[i] == scriptName)
                return scripts3[i];
        }
        
        return ""; // Not found
    }
    
    // ========================================
    // Legacy Constants (from GameMasterData.as)
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
}