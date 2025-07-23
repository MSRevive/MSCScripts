/**
 * WorldSystem.as
 * 
 * Environmental systems manager for Master Sword Rebirth
 * Handles dynamic lighting, weather cycles, and environmental effects
 * 
 * Converted from game_master.script lines 22-33 (lighting system)
 * and environmental functionality
 */

namespace MS
{
    /**
     * Light slot data structure for dynamic lighting system
     */
    class LightSlot
    {
        EntityHandle hOwner;      // Owner entity handle
        Color cColor;             // Light color (-1 = inactive)
        float flRadius;           // Light radius (-1 = inactive)
        bool bActive;             // Whether this slot is active
        
        LightSlot()
        {
            hOwner = EntityHandle();
            cColor = Color(-1, -1, -1);
            flRadius = -1.0f;
            bActive = false;
        }
    }
    
    /**
     * Weather state enumeration
     */
    enum WeatherState
    {
        WEATHER_CLEAR = 0,
        WEATHER_CLOUDY,
        WEATHER_RAIN,
        WEATHER_STORM,
        WEATHER_FOG,
        WEATHER_SNOW
    }
    
    /**
     * Time of day enumeration for lighting calculations
     */
    enum TimeOfDay
    {
        TIME_DAWN = 0,
        TIME_MORNING,
        TIME_MIDDAY,
        TIME_AFTERNOON,
        TIME_DUSK,
        TIME_NIGHT,
        TIME_MIDNIGHT
    }
    
    /**
     * World System manager class
     * Handles environmental effects, lighting, and weather
     */
    class WorldSystem
    {
    private:
        // Constants from game_master.script line 22
        const uint LIGHTSYS_N_LIGHTS = 16;
        
        // Dynamic lighting system (from lines 22-33)
        array<LightSlot> m_LightSlots;
        uint m_nActiveLights;
        
        // Weather system
        WeatherState m_CurrentWeather;
        WeatherState m_TargetWeather;
        float m_flWeatherTransitionTime;
        float m_flWeatherChangeTimer;
        
        // Time-based lighting
        TimeOfDay m_CurrentTimeOfDay;
        Color m_AmbientLightColor;
        float m_flAmbientLightIntensity;
        
        // Environmental effects
        bool m_bEnvironmentalEffectsEnabled;
        float m_flWindStrength;
        Vector3 m_vecWindDirection;
        
        // System state
        bool m_bInitialized;
        EntityHandle m_hSelf;
        
    public:
        /**
         * Constructor - Initialize the world system
         */
        WorldSystem()
        {
            m_bInitialized = false;
            m_nActiveLights = 0;
            m_CurrentWeather = WEATHER_CLEAR;
            m_TargetWeather = WEATHER_CLEAR;
            m_flWeatherTransitionTime = 0.0f;
            m_flWeatherChangeTimer = Random(300.0f, 600.0f); // 5-10 minutes
            m_CurrentTimeOfDay = TIME_MIDDAY;
            m_AmbientLightColor = Color(255, 255, 255);
            m_flAmbientLightIntensity = 1.0f;
            m_bEnvironmentalEffectsEnabled = true;
            m_flWindStrength = 0.5f;
            m_vecWindDirection = Vector3(1.0f, 0.0f, 0.0f);
            
            InitializeLightSystem();
        }
        
        /**
         * Initialize the dynamic lighting system
         * Based on game_master.script lines 22-33
         */
        void InitializeLightSystem()
        {
            LogMessage("WorldSystem: Initializing lighting system with " + LIGHTSYS_N_LIGHTS + " slots");
            
            // Initialize light slots (equivalent to init_lights loop)
            m_LightSlots.resize(LIGHTSYS_N_LIGHTS);
            for (uint i = 0; i < LIGHTSYS_N_LIGHTS; i++)
            {
                m_LightSlots[i] = LightSlot();
                LogMessage("[DEBUG] Light slot " + i + " initialized");
            }
            
            m_bInitialized = true;
            LogMessage("WorldSystem: Lighting system initialized successfully");
        }
        
        /**
         * Register a dynamic light source
         * @param hOwner Entity that owns this light
         * @param cColor Light color
         * @param flRadius Light radius
         * @return Light slot index, or -1 if no slots available
         */
        int RegisterLight(EntityHandle hOwner, const Color &in cColor, float flRadius)
        {
            if (!m_bInitialized)
            {
                LogMessage("[ERROR] WorldSystem: Attempted to register light before initialization");
                return -1;
            }
            
            // Find an available light slot
            for (uint i = 0; i < LIGHTSYS_N_LIGHTS; i++)
            {
                if (!m_LightSlots[i].bActive)
                {
                    m_LightSlots[i].hOwner = hOwner;
                    m_LightSlots[i].cColor = cColor;
                    m_LightSlots[i].flRadius = flRadius;
                    m_LightSlots[i].bActive = true;
                    m_nActiveLights++;
                    
                    LogMessage("[INFO] WorldSystem: Registered light " + i + " for entity (R:" + 
                           cColor.r + " G:" + cColor.g + " B:" + cColor.b + ", Radius:" + flRadius + ")");
                    
                    return int(i);
                }
            }
            
            LogMessage("[WARNING] WorldSystem: No available light slots (all " + LIGHTSYS_N_LIGHTS + " in use)");
            return -1;
        }
        
        /**
         * Unregister a dynamic light source
         * @param nSlot Light slot index to release
         */
        void UnregisterLight(int nSlot)
        {
            if (nSlot < 0 || nSlot >= int(LIGHTSYS_N_LIGHTS))
            {
                LogMessage("[ERROR] WorldSystem: Invalid light slot " + nSlot);
                return;
            }
            
            if (m_LightSlots[nSlot].bActive)
            {
                m_LightSlots[nSlot] = LightSlot(); // Reset to default state
                m_nActiveLights--;
                LogMessage("[INFO] WorldSystem: Unregistered light " + nSlot);
            }
            else
            {
                LogMessage("[WARNING] WorldSystem: Attempted to unregister inactive light slot " + nSlot);
            }
        }
        
        /**
         * Update a dynamic light's properties
         * @param nSlot Light slot index
         * @param cColor New light color
         * @param flRadius New light radius
         */
        void UpdateLight(int nSlot, const Color &in cColor, float flRadius)
        {
            if (nSlot < 0 || nSlot >= int(LIGHTSYS_N_LIGHTS))
            {
                LogMessage("[ERROR] WorldSystem: Invalid light slot " + nSlot);
                return;
            }
            
            if (m_LightSlots[nSlot].bActive)
            {
                m_LightSlots[nSlot].cColor = cColor;
                m_LightSlots[nSlot].flRadius = flRadius;
                LogMessage("[DEBUG] WorldSystem: Updated light " + nSlot);
            }
            else
            {
                LogMessage("[WARNING] WorldSystem: Attempted to update inactive light slot " + nSlot);
            }
        }
        
        /**
         * Get information about a light slot
         * @param nSlot Light slot index
         * @return Light slot data, or null if invalid
         */
        LightSlot@ GetLightSlot(int nSlot)
        {
            if (nSlot < 0 || nSlot >= int(LIGHTSYS_N_LIGHTS))
            {
                return null;
            }
            
            return @m_LightSlots[nSlot];
        }
        
        /**
         * Get the number of active lights
         */
        uint GetActiveLightCount() const
        {
            return m_nActiveLights;
        }
        
        /**
         * Set the current weather state
         * @param newWeather Target weather state
         * @param flTransitionTime Time to transition in seconds
         */
        void SetWeather(WeatherState newWeather, float flTransitionTime = 30.0f)
        {
            if (newWeather == m_CurrentWeather)
                return;
                
            m_TargetWeather = newWeather;
            m_flWeatherTransitionTime = flTransitionTime;
            
            LogMessage("[INFO] WorldSystem: Transitioning weather from " + int(m_CurrentWeather) + 
                   " to " + int(newWeather) + " over " + flTransitionTime + " seconds");
        }
        
        /**
         * Get the current weather state
         */
        WeatherState GetCurrentWeather() const
        {
            return m_CurrentWeather;
        }
        
        /**
         * Update time-based lighting effects
         * @param nHour Current game hour (0-23)
         */
        void UpdateTimeOfDayLighting(int nHour)
        {
            TimeOfDay newTimeOfDay = TIME_MIDDAY;
            Color newAmbientColor = Color(255, 255, 255);
            float newIntensity = 1.0f;
            
            // Determine time of day and lighting
            if (nHour >= 5 && nHour < 7)
            {
                newTimeOfDay = TIME_DAWN;
                newAmbientColor = Color(255, 200, 150); // Warm dawn light
                newIntensity = 0.6f;
            }
            else if (nHour >= 7 && nHour < 11)
            {
                newTimeOfDay = TIME_MORNING;
                newAmbientColor = Color(255, 240, 200); // Bright morning
                newIntensity = 0.8f;
            }
            else if (nHour >= 11 && nHour < 15)
            {
                newTimeOfDay = TIME_MIDDAY;
                newAmbientColor = Color(255, 255, 255); // Pure white
                newIntensity = 1.0f;
            }
            else if (nHour >= 15 && nHour < 18)
            {
                newTimeOfDay = TIME_AFTERNOON;
                newAmbientColor = Color(255, 220, 180); // Warm afternoon
                newIntensity = 0.9f;
            }
            else if (nHour >= 18 && nHour < 20)
            {
                newTimeOfDay = TIME_DUSK;
                newAmbientColor = Color(255, 150, 100); // Orange dusk
                newIntensity = 0.4f;
            }
            else if (nHour >= 20 || nHour < 2)
            {
                newTimeOfDay = TIME_NIGHT;
                newAmbientColor = Color(100, 100, 150); // Blue night
                newIntensity = 0.2f;
            }
            else // 2-5 AM
            {
                newTimeOfDay = TIME_MIDNIGHT;
                newAmbientColor = Color(80, 80, 120); // Deep night
                newIntensity = 0.1f;
            }
            
            // Update lighting if changed
            if (newTimeOfDay != m_CurrentTimeOfDay)
            {
                m_CurrentTimeOfDay = newTimeOfDay;
                m_AmbientLightColor = newAmbientColor;
                m_flAmbientLightIntensity = newIntensity;
                
                LogMessage("[DEBUG] WorldSystem: Time of day changed to " + int(newTimeOfDay) + 
                        " (Hour " + nHour + ", Intensity " + newIntensity + ")");
            }
        }
        
        /**
         * Update environmental effects (called periodically)
         * @param flDeltaTime Time since last update
         */
        void UpdateEnvironmentalEffects(float flDeltaTime)
        {
            if (!m_bEnvironmentalEffectsEnabled)
                return;
                
            // Update weather transition
            if (m_CurrentWeather != m_TargetWeather)
            {
                m_flWeatherTransitionTime -= flDeltaTime;
                if (m_flWeatherTransitionTime <= 0.0f)
                {
                    m_CurrentWeather = m_TargetWeather;
                    LogMessage("[INFO] WorldSystem: Weather transition complete to " + int(m_CurrentWeather));
                }
            }
            
            // Update weather change timer
            m_flWeatherChangeTimer -= flDeltaTime;
            if (m_flWeatherChangeTimer <= 0.0f)
            {
                // Randomly change weather
                array<WeatherState> possibleWeather = {
                    WEATHER_CLEAR, WEATHER_CLOUDY, WEATHER_RAIN, WEATHER_FOG
                };
                
                WeatherState newWeather = possibleWeather[RandomInt(0, possibleWeather.length() - 1)];
                SetWeather(newWeather, Random(20.0f, 60.0f));
                
                m_flWeatherChangeTimer = Random(300.0f, 900.0f); // 5-15 minutes
            }
            
            // Update wind effects
            if (Random(0.0f, 1.0f) < 0.01f) // 1% chance per update
            {
                m_flWindStrength = Random(0.2f, 1.0f);
                
                // Generate random wind direction without trigonometric functions
                // Use simple random x,y coordinates and normalize
                float x = Random(-1.0f, 1.0f);
                float y = Random(-1.0f, 1.0f);
                
                // Normalize the vector to get a unit direction vector
                float length = sqrt(x * x + y * y);
                if (length > 0.0f)
                {
                    x = x / length;
                    y = y / length;
                }
                else
                {
                    // Fallback to default direction if length is zero
                    x = 1.0f;
                    y = 0.0f;
                }
                
                m_vecWindDirection = Vector3(x, y, 0.0f);
            }
        }
        
        /**
         * Get current ambient lighting properties
         */
        Color GetAmbientLightColor() const
        {
            return m_AmbientLightColor;
        }
        
        /**
         * Get current ambient light intensity
         */
        float GetAmbientLightIntensity() const
        {
            return m_flAmbientLightIntensity;
        }
        
        /**
         * Get current wind properties
         */
        Vector3 GetWindDirection() const
        {
            return m_vecWindDirection;
        }
        
        /**
         * Get current wind strength
         */
        float GetWindStrength() const
        {
            return m_flWindStrength;
        }
        
        /**
         * Enable or disable environmental effects
         */
        void SetEnvironmentalEffectsEnabled(bool bEnabled)
        {
            m_bEnvironmentalEffectsEnabled = bEnabled;
            LogMessage("[INFO] WorldSystem: Environmental effects " + (bEnabled ? "enabled" : "disabled"));
        }
        
        /**
         * Debug function to dump all light slots
         */
        void DumpLightInfo()
        {
            LogMessage("[INFO] WorldSystem: Light System Status - " + m_nActiveLights + "/" + LIGHTSYS_N_LIGHTS + " active");
            for (uint i = 0; i < LIGHTSYS_N_LIGHTS; i++)
            {
                if (m_LightSlots[i].bActive)
                {
                    LogMessage("[INFO] Light " + i + ": Color(" + m_LightSlots[i].cColor.r + "," + 
                           m_LightSlots[i].cColor.g + "," + m_LightSlots[i].cColor.b + 
                           ") Radius:" + m_LightSlots[i].flRadius);
                }
            }
        }
    }
    
    // Global world system instance
    WorldSystem@ g_WorldSystem = null;
    
    /**
     * Initialize the world system
     */
    void InitializeWorldSystem()
    {
        if (g_WorldSystem is null)
        {
            @g_WorldSystem = WorldSystem();
            LogMessage("WorldSystem: Initialized successfully");
        }
        else
        {
            LogMessage("[WARNING] WorldSystem: Already initialized");
        }
    }
    
    /**
     * Get the global world system instance
     */
    WorldSystem@ GetWorldSystem()
    {
        if (g_WorldSystem is null)
        {
            InitializeWorldSystem();
        }
        return g_WorldSystem;
    }
    
    /**
     * Shutdown the world system
     */
    void ShutdownWorldSystem()
    {
        if (g_WorldSystem !is null)
        {
            LogMessage("WorldSystem: Shutting down");
            @g_WorldSystem = null;
        }
    }
}