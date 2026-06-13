# CodeAssist Installation Guide

## Installation Manuelle dans Roblox Studio

### Étape 1: Ouvrir Roblox Studio
1. Ouvrez Roblox Studio
2. Créez un nouveau place ou ouvrez un projet existant

### Étape 2: Créer le Plugin
1. Dans le menu **Plugins**, cliquez sur **Plugin Manager**
2. Cliquez sur le bouton **+** pour créer un nouveau plugin
3. Nommez-le "CodeAssist"

### Étape 3: Ajouter les fichiers ModuleScript
Dans le dossier du plugin créé, ajoutez ces ModuleScripts :

#### 1. CodeAssist.lua (Script principal)
```lua
--[[
    CodeAssist - Advanced AI Assistant for Roblox Developers
    Version: 1.0.0
]]

local Plugin = plugin
if not Plugin then
    error("CodeAssist must be run as a Roblox Studio plugin")
end

local HttpService = game:GetService("HttpService")
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

-- Create UI
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

-- Create UI elements
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CodeAssistWidget

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, 0, 1, 0)
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
InputLabel.TextSize = 14
InputLabel.Font = Enum.Font.Gotham
InputLabel.TextXAlignment = Enum.TextXAlignment.Left
InputLabel.Parent = ContentFrame

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, 0, 0, 100)
InputBox.Position = UDim2.new(0, 0, 0, 45)
InputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
InputBox.BorderSizePixel = 0
InputBox.Text = ""
InputBox.PlaceholderText = "e.g., Create a player health system..."
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

-- Action Buttons
local ActionButtonsFrame = Instance.new("Frame")
ActionButtonsFrame.Size = UDim2.new(1, 0, 0, 120)
ActionButtonsFrame.Position = UDim2.new(0, 0, 1, -125)
ActionButtonsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ActionButtonsFrame.BorderSizePixel = 0
ActionButtonsFrame.Parent = ContentFrame

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
local FullGameToolbar = Toolbar:CreateButton("Full Game", "Generate complete game with AI", "rbxassetid://0")

-- Load Advanced AI Module
local AdvancedAI = require(script.Parent.AdvancedAI)
AdvancedAI:LoadConfig()

-- AI Functions
local AIService = {}

function AIService:GenerateCode(prompt)
    return AdvancedAI:GenerateSystem("custom", prompt)
end

function AIService:GenerateFullGame(gameDescription, requirements)
    return AdvancedAI:GenerateFullGame(gameDescription, requirements)
end

-- Event Handlers
GenerateButton.MouseButton1Click:Connect(function()
    local userInput = InputBox.Text
    if userInput == "" or userInput == " " then
        OutputBox.Text = "Please enter a description of what you want to create."
        return
    end
    
    OutputBox.Text = "Generating code... Please wait."
    GenerateButton.Text = "Generating..."
    GenerateButton.Active = false
    
    local success, result = AIService:GenerateCode(userInput)
    
    if success then
        OutputBox.Text = result
    else
        OutputBox.Text = "Error: " .. (result or "Unknown error")
    end
    
    GenerateButton.Text = "Generate Code"
    GenerateButton.Active = true
end)

FullGameButton.MouseButton1Click:Connect(function()
    local gameDescription = InputBox.Text
    if gameDescription == "" or gameDescription == " " then
        OutputBox.Text = "Please describe the game you want to create."
        return
    end
    
    OutputBox.Text = "Generating complete game... This may take a while."
    FullGameButton.Text = "Generating..."
    FullGameButton.Active = false
    
    local requirements = "Production-ready, optimized for performance"
    local success, result = AIService:GenerateFullGame(gameDescription, requirements)
    
    if success then
        OutputBox.Text = result
    else
        OutputBox.Text = "Error: " .. (result or "Unknown error")
    end
    
    FullGameButton.Text = "Generate Full Game"
    FullGameButton.Active = true
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

GenerateButtonToolbar.Click:Connect(function()
    CodeAssistWidget.Enabled = not CodeAssistWidget.Enabled
end)

FullGameToolbar.Click:Connect(function()
    CodeAssistWidget.Enabled = true
    FullGameButton:Activate()
end)

print("CodeAssist Plugin Loaded Successfully!")
```

#### 2. AdvancedAI.lua (ModuleScript)
```lua
--[[
    CodeAssist Advanced AI Module
    Real AI-powered code generation using Groq API
]]

local HttpService = game:GetService("HttpService")

local AdvancedAI = {}

AdvancedAI.Config = {
    apiUrl = "https://api.groq.com/openai/v1/chat/completions",
    model = "llama-3.1-70b-versatile",
    temperature = 0.7,
    maxTokens = 8192,
    topP = 0.9,
    apiKey = "" -- Set your API key in plugin settings
}

function AdvancedAI:LoadConfig()
    local Plugin = plugin or getfenv().plugin
    if Plugin then
        local success, apiKey = pcall(function()
            return Plugin:GetSetting("CodeAssist_APIKey")
        end)
        if success and apiKey then
            self.Config.apiKey = apiKey
            return true
        end
    end
    return false
end

function AdvancedAI:BuildExpertSystemPrompt()
    return [[You are the world's foremost Roblox development expert with 15+ years of experience. Generate production-ready, optimized code for Roblox games.]]
end

function AdvancedAI:GenerateFullGame(gameDescription, requirements)
    local systemPrompt = self:BuildExpertSystemPrompt()
    local userPrompt = string.format("Generate a complete Roblox game: %s\nRequirements: %s", gameDescription, requirements or "Standard requirements")
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

function AdvancedAI:GenerateSystem(systemType, specifications)
    local systemPrompt = self:BuildExpertSystemPrompt()
    local userPrompt = string.format("Generate a %s system: %s", systemType, specifications or "Standard requirements")
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

function AdvancedAI:CallGroqAPI(systemPrompt, userPrompt)
    if not self.Config.apiKey then
        self:LoadConfig()
    end
    
    if not self.Config.apiKey then
        return nil, "API key not configured. Please set your Groq API key in plugin settings."
    end
    
    local requestBody = {
        model = self.Config.model,
        messages = {
            {role = "system", content = systemPrompt},
            {role = "user", content = userPrompt}
        },
        temperature = self.Config.temperature,
        max_tokens = self.Config.maxTokens,
        top_p = self.Config.topP
    }
    
    local success, response = pcall(function()
        return HttpService:RequestAsync({
            Url = self.Config.apiUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer " .. self.Config.apiKey
            },
            Body = HttpService:JSONEncode(requestBody)
        })
    end)
    
    if success and response.Success then
        local data = HttpService:JSONDecode(response.Body)
        if data.choices and data.choices[1] then
            return data.choices[1].message.content
        end
        return nil, "Invalid API response format"
    end
    
    return nil, "API request failed: " .. (response.Body or "Unknown error")
end

function AdvancedAI:SetAPIKey(apiKey)
    self.Config.apiKey = apiKey
    local Plugin = plugin or getfenv().plugin
    if Plugin then
        pcall(function()
            Plugin:SetSetting("CodeAssist_APIKey", apiKey)
        end)
    end
end

return AdvancedAI
```

### Étape 4: Configurer la clé API
1. Dans Roblox Studio, ouvrez la Command Bar (View → Command Bar)
2. Exécutez cette commande :
```lua
plugin:SetSetting("CodeAssist_APIKey", "votre_clé_api_ici")
```
3. Remplacez `votre_clé_api_ici` par votre clé API Groq

### Étape 5: Activer le Plugin
1. Dans Plugin Manager, activez le plugin CodeAssist
2. Le bouton "CodeAssist" apparaîtra dans la toolbar
3. Cliquez dessus pour ouvrir l'interface

### Étape 6: Utiliser le Plugin
1. Décrivez ce que vous voulez créer dans la zone de texte
2. Cliquez sur "Generate Code"
3. Copiez ou insérez le code généré

## Dépannage

### Plugin n'apparaît pas
- Vérifiez que le plugin est activé dans Plugin Manager
- Redémarrez Roblox Studio

### Erreur API key
- Assurez-vous d'avoir configuré votre clé API Groq
- Vérifiez que la clé est valide et a des crédits

### Code ne se génère pas
- Vérifiez votre connexion internet
- Assurez-vous que l'API Groq est accessible
- Consultez la console Output pour les messages d'erreur
