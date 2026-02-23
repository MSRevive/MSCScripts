#pragma context server

namespace MS
{

class PoisonCloud : CGameScript
{
	int IN_POISON_LOOP;
	int LOOP_COUNT;
	string MY_BASE_DAMAGE;
	string MY_DURATION;
	string MY_OWNER;
	string MY_OWNER_RACE;
	string MY_SKILL;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	int POISONING;
	int STORMING;
	string smoke_ANGLE;
	string smoke_POSITION;

	PoisonCloud()
	{
		const string SMOKE_SPRITE = "poison_cloud.spr";
		Precache(SMOKE_SPRITE);
		POISONING = 1;
		const int HEIGHT = 40;
		const int WIDTH = 96;
		const string POISON_SPRITE = "poison_cloud.spr";
		const int HEIGHT = 40;
		const int WIDTH = 96;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1);
		if ((STORMING))
		{
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.25);
		if ((STORMING))
		{
		}
		smokes_shoot();
	}

	void smokes_start()
	{
		STORMING = 1;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_BASE_DAMAGE = param3;
		MY_DURATION = param4;
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		MY_OWNER_RACE = GetEntityRace(param1);
		string MY_SKILL = param5;
		if ((MY_SKILL).findFirst("PARAM") == 0)
		{
			MY_SKILL = "spellcasting.affliction";
		}
		MY_DURATION("poisoning_end");
		ScheduleDelayedEvent(2, "smokes_start");
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), param2, MY_DURATION);
		StoreEntity("ent_expowner");
	}

	void OnSpawn() override
	{
		PLAYING_DEAD = 1;
		SetName("Poison Cloud");
		SetHealth(1);
		SetInvincible(true);
		SetRace("beloved");
		SetHeight(32);
		SetWidth(32);
		SetBloodType("none");
		SetModel("none");
		SetSolid("none");
		SetAngles("face");
		POISONING = 1;
		ScheduleDelayedEvent(0.5, "poisoning_go");
	}

	void poisoning_go()
	{
		if (!(POISONING)) return;
		ScheduleDelayedEvent(1.0, "poisoning_go");
		// TODO: getents any 256
		if (!(getCount > 0)) return;
		if ((IN_POISON_LOOP)) return;
		IN_POISON_LOOP = 1;
		LOOP_COUNT = 0;
		poison_area();
	}

	void poison_area()
	{
		if (!(POISONING)) return;
		ScheduleDelayedEvent(0.1, "poison_area");
		LOOP_COUNT += 1;
		if (LOOP_COUNT > 9)
		{
			LOOP_COUNT = 1;
		}
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
		if (!(IsEntityAlive(CHECK_ENT))) return;
		if (!(GetEntityRange(CHECK_ENT) < 256)) return;
		if (!(GetRelationship(CHECK_ENT) == "enemy")) return;
		if ("game.pvp" == 0)
		{
			if ((OWNER_ISPLAYER))
			{
			}
			if ((IsValidPlayer(CHECK_ENT)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TRACE_START = GetEntityOrigin(GetOwner());
		string TRACE_END = GetEntityOrigin(CHECK_ENT);
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		if ((GetEntityProperty(CHECK_ENT, "haseffect"))) return;
		ApplyEffect(CHECK_ENT, "effects/dot_poison", 2.5, MY_OWNER, MY_BASE_DAMAGE);
	}

	void poisoning_end()
	{
		ClientEvent("remove", "all", currentscript);
		POISONING = 0;
		STORMING = 0;
		ScheduleDelayedEvent(0.1, "remove_final");
	}

	void remove_final()
	{
		RemoveScript();
		ClientEvent("remove", "all", currentscript);
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		smoke_POSITION = param1;
		smoke_ANGLE = Vector3(0, param2, 0);
		ScheduleDelayedEvent(2, "smokes_start");
		string CL_TIME_LIVE = param3;
		CL_TIME_LIVE -= 0.5;
		CL_TIME_LIVE("poison_end_cl");
	}

	void poison_end_cl()
	{
		STORMING = 0;
		RemoveScript();
	}

	void smokes_start()
	{
		STORMING = 1;
	}

	void smokes_shoot()
	{
		string NEGWIDTH = WIDTH;
		NEGWIDTH *= -1;
		string x = RandomInt(NEGWIDTH, WIDTH);
		string y = RandomInt(NEGWIDTH, WIDTH);
		string L_POS = /* TODO: $relpos */ $relpos(smoke_ANGLE, Vector3(x, y, HEIGHT));
		L_POS += smoke_POSITION;
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
	}

	void setup_smokes()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
