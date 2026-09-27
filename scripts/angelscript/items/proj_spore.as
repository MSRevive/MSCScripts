#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjSpore : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int MODEL_BODY_OFS;
	string MODEL_WORLD;
	string MY_OWNER;
	string PROJ_ANIM_IDLE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGETYPE;
	string SOUND_BURN;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	int SPAWNED_CLOUD;
	string SPORE_STR;
	string SPRITE_ARROW_TRADE;

	ProjSpore()
	{
		PROJ_ANIM_IDLE = "idle_standard";
		PROJ_DAMAGE = RandomInt(60, 90);
		MODEL_BODY_OFS = 23;
		ARROW_BODY_OFS = 23;
		PROJ_ANIM_IDLE = "spore_spinning";
		PROJ_DAMAGETYPE = "poison";
		SOUND_HITWALL1 = "ambience/steamburst1.wav";
		SOUND_HITWALL2 = "ambience/steamburst1.wav";
		SOUND_BURN = "ambience/steamburst1.wav";
		SPRITE_ARROW_TRADE = "woodenarrow";
		ARROW_STICK_DURATION = 10;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.01;
		ARROW_EXPIRE_DELAY = 5;
		MODEL_WORLD = "weapons/projectiles.mdl";
	}

	void arrow_spawn()
	{
		SetName("spore sack");
		SetDescription("a spore sack");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.001);
		SetUseable(0);
	}

	void game_tossprojectile()
	{
		PlayAnim("once", "spore_spinning");
		SetIdleAnim("spore_spinning");
		SetMoveAnim("spore_spinning");
		MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		if ((OWNER_ISPLAYER))
		{
			SPORE_STR = GetSkillLevel(MY_OWNER, "spellcasting.affliction");
		}
		if (!(OWNER_ISPLAYER))
		{
			SPORE_STR = GetEntityProperty(MY_OWNER, "scriptvar");
		}
	}

	void game_projectile_hitwall()
	{
		LogDebug("game_projectile_hitwall GetEntityOrigin(GetOwner())");
		if ((SPAWNED_CLOUD)) return;
		SPAWNED_CLOUD = 1;
		MY_OWNER = GetEntityIndex("ent_expowner");
		SpawnNPC("monsters/summon/npc_poison_cloud2", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: MY_OWNER, SPORE_STR, 10.0, 2
	}

	void game_projectile_landed()
	{
		LogDebug("game_projectile_landed GetEntityOrigin(GetOwner())");
		MY_OWNER = GetEntityIndex("ent_expowner");
		XDoDamage(GetEntityOrigin(GetOwner()), 256, SPORE_POISON_DMG, 0, MY_OWNER, MY_OWNER, "spellcasting.affliction", "poison");
	}

	void game_projectile_hitnpc()
	{
		LogDebug("game_projectile_hitnpc GetEntityName(param1)");
		if ((SPAWNED_CLOUD)) return;
		SPAWNED_CLOUD = 1;
		SpawnNPC("monsters/summon/npc_poison_cloud2", GetEntityOrigin(param1), ScriptMode::Legacy); // params: MY_OWNER, SPORE_STR, 10.0, 2
	}

}

}
