#pragma context server

/**
 * Test script for Engine Event integration
 * 
 * This script tests the integration between C++ engine events 
 * and AngelScript event handlers.
 */

// Test handlers for engine events
void TestOnEnginePlayerConnect(const string &in szPlayerName, const string &in szSteamID)
{
    LogInfo("TEST: Player connected - Name: " + szPlayerName + ", SteamID: " + szSteamID);
}

void TestOnEnginePlayerDisconnect(const string &in szPlayerName, const string &in szSteamID)
{
    LogInfo("TEST: Player disconnected - Name: " + szPlayerName + ", SteamID: " + szSteamID);
}

void TestOnEngineMonsterKilled(const string &in szMonsterName, const string &in szKillerName, const Vector3 &in vecDeathPos)
{
    LogInfo("TEST: Monster killed - Monster: " + szMonsterName + 
            ", Killer: " + szKillerName + 
            ", Position: (" + formatFloat(vecDeathPos.x, "", 1, 1) + 
            ", " + formatFloat(vecDeathPos.y, "", 1, 1) + 
            ", " + formatFloat(vecDeathPos.z, "", 1, 1) + ")");
}

void TestOnEngineTreasureSpawned(const string &in szTreasureName, const Vector3 &in vecPos)
{
    LogInfo("TEST: Treasure spawned - Type: " + szTreasureName + 
            ", Position: (" + formatFloat(vecPos.x, "", 1, 1) + 
            ", " + formatFloat(vecPos.y, "", 1, 1) + 
            ", " + formatFloat(vecPos.z, "", 1, 1) + ")");
}

// Test registration function
void RegisterTestEventHandlers()
{
    LogInfo("TEST: Registering engine event test handlers...");
    
    // Register handlers with the engine event system
    RegisterEngineEvent("OnEnginePlayerConnect", TestOnEnginePlayerConnect);
    RegisterEngineEvent("OnEnginePlayerDisconnect", TestOnEnginePlayerDisconnect);
    RegisterEngineEvent("OnEngineMonsterKilled", TestOnEngineMonsterKilled);
    RegisterEngineEvent("OnEngineTreasureSpawned", TestOnEngineTreasureSpawned);
    
    LogInfo("TEST: Engine event test handlers registered successfully!");
    
    // Log current handlers
    LogEngineEventHandlers();
}

// Test unregistration function
void UnregisterTestEventHandlers()
{
    LogInfo("TEST: Unregistering engine event test handlers...");
    
    UnregisterEngineEvent("OnEnginePlayerConnect");
    UnregisterEngineEvent("OnEnginePlayerDisconnect");
    UnregisterEngineEvent("OnEngineMonsterKilled");
    UnregisterEngineEvent("OnEngineTreasureSpawned");
    
    LogInfo("TEST: Engine event test handlers unregistered!");
}

// Main test function
void TestEngineEventIntegration()
{
    LogInfo("=== Testing Engine Event Integration ===");
    
    // Register test handlers
    RegisterTestEventHandlers();
    
    LogInfo("TEST: Engine event integration test complete!");
    LogInfo("TEST: Connect/disconnect players, kill monsters, or spawn treasure to test events");
    LogInfo("TEST: Call UnregisterTestEventHandlers() to clean up when done");
}