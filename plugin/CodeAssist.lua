--[[
    CodeAssist - Advanced AI Assistant for Roblox Developers
    Version: 1.0.0
    Author: CodeAssist Team
    
    This plugin provides AI-powered code generation, bug detection,
    optimization, and intelligent assistance for Roblox development.
]]

-- Plugin Information
local PluginName = "CodeAssist"
local PluginVersion = "1.0.0"

-- Services
local Plugin = plugin or getfenv().plugin
if not Plugin then
    error("CodeAssist must be run as a Roblox Studio plugin")
end

local HttpService = game:GetService("HttpService")
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")
local ScriptEditorService = game:GetService("ScriptEditorService")
local Players = game:GetService("Players")

-- Plugin UI Setup
local Toolbar = Plugin:CreateToolbar("CodeAssist")
local DockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Right,
    false,
    false,
    400,
    600,
    400,
    600
)

local CodeAssistWidget = Plugin:CreateDockWidgetPluginGui(
    "CodeAssistWidget",
    DockWidgetPluginGuiInfo
)

CodeAssistWidget.Title = "CodeAssist AI"
CodeAssistWidget.Name = "CodeAssistWidget"

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CodeAssistWidget

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.Position = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, -20, 1, 0)
HeaderText.Position = UDim2.new(0, 10, 0, 0)
HeaderText.BackgroundTransparency = 1
HeaderText.Text = "CodeAssist AI"
HeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderText.TextSize = 24
HeaderText.Font = Enum.Font.GothamBold
HeaderText.TextXAlignment = Enum.TextXAlignment.Left
HeaderText.Parent = Header

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -70)
ContentFrame.Position = UDim2.new(0, 10, 0, 65)
ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- Input Section
local InputLabel = Instance.new("TextLabel")
InputLabel.Size = UDim2.new(1, 0, 0, 30)
InputLabel.Position = UDim2.new(0, 0, 0, 10)
InputLabel.BackgroundTransparency = 1
InputLabel.Text = "Describe what you want to create:"
InputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
LabelTextSize = 14
InputLabel.Font = Enum.Font.Gotham
InputLabel.TextXAlignment = Enum.TextXAlignment.Left
InputLabel.Parent = ContentFrame

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, 0, 0, 100)
InputBox.Position = UDim2.new(0, 0, 0, 45)
InputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
InputBox.BorderSizePixel = 0
InputBox.Text = ""
InputBox.PlaceholderText = "e.g., Create a player health system with regeneration..."
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
InputBox.TextSize = 14
InputBox.Font = Enum.Font.Gotham
InputBox.TextXAlignment = Enum.TextXAlignment.Left
InputBox.TextYAlignment = Enum.TextYAlignment.Top
InputBox.ClearTextOnFocus = false
InputBox.MultiLine = true
InputBox.Parent = ContentFrame

local InputPadding = Instance.new("UIPadding")
InputPadding.PaddingTop = UDim.new(0, 10)
InputPadding.PaddingLeft = UDim.new(0, 10)
InputPadding.PaddingRight = UDim.new(0, 10)
InputPadding.Parent = InputBox

-- Generate Button
local GenerateButton = Instance.new("TextButton")
GenerateButton.Size = UDim2.new(1, 0, 0, 40)
GenerateButton.Position = UDim2.new(0, 0, 0, 155)
GenerateButton.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
GenerateButton.BorderSizePixel = 0
GenerateButton.Text = "Generate Code"
GenerateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GenerateButton.TextSize = 16
GenerateButton.Font = Enum.Font.GothamBold
GenerateButton.Parent = ContentFrame

local GenerateCorner = Instance.new("UICorner")
GenerateCorner.CornerRadius = UDim.new(0, 8)
GenerateCorner.Parent = GenerateButton

-- Output Section
local OutputLabel = Instance.new("TextLabel")
OutputLabel.Size = UDim2.new(1, 0, 0, 30)
OutputLabel.Position = UDim2.new(0, 0, 0, 205)
OutputLabel.BackgroundTransparency = 1
OutputLabel.Text = "Generated Code:"
OutputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
OutputLabel.TextSize = 14
OutputLabel.Font = Enum.Font.Gotham
OutputLabel.TextXAlignment = Enum.TextXAlignment.Left
OutputLabel.Parent = ContentFrame

local OutputBox = Instance.new("TextBox")
OutputBox.Size = UDim2.new(1, 0, 1, -250)
OutputBox.Position = UDim2.new(0, 0, 0, 240)
OutputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
OutputBox.BorderSizePixel = 0
OutputBox.Text = ""
OutputBox.TextColor3 = Color3.fromRGB(220, 220, 220)
OutputBox.TextSize = 13
OutputBox.Font = Enum.Font.Code
OutputBox.TextXAlignment = Enum.TextXAlignment.Left
OutputBox.TextYAlignment = Enum.TextYAlignment.Top
OutputBox.ClearTextOnFocus = false
OutputBox.MultiLine = true
OutputBox.Parent = ContentFrame

local OutputPadding = Instance.new("UIPadding")
OutputPadding.PaddingTop = UDim.new(0, 10)
OutputPadding.PaddingLeft = UDim.new(0, 10)
OutputPadding.PaddingRight = UDim.new(0, 10)
OutputPadding.Parent = OutputBox

-- Action Buttons Frame
local ActionButtonsFrame = Instance.new("Frame")
ActionButtonsFrame.Size = UDim2.new(1, 0, 0, 120)
ActionButtonsFrame.Position = UDim2.new(0, 0, 1, -125)
ActionButtonsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ActionButtonsFrame.BorderSizePixel = 0
ActionButtonsFrame.Parent = ContentFrame

-- Advanced AI Buttons
local FullGameButton = Instance.new("TextButton")
FullGameButton.Size = UDim2.new(1, -10, 0, 35)
FullGameButton.Position = UDim2.new(0, 5, 0, 5)
FullGameButton.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
FullGameButton.BorderSizePixel = 0
FullGameButton.Text = "Generate Full Game"
FullGameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FullGameButton.TextSize = 14
FullGameButton.Font = Enum.Font.GothamBold
FullGameButton.Parent = ActionButtonsFrame

local FullGameCorner = Instance.new("UICorner")
FullGameCorner.CornerRadius = UDim.new(0, 6)
FullGameCorner.Parent = FullGameButton

local ArchitectureButton = Instance.new("TextButton")
ArchitectureButton.Size = UDim2.new(0.48, -5, 0, 35)
ArchitectureButton.Position = UDim2.new(0, 5, 0, 45)
ArchitectureButton.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
ArchitectureButton.BorderSizePixel = 0
ArchitectureButton.Text = "Game Architecture"
ArchitectureButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ArchitectureButton.TextSize = 14
ArchitectureButton.Font = Enum.Font.Gotham
ArchitectureButton.Parent = ActionButtonsFrame

local ArchCorner = Instance.new("UICorner")
ArchCorner.CornerRadius = UDim.new(0, 6)
ArchCorner.Parent = ArchitectureButton

local MultiplayerButton = Instance.new("TextButton")
MultiplayerButton.Size = UDim2.new(0.48, -5, 0, 35)
MultiplayerButton.Position = UDim2.new(0.52, 5, 0, 45)
MultiplayerButton.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
MultiplayerButton.BorderSizePixel = 0
MultiplayerButton.Text = "Multiplayer System"
MultiplayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MultiplayerButton.TextSize = 14
MultiplayerButton.Font = Enum.Font.Gotham
MultiplayerButton.Parent = ActionButtonsFrame

local MultiCorner = Instance.new("UICorner")
MultiCorner.CornerRadius = UDim.new(0, 6)
MultiCorner.Parent = MultiplayerButton

local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(0.48, -5, 0, 30)
CopyButton.Position = UDim2.new(0, 5, 0, 85)
CopyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
CopyButton.BorderSizePixel = 0
CopyButton.Text = "Copy to Clipboard"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextSize = 13
CopyButton.Font = Enum.Font.Gotham
CopyButton.Parent = ActionButtonsFrame

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 6)
CopyCorner.Parent = CopyButton

local InsertButton = Instance.new("TextButton")
InsertButton.Size = UDim2.new(0.48, -5, 0, 30)
InsertButton.Position = UDim2.new(0.52, 5, 0, 85)
InsertButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
InsertButton.BorderSizePixel = 0
InsertButton.Text = "Insert to Script"
InsertButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InsertButton.TextSize = 13
InsertButton.Font = Enum.Font.Gotham
InsertButton.Parent = ActionButtonsFrame

local InsertCorner = Instance.new("UICorner")
InsertCorner.CornerRadius = UDim.new(0, 6)
InsertCorner.Parent = InsertButton

-- Toolbar Buttons
local GenerateButtonToolbar = Toolbar:CreateButton("Generate Code", "Generate AI code", "rbxassetid://0")
local OptimizeButton = Toolbar:CreateButton("Optimize Code", "Optimize selected code", "rbxassetid://0")
local FixBugsButton = Toolbar:CreateButton("Fix Bugs", "Fix bugs in selected code", "rbxassetid://0")
local ExplainButton = Toolbar:CreateButton("Explain Code", "Explain selected code", "rbxassetid://0")
local AnalyzeButton = Toolbar:CreateButton("Analyze Project", "Analyze entire project", "rbxassetid://0")
local FullGameToolbar = Toolbar:CreateButton("Full Game", "Generate complete game with AI", "rbxassetid://0")

-- AI Service Module
local AIService = {}

-- Load Advanced AI Module
local AdvancedAI = require(script.Parent.AdvancedAI)

-- Initialize Advanced AI
AdvancedAI:LoadConfig()

-- Load configuration
local function LoadConfig()
    local config = {
        apiKey = AdvancedAI.Config.apiKey or "",
        apiUrl = AdvancedAI.Config.apiUrl,
        model = AdvancedAI.Config.model,
        temperature = AdvancedAI.Config.temperature,
        maxTokens = AdvancedAI.Config.maxTokens,
        topP = AdvancedAI.Config.topP
    }
    return config
end

AIService.Config = LoadConfig()

-- Roblox Knowledge Base - Comprehensive
local RobloxKnowledgeBase = {
    -- API Services
    Services = {
        "Players", "ReplicatedStorage", "ServerStorage", "StarterPlayer", 
        "StarterGui", "StarterPack", "Lighting", "Workspace", "SoundService",
        "MarketplaceService", "DataStoreService", "MessagingService",
        "TeleportService", "BadgeService", "GamePassService", "LeaderboardService",
        "UserService", "GroupsService", "FriendsService", "AnalyticsService",
        "HttpService", "RunService", "TweenService", "ContextActionService",
        "UserInputService", "GuiService", "ProximityPromptService",
        "CollectionService", "PathfindingService", "NavigationService"
    },
    
    -- Common Patterns
    Patterns = {
        PlayerJoin = [[
local Players = game:GetService("Players")
local function onPlayerJoin(player)
    -- Your code here
end
Players.PlayerAdded:Connect(onPlayerJoin)
]],
        
        PlayerLeave = [[
local Players = game:GetService("Players")
local function onPlayerLeave(player)
    -- Your code here
end
Players.PlayerRemoving:Connect(onPlayerLeave)
]],
        
        RemoteEvent = [[
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "YourEventName"
RemoteEvent.Parent = ReplicatedStorage
]],
        
        RemoteFunction = [[
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFunction = Instance.new("RemoteFunction")
RemoteFunction.Name = "YourFunctionName"
RemoteFunction.Parent = ReplicatedStorage
]],
        
        DataStore = [[
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("YourDataStoreName")

local function SaveData(player, data)
    local success, err = pcall(function()
        DataStore:SetAsync("Player_" .. player.UserId, data)
    end)
    if not success then
        warn("Failed to save data: " .. err)
    end
end

local function LoadData(player)
    local success, data = pcall(function()
        return DataStore:GetAsync("Player_" .. player.UserId)
    end)
    if success and data then
        return data
    end
    return nil
end
]],
        
        Leaderstats = [[
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
]],
        
        TouchInterest = [[
local part = script.Parent
local debounce = false

part.Touched:Connect(function(hit)
    if debounce then return end
    debounce = true
    
    local character = hit.Parent
    local humanoid = character:FindFirstChild("Humanoid")
    
    if humanoid then
        -- Your code here
    end
    
    task.wait(0.5)
    debounce = false
end)
]],
        
        ClickDetector = [[
local clickDetector = script.Parent
local debounce = false

clickDetector.MouseClick:Connect(function(player)
    if debounce then return end
    debounce = true
    
    -- Your code here
    
    task.wait(0.5)
    debounce = false
end)
]],
        
        ProximityPrompt = [[
local prompt = script.Parent

prompt.Triggered:Connect(function(player)
    -- Your code here
end)
]]
    },
    
    -- Best Practices
    BestPractices = {
        "Always use pcall for DataStore operations",
        "Use WaitForChild when accessing instances that might not exist yet",
        "Implement debounce for event handlers to prevent spam",
        "Use proper variable naming conventions (camelCase for local, PascalCase for instances)",
        "Add comments to complex logic",
        "Use module scripts for reusable code",
        "Implement proper error handling",
        "Use CollectionService for tagging and finding instances",
        "Optimize by using client-side replication where possible",
        "Use RemoteEvents/RemoteFunctions for server-client communication"
    },
    
    -- Common APIs
    CommonAPIs = {
        Instance = {
            "Destroy()", "Clone()", "GetChildren()", "GetDescendants()", 
            "FindFirstChild()", "WaitForChild()", "IsA()", "GetFullName()"
        },
        Humanoid = {
            "Health", "MaxHealth", "WalkSpeed", "JumpPower", "TakeDamage()", 
            "Heal()", "MoveTo()", "ChangeState()"
        },
        Player = {
            "UserId", "Name", "DisplayName", "Character", "Team", "LoadCharacter()",
            "Kick()", "GetRankInGroup()", "IsInGroup()"
        },
        Vector3 = {
            "Magnitude", "Unit", "FuzzyEq()", "lerp()", "FromAxis()"
        },
        CFrame = {
            "Position", "LookVector", "UpVector", "RightVector", "Angles()",
            "fromEulerAngles()", "fromMatrix()", "lerp()"
        },
        TweenService = {
            "Create()", "TweenInfo.new()"
        },
        RunService = {
            "Heartbeat", "RenderStepped", "Stepped", "IsClient()", "IsServer()",
            "IsStudio()", "BindToRenderStep()"
        }
    },
    
    -- Game Systems
    GameSystems = {
        HealthSystem = [[
-- Player Health System with Regeneration
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local HEALTH_REGEN_RATE = 1 -- Health per second
local MAX_HEALTH = 100

local function setupHealthSystem(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.MaxHealth = MAX_HEALTH
    humanoid.Health = MAX_HEALTH
    
    local function onHealthChanged()
        if humanoid.Health <= 0 then
            -- Player died
        end
    end
    
    humanoid.HealthChanged:Connect(onHealthChanged)
    
    -- Regeneration
    local connection
    connection = RunService.Heartbeat:Connect(function(deltaTime)
        if humanoid.Health < MAX_HEALTH and humanoid.Health > 0 then
            humanoid.Health = math.min(humanoid.Health + HEALTH_REGEN_RATE * deltaTime, MAX_HEALTH)
        end
    end)
    
    player.CharacterRemoving:Connect(function()
        connection:Disconnect()
    end)
end

Players.PlayerAdded:Connect(setupHealthSystem)
]],
        
        InventorySystem = [[
-- Simple Inventory System
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InventoryEvent = Instance.new("RemoteEvent")
InventoryEvent.Name = "InventoryEvent"
InventoryEvent.Parent = ReplicatedStorage

local inventories = {}

local function createInventory(player)
    inventories[player.UserId] = {
        items = {},
        maxSlots = 20
    }
end

local function addItem(player, item, amount)
    local inventory = inventories[player.UserId]
    if not inventory then return false end
    
    if #inventory.items < inventory.maxSlots then
        table.insert(inventory.items, {name = item, amount = amount})
        return true
    end
    return false
end

local function removeItem(player, item, amount)
    local inventory = inventories[player.UserId]
    if not inventory then return false end
    
    for i, invItem in ipairs(inventory.items) do
        if invItem.name == item and invItem.amount >= amount then
            invItem.amount = invItem.amount - amount
            if invItem.amount <= 0 then
                table.remove(inventory.items, i)
            end
            return true
        end
    end
    return false
end

Players.PlayerAdded:Connect(createInventory)
Players.PlayerRemoving:Connect(function(player)
    inventories[player.UserId] = nil
end)
]],
        
        ShopSystem = [[
-- Shop System with Currency
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local ShopEvent = Instance.new("RemoteEvent")
ShopEvent.Name = "ShopEvent"
ShopEvent.Parent = ReplicatedStorage

local shopItems = {
    {name = "Sword", price = 100, productId = 0},
    {name = "Shield", price = 150, productId = 0},
    {name = "Potion", price = 50, productId = 0}
}

local function processPurchase(player, itemName)
    local playerStats = player:FindFirstChild("leaderstats")
    if not playerStats then return false end
    
    local coins = playerStats:FindFirstChild("Coins")
    if not coins then return false end
    
    for _, item in ipairs(shopItems) do
        if item.name == itemName then
            if coins.Value >= item.price then
                coins.Value -= item.price
                -- Give item to player
                return true
            end
        end
    end
    return false
end

ShopEvent.OnServerEvent:Connect(processPurchase)
]],
        
        TeleportSystem = [[
-- Teleport System
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local TELEPORT_LOCATIONS = {
    {name = "Lobby", placeId = 1234567890},
    {name = "Game", placeId = 1234567891}
}

local function teleportPlayer(player, locationName)
    for _, location in ipairs(TELEPORT_LOCATIONS) do
        if location.name == locationName then
            TeleportService:Teleport(location.placeId, player)
            return true
        end
    end
    return false
end
]],
        
        LeaderboardSystem = [[
-- Advanced Leaderboard System
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local LeaderboardStore = DataStoreService:GetDataStore("Leaderboard")

local leaderboards = {
    {name = "Coins", type = "IntValue"},
    {name = "Kills", type = "IntValue"},
    {name = "Wins", type = "IntValue"},
    {name = "Level", type = "IntValue"}
}

local function setupLeaderstats(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
    
    for _, stat in ipairs(leaderboards) do
        local value = Instance.new(stat.type)
        value.Name = stat.name
        value.Value = 0
        value.Parent = leaderstats
    end
    
    -- Load saved data
    local success, data = pcall(function()
        return LeaderboardStore:GetAsync("Player_" .. player.UserId)
    end)
    
    if success and data then
        for statName, statValue in pairs(data) do
            local stat = leaderstats:FindFirstChild(statName)
            if stat then
                stat.Value = statValue
            end
        end
    end
end

local function saveLeaderstats(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end
    
    local data = {}
    for _, stat in ipairs(leaderboards) do
        local value = leaderstats:FindFirstChild(stat.name)
        if value then
            data[stat.name] = value.Value
        end
    end
    
    pcall(function()
        LeaderboardStore:SetAsync("Player_" .. player.UserId, data)
    end)
end

Players.PlayerAdded:Connect(setupLeaderstats)
Players.PlayerRemoving:Connect(saveLeaderstats)

-- Auto-save every 60 seconds
task.spawn(function()
    while true do
        task.wait(60)
        for _, player in ipairs(Players:GetPlayers()) do
            saveLeaderstats(player)
        end
    end
end)
]]
    },
    
    -- UI Components
    UIComponents = {
        Button = [[
local button = script.Parent
button.MouseButton1Click:Connect(function()
    -- Your code here
end)
]],
        
        TextLabel = [[
local textLabel = script.Parent
textLabel.Text = "Your Text"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.BackgroundTransparency = 1
]],
        
        Frame = [[
local frame = script.Parent
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame
]],
        
        ScrollingFrame = [[
local scrollingFrame = script.Parent
scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
]],
        
        InputField = [[
local inputField = script.Parent
inputField.ClearTextOnFocus = false
inputField.PlaceholderText = "Enter text..."
inputField.Text = ""
inputField.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        -- Handle input
    end
end)
]]
    },
    
    -- Forum Knowledge (Common Questions and Solutions)
    ForumKnowledge = {
        Performance = {
            "Use object pooling for frequently created/destroyed objects",
            "Avoid using WaitForChild in tight loops",
            "Use CollectionService for efficient instance management",
            "Minimize the number of RemoteEvents/RemoteFunctions",
            "Use client-side validation to reduce server load",
            "Optimize UI by using efficient layouts",
            "Use StreamingEnabled for large maps",
            "Avoid excessive use of Touched events"
        },
        
        Security = {
            "Never trust client input - always validate on server",
            "Use RemoteFunctions for sensitive operations",
            "Implement proper access checks",
            "Sanitize all user input",
            "Use server-side checks for game logic",
            "Never store sensitive data in client scripts",
            "Use FilteringEnabled for security",
            "Implement proper anti-cheat measures"
        },
        
        DataStorage = {
            "Use DataStoreService for persistent data",
            "Always wrap DataStore calls in pcall",
            "Implement proper data backup strategies",
            "Use session locking for concurrent access",
            "Consider data size limits (4MB per key)",
            "Use proper key naming conventions",
            "Implement data migration strategies",
            "Cache frequently accessed data"
        },
        
        Monetization = {
            "Use MarketplaceService for game passes",
            "Implement proper purchase validation",
            "Use Developer Products for consumables",
            "Consider subscription models",
            "Implement proper receipt processing",
            "Use analytics to track purchases",
            "Consider regional pricing",
            "Implement proper refund handling"
        }
    },
    
    -- Build Knowledge
    BuildKnowledge = {
        Terrain = {
            "Use terrain tools for natural landscapes",
            "Consider performance when using complex terrain",
            "Use materials appropriately for gameplay",
            "Optimize terrain collision",
            "Use terrain regions for large maps"
        },
        
        Parts = {
            "Use MeshParts for complex geometry",
            "Consider using Union/Negate for custom shapes",
            "Optimize by using fewer parts where possible",
            "Use proper anchoring for static objects",
            "Consider using CanCollide appropriately"
        },
        
        Lighting = {
            "Use proper lighting for atmosphere",
            "Consider performance impact of lighting",
            "Use light objects strategically",
            "Consider using shadows sparingly",
            "Use proper color grading"
        },
        
        Audio = {
            "Use SoundService for audio management",
            "Consider audio compression",
            "Use 3D sound for spatial audio",
            "Implement proper audio ducking",
            "Use sound groups for organization"
        }
    },
    
    -- API Reference
    APIReference = {
        Events = {
            "PlayerAdded", "PlayerRemoving", "CharacterAdded", "CharacterRemoving",
            "Touched", "MouseClick", "Triggered", "Changed", "ChildAdded", "ChildRemoved"
        },
        Functions = {
            "GetService", "WaitForChild", "FindFirstChild", "Destroy", "Clone",
            "GetChildren", "GetDescendants", "IsA", "GetFullName"
        },
        Properties = {
            "Name", "Parent", "Position", "Size", "Anchored", "CanCollide",
            "BrickColor", "Transparency", "Reflectance", "Archivable"
        }
    }
}

-- AI Prompt Engineering
local function BuildSystemPrompt()
    local prompt = [[You are CodeAssist, an expert Roblox developer AI assistant with comprehensive knowledge of the entire Roblox platform. You have deep understanding of:

ROBLOX SERVICES & APIs:
- All Roblox services (Players, ReplicatedStorage, DataStoreService, HttpService, etc.)
- Complete API reference for all classes, methods, properties, and events
- Best practices for each service and common patterns
- Performance optimization techniques for each service

ROBLOX SCRIPTING PATTERNS:
- Common scripting patterns and templates
- Event handling best practices
- Data structure patterns
- Communication patterns (RemoteEvents, RemoteFunctions)
- Module script organization

ROBLOX GAME SYSTEMS:
- Player management systems
- Data storage and persistence
- Inventory and item systems
- Shop and monetization systems
- Leaderboard and stat systems
- Teleportation systems
- Health and damage systems
- Combat systems
- Vehicle systems
- Building and crafting systems

ROBLOX UI DEVELOPMENT:
- All UI components (Frames, TextLabels, Buttons, etc.)
- UI layout systems (GridLayout, TableLayout, etc.)
- Responsive UI design
- UI animations and effects
- ScreenGui and PlayerGui management

ROBLOX BUILDING:
- Part and mesh optimization
- Terrain creation and manipulation
- Lighting and atmosphere
- Audio implementation
- Collision and physics

ROBLOX FORUM KNOWLEDGE:
- Common problems and solutions from the DevForum
- Performance optimization techniques
- Security best practices
- Data storage strategies
- Monetization strategies
- Anti-cheat methods

ROBLOX BEST PRACTICES:
- Code organization and structure
- Performance optimization
- Security considerations
- Error handling
- Documentation standards
- Testing methodologies

When generating code:
1. Always use proper Roblox Lua syntax
2. Include comments explaining complex logic
3. Use appropriate services and APIs
4. Follow Roblox naming conventions
5. Implement proper error handling with pcall
6. Consider performance implications
7. Use WaitForChild when accessing instances that might not exist
8. Implement debounce for event handlers
9. Use proper variable scoping
10. Follow security best practices

Always provide production-ready, optimized code that follows Roblox best practices. Explain your reasoning when helpful.
]]
    return prompt
end

-- AI Functions - Now using AdvancedAI module
function AIService:GenerateCode(prompt, context)
    -- Use AdvancedAI for real AI generation
    local fullPrompt = prompt
    if context then
        fullPrompt = fullPrompt .. "\n\nPROJECT CONTEXT:\n" .. context
    end
    
    return AdvancedAI:GenerateSystem("custom", fullPrompt)
end

function AIService:GenerateFullGame(gameDescription, requirements)
    return AdvancedAI:GenerateFullGame(gameDescription, requirements)
end

function AIService:GenerateGameArchitecture(gameConcept)
    return AdvancedAI:GenerateGameArchitecture(gameConcept)
end

function AIService:OptimizeCode(code)
    return AdvancedAI:ReviewAndImproveCode(code, "performance optimization")
end

function AIService:FixBugs(code)
    return AdvancedAI:ReviewAndImproveCode(code, "bug fixing and error handling")
end

function AIService:ExplainCode(code)
    local systemPrompt = AdvancedAI:BuildExpertSystemPrompt()
    local userPrompt = "Explain this Roblox Lua code in detail:\n\n" .. code
    
    return AdvancedAI:CallGroqAPI(systemPrompt, userPrompt)
end

function AIService:AnalyzeProject(projectStructure)
    return AdvancedAI:GenerateSystem("project analysis", projectStructure)
end

function AIService:GenerateMultiplayer(playerCount, gameType)
    return AdvancedAI:GenerateMultiplayerArchitecture(playerCount, gameType)
end

function AIService:GenerateMonetization(monetizationType, targetRevenue)
    return AdvancedAI:GenerateMonetizationSystem(monetizationType, targetRevenue)
end

-- Context Analysis
local function AnalyzeProjectContext()
    local context = "Current Project Structure:\n"
    
    -- Analyze workspace
    for _, child in ipairs(game.Workspace:GetChildren()) do
        context = context .. "- " .. child:GetFullName() .. " (" .. child.ClassName .. ")\n"
    end
    
    -- Analyze scripts
    local scripts = {}
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            table.insert(scripts, obj:GetFullName())
        end
    end
    
    if #scripts > 0 then
        context = context .. "\nScripts found:\n"
        for _, scriptPath in ipairs(scripts) do
            context = context .. "- " .. scriptPath .. "\n"
        end
    end
    
    return context
end

-- UI Event Handlers
GenerateButton.MouseButton1Click:Connect(function()
    local userInput = InputBox.Text
    if userInput == "" or userInput == " " then
        OutputBox.Text = "Please enter a description of what you want to create."
        return
    end
    
    OutputBox.Text = "Generating code... Please wait."
    GenerateButton.Text = "Generating..."
    GenerateButton.Active = false
    
    local context = AnalyzeProjectContext()
    local success, result = AIService:GenerateCode(userInput, context)
    
    if success then
        OutputBox.Text = result
    else
        OutputBox.Text = "Error: " .. (result or "Unknown error")
    end
    
    GenerateButton.Text = "Generate Code"
    GenerateButton.Active = true
end)

CopyButton.MouseButton1Click:Connect(function()
    if OutputBox.Text ~= "" then
        HttpService:ClipboardSet(OutputBox.Text)
        CopyButton.Text = "Copied!"
        task.wait(1)
        CopyButton.Text = "Copy to Clipboard"
    end
end)

InsertButton.MouseButton1Click:Connect(function()
    local selected = Selection:Get()
    if #selected > 0 then
        local selectedObject = selected[1]
        if selectedObject:IsA("Script") or selectedObject:IsA("LocalScript") or selectedObject:IsA("ModuleScript") then
            -- Insert code into script
            ChangeHistoryService:SetWaypoint("Before CodeAssist Insert")
            selectedObject.Source = selectedObject.Source .. "\n\n" .. OutputBox.Text
            ChangeHistoryService:SetWaypoint("After CodeAssist Insert")
            InsertButton.Text = "Inserted!"
            task.wait(1)
            InsertButton.Text = "Insert to Script"
        else
            warn("Selected object is not a script")
        end
    else
        warn("No object selected")
    end
end)

-- Advanced AI Button Handlers
FullGameButton.MouseButton1Click:Connect(function()
    local gameDescription = InputBox.Text
    if gameDescription == "" or gameDescription == " " then
        OutputBox.Text = "Please describe the game you want to create."
        return
    end
    
    OutputBox.Text = "Generating complete game... This may take a while."
    FullGameButton.Text = "Generating..."
    FullGameButton.Active = false
    
    local requirements = "Production-ready, optimized for performance, includes multiplayer support, monetization systems, and complete UI"
    local success, result = AIService:GenerateFullGame(gameDescription, requirements)
    
    if success then
        OutputBox.Text = result
    else
        OutputBox.Text = "Error: " .. (result or "Unknown error")
    end
    
    FullGameButton.Text = "Generate Full Game"
    FullGameButton.Active = true
end)

ArchitectureButton.MouseButton1Click:Connect(function()
    local gameConcept = InputBox.Text
    if gameConcept == "" or gameConcept == " " then
        OutputBox.Text = "Please describe your game concept for architecture design."
        return
    end
    
    OutputBox.Text = "Designing game architecture..."
    ArchitectureButton.Text = "Designing..."
    ArchitectureButton.Active = false
    
    local success, result = AIService:GenerateGameArchitecture(gameConcept)
    
    if success then
        OutputBox.Text = result
    else
        OutputBox.Text = "Error: " .. (result or "Unknown error")
    end
    
    ArchitectureButton.Text = "Game Architecture"
    ArchitectureButton.Active = true
end)

MultiplayerButton.MouseButton1Click:Connect(function()
    local gameType = InputBox.Text
    if gameType == "" or gameType == " " then
        OutputBox.Text = "Please describe your game type for multiplayer architecture."
        return
    end
    
    OutputBox.Text = "Generating multiplayer system..."
    MultiplayerButton.Text = "Generating..."
    MultiplayerButton.Active = false
    
    local playerCount = "1000+ concurrent players"
    local success, result = AIService:GenerateMultiplayer(playerCount, gameType)
    
    if success then
        OutputBox.Text = result
    else
        OutputBox.Text = "Error: " .. (result or "Unknown error")
    end
    
    MultiplayerButton.Text = "Multiplayer System"
    MultiplayerButton.Active = true
end)

-- Toolbar Button Handlers
GenerateButtonToolbar.Click:Connect(function()
    CodeAssistWidget.Enabled = not CodeAssistWidget.Enabled
end)

OptimizeButton.Click:Connect(function()
    local selected = Selection:Get()
    if #selected > 0 then
        local selectedObject = selected[1]
        if selectedObject:IsA("Script") or selectedObject:IsA("LocalScript") or selectedObject:IsA("ModuleScript") then
            local code = selectedObject.Source
            OutputBox.Text = "Optimizing code..."
            local success, result = AIService:OptimizeCode(code)
            if success then
                OutputBox.Text = result
            else
                OutputBox.Text = "Error: " .. (result or "Unknown error")
            end
            CodeAssistWidget.Enabled = true
        end
    end
end)

FixBugsButton.Click:Connect(function()
    local selected = Selection:Get()
    if #selected > 0 then
        local selectedObject = selected[1]
        if selectedObject:IsA("Script") or selectedObject:IsA("LocalScript") or selectedObject:IsA("ModuleScript") then
            local code = selectedObject.Source
            OutputBox.Text = "Fixing bugs..."
            local success, result = AIService:FixBugs(code)
            if success then
                OutputBox.Text = result
            else
                OutputBox.Text = "Error: " .. (result or "Unknown error")
            end
            CodeAssistWidget.Enabled = true
        end
    end
end)

ExplainButton.Click:Connect(function()
    local selected = Selection:Get()
    if #selected > 0 then
        local selectedObject = selected[1]
        if selectedObject:IsA("Script") or selectedObject:IsA("LocalScript") or selectedObject:IsA("ModuleScript") then
            local code = selectedObject.Source
            OutputBox.Text = "Explaining code..."
            local success, result = AIService:ExplainCode(code)
            if success then
                OutputBox.Text = result
            else
                OutputBox.Text = "Error: " .. (result or "Unknown error")
            end
            CodeAssistWidget.Enabled = true
        end
    end
end)

AnalyzeButton.Click:Connect(function()
    local context = AnalyzeProjectContext()
    OutputBox.Text = "Analyzing project..."
    local success, result = AIService:AnalyzeProject(context)
    if success then
        OutputBox.Text = result
    else
        OutputBox.Text = "Error: " .. (result or "Unknown error")
    end
    CodeAssistWidget.Enabled = true
end)

FullGameToolbar.Click:Connect(function()
    CodeAssistWidget.Enabled = true
    FullGameButton:Activate()
end)

-- Plugin Cleanup
Plugin.Unloading:Connect(function()
    -- Cleanup code here
end)

print("CodeAssist Plugin Loaded Successfully!")
print("Version: " .. PluginVersion)
