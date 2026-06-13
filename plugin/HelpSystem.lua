--[[
    CodeAssist Help System
    Comprehensive documentation and help system for the plugin
]]

local HelpSystem = {}

-- Help Topics
HelpSystem.Topics = {
    GettingStarted = {
        title = "Getting Started",
        content = [[
# Getting Started with CodeAssist

## Installation
1. Download the plugin files
2. Configure your Groq API key in the .env file
3. Import the plugin into Roblox Studio
4. Enable the plugin in Plugin Manager

## Basic Usage
1. Click the CodeAssist button in the toolbar
2. Describe what you want to create
3. Click "Generate Code"
4. Copy or insert the generated code

## First Steps
- Try generating a simple player join script
- Experiment with different prompts
- Use the code explanation feature to learn
- Explore the specialized modules
]]
    },
    
    CodeGeneration = {
        title = "Code Generation",
        content = [[
# Code Generation

## Best Practices for Prompts
- Be specific about what you want
- Include context about your project
- Mention any specific requirements
- Reference Roblox services or patterns

## Example Prompts
- "Create a player health system with regeneration"
- "Make a shop system with currency and items"
- "Generate an NPC with pathfinding AI"
- "Create a vehicle with physics"

## Tips
- Use the project analysis for better context
- Review generated code before using
- Iterate on prompts for better results
- Learn from the explanations provided
]]
    },
    
    BugDetection = {
        title = "Bug Detection",
        content = [[
# Bug Detection and Fixing

## How It Works
CodeAssist analyzes your code for:
- Syntax errors
- Logic errors
- Performance issues
- Security vulnerabilities
- Anti-patterns

## Common Bugs Found
- Missing WaitForChild calls
- Unprotected DataStore operations
- Memory leaks
- Race conditions
- Invalid type usage

## Using Bug Detection
1. Select code in Roblox Studio
2. Click "Fix Bugs" in toolbar
3. Review the suggested fixes
4. Apply the corrections
]]
    },
    
    Optimization = {
        title = "Code Optimization",
        content = [[
# Code Optimization

## Optimization Areas
- Performance improvements
- Memory usage reduction
- Network efficiency
- Rendering optimization
- Script execution speed

## Common Optimizations
- Use object pooling
- Implement spatial hashing
- Cache frequently accessed data
- Optimize UI layouts
- Use efficient algorithms

## Best Practices
- Profile before optimizing
- Focus on bottlenecks
- Test after changes
- Document optimizations
- Consider trade-offs
]]
    },
    
    APIReference = {
        title = "API Reference",
        content = [[
# API Reference

## Main Functions
- `AIService:GenerateCode(prompt, context)` - Generate code
- `AIService:OptimizeCode(code)` - Optimize code
- `AIService:FixBugs(code)` - Fix bugs
- `AIService:ExplainCode(code)` - Explain code
- `AIService:AnalyzeProject(structure)` - Analyze project

## Pattern Learning
- `PatternLearning:AnalyzeCode(code)` - Analyze patterns
- `PatternLearning:LearnFromCode(code, context)` - Learn from code
- `PatternLearning:GenerateCodeFromPattern(name, params)` - Generate from pattern

## Specialized Modules
- `SpecializedModules:GetModule(name)` - Get module
- `SpecializedModules:GetComponent(module, component)` - Get component
- `SpecializedModules:GetBestPractices(module)` - Get best practices
]]
    },
    
    RobloxKnowledge = {
        title = "Roblox Knowledge Base",
        content = [[
# Roblox Knowledge Base

## Services Covered
- Players, ReplicatedStorage, ServerStorage
- DataStoreService, HttpService, MessagingService
- TeleportService, MarketplaceService, BadgeService
- RunService, TweenService, UserInputService
- And 30+ more services

## Patterns Included
- Player join/leave handling
- Data storage patterns
- Remote communication
- UI component patterns
- Game system templates

## Best Practices
- Security considerations
- Performance optimization
- Code organization
- Error handling
- Testing methodologies
]]
    },
    
    Troubleshooting = {
        title = "Troubleshooting",
        content = [[
# Troubleshooting

## Common Issues

### Plugin Not Appearing
- Check Plugin Manager
- Verify plugin is enabled
- Restart Roblox Studio
- Check plugin file integrity

### API Key Errors
- Verify .env file configuration
- Check Groq API key validity
- Ensure internet connectivity
- Verify API credits

### Generation Not Working
- Check API configuration
- Verify Groq API status
- Check debug logs
- Reduce max tokens if needed

### Performance Issues
- Enable caching
- Reduce concurrent requests
- Lower max tokens
- Check system resources
]]
    },
    
    AdvancedFeatures = {
        title = "Advanced Features",
        content = [[
# Advanced Features

## Pattern Learning
The plugin learns from your code patterns:
- Recognizes common patterns
- Adapts to your style
- Stores successful patterns
- Provides personalized suggestions

## Context Awareness
CodeAssist considers:
- Project structure
- Existing code patterns
- Common practices
- Performance implications

## Specialized Modules
Access specialized systems:
- UI components library
- Audio management systems
- Physics engines
- Vehicle systems
- AI behaviors
]]
    }
}

-- Search functionality
function HelpSystem:Search(query)
    local results = {}
    query = string.lower(query)
    
    for topicName, topicData in pairs(self.Topics) do
        local content = string.lower(topicData.content)
        local title = string.lower(topicData.title)
        
        if string.find(title, query) or string.find(content, query) then
            table.insert(results, {
                name = topicName,
                title = topicData.title,
                content = topicData.content,
                relevance = self:CalculateRelevance(query, title, content)
            })
        end
    end
    
    -- Sort by relevance
    table.sort(results, function(a, b)
        return a.relevance > b.relevance
    end)
    
    return results
end

function HelpSystem:CalculateRelevance(query, title, content)
    local relevance = 0
    
    if string.find(title, query) then
        relevance = relevance + 10
    end
    
    local occurrences = select(2, string.gsub(content, query, ""))
    relevance = relevance + occurrences
    
    return relevance
end

-- Get topic by name
function HelpSystem:GetTopic(topicName)
    return self.Topics[topicName]
end

-- Get all topics
function HelpSystem:GetAllTopics()
    local topics = {}
    for name, data in pairs(self.Topics) do
        table.insert(topics, {
            name = name,
            title = data.title
        })
    end
    return topics
end

-- Get quick help for common tasks
function HelpSystem:GetQuickHelp(task)
    local quickHelp = {
        ["generate"] = "To generate code: Click the CodeAssist button, describe what you want, and click Generate.",
        ["optimize"] = "To optimize code: Select code in Studio, click Optimize in toolbar.",
        ["fix"] = "To fix bugs: Select code in Studio, click Fix Bugs in toolbar.",
        ["explain"] = "To explain code: Select code in Studio, click Explain in toolbar.",
        ["analyze"] = "To analyze project: Click Analyze Project in toolbar.",
        ["settings"] = "To change settings: Click the settings icon in the CodeAssist widget.",
        ["api"] = "API key is configured in the .env file in the plugin directory."
    }
    
    return quickHelp[task] or "No quick help available for this task."
end

-- Get tutorial for specific feature
function HelpSystem:GetTutorial(feature)
    local tutorials = {
        ["player_system"] = [[
# Player System Tutorial

## Basic Player Join System
```lua
local Players = game:GetService("Players")

local function onPlayerJoin(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
    
    local coins = Instance.new("IntValue")
    coins.Name = "Coins"
    coins.Value = 0
    coins.Parent = leaderstats
end

Players.PlayerAdded:Connect(onPlayerJoin)
```

## Adding Data Storage
1. Add DataStoreService
2. Create save/load functions
3. Handle errors with pcall
4. Save on player leave
]],
        
        ["data_store"] = [[
# Data Store Tutorial

## Basic Data Store Usage
```lua
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("PlayerData")

-- Save data
local success, err = pcall(function()
    DataStore:SetAsync("Player_" .. player.UserId, data)
end)

-- Load data
local success, data = pcall(function()
    return DataStore:GetAsync("Player_" .. player.UserId)
end)
```

## Best Practices
- Always use pcall for DataStore operations
- Implement proper error handling
- Consider data size limits
- Use session locking for concurrent access
]],
        
        ["remote_events"] = [[
# Remote Events Tutorial

## Server to Client
```lua
-- Server
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Parent = ReplicatedStorage

RemoteEvent:FireClient(player, data)

-- Client
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent")

RemoteEvent.OnClientEvent:Connect(function(data)
    -- Handle data
end)
```

## Client to Server
```lua
-- Client
RemoteEvent:FireServer(data)

-- Server
RemoteEvent.OnServerEvent:Connect(function(player, data)
    -- Handle data from player
end)
```
]],
        
        ["ui_creation"] = [[
# UI Creation Tutorial

## Basic Button
```lua
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
button.Text = "Click Me"
button.Parent = screenGui

button.MouseButton1Click:Connect(function()
    print("Button clicked!")
end)
```

## Modern UI Components
Use the SpecializedModules.UIModule for pre-built components.
]]
    }
    
    return tutorials[feature] or "No tutorial available for this feature."
end

-- Get keyboard shortcuts
function HelpSystem:GetKeyboardShortcuts()
    return {
        ["Ctrl+Shift+G"] = "Generate Code",
        ["Ctrl+Shift+O"] = "Optimize Code",
        ["Ctrl+Shift+F"] = "Fix Bugs",
        ["Ctrl+Shift+E"] = "Explain Code",
        ["Ctrl+Shift+A"] = "Analyze Project",
        ["Ctrl+Shift+S"] = "Open Settings"
    }
end

-- Get FAQ
function HelpSystem:GetFAQ()
    return {
        {
            question = "Do I need an API key?",
            answer = "Yes, you need a Groq API key. Get one free at groq.com"
        },
        {
            question = "Is my code private?",
            answer = "Yes, your code is processed securely and not stored or shared."
        },
        {
            question = "Can I use this for commercial projects?",
            answer = "Yes, CodeAssist can be used for commercial Roblox projects."
        },
        {
            question = "How accurate is the generated code?",
            answer = "CodeAssist achieves high accuracy by being trained on comprehensive Roblox knowledge."
        },
        {
            question = "Does it work with all Roblox projects?",
            answer = "Yes, CodeAssist works with all types of Roblox projects."
        },
        {
            question = "Can I customize the AI behavior?",
            answer = "Yes, you can adjust AI parameters in the settings."
        }
    }
end

-- Get version info
function HelpSystem:GetVersionInfo()
    return {
        version = "1.0.0",
        releaseDate = "2024",
        apiVersion = "v1",
        supportedStudioVersions = "Roblox Studio 2024+"
    }
end

-- Get contact info
function HelpSystem:GetContactInfo()
    return {
        documentation = "https://docs.codeassist.dev",
        discord = "https://discord.gg/codeassist",
        github = "https://github.com/yourusername/CodeAssist",
        email = "support@codeassist.dev",
        twitter = "@CodeAssistDev"
    }
end

return HelpSystem
