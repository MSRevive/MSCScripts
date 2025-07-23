/**
 * VotingCommands.as
 * 
 * Command handlers for voting commands (votemap, votepvp, votelock)
 * Bridges the command system to the GameMaster voting infrastructure
 * 
 * This file provides the command handlers that connect the ASCommandDispatcher
 * in C++ to the existing AngelScript voting system.
 */

#include "commands/CommandRegistry.as"
#include "gamemaster/GameMasterPlayerCommands.as"

// Bridge functions will be accessed through MS namespace

namespace MS
{
    // ========================================
    // Voting Command Handlers
    // ========================================
    
    /**
     * Votemap command handler
     * Handles "votemap [mapname]" commands
     */
    class VotemapCommandHandler : BaseCommandHandler
    {
        CommandResult Execute(CBasePlayer@ player, const array<string> &in args)
        {
            LogMessage("[VotemapCommand] Execute called by " + player.GetName() + 
                      " with " + formatInt(args.length()) + " arguments");
            
            // Get player information
            string playerName = player.GetName();
            string playerID = playerName; // Use player name as ID for now
            
            if (playerName.isEmpty())
            {
                LogMessage("[VotemapCommand] ERROR: Could not get player name");
                player.SendInfoMsg("Error: Could not identify player for voting");
                return CMD_ERROR;
            }
            
            // Check if player command system is ready
            if (!MS::IsPlayerCommandSystemReady())
            {
                LogMessage("[VotemapCommand] ERROR: Player command system not ready");
                player.SendInfoMsg("Error: Voting system not available");
                return CMD_ERROR;
            }
            
            // Build arguments array for the command
            array<string> commandArgs;
            
            // Add map name if provided
            if (args.length() > 0)
            {
                commandArgs.insertLast(args[0]);
            }
            else
            {
                // No map specified - this will trigger the map list display
                commandArgs.insertLast("param1");
            }
            
            // Additional arguments if provided
            for (uint i = 1; i < args.length(); i++)
            {
                commandArgs.insertLast(args[i]);
            }
            
            LogMessage("[VotemapCommand] Calling ProcessPlayerCommandBridge with " + 
                      formatInt(commandArgs.length()) + " arguments");
            
            // Call the existing voting system through the bridge
            try
            {
                MS::ProcessPlayerCommandBridge(playerID, playerName, "votemap", commandArgs);
                LogMessage("[VotemapCommand] ProcessPlayerCommandBridge completed successfully");
                return CMD_SUCCESS;
            }
            catch
            {
                LogMessage("[VotemapCommand] ERROR: Exception in ProcessPlayerCommandBridge");
                player.SendInfoMsg("Error: Failed to process votemap command");
                return CMD_ERROR;
            }
        }
        
        bool HasPermission(CBasePlayer@ player)
        {
            // Check if player command system is ready
            if (!MS::IsPlayerCommandSystemReady())
                return false;
                
            string playerName = player.GetName();
            if (playerName.isEmpty())
                return false;
                
            // Check player voting eligibility through the bridge function
            return MS::CanPlayerVoteNow(playerName);
        }
        
        string GetUsage()
        {
            return "votemap [mapname]";
        }
        
        string GetDescription()
        {
            return "Vote to change the map. Use without arguments to see available maps.";
        }
    }
    
    /**
     * Votepvp command handler
     * Handles "votepvp" commands
     */
    class VotepvpCommandHandler : BaseCommandHandler
    {
        CommandResult Execute(CBasePlayer@ player, const array<string> &in args)
        {
            LogMessage("[VotepvpCommand] Execute called by " + player.GetName());
            
            // Get player information
            string playerName = player.GetName();
            string playerID = playerName; // Use player name as ID for now
            
            if (playerName.isEmpty())
            {
                LogMessage("[VotepvpCommand] ERROR: Could not get player name");
                player.SendInfoMsg("Error: Could not identify player for voting");
                return CMD_ERROR;
            }
            
            // Check if player command system is ready
            if (!MS::IsPlayerCommandSystemReady())
            {
                LogMessage("[VotepvpCommand] ERROR: Player command system not ready");
                player.SendInfoMsg("Error: Voting system not available");
                return CMD_ERROR;
            }
            
            // Build arguments array for the command
            array<string> commandArgs;
            
            LogMessage("[VotepvpCommand] Calling ProcessPlayerCommandBridge");
            
            // Call the existing voting system through the bridge
            try
            {
                MS::ProcessPlayerCommandBridge(playerID, playerName, "votepvp", commandArgs);
                LogMessage("[VotepvpCommand] ProcessPlayerCommandBridge completed successfully");
                return CMD_SUCCESS;
            }
            catch
            {
                LogMessage("[VotepvpCommand] ERROR: Exception in ProcessPlayerCommandBridge");
                player.SendInfoMsg("Error: Failed to process votepvp command");
                return CMD_ERROR;
            }
        }
        
        bool HasPermission(CBasePlayer@ player)
        {
            // Check if player command system is ready
            if (!MS::IsPlayerCommandSystemReady())
                return false;
                
            string playerName = player.GetName();
            if (playerName.isEmpty())
                return false;
                
            // Check player voting eligibility through the bridge function
            return MS::CanPlayerVoteNow(playerName);
        }
        
        string GetUsage()
        {
            return "votepvp";
        }
        
        string GetDescription()
        {
            return "Vote to enable or disable PvP mode on the server.";
        }
    }
    
    /**
     * Votelock command handler
     * Handles "votelock" commands
     */
    class VotelockCommandHandler : BaseCommandHandler
    {
        CommandResult Execute(CBasePlayer@ player, const array<string> &in args)
        {
            LogMessage("[VotelockCommand] Execute called by " + player.GetName());
            
            // Get player information
            string playerName = player.GetName();
            string playerID = GetPlayerSteamID(player);
            
            if (playerID.isEmpty() || playerID == "STEAM_ID_INVALID")
            {
                LogMessage("[VotelockCommand] ERROR: Could not get player Steam ID");
                player.SendInfoMsg("Error: Could not identify player for voting");
                return CMD_ERROR;
            }
            
            // Check if player command system is ready
            if (!MS::IsPlayerCommandSystemReady())
            {
                LogMessage("[VotelockCommand] ERROR: Player command system not ready");
                player.SendInfoMsg("Error: Voting system not available");
                return CMD_ERROR;
            }
            
            // Build arguments array for the command
            array<string> commandArgs;
            
            LogMessage("[VotelockCommand] Calling ProcessPlayerCommandBridge");
            
            // Call the existing voting system through the bridge
            try
            {
                MS::ProcessPlayerCommandBridge(playerID, playerName, "votelock", commandArgs);
                LogMessage("[VotelockCommand] ProcessPlayerCommandBridge completed successfully");
                return CMD_SUCCESS;
            }
            catch
            {
                LogMessage("[VotelockCommand] ERROR: Exception in ProcessPlayerCommandBridge");
                player.SendInfoMsg("Error: Failed to process votelock command");
                return CMD_ERROR;
            }
        }
        
        bool HasPermission(CBasePlayer@ player)
        {
            // Check if player command system is ready
            if (!MS::IsPlayerCommandSystemReady())
                return false;
                
            string playerID = GetPlayerSteamID(player);
            if (playerID.isEmpty() || playerID == "STEAM_ID_INVALID")
                return false;
                
            // Check player voting eligibility through the bridge function
            return MS::CanPlayerVoteNow(playerID);
        }
        
        string GetUsage()
        {
            return "votelock";
        }
        
        string GetDescription()
        {
            return "Vote to lock the server with a password.";
        }
    }
    
    // ========================================
    // Registration Function
    // ========================================
    
    /**
     * Register all voting command handlers with the command registry
     */
    void RegisterVotingCommands(CommandRegistry@ registry)
    {
        if (registry is null)
        {
            LogMessage("[VotingCommands] ERROR: Cannot register voting commands - registry is null");
            return;
        }
        
        LogMessage("[VotingCommands] Registering voting command handlers...");
        
        // Register votemap command
        VotemapCommandHandler@ votemapHandler = VotemapCommandHandler();
        bool votemapRegistered = registry.RegisterCommand("votemap", votemapHandler);
        LogMessage("[VotingCommands] Votemap command registration: " + 
                  (votemapRegistered ? "SUCCESS" : "FAILED"));
        
        // Register votepvp command
        VotepvpCommandHandler@ votepvpHandler = VotepvpCommandHandler();
        bool votepvpRegistered = registry.RegisterCommand("votepvp", votepvpHandler);
        LogMessage("[VotingCommands] Votepvp command registration: " + 
                  (votepvpRegistered ? "SUCCESS" : "FAILED"));
        
        // Register votelock command
        VotelockCommandHandler@ votelockHandler = VotelockCommandHandler();
        bool votelockRegistered = registry.RegisterCommand("votelock", votelockHandler);
        LogMessage("[VotingCommands] Votelock command registration: " + 
                  (votelockRegistered ? "SUCCESS" : "FAILED"));
        
        // Log summary
        int successCount = (votemapRegistered ? 1 : 0) + 
                          (votepvpRegistered ? 1 : 0) + 
                          (votelockRegistered ? 1 : 0);
        LogMessage("[VotingCommands] Voting command registration complete: " + 
                  formatInt(successCount) + "/3 commands registered successfully");
    }
}

// ========================================
// Utility Functions
// ========================================

// Note: GetPlayerSteamID is now available as a global function from ASEntityBindings