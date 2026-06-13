--[[
    CodeAssist Utilities Module
    Helper functions and utilities for the plugin
]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Utilities = {}

-- String Utilities
function Utilities:Trim(str)
    return string.match(str, "^%s*(.-)%s*$") or str
end

function Utilities:Split(str, delimiter)
    local result = {}
    for match in string.gmatch(str, "([^" .. delimiter .. "]+)") do
        table.insert(result, match)
    end
    return result
end

function Utilities:Join(tbl, delimiter)
    return table.concat(tbl, delimiter)
end

function Utilities:StartsWith(str, prefix)
    return string.sub(str, 1, #prefix) == prefix
end

function Utilities:EndsWith(str, suffix)
    return string.sub(str, -#suffix) == suffix
end

function Utilities:Contains(str, substring)
    return string.find(str, substring, 1, true) ~= nil
end

function Utilities:Replace(str, pattern, replacement)
    return string.gsub(str, pattern, replacement)
end

function Utilities:Format(str, ...)
    local args = {...}
    return string.gsub(str, "{(%d+)}", function(i)
        return args[tonumber(i) + 1] or ""
    end)
end

-- Table Utilities
function Utilities:ShallowCopy(tbl)
    local copy = {}
    for k, v in pairs(tbl) do
        copy[k] = v
    end
    return copy
end

function Utilities:DeepCopy(tbl)
    if type(tbl) ~= "table" then
        return tbl
    end
    
    local copy = {}
    for k, v in pairs(tbl) do
        copy[Utilities:DeepCopy(k)] = Utilities:DeepCopy(v)
    end
    return copy
end

function Utilities:Merge(tbl1, tbl2)
    local merged = Utilities:ShallowCopy(tbl1)
    for k, v in pairs(tbl2) do
        merged[k] = v
    end
    return merged
end

function Utilities:Keys(tbl)
    local keys = {}
    for k, _ in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

function Utilities:Values(tbl)
    local values = {}
    for _, v in pairs(tbl) do
        table.insert(values, v)
    end
    return values
end

function Utilities:Length(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

function Utilities:ContainsKey(tbl, key)
    return tbl[key] ~= nil
end

function Utilities:ContainsValue(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

function Utilities:Filter(tbl, predicate)
    local filtered = {}
    for k, v in pairs(tbl) do
        if predicate(v, k) then
            filtered[k] = v
        end
    end
    return filtered
end

function Utilities:Map(tbl, mapper)
    local mapped = {}
    for k, v in pairs(tbl) do
        mapped[k] = mapper(v, k)
    end
    return mapped
end

function Utilities:Reduce(tbl, reducer, initial)
    local result = initial
    for k, v in pairs(tbl) do
        result = reducer(result, v, k)
    end
    return result
end

-- Math Utilities
function Utilities:Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function Utilities:Lerp(a, b, t)
    return a + (b - a) * t
end

function Utilities:RandomFloat(min, max)
    return math.random() * (max - min) + min
end

function Utilities:RandomInt(min, max)
    return math.random(min, max)
end

function Utilities:Round(value, decimals)
    local mult = 10 ^ (decimals or 0)
    return math.floor(value * mult + 0.5) / mult
end

function Utilities:Distance(point1, point2)
    return (point1 - point2).Magnitude
end

function Utilities:AngleBetween(vector1, vector2)
    return math.acos(vector1.Unit:Dot(vector2.Unit))
end

-- Time Utilities
function Utilities:Wait(seconds)
    task.wait(seconds)
end

function Utilities:Delay(seconds, callback)
    task.delay(seconds, callback)
end

function Utilities:Spawn(callback)
    task.spawn(callback)
end

function Utilities:GetTimestamp()
    return os.time()
end

function Utilities:FormatTimestamp(timestamp, format)
    return os.date(format or "%Y-%m-%d %H:%M:%S", timestamp)
end

function Utilities:GetElapsedTime(startTime)
    return os.time() - startTime
end

-- Validation Utilities
function Utilities:IsValidString(str)
    return type(str) == "string" and #str > 0
end

function Utilities:IsValidNumber(num)
    return type(num) == "number" and not (num ~= num) -- Check for NaN
end

function Utilities:IsValidTable(tbl)
    return type(tbl) == "table"
end

function Utilities:IsValidFunction(func)
    return type(func) == "function"
end

function Utilities:IsValidInstance(instance)
    return typeof(instance) == "Instance"
end

function Utilities:IsNil(value)
    return value == nil
end

function Utilities:IsEmpty(value)
    if value == nil then
        return true
    elseif type(value) == "string" then
        return #value == 0
    elseif type(value) == "table" then
        return next(value) == nil
    end
    return false
end

-- Instance Utilities
function Utilities:FindFirstChildOfClass(parent, className)
    for _, child in ipairs(parent:GetChildren()) do
        if child.ClassName == className then
            return child
        end
    end
    return nil
end

function Utilities:FindFirstChildWithName(parent, name)
    for _, child in ipairs(parent:GetChildren()) do
        if child.Name == name then
            return child
        end
    end
    return nil
end

function Utilities:GetAllDescendantsOfClass(parent, className)
    local descendants = {}
    for _, descendant in ipairs(parent:GetDescendants()) do
        if descendant.ClassName == className then
            table.insert(descendants, descendant)
        end
    end
    return descendants
end

function Utilities:DestroyChildren(parent)
    for _, child in ipairs(parent:GetChildren()) do
        child:Destroy()
    end
end

function Utilities:CloneInstance(instance)
    return instance:Clone()
end

function Utilities:SetProperties(instance, properties)
    for property, value in pairs(properties) do
        if instance[property] ~= nil then
            instance[property] = value
        end
    end
end

-- Player Utilities
function Utilities:GetPlayerByName(name)
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name == name or player.DisplayName == name then
            return player
        end
    end
    return nil
end

function Utilities:GetPlayerById(userId)
    return Players:GetPlayerByUserId(userId)
end

function Utilities:GetPlayersInGroup(groupId)
    local playersInGroup = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player:IsInGroup(groupId) then
            table.insert(playersInGroup, player)
        end
    end
    return playersInGroup
end

function Utilities:IsPlayerAdmin(player, groupId, adminRank)
    return player:GetRankInGroup(groupId) >= adminRank
end

function Utilities:GetPlayerCharacter(player)
    return player.Character
end

function Utilities:TeleportPlayer(player, position)
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(position)
        end
    end
end

-- Code Utilities
function Utilities:CountLines(code)
    local count = 0
    for _ in string.gmatch(code, "\n") do
        count = count + 1
    end
    return count + 1
end

function Utilities:RemoveComments(code)
    -- Remove single-line comments
    code = string.gsub(code, "--[^\n]*", "")
    -- Remove multi-line comments
    code = string.gsub(code, "%-%-%[%[.-%]%]", "")
    return code
end

function Utilities:FormatCode(code)
    -- Basic code formatting
    code = Utilities:Trim(code)
    code = string.gsub(code, "\n%s*\n", "\n") -- Remove empty lines
    code = string.gsub(code, "%s+", " ") -- Normalize whitespace
    return code
end

function Utilities:ExtractFunctions(code)
    local functions = {}
    for func, params in string.gmatch(code, "function%s+([%w_]+)%s*%(([^)]*)%)") do
        table.insert(functions, {
            name = func,
            parameters = params
        })
    end
    return functions
end

function Utilities:ExtractVariables(code)
    local variables = {}
    for var in string.gmatch(code, "local%s+([%w_]+)") do
        table.insert(variables, var)
    end
    return variables
end

function Utilities:ExtractServices(code)
    local services = {}
    for service in string.gmatch(code, 'GetService%("([^"]+)"%)') do
        table.insert(services, service)
    end
    return services
end

-- JSON Utilities
function Utilities:EncodeJSON(data)
    local success, result = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    return success and result or nil
end

function Utilities:DecodeJSON(jsonString)
    local success, result = pcall(function()
        return HttpService:JSONDecode(jsonString)
    end)
    return success and result or nil
end

-- HTTP Utilities
function Utilities:HTTPRequest(url, method, headers, body)
    local success, result = pcall(function()
        return HttpService:RequestAsync({
            Url = url,
            Method = method or "GET",
            Headers = headers or {},
            Body = body
        })
    end)
    return success and result or nil
end

function Utilities:HTTPGet(url, headers)
    return Utilities:HTTPRequest(url, "GET", headers)
end

function Utilities:HTTPPost(url, headers, body)
    return Utilities:HTTPRequest(url, "POST", headers, body)
end

-- Debug Utilities
function Utilities:Log(message, level)
    level = level or "info"
    local timestamp = Utilities:FormatTimestamp(Utilities:GetTimestamp())
    print(string.format("[%s] [%s] %s", timestamp, string.upper(level), message))
end

function Utilities:Warn(message)
    Utilities:Log(message, "warn")
end

function Utilities:Error(message)
    Utilities:Log(message, "error")
end

function Utilities:Debug(message)
    Utilities:Log(message, "debug")
end

function Utilities:Assert(condition, message)
    if not condition then
        error(message or "Assertion failed")
    end
end

-- Performance Utilities
function Utilities:StartPerformanceTimer()
    return tick()
end

function Utilities:EndPerformanceTimer(startTime)
    return tick() - startTime
end

function Utilities:MeasurePerformance(callback)
    local startTime = Utilities:StartPerformanceTimer()
    local result = callback()
    local elapsed = Utilities:EndPerformanceTimer(startTime)
    return result, elapsed
end

-- Debounce Utility
function Utilities:CreateDebounce(delay)
    local lastCall = 0
    return function(callback)
        local currentTime = tick()
        if currentTime - lastCall >= delay then
            lastCall = currentTime
            return callback()
        end
        return nil
    end
end

-- Throttle Utility
function Utilities:CreateThrottle(delay)
    local lastCall = 0
    local queuedCallback = nil
    
    return function(callback)
        queuedCallback = callback
        local currentTime = tick()
        
        if currentTime - lastCall >= delay then
            lastCall = currentTime
            if queuedCallback then
                local cb = queuedCallback
                queuedCallback = nil
                return cb()
            end
        else
            return nil
        end
    end
end

-- Retry Utility
function Utilities:Retry(callback, maxAttempts, delay)
    maxAttempts = maxAttempts or 3
    delay = delay or 1
    
    for attempt = 1, maxAttempts do
        local success, result = pcall(callback)
        if success then
            return true, result
        end
        
        if attempt < maxAttempts then
            Utilities:Wait(delay)
        end
    end
    
    return false, "Max retry attempts reached"
end

-- Cache Utility
function Utilities:CreateCache(ttl)
    local cache = {}
    local timestamps = {}
    ttl = ttl or 300 -- 5 minutes default
    
    local function cleanup()
        local currentTime = Utilities:GetTimestamp()
        for key, timestamp in pairs(timestamps) do
            if currentTime - timestamp > ttl then
                cache[key] = nil
                timestamps[key] = nil
            end
        end
    end
    
    return {
        get = function(key)
            cleanup()
            return cache[key]
        end,
        set = function(key, value)
            cache[key] = value
            timestamps[key] = Utilities:GetTimestamp()
        end,
        clear = function()
            cache = {}
            timestamps = {}
        end,
        has = function(key)
            cleanup()
            return cache[key] ~= nil
        end
    }
end

-- UUID Generator
function Utilities:GenerateUUID()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    return string.gsub(template, "[xy]", function(c)
        local v = (c == "x") and math.random(0, 15) or math.random(8, 11)
        return string.format("%x", v)
    end)
end

-- Hash Function (Simple)
function Utilities:SimpleHash(str)
    local hash = 0
    for i = 1, #str do
        hash = (hash * 31 + string.byte(str, i)) % 4294967296
    end
    return hash
end

-- Color Utilities
function Utilities:HexToRGB(hex)
    hex = string.gsub(hex, "#", "")
    local r = tonumber(string.sub(hex, 1, 2), 16) / 255
    local g = tonumber(string.sub(hex, 3, 4), 16) / 255
    local b = tonumber(string.sub(hex, 5, 6), 16) / 255
    return Color3.fromRGB(r * 255, g * 255, b * 255)
end

function Utilities:RGBToHex(color)
    return string.format("#%02X%02X%02X", 
        math.floor(color.R * 255), 
        math.floor(color.G * 255), 
        math.floor(color.B * 255)
    )
end

function Utilities:BlendColors(color1, color2, t)
    local r = Utilities:Lerp(color1.R, color2.R, t)
    local g = Utilities:Lerp(color1.G, color2.G, t)
    local b = Utilities:Lerp(color1.B, color2.B, t)
    return Color3.fromRGB(r * 255, g * 255, b * 255)
end

-- Version Comparison
function Utilities:CompareVersions(version1, version2)
    local v1Parts = Utilities:Split(version1, ".")
    local v2Parts = Utilities:Split(version2, ".")
    
    for i = 1, math.max(#v1Parts, #v2Parts) do
        local v1 = tonumber(v1Parts[i]) or 0
        local v2 = tonumber(v2Parts[i]) or 0
        
        if v1 > v2 then
            return 1
        elseif v1 < v2 then
            return -1
        end
    end
    
    return 0
end

-- File Path Utilities
function Utilities:GetFileName(path)
    return string.match(path, "([^/\\]+)$") or path
end

function Utilities:GetFileExtension(path)
    return string.match(path, "%.([^%.]+)$") or ""
end

function Utilities:GetDirectory(path)
    return string.match(path, "(.-)[/\\][^/\\]+$") or ""
end

-- Safe Call Utility
function Utilities:SafeCall(callback, errorHandler)
    local success, result = pcall(callback)
    if not success and errorHandler then
        errorHandler(result)
    end
    return success, result
end

-- Async Utilities
function Utilities:Asyncify(callback)
    return function(...)
        local args = {...}
        return task.spawn(function()
            callback(unpack(args))
        end)
    end
end

function Utilities:Promise(callback)
    local promise = {
        state = "pending",
        value = nil,
        reason = nil,
        callbacks = {
            resolve = {},
            reject = {}
        }
    }
    
    local function resolve(value)
        if promise.state ~= "pending" then return end
        promise.state = "fulfilled"
        promise.value = value
        for _, cb in ipairs(promise.callbacks.resolve) do
            cb(value)
        end
    end
    
    local function reject(reason)
        if promise.state ~= "pending" then return end
        promise.state = "rejected"
        promise.reason = reason
        for _, cb in ipairs(promise.callbacks.reject) do
            cb(reason)
        end
    end
    
    task.spawn(function()
        local success, result = pcall(callback)
        if success then
            resolve(result)
        else
            reject(result)
        end
    end)
    
    return {
        andThen = function(onResolve, onReject)
            if promise.state == "fulfilled" then
                onResolve(promise.value)
            elseif promise.state == "rejected" then
                if onReject then onReject(promise.reason) end
            else
                table.insert(promise.callbacks.resolve, onResolve)
                if onReject then
                    table.insert(promise.callbacks.reject, onReject)
                end
            end
            return promise
        end,
        catch = function(onReject)
            return promise:andThen(nil, onReject)
        end
    }
end

return Utilities
