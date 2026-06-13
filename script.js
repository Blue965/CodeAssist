// Mobile Navigation Toggle
const navToggle = document.querySelector('.nav-toggle');
const navMenu = document.querySelector('.nav-menu');

navToggle.addEventListener('click', () => {
    navMenu.classList.toggle('active');
});

// Close mobile menu when clicking on a link
document.querySelectorAll('.nav-menu a').forEach(link => {
    link.addEventListener('click', () => {
        navMenu.classList.remove('active');
    });
});

// FAQ Accordion
const faqItems = document.querySelectorAll('.faq-item');

faqItems.forEach(item => {
    const question = item.querySelector('.faq-question');
    question.addEventListener('click', () => {
        // Close other items
        faqItems.forEach(otherItem => {
            if (otherItem !== item) {
                otherItem.classList.remove('active');
            }
        });
        // Toggle current item
        item.classList.toggle('active');
    });
});

// Smooth scroll for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Navbar background change on scroll
const navbar = document.querySelector('.navbar');

window.addEventListener('scroll', () => {
    if (window.scrollY > 50) {
        navbar.style.background = 'rgba(255, 255, 255, 0.98)';
        navbar.style.boxShadow = '0 2px 20px rgba(0, 102, 255, 0.1)';
    } else {
        navbar.style.background = 'rgba(255, 255, 255, 0.95)';
        navbar.style.boxShadow = 'none';
    }
});

// Intersection Observer for animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe feature cards
document.querySelectorAll('.feature-card').forEach((card, index) => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(30px)';
    card.style.transition = `all 0.6s ease ${index * 0.1}s`;
    observer.observe(card);
});

// Observe steps
document.querySelectorAll('.step').forEach((step, index) => {
    step.style.opacity = '0';
    step.style.transform = 'translateY(30px)';
    step.style.transition = `all 0.6s ease ${index * 0.15}s`;
    observer.observe(step);
});

// Observe gallery items
document.querySelectorAll('.gallery-item').forEach((item, index) => {
    item.style.opacity = '0';
    item.style.transform = 'translateY(30px)';
    item.style.transition = `all 0.6s ease ${index * 0.1}s`;
    observer.observe(item);
});

// Observe FAQ items
document.querySelectorAll('.faq-item').forEach((item, index) => {
    item.style.opacity = '0';
    item.style.transform = 'translateY(20px)';
    item.style.transition = `all 0.5s ease ${index * 0.1}s`;
    observer.observe(item);
});

// Typing effect for code window
const codeContent = document.querySelector('.code-content');
if (codeContent) {
    const originalContent = codeContent.innerHTML;
    codeContent.innerHTML = '';
    
    let charIndex = 0;
    const typeSpeed = 10;
    
    function typeCode() {
        if (charIndex < originalContent.length) {
            codeContent.innerHTML = originalContent.substring(0, charIndex + 1);
            charIndex++;
            setTimeout(typeCode, typeSpeed);
        }
    }
    
    // Start typing after a delay
    setTimeout(typeCode, 1000);
}

// Counter animation for stats
const stats = document.querySelectorAll('.stat-number');
let statsAnimated = false;

function animateStats() {
    if (statsAnimated) return;
    
    stats.forEach(stat => {
        const targetText = stat.textContent;
        const targetNumber = parseInt(targetText.replace(/[^0-9]/g, ''));
        const suffix = targetText.replace(/[0-9]/g, '');
        
        let currentNumber = 0;
        const increment = targetNumber / 50;
        const duration = 2000;
        const stepTime = duration / 50;
        
        const counter = setInterval(() => {
            currentNumber += increment;
            if (currentNumber >= targetNumber) {
                stat.textContent = targetText;
                clearInterval(counter);
            } else {
                stat.textContent = Math.floor(currentNumber) + suffix;
            }
        }, stepTime);
    });
    
    statsAnimated = true;
}

// Trigger stats animation when hero section is visible
const heroSection = document.querySelector('.hero');
const statsObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            animateStats();
        }
    });
}, { threshold: 0.5 });

statsObserver.observe(heroSection);

// Button hover effects
document.querySelectorAll('.btn-primary, .btn-secondary').forEach(button => {
    button.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-2px)';
    });
    
    button.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0)';
    });
});

// Parallax effect for hero background
window.addEventListener('scroll', () => {
    const scrolled = window.pageYOffset;
    const hero = document.querySelector('.hero');
    if (hero) {
        hero.style.backgroundPositionY = scrolled * 0.5 + 'px';
    }
});

// Add loading animation
window.addEventListener('load', () => {
    document.body.style.opacity = '1';
});

// Initialize page opacity
document.body.style.opacity = '0';
document.body.style.transition = 'opacity 0.5s ease';

// Capability items animation
document.querySelectorAll('.capability').forEach((capability, index) => {
    capability.style.opacity = '0';
    capability.style.transform = 'translateY(20px)';
    capability.style.transition = `all 0.4s ease ${index * 0.05}s`;
    
    const capObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, { threshold: 0.2 });
    
    capObserver.observe(capability);
});

// Smooth reveal for section headers
document.querySelectorAll('.section-header').forEach(header => {
    header.style.opacity = '0';
    header.style.transform = 'translateY(30px)';
    header.style.transition = 'all 0.6s ease';
    
    const headerObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, { threshold: 0.2 });
    
    headerObserver.observe(header);
});


// Add spin animation for loading state
const style = document.createElement('style');
style.textContent = `
    .spin {
        animation: spin 1s linear infinite;
    }
    
    @keyframes spin {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }
`;
document.head.appendChild(style);

// Download plugin function
function downloadPlugin() {
    // Plugin script content
    const pluginScript = `--[[
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

-- Load API key from plugin settings and pass to module
local success, apiKey = pcall(function()
    return Plugin:GetSetting("CodeAssist_APIKey")
end)
if success and apiKey and apiKey ~= "" then
    AdvancedAI:SetAPIKey(apiKey)
end

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
    
    local requirements = "Production-ready, optimized for performance, includes multiplayer support"
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
            selectedObject.Source = selectedObject.Source .. "\\n\\n" .. OutputBox.Text
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

print("CodeAssist Plugin Loaded Successfully!")`;

    // AdvancedAI module content
    const advancedAIScript = `--[[
    CodeAssist Advanced AI Module
    Real AI-powered code generation using Groq API
]]

local HttpService = game:GetService("HttpService")

local AdvancedAI = {}

AdvancedAI.Config = {
    apiUrl = "https://api.groq.com/openai/v1/chat/completions",
    model = "llama-3.1-70b-versatile",
    temperature = 0.7,
    maxTokens = 4096,
    topP = 0.9,
    apiKey = "" -- Set your API key in plugin settings
}

function AdvancedAI:LoadConfig()
    -- LoadConfig is deprecated - API key should be set by main plugin script via SetAPIKey
    -- This function is kept for backward compatibility but no longer accesses plugin
    return false
end

function AdvancedAI:BuildExpertSystemPrompt()
    return "You are the world's foremost Roblox development expert with 15+ years of experience. Generate production-ready, optimized code for Roblox games."
end

function AdvancedAI:GenerateFullGame(gameDescription, requirements)
    local systemPrompt = self:BuildExpertSystemPrompt()
    local userPrompt = string.format("Generate a complete Roblox game: %s\\nRequirements: %s", gameDescription, requirements or "Standard requirements")
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

function AdvancedAI:GenerateSystem(systemType, specifications)
    local systemPrompt = self:BuildExpertSystemPrompt()
    local userPrompt = string.format("Generate a %s system: %s", systemType, specifications or "Standard requirements")
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

function AdvancedAI:CallGroqAPI(systemPrompt, userPrompt)
    if not self.Config.apiKey or self.Config.apiKey == "" then
        self:LoadConfig()
    end
    
    if not self.Config.apiKey or self.Config.apiKey == "" then
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
    
    if not success then
        return nil, "API request failed: " .. tostring(response)
    end
    
    if response.Success then
        local data = HttpService:JSONDecode(response.Body)
        if data.choices and data.choices[1] then
            return data.choices[1].message.content
        end
        return nil, "Invalid API response format"
    end
    
    return nil, "API request failed: " .. tostring(response.Body)
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

return AdvancedAI`;

    // README content
    const readme = `# CodeAssist Plugin

Advanced AI Assistant for Roblox Developers - Version 1.0.0

## Features

- AI-powered code generation using Groq API
- Generate complete games and systems
- Code optimization and bug detection
- Integrated UI for Roblox Studio
- Copy and insert code directly to scripts

## Installation

1. Open Roblox Studio
2. Go to Plugins > Manage Plugins
3. Click "Create New Plugin"
4. Name it "CodeAssist"
5. Create a Script named "CodeAssist.lua" in the plugin folder
6. Create a ModuleScript named "AdvancedAI.lua" in the same folder
7. Copy the content from the respective files into these scripts
8. Save and restart Roblox Studio

## Configuration

### Setting up the Groq API Key

1. Get your free API key at https://groq.com
2. In Roblox Studio, go to File > Plugin Settings
3. Find CodeAssist in the list
4. Enter your API key in the "CodeAssist_APIKey" field
5. Save the settings

## Usage

### Basic Code Generation

1. Click the "CodeAssist" button in the toolbar
2. Enter a description of what you want to create
3. Click "Generate Code"
4. Copy or insert the generated code

### Full Game Generation

1. Click "Generate Full Game" in the plugin UI
2. Describe the game you want to create
3. Wait for the AI to generate the complete game
4. Review and implement the code

## Requirements

- Roblox Studio
- Groq API key (free at https://groq.com)
- Internet connection for API calls

## Troubleshooting

### "API key not configured" error

- Make sure you've set your Groq API key in plugin settings
- Check that the API key is not empty

### "API request failed" error

- Check your internet connection
- Verify your Groq API key is valid
- Make sure HTTP requests are enabled in Roblox Studio

## Support

For issues and questions, please refer to the documentation or contact support.

## License

This plugin is provided as-is for educational and development purposes.

---

Made with ❤️ for Roblox developers`;

    // Create a text file with all content
    const content = `=== CodeAssist Plugin - Version 1.0.0 ===

=== FILE: CodeAssist.lua (Main Plugin Script) ===
${pluginScript}

=== FILE: AdvancedAI.lua (AI Module) ===
${advancedAIScript}

=== FILE: README.md ===
${readme}`;

    // Create download
    const blob = new Blob([content], { type: 'application/octet-stream' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'CodeAssist-Plugin-v1.0.0.lua';
    a.style.display = 'none';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
}
