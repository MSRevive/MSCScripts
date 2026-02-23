#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjSpore : CGameScript
{
	string MY_OWNER;
	string SOUND_BURN;
	int SPAWNED_CLOUD;
	string SPORE_STR;

	ProjSpore()
	{
		const string PROJ_ANIM_IDLE = "idle_standard";
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int MODEL_BODY_OFS = 23;
		const int ARROW_BODY_OFS = 23;
		const string PROJ_ANIM_IDLE = "spore_spinning";
		const string PROJ_DAMAGETYPE = "poison";
		const string SOUND_HITWALL1 = "ambience/steamburst1.wav";
		const string SOUND_HITWALL2 = "ambience/steamburst1.wav";
		SOUND_BURN = "ambience/steamburst1.wav";
		const string SPRITE_ARROW_TRADE = "woodenarrow";
		const int ARROW_STICK_DURATION = 10;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.01;
		const int ARROW_EXPIRE_DELAY = 5;
		const string MODEL_WORLD = "weapons/projectiles.mdl";
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
