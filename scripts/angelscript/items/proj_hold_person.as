#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjHoldPerson : CGameScript
{
	int ARROW_BODY_OFS;
	int ARROW_SOLIDIFY_ON_WALL;
	string GAME_PVP;
	int HITWALL_VOL;
	string HOLD_DMG;
	string HOLD_DURATION;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string MY_BEAM_ID;
	string PROJ_ANIM_IDLE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	int PROJ_DAMAGE_AOE_FALLOFF;
	int PROJ_DAMAGE_AOE_RANGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;
	int SCAN_RANGE;
	string SOUND_LOOP;
	string SOUND_ZAP1;
	string SOUND_ZAP2;
	string SOUND_ZAP3;

	ProjHoldPerson()
	{
		MODEL_HANDS = "weapons/projectiles.mdl";
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 2;
		MODEL_BODY_OFS = 2;
		PROJ_ANIM_IDLE = "idle_iceball";
		SOUND_ZAP1 = "debris/beamstart14.wav";
		SOUND_ZAP2 = "debris/beamstart14.wav";
		SOUND_ZAP3 = "debris/zap1.wav";
		SOUND_LOOP = "ambience/pulsemachine.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		HITWALL_VOL = 2;
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_DAMAGE_AOE_RANGE = 0;
		PROJ_DAMAGE_AOE_FALLOFF = 1;
		PROJ_DAMAGE_TYPE = "magic";
		PROJ_COLLIDEHITBOX = 1;
		PROJ_ANIM_IDLE = "none";
		SCAN_RANGE = 96;
	}

	void arrow_spawn()
	{
		SetName("Hold Person Spell");
		SetDescription("A paralyzing ball of magic");
		SetWeight(0);
		SetSize(1);
		SetValue(1);
		SetGravity(0.0001);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 2);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 200);
		SetProp(GetOwner(), "rendercolor", Vector3(255, 128, 0));
		GAME_PVP = "game.pvp";
	}

	void game_fall()
	{
	}

	void game_projectile_hitnpc()
	{
		ApplyEffect(m_hLastStruckByMe, "effects/debuff_hold", HOLD_DURATION);
		remove_me();
	}

	void game_tossprojectile()
	{
		HOLD_DURATION = GetEntityProperty("ent_expowner", "scriptvar");
		HOLD_DMG = GetEntityProperty("ent_expowner", "scriptvar");
		if (HOLD_DURATION == "PROJ_HOLD_DURATION")
		{
			HOLD_DURATION = 30.0;
		}
		if (HOLD_DMG == "PROJ_HOLD_DMG")
		{
			HOLD_DMG = 0;
		}
		// svplaysound: svplaysound 1 10 SOUND_LOOP
		EmitSound(1, 10, SOUND_LOOP);
		Effect("beam", "ents", "lgtning.spr", 10, GetOwner(), 0, "ent_expowner", 1, Vector3(255, 255, 255), 200, 100, 10.0);
		MY_BEAM_ID = GetEntityIndex(m_hLastCreated);
	}

	void game_projectile_hitwall()
	{
		remove_me();
	}

	void game_projectile_landed()
	{
		remove_me();
	}

	void remove_me()
	{
		Effect("beam", "update", MY_BEAM_ID, "remove", 0.1);
		// svplaysound: svplaysound 1 0 SOUND_LOOP
		EmitSound(1, 0, SOUND_LOOP);
	}

}

}
