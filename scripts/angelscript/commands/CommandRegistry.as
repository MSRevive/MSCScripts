/**
 * CommandRegistry.as
 * 
 * Core command registration and dispatch system for AngelScript.
 * Provides a flexible, secure command handler system with permission checking,
 * command aliasing, and dynamic command registration.
 * 
 * Key Features:
 * - Abstract CommandHandler interface for modular command implementations
 * - Secure permission checking system
 * - Command aliasing and dynamic registration
 * - Error handling and logging integration
 * - Support for both admin and player commands
 * 
 * Design Pattern:
 * - CommandHandler interface defines contract for all commands
 * - CommandRegistry manages command storage and dispatch
 * - PermissionChecker provides security layer
 * - CommandAlias system allows multiple names for same command
 */

namespace MS
{
    // ========================================
    // Permission Levels Enumeration
    // ========================================
    
    enum PermissionLevel
    {
        PERM_NONE = 0,          // No permissions
        PERM_PLAYER = 1,        // Basic player permissions
        PERM_ADMIN_STANDARD = 2, // Standard admin permissions  
        PERM_ADMIN_CVAR = 3,    // Cvar modification permissions
        PERM_ADMIN_RCON = 4,    // Full admin/rcon permissions
        PERM_DEVELOPER = 5      // Developer mode permissions
    }
    
    // ========================================
    // Command Result Enumeration
    // ========================================
    
    enum CommandResult
    {
        CMD_SUCCESS = 0,        // Command executed successfully
        CMD_FAILED = 1,         // Command failed to execute
        CMD_NO_PERMISSION = 2,  // Player lacks required permissions
        CMD_INVALID_SYNTAX = 3, // Invalid command syntax/arguments
        CMD_NOT_FOUND = 4,      // Command not found in registry
        CMD_ERROR = 5           // Internal error occurred
    }
    
    // ========================================
    // Abstract Command Handler Interface
    // ========================================
    
    /**
     * Interface for all command handlers.
     * All commands must implement this interface to be registerable.
     */
    interface CommandHandler
    {
        // Core command execution
        CommandResult Execute(CBasePlayer@ player, const array<string> &in args);
        
        // Permission checking
        bool HasPermission(CBasePlayer@ player);
        
        // Command documentation
        string GetUsage();
        string GetDescription();
        
        // Optional methods with default implementations
        PermissionLevel GetRequiredPermission();
        bool IsAdminCommand();
        bool IsDebugCommand();
        uint GetMinArguments();
        uint GetMaxArguments();
    }
    
    /**
     * Base command handler class with default implementations
     */
    class BaseCommandHandler : CommandHandler
    {
        // Required interface methods (must be implemented by derived classes)
        CommandResult Execute(CBasePlayer@ player, const array<string> &in args)
        {
            // Default implementation - should be overridden
            return CMD_FAILED;
        }
        
        bool HasPermission(CBasePlayer@ player)
        {
            // Default implementation - check permission level
            return CheckPlayerPermission(player, GetRequiredPermission());
        }
        
        string GetUsage()
        {
            // Default implementation - should be overridden
            return "No usage information available";
        }
        
        string GetDescription()
        {
            // Default implementation - should be overridden
            return "No description available";
        }
        
        // Default implementations for optional methods
        PermissionLevel GetRequiredPermission() { return PERM_PLAYER; }
        bool IsAdminCommand() { return false; }
        bool IsDebugCommand() { return false; }
        uint GetMinArguments() { return 0; }
        uint GetMaxArguments() { return 999; }
        
        // Helper method for permission checking using the permission system
        bool CheckPlayerPermission(CBasePlayer@ player, PermissionLevel requiredLevel)
        {
            if (player is null) return false;
            
            // Access permission checker through CommandRegistry
            CommandRegistry@ registry = GetCommandRegistry();
            if (registry is null) return false;
            
            PermissionChecker@ checker = registry.GetPermissionChecker();
            if (checker is null) return false;
            
            return checker.HasPermissionLevel(player, requiredLevel);
        }
        
        // Helper method for argument validation
        bool ValidateArguments(const array<string> &in args, string &out errorMessage)
        {
            uint minArgs = GetMinArguments();
            uint maxArgs = GetMaxArguments();
            
            if (args.length() < minArgs)
            {
                errorMessage = "Not enough arguments. Usage: " + GetUsage();
                return false;
            }
            
            if (args.length() > maxArgs)
            {
                errorMessage = "Too many arguments. Usage: " + GetUsage();
                return false;
            }
            
            return true;
        }
    }
    
    // ========================================
    // Permission Checker System
    // ========================================
    
    /**
     * Handles permission checking for command execution.
     * Integrates with the existing admin system and player manager.
     */
    class PermissionChecker
    {
        private bool m_bDeveloperModeEnabled = false;
        private string m_szDeveloperPlayer = "";
        
        /**
         * Initialize permission checker
         */
        void Initialize()
        {
            CheckDeveloperMode();
            LogMessage("[INFO] PermissionChecker initialized");
        }
        
        /**
         * Check if player has specific permission level
         */
        bool HasPermissionLevel(CBasePlayer@ player, PermissionLevel level)
        {
            if (player is null) return false;
            
            // Use if-else instead of switch for enum compatibility in AngelScript
            if (level == PERM_NONE)
            {
                return true;
            }
            else if (level == PERM_PLAYER)
            {
                return true; // All valid players have basic permissions
            }
            else if (level == PERM_ADMIN_STANDARD)
            {
                return IsPlayerAdmin(player);
            }
            else if (level == PERM_ADMIN_CVAR)
            {
                return HasAdminPrivilege(player, "cvar");
            }
            else if (level == PERM_ADMIN_RCON)
            {
                return HasAdminPrivilege(player, "rcon");
            }
            else if (level == PERM_DEVELOPER)
            {
                return IsPlayerDeveloper(player);
            }
            else
            {
                return false;
            }
        }
        
        /**
         * Check if player is admin (integrates with existing PlayerManager)
         */
        bool IsPlayerAdmin(CBasePlayer@ player)
        {
            if (player is null) return false;
            
            // Integration point: use existing admin system
            // For now, placeholder - will integrate with PlayerManager
            return CheckAdminFlag(player, "admin");
        }
        
        /**
         * Check if player has specific admin privilege
         */
        bool HasAdminPrivilege(CBasePlayer@ player, const string &in privilege)
        {
            if (player is null) return false;
            
            // Integration point: check specific admin privileges
            return CheckAdminFlag(player, privilege);
        }
        
        /**
         * Check if player is a developer
         */
        bool IsPlayerDeveloper(CBasePlayer@ player)
        {
            if (player is null) return false;
            
            if (!m_bDeveloperModeEnabled) return false;
            
            // Check if this is the designated developer player
            if (!m_szDeveloperPlayer.isEmpty())
            {
                return (player.GetName() == m_szDeveloperPlayer);
            }
            
            // Fallback: check admin status in dev mode
            return IsPlayerAdmin(player);
        }
        
        /**
         * Update developer mode settings
         */
        void SetDeveloperMode(bool enabled, const string &in devPlayer = "")
        {
            m_bDeveloperModeEnabled = enabled;
            m_szDeveloperPlayer = devPlayer;
            
            if (enabled)
            {
                LogMessage("[INFO] Developer mode enabled for: " + (devPlayer.isEmpty() ? "admins" : devPlayer));
            }
            else
            {
                LogMessage("[INFO] Developer mode disabled");
            }
        }
        
        /**
         * Check developer mode from server configuration
         */
        private void CheckDeveloperMode()
        {
            // Check cvar setting - placeholder for now
            string devMode = "0"; // GetCvar("ms_dev_mode");
            m_bDeveloperModeEnabled = (devMode == "1");
        }
        
        /**
         * Placeholder for admin flag checking - will integrate with existing systems
         */
        private bool CheckAdminFlag(CBasePlayer@ player, const string &in flag)
        {
            // Integration point: this will connect to the existing admin system
            // For now, return false as placeholder
            return false;
        }
    }
    
    // ========================================
    // Command Alias System
    // ========================================
    
    /**
     * Manages command aliases and alternative names
     */
    class CommandAlias
    {
        private dictionary m_Aliases; // string -> string mapping
        
        /**
         * Initialize with default aliases
         */
        void Initialize()
        {
            // Common command aliases
            RegisterAlias("tp", "teleport");
            RegisterAlias("players", "listplayers");
            RegisterAlias("spawns", "listspawns");
            RegisterAlias("dev", "devmode");
            RegisterAlias("gm", "gamemaster");
            RegisterAlias("admin", "adminhelp");
            RegisterAlias("help", "commands");
            
            LogMessage("[INFO] CommandAlias system initialized with default aliases");
        }
        
        /**
         * Register a new alias
         */
        void RegisterAlias(const string &in alias, const string &in actualCommand)
        {
            if (alias.isEmpty() || actualCommand.isEmpty()) return;
            
            m_Aliases[ToLower(alias)] = ToLower(actualCommand);
            LogMessage("[DEBUG] Registered alias: '" + alias + "' -> '" + actualCommand + "'");
        }
        
        /**
         * Resolve alias to actual command name
         */
        string ResolveAlias(const string &in command)
        {
            string lowerCommand = ToLower(command);
            string actualCommand;
            
            if (m_Aliases.get(lowerCommand, actualCommand))
            {
                return actualCommand;
            }
            
            return lowerCommand;
        }
        
        /**
         * Check if a string is an alias
         */
        bool IsAlias(const string &in command)
        {
            return m_Aliases.exists(ToLower(command));
        }
        
        /**
         * Get all registered aliases
         */
        array<string> GetAllAliases()
        {
            array<string> aliases;
            array<string> keys = m_Aliases.getKeys();
            
            for (uint i = 0; i < keys.length(); i++)
            {
                aliases.insertLast(keys[i]);
            }
            
            return aliases;
        }
        
        /**
         * Remove an alias
         */
        void RemoveAlias(const string &in alias)
        {
            m_Aliases.delete(ToLower(alias));
        }
        
        /**
         * Clear all aliases
         */
        void ClearAllAliases()
        {
            m_Aliases.deleteAll();
        }
    }
    
    // ========================================
    // Main Command Registry System
    // ========================================
    
    /**
     * Central command registration and dispatch system.
     * Manages command handlers, aliases, and execution workflow.
     */
    class CommandRegistry
    {
        private dictionary m_handlers;              // string -> CommandHandler@ mapping
        private dictionary m_commandMetadata;       // string -> CommandMetadata mapping
        private PermissionChecker@ m_permChecker;
        private CommandAlias@ m_aliasSystem;
        
        // Command execution statistics
        private uint m_nTotalCommands = 0;
        private uint m_nSuccessfulCommands = 0;
        private uint m_nFailedCommands = 0;
        private uint m_nPermissionDenied = 0;
        
        // Recent command history
        private array<string> m_recentCommands;
        private uint m_nMaxRecentCommands = 20;
        
        /**
         * Initialize the command registry
         */
        void Initialize()
        {
            LogMessage("[INFO] Initializing CommandRegistry system...");
            
            // Initialize subsystems
            @m_permChecker = PermissionChecker();
            m_permChecker.Initialize();
            
            @m_aliasSystem = CommandAlias();
            m_aliasSystem.Initialize();
            
            // Initialize command storage
            m_handlers.deleteAll();
            m_commandMetadata.deleteAll();
            m_recentCommands.resize(0);
            
            // Reset statistics
            m_nTotalCommands = 0;
            m_nSuccessfulCommands = 0;
            m_nFailedCommands = 0;
            m_nPermissionDenied = 0;
            
            LogMessage("[INFO] CommandRegistry initialized successfully");
        }
        
        /**
         * Shutdown the command registry
         */
        void Shutdown()
        {
            LogMessage("[INFO] Shutting down CommandRegistry...");
            
            // Clear all handlers and data
            m_handlers.deleteAll();
            m_commandMetadata.deleteAll();
            m_recentCommands.resize(0);
            
            // Clean up subsystems
            if (m_aliasSystem !is null)
            {
                m_aliasSystem.ClearAllAliases();
                @m_aliasSystem = null;
            }
            
            @m_permChecker = null;
            
            LogMessage("[INFO] CommandRegistry shutdown completed");
        }
        
        /**
         * Register a command handler with the registry
         */
        bool RegisterCommand(const string &in command, CommandHandler@ handler)
        {
            if (command.isEmpty() || handler is null)
            {
                LogMessage("[ERROR] Invalid parameters for RegisterCommand");
                return false;
            }
            
            string lowerCommand = ToLower(command);
            
            // Check if command already exists
            if (m_handlers.exists(lowerCommand))
            {
                LogMessage("[WARNING] Command '" + command + "' already registered, overwriting");
            }
            
            // Store the handler
            @m_handlers[lowerCommand] = handler;
            
            // Store metadata
            CommandMetadata metadata;
            metadata.commandName = lowerCommand;
            metadata.description = handler.GetDescription();
            metadata.usage = handler.GetUsage();
            metadata.requiredPermission = handler.GetRequiredPermission();
            metadata.isAdminCommand = handler.IsAdminCommand();
            metadata.isDebugCommand = handler.IsDebugCommand();
            metadata.registrationTime = GetCurrentTime();
            
            m_commandMetadata[lowerCommand] = metadata;
            
            LogMessage("[INFO] Registered command: '" + command + "' - " + handler.GetDescription());
            return true;
        }
        
        /**
         * Unregister a command from the registry
         */
        bool UnregisterCommand(const string &in command)
        {
            string lowerCommand = ToLower(command);
            
            if (!m_handlers.exists(lowerCommand))
            {
                LogMessage("[WARNING] Attempted to unregister non-existent command: " + command);
                return false;
            }
            
            m_handlers.delete(lowerCommand);
            m_commandMetadata.delete(lowerCommand);
            
            LogMessage("[INFO] Unregistered command: " + command);
            return true;
        }
        
        /**
         * Main command processing function
         */
        CommandResult ProcessCommand(CBasePlayer@ player, const string &in command, const array<string> &in args)
        {
            if (player is null || command.isEmpty())
            {
                LogMessage("[ERROR] Invalid parameters for ProcessCommand");
                return CMD_ERROR;
            }
            
            m_nTotalCommands++;
            
            // Resolve any aliases
            string actualCommand = m_aliasSystem.ResolveAlias(command);
            
            // Find the command handler
            CommandHandler@ handler;
            if (!m_handlers.get(actualCommand, @handler))
            {
                LogMessage("[DEBUG] Command not found: " + command + " (resolved: " + actualCommand + ")");
                m_nFailedCommands++;
                return CMD_NOT_FOUND;
            }
            
            // Check permissions
            if (!handler.HasPermission(player))
            {
                LogMessage("[WARNING] Permission denied for player " + player.GetName() + " on command: " + command);
                m_nPermissionDenied++;
                return CMD_NO_PERMISSION;
            }
            
            // Validate arguments using BaseCommandHandler's validation
            string errorMessage;
            BaseCommandHandler@ baseHandler = cast<BaseCommandHandler@>(handler);
            if (baseHandler !is null && !baseHandler.ValidateArguments(args, errorMessage))
            {
                LogMessage("[DEBUG] Invalid arguments for command '" + command + "': " + errorMessage);
                SendMessageToPlayer(player, errorMessage);
                m_nFailedCommands++;
                return CMD_INVALID_SYNTAX;
            }
            
            // Log command execution
            LogCommandExecution(player, actualCommand, args);
            
            // Execute the command
            CommandResult result = CMD_ERROR;
            try
            {
                result = handler.Execute(player, args);
            }
            catch
            {
                LogMessage("[ERROR] Exception during command execution: " + command);
                result = CMD_ERROR;
            }
            
            // Update statistics
            if (result == CMD_SUCCESS)
            {
                m_nSuccessfulCommands++;
            }
            else
            {
                m_nFailedCommands++;
            }
            
            return result;
        }
        
        /**
         * Process command from string (parses command and arguments)
         */
        CommandResult ProcessCommandString(CBasePlayer@ player, const string &in fullCommand)
        {
            if (fullCommand.isEmpty()) return CMD_INVALID_SYNTAX;
            
            // Parse command and arguments
            array<string> parts = fullCommand.split(" ");
            if (parts.length() == 0) return CMD_INVALID_SYNTAX;
            
            string command = parts[0];
            array<string> args;
            
            // Extract arguments
            for (uint i = 1; i < parts.length(); i++)
            {
                if (!parts[i].isEmpty())
                {
                    args.insertLast(parts[i]);
                }
            }
            
            return ProcessCommand(player, command, args);
        }
        
        /**
         * Check if a command exists in the registry
         */
        bool HasCommand(const string &in command)
        {
            string actualCommand = m_aliasSystem.ResolveAlias(command);
            return m_handlers.exists(actualCommand);
        }
        
        /**
         * Get list of all registered commands
         */
        array<string> GetAllCommands()
        {
            return m_handlers.getKeys();
        }
        
        /**
         * Get list of commands available to specific player
         */
        array<string> GetAvailableCommands(CBasePlayer@ player)
        {
            array<string> availableCommands;
            array<string> allCommands = GetAllCommands();
            
            for (uint i = 0; i < allCommands.length(); i++)
            {
                CommandHandler@ handler;
                if (m_handlers.get(allCommands[i], @handler))
                {
                    if (handler.HasPermission(player))
                    {
                        availableCommands.insertLast(allCommands[i]);
                    }
                }
            }
            
            return availableCommands;
        }
        
        /**
         * Get command handler for inspection
         */
        CommandHandler@ GetCommandHandler(const string &in command)
        {
            string actualCommand = m_aliasSystem.ResolveAlias(command);
            CommandHandler@ handler;
            m_handlers.get(actualCommand, @handler);
            return handler;
        }
        
        /**
         * Generate help text for a specific command
         */
        string GetCommandHelp(const string &in command)
        {
            CommandHandler@ handler = GetCommandHandler(command);
            if (handler is null)
            {
                return "Command '" + command + "' not found.";
            }
            
            string help = "Command: " + command + "\n";
            help += "Description: " + handler.GetDescription() + "\n";
            help += "Usage: " + handler.GetUsage();
            
            if (handler.IsAdminCommand())
            {
                help += "\n[Admin Command]";
            }
            
            if (handler.IsDebugCommand())
            {
                help += "\n[Debug Command]";
            }
            
            return help;
        }
        
        /**
         * Generate command statistics report
         */
        string GetStatisticsReport()
        {
            string report = "=== Command Registry Statistics ===\n";
            report += "Total Commands Registered: " + m_handlers.getSize() + "\n";
            report += "Total Commands Executed: " + m_nTotalCommands + "\n";
            report += "Successful Executions: " + m_nSuccessfulCommands + "\n";
            report += "Failed Executions: " + m_nFailedCommands + "\n";
            report += "Permission Denied: " + m_nPermissionDenied + "\n";
            
            if (m_nTotalCommands > 0)
            {
                float successRate = (float(m_nSuccessfulCommands) / float(m_nTotalCommands)) * 100.0f;
                report += "Success Rate: " + formatFloat(successRate, "", 1) + "%\n";
            }
            
            report += "Recent Commands: " + m_recentCommands.length() + "/" + m_nMaxRecentCommands;
            
            return report;
        }
        
        /**
         * Get permission checker instance
         */
        PermissionChecker@ GetPermissionChecker()
        {
            return m_permChecker;
        }
        
        /**
         * Get alias system instance
         */
        CommandAlias@ GetAliasSystem()
        {
            return m_aliasSystem;
        }
        
        /**
         * Log command execution
         */
        private void LogCommandExecution(CBasePlayer@ player, const string &in command, const array<string> &in args)
        {
            string logEntry = player.GetName() + " executed: " + command;
            
            if (args.length() > 0)
            {
                logEntry += " with args: ";
                for (uint i = 0; i < args.length(); i++)
                {
                    if (i > 0) logEntry += ", ";
                    logEntry += args[i];
                }
            }
            
            LogMessage("[INFO] " + logEntry);
            
            // Add to recent commands
            m_recentCommands.insertLast(logEntry);
            if (m_recentCommands.length() > m_nMaxRecentCommands)
            {
                m_recentCommands.removeAt(0);
            }
        }
        
        /**
         * Utility: Send message to player
         */
        private void SendMessageToPlayer(CBasePlayer@ player, const string &in message)
        {
            if (player is null) return;
            
            // Integration point: use actual player messaging system
            LogMessage("[MESSAGE] To " + player.GetName() + ": " + message);
        }
        
        /**
         * Utility: Get current time
         */
        private uint GetCurrentTime()
        {
            // Placeholder - will integrate with engine time functions
            return 0;
        }
        
        /**
         * Utility: Format float with precision
         */
        private string formatFloat(float value, const string &in prefix, uint precision)
        {
            // Simple formatting - can be enhanced
            return prefix + value;
        }
    }
    
    // ========================================
    // Command Metadata Structure
    // ========================================
    
    /**
     * Metadata associated with registered commands
     */
    class CommandMetadata
    {
        string commandName;
        string description;
        string usage;
        PermissionLevel requiredPermission;
        bool isAdminCommand;
        bool isDebugCommand;
        uint registrationTime;
        uint executionCount = 0;
        uint lastExecutionTime = 0;
    }
    
    // ========================================
    // Global Registry Instance
    // ========================================
    
    // Global command registry instance
    CommandRegistry@ g_CommandRegistry = null;
    
    /**
     * Initialize the global command registry
     */
    void InitializeCommandRegistry()
    {
        if (g_CommandRegistry !is null)
        {
            LogMessage("[WARNING] CommandRegistry already initialized, reinitializing...");
            g_CommandRegistry.Shutdown();
        }
        
        @g_CommandRegistry = CommandRegistry();
        g_CommandRegistry.Initialize();
        
        LogMessage("[INFO] Global CommandRegistry initialized");
    }

    /**
     * Shutdown the global command registry
     */
    void ShutdownCommandRegistry()
    {
        if (g_CommandRegistry !is null)
        {
            g_CommandRegistry.Shutdown();
            @g_CommandRegistry = null;
        }
        
        LogMessage("[INFO] Global CommandRegistry shutdown");
    }
    
    // ========================================
    // Convenience Functions
    // ========================================
    
    /**
     * Register a command globally
     */
    bool RegisterCommand(const string &in command, CommandHandler@ handler)
    {
        CommandRegistry@ registry = GetCommandRegistry();
        if (registry is null) return false;
        
        return registry.RegisterCommand(command, handler);
    }
    
    /**
     * Process a command globally
     */
    CommandResult ProcessCommand(CBasePlayer@ player, const string &in command, const array<string> &in args)
    {
        CommandRegistry@ registry = GetCommandRegistry();
        if (registry is null) return CMD_ERROR;
        
        return registry.ProcessCommand(player, command, args);
    }
    
    /**
     * Process command from full string globally
     */
    CommandResult ProcessCommandString(CBasePlayer@ player, const string &in fullCommand)
    {
        CommandRegistry@ registry = GetCommandRegistry();
        if (registry is null) return CMD_ERROR;
        
        return registry.ProcessCommandString(player, fullCommand);
    }
}