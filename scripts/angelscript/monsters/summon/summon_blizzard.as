#pragma context server

#include "monsters/summon/base_aoe.as"

namespace MS
{

class SummonBlizzard : CGameScript
{
	string ACTIVE_SKILL;
	string END_POS;
	string FLAKE_HEIGHT;
	string GAME_PVP;
	string MY_ANGLES;
	string MY_BASE_DMG;
	int MY_BASE_DURATION;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string ROOF_HEIGHT;
	float SCAN_RATE;
	string SHARD_HEIGHT;
	int SNOWING;
	string SNOW_CENTER;
	string TIME_LIVE;
	string vel;

	SummonBlizzard()
	{
		const float AOE_FREQ = 2.0;
		const int AOE_RADIUS = 172;
		const float FREQ_NOISE = 8.0;
		const int BLIZZARD_RANGE = 172;
		const string SHARD_MODEL = "glassgibs.mdl";
		Precache("snow1.spr");
		Precache(SHARD_MODEL);
		SCAN_RATE = 2.0;
		const int WIDTH = 100;
		const int HEIGHT = 200;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.12);
		string NEGWIDTH = WIDTH;
		NEGWIDTH *= -1;
		string NEGWIDTH = WIDTH;
		NEGWIDTH *= -1;
		string x = RandomInt(NEGWIDTH, WIDTH);
		string y = RandomInt(NEGWIDTH, WIDTH);
		END_POS += SNOW_CENTER;
		ClientEffect("tempent", "sprite", "snow1.spr", END_POS, "setup_blizzardflake");
		string NEGWIDTH = WIDTH;
		NEGWIDTH *= -1;
		string x = RandomInt(NEGWIDTH, WIDTH);
		string y = RandomInt(NEGWIDTH, WIDTH);
		END_POS += SNOW_CENTER;
		ClientEffect("tempent", "sprite", SHARD_MODEL, END_POS, "setup_hailshard");
		string NEGWIDTH = WIDTH;
		NEGWIDTH *= -1;
		string x = RandomInt(NEGWIDTH, WIDTH);
		string y = RandomInt(NEGWIDTH, WIDTH);
		END_POS += SNOW_CENTER;
		ClientEffect("tempent", "sprite", SHARD_MODEL, END_POS, "setup_hailshard");
	}

	void snow_start()
	{
		SNOWING = 1;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_ANGLES = param2;
		MY_BASE_DMG = param3;
		MY_BASE_DURATION = 10;
		ACTIVE_SKILL = param5;
		if (ACTIVE_SKILL == "PARAM5")
		{
			ACTIVE_SKILL = "spellcasting.ice";
		}
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		GAME_PVP = "game.pvp";
		if ((OWNER_ISPLAYER))
		{
			SCAN_RATE = 1.0;
		}
		SetAngles("face.y");
		TIME_LIVE = MY_BASE_DURATION;
		string TRACE_START = GetMonsterProperty("origin");
		string TRACE_END = TRACE_START;
		TRACE_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 2000));
		string ROOF_HEIGHT = TraceLine(TRACE_START, TRACE_END);
		if (Distance(ROOF_HEIGHT, GetMonsterProperty("origin")) > 512)
		{
			string ROOF_HEIGHT = GetMonsterProperty("origin");
			ROOF_HEIGHT += "z";
		}
		string MY_X = (GetMonsterProperty("origin")).x;
		string MY_Y = (GetMonsterProperty("origin")).y;
		string GRND_Z = (MY_OWNER).z;
		Vector3 SNOWFX_SPAWN = Vector3(MY_X, MY_Y, GRND_Z);
		if ((OWNER_ISPLAYER))
		{
			ClientEvent("new", "all", currentscript, SNOWFX_SPAWN, TIME_LIVE, ROOF_HEIGHT);
			TIME_LIVE("blizzard_death");
			snow_start();
		}
		if (!(OWNER_ISPLAYER))
		{
			ClientEvent("new", "all", currentscript, SNOWFX_SPAWN, TIME_LIVE, ROOF_HEIGHT);
			TIME_LIVE("blizzard_death");
			snow_start();
		}
	}

	void OnSpawn() override
	{
		SetName("Blizzard");
		SetInvincible(true);
		SetRace("beloved");
		SetModel("none");
		SetSolid("none");
		PLAYING_DEAD = 1;
		SetNoPush(true);
		SetGravity(0);
		SetRoam(false);
		if (!(true)) return;
		EmitSound(GetOwner(), 0, "amb/windy.wav", 10);
		FREQ_NOISE("do_noise");
	}

	void do_noise()
	{
		if (!(IS_ACTIVE)) return;
		EmitSound(GetOwner(), 0, "amb/windy.wav", 10);
		FREQ_NOISE("do_noise");
	}

	void blizzard_death()
	{
		DeleteEntity(GetOwner());
	}

	void apply_aoe_effect()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		ApplyEffect(param1, "effects/dot_cold", 5, MY_OWNER, MY_BASE_DMG, ACTIVE_SKILL);
	}

	void client_activate()
	{
		SNOW_CENTER = param1;
		ROOF_HEIGHT = param3;
		ROOF_HEIGHT = (ROOF_HEIGHT).z;
		END_POS = SNOW_CENTER;
		PARAM2("blizzard_end_cl");
		FLAKE_HEIGHT = (ROOF_HEIGHT).z;
		SHARD_HEIGHT = (ROOF_HEIGHT).z;
		SHARD_HEIGHT -= 64;
	}

	void blizzard_end_cl()
	{
		RemoveScript();
	}

	void setup_blizzardflake()
	{
		vel = RandomInt(-50, 50);
		string FLAKE_GRAv = Random(0.2, 2.1);
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.2);
		ClientEffect("tempent", "set_current_prop", "gravity", FLAKE_GRAv);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(vel, vel, -200));
	}

	void setup_hailshard()
	{
		string SHARD_SIZE = Random(1.0, 3.0);
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", SHARD_SIZE);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(90, 0, 0));
		ClientEffect("tempent", "set_current_prop", "angle", Vector3(90, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 3);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(-10, -10, -100));
	}

}

}
