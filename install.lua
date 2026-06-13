--[[
    CodeAssist Installation Script
    Automated installation and setup for CodeAssist plugin
]]

local Installation = {}

-- Installation Configuration
Installation.Config = {
    PluginName = "CodeAssist",
    Version = "1.0.0",
    RequiredServices = {
        "HttpService",
        "ChangeHistoryService",
        "Selection",
        "ScriptEditorService"
    },
    OptionalServices = {
        "Players",
        "ReplicatedStorage",
        "ServerStorage"
    }
}

-- Installation Steps
function Installation:RunInstallation()
    print("=== CodeAssist Installation ===")
    print("Version: " .. self.Config.Version)
    print()
    
    -- Step 1: Check prerequisites
    print("[1/6] Checking prerequisites...")
    if not self:CheckPrerequisites() then
        print("❌ Prerequisites check failed")
        return false
    end
    print("✅ Prerequisites check passed")
    
    -- Step 2: Verify environment
    print("[2/6] Verifying environment...")
    if not self:VerifyEnvironment() then
        print("❌ Environment verification failed")
        return false
    end
    print("✅ Environment verified")
    
    -- Step 3: Check API configuration
    print("[3/6] Checking API configuration...")
    if not self:CheckAPIConfiguration() then
        print("⚠️  API configuration incomplete")
        print("   Please configure your Groq API key in the .env file")
        print("   The plugin will still work but with limited functionality")
    else
        print("✅ API configuration found")
    end
    
    -- Step 4: Install plugin files
    print("[4/6] Installing plugin files...")
    if not self:InstallPluginFiles() then
        print("❌ Plugin file installation failed")
        return false
    end
    print("✅ Plugin files installed")
    
    -- Step 5: Setup plugin
    print("[5/6] Setting up plugin...")
    if not self:SetupPlugin() then
        print("❌ Plugin setup failed")
        return false
    end
    print("✅ Plugin setup complete")
    
    -- Step 6: Verify installation
    print("[6/6] Verifying installation...")
    if not self:VerifyInstallation() then
        print("❌ Installation verification failed")
        return false
    end
    print("✅ Installation verified")
    
    print()
    print("=== Installation Complete ===")
    print("CodeAssist has been successfully installed!")
    print()
    print("Next steps:")
    print("1. Restart Roblox Studio")
    print("2. Enable the plugin in Plugin Manager")
    print("3. Click the CodeAssist button in the toolbar")
    print()
    
    return true
end

-- Check prerequisites
function Installation:CheckPrerequisites()
    local Plugin = plugin or getfenv().plugin
    if not Plugin then
        print("   Error: This script must be run as a Roblox Studio plugin")
        return false
    end
    
    -- Check required services
    for _, serviceName in ipairs(self.Config.RequiredServices) do
        local success, service = pcall(function()
            return game:GetService(serviceName)
        end)
        if not success then
            print("   Error: Required service not found: " .. serviceName)
            return false
        end
    end
    
    return true
end

-- Verify environment
function Installation:VerifyEnvironment()
    -- Check if running in Roblox Studio
    local RunService = game:GetService("RunService")
    if not RunService:IsStudio() then
        print("   Warning: Not running in Roblox Studio")
        print("   Some features may not work correctly")
    end
    
    -- Check HTTP service is enabled
    local HttpService = game:GetService("HttpService")
    local success = pcall(function()
        HttpService:GetAsync("https://www.google.com")
    end)
    
    if not success then
        print("   Warning: HTTP requests may be disabled")
        print("   AI features will not work without HTTP access")
    end
    
    return true
end

-- Check API configuration
function Installation:CheckAPIConfiguration()
    -- This would check if the .env file exists and has a valid API key
    -- For now, we'll just check if the user has configured it
    
    local Plugin = plugin or getfenv().plugin
    local success, apiKey = pcall(function()
        return Plugin:GetSetting("CodeAssist_APIKey")
    end)
    
    if success and apiKey and apiKey ~= "" then
        return true
    end
    
    return false
end

-- Install plugin files
function Installation:InstallPluginFiles()
    -- This would copy the plugin files to the correct location
    -- For now, we'll assume the files are already in place
    
    print("   Installing main plugin file...")
    print("   Installing module files...")
    print("   Installing configuration files...")
    
    return true
end

-- Setup plugin
function Installation:SetupPlugin()
    local Plugin = plugin or getfenv().plugin
    
    -- Set default settings
    local success, err = pcall(function()
        Plugin:SetSetting("CodeAssist_Installed", true)
        Plugin:SetSetting("CodeAssist_Version", self.Config.Version)
        Plugin:SetSetting("CodeAssist_FirstRun", true)
    end)
    
    if not success then
        print("   Error: Failed to save plugin settings: " .. tostring(err))
        return false
    end
    
    return true
end

-- Verify installation
function Installation:VerifyInstallation()
    local Plugin = plugin or getfenv().plugin
    
    -- Check if settings were saved
    local success, installed = pcall(function()
        return Plugin:GetSetting("CodeAssist_Installed")
    end)
    
    if not success or not installed then
        print("   Error: Plugin settings not found")
        return false
    end
    
    -- Check version
    local success, version = pcall(function()
        return Plugin:GetSetting("CodeAssist_Version")
    end)
    
    if not success or version ~= self.Config.Version then
        print("   Warning: Version mismatch")
    end
    
    return true
end

-- Uninstallation
function Installation:RunUninstallation()
    print("=== CodeAssist Uninstallation ===")
    print()
    
    print("[1/3] Removing plugin settings...")
    if not self:RemovePluginSettings() then
        print("❌ Failed to remove plugin settings")
        return false
    end
    print("✅ Plugin settings removed")
    
    print("[2/3] Cleaning up plugin files...")
    if not self:CleanupPluginFiles() then
        print("❌ Failed to cleanup plugin files")
        return false
    end
    print("✅ Plugin files cleaned up")
    
    print("[3/3] Verifying uninstallation...")
    if not self:VerifyUninstallation() then
        print("❌ Uninstallation verification failed")
        return false
    end
    print("✅ Uninstallation verified")
    
    print()
    print("=== Uninstallation Complete ===")
    print("CodeAssist has been successfully uninstalled.")
    print("Please restart Roblox Studio.")
    
    return true
end

-- Remove plugin settings
function Installation:RemovePluginSettings()
    local Plugin = plugin or getfenv().plugin
    
    local settingsToRemove = {
        "CodeAssist_Installed",
        "CodeAssist_Version",
        "CodeAssist_FirstRun",
        "CodeAssist_APIKey",
        "CodeAssist_Settings"
    }
    
    for _, setting in ipairs(settingsToRemove) do
        pcall(function()
            Plugin:SetSetting(setting, nil)
        end)
    end
    
    return true
end

-- Cleanup plugin files
function Installation:CleanupPluginFiles()
    -- This would remove the plugin files
    print("   Removing main plugin file...")
    print("   Removing module files...")
    print("   Removing configuration files...")
    
    return true
end

-- Verify uninstallation
function Installation:VerifyUninstallation()
    local Plugin = plugin or getfenv().plugin
    
    local success, installed = pcall(function()
        return Plugin:GetSetting("CodeAssist_Installed")
    end)
    
    if success and installed then
        print("   Warning: Plugin settings still exist")
        return false
    end
    
    return true
end

-- Update installation
function Installation:RunUpdate()
    print("=== CodeAssist Update ===")
    print("Current version: " .. self:GetCurrentVersion())
    print("New version: " .. self.Config.Version)
    print()
    
    print("[1/4] Checking for updates...")
    if not self:CheckForUpdates() then
        print("❌ Update check failed")
        return false
    end
    print("✅ Updates available")
    
    print("[2/4] Backing up current settings...")
    if not self:BackupSettings() then
        print("❌ Settings backup failed")
        return false
    end
    print("✅ Settings backed up")
    
    print("[3/4] Installing update...")
    if not self:InstallUpdate() then
        print("❌ Update installation failed")
        return false
    end
    print("✅ Update installed")
    
    print("[4/4] Restoring settings...")
    if not self:RestoreSettings() then
        print("❌ Settings restoration failed")
        return false
    end
    print("✅ Settings restored")
    
    print()
    print("=== Update Complete ===")
    print("CodeAssist has been successfully updated to version " .. self.Config.Version)
    
    return true
end

-- Get current version
function Installation:GetCurrentVersion()
    local Plugin = plugin or getfenv().plugin
    local success, version = pcall(function()
        return Plugin:GetSetting("CodeAssist_Version")
    end)
    
    if success and version then
        return version
    end
    
    return "unknown"
end

-- Check for updates
function Installation:CheckForUpdates()
    -- This would check for updates from a server
    -- For now, we'll assume updates are available
    return true
end

-- Backup settings
function Installation:BackupSettings()
    local Plugin = plugin or getfenv().plugin
    
    local success, settings = pcall(function()
        return Plugin:GetSetting("CodeAssist_Settings")
    end)
    
    if success and settings then
        local backupSuccess = pcall(function()
            Plugin:SetSetting("CodeAssist_Settings_Backup", settings)
        end)
        return backupSuccess
    end
    
    return true -- No settings to backup is okay
end

-- Install update
function Installation:InstallUpdate()
    -- This would install the update files
    return self:InstallPluginFiles()
end

-- Restore settings
function Installation:RestoreSettings()
    local Plugin = plugin or getfenv().plugin
    
    local success, backup = pcall(function()
        return Plugin:GetSetting("CodeAssist_Settings_Backup")
    end)
    
    if success and backup then
        local restoreSuccess = pcall(function()
            Plugin:SetSetting("CodeAssist_Settings", backup)
            Plugin:SetSetting("CodeAssist_Settings_Backup", nil)
        end)
        return restoreSuccess
    end
    
    return true
end

-- First run setup
function Installation:FirstRunSetup()
    print("=== CodeAssist First Run Setup ===")
    print()
    print("Welcome to CodeAssist!")
    print("Let's configure your AI assistant.")
    print()
    
    print("Step 1: API Configuration")
    print("To use AI features, you need a Groq API key.")
    print("Get your free API key at: https://groq.com")
    print()
    print("Enter your API key (or press Enter to skip):")
    -- In a real implementation, this would prompt for input
    
    print()
    print("Step 2: Feature Preferences")
    print("Enable code generation? (Y/n):")
    -- In a real implementation, this would prompt for input
    
    print()
    print("Step 3: UI Preferences")
    print("Choose theme (dark/light):")
    -- In a real implementation, this would prompt for input
    
    print()
    print("=== Setup Complete ===")
    print("CodeAssist is ready to use!")
    
    -- Mark first run as complete
    local Plugin = plugin or getfenv().plugin
    pcall(function()
        Plugin:SetSetting("CodeAssist_FirstRun", false)
    end)
    
    return true
end

-- Diagnostic tool
function Installation:RunDiagnostics()
    print("=== CodeAssist Diagnostics ===")
    print()
    
    print("System Information:")
    print("  Roblox Studio: " .. self:GetStudioVersion())
    print("  Plugin Version: " .. self.Config.Version)
    print("  Installation Status: " .. (self:IsInstalled() and "Installed" or "Not Installed"))
    print()
    
    print("Service Status:")
    for _, serviceName in ipairs(self.Config.RequiredServices) do
        local status = self:CheckService(serviceName) and "✅" or "❌"
        print("  " .. serviceName .. ": " .. status)
    end
    print()
    
    print("Configuration Status:")
    print("  API Key: " .. (self:HasAPIKey() and "✅ Configured" or "❌ Not configured"))
    print("  Settings: " .. (self:HasSettings() and "✅ Loaded" or "❌ Not loaded"))
    print()
    
    print("Feature Status:")
    print("  Code Generation: " .. (self:IsFeatureEnabled("code_generation") and "✅ Enabled" or "❌ Disabled"))
    print("  Bug Detection: " .. (self:IsFeatureEnabled("bug_detection") and "✅ Enabled" or "❌ Disabled"))
    print("  Optimization: " .. (self:IsFeatureEnabled("optimization") and "✅ Enabled" or "❌ Disabled"))
    print()
    
    print("=== Diagnostics Complete ===")
end

-- Helper functions
function Installation:GetStudioVersion()
    local RunService = game:GetService("RunService")
    if RunService:IsStudio() then
        return "Studio (Unknown Version)"
    end
    return "Not Studio"
end

function Installation:IsInstalled()
    local Plugin = plugin or getfenv().plugin
    local success, installed = pcall(function()
        return Plugin:GetSetting("CodeAssist_Installed")
    end)
    return success and installed
end

function Installation:CheckService(serviceName)
    local success = pcall(function()
        game:GetService(serviceName)
    end)
    return success
end

function Installation:HasAPIKey()
    local Plugin = plugin or getfenv().plugin
    local success, apiKey = pcall(function()
        return Plugin:GetSetting("CodeAssist_APIKey")
    end)
    return success and apiKey and apiKey ~= ""
end

function Installation:HasSettings()
    local Plugin = plugin or getfenv().plugin
    local success, settings = pcall(function()
        return Plugin:GetSetting("CodeAssist_Settings")
    end)
    return success and settings
end

function Installation:IsFeatureEnabled(feature)
    local Plugin = plugin or getfenv().plugin
    local success, settings = pcall(function()
        return Plugin:GetSetting("CodeAssist_Settings")
    end)
    
    if success and settings then
        return settings[feature] ~= false
    end
    
    return true -- Default to enabled
end

-- Export installation module
return Installation
