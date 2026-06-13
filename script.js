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
    const pluginScript = "--[[\\n    CodeAssist - Advanced AI Assistant for Roblox Developers\\n    Version: 1.0.0\\n]]\\n\\nlocal Plugin = plugin\\nif not Plugin then\\n    error(\"CodeAssist must be run as a Roblox Studio plugin\")\\nend\\n\\nlocal HttpService = game:GetService(\"HttpService\")\\nlocal ChangeHistoryService = game:GetService(\"ChangeHistoryService\")\\nlocal Selection = game:GetService(\"Selection\")\\n\\n-- Create UI\\nlocal Toolbar = Plugin:CreateToolbar(\"CodeAssist\")\\nlocal DockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo.new(\\n    Enum.InitialDockState.Right,\\n    false,\\n    false,\\n    400,\\n    600,\\n    400,\\n    600\\n)\\n\\nlocal CodeAssistWidget = Plugin:CreateDockWidgetPluginGui(\\n    \"CodeAssistWidget\",\\n    DockWidgetPluginGuiInfo\\n)\\n\\nCodeAssistWidget.Title = \"CodeAssist AI\"\\nCodeAssistWidget.Name = \"CodeAssistWidget\"\\n\\n-- Create UI elements\\nlocal ScreenGui = Instance.new(\"ScreenGui\")\\nScreenGui.Parent = CodeAssistWidget\\n\\nlocal MainFrame = Instance.new(\"Frame\")\\nMainFrame.Size = UDim2.new(1, 0, 1, 0)\\nMainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)\\nMainFrame.BorderSizePixel = 0\\nMainFrame.Parent = ScreenGui\\n\\n-- Header\\nlocal Header = Instance.new(\"Frame\")\\nHeader.Size = UDim2.new(1, 0, 0, 60)\\nHeader.BackgroundColor3 = Color3.fromRGB(0, 102, 255)\\nHeader.BorderSizePixel = 0\\nHeader.Parent = MainFrame\\n\\nlocal HeaderText = Instance.new(\"TextLabel\")\\nHeaderText.Size = UDim2.new(1, -20, 1, 0)\\nHeaderText.Position = UDim2.new(0, 10, 0, 0)\\nHeaderText.BackgroundTransparency = 1\\nHeaderText.Text = \"CodeAssist AI\"\\nHeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)\\nHeaderText.TextSize = 24\\nHeaderText.Font = Enum.Font.GothamBold\\nHeaderText.TextXAlignment = Enum.TextXAlignment.Left\\nHeaderText.Parent = Header\\n\\n-- Content Frame\\nlocal ContentFrame = Instance.new(\"Frame\")\\nContentFrame.Size = UDim2.new(1, -20, 1, -70)\\nContentFrame.Position = UDim2.new(0, 10, 0, 65)\\nContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)\\nContentFrame.BorderSizePixel = 0\\nContentFrame.Parent = MainFrame\\n\\n-- Input Section\\nlocal InputLabel = Instance.new(\"TextLabel\")\\nInputLabel.Size = UDim2.new(1, 0, 0, 30)\\nInputLabel.Position = UDim2.new(0, 0, 0, 10)\\nInputLabel.BackgroundTransparency = 1\\nInputLabel.Text = \"Describe what you want to create:\"\\nInputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)\\nInputLabel.TextSize = 14\\nInputLabel.Font = Enum.Font.Gotham\\nInputLabel.TextXAlignment = Enum.TextXAlignment.Left\\nInputLabel.Parent = ContentFrame\\n\\nlocal InputBox = Instance.new(\"TextBox\")\\nInputBox.Size = UDim2.new(1, 0, 0, 100)\\nInputBox.Position = UDim2.new(0, 0, 0, 45)\\nInputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)\\nInputBox.BorderSizePixel = 0\\nInputBox.Text = \"\"\\nInputBox.PlaceholderText = \"e.g., Create a player health system with regeneration...\"\\nInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)\\nInputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)\\nInputBox.TextSize = 14\\nInputBox.Font = Enum.Font.Gotham\\nInputBox.TextXAlignment = Enum.TextXAlignment.Left\\nInputBox.TextYAlignment = Enum.TextYAlignment.Top\\nInputBox.ClearTextOnFocus = false\\nInputBox.MultiLine = true\\nInputBox.Parent = ContentFrame\\n\\nlocal InputPadding = Instance.new(\"UIPadding\")\\nInputPadding.PaddingTop = UDim.new(0, 10)\\nInputPadding.PaddingLeft = UDim.new(0, 10)\\nInputPadding.PaddingRight = UDim.new(0, 10)\\nInputPadding.Parent = InputBox\\n\\n-- Generate Button\\nlocal GenerateButton = Instance.new(\"TextButton\")\\nGenerateButton.Size = UDim2.new(1, 0, 0, 40)\\nGenerateButton.Position = UDim2.new(0, 0, 0, 155)\\nGenerateButton.BackgroundColor3 = Color3.fromRGB(0, 102, 255)\\nGenerateButton.BorderSizePixel = 0\\nGenerateButton.Text = \"Generate Code\"\\nGenerateButton.TextColor3 = Color3.fromRGB(255, 255, 255)\\nGenerateButton.TextSize = 16\\nGenerateButton.Font = Enum.Font.GothamBold\\nGenerateButton.Parent = ContentFrame\\n\\nlocal GenerateCorner = Instance.new(\"UICorner\")\\nGenerateCorner.CornerRadius = UDim.new(0, 8)\\nGenerateCorner.Parent = GenerateButton\\n\\n-- Output Section\\nlocal OutputLabel = Instance.new(\"TextLabel\")\\nOutputLabel.Size = UDim2.new(1, 0, 0, 30)\\nOutputLabel.Position = UDim2.new(0, 0, 0, 205)\\nOutputLabel.BackgroundTransparency = 1\\nOutputLabel.Text = \"Generated Code:\"\\nOutputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)\\nOutputLabel.TextSize = 14\\nOutputLabel.Font = Enum.Font.Gotham\\nOutputLabel.TextXAlignment = Enum.TextXAlignment.Left\\nOutputLabel.Parent = ContentFrame\\n\\nlocal OutputBox = Instance.new(\"TextBox\")\\nOutputBox.Size = UDim2.new(1, 0, 1, -250)\\nOutputBox.Position = UDim2.new(0, 0, 0, 240)\\nOutputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)\\nOutputBox.BorderSizePixel = 0\\nOutputBox.Text = \"\"\\nOutputBox.TextColor3 = Color3.fromRGB(220, 220, 220)\\nOutputBox.TextSize = 13\\nOutputBox.Font = Enum.Font.Code\\nOutputBox.TextXAlignment = Enum.TextXAlignment.Left\\nOutputBox.TextYAlignment = Enum.TextYAlignment.Top\\nOutputBox.ClearTextOnFocus = false\\nOutputBox.MultiLine = true\\nOutputBox.Parent = ContentFrame\\n\\nlocal OutputPadding = Instance.new(\"UIPadding\")\\nOutputPadding.PaddingTop = UDim.new(0, 10)\\nOutputPadding.PaddingLeft = UDim.new(0, 10)\\nOutputPadding.PaddingRight = UDim.new(0, 10)\\nOutputPadding.Parent = OutputBox\\n\\n-- Action Buttons\\nlocal ActionButtonsFrame = Instance.new(\"Frame\")\\nActionButtonsFrame.Size = UDim2.new(1, 0, 0, 120)\\nActionButtonsFrame.Position = UDim2.new(0, 0, 1, -125)\\nActionButtonsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)\\nActionButtonsFrame.BorderSizePixel = 0\\nActionButtonsFrame.Parent = ContentFrame\\n\\nlocal FullGameButton = Instance.new(\"TextButton\")\\nFullGameButton.Size = UDim2.new(1, -10, 0, 35)\\nFullGameButton.Position = UDim2.new(0, 5, 0, 5)\\nFullGameButton.BackgroundColor3 = Color3.fromRGB(0, 102, 255)\\nFullGameButton.BorderSizePixel = 0\\nFullGameButton.Text = \"Generate Full Game\"\\nFullGameButton.TextColor3 = Color3.fromRGB(255, 255, 255)\\nFullGameButton.TextSize = 14\\nFullGameButton.Font = Enum.Font.GothamBold\\nFullGameButton.Parent = ActionButtonsFrame\\n\\nlocal FullGameCorner = Instance.new(\"UICorner\")\\nFullGameCorner.CornerRadius = UDim.new(0, 6)\\nFullGameCorner.Parent = FullGameButton\\n\\nlocal CopyButton = Instance.new(\"TextButton\")\\nCopyButton.Size = UDim2.new(0.48, -5, 0, 30)\\nCopyButton.Position = UDim2.new(0, 5, 0, 85)\\nCopyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)\\nCopyButton.BorderSizePixel = 0\\nCopyButton.Text = \"Copy to Clipboard\"\\nCopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)\\nCopyButton.TextSize = 13\\nCopyButton.Font = Enum.Font.Gotham\\nCopyButton.Parent = ActionButtonsFrame\\n\\nlocal CopyCorner = Instance.new(\"UICorner\")\\nCopyCorner.CornerRadius = UDim.new(0, 6)\\nCopyCorner.Parent = CopyButton\\n\\nlocal InsertButton = Instance.new(\"TextButton\")\\nInsertButton.Size = UDim2.new(0.48, -5, 0, 30)\\nInsertButton.Position = UDim2.new(0.52, 5, 0, 85)\\nInsertButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)\\nInsertButton.BorderSizePixel = 0\\nInsertButton.Text = \"Insert to Script\"\\nInsertButton.TextColor3 = Color3.fromRGB(255, 255, 255)\\nInsertButton.TextSize = 13\\nInsertButton.Font = Enum.Font.Gotham\\nInsertButton.Parent = ActionButtonsFrame\\n\\nlocal InsertCorner = Instance.new(\"UICorner\")\\nInsertCorner.CornerRadius = UDim.new(0, 6)\\nInsertCorner.Parent = InsertButton\\n\\n-- Toolbar Buttons\\nlocal GenerateButtonToolbar = Toolbar:CreateButton(\"Generate Code\", \"Generate AI code\", \"rbxassetid://0\")\\nlocal FullGameToolbar = Toolbar:CreateButton(\"Full Game\", \"Generate complete game with AI\", \"rbxassetid://0\")\\n\\n-- Load Advanced AI Module\\nlocal AdvancedAI = require(script.Parent.AdvancedAI)\\n\\n-- Load API key from plugin settings and pass to module\\nlocal success, apiKey = pcall(function()\\n    return Plugin:GetSetting(\"CodeAssist_APIKey\")\\nend)\\nif success and apiKey and apiKey ~= \"\" then\\n    AdvancedAI:SetAPIKey(apiKey)\\nend\\n\\n-- AI Functions\\nlocal AIService = {}\\n\\nfunction AIService:GenerateCode(prompt)\\n    return AdvancedAI:GenerateSystem(\"custom\", prompt)\\nend\\n\\nfunction AIService:GenerateFullGame(gameDescription, requirements)\\n    return AdvancedAI:GenerateFullGame(gameDescription, requirements)\\nend\\n\\n-- Event Handlers\\nGenerateButton.MouseButton1Click:Connect(function()\\n    local userInput = InputBox.Text\\n    if userInput == \"\" or userInput == \" \" then\\n        OutputBox.Text = \"Please enter a description of what you want to create.\"\\n        return\\n    end\\n    \\n    OutputBox.Text = \"Generating code... Please wait.\"\\n    GenerateButton.Text = \"Generating...\"\\n    GenerateButton.Active = false\\n    \\n    local success, result = AIService:GenerateCode(userInput)\\n    \\n    if success then\\n        OutputBox.Text = result\\n    else\\n        OutputBox.Text = \"Error: \" .. (result or \"Unknown error\")\\n    end\\n    \\n    GenerateButton.Text = \"Generate Code\"\\n    GenerateButton.Active = true\\nend)\\n\\nFullGameButton.MouseButton1Click:Connect(function()\\n    local gameDescription = InputBox.Text\\n    if gameDescription == \"\" or gameDescription == \" \" then\\n        OutputBox.Text = \"Please describe the game you want to create.\"\\n        return\\n    end\\n    \\n    OutputBox.Text = \"Generating complete game... This may take a while.\"\\n    FullGameButton.Text = \"Generating...\"\\n    FullGameButton.Active = false\\n    \\n    local requirements = \"Production-ready, optimized for performance, includes multiplayer support\"\\n    local success, result = AIService:GenerateFullGame(gameDescription, requirements)\\n    \\n    if success then\\n        OutputBox.Text = result\\n    else\\n        OutputBox.Text = \"Error: \" .. (result or \"Unknown error\")\\n    end\\n    \\n    FullGameButton.Text = \"Generate Full Game\"\\n    FullGameButton.Active = true\\nend)\\n\\nCopyButton.MouseButton1Click:Connect(function()\\n    if OutputBox.Text ~= \"\" then\\n        HttpService:ClipboardSet(OutputBox.Text)\\n        CopyButton.Text = \"Copied!\"\\n        task.wait(1)\\n        CopyButton.Text = \"Copy to Clipboard\"\\n    end\\nend)\\n\\nInsertButton.MouseButton1Click:Connect(function()\\n    local selected = Selection:Get()\\n    if #selected > 0 then\\n        local selectedObject = selected[1]\\n        if selectedObject:IsA(\"Script\") or selectedObject:IsA(\"LocalScript\") or selectedObject:IsA(\"ModuleScript\") then\\n            ChangeHistoryService:SetWaypoint(\"Before CodeAssist Insert\")\\n            selectedObject.Source = selectedObject.Source .. \"\\\\n\\\\n\" .. OutputBox.Text\\n            ChangeHistoryService:SetWaypoint(\"After CodeAssist Insert\")\\n            InsertButton.Text = \"Inserted!\"\\n            task.wait(1)\\n            InsertButton.Text = \"Insert to Script\"\\n        else\\n            warn(\"Selected object is not a script\")\\n        end\\n    else\\n        warn(\"No object selected\")\\n    end\\nend)\\n\\nGenerateButtonToolbar.Click:Connect(function()\\n    CodeAssistWidget.Enabled = not CodeAssistWidget.Enabled\\nend)\\n\\nFullGameToolbar.Click:Connect(function()\\n    CodeAssistWidget.Enabled = true\\n    FullGameButton:Activate()\\nend)\\n\\nprint(\"CodeAssist Plugin Loaded Successfully!\")";

    // AdvancedAI module content
    const advancedAIScript = "--[[\\n    CodeAssist Advanced AI Module\\n    Real AI-powered code generation using Groq API\\n]]\\n\\nlocal HttpService = game:GetService(\"HttpService\")\\n\\nlocal AdvancedAI = {}\\n\\nAdvancedAI.Config = {\\n    apiUrl = \"https://api.groq.com/openai/v1/chat/completions\",\\n    model = \"llama-3.1-70b-versatile\",\\n    temperature = 0.7,\\n    maxTokens = 4096,\\n    topP = 0.9,\\n    apiKey = \"\" -- Set your API key in plugin settings\\n}\\n\\nfunction AdvancedAI:LoadConfig()\\n    -- LoadConfig is deprecated - API key should be set by main plugin script via SetAPIKey\\n    -- This function is kept for backward compatibility but no longer accesses plugin\\n    return false\\nend\\n\\nfunction AdvancedAI:BuildExpertSystemPrompt()\\n    return \"You are the world's foremost Roblox development expert with 15+ years of experience. Generate production-ready, optimized code for Roblox games.\"\\nend\\n\\nfunction AdvancedAI:GenerateFullGame(gameDescription, requirements)\\n    local systemPrompt = self:BuildExpertSystemPrompt()\\n    local userPrompt = string.format(\"Generate a complete Roblox game: %s\\\\nRequirements: %s\", gameDescription, requirements or \"Standard requirements\")\\n    return self:CallGroqAPI(systemPrompt, userPrompt)\\nend\\n\\nfunction AdvancedAI:GenerateSystem(systemType, specifications)\\n    local systemPrompt = self:BuildExpertSystemPrompt()\\n    local userPrompt = string.format(\"Generate a %s system: %s\", systemType, specifications or \"Standard requirements\")\\n    return self:CallGroqAPI(systemPrompt, userPrompt)\\nend\\n\\nfunction AdvancedAI:CallGroqAPI(systemPrompt, userPrompt)\\n    if not self.Config.apiKey or self.Config.apiKey == \"\" then\\n        self:LoadConfig()\\n    end\\n    \\n    if not self.Config.apiKey or self.Config.apiKey == \"\" then\\n        return nil, \"API key not configured. Please set your Groq API key in plugin settings.\"\\n    end\\n    \\n    local requestBody = {\\n        model = self.Config.model,\\n        messages = {\\n            {role = \"system\", content = systemPrompt},\\n            {role = \"user\", content = userPrompt}\\n        },\\n        temperature = self.Config.temperature,\\n        max_tokens = self.Config.maxTokens,\\n        top_p = self.Config.topP\\n    }\\n    \\n    local success, response = pcall(function()\\n        return HttpService:RequestAsync({\\n            Url = self.Config.apiUrl,\\n            Method = \"POST\",\\n            Headers = {\\n                [\"Content-Type\"] = \"application/json\",\\n                [\"Authorization\"] = \"Bearer \" .. self.Config.apiKey\\n            },\\n            Body = HttpService:JSONEncode(requestBody)\\n        })\\n    end)\\n    \\n    if not success then\\n        return nil, \"API request failed: \" .. tostring(response)\\n    end\\n    \\n    if response.Success then\\n        local data = HttpService:JSONDecode(response.Body)\\n        if data.choices and data.choices[1] then\\n            return data.choices[1].message.content\\n        end\\n        return nil, \"Invalid API response format\"\\n    end\\n    \\n    return nil, \"API request failed: \" .. tostring(response.Body)\\nend\\n\\nfunction AdvancedAI:SetAPIKey(apiKey)\\n    self.Config.apiKey = apiKey\\n    local Plugin = plugin or getfenv().plugin\\n    if Plugin then\\n        pcall(function()\\n            Plugin:SetSetting(\"CodeAssist_APIKey\", apiKey)\\n        end)\\n    end\\nend\\n\\nreturn AdvancedAI";

    // README content
    const readme = "# CodeAssist Plugin\\n\\nAdvanced AI Assistant for Roblox Developers - Version 1.0.0\\n\\n## Features\\n\\n- AI-powered code generation using Groq API\\n- Generate complete games and systems\\n- Code optimization and bug detection\\n- Integrated UI for Roblox Studio\\n- Copy and insert code directly to scripts\\n\\n## Installation\\n\\n1. Open Roblox Studio\\n2. Go to Plugins > Manage Plugins\\n3. Click \"Create New Plugin\"\\n4. Name it \"CodeAssist\"\\n5. Create a Script named \"CodeAssist.lua\" in the plugin folder\\n6. Create a ModuleScript named \"AdvancedAI.lua\" in the same folder\\n7. Copy the content from the respective files into these scripts\\n8. Save and restart Roblox Studio\\n\\n## Configuration\\n\\n### Setting up the Groq API Key\\n\\n1. Get your free API key at https://groq.com\\n2. In Roblox Studio, go to File > Plugin Settings\\n3. Find CodeAssist in the list\\n4. Enter your API key in the \"CodeAssist_APIKey\" field\\n5. Save the settings\\n\\n## Usage\\n\\n### Basic Code Generation\\n\\n1. Click the \"CodeAssist\" button in the toolbar\\n2. Enter a description of what you want to create\\n3. Click \"Generate Code\"\\n4. Copy or insert the generated code\\n\\n### Full Game Generation\\n\\n1. Click \"Generate Full Game\" in the plugin UI\\n2. Describe the game you want to create\\n3. Wait for the AI to generate the complete game\\n4. Review and implement the code\\n\\n## Requirements\\n\\n- Roblox Studio\\n- Groq API key (free at https://groq.com)\\n- Internet connection for API calls\\n\\n## Troubleshooting\\n\\n### \"API key not configured\" error\\n\\n- Make sure you've set your Groq API key in plugin settings\\n- Check that the API key is not empty\\n\\n### \"API request failed\" error\\n\\n- Check your internet connection\\n- Verify your Groq API key is valid\\n- Make sure HTTP requests are enabled in Roblox Studio\\n\\n## Support\\n\\nFor issues and questions, please refer to the documentation or contact support.\\n\\n## License\\n\\nThis plugin is provided as-is for educational and development purposes.\\n\\n---\\n\\nMade with ❤️ for Roblox developers";

    // Create a text file with all content
    const content = "=== CodeAssist Plugin - Version 1.0.0 ===\\n\\n=== FILE: CodeAssist.lua (Main Plugin Script) ===\\n" + pluginScript + "\\n\\n=== FILE: AdvancedAI.lua (AI Module) ===\\n" + advancedAIScript + "\\n\\n=== FILE: README.md ===\\n" + readme;

    // Create download
    const blob = new Blob([content], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'CodeAssist-Plugin-v1.0.0.lua';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
}
