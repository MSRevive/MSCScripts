#pragma context server

namespace MS
{

class NpcPoisonCloudOld : CGameScript
{
	string MY_BASE_DAMAGE;
	string MY_DURATION;
	string MY_OWNER;
	string MY_OWNER_RACE;
	int PLAYING_DEAD;
	int POISONING;
	int STORMING;
	string TARG_LIST;
	string smoke_ANGLE;
	string smoke_POSITION;

	NpcPoisonCloudOld()
	{
		const string SMOKE_SPRITE = "poison_cloud.spr";
		const string SPAWN_SOUND = "ambience/steamburst1.wav";
		const string DAMAGE_TYPE = "poison";
		const string EFFECT_SCRIPT = "effects/dot_poison";
		Precache(SMOKE_SPRITE);
		POISONING = 1;
		const int HEIGHT = 40;
		const int WIDTH = 96;
		const int SCAN_RANGE = 128;
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
		MY_OWNER_RACE = GetEntityRace(param1);
		SetRace(MY_OWNER_RACE);
		MY_DURATION("poisoning_end");
		ScheduleDelayedEvent(2, "smokes_start");
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), param2, MY_DURATION);
	}

	void OnSpawn() override
	{
		PLAYING_DEAD = 1;
		SetName("Poison Cloud");
		SetHealth(1);
		SetFOV(359);
		SetInvincible(true);
		SetHeight(32);
		SetWidth(32);
		SetBloodType("none");
		SetModel("none");
		SetSolid("none");
		SetGravity(0);
		SetFly(true);
		SetNoPush(true);
		SetAngles("face");
		POISONING = 1;
		ScheduleDelayedEvent(0.5, "poisoning_go");
		ScheduleDelayedEvent(0.1, "spawn_sound");
	}

	void poisoning_go()
	{
		if (!(POISONING)) return;
		ScheduleDelayedEvent(0.5, "poisoning_go");
		TARG_LIST = FindEntitiesInSphere("enemy", SCAN_RANGE);
		if (!(TARG_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(TARG_LIST, ";"); i++)
		{
			affect_targets();
		}
	}

	void affect_targets()
	{
		string CHECK_ENT = GetToken(TARG_LIST, i, ";");
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
		ApplyEffect(CHECK_ENT, EFFECT_SCRIPT, 5.0, MY_OWNER, MY_BASE_DAMAGE);
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
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		smoke_POSITION = param1;
		smoke_ANGLE = Vector3(0, param2, 0);
		ScheduleDelayedEvent(2, "smokes_start");
		PARAM3("poison_end_cl");
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

	void spawn_sound()
	{
		EmitSound(GetOwner(), 0, SPAWN_SOUND, 10);
	}

}

}
