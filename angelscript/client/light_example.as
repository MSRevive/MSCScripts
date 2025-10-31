//==========================================================================
// light_example.as - Example client-side lighting using AngelScript
//
// Demonstrates how to use the CDynamicLight class for creating
// temporary and permanent lights on the client.
//
// Legacy command equivalent: cleffect light new <origin> <radius> <color> <duration>
//==========================================================================

// Create a temporary light (legacy: make_light.script)
void CreateTemporaryLight(Vector3 position, float radius, Color color, float duration)
{
    CDynamicLight@ light = CreateDynamicLight(position, radius, color, duration);
    
    if (light.IsValid())
    {
        MS_ANGEL_INFO("Created temporary light at position: " 
                      + position.x + "," + position.y + "," + position.z);
    }
    else
    {
        MS_ANGEL_ERROR("Failed to create temporary light");
    }
}

// Create a torch light effect
void CreateTorchLight(Vector3 position)
{
    Color orangeFlame = Color(255, 180, 60, 255);
    float radius = 256.0;
    float duration = 60.0;  // 60 seconds
    
    CDynamicLight@ light = CreateDynamicLight(position, radius, orangeFlame, duration);
    
    if (light.IsValid())
    {
        MS_ANGEL_INFO("Created torch light");
    }
}

// Create a light that follows an entity
void CreateFollowingLight(int entityIndex, Color color, float radius, float duration)
{
    CClientEntity@ ent = GetClientEntity(entityIndex);
    if (!ent.Exists()) return;
    
    Vector3 entPos = ent.GetOrigin();
    CDynamicLight@ light = CreateDynamicLight(entPos, radius, color, duration);
    
    if (light.IsValid())
    {
        light.FollowEntity(entityIndex);
        MS_ANGEL_INFO("Created light following entity " + entityIndex);
    }
}

// Create a dark light (removes light in an area)
void CreateDarkZone(Vector3 position, float radius, float duration)
{
    Color black = Color(0, 0, 0, 255);
    CDynamicLight@ light = CreateDynamicLight(position, radius, black, duration);
    
    if (light.IsValid())
    {
        light.SetDark(true);  // Make it a dark light
        MS_ANGEL_INFO("Created dark zone");
    }
}

// Create a pulsing light effect (would need timer system for full implementation)
void CreatePulsingLight(Vector3 position)
{
    Color white = Color(255, 255, 255, 255);
    float baseRadius = 200.0;
    float duration = 10.0;
    
    CDynamicLight@ light = CreateDynamicLight(position, baseRadius, white, duration);
    
    if (light.IsValid())
    {
        // In full implementation, would set up a timer to pulse the radius
        MS_ANGEL_INFO("Created light (pulsing would require timer callbacks)");
    }
}

// Example: Create colored lights around the player
void CreateColoredLightsAroundPlayer()
{
    CLocalPlayer@ player = GetLocalPlayer();
    if (player is null) return;
    
    Vector3 playerPos = player.GetOrigin();
    
    // Create red, green, and blue lights in a circle
    float angleStep = 120.0;  // 360/3 for 3 lights
    float distance = 200.0;
    
    for (int i = 0; i < 3; i++)
    {
        float angle = i * angleStep * 3.14159 / 180.0;  // Convert to radians
        Vector3 lightPos = playerPos;
        lightPos.x += cos(angle) * distance;
        lightPos.y += sin(angle) * distance;
        
        Color color;
        if (i == 0) color = Color(255, 0, 0, 255);       // Red
        else if (i == 1) color = Color(0, 255, 0, 255);  // Green
        else color = Color(0, 0, 255, 255);              // Blue
        
        CreateDynamicLight(lightPos, 150.0, color, 5.0);
    }
    
    MS_ANGEL_INFO("Created colored lights around player");
}

// Example usage:
// CreateTorchLight(Vector3(100, 200, 50));
// CreateFollowingLight(5, Color(255, 255, 0, 255), 200.0, 30.0);
// CreateDarkZone(Vector3(0, 0, 100), 512.0, 10.0);
// CreateColoredLightsAroundPlayer();

