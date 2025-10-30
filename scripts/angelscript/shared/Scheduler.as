#pragma context shared

/**
 * Scheduler.as
 * 
 * A flexible scheduler system for delayed task execution.
 * Works in both client and server contexts.
 * Command execution callbacks are server-only.
 */

namespace MS
{
    // ========================================
    // Scheduled Task Class
    // ========================================
    
    /**
     * Represents a single scheduled task
     */
    class ScheduledTask
    {
        string m_szTaskID;
        float m_fExecuteTime;           // Game time when task should execute
        float m_fInterval;              // For repeating tasks (0 = one-time)
        int m_nRepeatCount;             // -1 = infinite, 0 = done, >0 = remaining repeats
        bool m_bActive;                 // Is this task active?
        
        // Callback information
        string m_szCallbackName;        // Name of the function to call
        array<string> m_Params;         // Parameters to pass to callback
        
        // Countdown notification
        bool m_bShowCountdown;          // Show countdown messages?
        array<float> m_CountdownTimes;  // Times to show countdown (e.g., 5, 3, 2, 1)
        int m_nCurrentCountdownIndex;   // Current countdown notification index
        
        // Context information
        bool m_bServerOnly;             // Is this a server-only task?
        
        ScheduledTask()
        {
            m_szTaskID = "";
            m_fExecuteTime = 0.0f;
            m_fInterval = 0.0f;
            m_nRepeatCount = 0;
            m_bActive = false;
            m_szCallbackName = "";
            m_bShowCountdown = false;
            m_nCurrentCountdownIndex = 0;
            m_bServerOnly = false;
        }
        
        /**
         * Initialize task with basic parameters
         */
        void Initialize(const string &in szTaskID, float fDelay, const string &in szCallback, bool bServerOnly = false)
        {
            m_szTaskID = szTaskID;
            m_fExecuteTime = GetGameTime() + fDelay;
            m_fInterval = 0.0f;
            m_nRepeatCount = 0;
            m_bActive = true;
            m_szCallbackName = szCallback;
            m_bServerOnly = bServerOnly;
        }
        
        /**
         * Initialize repeating task
         */
        void InitializeRepeating(const string &in szTaskID, float fDelay, float fInterval, int nRepeats, const string &in szCallback, bool bServerOnly = false)
        {
            m_szTaskID = szTaskID;
            m_fExecuteTime = GetGameTime() + fDelay;
            m_fInterval = fInterval;
            m_nRepeatCount = nRepeats;
            m_bActive = true;
            m_szCallbackName = szCallback;
            m_bServerOnly = bServerOnly;
        }
        
        /**
         * Add a parameter to the callback
         */
        void AddParameter(const string &in szParam)
        {
            m_Params.insertLast(szParam);
        }
        
        /**
         * Enable countdown notifications
         */
        void EnableCountdown(const array<float> &in times)
        {
            m_bShowCountdown = true;
            m_CountdownTimes = times;
            m_nCurrentCountdownIndex = 0;
        }
        
        /**
         * Check if task should execute now
         */
        bool ShouldExecute() const
        {
            return m_bActive && GetGameTime() >= m_fExecuteTime;
        }
        
        /**
         * Check if countdown notification should be shown
         */
        bool ShouldShowCountdown() const
        {
            if (!m_bShowCountdown || !m_bActive)
                return false;
                
            if (m_nCurrentCountdownIndex >= int(m_CountdownTimes.length()))
                return false;
                
            float fTimeRemaining = m_fExecuteTime - GetGameTime();
            return fTimeRemaining <= m_CountdownTimes[m_nCurrentCountdownIndex] && fTimeRemaining > 0.0f;
        }
        
        /**
         * Get time remaining until execution
         */
        float GetTimeRemaining() const
        {
            return m_fExecuteTime - GetGameTime();
        }
        
        /**
         * Advance to next countdown notification
         */
        void AdvanceCountdown()
        {
            m_nCurrentCountdownIndex++;
        }
        
        /**
         * Schedule next repeat execution
         */
        void ScheduleNextRepeat()
        {
            if (m_nRepeatCount > 0)
            {
                m_nRepeatCount--;
            }
            
            if (m_nRepeatCount != 0)  // -1 (infinite) or > 0 (more repeats)
            {
                m_fExecuteTime = GetGameTime() + m_fInterval;
                // Reset countdown for next iteration
                m_nCurrentCountdownIndex = 0;
            }
            else
            {
                m_bActive = false;  // Done repeating
            }
        }
        
        /**
         * Cancel this task
         */
        void Cancel()
        {
            m_bActive = false;
        }
    }
    
    // ========================================
    // Callback Registry Interface
    // ========================================
    
    /**
     * Interface for callback handlers
     * Implement this to handle custom callbacks
     */
    interface ISchedulerCallback
    {
        void OnScheduledCallback(const string &in szCallbackName, const array<string> &in params);
    }
    
    // ========================================
    // Scheduler Manager Class
    // ========================================
    
    /**
     * Manages all scheduled tasks
     */
    class SchedulerManager
    {
        private array<ScheduledTask@> m_Tasks;
        private dictionary m_TaskMap;  // taskID -> index mapping
        private int m_nNextTaskID;
        private bool m_bInitialized;
        private float m_fLastCleanupTime;  // Track last cleanup time
        
        // Callback registry
        private array<ISchedulerCallback@> m_CallbackHandlers;
        
        SchedulerManager()
        {
            m_nNextTaskID = 1;
            m_bInitialized = false;
            m_fLastCleanupTime = 0.0f;
        }
        
        /**
         * Initialize the scheduler
         */
        bool Initialize()
        {
            if (m_bInitialized)
            {
                LogInfo("SchedulerManager: Already initialized");
                return true;
            }
            
            LogInfo("SchedulerManager: Initializing scheduler system...");
            
            m_Tasks.resize(0);
            m_TaskMap.deleteAll();
            m_CallbackHandlers.resize(0);
            m_nNextTaskID = 1;
            m_fLastCleanupTime = 0.0f;
            m_bInitialized = true;
            
            LogInfo("SchedulerManager: Scheduler initialized successfully");
            return true;
        }
        
        /**
         * Shutdown the scheduler
         */
        void Shutdown()
        {
            if (!m_bInitialized)
                return;
                
            LogInfo("SchedulerManager: Shutting down scheduler...");
            
            // Cancel all active tasks
            for (uint i = 0; i < m_Tasks.length(); i++)
            {
                if (m_Tasks[i] !is null && m_Tasks[i].m_bActive)
                {
                    m_Tasks[i].Cancel();
                }
            }
            
            m_Tasks.resize(0);
            m_TaskMap.deleteAll();
            m_CallbackHandlers.resize(0);
            m_bInitialized = false;
            
            LogInfo("SchedulerManager: Scheduler shutdown complete");
        }
        
        /**
         * Register a callback handler
         */
        void RegisterCallbackHandler(ISchedulerCallback@ handler)
        {
            if (handler !is null)
            {
                m_CallbackHandlers.insertLast(handler);
                LogInfo("SchedulerManager: Registered callback handler");
            }
        }
        
        /**
         * Update scheduler - call this every frame/think
         */
        void Update()
        {
            if (!m_bInitialized)
                return;
                
            // Process all tasks
            for (uint i = 0; i < m_Tasks.length(); i++)
            {
                ScheduledTask@ task = m_Tasks[i];
                if (task is null || !task.m_bActive)
                    continue;
                
                // Check for countdown notifications
                if (task.ShouldShowCountdown())
                {
                    float fTimeRemaining = task.GetTimeRemaining();
                    int nSeconds = int(fTimeRemaining + 0.5f);  // Round up
                    
                    if (nSeconds > 0)
                    {
                        OnCountdownNotification(task.m_szTaskID, nSeconds);
                        task.AdvanceCountdown();
                    }
                }
                
                // Check if task should execute
                if (task.ShouldExecute())
                {
                    ExecuteTask(task);
                    
                    // Handle repeating tasks
                    if (task.m_fInterval > 0.0f)
                    {
                        task.ScheduleNextRepeat();
                    }
                    else
                    {
                        task.Cancel();
                    }
                }
            }
            
            // Clean up completed tasks periodically
            CleanupCompletedTasks();
        }
        
        /**
         * Schedule a one-time delayed task
         */
        string ScheduleTask(float fDelay, const string &in szCallback, const array<string> &in params = array<string>(), bool bServerOnly = false)
        {
            if (!m_bInitialized)
            {
                LogError("SchedulerManager: Cannot schedule task - not initialized");
                return "";
            }
            
            if (fDelay < 0.0f)
            {
                LogWarning("SchedulerManager: Negative delay adjusted to 0");
                fDelay = 0.0f;
            }
            
            // Generate task ID
            string szTaskID = "task_" + m_nNextTaskID++;
            
            // Create task
            ScheduledTask@ task = ScheduledTask();
            task.Initialize(szTaskID, fDelay, szCallback, bServerOnly);
            
            // Add parameters
            for (uint i = 0; i < params.length(); i++)
            {
                task.AddParameter(params[i]);
            }
            
            // Add to list
            int nIndex = int(m_Tasks.length());
            m_Tasks.insertLast(task);
            m_TaskMap[szTaskID] = nIndex;
            
            LogInfo("SchedulerManager: Scheduled task '" + szTaskID + "' (callback: " + szCallback + ", delay: " + fDelay + "s)");
            return szTaskID;
        }
        
        /**
         * Schedule a task with countdown notifications
         */
        string ScheduleTaskWithCountdown(float fDelay, const string &in szCallback, const array<string> &in params, const array<float> &in countdownTimes, bool bServerOnly = false)
        {
            string szTaskID = ScheduleTask(fDelay, szCallback, params, bServerOnly);
            
            if (!szTaskID.isEmpty())
            {
                // Get the task and enable countdown
                uint64 nIndexValue;
                if (m_TaskMap.get(szTaskID, nIndexValue))
                {
                    int nIndex = int(nIndexValue);
                    if (nIndex >= 0 && nIndex < int(m_Tasks.length()))
                    {
                        m_Tasks[nIndex].EnableCountdown(countdownTimes);
                        LogInfo("SchedulerManager: Enabled countdown for task '" + szTaskID + "'");
                    }
                }
            }
            
            return szTaskID;
        }
        
        /**
         * Schedule a repeating task
         */
        string ScheduleRepeatingTask(float fDelay, float fInterval, int nRepeats, const string &in szCallback, const array<string> &in params = array<string>(), bool bServerOnly = false)
        {
            if (!m_bInitialized)
            {
                LogError("SchedulerManager: Cannot schedule repeating task - not initialized");
                return "";
            }
            
            if (fInterval <= 0.0f)
            {
                LogError("SchedulerManager: Invalid interval for repeating task");
                return "";
            }
            
            // Generate task ID
            string szTaskID = "repeat_" + m_nNextTaskID++;
            
            // Create task
            ScheduledTask@ task = ScheduledTask();
            task.InitializeRepeating(szTaskID, fDelay, fInterval, nRepeats, szCallback, bServerOnly);
            
            // Add parameters
            for (uint i = 0; i < params.length(); i++)
            {
                task.AddParameter(params[i]);
            }
            
            // Add to list
            int nIndex = int(m_Tasks.length());
            m_Tasks.insertLast(task);
            m_TaskMap[szTaskID] = nIndex;
            
            string szRepeatStr = (nRepeats == -1) ? "infinite" : ("" + nRepeats);
            LogInfo("SchedulerManager: Scheduled repeating task '" + szTaskID + "' (interval: " + fInterval + "s, repeats: " + szRepeatStr + ")");
            return szTaskID;
        }
        
        /**
         * Cancel a scheduled task
         */
        bool CancelTask(const string &in szTaskID)
        {
            uint64 nIndexValue;
            if (!m_TaskMap.get(szTaskID, nIndexValue))
            {
                LogWarning("SchedulerManager: Cannot cancel task '" + szTaskID + "' - not found");
                return false;
            }
            
            int nIndex = int(nIndexValue);
            if (nIndex >= 0 && nIndex < int(m_Tasks.length()))
            {
                m_Tasks[nIndex].Cancel();
                LogInfo("SchedulerManager: Cancelled task '" + szTaskID + "'");
                return true;
            }
            
            return false;
        }
        
        /**
         * Check if a task exists and is active
         */
        bool HasActiveTask(const string &in szTaskID) const
        {
            uint64 nIndexValue;
            if (!m_TaskMap.get(szTaskID, nIndexValue))
                return false;
            
            int nIndex = int(nIndexValue);
            if (nIndex >= 0 && nIndex < int(m_Tasks.length()))
            {
                return m_Tasks[nIndex].m_bActive;
            }
            
            return false;
        }
        
        /**
         * Get time remaining for a task
         */
        float GetTaskTimeRemaining(const string &in szTaskID) const
        {
            uint64 nIndexValue;
            if (!m_TaskMap.get(szTaskID, nIndexValue))
                return -1.0f;
            
            int nIndex = int(nIndexValue);
            if (nIndex >= 0 && nIndex < int(m_Tasks.length()))
            {
                return m_Tasks[nIndex].GetTimeRemaining();
            }
            
            return -1.0f;
        }
        
        /**
         * Get number of active tasks
         */
        int GetActiveTaskCount() const
        {
            int nCount = 0;
            for (uint i = 0; i < m_Tasks.length(); i++)
            {
                if (m_Tasks[i] !is null && m_Tasks[i].m_bActive)
                    nCount++;
            }
            return nCount;
        }
        
        /**
         * Execute a scheduled task
         */
        private void ExecuteTask(ScheduledTask@ task)
        {
            if (task is null)
                return;
                
            LogInfo("SchedulerManager: Executing task '" + task.m_szTaskID + "' (callback: " + task.m_szCallbackName + ")");
            
            // Notify all registered callback handlers
            for (uint i = 0; i < m_CallbackHandlers.length(); i++)
            {
                if (m_CallbackHandlers[i] !is null)
                {
                    m_CallbackHandlers[i].OnScheduledCallback(task.m_szCallbackName, task.m_Params);
                }
            }
        }
        
        /**
         * Handle countdown notifications
         */
        private void OnCountdownNotification(const string &in szTaskID, int nSeconds)
        {
            string szMessage = "Action executing in " + nSeconds + " second" + (nSeconds != 1 ? "s" : "") + "...";
            LogInfo("SchedulerManager: Countdown - " + szMessage + " (Task: " + szTaskID + ")");
            
            // This can be overridden by callback handlers to show messages to players
        }
        
        /**
         * Clean up completed tasks
         */
        private void CleanupCompletedTasks()
        {
            // Only clean up occasionally to avoid performance issues
            float fCurrentTime = GetGameTime();
            
            if (fCurrentTime - m_fLastCleanupTime < 30.0f)  // Clean every 30 seconds
                return;
                
            m_fLastCleanupTime = fCurrentTime;
            
            int nRemovedCount = 0;
            
            // Remove inactive tasks
            for (int i = int(m_Tasks.length()) - 1; i >= 0; i--)
            {
                if (m_Tasks[i] is null || !m_Tasks[i].m_bActive)
                {
                    if (m_Tasks[i] !is null)
                    {
                        m_TaskMap.delete(m_Tasks[i].m_szTaskID);
                        nRemovedCount++;
                    }
                    m_Tasks.removeAt(uint(i));
                }
            }
            
            // Rebuild task map indices
            m_TaskMap.deleteAll();
            for (uint i = 0; i < m_Tasks.length(); i++)
            {
                if (m_Tasks[i] !is null)
                {
                    m_TaskMap[m_Tasks[i].m_szTaskID] = i;
                }
            }
            
            if (nRemovedCount > 0)
            {
                LogInfo("SchedulerManager: Cleaned up " + nRemovedCount + " completed task(s)");
            }
        }
        
        /**
         * Simple logging functions
         */
        private void LogInfo(const string &in szMessage)
        {
            LogMessage("[Scheduler] " + szMessage);
        }
        
        private void LogWarning(const string &in szMessage)
        {
            LogMessage("[Scheduler WARNING] " + szMessage);
        }
        
        private void LogError(const string &in szMessage)
        {
            LogMessage("[Scheduler ERROR] " + szMessage);
        }
    }
    
    // ========================================
    // Global Scheduler Instance
    // ========================================
    
    SchedulerManager g_Scheduler;
    
    /**
     * Get the global scheduler instance
     */
    SchedulerManager@ GetScheduler()
    {
        return @g_Scheduler;
    }
    
    /**
     * Initialize the scheduler system
     */
    bool InitializeScheduler()
    {
        return g_Scheduler.Initialize();
    }
    
    /**
     * Shutdown the scheduler system
     */
    void ShutdownScheduler()
    {
        g_Scheduler.Shutdown();
    }
    
    /**
     * Update the scheduler (call this every frame/think)
     */
    void UpdateScheduler()
    {
        g_Scheduler.Update();
    }
    
    // ========================================
    // Convenience Functions
    // ========================================
    
    /**
     * Schedule a simple delayed callback
     */
    string Schedule(float fDelay, const string &in szCallback)
    {
        array<string> emptyParams;
        return g_Scheduler.ScheduleTask(fDelay, szCallback, emptyParams);
    }
    
    /**
     * Schedule with parameters
     */
    string ScheduleWithParams(float fDelay, const string &in szCallback, const array<string> &in params)
    {
        return g_Scheduler.ScheduleTask(fDelay, szCallback, params);
    }
    
    /**
     * Schedule with countdown
     */
    string ScheduleWithCountdown(float fDelay, const string &in szCallback, const array<string> &in params)
    {
        // Default countdown times: 10, 5, 3, 2, 1
        array<float> countdown = {10.0f, 5.0f, 3.0f, 2.0f, 1.0f};
        return g_Scheduler.ScheduleTaskWithCountdown(fDelay, szCallback, params, countdown);
    }
    
    /**
     * Cancel a scheduled task
     */
    bool CancelScheduledTask(const string &in szTaskID)
    {
        return g_Scheduler.CancelTask(szTaskID);
    }
}

