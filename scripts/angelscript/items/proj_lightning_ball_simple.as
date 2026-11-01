#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjLightningBallSimple : CGameScript
{
	int ARROW_BODY_OFS;
	string F_BALL_DMG;
	string F_BALL_SIZE;
	string F_BALL_TYPE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	string PROJ_ANIM_IDLE;
	int PROJ_DAMAGE;
	int PROJ_DAMAGE_AOE_FALLOFF;
	int PROJ_DAMAGE_AOE_RANGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;
	int SCAN_SIZE;
	string SOUND_SHOOT;
	string SOUND_ZAP1;
	string SOUND_ZAP2;
	string SOUND_ZAP3;

	ProjLightningBallSimple()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "none";
		ARROW_BODY_OFS = 6;
		SOUND_SHOOT = "ambience/alienflyby1.wav";
		SOUND_ZAP1 = "debris/beamstart14.wav";
		SOUND_ZAP2 = "debris/beamstart14.wav";
		SOUND_ZAP3 = "debris/zap1.wav";
		PROJ_MOTIONBLUR = 0;
		PROJ_ANIM_IDLE = "spin_horizontal_slow";
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = 200;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_DAMAGE_AOE_RANGE = 32;
		PROJ_DAMAGE_AOE_FALLOFF = 1;
		PROJ_DAMAGE_TYPE = "lightning";
	}

	void arrow_spawn()
	{
		SetName("Manabolt");
		SetDescription("Manabolt");
		SetWeight(0);
		SetSize(1);
		SetValue(1);
		SetGravity(0.0001);
		SetModel("none");
		SetIdleAnim("spin_horizontal_slow");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		ScheduleDelayedEvent(10.0, "remove_me");
	}

	void game_fall()
	{
	}

	void game_hitworld()
	{
		// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
		array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_tossprojectile()
	{
		MY_OWNER = GetEntityIndex("ent_expowner");
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		F_BALL_SIZE = GetEntityProperty(MY_OWNER, "scriptvar");
		F_BALL_DMG = GetEntityProperty(MY_OWNER, "scriptvar");
		F_BALL_TYPE = "lightning";
		SCAN_SIZE = 16;
		if ((OWNER_ISPLAYER))
		{
			SCAN_SIZE = 12;
		}
		SCAN_SIZE *= F_BALL_SIZE;
		if (F_BALL_SIZE == 0)
		{
			DeleteEntity(GetOwner());
		}
		if (!(F_BALL_SIZE > 0)) return;
		SetModel("weapons/projectiles.mdl");
		int SUB_MODEL = int(F_BALL_SIZE);
		SUB_MODEL += 12;
		int SUB_MODEL = int(SUB_MODEL);
		SetModelBody(0, SUB_MODEL);
		EmitSound(GetOwner(), 0, SOUND_SHOOT, F_BALL_SIZE);
	}

	void game_projectile_hitnpc()
	{
		SetModel("none");
		// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
		array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		Effect("screenfade", GetEntityIndex(m_hLastStruckByMe), 3, 1, Vector3(255, 255, 255), 255, "fadein");
		SetExpireTime(0);
	}

	void game_projectile_landed()
	{
		SetModel("none");
		SetExpireTime(0);
	}

}

}
