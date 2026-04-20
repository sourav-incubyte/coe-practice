# Maestro Test Examples

This directory contains simple Maestro test examples demonstrating various Maestro features.

## Running Tests

Run all tests:
```bash
maestro test .maestro
```

Run a specific test:
```bash
maestro test .maestro/counter_test.yaml
```

## Test Files

### 1. counter_test.yaml
**Main test for the counter app**
- Launches the app
- Waits for animations
- Asserts initial counter value (0)
- Taps increment 3 times
- Taps decrement once
- Asserts final value (2)
- Takes screenshot

**Features demonstrated:**
- `launchApp` - Launch the application
- `waitForAnimationToEnd` - Wait for animations to complete
- `assertVisible` - Assert an element is visible
- `tapOn` - Tap on an element
- `takeScreenshot` - Take a screenshot

### 2. input_example.yaml
**Text input and form interactions**
- Demonstrates how to input text into fields
- Shows how to assert text content
- Shows how to clear text

**Features demonstrated:**
- `inputText` - Input text into a field
- `assertText` - Assert text content
- `clearText` - Clear text from a field

### 3. scrolling_example.yaml
**Scrolling interactions**
- Shows how to scroll by percentage
- Shows how to scroll until an element is visible
- Shows how to scroll between coordinates

**Features demonstrated:**
- `scroll` - Scroll by percentage
- `scrollUntilVisible` - Scroll until element is visible
- Scroll with speed control

### 4. wait_example.yaml
**Wait conditions**
- Shows how to wait for animations
- Shows how to wait until an element is visible
- Shows how to wait until an element is not visible
- Shows how to wait for a specific duration

**Features demonstrated:**
- `waitForAnimationToEnd` - Wait for animations
- `waitUntilVisible` - Wait until element is visible
- `waitUntilNotVisible` - Wait until element is not visible
- `wait` - Wait for specific duration

### 5. swipe_example.yaml
**Swipe gestures**
- Shows how to swipe in different directions
- Shows how to swipe on specific elements
- Shows how to control swipe duration

**Features demonstrated:**
- `swipe` - Swipe in a direction
- `swipeOn` - Swipe on a specific element
- Direction control (LEFT, RIGHT, UP, DOWN)
- Duration control

### 6. conditional_example.yaml
**Conditional logic**
- Shows how to execute actions based on element visibility
- Shows if/else patterns for different scenarios

**Features demonstrated:**
- `ifElse` - Conditional execution
- Condition based on element visibility
- ifTrue/ifFalse branches

### 7. system_example.yaml
**System interactions**
- Shows how to press back button
- Shows how to open links
- Shows how to set location
- Shows how to set permissions

**Features demonstrated:**
- `pressBack` - Press back button
- `openLink` - Open a URL
- `setLocation` - Set GPS location
- `setPermissions` - Grant permissions

## Common Maestro Commands

### Basic Actions
- `tapOn` - Tap on an element
- `longPressOn` - Long press on an element
- `doubleTapOn` - Double tap on an element

### Assertions
- `assertVisible` - Assert element is visible
- `assertNotVisible` - Assert element is not visible
- `assertText` - Assert text content
- `assertTextContains` - Assert text contains substring

### Navigation
- `pressBack` - Press back button
- `openLink` - Open a URL

### Input
- `inputText` - Input text
- `clearText` - Clear text

### Gestures
- `swipe` - Swipe gesture
- `swipeOn` - Swipe on specific element
- `scroll` - Scroll screen
- `scrollUntilVisible` - Scroll until element visible

### Wait Conditions
- `waitForAnimationToEnd` - Wait for animations
- `waitUntilVisible` - Wait until element visible
- `waitUntilNotVisible` - Wait until element not visible
- `wait` - Wait for duration

### System
- `setLocation` - Set GPS location
- `setPermissions` - Grant permissions
- `copyText` - Copy text
- `pasteText` - Paste text

## Tips

1. **Use `waitForAnimationToEnd`** before interactions to ensure UI is ready
2. **Take screenshots** at key points for debugging
3. **Use specific selectors** (text, id, etc.) for reliable element targeting
4. **Keep tests simple** - one test should verify one user flow
5. **Use descriptive names** for test files and screenshots
