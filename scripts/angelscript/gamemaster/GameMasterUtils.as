/**
 * GameMasterUtils.as
 * 
 * Utility functions for the GameMaster system
 * Provides helper functions for string operations, array management, and player validation
 * that are used by the voting and map transition systems.
 */

// ============================================================================
// Note: Engine functions are now globally bound via ASEntityBindings.cpp
// Functions available globally include:
// - Player functions: IsConnected, GetSteamID, GetDisplayName, GetAllPlayers, etc.
// - Game functions: GetCvar, GetGameTime, GetMapName, LogMessage, etc.
// - Math functions: sin, cos, sqrt, abs, min, max, Random, RandomInt, etc.
// - String functions: ToUpper, ToLower, Replace, split, Left, Right, Mid, etc.
// ============================================================================

namespace MS
{
    /**
     * Utility functions for GameMaster operations
     */
    
    // ============================================================================
    // Math Functions
    // ============================================================================
    
    /**
     * Ceiling function (rounds up to nearest integer)
     */
    int ceil(float value)
    {
        int intValue = int(value);
        if (value > intValue)
            return intValue + 1;
        return intValue;
    }
    
    // ============================================================================
    // Entity Management Functions (Only functions that add value)
    // ============================================================================
    
    /**
     * Get player by index (1-based indexing vs 0-based engine function)
     */
    CBasePlayer@ GetPlayerByIndex(int index)
    {
        array<CBasePlayer@>@ players = GetAllPlayers();
        if (index > 0 && index <= int(players.length()))
        {
            return players[index - 1];
        }
        return null;
    }
    
    /**
     * Get number of active players (alias for GetPlayerCount for clarity)
     */
    int GetActivePlayerCount()
    {
        return GetPlayerCount();
    }
    
    // ============================================================================
    // Logging Functions
    // ============================================================================
    
    /**
     * Log info message
     */
    void LogInfo(const string &in message)
    {
        LogMessage("[INFO] " + message);
    }
    
    /**
     * Log error message
     */
    void LogError(const string &in message)
    {
        LogMessage("[ERROR] " + message);
    }
    
    /**
     * Log debug message
     */
    void LogDebug(const string &in message)
    {
        DeveloperMessage(1, "[DEBUG] " + message);
    }
    
    /**
     * Log warning message
     */
    void LogWarning(const string &in message)
    {
        LogMessage("[WARNING] " + message);
    }
    
    // ============================================================================
    // String Helper Functions (from Legacy Scripts)
    // ============================================================================
    
    /**
     * Split a string into tokens using the specified separator
     * @param input The string to tokenize
     * @param separator The separator character(s) (default: ";")
     * @return Array of tokens
     */
    array<string> TokenizeString(const string &in input, const string &in separator = ";")
    {
            array<string> tokens;
            
            if (input.isEmpty())
                return tokens;
                
            string workString = input;
            int pos = 0;
            int sepLen = separator.length();
            
            while (true)
        {
                int foundPos = workString.findFirst(separator, pos);
                if (foundPos < 0)
            {
                    // Last token
                    string token = workString.substr(pos);
                    if (!token.isEmpty())
                        tokens.insertLast(token);
                    break;
                }
                else
            {
                    string token = workString.substr(pos, foundPos - pos);
                    if (!token.isEmpty())
                        tokens.insertLast(token);
                    pos = foundPos + sepLen;
                }
            }
            
            return tokens;
        }
        
        /**
         * Get a specific token from a tokenized string
         * @param input The string to tokenize
         * @param index The token index to retrieve (0-based)
         * @param separator The separator character(s) (default: ";")
         * @return The token at the specified index, or empty string if not found
         */
    string GetToken(const string &in input, int index, const string &in separator = ";")
    {
            array<string> tokens = TokenizeString(input, separator);
            if (index >= 0 && index < int(tokens.length()))
                return tokens[index];
            return "";
        }
        
        /**
         * Get the number of tokens in a string
         * @param input The string to tokenize
         * @param separator The separator character(s) (default: ";")
         * @return The number of tokens found
         */
    int GetTokenCount(const string &in input, const string &in separator = ";")
    {
            return int(TokenizeString(input, separator).length());
        }
        
        /**
         * Add a token to a tokenized string
         * @param input The existing tokenized string
         * @param token The token to add
         * @param separator The separator character(s) (default: ";")
         * @return The new tokenized string with the added token
         */
     string AddToken(const string &in input, const string &in token, const string &in separator = ";")
    {
            if (input.isEmpty())
                return token;
            return input + separator + token;
        }
        
        /**
         * Remove a token from a tokenized string by value
         * @param input The existing tokenized string
         * @param token The token to remove
         * @param separator The separator character(s) (default: ";")
         * @return The new tokenized string with the token removed
         */
     string RemoveToken(const string &in input, const string &in token, const string &in separator = ";")
    {
            array<string> tokens = TokenizeString(input, separator);
            string result = "";
            
            for (uint i = 0; i < tokens.length(); i++)
        {
                if (tokens[i] != token)
            {
                    if (!result.isEmpty())
                        result += separator;
                    result += tokens[i];
                }
            }
            
            return result;
        }
        
        /**
         * Remove a token from a tokenized string by index
         * @param input The existing tokenized string
         * @param index The index of the token to remove
         * @param separator The separator character(s) (default: ";")
         * @return The new tokenized string with the token removed
         */
     string RemoveTokenAt(const string &in input, int index, const string &in separator = ";")
    {
            array<string> tokens = TokenizeString(input, separator);
            
            if (index < 0 || index >= int(tokens.length()))
                return input;
                
            string result = "";
            for (uint i = 0; i < tokens.length(); i++)
        {
                if (int(i) != index)
            {
                    if (!result.isEmpty())
                        result += separator;
                    result += tokens[i];
                }
            }
            
            return result;
        }
        
        /**
         * Find the index of a token in a tokenized string
         * @param input The tokenized string to search
         * @param token The token to find
         * @param separator The separator character(s) (default: ";")
         * @return The index of the token, or -1 if not found
         */
     int FindToken(const string &in input, const string &in token, const string &in separator = ";")
    {
            array<string> tokens = TokenizeString(input, separator);
            
            for (uint i = 0; i < tokens.length(); i++)
        {
                if (tokens[i] == token)
                    return int(i);
            }
            
            return -1;
        }
        
        /**
         * Get a random token from a tokenized string
         * @param input The tokenized string
         * @param separator The separator character(s) (default: ";")
         * @return A random token from the string
         */
     string GetRandomToken(const string &in input, const string &in separator = ";")
    {
            array<string> tokens = TokenizeString(input, separator);
            
            if (tokens.length() == 0)
                return "";
                
            int randomIndex = RandomInt(0, int(tokens.length()) - 1);
            return tokens[randomIndex];
        }
        
        /**
         * Convert string to lowercase
         * @param input The string to convert
         * @return The lowercase version of the string
         */
     string ToLower(const string &in input)
    {
            string result = input;
            for (uint i = 0; i < result.length(); i++)
        {
                uint8 ch = result[i];
                if (ch >= 65 && ch <= 90) // 'A' to 'Z'
                    result[i] = ch + 32; // Convert to lowercase
            }
            return result;
        }
        
        /**
         * Convert string to uppercase
         * @param input The string to convert
         * @return The uppercase version of the string
         */
     string ToUpper(const string &in input)
    {
            string result = input;
            for (uint i = 0; i < result.length(); i++)
        {
                uint8 ch = result[i];
                if (ch >= 97 && ch <= 122) // 'a' to 'z'
                    result[i] = ch - 32; // Convert to uppercase
            }
            return result;
        }
        
        /**
         * Trim whitespace from both ends of a string
         * @param input The string to trim
         * @return The trimmed string
         */
     string Trim(const string &in input)
    {
            if (input.isEmpty())
                return input;
                
            uint start = 0;
            uint end = input.length() - 1;
            
            // Find first non-whitespace character
            while (start < input.length() && IsWhitespace(input[start]))
                start++;
                
            // Find last non-whitespace character
            while (end > start && IsWhitespace(input[end]))
                end--;
                
            if (start > end)
                return "";
                
            return input.substr(start, end - start + 1);
        }
        
        /**
         * Check if a character is whitespace
         * @param ch The character to check
         * @return True if the character is whitespace
         */
     bool IsWhitespace(uint8 ch)
    {
            return ch == 32 || ch == 9 || ch == 10 || ch == 13; // space, tab, newline, carriage return
        }
        
        /**
         * Replace all occurrences of a substring with another substring
         * @param input The input string
         * @param search The substring to search for
         * @param replacement The replacement substring
         * @return The string with replacements made
         */
     string Replace(const string &in input, const string &in search, const string &in replacement)
    {
            if (input.isEmpty() || search.isEmpty())
                return input;
                
            string result = input;
            int pos = 0;
            
            while ((pos = result.findFirst(search, pos)) >= 0)
        {
                result = result.substr(0, pos) + replacement + result.substr(pos + search.length());
                pos += replacement.length();
            }
            
            return result;
        }
        
        /**
         * Split a string by separator
         */
        array<string> Split(const string &in input, const string &in separator)
        {
            return TokenizeString(input, separator);
        }
        
        /**
         * Check if string starts with prefix
         */
        bool StartsWith(const string &in input, const string &in prefix)
        {
            if (prefix.length() > input.length())
                return false;
            return input.substr(0, prefix.length()) == prefix;
        }
    
    // ============================================================================
    // Array Helper Functions
    // ============================================================================
    
    /**
     * Check if an array contains a specific string value
     * @param arr The array to search
     * @param value The value to search for
     * @return True if the value is found
     */
    bool ContainsString(const array<string> &in arr, const string &in value)
    {
            return FindString(arr, value) >= 0;
        }
        
        /**
         * Find the index of a string value in an array
         * @param arr The array to search
         * @param value The value to search for
         * @return The index of the value, or -1 if not found
         */
     int FindString(const array<string> &in arr, const string &in value)
    {
            for (uint i = 0; i < arr.length(); i++)
        {
                if (arr[i] == value)
                    return int(i);
            }
            return -1;
        }
        
        /**
         * Remove all occurrences of a string value from an array
         * @param arr The array to modify
         * @param value The value to remove
         * @return The number of items removed
         */
     int RemoveString(array<string> &inout arr, const string &in value)
    {
            int removedCount = 0;
            
            for (int i = int(arr.length()) - 1; i >= 0; i--)
        {
                if (arr[i] == value)
            {
                    arr.removeAt(i);
                    removedCount++;
                }
            }
            
            return removedCount;
        }
        
        /**
         * Get a random element from a string array
         * @param arr The array to choose from
         * @return A random element, or empty string if array is empty
         */
     string GetRandomString(const array<string> &in arr)
    {
            if (arr.length() == 0)
                return "";
                
            uint randomIndex = RandomInt(0, int(arr.length()) - 1);
            return arr[randomIndex];
        }
        
        /**
         * Shuffle a string array in place
         * @param arr The array to shuffle
         */
     void ShuffleStrings(array<string> &inout arr)
    {
            for (uint i = arr.length() - 1; i > 0; i--)
        {
                uint j = RandomInt(0, int(i));
                string temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
        
        /**
         * Create a copy of a string array
         * @param source The source array
         * @return A copy of the array
         */
     array<string> CopyStringArray(const array<string> &in source)
    {
            array<string> result;
            for (uint i = 0; i < source.length(); i++)
                result.insertLast(source[i]);
            return result;
        }
        
        /**
         * Merge two string arrays, removing duplicates
         * @param arr1 The first array
         * @param arr2 The second array
         * @return A merged array with unique values
         */
     array<string> MergeUniqueStrings(const array<string> &in arr1, const array<string> &in arr2)
    {
            array<string> result = CopyStringArray(arr1);
            
            for (uint i = 0; i < arr2.length(); i++)
        {
                if (!ContainsString(result, arr2[i]))
                    result.insertLast(arr2[i]);
            }
            
            return result;
        }
    
    // ============================================================================
    // Player Helper Functions
    // ============================================================================
    
    /**
     * Get a player by their Steam ID
     * @param steamID The Steam ID to search for
     * @return The player entity, or null if not found
     */
    CBasePlayer@ GetPlayerBySteamID(const string &in steamID)
    {
            array<CBasePlayer@>@ players = GetAllPlayers();
            
            for (uint i = 0; i < players.length(); i++)
        {
                if (players[i] !is null)
            {
                    string playerSteamID = GetSteamID(players[i]);
                    if (playerSteamID == steamID)
                        return players[i];
                }
            }
            
            return null;
        }
        
        /**
         * Get a player by their display name (case-insensitive)
         * @param name The display name to search for
         * @return The player entity, or null if not found
         */
     CBasePlayer@ GetPlayerByName(const string &in name)
    {
            array<CBasePlayer@>@ players = GetAllPlayers();
            string searchName = ToLower(Trim(name));
            
            for (uint i = 0; i < players.length(); i++)
        {
                if (players[i] !is null)
            {
                    string playerName = ToLower(Trim(GetDisplayName(players[i])));
                    if (playerName == searchName)
                        return players[i];
                }
            }
            
            return null;
        }
        
        /**
         * Check if a player is valid and connected
         * @param player The player to check
         * @return True if the player is valid and connected
         */
     bool IsValidPlayer(CBasePlayer@ player)
    {
            return IsConnected(player);
        }
        
        /**
         * Get the Steam ID of a player as a string
         * @param player The player entity
         * @return The Steam ID as a string, or empty string if invalid
         */
     string GetPlayerSteamID(CBasePlayer@ player)
    {
            if (!IsValidPlayer(player))
                return "";
            return GetSteamID(player);
        }
        
        /**
         * Get the display name of a player
         * @param player The player entity
         * @return The display name, or empty string if invalid
         */
     string GetPlayerDisplayName(CBasePlayer@ player)
    {
            if (!IsValidPlayer(player))
                return "";
            return GetDisplayName(player);
        }
        
        /**
         * Check if a player has admin privileges
         * @param player The player to check
         * @return True if the player has admin privileges
         */
     bool IsPlayerAdmin(CBasePlayer@ player)
    {
            if (!IsValidPlayer(player))
                return false;
            return IsAdmin(player);
        }
        
        /**
         * Get all connected player Steam IDs
         * @return Array of Steam IDs for all connected players
         */
     array<string> GetAllPlayerSteamIDs()
    {
            array<string> steamIDs;
            array<CBasePlayer@>@ players = GetAllPlayers();
            
            for (uint i = 0; i < players.length(); i++)
        {
                if (IsValidPlayer(players[i]))
            {
                    steamIDs.insertLast(GetPlayerSteamID(players[i]));
                }
            }
            
            return steamIDs;
        }
        
        /**
         * Get all connected player display names
         * @return Array of display names for all connected players
         */
     array<string> GetAllPlayerNames()
    {
            array<string> names;
            array<CBasePlayer@>@ players = GetAllPlayers();
            
            for (uint i = 0; i < players.length(); i++)
        {
                if (IsValidPlayer(players[i]))
            {
                    names.insertLast(GetPlayerDisplayName(players[i]));
                }
            }
            
            return names;
        }
        
        /**
         * Check if a Steam ID corresponds to a connected player
         * @param steamID The Steam ID to check
         * @return True if a player with this Steam ID is connected
         */
     bool IsPlayerConnected(const string &in steamID)
    {
            return GetPlayerBySteamID(steamID) !is null;
        }
        
        /**
         * Get the player count for a specific condition
         * @param includeAdmins Whether to include admin players in the count
         * @return Number of players matching the condition
         */
     int GetPlayerCountFiltered(bool includeAdmins = true)
    {
            int count = 0;
            array<CBasePlayer@>@ players = GetAllPlayers();
            
            for (uint i = 0; i < players.length(); i++)
        {
                if (IsValidPlayer(players[i]))
            {
                    if (includeAdmins || !IsPlayerAdmin(players[i]))
                        count++;
                }
            }
            
            return count;
        }
        
        /**
         * Validate that a Steam ID has the correct format
         * @param steamID The Steam ID to validate
         * @return True if the Steam ID appears to be valid
         */
     bool IsValidSteamID(const string &in steamID)
    {
            // Basic validation - should start with "STEAM_" and contain appropriate characters
            if (steamID.isEmpty() || steamID.length() < 8)
                return false;
                
            if (steamID.findFirst("STEAM_") != 0)
                return false;
                
            // Additional validation could be added here
            return true;
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
    
    // ============================================================================
    // Convenience Functions
    // ============================================================================
    
    /**
     * Generate a unique ID for votes, transitions, etc.
     * @param prefix Optional prefix for the ID
     * @return A unique identifier string
     */
    string GenerateUniqueID(const string &in prefix = "")
    {
        string timestamp = formatFloat(GetGameTime(), "", 0, 6);
        string random = formatInt(RandomInt(1000, 9999));
        
        if (prefix.isEmpty())
            return timestamp + "_" + random;
        else
            return prefix + "_" + timestamp + "_" + random;
    }
    
    /**
     * Format a time duration in seconds to a human-readable string
     * @param seconds The duration in seconds
     * @return Formatted time string (e.g., "1m 30s", "45s")
     */
    string FormatDuration(float seconds)
    {
        if (seconds < 60.0f)
            return formatInt(int(seconds)) + "s";
        
        int minutes = int(seconds / 60.0f);
        int remainingSeconds = int(seconds) % 60;
        
        if (remainingSeconds == 0)
            return formatInt(minutes) + "m";
        else
            return formatInt(minutes) + "m " + formatInt(remainingSeconds) + "s";
    }
    
    /**
     * Calculate the percentage of players required for a vote to pass
     * @param totalPlayers Total number of eligible players
     * @param passThreshold Threshold percentage (0.0 - 1.0)
     * @return Number of votes required to pass
     */
    int CalculateRequiredVotes(int totalPlayers, float passThreshold = 0.5f)
    {
        if (totalPlayers <= 0)
            return 1;
            
        float required = float(totalPlayers) * passThreshold;
        return int(max(1.0f, MS::ceil(required)));
    }
}