/**
 * CommandModule.as
 * 
 * Main command processing module that serves as the bridge between
 * the C++ ASCommandDispatcher and the AngelScript CommandRegistry system.
 * 
 * This module provides the global ProcessCommand function that 
 * ASCommandDispatcher expects to find.
 */

#include "commands/CommandRegistry.as"
#include "commands/VotingCommands.as"

namespace MS
{
    // Global CommandRegistry instance for the module
    CommandRegistry@ g_CommandModule_Registry = null;
    
    /**
     * Initialize the command module
     * Called when the module loads
     */
    void InitializeCommandModule()
    {
        LogMessage("[CommandModule] Initializing command processing module...");
        
        if (g_CommandModule_Registry is null)
        {
            @g_CommandModule_Registry = CommandRegistry();
            g_CommandModule_Registry.Initialize();
            LogMessage("[CommandModule] CommandRegistry created and initialized");
        }
        else
        {
            LogMessage("[CommandModule] CommandRegistry already exists - reusing instance");
        }
        
        // Register basic command handlers
        RegisterBasicCommands();
        
        // Register voting command handlers
        RegisterVotingCommands();
        
        LogMessage("[CommandModule] Command module initialization complete");
    }
    
    /**
     * Shutdown the command module
     */
    void ShutdownCommandModule()
    {
        LogMessage("[CommandModule] Shutting down command processing module...");
        
        if (g_CommandModule_Registry !is null)
        {
            g_CommandModule_Registry.Shutdown();
            @g_CommandModule_Registry = null;
        }
        
        LogMessage("[CommandModule] Command module shutdown complete");
    }
    
    /**
     * Get the command registry instance
     */
    CommandRegistry@ GetCommandRegistry()
    {
        if (g_CommandModule_Registry is null)
        {
            LogMessage("[CommandModule] WARNING: CommandRegistry not initialized - auto-initializing");
            InitializeCommandModule();
        }
        
        return g_CommandModule_Registry;
    }
    
    /**
     * Register basic command handlers for testing
     */
    void RegisterBasicCommands()
    {
        LogMessage("[CommandModule] Registering basic command handlers...");
        
        CommandRegistry@ registry = GetCommandRegistry();
        if (registry is null)
        {
            LogMessage("[CommandModule] ERROR: Failed to get CommandRegistry for handler registration");
            return;
        }
        
        // Register test command
        TestCommandHandler@ testHandler = TestCommandHandler();
        bool testRegistered = registry.RegisterCommand("test", testHandler);
        LogMessage("[CommandModule] Test command registration: " + (testRegistered ? "SUCCESS" : "FAILED"));
        
        // Register say command  
        SayCommandHandler@ sayHandler = SayCommandHandler();
        bool sayRegistered = registry.RegisterCommand("say", sayHandler);
        LogMessage("[CommandModule] Say command registration: " + (sayRegistered ? "SUCCESS" : "FAILED"));
        
        // Register help command
        HelpCommandHandler@ helpHandler = HelpCommandHandler();
        bool helpRegistered = registry.RegisterCommand("help", helpHandler);
        LogMessage("[CommandModule] Help command registration: " + (helpRegistered ? "SUCCESS" : "FAILED"));
        
        LogMessage("[CommandModule] Basic command handler registration complete");
    }
    
    /**
     * Register voting command handlers
     */
    void RegisterVotingCommands()
    {
        LogMessage("[CommandModule] Registering voting command handlers...");
        
        CommandRegistry@ registry = GetCommandRegistry();
        if (registry is null)
        {
            LogMessage("[CommandModule] ERROR: Failed to get CommandRegistry for voting handler registration");
            return;
        }
        
        // Register all voting commands through the VotingCommands module
        MS::RegisterVotingCommands(registry);
        
        LogMessage("[CommandModule] Voting command handler registration complete");
        
        // Log all registered commands for verification
        array<string> allCommands = registry.GetAllCommands();
        LogMessage("[CommandModule] Total registered commands: " + formatInt(allCommands.length()));
        for (uint i = 0; i < allCommands.length(); i++)
        {
            LogMessage("[CommandModule]   - " + allCommands[i]);
        }
    }
}

// ========================================
// Global Functions (Required by ASCommandDispatcher)
// ========================================

/**
 * Main command processing function called by ASCommandDispatcher
 * This is the entry point that the C++ ASCommandDispatcher expects to find
 */
bool ProcessCommand(CBasePlayer@ player, const string &in command, const string &in args)
{
    LogMessage("[CommandModule] ProcessCommand called: player=" + 
              (player !is null ? player.GetName() : "NULL") + 
              ", command='" + command + "', args='" + args + "'");
    
    // Validate parameters
    if (player is null)
    {
        LogMessage("[CommandModule] ERROR: ProcessCommand called with null player");
        return false;
    }
    
    if (command.isEmpty())
    {
        LogMessage("[CommandModule] ERROR: ProcessCommand called with empty command");
        return false;
    }
    
    // Get the command registry
    MS::CommandRegistry@ registry = MS::GetCommandRegistry();
    if (registry is null)
    {
        LogMessage("[CommandModule] ERROR: CommandRegistry not available");
        return false;
    }
    
    // Parse arguments into array
    array<string> argArray;
    if (!args.isEmpty())
    {
        // Simple space-based argument parsing
        array<string> parts = args.split(" ");
        for (uint i = 0; i < parts.length(); i++)
        {
            if (!parts[i].isEmpty())
            {
                argArray.insertLast(parts[i]);
            }
        }
    }
    
    LogMessage("[CommandModule] Processing command '" + command + "' with " + 
              formatInt(argArray.length()) + " arguments");
    
    // Process the command through the registry
    MS::CommandResult result = registry.ProcessCommand(player, command, argArray);
    
    // Log the result
    string resultStr = "";
    switch (result)
    {
        case MS::CMD_SUCCESS:
            resultStr = "SUCCESS";
            break;
        case MS::CMD_FAILED:
            resultStr = "FAILED";
            break;
        case MS::CMD_NO_PERMISSION:
            resultStr = "NO_PERMISSION";
            break;
        case MS::CMD_INVALID_SYNTAX:
            resultStr = "INVALID_SYNTAX";
            break;
        case MS::CMD_NOT_FOUND:
            resultStr = "NOT_FOUND";
            break;
        case MS::CMD_ERROR:
            resultStr = "ERROR";
            break;
        default:
            resultStr = "UNKNOWN(" + formatInt(int(result)) + ")";
            break;
    }
    
    LogMessage("[CommandModule] Command '" + command + "' result: " + resultStr);
    
    // Return true if command was found and processed (even if it failed)
    return (result != MS::CMD_NOT_FOUND && result != MS::CMD_ERROR);
}

/**
 * Initialize the command processing system
 * Called by the AngelScript manager during startup
 */
void InitializeCommands()
{
    LogMessage("[CommandModule] InitializeCommands called from AngelScript manager");
    MS::InitializeCommandModule();
}

/**
 * Shutdown the command processing system
 * Called by the AngelScript manager during shutdown
 */
void ShutdownCommands()
{
    LogMessage("[CommandModule] ShutdownCommands called from AngelScript manager");
    MS::ShutdownCommandModule();
}

// ========================================
// Basic Command Handler Implementations
// ========================================

/**
 * Test command handler for basic functionality testing
 */
class TestCommandHandler : MS::BaseCommandHandler
{
    MS::CommandResult Execute(CBasePlayer@ player, const array<string> &in args)
    {
        LogMessage("[TestCommand] Test command executed by " + player.GetName());
        
        // Send response to player
        string message = "Test command successful! Player: " + player.GetName();
        if (args.length() > 0)
        {
            message += " Args: ";
            for (uint i = 0; i < args.length(); i++)
            {
                if (i > 0) message += ", ";
                message += args[i];
            }
        }
        
        player.SendInfoMsg(message);
        LogMessage("[TestCommand] " + message);
        
        return MS::CMD_SUCCESS;
    }
    
    bool HasPermission(CBasePlayer@ player)
    {
        // Test command available to all players
        return true;
    }
    
    string GetUsage()
    {
        return "test [optional_arguments]";
    }
    
    string GetDescription()
    {
        return "Test command for verifying the command system functionality";
    }
}

/**
 * Say command handler for chat functionality
 */
class SayCommandHandler : MS::BaseCommandHandler
{
    MS::CommandResult Execute(CBasePlayer@ player, const array<string> &in args)
    {
        if (args.length() == 0)
        {
            player.SendInfoMsg("Usage: say <message>");
            return MS::CMD_INVALID_SYNTAX;
        }
        
        // Reconstruct message from arguments
        string message = "";
        for (uint i = 0; i < args.length(); i++)
        {
            if (i > 0) message += " ";
            message += args[i];
        }
        
        // Broadcast the message
        string broadcastMsg = player.GetName() + " says: " + message;
        
        // Send to all players
        array<CBasePlayer@> players = GetAllPlayers();
        for (uint i = 0; i < players.length(); i++)
        {
            if (players[i] !is null)
            {
                players[i].SendInfoMsg(broadcastMsg);
            }
        }
        
        LogMessage("[SayCommand] " + broadcastMsg);
        return MS::CMD_SUCCESS;
    }
    
    bool HasPermission(CBasePlayer@ player)
    {
        return true;
    }
    
    string GetUsage()
    {
        return "say <message>";
    }
    
    string GetDescription()
    {
        return "Broadcast a message to all players";
    }
}

/**
 * Help command handler for listing available commands
 */
class HelpCommandHandler : MS::BaseCommandHandler
{
    MS::CommandResult Execute(CBasePlayer@ player, const array<string> &in args)
    {
        MS::CommandRegistry@ registry = MS::GetCommandRegistry();
        if (registry is null)
        {
            player.SendInfoMsg("Error: Command registry not available");
            return MS::CMD_ERROR;
        }
        
        if (args.length() == 1)
        {
            // Show help for specific command
            string commandHelp = registry.GetCommandHelp(args[0]);
            player.SendInfoMsg(commandHelp);
        }
        else
        {
            // List all available commands
            array<string> availableCommands = registry.GetAvailableCommands(player);
            
            string message = "Available commands (" + formatInt(availableCommands.length()) + "):";
            player.SendInfoMsg(message);
            
            for (uint i = 0; i < availableCommands.length(); i++)
            {
                player.SendInfoMsg("  - " + availableCommands[i]);
            }
        }
        
        return MS::CMD_SUCCESS;
    }
    
    bool HasPermission(CBasePlayer@ player)
    {
        return true;
    }
    
    string GetUsage()
    {
        return "help [command_name]";
    }
    
    string GetDescription()
    {
        return "Show help for commands or list all available commands";
    }
}

// ========================================
// Module Auto-Initialization
// ========================================

// Auto-initialize when module loads
void ModuleInit()
{
    LogMessage("[CommandModule] Module loading - auto-initializing command system");
    MS::InitializeCommandModule();
}

// Auto-cleanup when module unloads  
void ModuleShutdown()
{
    LogMessage("[CommandModule] Module unloading - shutting down command system");
    MS::ShutdownCommandModule();
}