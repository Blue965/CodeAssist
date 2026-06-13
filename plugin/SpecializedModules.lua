--[[
    CodeAssist Specialized Modules
    Specialized AI modules for UI, Audio, Physics, and other Roblox systems
]]

local SpecializedModules = {}

-- UI Development Module
SpecializedModules.UIModule = {
    -- UI Components Library
    Components = {
        ModernButton = [[
local button = script.Parent
local TweenService = game:GetService("TweenService")

-- Button styling
button.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
button.Size = UDim2.new(0, 200, 0, 50)
button.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = button

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 12)
padding.PaddingBottom = UDim.new(0, 12)
padding.PaddingLeft = UDim.new(0, 24)
padding.PaddingRight = UDim.new(0, 24)
padding.Parent = button

local textLabel = button:FindFirstChild("TextLabel") or Instance.new("TextLabel")
textLabel.Name = "TextLabel"
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Button"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 18
textLabel.Font = Enum.Font.GothamBold
textLabel.Parent = button

-- Hover effects
local hoverTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local hoverColor = Color3.fromRGB(0, 130, 255)
local normalColor = Color3.fromRGB(0, 102, 255)

button.MouseEnter:Connect(function()
    TweenService:Create(button, hoverTweenInfo, {BackgroundColor3 = hoverColor}):Play()
end)

button.MouseLeave:Connect(function()
    TweenService:Create(button, hoverTweenInfo, {BackgroundColor3 = normalColor}):Play()
end)

-- Click effect
button.MouseButton1Click:Connect(function()
    local clickTween = TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, 190, 0, 45)})
    clickTween:Play()
    clickTween.Completed:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, 200, 0, 50)}):Play()
    end)
end)
]],

        ModernCard = [[
local card = script.Parent
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 16)
UIListLayout.Parent = card

-- Card styling
card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
card.Size = UDim2.new(1, 0, 0, 200)
card.BorderSizePixel = 0

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 12)
cardCorner.Parent = card

local cardStroke = Instance.new("UIStroke")
cardStroke.Color = Color3.fromRGB(200, 200, 200)
cardStroke.Thickness = 1
cardStroke.Parent = card

local cardShadow = Instance.new("UIStroke")
cardShadow.Color = Color3.fromRGB(0, 0, 0)
cardStroke.Transparency = 0.9
cardStroke.Thickness = 4
cardStroke.Parent = card

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 20)
padding.PaddingBottom = UDim.new(0, 20)
padding.PaddingLeft = UDim.new(0, 20)
padding.PaddingRight = UDim.new(0, 20)
padding.Parent = card
]],

        ProgressBar = [[
local progressBar = script.Parent

-- Background
progressBar.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
progressBar.Size = UDim2.new(1, 0, 0, 20)
progressBar.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = progressBar

-- Progress fill
local progressFill = Instance.new("Frame")
progressFill.Name = "ProgressFill"
progressFill.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBar

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 10)
fillCorner.Parent = progressFill

-- Progress text
local progressText = Instance.new("TextLabel")
progressText.Name = "ProgressText"
progressText.Size = UDim2.new(1, 0, 1, 0)
progressText.BackgroundTransparency = 1
progressText.Text = "0%"
progressText.TextColor3 = Color3.fromRGB(255, 255, 255)
progressText.TextSize = 12
progressText.Font = Enum.Font.GothamBold
progressText.TextXAlignment = Enum.TextXAlignment.Center
progressText.TextYAlignment = Enum.TextYAlignment.Center
progressText.Parent = progressFill

-- Update function
local function setProgress(value)
    value = math.clamp(value, 0, 100)
    progressFill.Size = UDim2.new(value / 100, 0, 1, 0)
    progressText.Text = tostring(math.floor(value)) .. "%"
end

-- Example usage
for i = 0, 100 do
    setProgress(i)
    task.wait(0.05)
end
]],

        DropdownMenu = [[
local dropdown = script.Parent
local TweenService = game:GetService("TweenService")

-- Main button
local mainButton = Instance.new("TextButton")
mainButton.Name = "MainButton"
mainButton.Size = UDim2.new(1, 0, 0, 40)
mainButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainButton.BorderSizePixel = 0
mainButton.Text = "Select Option"
mainButton.TextColor3 = Color3.fromRGB(0, 0, 0)
mainButton.TextSize = 16
mainButton.Font = Enum.Font.Gotham
mainButton.Parent = dropdown

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = mainButton

local buttonPadding = Instance.new("UIPadding")
buttonPadding.PaddingLeft = UDim.new(0, 16)
buttonPadding.PaddingRight = UDim.new(0, 16)
buttonPadding.Parent = mainButton

-- Arrow icon
local arrow = Instance.new("TextLabel")
arrow.Name = "Arrow"
arrow.Size = UDim2.new(0, 20, 0, 20)
arrow.Position = UDim2.new(1, -36, 0.5, -10)
arrow.BackgroundTransparency = 1
arrow.Text = "▼"
arrow.TextColor3 = Color3.fromRGB(100, 100, 100)
arrow.TextSize = 12
arrow.Font = Enum.Font.Gotham
arrow.Parent = mainButton

-- Options container
local optionsContainer = Instance.new("Frame")
optionsContainer.Name = "OptionsContainer"
optionsContainer.Size = UDim2.new(1, 0, 0, 0)
optionsContainer.Position = UDim2.new(0, 0, 1, 8)
optionsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
optionsContainer.BorderSizePixel = 0
optionsContainer.Visible = false
optionsContainer.Parent = dropdown

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 8)
containerCorner.Parent = optionsContainer

local containerStroke = Instance.new("UIStroke")
containerStroke.Color = Color3.fromRGB(200, 200, 200)
containerStroke.Thickness = 1
containerStroke.Parent = optionsContainer

local optionsList = Instance.new("UIListLayout")
optionsList.SortOrder = Enum.SortOrder.LayoutOrder
optionsList.Padding = UDim.new(0, 0)
optionsList.Parent = optionsContainer

-- Options
local options = {"Option 1", "Option 2", "Option 3", "Option 4"}

for i, option in ipairs(options) do
    local optionButton = Instance.new("TextButton")
    optionButton.Name = "Option" .. i
    optionButton.Size = UDim2.new(1, 0, 0, 40)
    optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionButton.BorderSizePixel = 0
    optionButton.Text = option
    optionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    optionButton.TextSize = 14
    optionButton.Font = Enum.Font.Gotham
    optionButton.LayoutOrder = i
    optionButton.Parent = optionsContainer
    
    local optionPadding = Instance.new("UIPadding")
    optionPadding.PaddingLeft = UDim.new(0, 16)
    optionPadding.PaddingRight = UDim.new(0, 16)
    optionPadding.Parent = optionButton
    
    optionButton.MouseButton1Click:Connect(function()
        mainButton.Text = option
        ToggleDropdown()
    end)
    
    optionButton.MouseEnter:Connect(function()
        optionButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    end)
    
    optionButton.MouseLeave:Connect(function()
        optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

-- Toggle function
local isOpen = false
local function ToggleDropdown()
    isOpen = not isOpen
    optionsContainer.Visible = isOpen
    
    if isOpen then
        optionsContainer.Size = UDim2.new(1, 0, 0, #options * 40)
        arrow.Text = "▲"
    else
        optionsContainer.Size = UDim2.new(1, 0, 0, 0)
        arrow.Text = "▼"
    end
end

mainButton.MouseButton1Click:Connect(ToggleDropdown)
]],

        TabSystem = [[
local tabSystem = script.Parent
local TweenService = game:GetService("TweenService")

-- Tab buttons container
local tabButtons = Instance.new("Frame")
tabButtons.Name = "TabButtons"
tabButtons.Size = UDim2.new(1, 0, 0, 50)
tabButtons.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
tabButtons.BorderSizePixel = 0
tabButtons.Parent = tabSystem

local buttonsLayout = Instance.new("UIListLayout")
buttonsLayout.FillDirection = Enum.FillDirection.Horizontal
buttonsLayout.Padding = UDim.new(0, 0)
buttonsLayout.Parent = tabButtons

local buttonsPadding = Instance.new("UIPadding")
buttonsPadding.PaddingLeft = UDim.new(0, 8)
buttonsPadding.Parent = tabButtons

-- Content container
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, -50)
contentContainer.Position = UDim2.new(0, 0, 0, 50)
contentContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
contentContainer.BorderSizePixel = 0
contentContainer.Parent = tabSystem

-- Tabs data
local tabs = {
    {name = "Home", content = "Home Content"},
    {name = "Profile", content = "Profile Content"},
    {name = "Settings", content = "Settings Content"},
    {name = "About", content = "About Content"}
}

local activeTab = nil

-- Create tabs
for i, tabData in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Name = "Tab" .. i
    tabButton.Size = UDim2.new(0, 120, 1, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    tabButton.BorderSizePixel = 0
    tabButton.Text = tabData.name
    tabButton.TextColor3 = Color3.fromRGB(100, 100, 100)
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.Gotham
    tabButton.Parent = tabButtons
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingLeft = UDim.new(0, 16)
    tabPadding.PaddingRight = UDim.new(0, 16)
    tabPadding.Parent = tabButton
    
    -- Create content
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content" .. i
    contentFrame.Size = UDim2.new(1, 0, 1, 0)
    contentFrame.Position = UDim2.new(0, 0, 0, 0)
    contentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    contentFrame.BorderSizePixel = 0
    contentFrame.Visible = false
    contentFrame.Parent = contentContainer
    
    local contentText = Instance.new("TextLabel")
    contentText.Size = UDim2.new(1, 0, 1, 0)
    contentText.BackgroundTransparency = 1
    contentText.Text = tabData.content
    contentText.TextColor3 = Color3.fromRGB(0, 0, 0)
    contentText.TextSize = 24
    contentText.Font = Enum.Font.GothamBold
    contentText.Parent = contentFrame
    
    -- Tab click handler
    tabButton.MouseButton1Click:Connect(function()
        -- Deactivate previous tab
        if activeTab then
            activeTab.Button.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            activeTab.Button.TextColor3 = Color3.fromRGB(100, 100, 100)
            activeTab.Content.Visible = false
        end
        
        -- Activate new tab
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextColor3 = Color3.fromRGB(0, 102, 255)
        contentFrame.Visible = true
        
        activeTab = {Button = tabButton, Content = contentFrame}
    end)
    
    -- Activate first tab
    if i == 1 then
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextColor3 = Color3.fromRGB(0, 102, 255)
        contentFrame.Visible = true
        activeTab = {Button = tabButton, Content = contentFrame}
    end
end
]]
    },
    
    -- UI Best Practices
    BestPractices = {
        "Use UDim2 for responsive sizing",
        "Implement proper scaling for different screen sizes",
        "Use UI constraints (UIPadding, UIScale, UIAspectRatio)",
        "Optimize UI by removing unused elements",
        "Use efficient animations with TweenService",
        "Implement proper z-indexing with GUI order",
        "Use ScreenGui for player-specific UI",
        "Use BillboardGui for world-space UI",
        "Consider mobile touch targets (minimum 44x44 pixels)",
        "Use proper font families and sizes for readability"
    }
}

-- Audio Development Module
SpecializedModules.AudioModule = {
    -- Audio Components
    Components = {
        SoundManager = [[
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")

local SoundManager = {}

-- Sound groups for organization
local MasterGroup = Instance.new("SoundGroup")
MasterGroup.Name = "MasterGroup"
MasterGroup.Parent = SoundService

local MusicGroup = Instance.new("SoundGroup")
MusicGroup.Name = "MusicGroup"
MusicGroup.Parent = MasterGroup

local SFXGroup = Instance.new("SoundGroup")
SFXGroup.Name = "SFXGroup"
SFXGroup.Parent = MasterGroup

local VoiceGroup = Instance.new("SoundGroup")
VoiceGroup.Name = "VoiceGroup"
VoiceGroup.Parent = MasterGroup

-- Volume controls
local function setMasterVolume(volume)
    MasterGroup.Volume = math.clamp(volume, 0, 1)
end

local function setMusicVolume(volume)
    MusicGroup.Volume = math.clamp(volume, 0, 1)
end

local function setSFXVolume(volume)
    SFXGroup.Volume = math.clamp(volume, 0, 1)
end

local function setVoiceVolume(volume)
    VoiceGroup.Volume = math.clamp(volume, 0, 1)
end

-- Play sound function
local function playSound(soundId, group, volume, pitch)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume or 1
    sound.Pitch = pitch or 1
    sound.RollOffMaxDistance = 100
    sound.RollOffMinDistance = 10
    sound.RollOffMode = Enum.RollOffMode.Linear
    
    if group == "music" then
        sound.Parent = MusicGroup
    elseif group == "sfx" then
        sound.Parent = SFXGroup
    elseif group == "voice" then
        sound.Parent = VoiceGroup
    else
        sound.Parent = MasterGroup
    end
    
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
    
    return sound
end

-- 3D sound for spatial audio
local function play3DSound(soundId, position, parent, volume, pitch)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume or 1
    sound.Pitch = pitch or 1
    sound.Parent = parent or workspace
    
    local attachment = Instance.new("Attachment")
    attachment.Parent = parent or workspace
    
    local soundEmitter = Instance.new("SoundEmitter")
    soundEmitter.Parent = attachment
    
    soundEmitter:Play()
    
    return soundEmitter
end

-- Music system with crossfading
local currentMusic = nil
local function playMusic(musicId, fadeTime)
    if currentMusic then
        -- Fade out current music
        local fadeOut = TweenService:Create(currentMusic, TweenInfo.new(fadeTime), {Volume = 0})
        fadeOut:Play()
        fadeOut.Completed:Connect(function()
            currentMusic:Stop()
            currentMusic:Destroy()
        end)
    end
    
    -- Play new music
    currentMusic = Instance.new("Sound")
    currentMusic.SoundId = musicId
    currentMusic.Volume = 0
    currentMusic.Looped = true
    currentMusic.Parent = MusicGroup
    currentMusic:Play()
    
    -- Fade in
    local fadeIn = TweenService:Create(currentMusic, TweenInfo.new(fadeTime), {Volume = 1})
    fadeIn:Play()
end

-- Export functions
SoundManager.setMasterVolume = setMasterVolume
SoundManager.setMusicVolume = setMusicVolume
SoundManager.setSFXVolume = setSFXVolume
SoundManager.setVoiceVolume = setVoiceVolume
SoundManager.playSound = playSound
SoundManager.play3DSound = play3DSound
SoundManager.playMusic = playMusic

return SoundManager
]],

        DynamicAudioSystem = [[
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local DynamicAudio = {}

-- Dynamic music based on game state
local musicStates = {
    calm = {
        tracks = {"rbxassetid://1234567890"},
        intensity = 0.3
    },
    combat = {
        tracks = {"rbxassetid://1234567891"},
        intensity = 0.8
    },
    victory = {
        tracks = {"rbxassetid://1234567892"},
        intensity = 1.0
    }
}

local currentState = "calm"
local currentTrack = nil

local function setMusicState(state)
    if musicStates[state] then
        currentState = state
        
        -- Crossfade to new track
        local newTrackId = musicStates[state].tracks[1]
        local intensity = musicStates[state].intensity
        
        -- Implementation would crossfade between tracks
        -- based on intensity and state
    end
end

-- Adaptive audio based on player actions
local function onPlayerAction(actionType)
    if actionType == "combat" then
        setMusicState("combat")
    elseif actionType == "victory" then
        setMusicState("victory")
    elseif actionType == "calm" then
        setMusicState("calm")
    end
end

-- Procedural sound generation
local function generateProceduralSound(frequency, duration, waveType)
    -- This would generate sound waves programmatically
    -- Using audio synthesis techniques
end

DynamicAudio.setMusicState = setMusicState
DynamicAudio.onPlayerAction = onPlayerAction
DynamicAudio.generateProceduralSound = generateProceduralSound

return DynamicAudio
]]
    },
    
    -- Audio Best Practices
    BestPractices = {
        "Use SoundGroups for volume control",
        "Implement proper audio ducking",
        "Use compressed audio formats",
        "Optimize by reusing Sound objects",
        "Use 3D spatial audio for immersion",
        "Implement proper audio fading",
        "Consider audio occlusion",
        "Use audio for gameplay feedback",
        "Balance music and sound effects",
        "Test audio on different devices"
    }
}

-- Physics Development Module
SpecializedModules.PhysicsModule = {
    -- Physics Components
    Components = {
        CustomPhysics = [[
local RunService = game:GetService("RunService")
local PhysicsService = game:GetService("PhysicsService")

-- Custom gravity system
local function setCustomGravity(part, gravity)
    local bodyVelocity = part:FindFirstChild("CustomGravity")
    if not bodyVelocity then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "CustomGravity"
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = part
    end
    bodyVelocity.Velocity = Vector3.new(0, -gravity, 0)
end

-- Custom friction
local function setCustomFriction(part, friction)
    part.CustomPhysicalProperties = PhysicalProperties.new(
        part.CustomPhysicalProperties.Density,
        friction,
        part.CustomPhysicalProperties.Elasticity,
        part.CustomPhysicalProperties.FrictionWeight,
        part.CustomPhysicalProperties.ElasticityWeight
    )
end

-- Collision filtering
local function setupCollisionGroups(group1, group2, shouldCollide)
    PhysicsService:CollisionGroupSetCollidable(group1, group2, shouldCollide)
end

-- Raycasting with multiple hits
local function multiRaycast(origin, direction, maxDistance, filterDescendants)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = filterDescendants or {}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.IgnoreWater = true
    
    local results = {}
    local currentOrigin = origin
    local remainingDistance = maxDistance
    
    while remainingDistance > 0 do
        local result = workspace:Raycast(currentOrigin, direction.Unit * remainingDistance, raycastParams)
        
        if result then
            table.insert(results, result)
            currentOrigin = result.Position + direction.Unit * 0.1
            remainingDistance = remainingDistance - (result.Position - currentOrigin).Magnitude
        else
            break
        end
    end
    
    return results
end

-- Custom collision detection
local function sphereCast(center, radius, direction, maxDistance)
    local results = {}
    
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local closestPoint = part:ClosestPoint(center)
            local distance = (closestPoint - center).Magnitude
            
            if distance <= radius then
                table.insert(results, {part = part, point = closestPoint, distance = distance})
            end
        end
    end
    
    return results
end

-- Physics simulation override
local function simulateCustomPhysics(part, deltaTime)
    local velocity = part:FindFirstChild("CustomVelocity")
    local acceleration = part:FindFirstChild("CustomAcceleration")
    
    if velocity and acceleration then
        velocity.Velocity = velocity.Velocity + acceleration.Velocity * deltaTime
        part.CFrame = part.CFrame + velocity.Velocity * deltaTime
    end
end

-- Initialize custom physics
local function initializeCustomPhysics(part)
    -- Remove default physics
    part.Anchored = true
    
    -- Add custom physics components
    local velocity = Instance.new("BodyVelocity")
    velocity.Name = "CustomVelocity"
    velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    velocity.Parent = part
    
    local acceleration = Instance.new("BodyVelocity")
    acceleration.Name = "CustomAcceleration"
    acceleration.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    acceleration.Parent = part
end
]],

        VehiclePhysics = [[
-- Advanced vehicle physics with suspension, traction, and aerodynamics
local RunService = game:GetService("RunService")

local VehiclePhysics = {}

local function setupVehiclePhysics(model)
    local chassis = model:FindFirstChild("Chassis")
    if not chassis then return end
    
    -- Suspension system
    local suspensionStiffness = 5000
    local suspensionDamping = 500
    local suspensionRestLength = 2
    
    -- Wheel configuration
    local wheels = {}
    for _, child in ipairs(model:GetChildren()) do
        if child.Name:find("Wheel") then
            table.insert(wheels, {
                part = child,
        offset = child.Position - chassis.Position
            })
        end
    end
    
    -- Physics update
    local function updateVehicle(deltaTime)
        local velocity = chassis.AssemblyLinearVelocity
        local angularVelocity = chassis.AssemblyAngularVelocity
        
        -- Apply suspension forces
        for _, wheel in ipairs(wheels) do
            local worldPosition = chassis.CFrame:PointToWorldSpace(wheel.offset)
            local rayDirection = Vector3.new(0, -1, 0)
            
            local raycastResult = workspace:Raycast(worldPosition, rayDirection * suspensionRestLength)
            
            if raycastResult then
                local compression = suspensionRestLength - raycastResult.Distance
                local suspensionForce = compression * suspensionStiffness
                local dampingForce = -velocity.Y * suspensionDamping
                
                local totalForce = suspensionForce + dampingForce
                chassis:ApplyForce(Vector3.new(0, totalForce, 0), worldPosition)
            end
        end
        
        -- Apply traction
        local tractionForce = 1000
        local forwardDirection = chassis.CFrame.LookVector
        chassis:ApplyForce(forwardDirection * tractionForce, chassis.Position)
        
        -- Apply aerodynamics
        local dragCoefficient = 0.3
        local dragForce = -velocity.Unit * velocity.Magnitude^2 * dragCoefficient
        chassis:ApplyForce(dragForce, chassis.Position)
    end
    
    RunService.Heartbeat:Connect(updateVehicle)
end

VehiclePhysics.setupVehiclePhysics = setupVehiclePhysics
return VehiclePhysics
]]
    },
    
    -- Physics Best Practices
    BestPractices = {
        "Use NetworkOwnership for multiplayer physics",
        "Optimize collision groups",
        "Use constraints instead of complex physics",
        "Implement proper physics replication",
        "Use RaycastParams for efficient raycasting",
        "Consider physics LOD for distant objects",
        "Use BodyMovers for controlled movement",
        "Implement proper physics interpolation",
        "Test physics on different client framerates",
        "Use physics sub-stepping for stability"
    }
}

-- Get specialized module
function SpecializedModules:GetModule(moduleName)
    return self[moduleName]
end

-- Get component from module
function SpecializedModules:GetComponent(moduleName, componentName)
    local module = self[moduleName]
    if module and module.Components then
        return module.Components[componentName]
    end
    return nil
end

-- Get best practices for module
function SpecializedModules:GetBestPractices(moduleName)
    local module = self[moduleName]
    if module then
        return module.BestPractices
    end
    return {}
end

return SpecializedModules
