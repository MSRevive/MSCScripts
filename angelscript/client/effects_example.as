//==========================================================================
// effects_example.as - Comprehensive client effects examples
//
// Demonstrates beams, temp entities, environment control, and sounds
// using the new AngelScript client-side API.
//==========================================================================

// Create a lightning beam between two points
void CreateLightningEffect(Vector3 start, Vector3 end, float duration)
{
    CBeam@ beam = CreateBeamPoints(start, end, "sprites/laserbeam.spr");
    
    if (beam.IsValid())
    {
        beam.SetWidth(20.0);
        beam.SetColor(Color(150, 150, 255, 255));
        beam.SetBrightness(255.0);
        beam.SetAmplitude(15.0);  // Make it wavy like lightning
        beam.SetLife(duration);
        
        MS_ANGEL_INFO("Created lightning beam");
    }
}

// Create a beam connecting two entities
void CreateEntityBeam(int startEntity, int endEntity, float duration)
{
    CBeam@ beam = CreateBeamEntities(startEntity, 0, endEntity, 0, "sprites/laserbeam.spr");
    
    if (beam.IsValid())
    {
        beam.SetWidth(10.0);
        beam.SetColor(Color(0, 255, 0, 255));
        beam.SetBrightness(200.0);
        beam.SetLife(duration);
        
        MS_ANGEL_INFO("Created entity connection beam");
    }
}

// Create a explosion effect with sprite and light
void CreateExplosionEffect(Vector3 position)
{
    // Create explosion sprite
    CTempEntity@ explosion = CreateTempSprite("sprites/zerogxplode.spr", position);
    if (explosion.IsValid())
    {
        explosion.SetScale(2.0);
        explosion.SetRenderMode(kRenderTransAdd);
        explosion.SetRenderAmount(255);
        explosion.SetFrameRate(15.0);
        explosion.SetDeathDelay(1.0);
        explosion.SetFadeout(true, 0.5);
    }
    
    // Create explosion light
    Color orangeFlash = Color(255, 150, 50, 255);
    CDynamicLight@ light = CreateDynamicLight(position, 400.0, orangeFlash, 0.5);
    
    // Play explosion sound
    CClientSound@ sound = GetClientSound();
    sound.PlaySoundAtPosition(position, "weapons/explode3.wav", 1.0);
    
    MS_ANGEL_INFO("Created explosion effect");
}

// Create a magic circle effect on the ground
void CreateMagicCircle(Vector3 position, Color color, float duration)
{
    CTempEntity@ circle = CreateTempSprite("sprites/flare6.spr", position);
    if (circle.IsValid())
    {
        circle.SetScale(3.0);
        circle.SetRenderMode(kRenderGlow);
        circle.SetRenderAmount(200);
        circle.SetRenderColor(color);
        circle.SetDeathDelay(duration);
        circle.SetFadeout(true, duration * 0.5);
        
        // Make it spin
        Vector3 angles = Vector3(90, 0, 0);  // Flat on ground
        circle.SetAngles(angles);
    }
    
    MS_ANGEL_INFO("Created magic circle");
}

// Set atmospheric effects
void SetDarkAtmosphere()
{
    CClientEnvironment@ env = GetEnvironment();
    
    // Dark red tint
    env.SetScreenTint(Color(50, 0, 0, 100));
    
    MS_ANGEL_INFO("Set dark atmosphere");
}

void SetFoggyAtmosphere()
{
    CClientEnvironment@ env = GetEnvironment();
    
    // Enable fog
    env.SetFogEnabled(true);
    env.SetFogColor(Color(200, 200, 200, 255));
    env.SetFogDensity(0.001);
    
    MS_ANGEL_INFO("Set foggy atmosphere");
}

void ClearAtmosphere()
{
    CClientEnvironment@ env = GetEnvironment();
    env.ClearScreenTint();
    env.SetFogEnabled(false);
    
    MS_ANGEL_INFO("Cleared atmosphere effects");
}

// Create particle trail effect (simplified)
void CreateParticleTrail(Vector3 start, Vector3 end, Color color)
{
    // Create several small sprites along the path
    int numParticles = 10;
    
    for (int i = 0; i < numParticles; i++)
    {
        float t = float(i) / float(numParticles);
        Vector3 pos;
        pos.x = start.x + (end.x - start.x) * t;
        pos.y = start.y + (end.y - start.y) * t;
        pos.z = start.z + (end.z - start.z) * t;
        
        CTempEntity@ particle = CreateTempSprite("sprites/hotglow.spr", pos);
        if (particle.IsValid())
        {
            particle.SetScale(0.5);
            particle.SetRenderMode(kRenderGlow);
            particle.SetRenderColor(color);
            particle.SetDeathDelay(2.0);
            particle.SetFadeout(true, 1.5);
        }
    }
    
    MS_ANGEL_INFO("Created particle trail");
}

// Create spark effects
void CreateSparkShower(Vector3 position, int numSparks)
{
    for (int i = 0; i < numSparks; i++)
    {
        CreateSpark(position);
    }
    
    MS_ANGEL_INFO("Created spark shower with " + numSparks + " sparks");
}

// Utility: Check ground and create effect at ground level
void CreateGroundEffect(Vector3 position)
{
    Vector3 groundPos = GetGroundHeight(position);
    
    MS_ANGEL_INFO("Ground height: " + groundPos.z);
    
    // Create light at ground level
    Color blue = Color(100, 100, 255, 255);
    CreateDynamicLight(groundPos, 200.0, blue, 3.0);
    
    // Create sprite
    CTempEntity@ sprite = CreateTempSprite("sprites/flare6.spr", groundPos);
    if (sprite.IsValid())
    {
        sprite.SetScale(2.0);
        sprite.SetRenderMode(kRenderGlow);
        sprite.SetRenderColor(blue);
        sprite.SetDeathDelay(3.0);
    }
}

// Example: Create a spell casting effect
void CreateSpellCastEffect()
{
    CLocalPlayer@ player = GetLocalPlayer();
    if (player is null) return;
    
    Vector3 playerPos = player.GetOrigin();
    Vector3 angles = player.GetViewAngles();
    
    // Create magic circle at player feet
    CreateMagicCircle(playerPos, Color(150, 50, 255, 255), 2.0);
    
    // Create beam shooting forward
    Vector3 endPos = playerPos;
    endPos.x += cos(angles.y * 3.14159 / 180.0) * 500.0;
    endPos.y += sin(angles.y * 3.14159 / 180.0) * 500.0;
    
    CBeam@ beam = CreateBeamEntPoint(player.GetIndex(), 0, endPos, "sprites/laserbeam.spr");
    if (beam.IsValid())
    {
        beam.SetWidth(15.0);
        beam.SetColor(Color(200, 50, 255, 255));
        beam.SetLife(0.5);
    }
    
    // Play spell sound
    CClientSound@ sound = GetClientSound();
    sound.PlaySound(SOUND_CHANNEL_WEAPON, "weapons/gauss2.wav", 1.0);
    
    MS_ANGEL_INFO("Created spell cast effect");
}

// Example usage:
// CreateLightningEffect(Vector3(0,0,100), Vector3(100,100,0), 2.0);
// CreateExplosionEffect(Vector3(100, 200, 50));
// SetDarkAtmosphere();
// CreateSpellCastEffect();

