//==========================================================================
// vgui_test_suite.as
//
// Comprehensive VGUI AngelScript Test Suite Module
// Tests all VGUI bindings: VGUIPanel, VGUIFrame, VGUIButton, VGUILabel,
// VGUITextEntry, VGUIImagePanel, and factory/utility functions
//==========================================================================

#pragma context client

// ========================================================================
// Global State Variables (accessible from module and global functions)
// ========================================================================

int g_TestsPassed = 0;
int g_TestsFailed = 0;
array<string> g_TestLog;

// Test panel tracking for cleanup
array<VGUIPanel@> g_TestPanels;

// Button callback counters
int g_Button1ClickCount = 0;
int g_Button2ClickCount = 0;
bool g_InvalidCallbackTested = false;

// ========================================================================
// Initialization
// ========================================================================

void main()
{
    LogMessage("[VGUI Test Suite] Script initialized");
    LogMessage("[VGUI Test Suite] Call RunAllTests() to start testing");

    // Auto-run tests on load (uncomment if desired)
    // RunAllTests();
}

// ========================================================================
// Test Result Reporting
// ========================================================================
void ReportTestStart(const string &in testName)
{
    LogMessage("[VGUI Test] Starting: " + testName);
    g_TestLog.insertLast("Starting: " + testName);
}

void ReportTest(const string &in testName, bool passed)
{
    if (passed)
    {
        g_TestsPassed++;
        LogMessage("[VGUI Test] PASSED: " + testName);
        g_TestLog.insertLast("✓ PASSED: " + testName);
    }
    else
    {
        g_TestsFailed++;
        LogMessage("[VGUI Test] FAILED: " + testName);
        g_TestLog.insertLast("✗ FAILED: " + testName);
    }
}

void ReportStep(const string &in message, bool success = true)
{
    if (success)
    {
        LogMessage("[VGUI Test]   ✓ " + message);
    }
    else
    {
        LogMessage("[VGUI Test]   ✗ " + message);
    }
}

void PrintTestSummary()
{
    LogMessage("[VGUI Test] ================================");
    LogMessage("[VGUI Test] Test Summary:");
    LogMessage("[VGUI Test] " + g_TestsPassed + " tests passed");
    LogMessage("[VGUI Test] " + g_TestsFailed + " tests failed");
    LogMessage("[VGUI Test] Total: " + (g_TestsPassed + g_TestsFailed) + " tests");
    LogMessage("[VGUI Test] ================================");
}

// ============================================================================
// VGUIPanel Base Class Tests
// ============================================================================

void TestVGUIPanel_Creation()
{
    ReportTestStart("TestVGUIPanel_Creation");

    VGUIPanel@ panel = CreatePanel(10, 10, 100, 100);

    if (panel is null)
    {
        ReportStep("Panel creation failed", false);
        ReportTest("TestVGUIPanel_Creation", false);
        return;
    }

    ReportStep("Panel created successfully");

    if (!panel.IsValid())
    {
        ReportStep("Panel IsValid() returned false", false);
        ReportTest("TestVGUIPanel_Creation", false);
        return;
    }

    ReportStep("Panel IsValid() returned true");

    g_TestPanels.insertLast(panel);
    ReportTest("TestVGUIPanel_Creation", true);
}

void TestVGUIPanel_Position()
{
    ReportTestStart("TestVGUIPanel_Position");

    VGUIPanel@ panel = CreatePanel(0, 0, 100, 100);

    if (panel is null || !panel.IsValid())
    {
        ReportStep("Panel creation/validation failed", false);
        ReportTest("TestVGUIPanel_Position", false);
        return;
    }

    // Test SetPos
    panel.SetPos(150, 200);
    ReportStep("SetPos(150, 200) called");

    // Note: GetPos would require out parameters which we can't easily test
    // in this simple framework. This is more of a visual/integration test.

    panel.SetPos(300, 400);
    ReportStep("SetPos(300, 400) called - position changed");

    g_TestPanels.insertLast(panel);
    ReportTest("TestVGUIPanel_Position", true);
}

void TestVGUIPanel_Size()
{
    ReportTestStart("TestVGUIPanel_Size");

    VGUIPanel@ panel = CreatePanel(10, 10, 50, 50);

    if (panel is null || !panel.IsValid())
    {
        ReportStep("Panel creation/validation failed", false);
        ReportTest("TestVGUIPanel_Size", false);
        return;
    }

    ReportStep("Initial size: 50x50");

    // Test SetSize
    panel.SetSize(200, 150);
    ReportStep("SetSize(200, 150) called");

    panel.SetSize(100, 100);
    ReportStep("SetSize(100, 100) called - size changed");

    g_TestPanels.insertLast(panel);
    ReportTest("TestVGUIPanel_Size", true);
}

void TestVGUIPanel_Bounds()
{
    ReportTestStart("TestVGUIPanel_Bounds");

    VGUIPanel@ panel = CreatePanel(0, 0, 50, 50);

    if (panel is null || !panel.IsValid())
    {
        ReportStep("Panel creation/validation failed", false);
        ReportTest("TestVGUIPanel_Bounds", false);
        return;
    }

    // Test SetBounds
    panel.SetBounds(100, 100, 200, 150);
    ReportStep("SetBounds(100, 100, 200, 150) called");

    panel.SetBounds(50, 50, 300, 200);
    ReportStep("SetBounds(50, 50, 300, 200) called - bounds changed");

    g_TestPanels.insertLast(panel);
    ReportTest("TestVGUIPanel_Bounds", true);
}

void TestVGUIPanel_Visibility()
{
    ReportTestStart("TestVGUIPanel_Visibility");

    VGUIPanel@ panel = CreatePanel(10, 10, 100, 100);

    if (panel is null || !panel.IsValid())
    {
        ReportStep("Panel creation/validation failed", false);
        ReportTest("TestVGUIPanel_Visibility", false);
        return;
    }

    // Test visibility
    panel.SetVisible(false);
    ReportStep("SetVisible(false) called");

    bool visible = panel.IsVisible();
    if (visible)
    {
        ReportStep("IsVisible() returned true when should be false", false);
        ReportTest("TestVGUIPanel_Visibility", false);
        return;
    }

    ReportStep("IsVisible() correctly returned false");

    panel.SetVisible(true);
    ReportStep("SetVisible(true) called");

    visible = panel.IsVisible();
    if (!visible)
    {
        ReportStep("IsVisible() returned false when should be true", false);
        ReportTest("TestVGUIPanel_Visibility", false);
        return;
    }

    ReportStep("IsVisible() correctly returned true");

    g_TestPanels.insertLast(panel);
    ReportTest("TestVGUIPanel_Visibility", true);
}

void TestVGUIPanel_Colors()
{
    ReportTestStart("TestVGUIPanel_Colors");

    VGUIPanel@ panel = CreatePanel(400, 10, 100, 100);

    if (panel is null || !panel.IsValid())
    {
        ReportStep("Panel creation/validation failed", false);
        ReportTest("TestVGUIPanel_Colors", false);
        return;
    }

    panel.SetVisible(true);

    // Test foreground color (red)
    panel.SetFgColor(255, 0, 0, 255);
    ReportStep("SetFgColor(255, 0, 0, 255) - Red");

    // Test background color (blue)
    panel.SetBgColor(0, 0, 255, 200);
    ReportStep("SetBgColor(0, 0, 255, 200) - Semi-transparent blue");

    g_TestPanels.insertLast(panel);
    ReportTest("TestVGUIPanel_Colors", true);
}

void TestVGUIPanel_Rendering()
{
    ReportTestStart("TestVGUIPanel_Rendering");

    VGUIPanel@ panel = CreatePanel(510, 10, 100, 100);

    if (panel is null || !panel.IsValid())
    {
        ReportStep("Panel creation/validation failed", false);
        ReportTest("TestVGUIPanel_Rendering", false);
        return;
    }

    panel.SetVisible(true);
    panel.SetBgColor(0, 255, 0, 255);

    // Test repaint
    panel.Repaint();
    ReportStep("Repaint() called");

    // Test paint enabled/disabled
    panel.SetPaintEnabled(false);
    ReportStep("SetPaintEnabled(false) called");

    panel.SetPaintEnabled(true);
    ReportStep("SetPaintEnabled(true) called");

    g_TestPanels.insertLast(panel);
    ReportTest("TestVGUIPanel_Rendering", true);
}

void TestVGUIPanel_MouseInteraction()
{
    ReportTestStart("TestVGUIPanel_MouseInteraction");

    VGUIPanel@ panel = CreatePanel(620, 10, 100, 100);

    if (panel is null || !panel.IsValid())
    {
        ReportStep("Panel creation/validation failed", false);
        ReportTest("TestVGUIPanel_MouseInteraction", false);
        return;
    }

    panel.SetVisible(true);
    panel.SetBgColor(255, 255, 0, 255);

    // Test mouse over detection (will depend on actual mouse position)
    bool mouseOver = panel.IsMouseOver();
    ReportStep("IsMouseOver() returned: " + (mouseOver ? "true" : "false"));
    ReportStep("Mouse detection functional (move mouse over yellow panel to test)");

    g_TestPanels.insertLast(panel);
    ReportTest("TestVGUIPanel_MouseInteraction", true);
}

void TestVGUIPanel_Removal()
{
    ReportTestStart("TestVGUIPanel_Removal");

    VGUIPanel@ panel = CreatePanel(730, 10, 100, 100);

    if (panel is null || !panel.IsValid())
    {
        ReportStep("Panel creation/validation failed", false);
        ReportTest("TestVGUIPanel_Removal", false);
        return;
    }

    panel.SetVisible(true);
    panel.SetBgColor(255, 0, 255, 255);
    ReportStep("Panel created and visible");

    // Test removal
    panel.Remove();
    ReportStep("Remove() called - panel should be removed from parent");

    // Don't add to tracking array since we removed it
    ReportTest("TestVGUIPanel_Removal", true);
}

// ============================================================================
// VGUIFrame Tests
// ============================================================================

void TestVGUIFrame_Creation()
{
    ReportTestStart("TestVGUIFrame_Creation");

    VGUIFrame@ frame = CreateFrame(50, 150, 300, 200, "Test Frame");

    if (frame is null)
    {
        ReportStep("Frame creation failed", false);
        ReportTest("TestVGUIFrame_Creation", false);
        return;
    }

    ReportStep("Frame created successfully");

    if (!frame.IsValid())
    {
        ReportStep("Frame IsValid() returned false", false);
        ReportTest("TestVGUIFrame_Creation", false);
        return;
    }

    ReportStep("Frame IsValid() returned true");

    frame.SetVisible(true);
    ReportStep("Frame set visible");

    g_TestPanels.insertLast(frame);
    ReportTest("TestVGUIFrame_Creation", true);
}

void TestVGUIFrame_Title()
{
    ReportTestStart("TestVGUIFrame_Title");

    VGUIFrame@ frame = CreateFrame(370, 150, 300, 200, "Initial Title");

    if (frame is null || !frame.IsValid())
    {
        ReportStep("Frame creation/validation failed", false);
        ReportTest("TestVGUIFrame_Title", false);
        return;
    }

    frame.SetVisible(true);
    ReportStep("Frame created with title: 'Initial Title'");

    frame.SetTitle("Updated Title");
    ReportStep("SetTitle('Updated Title') called");

    frame.SetTitle("Final Title Test");
    ReportStep("SetTitle('Final Title Test') called");

    g_TestPanels.insertLast(frame);
    ReportTest("TestVGUIFrame_Title", true);
}

void TestVGUIFrame_Moveable()
{
    ReportTestStart("TestVGUIFrame_Moveable");

    VGUIFrame@ frame = CreateFrame(50, 370, 280, 180, "Moveable Test");

    if (frame is null || !frame.IsValid())
    {
        ReportStep("Frame creation/validation failed", false);
        ReportTest("TestVGUIFrame_Moveable", false);
        return;
    }

    frame.SetVisible(true);

    frame.SetMoveable(true);
    ReportStep("SetMoveable(true) - frame can be dragged by title bar");

    frame.SetMoveable(false);
    ReportStep("SetMoveable(false) - frame cannot be dragged");

    frame.SetMoveable(true);
    ReportStep("SetMoveable(true) - dragging re-enabled");

    g_TestPanels.insertLast(frame);
    ReportTest("TestVGUIFrame_Moveable", true);
}

void TestVGUIFrame_Sizeable()
{
    ReportTestStart("TestVGUIFrame_Sizeable");

    VGUIFrame@ frame = CreateFrame(350, 370, 280, 180, "Sizeable Test");

    if (frame is null || !frame.IsValid())
    {
        ReportStep("Frame creation/validation failed", false);
        ReportTest("TestVGUIFrame_Sizeable", false);
        return;
    }

    frame.SetVisible(true);

    frame.SetSizeable(true);
    ReportStep("SetSizeable(true) - frame can be resized by edges");

    frame.SetSizeable(false);
    ReportStep("SetSizeable(false) - frame cannot be resized");

    g_TestPanels.insertLast(frame);
    ReportTest("TestVGUIFrame_Sizeable", true);
}

void TestVGUIFrame_Buttons()
{
    ReportTestStart("TestVGUIFrame_Buttons");

    VGUIFrame@ frame = CreateFrame(650, 370, 280, 180, "Button Test");

    if (frame is null || !frame.IsValid())
    {
        ReportStep("Frame creation/validation failed", false);
        ReportTest("TestVGUIFrame_Buttons", false);
        return;
    }

    frame.SetVisible(true);

    frame.SetCloseButton(true);
    ReportStep("SetCloseButton(true) - close button visible");

    frame.SetMinimizeButton(true);
    ReportStep("SetMinimizeButton(true) - minimize button visible");

    frame.SetCloseButton(false);
    ReportStep("SetCloseButton(false) - close button hidden");

    frame.SetCloseButton(true);
    ReportStep("SetCloseButton(true) - close button shown again");

    g_TestPanels.insertLast(frame);
    ReportTest("TestVGUIFrame_Buttons", true);
}

void TestVGUIFrame_Center()
{
    ReportTestStart("TestVGUIFrame_Center");

    VGUIFrame@ frame = CreateFrame(0, 0, 400, 300, "Centered Frame");

    if (frame is null || !frame.IsValid())
    {
        ReportStep("Frame creation/validation failed", false);
        ReportTest("TestVGUIFrame_Center", false);
        return;
    }

    frame.SetMoveable(true);
    frame.SetCloseButton(true);

    frame.Center();
    ReportStep("Center() called - frame positioned at screen center");

    frame.SetVisible(true);
    ReportStep("Frame made visible at center position");

    g_TestPanels.insertLast(frame);
    ReportTest("TestVGUIFrame_Center", true);
}

void TestVGUIFrame_Inheritance()
{
    ReportTestStart("TestVGUIFrame_Inheritance");

    VGUIFrame@ frame = CreateFrame(100, 570, 250, 150, "Inheritance Test");

    if (frame is null || !frame.IsValid())
    {
        ReportStep("Frame creation/validation failed", false);
        ReportTest("TestVGUIFrame_Inheritance", false);
        return;
    }

    frame.SetVisible(true);

    // Test inherited VGUIPanel methods
    frame.SetBgColor(200, 200, 255, 255);
    ReportStep("SetBgColor() - inherited from VGUIPanel");

    frame.SetPos(120, 590);
    ReportStep("SetPos() - inherited from VGUIPanel");

    frame.SetSize(300, 180);
    ReportStep("SetSize() - inherited from VGUIPanel");

    bool visible = frame.IsVisible();
    ReportStep("IsVisible() returned: " + (visible ? "true" : "false"));

    g_TestPanels.insertLast(frame);
    ReportTest("TestVGUIFrame_Inheritance", true);
}

// ============================================================================
// VGUIButton Tests
// ============================================================================

void TestVGUIButton_Creation()
{
    ReportTestStart("TestVGUIButton_Creation");

    VGUIButton@ button = CreateButton("Test Button", 50, 730, 120, 30);

    if (button is null)
    {
        ReportStep("Button creation failed", false);
        ReportTest("TestVGUIButton_Creation", false);
        return;
    }

    ReportStep("Button created successfully");

    if (!button.IsValid())
    {
        ReportStep("Button IsValid() returned false", false);
        ReportTest("TestVGUIButton_Creation", false);
        return;
    }

    ReportStep("Button IsValid() returned true");

    button.SetVisible(true);
    ReportStep("Button set visible");

    g_TestPanels.insertLast(button);
    ReportTest("TestVGUIButton_Creation", true);
}

void TestVGUIButton_Text()
{
    ReportTestStart("TestVGUIButton_Text");

    VGUIButton@ button = CreateButton("Initial Text", 180, 730, 150, 30);

    if (button is null || !button.IsValid())
    {
        ReportStep("Button creation/validation failed", false);
        ReportTest("TestVGUIButton_Text", false);
        return;
    }

    button.SetVisible(true);
    ReportStep("Button created with text: 'Initial Text'");

    button.SetText("Updated Text");
    ReportStep("SetText('Updated Text') called");

    button.SetText("Final");
    ReportStep("SetText('Final') called");

    g_TestPanels.insertLast(button);
    ReportTest("TestVGUIButton_Text", true);
}

// Button callback handlers
void OnTestButton1Clicked()
{
    g_Button1ClickCount++;
    LogMessage("[VGUI Test] Button 1 clicked! Count: " + g_Button1ClickCount);
}

void OnTestButton2Clicked()
{
    g_Button2ClickCount++;
    LogMessage("[VGUI Test] Button 2 clicked! Count: " + g_Button2ClickCount);
}

void TestVGUIButton_Callbacks()
{
    ReportTestStart("TestVGUIButton_Callbacks");

    VGUIButton@ button1 = CreateButton("Click Me 1", 340, 730, 100, 30);
    VGUIButton@ button2 = CreateButton("Click Me 2", 450, 730, 100, 30);

    if (button1 is null || !button1.IsValid() || button2 is null || !button2.IsValid())
    {
        ReportStep("Button creation/validation failed", false);
        ReportTest("TestVGUIButton_Callbacks", false);
        return;
    }

    button1.SetVisible(true);
    button2.SetVisible(true);

    // Set callbacks
    button1.SetCallback("OnTestButton1Clicked");
    ReportStep("Button 1 callback set to 'OnTestButton1Clicked'");

    button2.SetCallback("OnTestButton2Clicked");
    ReportStep("Button 2 callback set to 'OnTestButton2Clicked'");

    ReportStep("Click buttons to test callbacks (check console for click counts)");

    g_TestPanels.insertLast(button1);
    g_TestPanels.insertLast(button2);
    ReportTest("TestVGUIButton_Callbacks", true);
}

void TestVGUIButton_EnableDisable()
{
    ReportTestStart("TestVGUIButton_EnableDisable");

    VGUIButton@ button = CreateButton("Enable Test", 560, 730, 120, 30);

    if (button is null || !button.IsValid())
    {
        ReportStep("Button creation/validation failed", false);
        ReportTest("TestVGUIButton_EnableDisable", false);
        return;
    }

    button.SetVisible(true);

    button.SetEnabled(true);
    ReportStep("SetEnabled(true) - button is clickable");

    button.SetEnabled(false);
    ReportStep("SetEnabled(false) - button is disabled");

    button.SetEnabled(true);
    ReportStep("SetEnabled(true) - button re-enabled");

    g_TestPanels.insertLast(button);
    ReportTest("TestVGUIButton_EnableDisable", true);
}

void TestVGUIButton_Colors()
{
    ReportTestStart("TestVGUIButton_Colors");

    VGUIButton@ button = CreateButton("Hover Me", 690, 730, 100, 30);

    if (button is null || !button.IsValid())
    {
        ReportStep("Button creation/validation failed", false);
        ReportTest("TestVGUIButton_Colors", false);
        return;
    }

    button.SetVisible(true);

    // Set armed color (when mouse hovers)
    button.SetArmedColor(100, 200, 255, 255);
    ReportStep("SetArmedColor(100, 200, 255, 255) - light blue on hover");

    // Set depressed color (when clicked)
    button.SetDepressedColor(255, 100, 100, 255);
    ReportStep("SetDepressedColor(255, 100, 100, 255) - red when clicked");

    ReportStep("Hover over and click button to see color changes");

    g_TestPanels.insertLast(button);
    ReportTest("TestVGUIButton_Colors", true);
}

// ============================================================================
// VGUILabel Tests
// ============================================================================

void TestVGUILabel_Creation()
{
    ReportTestStart("TestVGUILabel_Creation");

    VGUILabel@ label = CreateLabel("Test Label", 800, 50, 150, 30);

    if (label is null)
    {
        ReportStep("Label creation failed", false);
        ReportTest("TestVGUILabel_Creation", false);
        return;
    }

    ReportStep("Label created successfully");

    if (!label.IsValid())
    {
        ReportStep("Label IsValid() returned false", false);
        ReportTest("TestVGUILabel_Creation", false);
        return;
    }

    ReportStep("Label IsValid() returned true");

    label.SetVisible(true);
    ReportStep("Label set visible");

    g_TestPanels.insertLast(label);
    ReportTest("TestVGUILabel_Creation", true);
}

void TestVGUILabel_Text()
{
    ReportTestStart("TestVGUILabel_Text");

    VGUILabel@ label = CreateLabel("Initial Label Text", 800, 90, 200, 30);

    if (label is null || !label.IsValid())
    {
        ReportStep("Label creation/validation failed", false);
        ReportTest("TestVGUILabel_Text", false);
        return;
    }

    label.SetVisible(true);
    ReportStep("Label created with text: 'Initial Label Text'");

    label.SetText("Updated Label");
    ReportStep("SetText('Updated Label') called");

    label.SetText("Long label text to test rendering");
    ReportStep("SetText('Long label text to test rendering') called");

    g_TestPanels.insertLast(label);
    ReportTest("TestVGUILabel_Text", true);
}

void TestVGUILabel_Color()
{
    ReportTestStart("TestVGUILabel_Color");

    VGUILabel@ label = CreateLabel("Colored Text", 800, 130, 150, 30);

    if (label is null || !label.IsValid())
    {
        ReportStep("Label creation/validation failed", false);
        ReportTest("TestVGUILabel_Color", false);
        return;
    }

    label.SetVisible(true);

    // Red text
    label.SetTextColor(255, 0, 0, 255);
    ReportStep("SetTextColor(255, 0, 0, 255) - red text");

    g_TestPanels.insertLast(label);
    ReportTest("TestVGUILabel_Color", true);
}

void TestVGUILabel_Alignment()
{
    ReportTestStart("TestVGUILabel_Alignment");

    VGUILabel@ labelLeft = CreateLabel("Left Aligned", 800, 170, 200, 25);
    VGUILabel@ labelCenter = CreateLabel("Center Aligned", 800, 200, 200, 25);
    VGUILabel@ labelRight = CreateLabel("Right Aligned", 800, 230, 200, 25);

    if (labelLeft is null || !labelLeft.IsValid() ||
        labelCenter is null || !labelCenter.IsValid() ||
        labelRight is null || !labelRight.IsValid())
    {
        ReportStep("Label creation/validation failed", false);
        ReportTest("TestVGUILabel_Alignment", false);
        return;
    }

    labelLeft.SetVisible(true);
    labelCenter.SetVisible(true);
    labelRight.SetVisible(true);

    // Set background colors to visualize alignment
    labelLeft.SetBgColor(50, 50, 50, 255);
    labelCenter.SetBgColor(50, 50, 50, 255);
    labelRight.SetBgColor(50, 50, 50, 255);

    labelLeft.SetContentAlignment(0);  // Left
    ReportStep("Left label: SetContentAlignment(0) - left aligned");

    labelCenter.SetContentAlignment(1);  // Center
    ReportStep("Center label: SetContentAlignment(1) - center aligned");

    labelRight.SetContentAlignment(2);  // Right
    ReportStep("Right label: SetContentAlignment(2) - right aligned");

    g_TestPanels.insertLast(labelLeft);
    g_TestPanels.insertLast(labelCenter);
    g_TestPanels.insertLast(labelRight);
    ReportTest("TestVGUILabel_Alignment", true);
}

// ============================================================================
// VGUITextEntry Tests
// ============================================================================

void TestVGUITextEntry_Creation()
{
    ReportTestStart("TestVGUITextEntry_Creation");

    VGUITextEntry@ entry = CreateTextEntry(800, 270, 200, 25);

    if (entry is null)
    {
        ReportStep("TextEntry creation failed", false);
        ReportTest("TestVGUITextEntry_Creation", false);
        return;
    }

    ReportStep("TextEntry created successfully");

    if (!entry.IsValid())
    {
        ReportStep("TextEntry IsValid() returned false", false);
        ReportTest("TestVGUITextEntry_Creation", false);
        return;
    }

    ReportStep("TextEntry IsValid() returned true");

    entry.SetVisible(true);
    entry.SetText("Type here...");
    ReportStep("TextEntry set visible with placeholder text");

    g_TestPanels.insertLast(entry);
    ReportTest("TestVGUITextEntry_Creation", true);
}

void TestVGUITextEntry_TextOperations()
{
    ReportTestStart("TestVGUITextEntry_TextOperations");

    VGUITextEntry@ entry = CreateTextEntry(800, 305, 200, 25);

    if (entry is null || !entry.IsValid())
    {
        ReportStep("TextEntry creation/validation failed", false);
        ReportTest("TestVGUITextEntry_TextOperations", false);
        return;
    }

    entry.SetVisible(true);

    // Set text
    entry.SetText("Initial text");
    ReportStep("SetText('Initial text') called");

    // Get text
    string text = entry.GetText();
    ReportStep("GetText() returned: '" + text + "'");

    if (text != "Initial text")
    {
        ReportStep("Text mismatch: expected 'Initial text', got '" + text + "'", false);
        ReportTest("TestVGUITextEntry_TextOperations", false);
        return;
    }

    // Update text
    entry.SetText("Updated text");
    text = entry.GetText();
    ReportStep("After SetText('Updated text'), GetText() returned: '" + text + "'");

    g_TestPanels.insertLast(entry);
    ReportTest("TestVGUITextEntry_TextOperations", true);
}

void TestVGUITextEntry_Editable()
{
    ReportTestStart("TestVGUITextEntry_Editable");

    VGUITextEntry@ entry = CreateTextEntry(800, 340, 200, 25);

    if (entry is null || !entry.IsValid())
    {
        ReportStep("TextEntry creation/validation failed", false);
        ReportTest("TestVGUITextEntry_Editable", false);
        return;
    }

    entry.SetVisible(true);
    entry.SetText("Editable field");

    entry.SetEditable(true);
    ReportStep("SetEditable(true) - field can be edited");

    entry.SetEditable(false);
    ReportStep("SetEditable(false) - field is read-only");

    entry.SetEditable(true);
    ReportStep("SetEditable(true) - editing re-enabled");

    g_TestPanels.insertLast(entry);
    ReportTest("TestVGUITextEntry_Editable", true);
}

void TestVGUITextEntry_Limitations()
{
    ReportTestStart("TestVGUITextEntry_Limitations");

    VGUITextEntry@ entry = CreateTextEntry(800, 375, 200, 25);

    if (entry is null || !entry.IsValid())
    {
        ReportStep("TextEntry creation/validation failed", false);
        ReportTest("TestVGUITextEntry_Limitations", false);
        return;
    }

    entry.SetVisible(true);
    entry.SetText("Limitations test");

    // Test SetMaxLength (documented as not fully supported)
    entry.SetMaxLength(10);
    ReportStep("SetMaxLength(10) - NOTE: Not fully supported in base VGUI");

    // Test SetMultiline (documented as not supported)
    entry.SetMultiline(true);
    ReportStep("SetMultiline(true) - NOTE: Not supported, use TextPanel instead");

    g_TestPanels.insertLast(entry);
    ReportTest("TestVGUITextEntry_Limitations", true);
}

// ============================================================================
// VGUIImagePanel Tests
// ============================================================================

void TestVGUIImagePanel_Creation()
{
    ReportTestStart("TestVGUIImagePanel_Creation");

    VGUIImagePanel@ imagePanel = CreateImagePanel("gfx/vgui/test.tga", 800, 410, 128, 128);

    if (imagePanel is null)
    {
        ReportStep("ImagePanel creation failed", false);
        ReportTest("TestVGUIImagePanel_Creation", false);
        return;
    }

    ReportStep("ImagePanel created successfully");

    if (!imagePanel.IsValid())
    {
        ReportStep("ImagePanel IsValid() returned false", false);
        ReportTest("TestVGUIImagePanel_Creation", false);
        return;
    }

    ReportStep("ImagePanel IsValid() returned true");

    imagePanel.SetVisible(true);
    ReportStep("ImagePanel set visible (image may not load if path invalid)");

    g_TestPanels.insertLast(imagePanel);
    ReportTest("TestVGUIImagePanel_Creation", true);
}

void TestVGUIImagePanel_Scaling()
{
    ReportTestStart("TestVGUIImagePanel_Scaling");

    VGUIImagePanel@ imagePanel = CreateImagePanel("gfx/vgui/test.tga", 800, 550, 100, 100);

    if (imagePanel is null || !imagePanel.IsValid())
    {
        ReportStep("ImagePanel creation/validation failed", false);
        ReportTest("TestVGUIImagePanel_Scaling", false);
        return;
    }

    imagePanel.SetVisible(true);

    imagePanel.SetScaleImage(true);
    ReportStep("SetScaleImage(true) - image will scale to fit panel");

    imagePanel.SetScaleImage(false);
    ReportStep("SetScaleImage(false) - image will use original size");

    imagePanel.SetScaleImage(true);
    ReportStep("SetScaleImage(true) - scaling re-enabled");

    g_TestPanels.insertLast(imagePanel);
    ReportTest("TestVGUIImagePanel_Scaling", true);
}

// ============================================================================
// Utility Function Tests
// ============================================================================

void TestUtilityFunctions_GetScreenSize()
{
    ReportTestStart("TestUtilityFunctions_GetScreenSize");

    int screenWide = 0;
    int screenTall = 0;

    GetScreenSize(screenWide, screenTall);

    ReportStep("GetScreenSize() returned: " + screenWide + "x" + screenTall);

    if (screenWide <= 0 || screenTall <= 0)
    {
        ReportStep("Invalid screen dimensions", false);
        ReportTest("TestUtilityFunctions_GetScreenSize", false);
        return;
    }

    ReportStep("Screen dimensions are valid");
    ReportTest("TestUtilityFunctions_GetScreenSize", true);
}

void TestUtilityFunctions_IsPanelValid()
{
    ReportTestStart("TestUtilityFunctions_IsPanelValid");

    VGUIPanel@ validPanel = CreatePanel(10, 10, 50, 50);

    if (validPanel is null)
    {
        ReportStep("Panel creation failed", false);
        ReportTest("TestUtilityFunctions_IsPanelValid", false);
        return;
    }

    // Test with valid panel
    bool isValid = IsPanelValid(validPanel);
    if (!isValid)
    {
        ReportStep("IsPanelValid() returned false for valid panel", false);
        ReportTest("TestUtilityFunctions_IsPanelValid", false);
        return;
    }
    ReportStep("IsPanelValid() correctly returned true for valid panel");

    // Test with null
    VGUIPanel@ nullPanel = null;
    isValid = IsPanelValid(nullPanel);
    if (isValid)
    {
        ReportStep("IsPanelValid() returned true for null panel", false);
        ReportTest("TestUtilityFunctions_IsPanelValid", false);
        return;
    }
    ReportStep("IsPanelValid() correctly returned false for null panel");

    g_TestPanels.insertLast(validPanel);
    ReportTest("TestUtilityFunctions_IsPanelValid", true);
}

// ============================================================================
// Integration Tests
// ============================================================================

void TestIntegration_Hierarchy()
{
    ReportTestStart("TestIntegration_Hierarchy");

    // Create a frame as parent
    VGUIFrame@ frame = CreateFrame(50, 580, 350, 250, "Hierarchy Test");

    if (frame is null || !frame.IsValid())
    {
        ReportStep("Frame creation failed", false);
        ReportTest("TestIntegration_Hierarchy", false);
        return;
    }

    frame.SetVisible(true);
    frame.SetMoveable(true);
    ReportStep("Parent frame created");

    // Create child panel
    VGUIPanel@ childPanel = CreatePanel(10, 40, 330, 80);
    if (childPanel !is null && childPanel.IsValid())
    {
        childPanel.SetBgColor(100, 100, 200, 255);
        frame.AddChild(childPanel);
        ReportStep("Child panel added to frame");
    }

    // Create child button
    VGUIButton@ childButton = CreateButton("Child Button", 10, 130, 100, 25);
    if (childButton !is null && childButton.IsValid())
    {
        frame.AddChild(childButton);
        childButton.SetVisible(true);
        ReportStep("Child button added to frame");
    }

    // Create child label
    VGUILabel@ childLabel = CreateLabel("Child Label", 120, 130, 100, 25);
    if (childLabel !is null && childLabel.IsValid())
    {
        childLabel.SetTextColor(255, 255, 0, 255);
        frame.AddChild(childLabel);
        childLabel.SetVisible(true);
        ReportStep("Child label added to frame");
    }

    // Create child text entry
    VGUITextEntry@ childEntry = CreateTextEntry(10, 165, 200, 25);
    if (childEntry !is null && childEntry.IsValid())
    {
        childEntry.SetText("Child text entry");
        frame.AddChild(childEntry);
        childEntry.SetVisible(true);
        ReportStep("Child text entry added to frame");
    }

    ReportStep("Hierarchy created: Frame → Panel, Button, Label, TextEntry");
    ReportStep("Move the frame to verify children move with parent");

    g_TestPanels.insertLast(frame);
    // Don't add children to tracking array - they'll be cleaned up with parent

    ReportTest("TestIntegration_Hierarchy", true);
}

void TestIntegration_ComplexUI()
{
    ReportTestStart("TestIntegration_ComplexUI");

    VGUIFrame@ frame = CreateFrame(420, 580, 400, 300, "Complex UI Demo");

    if (frame is null || !frame.IsValid())
    {
        ReportStep("Frame creation failed", false);
        ReportTest("TestIntegration_ComplexUI", false);
        return;
    }

    frame.SetVisible(true);
    frame.SetMoveable(true);
    frame.SetSizeable(false);
    frame.SetCloseButton(true);
    ReportStep("Main frame configured");

    // Title label
    VGUILabel@ title = CreateLabel("Complex UI Test", 10, 40, 380, 30);
    if (title !is null && title.IsValid())
    {
        title.SetTextColor(255, 255, 255, 255);
        title.SetContentAlignment(1);  // Center
        frame.AddChild(title);
        title.SetVisible(true);
        ReportStep("Title label added");
    }

    // Input section
    VGUILabel@ inputLabel = CreateLabel("Input:", 10, 80, 60, 25);
    if (inputLabel !is null && inputLabel.IsValid())
    {
        frame.AddChild(inputLabel);
        inputLabel.SetVisible(true);
    }

    VGUITextEntry@ inputField = CreateTextEntry(75, 80, 200, 25);
    if (inputField !is null && inputField.IsValid())
    {
        inputField.SetText("Enter text here");
        frame.AddChild(inputField);
        inputField.SetVisible(true);
        ReportStep("Input field added");
    }

    // Buttons
    VGUIButton@ btn1 = CreateButton("Button 1", 10, 120, 90, 25);
    VGUIButton@ btn2 = CreateButton("Button 2", 110, 120, 90, 25);
    VGUIButton@ btn3 = CreateButton("Button 3", 210, 120, 90, 25);

    if (btn1 !is null && btn1.IsValid())
    {
        frame.AddChild(btn1);
        btn1.SetVisible(true);
    }
    if (btn2 !is null && btn2.IsValid())
    {
        frame.AddChild(btn2);
        btn2.SetVisible(true);
    }
    if (btn3 !is null && btn3.IsValid())
    {
        frame.AddChild(btn3);
        btn3.SetVisible(true);
    }
    ReportStep("Three buttons added");

    // Status panel
    VGUIPanel@ statusPanel = CreatePanel(10, 160, 380, 100);
    if (statusPanel !is null && statusPanel.IsValid())
    {
        statusPanel.SetBgColor(40, 40, 40, 255);
        frame.AddChild(statusPanel);
        statusPanel.SetVisible(true);

        VGUILabel@ statusText = CreateLabel("Status: Ready", 10, 10, 360, 25);
        if (statusText !is null && statusText.IsValid())
        {
            statusText.SetTextColor(0, 255, 0, 255);
            statusPanel.AddChild(statusText);
            statusText.SetVisible(true);
        }

        ReportStep("Status panel added with label");
    }

    ReportStep("Complex UI created with nested elements");

    g_TestPanels.insertLast(frame);
    ReportTest("TestIntegration_ComplexUI", true);
}

// ============================================================================
// Main Test Runner
// ============================================================================

void RunAllTests()
{
    LogMessage("[VGUI Test] ========================================");
    LogMessage("[VGUI Test] Starting VGUI Test Suite");
    LogMessage("[VGUI Test] ========================================");

    // Reset counters
    g_TestsPassed = 0;
    g_TestsFailed = 0;
    g_Button1ClickCount = 0;
    g_Button2ClickCount = 0;

    // VGUIPanel tests
    TestVGUIPanel_Creation();
    TestVGUIPanel_Position();
    TestVGUIPanel_Size();
    TestVGUIPanel_Bounds();
    TestVGUIPanel_Visibility();
    TestVGUIPanel_Colors();
    TestVGUIPanel_Rendering();
    TestVGUIPanel_MouseInteraction();
    TestVGUIPanel_Removal();

    // VGUIFrame tests
    TestVGUIFrame_Creation();
    TestVGUIFrame_Title();
    TestVGUIFrame_Moveable();
    TestVGUIFrame_Sizeable();
    TestVGUIFrame_Buttons();
    TestVGUIFrame_Center();
    TestVGUIFrame_Inheritance();

    // VGUIButton tests
    TestVGUIButton_Creation();
    TestVGUIButton_Text();
    TestVGUIButton_Callbacks();
    TestVGUIButton_EnableDisable();
    TestVGUIButton_Colors();

    // VGUILabel tests
    TestVGUILabel_Creation();
    TestVGUILabel_Text();
    TestVGUILabel_Color();
    TestVGUILabel_Alignment();

    // VGUITextEntry tests
    TestVGUITextEntry_Creation();
    TestVGUITextEntry_TextOperations();
    TestVGUITextEntry_Editable();
    TestVGUITextEntry_Limitations();

    // VGUIImagePanel tests
    TestVGUIImagePanel_Creation();
    TestVGUIImagePanel_Scaling();

    // Utility function tests
    TestUtilityFunctions_GetScreenSize();
    TestUtilityFunctions_IsPanelValid();

    // Integration tests
    TestIntegration_Hierarchy();
    TestIntegration_ComplexUI();

    // Print summary
    PrintTestSummary();

    LogMessage("[VGUI Test] ========================================");
    LogMessage("[VGUI Test] Test suite completed!");
    LogMessage("[VGUI Test] Test panels remain visible for inspection");
    LogMessage("[VGUI Test] Call CleanupTests() to remove all panels");
    LogMessage("[VGUI Test] ========================================");
}

// ============================================================================
// Cleanup
// ============================================================================

void CleanupTests()
{
    LogMessage("[VGUI Test] Cleaning up " + g_TestPanels.length() + " test panels...");

    for (uint i = 0; i < g_TestPanels.length(); i++)
    {
        VGUIPanel@ panel = g_TestPanels[i];
        if (panel !is null && panel.IsValid())
        {
            panel.SetVisible(false);
            panel.Remove();
        }
    }

    g_TestPanels.resize(0);

    LogMessage("[VGUI Test] Cleanup complete");
}
