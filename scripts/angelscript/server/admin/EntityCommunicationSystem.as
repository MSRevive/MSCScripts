#pragma context server

/**
 * EntityCommunicationSystem.as
 * 
 * Core communication framework that enables entities to communicate with the Game Master system.
 * This is the backbone that connects entities to Game Master functionality including quest systems,
 * NPC management, triggers, and admin commands.
 * 
 * Key Features:
 * - Message routing and validation
 * - Function dispatch to appropriate systems
 * - Security checks and permission validation
 * - Logging and debugging capabilities
 * - Rate limiting and abuse prevention
 */

namespace MS
{
    /**
     * Communication message structure
     */
    class CommunicationMessage
    {
        string szTarget;              // Target system (GAME_MASTER, etc.)
        string szFunction;            // Function to call
        array<string> szParameters;   // Function parameters
        CBaseEntity@ hSender;         // Entity that sent the message
        string szSenderID;            // Sender identifier
        float flTimestamp;            // When message was sent
        uint nPriority;               // Message priority (1=high, 5=low)
        
        CommunicationMessage()
        {
            szTarget = "";
            szFunction = "";
            hSender = CBaseEntity@();
            szSenderID = "";
            flTimestamp = GetGameTime();
            nPriority = 3; // Normal priority
        }
        
        CommunicationMessage(const string &in target, const string &in function)
        {
            szTarget = target;
            szFunction = function;
            hSender = CBaseEntity@();
            szSenderID = "";
            flTimestamp = GetGameTime();
            nPriority = 3;
        }
    }
    
    /**
     * Communication handler interface
     */
    interface ICommunicationHandler
    {
        bool HandleMessage(const CommunicationMessage &in message);
        string GetHandlerName();
        array<string> GetSupportedFunctions();
    }
    
    /**
     * Entity Communication System
     * The central message routing and validation system
     */
    class EntityCommunicationSystem
    {
        // Message handlers by target
        ::dictionary m_Handlers; // string -> ICommunicationHandler@
        
        // Message statistics
        uint m_nTotalMessages;
        uint m_nSuccessfulMessages;
        uint m_nFailedMessages;
        uint m_nBlockedMessages;
        
        // Rate limiting (per sender)
        ::dictionary m_RateLimiting; // string -> float (last message time)
        float m_flRateLimit = 0.1f; // Minimum time between messages (seconds)
        
        // Security settings
        bool m_bSecurityEnabled = true;
        bool m_bLoggingEnabled = true;
        uint m_nMaxParameters = 10;
        uint m_nMaxParameterLength = 256;
        
        // Message queue for async processing
        array<CommunicationMessage> m_MessageQueue;
        bool m_bProcessingEnabled = true;
        
        EntityCommunicationSystem()
        {
            m_nTotalMessages = 0;
            m_nSuccessfulMessages = 0;
            m_nFailedMessages = 0;
            m_nBlockedMessages = 0;
            
            LogMessage("[INFO] EntityCommunicationSystem: Initializing communication framework");
        }
        
        /**
         * Initialize the communication system
         */
        void Initialize()
        {
            LogMessage("[INFO] EntityCommunicationSystem: Registering default handlers");
            
            // Register built-in handlers
            RegisterDefaultHandlers();
            
            LogMessage("[INFO] EntityCommunicationSystem: Communication system initialized with " + 
                      m_Handlers.getSize() + " handlers");
        }
        
        /**
         * Shutdown the communication system
         */
        void Shutdown()
        {
            m_Handlers.deleteAll();
            m_MessageQueue.resize(0);
            m_RateLimiting.deleteAll();
            
            LogMessage("[INFO] EntityCommunicationSystem: System shutdown complete");
            LogMessage("[INFO] EntityCommunicationSystem: Final stats - Total: " + m_nTotalMessages + 
                      ", Success: " + m_nSuccessfulMessages + ", Failed: " + m_nFailedMessages + 
                      ", Blocked: " + m_nBlockedMessages);
        }
        
        /**
         * Process a communication request from an entity
         * This is the main entry point for external communications
         * 
         * @param szTarget Target system identifier (e.g., "GAME_MASTER")
         * @param szFunction Function to call (e.g., "ext_got_quest_item")
         * @param parameters Array of string parameters
         * @param hSender Handle to the sending entity (for validation)
         * @param szSenderID Optional sender identifier override
         * @return True if message was processed successfully
         */
        bool ProcessCommunication(const string &in szTarget, const string &in szFunction, 
                                 const array<string> &in parameters, CBaseEntity@ hSender, 
                                 const string &in szSenderID = "")
        {
            m_nTotalMessages++;
            
            // Create message
            CommunicationMessage message(szTarget, szFunction);
            message.hSender = hSender;
            message.szSenderID = (szSenderID.length() > 0) ? szSenderID : GenerateSenderID(hSender);
            message.szParameters = parameters;
            
            // Log the communication attempt
            if (m_bLoggingEnabled)
            {
                LogCommunication(message, "RECEIVED");
            }
            
            // Security validation
            if (!ValidateMessage(message))
            {
                m_nBlockedMessages++;
                LogMessage("[WARNING] EntityCommunicationSystem: Message blocked from " + 
                          message.szSenderID + " - security validation failed");
                return false;
            }
            
            // Rate limiting check
            if (!CheckRateLimit(message.szSenderID))
            {
                m_nBlockedMessages++;
                LogMessage("[WARNING] EntityCommunicationSystem: Message blocked from " + 
                          message.szSenderID + " - rate limit exceeded");
                return false;
            }
            
            // Queue message for processing
            if (m_bProcessingEnabled)
            {
                return ProcessMessageImmediate(message);
            }
            else
            {
                m_MessageQueue.insertLast(message);
                return true;
            }
        }
        
        /**
         * Process queued messages (for async processing)
         */
        void ProcessQueuedMessages()
        {
            if (!m_bProcessingEnabled || m_MessageQueue.length() == 0)
                return;
            
            // Process up to 10 messages per call to avoid lag
            uint nProcessed = 0;
            while (m_MessageQueue.length() > 0 && nProcessed < 10)
            {
                CommunicationMessage message = m_MessageQueue[0];
                m_MessageQueue.removeAt(0);
                
                ProcessMessageImmediate(message);
                nProcessed++;
            }
            
            if (m_MessageQueue.length() > 0)
            {
                LogMessage("[DEBUG] EntityCommunicationSystem: " + m_MessageQueue.length() + 
                          " messages still queued");
            }
        }
        
        /**
         * Register a communication handler
         */
        void RegisterHandler(const string &in szTarget, ICommunicationHandler@ pHandler)
        {
            if (pHandler is null)
            {
                LogMessage("[ERROR] EntityCommunicationSystem: Cannot register null handler for " + szTarget);
                return;
            }
            
            m_Handlers.set(szTarget, @pHandler);
            LogMessage("[INFO] EntityCommunicationSystem: Registered handler for target '" + szTarget + 
                      "' - " + pHandler.GetHandlerName());
        }
        
        /**
         * Unregister a communication handler
         */
        void UnregisterHandler(const string &in szTarget)
        {
            if (m_Handlers.exists(szTarget))
            {
                m_Handlers.delete(szTarget);
                LogMessage("[INFO] EntityCommunicationSystem: Unregistered handler for target '" + szTarget + "'");
            }
        }
        
        /**
         * Get communication statistics
         */
        void GetStatistics(uint &out nTotal, uint &out nSuccess, uint &out nFailed, uint &out nBlocked)
        {
            nTotal = m_nTotalMessages;
            nSuccess = m_nSuccessfulMessages;
            nFailed = m_nFailedMessages;
            nBlocked = m_nBlockedMessages;
        }
        
        /**
         * Dump system status for debugging
         */
        void DumpStatus()
        {
            LogMessage("[INFO] EntityCommunicationSystem: === SYSTEM STATUS ===");
            LogMessage("[INFO] Registered handlers: " + m_Handlers.getSize());
            
            array<string> targets = m_Handlers.getKeys();
            for (uint i = 0; i < targets.length(); i++)
            {
                ICommunicationHandler@ pHandler;
                m_Handlers.get(targets[i], @pHandler);
                if (pHandler !is null)
                {
                    array<string> functions = pHandler.GetSupportedFunctions();
                    LogMessage("[INFO]   " + targets[i] + ": " + pHandler.GetHandlerName() + 
                              " (" + functions.length() + " functions)");
                }
            }
            
            LogMessage("[INFO] Message stats: Total=" + m_nTotalMessages + 
                      ", Success=" + m_nSuccessfulMessages + 
                      ", Failed=" + m_nFailedMessages + 
                      ", Blocked=" + m_nBlockedMessages);
            LogMessage("[INFO] Queued messages: " + m_MessageQueue.length());
            LogMessage("[INFO] Rate limiting entries: " + m_RateLimiting.getSize());
            LogMessage("[INFO] === END STATUS ===");
        }
        
        /**
         * Enable/disable security validation
         */
        void SetSecurityEnabled(bool bEnabled)
        {
            m_bSecurityEnabled = bEnabled;
            LogMessage("[INFO] EntityCommunicationSystem: Security validation " + 
                      (bEnabled ? "enabled" : "disabled"));
        }
        
        /**
         * Enable/disable communication logging
         */
        void SetLoggingEnabled(bool bEnabled)
        {
            m_bLoggingEnabled = bEnabled;
        }
        
        /**
         * Set rate limiting parameters
         */
        void SetRateLimit(float flSeconds)
        {
            m_flRateLimit = flSeconds;
            LogMessage("[INFO] EntityCommunicationSystem: Rate limit set to " + flSeconds + " seconds");
        }
        
        /**
         * Clear rate limiting data
         */
        void ClearRateLimiting()
        {
            m_RateLimiting.deleteAll();
            LogMessage("[INFO] EntityCommunicationSystem: Rate limiting data cleared");
        }
        
        /**
         * Register default communication handlers
         */
        void RegisterDefaultHandlers()
        {
            // The actual handlers will be registered by the respective systems
            // This is just a placeholder for initialization
            LogMessage("[DEBUG] EntityCommunicationSystem: Default handler registration placeholder");
        }
        
        /**
         * Process a message immediately
         */
        bool ProcessMessageImmediate(const CommunicationMessage &in message)
        {
            if (!m_Handlers.exists(message.szTarget))
            {
                m_nFailedMessages++;
                LogMessage("[WARNING] EntityCommunicationSystem: No handler registered for target '" + 
                          message.szTarget + "'");
                return false;
            }
            
            ICommunicationHandler@ pHandler;
            m_Handlers.get(message.szTarget, @pHandler);
            
            if (pHandler is null)
            {
                m_nFailedMessages++;
                LogMessage("[ERROR] EntityCommunicationSystem: Handler for '" + message.szTarget + 
                          "' is null");
                return false;
            }
            
            try
            {
                bool bResult = pHandler.HandleMessage(message);
                
                if (bResult)
                {
                    m_nSuccessfulMessages++;
                    if (m_bLoggingEnabled)
                    {
                        LogCommunication(message, "SUCCESS");
                    }
                }
                else
                {
                    m_nFailedMessages++;
                    if (m_bLoggingEnabled)
                    {
                        LogCommunication(message, "FAILED");
                    }
                }
                
                return bResult;
            }
            catch
            {
                m_nFailedMessages++;
                LogMessage("[ERROR] EntityCommunicationSystem: Exception in handler for '" + 
                          message.szTarget + "." + message.szFunction + "'");
                return false;
            }
        }
        
        /**
         * Validate a communication message
         */
        bool ValidateMessage(const CommunicationMessage &in message)
        {
            if (!m_bSecurityEnabled)
                return true;
            
            // Basic validation
            if (message.szTarget.length() == 0)
            {
                LogMessage("[WARNING] EntityCommunicationSystem: Empty target in message");
                return false;
            }
            
            if (message.szFunction.length() == 0)
            {
                LogMessage("[WARNING] EntityCommunicationSystem: Empty function in message");
                return false;
            }
            
            // Parameter validation
            if (message.szParameters.length() > m_nMaxParameters)
            {
                LogMessage("[WARNING] EntityCommunicationSystem: Too many parameters (" + 
                          message.szParameters.length() + " > " + m_nMaxParameters + ")");
                return false;
            }
            
            for (uint i = 0; i < message.szParameters.length(); i++)
            {
                if (message.szParameters[i].length() > m_nMaxParameterLength)
                {
                    LogMessage("[WARNING] EntityCommunicationSystem: Parameter " + i + 
                              " too long (" + message.szParameters[i].length() + " > " + 
                              m_nMaxParameterLength + ")");
                    return false;
                }
            }
            
            // Target validation
            if (!IsValidTarget(message.szTarget))
            {
                LogMessage("[WARNING] EntityCommunicationSystem: Invalid target '" + 
                          message.szTarget + "'");
                return false;
            }
            
            // Function name validation (prevent injection)
            if (!IsValidFunctionName(message.szFunction))
            {
                LogMessage("[WARNING] EntityCommunicationSystem: Invalid function name '" + 
                          message.szFunction + "'");
                return false;
            }
            
            return true;
        }
        
        /**
         * Check rate limiting for a sender
         */
        bool CheckRateLimit(const string &in szSenderID)
        {
            if (m_flRateLimit <= 0.0f)
                return true; // Rate limiting disabled
            
            float flCurrentTime = GetGameTime();
            
            if (m_RateLimiting.exists(szSenderID))
            {
                float flLastTime;
                m_RateLimiting.get(szSenderID, flLastTime);
                
                if (flCurrentTime - flLastTime < m_flRateLimit)
                {
                    return false; // Rate limit exceeded
                }
            }
            
            // Update last message time
            m_RateLimiting.set(szSenderID, flCurrentTime);
            return true;
        }
        
        /**
         * Generate a sender ID from entity handle
         */
        string GenerateSenderID(CBaseEntity@ hEntity)
        {
            if (!hEntity.IsValid())
                return "unknown";
            
            // TODO: In a real implementation, this would get entity information
            // For now, use a simple counter approach
            uint s_nEntityCounter = m_nTotalMessages;
            return "entity_" + s_nEntityCounter;
        }
        
        /**
         * Validate target name
         */
        bool IsValidTarget(const string &in szTarget)
        {
            // Allow alphanumeric and underscore only
            for (uint i = 0; i < szTarget.length(); i++)
            {
                uint8 c = szTarget[i];
                if (!((c >= uint8(65) && c <= uint8(90)) || (c >= uint8(97) && c <= uint8(122)) || 
                      (c >= uint8(48) && c <= uint8(57)) || c == uint8(95)))
                {
                    return false;
                }
            }
            return szTarget.length() > 0 && szTarget.length() <= 32;
        }
        
        /**
         * Validate function name
         */
        bool IsValidFunctionName(const string &in szFunction)
        {
            // Allow alphanumeric and underscore only
            for (uint i = 0; i < szFunction.length(); i++)
            {
                uint8 c = szFunction[i];
                if (!((c >= uint8(65) && c <= uint8(90)) || (c >= uint8(97) && c <= uint8(122)) || 
                      (c >= uint8(48) && c <= uint8(57)) || c == uint8(95)))
                {
                    return false;
                }
            }
            return szFunction.length() > 0 && szFunction.length() <= 64;
        }
        
        /**
         * Log a communication event
         */
        void LogCommunication(const CommunicationMessage &in message, const string &in szStatus)
        {
            string logMsg = "[COMM] " + szStatus + " - " + message.szSenderID + " -> " + 
                           message.szTarget + "." + message.szFunction + "(";
            
            for (uint i = 0; i < message.szParameters.length(); i++)
            {
                if (i > 0) logMsg += ", ";
                logMsg += "\"" + message.szParameters[i] + "\"";
            }
            logMsg += ")";
            
            LogMessage(logMsg);
        }
    }
    
    // Global communication system instance
    EntityCommunicationSystem@ g_EntityCommunicationSystem = null;
    
    /**
     * Initialize the entity communication system
     */
    void InitializeEntityCommunicationSystem()
    {
        if (g_EntityCommunicationSystem is null)
        {
            @g_EntityCommunicationSystem = EntityCommunicationSystem();
            g_EntityCommunicationSystem.Initialize();
            LogMessage("[INFO] EntityCommunicationSystem: Global system initialized");
        }
        else
        {
            LogMessage("[WARNING] EntityCommunicationSystem: System already initialized");
        }
    }
    
    /**
     * Get the global entity communication system
     */
    EntityCommunicationSystem@ GetEntityCommunicationSystem()
    {
        if (g_EntityCommunicationSystem is null)
        {
            InitializeEntityCommunicationSystem();
        }
        return g_EntityCommunicationSystem;
    }
    
    /**
     * Shutdown the entity communication system
     */
    void ShutdownEntityCommunicationSystem()
    {
        if (g_EntityCommunicationSystem !is null)
        {
            g_EntityCommunicationSystem.Shutdown();
            @g_EntityCommunicationSystem = null;
            LogMessage("[INFO] EntityCommunicationSystem: Global system shutdown");
        }
    }
    
    /**
     * Main entry point for external entity communications
     * This function is called by entities using the legacy callexternal pattern
     * 
     * @param szTarget Target system (e.g., "GAME_MASTER")
     * @param szFunction Function to call
     * @param szParam1 First parameter (optional)
     * @param szParam2 Second parameter (optional)
     * @param szParam3 Third parameter (optional)
     * @param szParam4 Fourth parameter (optional)
     * @param hSender Entity making the call
     * @return True if the communication was processed successfully
     */
    bool CallExternal(const string &in szTarget, const string &in szFunction, 
                     const string &in szParam1 = "", const string &in szParam2 = "",
                     const string &in szParam3 = "", const string &in szParam4 = "",
                     CBaseEntity@ hSender = CBaseEntity@())
    {
        EntityCommunicationSystem@ pSystem = GetEntityCommunicationSystem();
        if (pSystem is null)
        {
            LogMessage("[ERROR] CallExternal: Communication system not available");
            return false;
        }
        
        // Build parameter array
        array<string> parameters;
        if (szParam1.length() > 0) parameters.insertLast(szParam1);
        if (szParam2.length() > 0) parameters.insertLast(szParam2);
        if (szParam3.length() > 0) parameters.insertLast(szParam3);
        if (szParam4.length() > 0) parameters.insertLast(szParam4);
        
        return pSystem.ProcessCommunication(szTarget, szFunction, parameters, hSender);
    }
    
    /**
     * Extended entry point for external entity communications with array parameters
     */
    bool CallExternalArray(const string &in szTarget, const string &in szFunction, 
                          const array<string> &in parameters, CBaseEntity@ hSender = CBaseEntity@(),
                          const string &in szSenderID = "")
    {
        EntityCommunicationSystem@ pSystem = GetEntityCommunicationSystem();
        if (pSystem is null)
        {
            LogMessage("[ERROR] CallExternalArray: Communication system not available");
            return false;
        }
        
        return pSystem.ProcessCommunication(szTarget, szFunction, parameters, hSender, szSenderID);
    }
}