# AngelScript GameMaster Conversion

This directory contains the converted AngelScript version of the Master Sword Rebirth game_master.script system.

## Files Created

### 1. GameMaster.as
The main GameMaster class that manages server-wide game logic. Key features:
- **Spawn Management**: Handles entity spawning and initialization
- **Gold Spew System**: Manages post-mortem gold bag distribution
- **Time Synchronization**: Maintains server time and periodic updates
- **Event Handling**: Processes game events like player connections, monster deaths
- **Delayed NPC Creation**: Supports up to 4 delayed NPC spawn slots
- **Entity Fading**: Manages entity fade-out effects
- **Light System**: Manages dynamic lighting (16 light slots)

### 2. GameMasterData.as
Data structures and constants converted from the original script:
- **Magic Hand Scripts**: Arrays of magic hand spell scripts and names (3 groups)
- **Constants**: Spawn counts, light system limits, fade rates
- **Data Structures**: NPC spawn data, light system data, damage tracking
- **Global Accessors**: Functions to manage global game state
- **Utility Functions**: Magic hand script lookups and management

### 3. GameMasterEvents.as
Event system interfaces and event management:
- **Event Interfaces**: IGameMasterEvents, IMapTransitionEvents, IVoteEvents, IDamageEvents
- **Event Data Structures**: Detailed event data classes for logging and processing
- **Event Manager**: Central event dispatcher and listener management
- **Helper Functions**: Broadcasting, logging, event utilities

### 4. GameMasterUtils.as
Utility functions that bridge legacy script functions to AngelScript:
- **Time Functions**: Game time, scheduling, timestamps
- **Entity Management**: Entity creation, finding, player management
- **Server Functions**: CVars, commands, server state checks
- **Math Utilities**: Vector operations, random numbers, angle conversions
- **Logging**: Structured logging functions (Info, Error, Debug, Warning)
- **Legacy Compatibility**: Variable management functions (setvard, setvarg, etc.)

## Conversion Summary

### From Original game_master.script (Lines 1-100):

**Global Variables Converted:**
- `MAGIC_HAND_SCRIPTS1/2/3` → Arrays in GameMasterData.as
- `MAGIC_HAND_NAMES1/2/3` → Arrays in GameMasterData.as
- `CONST_SPAWNS_PER_SET` → Constant in GameMasterData.as
- `LIGHTSYS_N_LIGHTS` → Constant in GameMasterData.as
- `N_MALDORAS`, `MALDORA_LIST` → Class members in GameMaster.as
- `DEMON_RAGE_USERS/USES` → Class members in GameMaster.as

**Initialization Logic Converted:**
- Array creation and initialization → Constructor logic
- Light system setup → Private member initialization
- Global variable setup → Class-based state management

**Spawn Logic Converted (Lines 46-100):**
- Entity properties setup → Spawn() method
- Server-side checks → IsServer() calls
- Game master registration → Global state management
- Chat logging initialization → InitializeChatLog() method
- Time synchronization setup → TimeSyncCheck() method
- Development mode checking → IsCentralServer() check

## Key Improvements

1. **Object-Oriented Design**: Converted from global script to class-based architecture
2. **Type Safety**: Strong typing with AngelScript type system
3. **Encapsulation**: Private/public members with proper data hiding
4. **Event System**: Structured event handling with interfaces
5. **Logging Integration**: MSLogger integration with proper log levels
6. **Memory Management**: AngelScript automatic memory management
7. **Error Handling**: Proper error checking and logging
8. **Documentation**: Comprehensive inline documentation

## Integration Points

These files are designed to integrate with:
- **AngelScript Engine**: Core types (Vector3, EntityHandle, etc.)
- **MSLogger System**: Structured logging with categories
- **Game Engine**: Entity system, player management, server commands
- **Legacy Script System**: Compatibility layer for existing scripts

### 5. MagicSystem.as
**Core magic system for Master Sword Rebirth**:
- **Spell Management**: Handles spell registration, casting mechanics, and magic interactions
- **Magic Hand Integration**: Implements the magic hand spell system from lines 4-11 of game_master.script
- **Spell Categories**: Organizes spells into 3 categories (Basic, Advanced, Master Level)
- **Casting Mechanics**: Handles preparation time, mana/energy costs, skill requirements
- **Spell Effects**: Supports projectile, target, area, self, and summon spell types
- **Integration**: Works with SpellRegistry and CombatSystem for complete spell management

### 6. SpellRegistry.as
**Spell registration and management system**:
- **Spell Data**: Complete spell information including costs, requirements, and effects
- **Player Spell Management**: Tracks learned spells per player with cooldowns
- **Potion of Forgetfulness**: Implements the forget_spell system from game_master.script
- **Spell Slots**: Manages limited spell slots per player (default 7 slots)
- **Lookup Functions**: Find spells by script name or display name
- **Statistics**: Tracks spell usage and provides registry statistics

### 7. CombatSystem.as
**Combat mechanics and damage tracking**:
- **Damage Processing**: Handles damage calculation with armor, resistance, and critical hits
- **Combat Statistics**: Tracks damage dealt/taken, kills, deaths, spells cast per player
- **Spell Damage Integration**: Specialized spell damage processing with magic system
- **Damage Types**: Supports multiple damage types (fire, cold, lightning, poison, etc.)
- **Combat Events**: Logs combat events for analysis and debugging
- **Block/Resist System**: Handles damage blocking and magic resistance

### 8. MagicCombatTest.as
**Test script demonstrating system integration**:
- **System Testing**: Tests initialization and basic functionality
- **Spell Testing**: Demonstrates spell registration and player spell management  
- **Potion Testing**: Tests potion of forgetfulness mechanics
- **Combat Testing**: Shows damage processing and statistics
- **Integration Demo**: Demonstrates magic-combat system interaction

## Conversion Summary

### From Original game_master.script (Lines 4-11) - Magic Hand System:

**Magic Hand Scripts Converted:**
- `MAGIC_HAND_SCRIPTS1` → Array in GameMasterData.as (11 spells: acid_bolt through ice_shield)
- `MAGIC_HAND_SCRIPTS2` → Array in GameMasterData.as (10 spells: ice_shield_lesser through summon_rat)  
- `MAGIC_HAND_SCRIPTS3` → Array in GameMasterData.as (3 spells: summon_undead, turn_undead, volcano)
- `MAGIC_HAND_NAMES1/2/3` → Corresponding display name arrays

**Magic System Converted (Lines 526-668) - Potion of Forgetfulness:**
- `forget_spell` function → PlayerSpellData.ForgetSpell() method
- `add_spell_callbacks` → SpellRegistry.GetPlayerSpellNames() for menu
- `confirm_forget_spell` → SpellRegistry.PlayerForgetSpell() method
- `erase_spell` → Spell slot management with wipespell functionality

**Key Magic Features Implemented:**
- **24 Magic Hand Spells**: All spells from the 3 categories registered with metadata
- **Spell Categorization**: Basic Combat (cat 1), Advanced Combat (cat 2), Master Level (cat 3)
- **Skill Requirements**: Automatic skill level assignment based on spell complexity
- **Mana/Energy Costs**: Dynamic cost calculation based on spell power
- **Spell Types**: Projectile, target, area, self-cast, and summoning spells
- **Preparation Times**: Variable cast times based on spell complexity

## Next Steps

1. **C++ Binding**: Implement the utility functions in C++ and bind to AngelScript
2. **Entity Integration**: Connect to the actual game entity system  
3. **Event Wiring**: Connect events to the game engine event system
4. **Magic Integration**: Bind magic system to actual spell casting in game
5. **Combat Integration**: Connect combat system to actual damage processing
6. **Testing**: Create test scripts to verify functionality
7. **Performance Optimization**: Profile and optimize critical paths
8. **Legacy Migration**: Gradually migrate remaining game_master.script functionality

## Usage Examples

### GameMaster System
```angelscript
// Create and initialize the game master
MS::GameMaster gm;
gm.Spawn();

// Handle events
gm.OnPlayerConnect("TestPlayer");
gm.GoldSpew(100.0f, 2, 150.0f, 5, 20, Vector3(100, 200, 0));

// Delayed NPC creation
MS::GameMasterNPCSpawn spawn;
spawn.szScript = "monsters/orc";
spawn.vecPosition = Vector3(0, 0, 0);
gm.DelayedCreateNPC(0, 2.0f, spawn);
```

### Magic System
```angelscript
// Initialize magic and combat systems
MS::InitializeMagicSystem();
MS::InitializeCombatSystem();

// Get systems
MS::MagicSystem@ magic = MS::GetMagicSystem();
MS::SpellRegistry@ registry = magic.GetSpellRegistry();

// Player learns spells
registry.PlayerLearnSpell("player123", "magic_hand_fire_ball");
registry.PlayerLearnSpell("player123", "magic_hand_ice_shield");

// Cast a spell
magic.CastSpell(pPlayer, "Fire Ball", targetLocation);

// Get player's spells (for UI)
array<string> spellNames = registry.GetPlayerSpellNames("player123");
for (uint i = 0; i < spellNames.length(); i++) {
    // Display spell in UI: spellNames[i]
}
```

### Potion of Forgetfulness
```angelscript
// Potion of forgetfulness usage
MS::SpellRegistry@ registry = MS::GetMagicSystem().GetSpellRegistry();
string playerID = "player123";

// Get player's learned spells for menu
array<string> spellNames = registry.GetPlayerSpellNames(playerID);

// Player selects spell slot 2 to forget
if (registry.PlayerForgetSpell(playerID, 2)) {
    // Success - spell forgotten, slot freed
    PlayerMessage(playerID, "You have forgotten the spell!");
}
```

### Combat System
```angelscript
// Get combat system
MS::CombatSystem@ combat = MS::GetCombatSystem();

// Create spell damage
MS::SpellData@ fireballSpell = registry.FindSpellByScript("magic_hand_fire_ball");
float damage = combat.ProcessSpellDamage(pTarget, pCaster, fireballSpell, 25.0f);

// Track combat statistics
MS::CombatStats@ stats = combat.GetPlayerStats("player123");
// stats.flTotalDamageDealt, stats.nKills, stats.nSpellsCast, etc.

// Handle player death
combat.HandlePlayerDeath(pPlayer, pKiller);
```

### 9. WorldSystem.as
**Environmental systems and dynamic lighting management**:
- **Dynamic Lighting**: 16-slot lighting system from game_master.script lines 22-33
- **Weather Control**: Weather state management with transitions (clear, cloudy, rain, storm, fog, snow)
- **Time-based Lighting**: Automatic ambient lighting based on time of day
- **Environmental Effects**: Wind simulation and atmospheric effects
- **Light Registration**: RegisterLight(), UnregisterLight(), UpdateLight() for dynamic light sources
- **Weather API**: SetWeather(), GetCurrentWeather(), UpdateEnvironmentalEffects()

### 10. EntitySpawner.as
**NPC and monster spawning system**:
- **Delayed Spawning**: ScheduleDelayedSpawn() for timed entity creation
- **Spawn Groups**: Group management for related entities with sequential or simultaneous spawning
- **Respawn Tracking**: Automatic respawn handling for entities that should regenerate
- **Spawn Slots**: 16 spawn slots for managing scheduled entity creation
- **Entity Lifecycle**: Track spawned entities from creation to death/removal
- **Statistics**: Total spawned, currently alive, and spawn success tracking

### 11. QuestTracker.as
**Quest item management system from game_master.script lines 1744-1813**:
- **Quest Item Registry**: RegisterQuestItem() for item type management
- **Player Inventories**: Track quest items per player with quantities and timestamps
- **NPC Interactions**: NPCRequestQuestItem() for NPC-player item exchanges
- **Item Discovery**: PlayerFoundQuestItem() handles item collection events
- **Delivery System**: Automatic item delivery to requesting NPCs with consumption tracking
- **Legacy Compatibility**: ext_got_quest_item(), ext_check_quest_item(), ext_dump_quest_items()

## Conversion Summary - Phase 4 (World & Entity Systems)

### From Original game_master.script (Lines 22-33) - Dynamic Lighting:

**Light System Arrays Converted:**
- `LIGHTSYS_N_LIGHTS` → Constant in WorldSystem.as (16 light slots)
- `ARRAY_LIGHT_OWNERLIST` → LightSlot.hOwner member
- `ARRAY_LIGHT_COLOR` → LightSlot.cColor member  
- `ARRAY_LIGHT_RAD` → LightSlot.flRadius member
- `init_lights` loop → InitializeLightSystem() method with proper slot initialization

**Key Lighting Features Implemented:**
- **16 Dynamic Light Slots**: Complete light management with registration/unregistration
- **Light Properties**: Color (RGB), radius, owner entity tracking
- **Slot Management**: Available slot detection, active light counting
- **Time-based Lighting**: Automatic ambient lighting based on game hour
- **Weather Integration**: Weather affects lighting and environmental conditions

### From Original game_master.script (Lines 1744-1813) - Quest Items:

**Quest Item System Converted:**
- `ARRAY_QUEST_ITEMS` → PlayerQuestItem array per player
- `ext_got_quest_item` → PlayerFoundQuestItem() method
- `ext_check_quest_item` → NPCRequestQuestItem() method
- `find_all_qitems` → ProcessPendingRequests() and delivery logic
- `ext_dump_quest_items` → DumpAllQuestItems() method

**Key Quest Features Implemented:**
- **Item Registration**: Dynamic quest item type registration
- **Player Inventories**: Per-player quest item tracking with quantities
- **NPC Requests**: NPCs can request items from players with automatic delivery
- **Item Consumption**: Configurable item consumption on delivery
- **Special Handling**: Map-specific item effects (e.g., dynamite in rmines)
- **Statistics**: Total items found, deliveries made, active players

### Environmental & Spawning Enhancements:

**Weather System (New):**
- **Weather States**: Clear, cloudy, rain, storm, fog, snow
- **Smooth Transitions**: Configurable transition times between weather states
- **Automatic Changes**: Random weather changes every 5-15 minutes
- **Lighting Integration**: Weather affects ambient lighting

**Entity Spawning (Enhanced):**
- **Delayed Spawning**: Schedule entities to spawn after specific delays
- **Spawn Groups**: Manage related entities (e.g., orc camps, guard patrols)
- **Respawn Logic**: Automatic respawn tracking for renewable entities
- **Spawn Statistics**: Track spawn success rates and entity lifetimes

## Usage Examples - World & Entity Systems

### WorldSystem Usage
```angelscript
// Initialize world system
MS::InitializeWorldSystem();
MS::WorldSystem@ world = MS::GetWorldSystem();

// Register a dynamic light source
EntityHandle torch = CreateEntity("torch", Vector3(100, 200, 0), Vector3(0, 0, 0));
int lightSlot = world.RegisterLight(torch, Color(255, 200, 100), 150.0f);

// Update time-based lighting
world.UpdateTimeOfDayLighting(14); // 2 PM

// Change weather
world.SetWeather(MS::WEATHER_RAIN, 30.0f); // Rain over 30 seconds

// Update environmental effects
world.UpdateEnvironmentalEffects(deltaTime);
```

### EntitySpawner Usage
```angelscript
// Initialize entity spawner
MS::InitializeEntitySpawner();
MS::EntitySpawner@ spawner = MS::GetEntitySpawner();

// Create spawn data
MS::EntitySpawnData orc;
orc.szScript = "monsters/orc";
orc.vecPosition = Vector3(500, 300, 0);
orc.flHealth = 100.0f;
orc.bRespawn = true;
orc.flRespawnDelay = 120.0f; // 2 minutes

// Schedule delayed spawn
int spawnSlot = spawner.ScheduleDelayedSpawn(5.0f, orc); // Spawn in 5 seconds

// Create a spawn group
int groupIndex = spawner.CreateSpawnGroup("orc_patrol");
spawner.AddEntityToGroup(groupIndex, orc);
spawner.SpawnGroup(groupIndex, 2.0f); // 2 second delay between spawns

// Update spawner (call periodically)
spawner.Update(deltaTime);
```

### QuestTracker Usage
```angelscript
// Initialize quest tracker
MS::InitializeQuestTracker();
MS::QuestTracker@ quests = MS::GetQuestTracker();

// Register custom quest item
quests.RegisterQuestItem("magic_gem", "Magic Gem", "A gem pulsing with magical energy");

// Player finds an item
quests.PlayerFoundQuestItem("player123", "stick_dynamite", 1);

// NPC requests items from players
uint delivered = quests.NPCRequestQuestItem("stick_dynamite", "npc_miner", 1, true);
if (delivered > 0) {
    // Reward the player
    CallNPCScript("npc_miner", "reward_player");
}

// Check player's quest items
uint dynamiteCount = quests.GetPlayerQuestItemCount("player123", "stick_dynamite");
array<MS::PlayerQuestItem> playerItems = quests.GetPlayerQuestItems("player123");

// Debug dump
quests.DumpAllQuestItems();
```