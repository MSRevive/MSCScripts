#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjLightningBallSimple : CGameScript
{
	string F_BALL_DMG;
	string F_BALL_SIZE;
	string F_BALL_TYPE;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	int SCAN_SIZE;

	ProjLightningBallSimple()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "none";
		const int ARROW_BODY_OFS = 6;
		const string SOUND_SHOOT = "ambience/alienflyby1.wav";
		const string SOUND_ZAP1 = "debris/beamstart14.wav";
		const string SOUND_ZAP2 = "debris/beamstart14.wav";
		const string SOUND_ZAP3 = "debris/zap1.wav";
		const int PROJ_MOTIONBLUR = 0;
		const string PROJ_ANIM_IDLE = "spin_horizontal_slow";
		const int MODEL_BODY_OFS = 0;
		const int PROJ_DAMAGE = 200;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_DAMAGE_AOE_RANGE = 32;
		const int PROJ_DAMAGE_AOE_FALLOFF = 1;
		const string PROJ_DAMAGE_TYPE = "lightning";
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
		string SUB_MODEL = int(F_BALL_SIZE);
		SUB_MODEL += 12;
		string SUB_MODEL = int(SUB_MODEL);
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
