--[[
    CodeAssist Advanced AI Module
    Real AI-powered code generation using Groq API for complex Roblox development
]]

local HttpService = game:GetService("HttpService")

local AdvancedAI = {}

-- AI Configuration
AdvancedAI.Config = {
    apiUrl = "https://api.groq.com/openai/v1/chat/completions",
    model = "llama-3.1-70b-versatile",
    temperature = 0.7,
    maxTokens = 8192,
    topP = 0.9
}

-- Load API key from settings
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

-- Enhanced System Prompt for Roblox Expert AI
function AdvancedAI:BuildExpertSystemPrompt()
    return [[You are the world's foremost Roblox development expert with 15+ years of experience. You have worked on:
- Top Roblox games with 10M+ daily active users
- Enterprise-scale systems handling millions of concurrent players
- Roblox internal tools and platform development
- Teaching Roblox development at universities
- Creating best practices adopted by the entire community

Your expertise encompasses:

ULTIMATE ROBLOX PLATFORM MASTERY:
- Every single Roblox service (70+ services) with API-level precision
- All classes, methods, properties, events, enums, and their behaviors
- Internal Roblox engine knowledge and limitations
- undocumented APIs and advanced techniques
- Memory management and garbage collection internals
- Network replication deep understanding
- Physics engine behavior at scale
- Rendering pipeline optimization
- Cross-platform performance characteristics
- Studio internal architecture and tooling

GAME DEVELOPMENT EXCELLENCE:
- Architectural patterns for 100M+ player games
- Distributed systems across multiple servers
- Real-time synchronization at global scale
- Advanced combat systems with netcode prediction
- Economy design and anti-manipulation
- Social systems and community management
- Content delivery networks for assets
- Analytics and telemetry systems
- A/B testing frameworks for game features
- Live operations and event systems

CODING SUPREMACY:
- Lua optimization at assembly level understanding
- Advanced metaprogramming techniques
- Memory pool management and object pooling
- Custom physics implementations
- Network protocol design
- Security architecture and threat modeling
- Performance profiling and optimization
- Debugging complex race conditions
- Code architecture for massive codebases
- Testing strategies for distributed systems

DEEP ROBLOX TECHNICAL KNOWLEDGE:
- DataStoreService: Session locking, quotas, sharding strategies
- MessagingService: Pub/Sub patterns, cross-server coordination
- MemoryStoreService: Caching strategies, TTL optimization
- TeleportService: Seamless transitions, data preservation
- PhysicsService: Custom constraints, collision optimization
- PathfindingService: Advanced navigation, dynamic environments
- AnimationService: Custom rigs, compression techniques
- VoiceChatService: Integration and optimization
- InputService: Advanced input handling and buffering
- ContextActionService: Mobile optimization

INDUSTRY INSIGHTS:
- Roblox platform roadmap and upcoming features
- Performance bottlenecks in the engine
- Security vulnerabilities and mitigation strategies
- Monetization optimization techniques
- User retention psychology and implementation
- Community management at scale
- Content moderation systems
- Anti-cheat techniques used by top games
- Server cost optimization strategies
- Player behavior analytics

CODE GENERATION PRINCIPLES:
1. Write code as if it will be reviewed by Roblox engineers
2. Include performance metrics and optimization notes
3. Add memory usage analysis in comments
4. Document network bandwidth implications
5. Include fallback strategies for edge cases
6. Add monitoring and telemetry hooks
7. Consider mobile device limitations
8. Implement graceful degradation
9. Add comprehensive error recovery
10. Include scalability projections

ADVANCED PATTERNS TO USE:
- Object pooling for all dynamic instances
- Spatial partitioning for spatial queries
- Event sourcing for state management
- CQRS for read/write separation
- Circuit breakers for external dependencies
- Rate limiting with token buckets
- Exponential backoff for retries
- Idempotent operations for safety
- Optimistic UI updates
- Delta compression for network updates

PERFORMANCE OPTIMIZATIONS:
- Minimize WaitForChild calls in hot paths
- Use attribute-based systems instead of instance chains
- Implement custom replication for critical data
- Use StreamingEnabled strategically
- Optimize UI with efficient layouts
- Batch remote calls when possible
- Use efficient data structures (arrays vs tables)
- Implement LOD (Level of Detail) systems
- Use physics sub-stepping for stability
- Optimize terrain and mesh usage

SECURITY MANDATES:
- Validate ALL client input on server
- Use server authoritative game logic
- Implement proper access control
- Rate limit all sensitive operations
- Sanitize all user-generated content
- Use encryption for sensitive data
- Implement proper session management
- Add audit logging for critical actions
- Use secure random number generation
- Implement proper data isolation

When generating code, think like you're building the next billion-dollar Roblox game. Every decision should consider scale, performance, security, and maintainability. Explain your architectural decisions when relevant.
]]
end

-- Real AI Code Generation
function AdvancedAI:GenerateFullGame(gameDescription, requirements)
    local systemPrompt = self:BuildExpertSystemPrompt()
    
    local userPrompt = string.format([[
Generate a complete, production-ready Roblox game based on this description:

GAME DESCRIPTION:
%s

REQUIREMENTS:
%s

Generate the ENTIRE game code including:
1. Server-side scripts (all game logic)
2. Client-side scripts (UI, controls, effects)
3. Module scripts (reusable systems)
4. Data structure and storage
5. Network communication setup
6. UI/UX implementation
7. Audio integration
8. Performance optimizations
9. Security measures
10. Error handling and logging

Provide the code in a well-organized structure with clear file names and purposes. Each script should be complete and ready to use.
]], gameDescription, requirements or "Standard Roblox game requirements")
    
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

-- Generate Specific System with AI
function AdvancedAI:GenerateSystem(systemType, specifications)
    local systemPrompt = self:BuildExpertSystemPrompt()
    
    local userPrompt = string.format([[
Generate a complete, enterprise-grade %s system for Roblox with these specifications:

SYSTEM TYPE: %s
SPECIFICATIONS: %s

Requirements:
1. Complete implementation with all necessary components
2. Server-side and client-side code where applicable
3. Proper error handling and edge cases
4. Performance optimization
5. Security considerations
6. Scalability for large player counts
7. Comprehensive comments
8. Production-ready code quality

Provide the full code implementation that can be directly used in a professional Roblox game.
]], systemType, systemType, specifications or "Standard professional requirements")
    
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

-- Generate Complete Game Architecture
function AdvancedAI:GenerateGameArchitecture(gameConcept)
    local systemPrompt = self:BuildExpertSystemPrompt()
    
    local userPrompt = string.format([[
Design and generate the complete architecture for a Roblox game:

GAME CONCEPT:
%s

Provide:
1. Overall system architecture
2. Service breakdown and responsibilities
3. Data flow diagrams (in text)
4. Network communication strategy
5. Security architecture
6. Scalability plan
7. Performance optimization strategy
8. Code organization structure
9. Implementation priorities
10. Risk mitigation strategies

Then generate the core implementation code for the most critical systems.
]], gameConcept)
    
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

-- AI Code Review and Improvement
function AdvancedAI:ReviewAndImproveCode(code, focusAreas)
    local systemPrompt = self:BuildExpertSystemPrompt()
    
    local userPrompt = string.format([[
Review and improve this Roblox Lua code:

CODE:
%s

FOCUS AREAS: %s

Provide:
1. Detailed code review identifying issues
2. Security vulnerabilities and fixes
3. Performance optimizations
4. Best practices violations
5. Improved version of the code
6. Explanation of all changes
7. Additional recommendations

Be thorough and critical. This is for a production game.
]], code, focusAreas or "security, performance, best practices")
    
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

-- Generate Multiplayer Architecture
function AdvancedAI:GenerateMultiplayerArchitecture(playerCount, gameType)
    local systemPrompt = self:BuildExpertSystemPrompt()
    
    local userPrompt = string.format([[
Design a complete multiplayer architecture for a Roblox game:

TARGET PLAYERS: %s
GAME TYPE: %s

Provide:
1. Server architecture (single vs multiple servers)
2. Data synchronization strategy
3. Network communication patterns
4. Latency handling techniques
5. Anti-cheat measures
6. Load balancing strategy
7. Cross-server communication
8. Player state management
9. Event handling at scale
10. Disaster recovery

Generate implementation code for the core networking systems.
]], playerCount, gameType)
    
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

-- Generate Monetization System
function AdvancedAI:GenerateMonetizationSystem(monetizationType, targetRevenue)
    local systemPrompt = self:BuildExpertSystemPrompt()
    
    local userPrompt = string.format([[
Design and implement a complete monetization system:

MONETIZATION TYPE: %s
TARGET REVENUE MODEL: %s

Include:
1. Robux integration
2. Game passes implementation
3. Developer products
4. Premium features
5. Subscription systems
6. Analytics and tracking
7. A/B testing framework
8. User retention strategies
9. Compliance with Roblox TOS
10. Anti-abuse measures

Generate complete, production-ready code.
]], monetizationType, targetRevenue)
    
    return self:CallGroqAPI(systemPrompt, userPrompt)
end

-- Call Groq API
function AdvancedAI:CallGroqAPI(systemPrompt, userPrompt)
    if not self.Config.apiKey then
        self:LoadConfig()
    end
    
    if not self.Config.apiKey then
        return nil, "API key not configured. Please set your Groq API key in settings."
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

-- Set API key
function AdvancedAI:SetAPIKey(apiKey)
    self.Config.apiKey = apiKey
    local Plugin = plugin or getfenv().plugin
    if Plugin then
        pcall(function()
            Plugin:SetSetting("CodeAssist_APIKey", apiKey)
        end)
    end
end

-- Get configuration
function AdvancedAI:GetConfig()
    return self.Config
end

-- Update configuration
function AdvancedAI:UpdateConfig(newConfig)
    for key, value in pairs(newConfig) do
        self.Config[key] = value
    end
end

return AdvancedAI
