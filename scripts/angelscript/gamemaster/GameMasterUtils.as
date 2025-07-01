/**
 * GameMasterUtils.as
 * 
 * Utility functions for the GameMaster system
 */

namespace MS
{
    /**
     * Utility functions for GameMaster operations
     */
    
    // ============================================================================
    // Time Functions
    // ============================================================================
    
    /**
     * Get current game time in seconds
     */
    float GetGameTime()
    {
        return ::GetGameTime();
    }
    
    /**
     * Get current timestamp as string
     */
    string GetTimestamp()
    {
        return ::GetTimestamp();
    }
    
    // ============================================================================
    // Entity Management Functions
    // ============================================================================
    
    /**
     * Get player by index (1-based)
     */
    CBasePlayer@ GetPlayerByIndex(int index)
    {
        array<CBasePlayer@>@ players = ::GetAllPlayers();
        if (index > 0 && index <= int(players.length()))
        {
            return players[index - 1];
        }
        return null;
    }
    
    /**
     * Get all connected players
     */
    array<CBasePlayer@>@ GetAllPlayers()
    {
        return ::GetAllPlayers();
    }
    
    /**
     * Get number of connected players
     */
    int GetPlayerCount()
    {
        return ::GetPlayerCount();
    }
    
    // ============================================================================
    // Server Functions
    // ============================================================================
    
    /**
     * Get console variable value
     */
    string GetCvar(const string &in name)
    {
        return ::GetCvar(name);
    }
    
    /**
     * Get current map name
     */
    string GetMapName()
    {
        return ::GetMapName();
    }
    
    // ============================================================================
    // Math Utilities
    // ============================================================================
    
    /**
     * Generate random float between min and max
     */
    float RandomFloat(float min, float max)
    {
        return ::Random(min, max);
    }
    
    /**
     * Generate random integer between min and max
     */
    int RandomInt(int min, int max)
    {
        return ::RandomInt(min, max);
    }
    
    /**
     * Create a Vector3 from components
     */
    Vector3 MakeVector(float x, float y, float z)
    {
        return ::CreateVector(x, y, z);
    }
    
    /**
     * Create angles from pitch, yaw, roll
     */
    Vector3 MakeAngles(float pitch, float yaw, float roll)
    {
        return ::CreateAngles(pitch, yaw, roll);
    }
    
    // ============================================================================
    // Logging Functions
    // ============================================================================
    
    /**
     * Log info message
     */
    void LogInfo(const string &in message)
    {
        ::LogMessage("[INFO] " + message);
    }
    
    /**
     * Log error message
     */
    void LogError(const string &in message)
    {
        ::LogMessage("[ERROR] " + message);
    }
    
    /**
     * Log debug message
     */
    void LogDebug(const string &in message)
    {
        ::DeveloperMessage(1, "[DEBUG] " + message);
    }
    
    /**
     * Log warning message
     */
    void LogWarning(const string &in message)
    {
        ::LogMessage("[WARNING] " + message);
    }
    
    // ============================================================================
    // Legacy Compatibility Functions
    // ============================================================================
    
    /**
     * Set variable (placeholder for legacy setvard function)
     */
    void setvard(const string &in name, float value)
    {
        LogDebug("setvard: " + name + " = " + value);
    }
    
    /**
     * Set variable (placeholder for legacy setvarg function)
     */
    void setvarg(const string &in name, const string &in value)
    {
        LogDebug("setvarg: " + name + " = " + value);
    }
}