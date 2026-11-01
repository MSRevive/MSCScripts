#pragma context server

namespace MS
{

class MaldoraDead : CGameScript
{
	string ANIM_IDLE;
	string AXE_ITEM;
	string AXE_TYPE;
	string BARRIER_ID;
	int DEATH_ACCEL;
	int FLY_COUNT;
	int I_AM_TURNABLE;
	string MONSTER_MODEL;
	string MY_Z;
	int NO_SPAWN_STUCK_CHECK;
	string ROOF_HEIGHT;
	string SOUND_LAUGH;

	MaldoraDead()
	{
		ANIM_IDLE = "idle";
		SOUND_LAUGH = "monsters/skeleton/cal_laugh.wav";
		MONSTER_MODEL = "monsters/maldora.mdl";
		Precache(MONSTER_MODEL);
		NO_SPAWN_STUCK_CHECK = 1;
		I_AM_TURNABLE = 0;
		Precache("doors/aliendoor3.wav");
		Precache("magic/spawn.wav");
	}

	void OnSpawn() override
	{
		SetName("Fragment of Maldora");
		SetHealth(3000);
		SetRace("demon");
		SetInvincible(true);
		SetModel(MONSTER_MODEL);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetSolid("none");
		SetWidth(32);
		SetHeight(86);
		SetBloodType("none");
		SetRoam(false);
		SetSayTextRange(2048);
		SetName("dead_maldora");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
	}

	void game_precache()
	{
		Precache("monsters/summon/barrier");
	}

	void make_barrier()
	{
		SpawnNPC("monsters/summon/barrier", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 128, 1, 0
		BARRIER_ID = GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.25, "get_orc_ids");
	}

	void game_dynamically_created()
	{
		DEATH_ACCEL = 20;
		if (param1 != "crow")
		{
			if (param1 != "crow_final")
			{
			}
			ScheduleDelayedEvent(0.1, "make_barrier");
		}
		if (param1 == "death")
		{
			DEATH_ACCEL = 10;
			death_exit();
		}
		if (param1 == "crow")
		{
			DEATH_ACCEL = 10;
			fly_out();
		}
		if (param1 == "crow_final")
		{
			DEATH_ACCEL = 10;
			SetProp(GetOwner(), "rendermode", 0);
			SetProp(GetOwner(), "renderamt", 255);
			fly_out();
			LogDebug("drop_axe PARAM2");
			if (param2 > -1)
			{
			}
			ScheduleDelayedEvent(0.5, "spawn_axe");
			AXE_TYPE = param2;
		}
	}

	void spawn_axe()
	{
		SayText("Here fools, you've earned a gift...");
		EmitSound(GetOwner(), 0, "voices/lodagond-4/maldora_reward.wav", 10);
		if (AXE_TYPE == 0)
		{
			AXE_ITEM = "axes_tf";
		}
		if (AXE_TYPE == 1)
		{
			AXE_ITEM = "axes_td";
		}
		if (AXE_TYPE == 2)
		{
			AXE_ITEM = "axes_ti";
		}
		if (AXE_TYPE == 3)
		{
			AXE_ITEM = "axes_tp";
		}
		if (AXE_TYPE == 4)
		{
			AXE_ITEM = "axes_tl";
		}
		SetProp(GetOwner(), "skin", 5);
		CallExternal(GAME_MASTER, "gm_drop_item", 1.0, AXE_ITEM, GetEntityOrigin(GetOwner()), 1);
	}

	void say_gaveyou1()
	{
		PlayAnim("critical", "ref_shoot_squeak");
		SayText(I + " ve empowered your shamans. I ve given your troops all the poison they could ever use...");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/fmaldora_2voldar1.wav", 10);
	}

	void say_gaveyou2()
	{
		SayText("...and " + I + " ve granted you your own magical powers... Just as we agreed.");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/fmaldora_2voldar2.wav", 10);
	}

	void say_gaveyou3()
	{
		PlayAnim("critical", "look_idle");
		if (GetPlayerCount() == 1)
		{
			SayText("But if you can t stop one pathetic human, with all of that power...");
		}
		if (GetPlayerCount() == 2)
		{
			SayText("But if you can t stop a pair of puny humans, with all of that power...");
		}
		if (GetPlayerCount() == 3)
		{
			SayText("But if you can t stop a three puny humans, with all of that power...");
		}
		if (GetPlayerCount() == 4)
		{
			SayText("But if you can t stop a four puny humans, with all of that power...");
		}
		if (GetPlayerCount() == 5)
		{
			SayText("But if you can t stop a five puny humans, with all of that power...");
		}
		if (GetPlayerCount() == 6)
		{
			SayText("But if you can t stop a six puny humans, with all of that power...");
		}
		if (GetPlayerCount() > 6)
		{
			SayText("But if you can t stop a couple of puny humans, with all of that power...");
		}
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/fmaldora_2voldar3.wav", 10);
	}

	void say_gaveyou4()
	{
		SayText("...then you aren t of much use to me, are you?");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/fmaldora_2voldar4.wav", 10);
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void face_me()
	{
		SetAngles("face_origin");
		ScheduleDelayedEvent(0.1, "straighten_up");
	}

	void straighten_up()
	{
		SetAngles("face");
	}

	void fly_out()
	{
		CallExternal(BARRIER_ID, "remove_barrier");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/fmaldora_exit4.wav", 10);
		SetFly(true);
		FLY_COUNT = 0;
		string TRACE_ORG = GetMonsterProperty("origin");
		string TRACE_END = /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 2000));
		string TRACE_LINE = TraceLine(TRACE_ORG, TRACE_END);
		ROOF_HEIGHT = (TRACE_LINE).z;
		ROOF_HEIGHT += 128;
		ScheduleDelayedEvent(0.1, "fly_out_loop");
	}

	void fly_out_loop()
	{
		string MY_X = (GetMonsterProperty("origin")).x;
		string MY_Y = (GetMonsterProperty("origin")).y;
		MY_Z = (GetMonsterProperty("origin")).z;
		MY_Z += DEATH_ACCEL;
		SetEntityOrigin(GetOwner(), Vector3(MY_X, MY_Y, MY_Z));
		if (MY_Z > ROOF_HEIGHT)
		{
			remove_me();
		}
		if (MY_Z <= ROOF_HEIGHT)
		{
			ScheduleDelayedEvent(0.1, "fly_out_loop");
		}
	}

	void death_exit()
	{
		SayText("Well , it seems what my master said maybe true... Maybe you are amongst the chosen ones.");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/fmaldora_exit1.wav", 10);
		ScheduleDelayedEvent(5.7, "death_exit2");
	}

	void death_exit2()
	{
		SayText("If so , you maybe useful. We will meet again one day , to put that to the test.");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/fmaldora_exit2.wav", 10);
		string L_MAP_NAME = StringToLower(GetMapName());
		if (L_MAP_NAME == "ms_wicardoven")
		{
			ScheduleDelayedEvent(5.9, "death_exit3");
		}
		if (L_MAP_NAME != "ms_wicardoven")
		{
			ScheduleDelayedEvent(1.0, "fly_out");
		}
	}

	void death_exit3()
	{
		SayText("That is , if you even survive the desert beyond.");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/fmaldora_exit3.wav", 10);
		ScheduleDelayedEvent(3.9, "fly_out");
	}

}

}
