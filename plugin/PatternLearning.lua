--[[
    CodeAssist Pattern Learning Module
    Machine learning integration for code pattern recognition and generation
]]

local HttpService = game:GetService("HttpService")
local DataStoreService = game:GetService("DataStoreService")

local PatternLearning = {}

-- Pattern Database
PatternLearning.Database = {
    -- Common Code Patterns
    CommonPatterns = {
        PlayerJoinPattern = {
            pattern = "Players%.PlayerAdded%.Connect",
            frequency = 0.95,
            context = "player_management"
        },
        
        DataStorePattern = {
            pattern = "DataStoreService:GetDataStore",
            frequency = 0.88,
            context = "data_storage"
        },
        
        RemoteEventPattern = {
            pattern = "RemoteEvent%.FireServer",
            frequency = 0.92,
            context = "networking"
        },
        
        WaitForChildPattern = {
            pattern = ":WaitForChild%(",
            frequency = 0.97,
            context = "instance_management"
        },
        
        PCallPattern = {
            pattern = "pcall%(function",
            frequency = 0.94,
            context = "error_handling"
        }
    },
    
    -- Anti-Patterns (common mistakes)
    AntiPatterns = {
        NoPCallForDataStore = {
            pattern = "DataStore.*:SetAsync%(.*%)",
            severity = "high",
            fix = "Wrap DataStore calls in pcall for error handling"
        },
        
        NoWaitForChild = {
            pattern = "%.Parent%.Script",
            severity = "medium",
            fix = "Use WaitForChild when accessing instances that might not exist"
        },
        
        GlobalVariables = {
            pattern = "^%s*[a-zA-Z_][a-zA-Z0-9_]*%s*=%s*",
            severity = "low",
            fix = "Use local variables for better performance and scope management"
        },
        
        MagicNumbers = {
            pattern = "%d+%.?%d*",
            severity = "low",
            fix = "Define constants for magic numbers to improve code readability"
        }
    },
    
    -- Code Smells
    CodeSmells = {
        LongFunction = {
            threshold = 50,
            message = "Function is too long, consider breaking it into smaller functions"
        },
        
        DeepNesting = {
            threshold = 4,
            message = "Deep nesting detected, consider refactoring"
        },
        
        DuplicateCode = {
            threshold = 3,
            message = "Duplicate code detected, consider creating a function"
        },
        
        LargeParameterList = {
            threshold = 5,
            message = "Too many parameters, consider using a table or object"
        }
    },
    
    -- Performance Patterns
    PerformancePatterns = {
        ObjectPooling = {
            description = "Use object pooling for frequently created/destroyed objects",
            impact = "high",
            example = [[
-- Instead of creating/destroying:
local bullet = Instance.new("Part")
-- ... use bullet
bullet:Destroy()

-- Use pooling:
local bulletPool = {}
function getBullet()
    if #bulletPool > 0 then
        return table.remove(bulletPool)
    end
    return Instance.new("Part")
end
function returnBullet(bullet)
    table.insert(bulletPool, bullet)
end
]]
        },
        
        SpatialHashing = {
            description = "Use spatial hashing for efficient spatial queries",
            impact = "high",
            example = [[
local cellSize = 50
local spatialHash = {}

function getCellKey(position)
    local x = math.floor(position.X / cellSize)
    local z = math.floor(position.Z / cellSize)
    return x .. "," .. z
end

function addToHash(object)
    local key = getCellKey(object.Position)
    if not spatialHash[key] then
        spatialHash[key] = {}
    end
    table.insert(spatialHash[key], object)
end
]]
        },
        
        ClientSidePrediction = {
            description = "Use client-side prediction for smooth gameplay",
            impact = "medium",
            example = [[
-- Client-side movement prediction
local function predictMovement(input)
    local predictedPosition = currentPosition + input * speed * deltaTime
    -- Apply predicted position immediately
    -- Server will validate and correct if needed
end
]]
        }
    },
    
    -- Security Patterns
    SecurityPatterns = {
        ServerValidation = {
            description = "Always validate client input on the server",
            severity = "critical",
            example = [[
-- BAD (trusts client):
RemoteEvent.OnServerEvent:Connect(function(player, damage)
    targetHumanoid.Health -= damage  -- Client can send any damage!
end)

-- GOOD (validates on server):
RemoteEvent.OnServerEvent:Connect(function(player, damage)
    damage = math.clamp(damage, 0, MAX_DAMAGE)  -- Validate
    if canDamage(player, target) then  -- Additional checks
        targetHumanoid.Health -= damage
    end
end)
]]
        },
        
        FilteringEnabled = {
            description = "Use FilteringEnabled for security",
            severity = "high",
            example = [[
-- Enable FilteringEnabled in game settings
-- Use RemoteEvents/RemoteFunctions for client-server communication
-- Never trust client-side calculations for game logic
]]
        },
        
        AccessChecks = {
            description = "Implement proper access checks",
            severity = "high",
            example = [[
local function isAdmin(player)
    return player:GetRankInGroup(GROUP_ID) >= ADMIN_RANK
end

if isAdmin(player) then
    -- Allow admin action
else
    -- Deny access
end
]]
        }
    }
}

-- Pattern Recognition
function PatternLearning:AnalyzeCode(code)
    local analysis = {
        patterns = {},
        antiPatterns = {},
        codeSmells = {},
        suggestions = {}
    }
    
    -- Detect common patterns
    for patternName, patternData in pairs(self.Database.CommonPatterns) do
        if string.find(code, patternData.pattern) then
            table.insert(analysis.patterns, {
                name = patternName,
                frequency = patternData.frequency,
                context = patternData.context
            })
        end
    end
    
    -- Detect anti-patterns
    for antiPatternName, antiPatternData in pairs(self.Database.AntiPatterns) do
        if string.find(code, antiPatternData.pattern) then
            table.insert(analysis.antiPatterns, {
                name = antiPatternName,
                severity = antiPatternData.severity,
                fix = antiPatternData.fix
            })
        end
    end
    
    -- Detect code smells
    analysis.codeSmells = self:DetectCodeSmells(code)
    
    -- Generate suggestions
    analysis.suggestions = self:GenerateSuggestions(analysis)
    
    return analysis
end

function PatternLearning:DetectCodeSmells(code)
    local smells = {}
    local lines = string.split(code, "\n")
    
    -- Check for long functions
    local functionStart = nil
    for i, line in ipairs(lines) do
        if string.match(line, "function%s+%w+") then
            functionStart = i
        elseif functionStart and string.match(line, "^end") then
            local functionLength = i - functionStart
            if functionLength > self.Database.CodeSmells.LongFunction.threshold then
                table.insert(smells, {
                    type = "LongFunction",
                    line = functionStart,
                    length = functionLength,
                    message = self.Database.CodeSmells.LongFunction.message
                })
            end
            functionStart = nil
        end
    end
    
    -- Check for deep nesting
    local maxNesting = 0
    local currentNesting = 0
    for _, line in ipairs(lines) do
        local opens = select(2, string.gsub(line, "if", ""))
        local closes = select(2, string.gsub(line, "end", ""))
        currentNesting = currentNesting + opens - closes
        maxNesting = math.max(maxNesting, currentNesting)
    end
    
    if maxNesting > self.Database.CodeSmells.DeepNesting.threshold then
        table.insert(smells, {
            type = "DeepNesting",
            depth = maxNesting,
            message = self.Database.CodeSmells.DeepNesting.message
        })
    end
    
    return smells
end

function PatternLearning:GenerateSuggestions(analysis)
    local suggestions = {}
    
    -- Suggest performance improvements
    if #analysis.patterns > 0 then
        for _, pattern in ipairs(analysis.patterns) do
            if pattern.context == "data_storage" then
                table.insert(suggestions, {
                    type = "performance",
                    suggestion = "Consider implementing data caching for frequently accessed data"
                })
            end
        end
    end
    
    -- Suggest security improvements
    for _, antiPattern in ipairs(analysis.antiPatterns) do
        if antiPattern.severity == "critical" or antiPattern.severity == "high" then
            table.insert(suggestions, {
                type = "security",
                suggestion = antiPattern.fix
            })
        end
    end
    
    -- Suggest code quality improvements
    for _, smell in ipairs(analysis.codeSmells) do
        table.insert(suggestions, {
            type = "quality",
            suggestion = smell.message
        })
    end
    
    return suggestions
end

-- Pattern Learning from User Code
function PatternLearning:LearnFromCode(code, context)
    local patterns = self:ExtractPatterns(code)
    
    -- Store patterns for future reference
    for _, pattern in ipairs(patterns) do
        self:StorePattern(pattern, context)
    end
    
    return patterns
end

function PatternLearning:ExtractPatterns(code)
    local patterns = {}
    
    -- Extract function definitions
    for func in string.gmatch(code, "function%s+([%w_]+)%s*%(([^)]*)%)") do
        table.insert(patterns, {
            type = "function",
            name = func,
            signature = func
        })
    end
    
    -- Extract variable declarations
    for var in string.gmatch(code, "local%s+([%w_]+)") do
        table.insert(patterns, {
            type = "variable",
            name = var
        })
    end
    
    -- Extract service calls
    for service in string.gmatch(code, "GetService%(%&quot;([%w_]+)%&quot;)") do
        table.insert(patterns, {
            type = "service",
            name = service
        })
    end
    
    return patterns
end

function PatternLearning:StorePattern(pattern, context)
    -- Store in DataStore for persistence
    local PatternStore = DataStoreService:GetDataStore("CodeAssist_Patterns")
    
    local success, err = pcall(function()
        PatternStore:UpdateAsync(pattern.type .. "_" .. pattern.name, function(oldData)
            oldData = oldData or {count = 0, contexts = {}}
            oldData.count = oldData.count + 1
            if context then
                table.insert(oldData.contexts, context)
            end
            return oldData
        end)
    end)
    
    if not success then
        warn("Failed to store pattern: " .. err)
    end
end

-- Pattern-Based Code Generation
function PatternLearning:GenerateCodeFromPattern(patternName, parameters)
    local pattern = self.Database.CommonPatterns[patternName]
    if not pattern then
        return nil, "Pattern not found"
    end
    
    -- Generate code based on pattern
    local code = self:ExpandPattern(pattern, parameters)
    
    return code
end

function PatternLearning:ExpandPattern(pattern, parameters)
    -- This would expand the pattern with the given parameters
    -- For now, return a basic implementation
    return "-- Pattern expansion for " .. pattern.pattern
end

-- Code Similarity Detection
function PatternLearning:FindSimilarCode(code, threshold)
    -- Find similar code patterns in the database
    local similar = {}
    
    -- This would implement similarity detection algorithms
    -- For now, return empty table
    
    return similar
end

-- Pattern Statistics
function PatternLearning:GetPatternStatistics()
    local stats = {
        totalPatterns = 0,
        mostCommon = {},
        leastCommon = {}
    }
    
    -- Count patterns
    for name, data in pairs(self.Database.CommonPatterns) do
        stats.totalPatterns = stats.totalPatterns + 1
        table.insert(stats.mostCommon, {name = name, frequency = data.frequency})
    end
    
    -- Sort by frequency
    table.sort(stats.mostCommon, function(a, b)
        return a.frequency > b.frequency
    end)
    
    return stats
end

-- Initialize Pattern Learning
function PatternLearning:Initialize()
    -- Load learned patterns from DataStore
    local PatternStore = DataStoreService:GetDataStore("CodeAssist_Patterns")
    
    local success, data = pcall(function()
        return PatternStore:GetAsync("learned_patterns")
    end)
    
    if success and data then
        -- Merge with existing database
        for patternName, patternData in pairs(data) do
            self.Database.CommonPatterns[patternName] = patternData
        end
    end
    
    print("Pattern Learning Module Initialized")
end

return PatternLearning
