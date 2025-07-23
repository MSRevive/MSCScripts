# Master Sword Rebirth AngelScript Architecture

## Table of Contents
1. [System Overview](#system-overview)
2. [Core Systems](#core-systems)
3. [Game Mechanics](#game-mechanics)
4. [Administrative Tools](#administrative-tools)
5. [Testing Framework](#testing-framework)
6. [File Organization](#file-organization)
7. [Integration Points](#integration-points)
8. [Development Workflow](#development-workflow)

## System Overview

Master Sword Rebirth utilizes AngelScript as its primary scripting engine for game logic, providing a powerful and flexible system for implementing game mechanics, administrative tools, and dynamic content. The AngelScript system is organized into several interconnected modules that work together to create a comprehensive game experience.

### Key Features
- **Modular Architecture**: Systems are separated into logical modules with clear interfaces
- **Event-Driven Design**: Uses event handlers and callbacks for system communication
- **Namespace Organization**: All systems are properly namespaced under `MS::`
- **Comprehensive Testing**: Full test suite with stress testing capabilities
- **Hot-Reload Support**: Scripts support pak file integration with include directives
- **Administrative Interface**: Complete admin command system with privilege levels

## Core Systems

### GameMaster System (`gamemaster/`)

The GameMaster system serves as the central coordinator for all server-wide game logic and events.

#### Key Components:
- **GameMaster.as** - Main coordinator class handling global events
- **GameMasterInit.as** - Initialization and engine integration
- **GameMasterData.as** - Data structures and constants
- **GameMasterUtils.as** - Utility functions
- **GameMasterEvents.as** - Event system interfaces
- **GameMasterSimple.as** - Simplified standalone version for testing

#### Purpose:
- Manages server-wide game state
- Coordinates between different game systems
- Handles player connection/disconnection events
- Manages monster death and treasure spawning
- Provides gold spew effects and delayed NPC creation
- Integrates with advanced trigger systems

#### Engine Integration Points:
```cpp
// Called by C++ engine
void game_master_init()        // Map start
void game_master_shutdown()    // Map end
void game_spawn()             // Legacy compatibility
```

### Player Management System (`player/`)

Handles all player-related functionality including admin privileges and statistics tracking.

#### Key Components:
- **PlayerManager.as** - Core player tracking and admin system
- **QuestItemIntegration.as** - Quest item handling
- **QuestTracker.as** - Quest progress tracking

#### Purpose:
- Track player connections and statistics
- Manage admin privilege system with configurable permissions
- Handle developer mode functionality
- Integrate with quest system for item management
- Provide player state synchronization

#### Admin Privilege Levels:
- `standard_rcon_cvar_` - Full administrative access
- `standard_cvar_` - Server configuration access
- `standard_` - Basic moderation commands

### World System (`world/`)

Manages environmental effects, dynamic lighting, and world state.

#### Key Components:
- **WorldSystem.as** - Environmental effects and lighting manager
- **SpawnSystem.as** - Entity spawning coordination
- **TreasureManager.as** - Treasure spawning and anti-farming
- **EntitySpawner.as** - Advanced entity creation
- **CriticalNPCManager.as** - Essential NPC management

#### Purpose:
- Dynamic lighting system with 16 configurable light slots
- Weather transitions and environmental effects
- Time-based ambient lighting (dawn, day, dusk, night)
- Wind effects and atmospheric changes
- Critical NPC tracking and respawn management
- Treasure spawning with anti-farming protection

#### Lighting System Features:
- 16 concurrent dynamic lights
- Per-entity light registration
- Color and radius customization
- Automatic cleanup and slot management

## Game Mechanics

### Magic System (`magic/`)

Comprehensive spell casting system with advanced features.

#### Key Components:
- **MagicSystem.as** - Core magic system manager
- **SpellRegistry.as** - Spell registration and player spell tracking
- **TestPotionOfForgetfulness.as** - Spell forgetting mechanics
- **MagicCombatTest.as** - Combat integration testing

#### Purpose:
- Spell registration and categorization (3 tiers of magic hand spells)
- Player spell learning and cooldown management
- Potion of Forgetfulness system for spell management
- Integration with combat system for damage calculation
- Magic hand spell categories with 34+ unique spells

#### Magic Hand Categories:
1. **Basic Combat Magic** (11 spells) - Fire ball, frost bolt, healing circle, etc.
2. **Advanced Combat Magic** (10 spells) - Lightning storm, poison cloud, summons, etc.
3. **Master Level Magic** (3 spells) - Volcano, turn undead, summon undead

#### Potion of Forgetfulness Features:
- Interactive menu system for spell selection
- Confirmation dialogs with screen fade effects
- Integration with admin commands for testing
- Player-specific spell tracking and management

### Combat System (`combat/`)

Advanced damage calculation and combat mechanics.

#### Key Components:
- **CombatSystem.as** - Core combat mechanics and damage processing

#### Purpose:
- Damage type system (physical, elemental, magic)
- Status effect management (poison, burn, freeze, etc.)
- Resistance and armor calculations
- Critical hit system with configurable multipliers
- Combat statistics tracking per player
- Integration with spell damage from magic system

#### Damage Types:
- Physical: Slash, Pierce, Blunt
- Elemental: Fire, Cold, Lightning, Poison, Acid
- Magical: Holy, Dark, Magic

#### Status Effects:
- Damage over Time: Poison, Burn
- Movement: Freeze, Slow, Haste
- Combat: Weaken, Strength, Shield
- Utility: Blind, Regeneration, Curse

### Trigger Systems (`triggers/`)

Advanced condition-based event triggering.

#### Key Components:
- **AdvancedTriggerSystem.as** - Complex condition parsing and evaluation
- **HPSequenceTrigger.as** - Health-based encounter triggers
- **TriggerSystemExample.as** - Usage examples and demonstrations

#### Purpose:
- Dynamic encounter scaling based on party composition
- Complex condition parsing with logical operators
- Party analysis (HP, race, class, allegiance)
- HP-based sequence triggers for boss encounters
- Integration with admin commands for testing

#### Trigger Filter Examples:
```
"totalhp>500&nplayers<4|race=human"  // High HP party or human players
"minlevel>10&hasclass=warrior"       // High level with warrior present
"!isenemy&avghp>75"                  // Allied party with good health
```

## Administrative Tools

### Admin System (`admin/`)

Comprehensive administrative interface with privilege-based command system.

#### Key Components:
- **AdminSystem.as** - Main admin command processor
- **CallExternalBridge.as** - External API integration
- **EntityCommunicationSystem.as** - Entity communication framework

#### Admin Command Categories:

**Spawn Management:**
- `addspawn` - Add spawn points at current location
- `listspawns` - Display all configured spawn points
- `testspawn <index>` - Teleport to specific spawn point
- `clearspawns` - Remove all spawn points (requires rcon)

**Player Management:**
- `kick <player> [reason]` - Kick player from server
- `ban <player> [duration] [reason]` - Ban player (requires rcon)
- `listplayers` - Show all connected players with admin status

**Developer Tools:**
- `devmode <on|off>` - Toggle developer mode (requires rcon)
- `setdev [player]` - Set developer player
- `testpotion` - Test Potion of Forgetfulness system

**Critical NPC Management:**
- `critnpc <list|register|remove|reset>` - Manage critical NPCs
- `respawnnpc <name> [x] [y] [z]` - Respawn critical NPC
- `npcstatus [clear]` - Display NPC status and death history

**Trigger System:**
- `testtrigger <filter>` - Test trigger filter conditions
- `createhpseq <name> [radius]` - Create HP sequence trigger
- `resethpseq <index|all>` - Reset HP sequence triggers
- `partyinfo` - Display detailed party analysis

**Magic System:**
- `testpotion` - Test Potion of Forgetfulness (dev only)
- `forgetspell <number>` - Select spell for forgetting
- `confirmforget` - Confirm spell forgetting
- `cancelforget` - Cancel spell forgetting process
- `listspells` - List learned spells (dev only)
- `learnspell <script>` - Learn specific spell (dev only)

**Treasure System:**
- `treasurestatus` - Display treasure system status
- `scrambletreasure` - Randomize all treasure lists
- `addtreasurespawn [x] [y] [z] [difficulty] [respawn_time]` - Add treasure spawn
- `respawntreasures` - Force respawn all treasures
- `clearfarmdata [player]` - Clear anti-farming data
- `generatetreasure [x] [y] [z] [difficulty]` - Generate treasure at location

**Utility Commands:**
- `teleport <x> <y> <z>` or `tp <player>` - Teleport functionality
- `god` - Toggle god mode (requires cvar privileges)
- `noclip` - Toggle noclip mode (requires cvar privileges)
- `give <player> <item> [amount]` - Give items to players
- `spawn <entity>` - Spawn entities
- `reload` - Reload server configuration
- `status` - Display server status
- `help [command]` - Display available commands

### Privilege System

Admin privileges are hierarchical and configurable:

- **rcon** - Full server control (ban, server config, critical systems)
- **cvar** - Server variable modification (game balance, spawning)
- **standard** - Basic moderation (kick, NPC management, triggers)

## Testing Framework

### Comprehensive Test Suite (`tests/`)

The testing framework provides extensive validation of all AngelScript systems.

#### Key Components:
- **MasterTestSuite.as** - Test coordinator and runner
- **EngineIntegrationTests.as** - Engine API validation
- **QuestSystemTests.as** - Quest system validation
- **NPCManagerTests.as** - NPC system testing
- **CommunicationTests.as** - Inter-system communication testing
- **PlayerManagementTests.as** - Player system validation
- **PerformanceTests.as** - Load testing and optimization
- **TestUtilities.as** - Common testing utilities

#### Test Categories:

**Comprehensive Testing:**
```cpp
RunAllAngelScriptTests()     // Full system validation
RunStressTests()             // Production readiness testing
RunRegressionTests()         // Previously failing scenarios
```

**Individual System Testing:**
```cpp
RunEngineTests()             // Engine integration
RunQuestTests()              // Quest system
RunNPCTests()                // NPC management
RunTriggerTests()            // Trigger systems
RunCommunicationTests()      // System communication
RunPlayerTests()             // Player management
RunPerformanceTests()        // Performance validation
```

**Quick Validation:**
```cpp
RunQuickValidation()         // Essential systems only
```

#### Test Features:
- Automated test execution with detailed reporting
- Stress testing for production readiness assessment
- Performance benchmarking and memory pressure testing
- Success rate calculation and quality assessment
- Individual test result tracking with timing information

## File Organization

```
MSCScripts/scripts/angelscript/
├── gamemaster/                 # Core game coordination
│   ├── GameMaster.as          # Main coordinator
│   ├── GameMasterInit.as      # Initialization
│   ├── GameMasterData.as      # Data structures
│   ├── GameMasterUtils.as     # Utilities
│   ├── GameMasterEvents.as    # Event system
│   ├── GameMasterSimple.as    # Testing version
│   └── GameMasterTest.as      # Unit tests
├── player/                     # Player management
│   ├── PlayerManager.as       # Core player system
│   ├── QuestItemIntegration.as# Quest integration
│   └── QuestTracker.as        # Quest tracking
├── world/                      # World systems
│   ├── WorldSystem.as         # Environment/lighting
│   ├── SpawnSystem.as         # Entity spawning
│   ├── TreasureManager.as     # Treasure system
│   ├── EntitySpawner.as       # Advanced spawning
│   └── CriticalNPCManager.as  # Critical NPCs
├── magic/                      # Magic system
│   ├── MagicSystem.as         # Core magic
│   ├── SpellRegistry.as       # Spell management
│   ├── TestPotionOfForgetfulness.as
│   └── MagicCombatTest.as     # Combat integration
├── combat/                     # Combat mechanics
│   └── CombatSystem.as        # Damage/status effects
├── triggers/                   # Trigger systems
│   ├── AdvancedTriggerSystem.as # Complex conditions
│   ├── HPSequenceTrigger.as   # HP-based triggers
│   └── TriggerSystemExample.as# Usage examples
├── admin/                      # Administrative tools
│   ├── AdminSystem.as         # Command processor
│   ├── CallExternalBridge.as  # External APIs
│   ├── EntityCommunicationSystem.as
│   └── EntityCommunicationInit.as
└── tests/                      # Testing framework
    ├── MasterTestSuite.as     # Test coordinator
    ├── EngineIntegrationTests.as
    ├── QuestSystemTests.as
    ├── NPCManagerTests.as
    ├── CommunicationTests.as
    ├── PlayerManagementTests.as
    ├── PerformanceTests.as
    └── TestUtilities.as

Root Level Test Files:
├── test_angelscript_simple.as  # Basic AngelScript test
├── test_include_test.as        # Include functionality test
└── test_common.as             # Common test functions
```

## Integration Points

### Engine to AngelScript

The C++ engine integrates with AngelScript through several key interfaces:

#### Core Engine Functions (provided by C++):
```cpp
// Entity Management
CBasePlayer@ GetPlayerByIndex(int index)
array<CBasePlayer@>@ GetAllPlayers()
int GetPlayerCount()

// Server Functions
string GetCvar(const string &in name)
string GetMapName()
float GetGameTime()
string GetTimestamp()

// Event Registration
void RegisterEngineEvent(const string &in eventName, function@ callback)

// Logging
void LogMessage(const string &in message)
void DeveloperMessage(int level, const string &in message)

// Math/Utility
float Random(float min, float max)
int RandomInt(int min, int max)
Vector3 CreateVector(float x, float y, float z)
```

#### AngelScript to Engine Events:
```cpp
// Map Lifecycle
void game_master_init()          // Called when map starts
void game_master_shutdown()      // Called when map ends
void game_spawn()               // Legacy compatibility

// Player Events
void OnEnginePlayerConnect(const string &in name, const string &in steamID)
void OnEnginePlayerDisconnect(const string &in name, const string &in steamID)

// Game Events
void OnEngineMonsterKilled(const string &in monster, const string &in killer, const Vector3 &in pos)
void OnEngineTreasureSpawned(const string &in type, const Vector3 &in pos)
```

### Pak File Integration

The system supports pak file integration for script modularity:

```cpp
#include "gamemaster/GameMasterData.as"
#include "magic/SpellRegistry.as"
#include "combat/CombatSystem.as"
```

This allows for:
- Modular script development
- Hot-reloading of script changes
- Proper dependency management
- Namespace organization

### Error Handling and Validation

The system includes comprehensive error handling:

#### Environment Validation:
- Engine API availability checking
- Namespace conflict detection
- Include dependency validation
- System initialization verification

#### Runtime Error Handling:
- Null pointer checking for all entity operations
- Parameter validation for all public functions
- Graceful degradation when systems are unavailable
- Comprehensive logging for debugging

## Development Workflow

### Setting Up Development Environment

1. **AngelScript Integration**: Ensure the C++ engine has AngelScript properly integrated
2. **Pak File Support**: Configure pak file loading for include directives
3. **Logging System**: Set up engine logging integration for script debugging
4. **Test Environment**: Initialize the testing framework for validation

### Development Process

1. **System Design**: Plan new features within the existing namespace structure
2. **Implementation**: Develop in the appropriate module directory
3. **Testing**: Use the comprehensive test suite for validation
4. **Integration**: Test with other systems using the trigger and event systems
5. **Documentation**: Update this architecture document as needed

### Testing Strategy

#### Development Testing:
```cpp
InitializeTestSuite()        // Initialize test framework
RunQuickValidation()         // Fast development testing
RunEngineTests()            // Test specific systems
```

#### Pre-Production Testing:
```cpp
RunAllAngelScriptTests()     // Comprehensive validation
RunStressTests()             // Load testing
RunRegressionTests()         // Stability verification
```

#### Production Monitoring:
- Monitor script performance through the testing framework
- Use admin commands for live debugging
- Leverage the comprehensive logging system for issue tracking

### Best Practices

1. **Namespace Usage**: Always use the `MS::` namespace for game systems
2. **Error Handling**: Check for null entities and invalid parameters
3. **Logging**: Use appropriate log levels (Info, Warning, Error, Debug)
4. **Testing**: Write tests for all new functionality
5. **Documentation**: Update comments and architecture documentation
6. **Integration**: Use the event system for inter-system communication
7. **Performance**: Leverage caching systems where appropriate (e.g., party analysis cache)

### Debugging Tools

#### Admin Commands for Debugging:
- `devmode on` - Enable detailed logging and developer features
- `status` - Check system health and statistics
- `partyinfo` - Analyze current party composition for trigger testing
- `testtrigger` - Test trigger filter conditions
- `npcstatus` - Check critical NPC states
- `treasurestatus` - Verify treasure system operation

#### Test Framework for Validation:
- Individual system test runners for focused debugging
- Performance tests for optimization
- Stress tests for load validation
- Comprehensive reporting for issue identification

This architecture provides a robust, scalable, and maintainable foundation for Master Sword Rebirth's scripting system, enabling rich gameplay experiences while maintaining code quality and system reliability.