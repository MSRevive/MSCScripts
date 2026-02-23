#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjMana : CGameScript
{
	string DAMAGE_LIST;
	string F_BALL_DMG;
	string F_BALL_SIZE;
	string F_BALL_TYPE;
	string GAME_PVP;
	int LAST_TOUCHED;
	string MY_OWNER;
	string NEXT_TOUCH;
	string OWNER_ISPLAYER;
	int SCAN_ON;
	int SCAN_SIZE;
	string SCAN_TARGS;
	string TOKEN_TARGETS;

	ProjMana()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "none";
		const int ARROW_BODY_OFS = 6;
		const string SOUND_SHOOT = "ambience/alienflyby1.wav";
		const string SOUND_ZAP1 = "debris/beamstart14.wav";
		const string SOUND_ZAP2 = "debris/beamstart14.wav";
		const string SOUND_ZAP3 = "debris/zap1.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const int HITWALL_VOL = 2;
		const int PROJ_MOTIONBLUR = 0;
		const int MODEL_BODY_OFS = 0;
		const int PROJ_DAMAGE = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_DAMAGE_AOE_RANGE = 0;
		const int PROJ_DAMAGE_AOE_FALLOFF = 1;
		const string PROJ_DAMAGE_TYPE = "magic";
		const int PROJ_COLLIDEHITBOX = 1;
		const int PROJ_IGNORENPC = 1;
		const string PROJ_ANIM_IDLE = "none";
	}

	void arrow_spawn()
	{
		SetName("Manabolt");
		SetDescription("Manabolt");
		SetWeight(0);
		SetSize(16);
		SetValue(16);
		SetGravity(0.0001);
		SetModel("none");
		ScheduleDelayedEvent(10.0, "remove_me");
		GAME_PVP = "game.pvp";
		// TODO: UNCONVERTED: projectiletouch 1
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(GetGameTime() > NEXT_TOUCH)) return;
		NEXT_TOUCH = GetGameTime();
		NEXT_TOUCH += 0.1;
		LogDebug("game_touch GetEntityName(param1)");
		check_damage(GetEntityIndex(param1), 1);
	}

	void game_fall()
	{
		LogDebug("game_fall");
	}

	void game_projectile_hitwall()
	{
		LogDebug("game_projectile_hitwall");
		// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
		array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		SetAlive(0);
		SCAN_ON = 0;
		RemoveScript();
		DeleteEntity(GetOwner());
	}

	void game_projectile_hitnpc()
	{
		LogDebug("game_projectile_hitnpc GetEntityName(param1)");
	}

	void game_projectile_landed()
	{
		LogDebug("game_projectile_landed");
	}

	void game_tossprojectile()
	{
		TOKEN_TARGETS = "";
		MY_OWNER = GetEntityIndex("ent_expowner");
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		F_BALL_SIZE = GetEntityProperty(MY_OWNER, "scriptvar");
		F_BALL_DMG = GetEntityProperty(MY_OWNER, "scriptvar");
		F_BALL_TYPE = GetEntityProperty(MY_OWNER, "scriptvar");
		DAMAGE_LIST = "";
		string F_BALL_VOL = int(F_BALL_SIZE);
		F_BALL_VOL = max(1, min(10, F_BALL_VOL));
		// svplaysound: svplaysound 4 F_BALL_VOL SOUND_SHOOT
		EmitSound(4, F_BALL_VOL, SOUND_SHOOT);
		LogDebug("game_tossprojectile F_BALL_SIZE F_BALL_DMG F_BALL_TYPE GetEntityName(MY_OWNER)");
		if (F_BALL_TYPE == "F_BALL_TYPE")
		{
			F_BALL_TYPE = "magic";
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
		SetModelBody(0, 13);
		string SCALE_SIZE = F_BALL_SIZE;
		SCALE_SIZE *= 0.75;
		SetProp(GetOwner(), "scale", SCALE_SIZE);
		SetWidth(SCAN_SIZE);
		SetHeight(SCAN_SIZE);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 20);
		SCAN_ON = 1;
		scan_damage();
	}

	void scan_damage()
	{
		if ((SCAN_ON))
		{
			ScheduleDelayedEvent(0.1, "scan_damage");
		}
		string MY_ORG = GetEntityOrigin(GetOwner());
		if (MY_ORG == Vector3(0, 0, 0))
		{
			DeleteEntity(GetOwner());
		}
		string MY_HEIGHT = (MY_ORG).z;
		MY_HEIGHT -= /* TODO: $get_ground_height */ $get_ground_height(MY_ORG);
		if (MY_HEIGHT < 72)
		{
			MY_ORG = "z";
			if (SCAN_SIZE > 32)
			{
				MY_ORG += "z";
			}
		}
		SCAN_TARGS = FindEntitiesInSphere("any", SCAN_SIZE);
		if (!(SCAN_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(SCAN_TARGS, ";"); i++)
		{
			damage_targets();
		}
	}

	void damage_targets()
	{
		string CUR_TARG = GetToken(SCAN_TARGS, i, ";");
		check_damage(CUR_TARGET);
	}

	void remove_last_touched()
	{
		LAST_TOUCHED = 0;
	}

	void check_damage()
	{
		string CUR_TARG = param1;
		if ((DAMAGE_LIST).findFirst(CUR_TARG) >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		LogDebug("damage_targets nam GetEntityName(CUR_TARG) nme GetRelationship(CUR_TARG) plr IsValidPlayer(CUR_TARG)");
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			if ((OWNER_ISPLAYER))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		LogDebug("damageline MY_ORG TARG_ORG F_BALL_DMG");
		XDoDamage(MY_ORG, TARG_ORG, F_BALL_DMG, 1.0, "ent_expowner", GetOwner(), "archery", "magic", "dmgevent:ext_manaball");
		if (DAMAGE_LIST.length() > 0) DAMAGE_LIST += ";";
		DAMAGE_LIST += CUR_TARG;
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void game_projectile_hitwall()
	{
		// svplaysound: svplaysound 4 0 SOUND_SHOOT
		EmitSound(4, 0, SOUND_SHOOT);
	}

}

}
