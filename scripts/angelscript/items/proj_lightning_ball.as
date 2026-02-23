#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjLightningBall : CGameScript
{
	string F_BALL_DMG;
	string F_BALL_SIZE;
	string F_BALL_TYPE;
	int HIT_SOMETHING;
	int LOOP_COUNT;
	string MY_OWNER;
	string MY_SCRIPT_IDX;
	string OWNER_ISPLAYER;
	int SCAN_ON;
	int SCAN_SIZE;

	ProjLightningBall()
	{
		const int PROJ_IGNORENPC = 0;
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "none";
		const int ARROW_BODY_OFS = 6;
		const string SOUND_SHOOT = "ambience/alienflyby1.wav";
		const string SOUND_ZAP1 = "debris/beamstart14.wav";
		const string SOUND_ZAP2 = "debris/beamstart14.wav";
		const string SOUND_ZAP3 = "debris/zap1.wav";
		const int PROJ_MOTIONBLUR = 0;
		const string PROJ_ANIM_IDLE = "none";
		const int MODEL_BODY_OFS = 0;
		const int PROJ_DAMAGE = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_DAMAGE_AOE_RANGE = 32;
		const int PROJ_DAMAGE_AOE_FALLOFF = 1;
		const string PROJ_DAMAGE_TYPE = "lightning";
	}

	void OnSpawn() override
	{
		if (param1 != "1")
		{
			ScheduleDelayedEvent(10.0, "remove_me");
		}
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
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
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
		if (GetEntityProperty(MY_OWNER, "scriptvar") != "BALL_TYPE")
		{
			F_BALL_TYPE = GetEntityProperty(MY_OWNER, "scriptvar");
		}
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
		SetIdleAnim("idle_standard");
		SetMoveAnim("idle_standard");
		string SUB_MODEL = int(F_BALL_SIZE);
		SUB_MODEL += 12;
		string SUB_MODEL = int(SUB_MODEL);
		SetModelBody(0, SUB_MODEL);
		if (F_BALL_TYPE == "holy")
		{
			SetProp(GetOwner(), "rendermode", 1);
			SetProp(GetOwner(), "rendercolor", Vector3(0, 0, 255));
		}
		MY_SCRIPT_IDX = "game.script.last_sent_id";
		EmitSound(GetOwner(), 0, SOUND_SHOOT, F_BALL_SIZE);
		SCAN_ON = 1;
		scan_damage();
	}

	void scan_damage()
	{
		if ((SCAN_ON))
		{
			ScheduleDelayedEvent(0.1, "scan_damage");
		}
		// TODO: getents any SCAN_SIZE
		if (!(getCount > 0)) return;
		hit_target();
	}

	void game_hitnpc()
	{
		CallExternal(MY_OWNER, "send_damage", GetEntityIndex(m_hLastStruckByMe), "direct", F_BALL_DMG, 1.0, MY_OWNER, F_BALL_TYPE);
		XDoDamage(GetEntityIndex(m_hLastStruckByMe), "direct", F_BALL_DMG, 1.0, MY_OWNER, MY_OWNER, "spellcasting.lightning", F_BALL_TYPE);
		Effect("screenfade", GetEntityIndex(m_hLastStruckByMe), 3, 1, Vector3(255, 255, 255), 255, "fadein");
		DeleteEntity(GetOwner());
	}

	void game_projectile_landed()
	{
		SetModel("none");
		ClientEvent("update", "all", MY_SCRIPT_IDX, "shrink_out");
		SetExpireTime(0);
	}

	void hit_target()
	{
		HIT_SOMETHING = 1;
		LOOP_COUNT = 0;
		for (int i = 0; i < getCount; i++)
		{
			dmg_target();
		}
	}

	void dmg_target()
	{
		LOOP_COUNT += 1;
		if (LOOP_COUNT == 1)
		{
			string CHECK_ENT = getEnt1;
		}
		if (LOOP_COUNT == 2)
		{
			string CHECK_ENT = getEnt2;
		}
		if (LOOP_COUNT == 3)
		{
			string CHECK_ENT = getEnt3;
		}
		if (LOOP_COUNT == 4)
		{
			string CHECK_ENT = getEnt4;
		}
		if (LOOP_COUNT == 5)
		{
			string CHECK_ENT = getEnt5;
		}
		if (LOOP_COUNT == 6)
		{
			string CHECK_ENT = getEnt6;
		}
		if (LOOP_COUNT == 7)
		{
			string CHECK_ENT = getEnt7;
		}
		if (LOOP_COUNT == 8)
		{
			string CHECK_ENT = getEnt8;
		}
		if (LOOP_COUNT == 9)
		{
			string CHECK_ENT = getEnt9;
		}
		if (!(GetRelationship(CHECK_ENT) == "enemy")) return;
		if ((OWNER_ISPLAYER))
		{
			if ("game.pvp" == 0)
			{
			}
			if ((IsValidPlayer(CHECK_ENT)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityProperty(CHECK_ENT, "scriptvar")))
		{
			XDoDamage(CHECK_ENT, "direct", F_BALL_DMG, 1.0, MY_OWNER, MY_OWNER, "spellcasting.lightning", F_BALL_TYPE);
		}
		Effect("screenfade", CHECK_ENT, 3, 1, Vector3(255, 255, 255), 255, "fadein");
	}

}

}
