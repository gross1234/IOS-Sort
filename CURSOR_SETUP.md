# Cursor Development Setup Guide

## Recommended Cursor Settings

Create a `.vscode/settings.json` file in your project root with these settings:

```json
{
  "editor.tabSize": 4,
  "editor.insertSpaces": true,
  "editor.rulers": [120],
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.associations": {
    "*.swift": "swift"
  },
  "search.exclude": {
    "**/build": true,
    "**/DerivedData": true,
    "**/xcuserdata": true,
    "**/.DS_Store": true
  },
  "files.exclude": {
    "**/build": true,
    "**/DerivedData": true,
    "**/xcuserdata": true,
    "**/.DS_Store": true
  }
}
```

## Cursor Extensions for iOS Development

Install these recommended extensions:

1. **Swift** - Official Swift language support
2. **SwiftLint** - Code linting and formatting
3. **iOS Simulator** - Run iOS apps directly from Cursor
4. **GitLens** - Enhanced Git capabilities
5. **Bracket Pair Colorizer** - Better code readability
6. **Auto Rename Tag** - Rename paired tags automatically
7. **Path Intellisense** - Autocomplete file paths

## Keyboard Shortcuts

- `Cmd + Shift + P` - Command Palette
- `Cmd + P` - Quick Open
- `Cmd + Shift + F` - Search across files
- `Cmd + D` - Select next occurrence
- `Cmd + Shift + L` - Select all occurrences
- `Option + Up/Down` - Move line up/down
- `Shift + Option + Up/Down` - Copy line up/down
- `Cmd + /` - Toggle line comment
- `Cmd + Shift + /` - Toggle block comment

## Cursor AI Features for iOS Development

### Code Generation

- Use `Cmd + K` to generate code with AI
- Ask for SwiftUI components, ViewModels, or Models
- Request algorithm implementations

### Code Explanation

- Select code and ask "Explain this code"
- Get detailed explanations of Swift/SwiftUI concepts

### Refactoring

- Ask AI to refactor code for better performance
- Request code optimization suggestions

### Debugging Help

- Paste error messages for AI assistance
- Get suggestions for fixing compilation errors

## Best Practices

1. **Use Cursor's AI Chat** for:

   - Code generation and completion
   - Debugging assistance
   - Code explanation and learning
   - Refactoring suggestions

2. **Leverage Codebase Search**:

   - Use `Cmd + Shift + F` to search across all files
   - Find function definitions and usages
   - Search for specific patterns

3. **Take Advantage of IntelliSense**:

   - Auto-completion for Swift APIs
   - Parameter hints and documentation
   - Error detection and suggestions

4. **Use Git Integration**:
   - View diffs directly in Cursor
   - Stage and commit changes
   - Resolve merge conflicts

## Project-Specific Tips

### For This Sorting App:

- Use AI to generate new sorting algorithms
- Ask for help with SwiftUI animations
- Get suggestions for performance optimization
- Request help with MVVM architecture patterns

### Common AI Prompts:

- "Generate a SwiftUI view for..."
- "Create a ViewModel for..."
- "Implement [algorithm name] in Swift"
- "Optimize this Swift code for performance"
- "Add error handling to this function"
- "Create unit tests for this class"

## Troubleshooting

### If Cursor isn't recognizing Swift files:

1. Check file associations in settings
2. Install Swift extension
3. Restart Cursor

### If IntelliSense isn't working:

1. Ensure Xcode is installed
2. Check Swift toolchain path
3. Reload window (`Cmd + Shift + P` → "Developer: Reload Window")

### If AI features aren't working:

1. Check internet connection
2. Verify Cursor subscription
3. Try restarting Cursor
