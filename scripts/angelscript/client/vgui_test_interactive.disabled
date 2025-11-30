//==========================================================================
// vgui_test_interactive.as
//
// Interactive VGUI Test Control Panel Module
// Provides a UI for running VGUI tests individually or all together
// with visual feedback and status reporting
//==========================================================================

#pragma context client

// ========================================================================
// Global State Variables (accessible from module and global callbacks)
// ========================================================================

#include "client/vgui_test_suite.as"

VGUIFrame@ g_mainTestFrame;
VGUILabel@ g_statusLabel;
VGUILabel@ g_resultLabel;
array<VGUIButton@> g_testButtons;
array<VGUIPanel@> g_childPanels;  // Keep references to all child panels to prevent premature deletion
bool g_controlPanelCreated = false;

namespace VGUI
{
    module TestInteractive
    {
        TestInteractive()  // Constructor - no return type, must match module name
        {
            LogMessage("[VGUI Interactive] Script initialized");
        }
    }
}

// ============================================================================
// Test Control Panel Creation
// ============================================================================

void CreateTestControlPanel()
{
    if (g_controlPanelCreated)
    {
        LogMessage("[VGUI Interactive] Control panel already created");
        return;
    }

    LogMessage("[VGUI Interactive] Creating test control panel...");

    // Create main frame
    @g_mainTestFrame = CreateFrame(50, 50, 350, 600, "VGUI Test Control Panel");

    if (g_mainTestFrame is null || !g_mainTestFrame.IsValid())
    {
        LogMessage("[VGUI Interactive] Failed to create main test frame");
        return;
    }

    g_mainTestFrame.SetMoveable(true);
    g_mainTestFrame.SetSizeable(false);
    g_mainTestFrame.SetCloseButton(true);
    g_mainTestFrame.SetMinimizeButton(false);

    // Parent the frame to the viewport so it's visible
    VGUIPanel@ viewport = GetViewportPanel();
    if (viewport !is null && viewport.IsValid())
    {
        g_mainTestFrame.SetParent(viewport);
        LogMessage("[VGUI Interactive] Frame parented to viewport");
    }
    else
    {
        LogMessage("[VGUI Interactive] WARNING: Failed to get viewport panel - UI may not be visible");
    }

    // Title label
    VGUILabel@ title = CreateLabel("VGUI Test Suite", 10, 40, 330, 30);
    if (title !is null && title.IsValid())
    {
        title.SetTextColor(255, 255, 255, 255);
        title.SetContentAlignment(1);  // Center
        title.SetBgColor(50, 50, 100, 255);
        title.SetParent(g_mainTestFrame);
        g_childPanels.insertLast(title);  // Keep alive
    }

    int yPos = 80;
    int buttonHeight = 30;
    int buttonSpacing = 35;

    // Run All Tests button (highlighted)
    VGUIButton@ btnRunAll = CreateButton("Run All Tests", 10, yPos, 330, buttonHeight);
    if (btnRunAll !is null && btnRunAll.IsValid())
    {
        btnRunAll.SetCallback("OnRunAllTests");
        btnRunAll.SetArmedColor(100, 255, 100, 255);
        btnRunAll.SetDepressedColor(50, 200, 50, 255);
        btnRunAll.SetParent(g_mainTestFrame);
        g_testButtons.insertLast(btnRunAll);
    }
    yPos += buttonSpacing + 10;

    // Section label
    VGUILabel@ sectionLabel = CreateLabel("Individual Tests:", 10, yPos, 330, 20);
    if (sectionLabel !is null && sectionLabel.IsValid())
    {
        sectionLabel.SetTextColor(200, 200, 200, 255);
        sectionLabel.SetParent(g_mainTestFrame);
        g_childPanels.insertLast(sectionLabel);  // Keep alive
    }
    yPos += 25;

    // Individual test buttons
    array<string> testNames = {
        "VGUIPanel Tests",
        "VGUIFrame Tests",
        "VGUIButton Tests",
        "VGUILabel Tests",
        "VGUITextEntry Tests",
        "VGUIImagePanel Tests",
        "Factory Functions",
        "Utility Functions",
        "Integration Tests"
    };

    array<string> callbacks = {
        "OnTestVGUIPanel",
        "OnTestVGUIFrame",
        "OnTestVGUIButton",
        "OnTestVGUILabel",
        "OnTestVGUITextEntry",
        "OnTestVGUIImagePanel",
        "OnTestFactories",
        "OnTestUtilities",
        "OnTestIntegration"
    };

    for (uint i = 0; i < testNames.length(); i++)
    {
        VGUIButton@ btn = CreateButton(testNames[i], 10, yPos, 330, buttonHeight);
        if (btn !is null && btn.IsValid())
        {
            btn.SetCallback(callbacks[i]);
            btn.SetArmedColor(150, 150, 255, 255);
            btn.SetParent(g_mainTestFrame);
            g_testButtons.insertLast(btn);
        }
        yPos += buttonSpacing;
    }

    yPos += 10;

    // Cleanup button
    VGUIButton@ btnCleanup = CreateButton("Cleanup Test Panels", 10, yPos, 330, buttonHeight);
    if (btnCleanup !is null && btnCleanup.IsValid())
    {
        btnCleanup.SetCallback("OnCleanupTests");
        btnCleanup.SetArmedColor(255, 150, 100, 255);
        btnCleanup.SetDepressedColor(200, 100, 50, 255);
        btnCleanup.SetParent(g_mainTestFrame);
        g_testButtons.insertLast(btnCleanup);
    }
    yPos += buttonSpacing + 10;

    // Status section
    VGUIPanel@ statusPanel = CreatePanel(10, yPos, 330, 80);
    if (statusPanel !is null && statusPanel.IsValid())
    {
        statusPanel.SetBgColor(40, 40, 40, 255);
        statusPanel.SetParent(g_mainTestFrame);
        g_childPanels.insertLast(statusPanel);  // Keep alive

        @g_statusLabel = CreateLabel("Status: Ready", 10, 10, 310, 25);
        if (g_statusLabel !is null && g_statusLabel.IsValid())
        {
            g_statusLabel.SetTextColor(0, 255, 0, 255);
            g_statusLabel.SetParent(statusPanel);
        }

        @g_resultLabel = CreateLabel("Results: 0/0 tests", 10, 40, 310, 25);
        if (g_resultLabel !is null && g_resultLabel.IsValid())
        {
            g_resultLabel.SetTextColor(255, 255, 255, 255);
            g_resultLabel.SetParent(statusPanel);
        }
    }

    // Activate the frame (makes visible, requests focus, and repaints)
    // This must be called AFTER all setup is complete (parent set, children added)
    g_mainTestFrame.Activate();
    g_controlPanelCreated = true;

    LogMessage("[VGUI Interactive] Test control panel created successfully");
}

// ============================================================================
// Status Update Functions
// ============================================================================

void UpdateStatus(const string &in message, bool isError = false)
{
    if (g_statusLabel !is null && g_statusLabel.IsValid())
    {
        g_statusLabel.SetText("Status: " + message);
        if (isError)
        {
            g_statusLabel.SetTextColor(255, 0, 0, 255);  // Red for errors
        }
        else
        {
            g_statusLabel.SetTextColor(0, 255, 0, 255);  // Green for normal
        }
    }

    LogMessage("[VGUI Interactive] Status: " + message);
}

void UpdateResults(int passed, int failed)
{
    if (g_resultLabel !is null && g_resultLabel.IsValid())
    {
        int total = passed + failed;
        g_resultLabel.SetText("Results: " + passed + "/" + total + " tests passed");

        // Color code based on pass rate
        if (failed == 0)
        {
            g_resultLabel.SetTextColor(0, 255, 0, 255);  // Green - all passed
        }
        else if (passed > failed)
        {
            g_resultLabel.SetTextColor(255, 255, 0, 255);  // Yellow - mostly passed
        }
        else
        {
            g_resultLabel.SetTextColor(255, 0, 0, 255);  // Red - mostly failed
        }
    }
}

// ============================================================================
// Button Callback Handlers
// ============================================================================

void OnRunAllTests()
{
    UpdateStatus("Running all tests...");
    LogMessage("[VGUI Interactive] Running all tests...");

    RunAllTests();

    UpdateStatus("All tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnTestVGUIPanel()
{
    UpdateStatus("Running VGUIPanel tests...");
    LogMessage("[VGUI Interactive] Running VGUIPanel tests...");

    // Reset counters
    g_TestsPassed = 0;
    g_TestsFailed = 0;

    TestVGUIPanel_Creation();
    TestVGUIPanel_Position();
    TestVGUIPanel_Size();
    TestVGUIPanel_Bounds();
    TestVGUIPanel_Visibility();
    TestVGUIPanel_Colors();
    TestVGUIPanel_Rendering();
    TestVGUIPanel_MouseInteraction();
    TestVGUIPanel_Removal();

    UpdateStatus("VGUIPanel tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnTestVGUIFrame()
{
    UpdateStatus("Running VGUIFrame tests...");
    LogMessage("[VGUI Interactive] Running VGUIFrame tests...");

    g_TestsPassed = 0;
    g_TestsFailed = 0;

    TestVGUIFrame_Creation();
    TestVGUIFrame_Title();
    TestVGUIFrame_Moveable();
    TestVGUIFrame_Sizeable();
    TestVGUIFrame_Buttons();
    TestVGUIFrame_Center();
    TestVGUIFrame_Inheritance();

    UpdateStatus("VGUIFrame tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnTestVGUIButton()
{
    UpdateStatus("Running VGUIButton tests...");
    LogMessage("[VGUI Interactive] Running VGUIButton tests...");

    g_TestsPassed = 0;
    g_TestsFailed = 0;

    TestVGUIButton_Creation();
    TestVGUIButton_Text();
    TestVGUIButton_Callbacks();
    TestVGUIButton_EnableDisable();
    TestVGUIButton_Colors();

    UpdateStatus("VGUIButton tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnTestVGUILabel()
{
    UpdateStatus("Running VGUILabel tests...");
    LogMessage("[VGUI Interactive] Running VGUILabel tests...");

    g_TestsPassed = 0;
    g_TestsFailed = 0;

    TestVGUILabel_Creation();
    TestVGUILabel_Text();
    TestVGUILabel_Color();
    TestVGUILabel_Alignment();

    UpdateStatus("VGUILabel tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnTestVGUITextEntry()
{
    UpdateStatus("Running VGUITextEntry tests...");
    LogMessage("[VGUI Interactive] Running VGUITextEntry tests...");

    g_TestsPassed = 0;
    g_TestsFailed = 0;

    TestVGUITextEntry_Creation();
    TestVGUITextEntry_TextOperations();
    TestVGUITextEntry_Editable();
    TestVGUITextEntry_Limitations();

    UpdateStatus("VGUITextEntry tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnTestVGUIImagePanel()
{
    UpdateStatus("Running VGUIImagePanel tests...");
    LogMessage("[VGUI Interactive] Running VGUIImagePanel tests...");

    g_TestsPassed = 0;
    g_TestsFailed = 0;

    TestVGUIImagePanel_Creation();
    TestVGUIImagePanel_Scaling();

    UpdateStatus("VGUIImagePanel tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnTestFactories()
{
    UpdateStatus("Running factory function tests...");
    LogMessage("[VGUI Interactive] Running factory function tests...");

    g_TestsPassed = 0;
    g_TestsFailed = 0;

    // Factory functions are tested as part of other tests
    // Just create some panels to verify factories work
    VGUIFrame@ testFrame = CreateFrame(100, 100, 200, 150, "Factory Test");
    if (testFrame !is null && testFrame.IsValid())
    {
        g_TestsPassed++;
        g_TestPanels.insertLast(testFrame);
    }
    else
    {
        g_TestsFailed++;
    }

    VGUIButton@ testButton = CreateButton("Test", 0, 0, 100, 30);
    if (testButton !is null && testButton.IsValid())
    {
        g_TestsPassed++;
        g_TestPanels.insertLast(testButton);
    }
    else
    {
        g_TestsFailed++;
    }

    VGUILabel@ testLabel = CreateLabel("Test", 0, 0, 100, 30);
    if (testLabel !is null && testLabel.IsValid())
    {
        g_TestsPassed++;
        g_TestPanels.insertLast(testLabel);
    }
    else
    {
        g_TestsFailed++;
    }

    VGUITextEntry@ testEntry = CreateTextEntry(0, 0, 100, 30);
    if (testEntry !is null && testEntry.IsValid())
    {
        g_TestsPassed++;
        g_TestPanels.insertLast(testEntry);
    }
    else
    {
        g_TestsFailed++;
    }

    VGUIPanel@ testPanel = CreatePanel(0, 0, 100, 100);
    if (testPanel !is null && testPanel.IsValid())
    {
        g_TestsPassed++;
        g_TestPanels.insertLast(testPanel);
    }
    else
    {
        g_TestsFailed++;
    }

    UpdateStatus("Factory function tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnTestUtilities()
{
    UpdateStatus("Running utility function tests...");
    LogMessage("[VGUI Interactive] Running utility function tests...");

    g_TestsPassed = 0;
    g_TestsFailed = 0;

    TestUtilityFunctions_GetScreenSize();
    TestUtilityFunctions_IsPanelValid();

    UpdateStatus("Utility function tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnTestIntegration()
{
    UpdateStatus("Running integration tests...");
    LogMessage("[VGUI Interactive] Running integration tests...");

    g_TestsPassed = 0;
    g_TestsFailed = 0;

    TestIntegration_Hierarchy();
    TestIntegration_ComplexUI();

    UpdateStatus("Integration tests completed");
    UpdateResults(g_TestsPassed, g_TestsFailed);
}

void OnCleanupTests()
{
    UpdateStatus("Cleaning up test panels...");
    LogMessage("[VGUI Interactive] Cleaning up test panels...");

    CleanupTests();

    UpdateStatus("Cleanup completed");
    UpdateResults(0, 0);  // Reset results
}

    // ========================================================================
    // Keyboard Shortcuts (Future Enhancement)
    // ========================================================================

    // TODO: Add keyboard shortcut support
    // F1 - Show/hide control panel
    // F2 - Run all tests
    // F3 - Cleanup
    // etc.

// Note: Global callback functions (OnRunAllTests, OnTestVGUIPanel, etc.)
// are defined above and will be called by VGUI button clicks
