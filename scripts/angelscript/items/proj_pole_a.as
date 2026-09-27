#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoleA : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int DID_SPAWN_CHECK;
	string GAME_PVP;
	int HIT_NPC;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	float PROJ_CLOUD_DURATION;
	int PROJ_COLLIDE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjPoleA()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 70;
		ARROW_BODY_OFS = 70;
		ARROW_STICK_DURATION = 0;
		ARROW_EXPIRE_DELAY = 0;
		SOUND_HITWALL1 = "weapons/xbow_hit1.wav";
		SOUND_HITWALL2 = "weapons/xbow_hit1.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "acid";
		PROJ_DAMAGESTAT = "spellcasting.ice";
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 0;
		PROJ_AOE_RANGE = 0;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDE = 1;
		PROJ_CLOUD_DURATION = 20.0;
	}

	void game_precache()
	{
		Precache("monsters/summon/affliction_lance");
	}

	void arrow_spawn()
	{
		SetName("Affliction Lance");
		SetDescription("You have been afflicted by this lance");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_tossprojectile()
	{
		GAME_PVP = "game.pvp";
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(0, 255, 0), 128, 1.5);
	}

	void game_projectile_hitnpc()
	{
		HIT_NPC = 1;
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		int L_DMG = 800;
		string OWNER_SKILL_RATIO = GetSkillLevel("ent_expowner", "polearms");
		OWNER_SKILL_RATIO *= 0.01;
		L_DMG *= OWNER_SKILL_RATIO;
		int PUSH_STR = 800;
		string TARG_ORG = GetEntityOrigin(param1);
		string MY_ORG = GetEntityOrigin("ent_expowner");
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, PUSH_STR, 0)));
		string POISON_DOT = GetSkillLevel("ent_expowner", "spellcasting.affliction");
		POISON_DOT *= 0.5;
		ApplyEffect(param1, "effects/dot_acid", 5.0, GetEntityIndex("ent_expowner"), POISON_DOT, "polearms");
		if (!(IsEntityAlive(param1))) return;
		XDoDamage(param1, "direct", L_DMG, 1.0, "ent_expowner", GetOwner(), "polearms", "acid");
	}

	void game_projectile_landed()
	{
		if ((HIT_NPC)) return;
		if ((DID_SPAWN_CHECK)) return;
		DID_SPAWN_CHECK = 1;
		string MY_PITCH = GetEntityProperty(GetOwner(), "angles.pitch");
		if (MY_PITCH > 175)
		{
			if (MY_PITCH < 360)
			{
			}
			int DO_PROJ = 1;
		}
		if (!(DO_PROJ)) return;
		if (GetEntityMP("ent_expowner") < 20)
		{
			SendColoredMessage("ent_expowner", "Insuffcient mana for Afflictor.");
		}
		if (!(GetEntityMP("ent_expowner") >= 20)) return;
		GiveMP("ent_expowner");
		string MY_ORG = GetEntityOrigin(GetOwner());
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(MY_ORG);
		string MY_Z = (MY_ORG).z;
		GROUND_Z += 64;
		if (!(MY_Z < GROUND_Z)) return;
		GROUND_Z -= 128;
		if (!(MY_Z > GROUND_Z)) return;
		string MY_ORG = GetEntityOrigin(GetOwner());
		LogDebug("game_projectile_landed MY_ORG");
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(MY_ORG);
		MY_ORG = "z";
		string L_FX_ID = /* TODO: $get_scriptflag */ $get_scriptflag("ent_expowner", "pole_a", "name_value");
		if (L_FX_ID == "none")
		{
			SpawnNPC("monsters/summon/affliction_lance", MY_ORG, ScriptMode::Legacy); // params: GetEntityIndex("ent_expowner"), MY_ORG, GetEntityAngles(GetOwner()), PROJ_CLOUD_DURATION
		}
		else
		{
			CallExternal(L_FX_ID, "transfer_location", MY_ORG);
		}
	}

}

}
