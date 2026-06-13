--[[
    CodeAssist Settings Module
    Handles plugin configuration, user preferences, and API key management
]]

local HttpService = game:GetService("HttpService")

local Settings = {}

-- Default Settings
Settings.Defaults = {
    -- API Configuration
    APIKey = "",
    APIUrl = "https://api.groq.com/openai/v1/chat/completions",
    Model = "llama-3.1-70b-versatile",
    
    -- AI Parameters
    Temperature = 0.7,
    MaxTokens = 4096,
    TopP = 0.9,
    FrequencyPenalty = 0.0,
    PresencePenalty = 0.0,
    
    -- Feature Toggles
    EnableCodeGeneration = true,
    EnableBugDetection = true,
    EnableOptimization = true,
    EnableRealtimeSuggestions = true,
    EnableCodeExplanation = true,
    EnableProjectAnalysis = true,
    
    -- Performance Settings
    MaxConcurrentRequests = 5,
    RequestTimeout = 30000,
    CacheEnabled = true,
    CacheTTL = 3600,
    
    -- UI Settings
    Theme = "dark",
    FontSize = 14,
    AutoSave = true,
    AutoSaveInterval = 300,
    
    -- Logging
    LogLevel = "info",
    DebugMode = false,
    
    -- Advanced Settings
    EnableContextAwareness = true,
    EnableLearning = true,
    EnableAutoOptimization = false,
    SuggestionConfidenceThreshold = 0.7
}

-- Current Settings
Settings.Current = {}

-- Load Settings from Plugin Storage
function Settings:Load()
    local Plugin = plugin or getfenv().plugin
    if not Plugin then return false end
    
    local success, data = pcall(function()
        return Plugin:GetSetting("CodeAssist_Settings")
    end)
    
    if success and data then
        self.Current = data
    else
        self.Current = table.clone(self.Defaults)
    end
    
    return true
end

-- Save Settings to Plugin Storage
function Settings:Save()
    local Plugin = plugin or getfenv().plugin
    if not Plugin then return false end
    
    local success, err = pcall(function()
        Plugin:SetSetting("CodeAssist_Settings", self.Current)
    end)
    
    return success, err
end

-- Get a specific setting
function Settings:Get(key)
    return self.Current[key] or self.Defaults[key]
end

-- Set a specific setting
function Settings:Set(key, value)
    self.Current[key] = value
    return self:Save()
end

-- Reset to defaults
function Settings:Reset()
    self.Current = table.clone(self.Defaults)
    return self:Save()
end

-- Validate API Key
function Settings:ValidateAPIKey(apiKey)
    if not apiKey or apiKey == "" then
        return false, "API Key is empty"
    end
    
    if string.len(apiKey) < 20 then
        return false, "API Key is too short"
    end
    
    return true, "API Key is valid"
end

-- Export Settings
function Settings:Export()
    return HttpService():JSONEncode(self.Current)
end

-- Import Settings
function Settings:Import(jsonString)
    local HttpService = game:GetService("HttpService")
    local success, data = pcall(function()
        return HttpService:JSONDecode(jsonString)
    end)
    
    if success then
        self.Current = data
        return self:Save()
    end
    
    return false, "Invalid JSON format"
end

-- Initialize Settings
function Settings:Initialize()
    self:Load()
    
    -- Validate API key
    local apiKey = self:Get("APIKey")
    local valid, message = self:ValidateAPIKey(apiKey)
    
    if not valid then
        warn("CodeAssist: " .. message)
    end
    
    return self.Current
end

return Settings
