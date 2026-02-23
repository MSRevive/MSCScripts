#pragma context server

namespace MS
{

class MagicDart : CGameScript
{
	int DART_ON;
	string FINAL_DEST;
	int FIZZING_OUT;
	int HIT_SOMETHING;
	int LOOP_COUNT;
	string MY_OWNER;
	string MY_SCRIPT_IDX;
	string MY_SKILL;
	string OLD_POS;
	string OWNER_ANGLES;
	string OWNER_ISPLAYER;
	string PROJ_DEST;
	string PROJ_DMG;
	string PROJ_SIZE;
	int PROJ_SPEED;
	int STUCK_COUNT;
	string WORLD_SIZE;

	MagicDart()
	{
		const string SOUND_SHOOT = "ambience/alienflyby1.wav";
		const string SOUND_ZAP1 = "debris/beamstart14.wav";
		const string SOUND_ZAP2 = "debris/beamstart14.wav";
		const string SOUND_ZAP3 = "debris/zap1.wav";
	}

	void game_dynamically_created()
	{
		MY_OWNER = GetEntityIndex(param1);
		PROJ_DEST = param2;
		PROJ_SIZE = param3;
		PROJ_DMG = param5;
		MY_SKILL = param6;
		WORLD_SIZE = PROJ_SIZE;
		WORLD_SIZE *= 15;
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		PROJ_SPEED = 180;
		string SPEED_ADJ = PROJ_SIZE;
		SPEED_ADJ *= 15;
		PROJ_SPEED -= SPEED_ADJ;
		SetMoveDest(PROJ_DEST);
		SetProp(GetOwner(), "movetype", "const.movetype.noclip");
		SetProp(GetOwner(), "solid", 0);
		OWNER_ANGLES = GetEntityAngles(MY_OWNER);
		SetAngles("face");
		FINAL_DEST = /* TODO: $relpos */ $relpos(0, 20000, 0);
		SetMoveDest(FINAL_DEST);
		string L_PROJ_SPEED = PROJ_SPEED;
		L_PROJ_SPEED *= 10;
		SetAnimMoveSpeed(L_PROJ_SPEED);
		ClientEvent("new", "all", "monsters/summon/magic_dart_cl", GetEntityIndex(GetOwner()), PROJ_SIZE);
		MY_SCRIPT_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.1, "setup_dart");
		ScheduleDelayedEvent(10.0, "fiz_out");
	}

	void OnSpawn() override
	{
		SetName("Mana Bolt");
		SetModel("monsters/bat.mdl");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SetWidth(32);
		SetHeight(32);
		SetSolid("none");
		SetBloodType("none");
		SetInvincible(true);
		SetRace("beloved");
		SetMonsterClip(0);
		SetFly(true);
		SetGravity(0);
		ScheduleDelayedEvent(10.0, "remove_me");
	}

	void setup_dart()
	{
		DART_ON = 1;
		STUCK_COUNT = 0;
		OLD_POS = GetMonsterProperty("origin");
		ScheduleDelayedEvent(0.1, "move_dart");
		string SHOOT_VOLUME = int(PROJ_SIZE);
		SetMoveDest(PROJ_DEST);
		EmitSound(GetOwner(), 0, SOUND_SHOOT, SHOOT_VOLUME);
	}

	void move_dart()
	{
		if (!(DART_ON)) return;
		ScheduleDelayedEvent(0.1, "move_dart");
		SetMoveDest(PROJ_DEST);
		// TODO: getents any WORLD_SIZE
		if (getCount > 0)
		{
			hit_target();
			ScheduleDelayedEvent(0.1, "fiz_out", "getents");
		}
		if (Distance(GetMonsterProperty("origin"), PROJ_DEST) <= PROJ_SPEED)
		{
			if (!(HIT_SOMETHING))
			{
			}
			string NEW_DEST = PROJ_DEST;
			string MY_YAW = (GetMonsterProperty("angles.yaw")).z;
			NEW_DEST += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 1000, 0));
			PROJ_DEST = NEW_DEST;
		}
		if (GetMonsterProperty("origin") == OLD_POS)
		{
			if (!(HIT_SOMETHING))
			{
			}
			STUCK_COUNT += 1;
			if (STUCK_COUNT > 3)
			{
			}
			fiz_out("stuck");
		}
		OLD_POS = GetMonsterProperty("origin");
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
		if (!(GetEntityIndex(CHECK_ENT) != FIRST_TARG)) return;
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
		XDoDamage(CHECK_ENT, "direct", PROJ_DMG, 1.0, MY_OWNER, MY_OWNER, MY_SKILL, "magic");
		Effect("screenfade", CHECK_ENT, 3, 1, Vector3(255, 255, 255), 255, "fadein");
	}

	void debug_beam()
	{
		if (param3 == "PARAM3")
		{
			Vector3 BEAM_COLOR = Vector3(255, 0, 255);
		}
		if (param3 != "PARAM3")
		{
			string BEAM_COLOR = param3;
		}
		float BEAM_DURATION = 1.0;
		string BEAM_START = param1;
		if (param2 == "PARAM2")
		{
			string BEAM_END = BEAM_START;
		}
		if (param2 != "PARAM2")
		{
			string BEAM_END = param2;
		}
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 64));
		Effect("beam", "point", "laserbeam.spr", 20, BEAM_START, BEAM_END, BEAM_COLOR, 255, 0.7, BEAM_DURATION);
	}

	void fiz_out()
	{
		if ((FIZZING_OUT)) return;
		FIZZING_OUT = 1;
		DART_ON = 0;
		// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
		array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ClientEvent("update", "all", MY_SCRIPT_IDX, "shrink_out");
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		ScheduleDelayedEvent(0.1, "remove_me2");
	}

	void remove_me2()
	{
		DeleteEntity(GetOwner());
	}

	void game_reached_dest()
	{
	}

	void game_movingto_dest()
	{
		SetAnimMoveSpeed(PROJ_SPEED);
	}

	void game_stopmoving()
	{
		SetAnimMoveSpeed(PROJ_SPEED);
	}

}

}
