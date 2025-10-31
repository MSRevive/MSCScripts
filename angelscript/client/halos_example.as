//==========================================================================
// halos_example.as - Example client-side halo rendering using AngelScript
// 
// This is a simplified demonstration of how to convert the legacy
// halos.script to use the new AngelScript client-side API.
//
// NOTE: Full implementation would require render callbacks which are
// still being developed in the client callback system.
//==========================================================================

// Global halo tracking
array<int> g_HaloPlayers;
array<int> g_DevHaloPlayers;
int g_HaloFrame = 0;
bool g_TrackingHalos = false;

// Main render loop (called each frame)
void OnRender()
{
    if (!g_TrackingHalos) return;
    
    // Increment halo animation frame
    g_HaloFrame++;
    if (g_HaloFrame > 1000) g_HaloFrame = 0;
    
    // Render halos for tracked players
    for (uint i = 0; i < g_HaloPlayers.length(); i++)
    {
        RenderPlayerHalo(g_HaloPlayers[i], false);
    }
    
    for (uint i = 0; i < g_DevHaloPlayers.length(); i++)
    {
        RenderPlayerHalo(g_DevHaloPlayers[i], true);
    }
}

// Render a single player's halo
void RenderPlayerHalo(int playerIndex, bool isDevHalo)
{
    CLocalPlayer@ localPlayer = GetLocalPlayer();
    if (localPlayer is null) return;
    
    // Don't render own halo in first person
    if (playerIndex == localPlayer.GetIndex() && !localPlayer.IsThirdPerson())
        return;
    
    // Get player entity
    CClientEntity@ player = GetClientEntity(playerIndex);
    if (!player.Exists()) return;
    
    // Get player head position (bone 14)
    Vector3 haloPos = player.GetBonePosition(14);
    haloPos.z += 15.0;  // Offset above head
    
    // Create sprite for halo
    CTempEntity@ halo = CreateFrameSprite("weapons/magic/seals.mdl", haloPos);
    if (halo.IsValid())
    {
        halo.SetFrame(g_HaloFrame);
        halo.SetScale(2.0);
        
        if (isDevHalo)
        {
            // Dev halo - blue and fancy (body 37)
            halo.SetBody(37);
            halo.SetRenderColor(Color(0, 0, 255, 255));
        }
        else
        {
            // Regular halo (body 31)
            halo.SetBody(31);
        }
        
        // Halo lasts one frame
        halo.SetDeathDelay(0.1);
    }
}

// Add player to halo tracking
void AddPlayerHalo(int playerIndex, int haloType)
{
    // haloType: 0 = remove, 1 = normal, 2 = dev
    
    if (haloType == 0)
    {
        // Remove halo
        RemoveFromArray(g_HaloPlayers, playerIndex);
        RemoveFromArray(g_DevHaloPlayers, playerIndex);
        
        if (g_HaloPlayers.length() == 0 && g_DevHaloPlayers.length() == 0)
            g_TrackingHalos = false;
    }
    else if (haloType == 1)
    {
        // Add normal halo
        if (!ArrayContains(g_HaloPlayers, playerIndex))
        {
            g_HaloPlayers.insertLast(playerIndex);
            g_TrackingHalos = true;
        }
        
        // Remove from dev halos if present
        RemoveFromArray(g_DevHaloPlayers, playerIndex);
    }
    else if (haloType == 2)
    {
        // Add dev halo
        if (!ArrayContains(g_DevHaloPlayers, playerIndex))
        {
            g_DevHaloPlayers.insertLast(playerIndex);
            g_TrackingHalos = true;
        }
        
        // Remove from normal halos if present
        RemoveFromArray(g_HaloPlayers, playerIndex);
    }
}

// Helper functions
bool ArrayContains(array<int>@ arr, int value)
{
    for (uint i = 0; i < arr.length(); i++)
    {
        if (arr[i] == value) return true;
    }
    return false;
}

void RemoveFromArray(array<int>@ arr, int value)
{
    for (uint i = 0; i < arr.length(); i++)
    {
        if (arr[i] == value)
        {
            arr.removeAt(i);
            return;
        }
    }
}

// Example usage:
// AddPlayerHalo(5, 1);  // Add normal halo to player 5
// AddPlayerHalo(3, 2);  // Add dev halo to player 3
// AddPlayerHalo(5, 0);  // Remove halo from player 5

