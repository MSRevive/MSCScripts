#pragma context server

namespace MS
{

class UberBlizzard : CGameScript
{
	string BLIZ_DENSITY;
	string BLIZ_WIDTH;
	string FLAKE_HEIGHT;
	string FREEZE_CHANCE;
	int IS_ACTIVE;
	int LOOP_COUNT;
	string MY_BASE_DMG;
	string MY_DURATION;
	string MY_OWNER;
	string MY_RADIUS;
	string MY_SCRIPT_IDX;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string ROOF_HEIGHT;
	string SHARD_HEIGHT;
	string SNOW_CENTER;
	int SNOW_ON;
	string vel;

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.2);
		if ((SNOW_ON))
		{
		}
		for (int i = 0; i < BLIZ_DENSITY; i++)
		{
			make_flakes();
		}
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_BASE_DMG = param2;
		MY_DURATION = param3;
		MY_RADIUS = param4;
		FREEZE_CHANCE = param5;
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), /* TODO: $get_sky_height */ $get_sky_height(GetMonsterProperty("origin")), MY_RADIUS, 10);
		MY_SCRIPT_IDX = "game.script.last_sent_id";
		IS_ACTIVE = 1;
		scan_attack();
		MY_DURATION("end_summon");
	}

	void OnSpawn() override
	{
		SetName("Blizzard");
		SetRace("beloved");
		SetInvincible(true);
		SetHealth(1);
		PLAYING_DEAD = 1;
	}

	void scan_attack()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(10.0, "scan_attack");
		// TODO: getents any MY_RADIUS
		if (!(getCount > 0)) return;
		LOOP_COUNT = 0;
		if (!(IsEntityAlive(MY_OWNER))) return;
		for (int i = 0; i < getCount; i++)
		{
			check_attack();
		}
	}

	void check_attack()
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
		if (!(GetEntityRange(CHECK_ENT) < MY_RADIUS)) return;
		if (!(RandomInt(1, 100) < FREEZE_CHANCE)) return;
		ApplyEffect(CHECK_ENT, "effects/dot_cold", 9.5, MY_OWNER, MY_BASE_DMG);
	}

	void end_summon()
	{
		IS_ACTIVE = 0;
		ClientEvent("remove", "all", MY_SCRIPT_IDX);
		ScheduleDelayedEvent(0.2, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		SNOW_CENTER = param1;
		ROOF_HEIGHT = param2;
		BLIZ_WIDTH = param3;
		BLIZ_DENSITY = param4;
		ROOF_HEIGHT = (ROOF_HEIGHT).z;
		FLAKE_HEIGHT = ROOF_HEIGHT;
		SHARD_HEIGHT = ROOF_HEIGHT;
		SHARD_HEIGHT -= 64;
		SNOW_ON = 1;
	}

	void make_flakes()
	{
		string NEGBLIZ_WIDTH = BLIZ_WIDTH;
		NEGBLIZ_WIDTH *= -1;
		string x = RandomInt(NEGBLIZ_WIDTH, BLIZ_WIDTH);
		string y = RandomInt(NEGBLIZ_WIDTH, BLIZ_WIDTH);
		START_POS += SNOW_CENTER;
		ClientEffect("tempent", "sprite", "snow1.spr", START_POS, "setup_blizzardflake");
		string NEGBLIZ_WIDTH = BLIZ_WIDTH;
		NEGBLIZ_WIDTH *= -1;
		string x = RandomInt(NEGBLIZ_WIDTH, BLIZ_WIDTH);
		string y = RandomInt(NEGBLIZ_WIDTH, BLIZ_WIDTH);
		START_POS += SNOW_CENTER;
		ClientEffect("tempent", "sprite", "glassgibs.mdl", START_POS, "setup_hailshard");
	}

	void setup_blizzardflake()
	{
		vel = RandomInt(-50, 50);
		string FLAKE_GRAv = Random(0.2, 2.1);
		string FLAKE_SCALE = Random(1, 3);
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", FLAKE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", FLAKE_GRAv);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(vel, vel, -200));
	}

	void setup_hailshard()
	{
		string SHARD_SIZE = Random(1.0, 5.0);
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", SHARD_SIZE);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(90, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 3);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(-10, -10, -100));
	}

}

}
