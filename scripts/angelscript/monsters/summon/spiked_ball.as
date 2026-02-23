#pragma context server

namespace MS
{

class SpikedBall : CGameScript
{
	string DMG_MULTI;
	int GROUND_PULSE;
	int IS_ACTIVE;
	string MY_OWNER;
	string NEXT_DMG;
	int N_DMG_TIMES;
	string OLD_SPEED;
	int PLAYING_DEAD;
	string PUSH_LIST;
	string START_VEL;
	string TOUCH_TARG;

	SpikedBall()
	{
		const string SPRITE_EXPLODE = "bigsmoke.spr";
		const string SOUND_EXPLODE = "weapons/explode3.wav";
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		START_VEL = param2;
		DMG_MULTI = param3;
		SetCallback("touch", "enable");
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.01, "boost_and_scan");
		ScheduleDelayedEvent(10.0, "go_splodie");
	}

	void OnSpawn() override
	{
		SetName("Spiked Ball");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 64);
		SetWidth(48);
		SetHeight(48);
		SetGravity(2);
		SetIdleAnim("spin_vertical_norm");
		SetProp(GetOwner(), "movetype", "const.movetype.bounce");
		SetProp(GetOwner(), "friction", 0.2);
		SetInvincible(true);
		SetRace("beloved");
		PLAYING_DEAD = 1;
	}

	void boost_and_scan()
	{
		AddVelocity(GetOwner(), START_VEL);
		OLD_SPEED = GetEntitySpeed(GetOwner());
		N_DMG_TIMES = 0;
		GROUND_PULSE = 0;
		monitor_speed();
	}

	void monitor_speed()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "monitor_speed");
		string CUR_SPEED = GetEntitySpeed(GetOwner());
		if (CUR_SPEED < 200)
		{
			if (OLD_SPEED < 200)
			{
			}
			go_splodie();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		string MY_GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		MY_Z -= MY_GROUND_Z;
		if (MY_Z < 10)
		{
			GROUND_PULSE += 1;
			EmitSound(GetOwner(), 0, "debris/bustmetal2.wav", 10);
			if (GROUND_PULSE > 2)
			{
			}
			go_splodie();
		}
		OLD_SPEED = CUR_SPEED;
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(IS_ACTIVE)) return;
		TOUCH_TARG = param1;
		ScheduleDelayedEvent(0.01, "damage_touched");
	}

	void damage_touched()
	{
		if (!(GetGameTime() > NEXT_DMG)) return;
		NEXT_DMG = GetGameTime();
		NEXT_DMG += 0.25;
		N_DMG_TIMES += 1;
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
		string DMG_AMT = GetEntitySpeed(GetOwner());
		DMG_AMT *= DMG_MULTI;
		if (GetEntityProperty(MY_OWNER, "dmgmulti") > 0)
		{
			DMG_SMT *= GetEntityProperty(MY_OWNER, "dmgmulti");
		}
		EmitSound(GetOwner(), 0, "debris/bustmetal2.wav", 10);
		XDoDamage(TOUCH_TARG, "direct", DMG_AMT, 1.0, MY_OWNER, MY_OWNER, "none", "blunt_effect");
		if (N_DMG_TIMES > 10)
		{
			ScheduleDelayedEvent(0.1, "go_splodie");
		}
	}

	void go_splodie()
	{
		Effect("tempent", "spray", SPRITE_EXPLODE, GetMonsterProperty("origin"), 0, 1, 0, 0);
		SetModel("none");
		string DMG_AMT = DMG_MULTI;
		DMG_AMT *= 300;
		XDoDamage(GetEntityOrigin(GetOwner()), 128, DMG_AMT, 0, MY_OWNER, MY_OWNER, "none", "fire_effect");
		PUSH_LIST = FindEntitiesInSphere("enemy", 128);
		if (PUSH_LIST != "none")
		{
			for (int i = 0; i < GetTokenCount(PUSH_LIST, ";"); i++)
			{
				push_loop();
			}
		}
		EmitSound(GetOwner(), 0, SOUND_EXPLODE, 10);
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void push_loop()
	{
		string CUR_TARGET = GetToken(PUSH_LIST, i, ";");
		string TARGET_ORG = GetEntityOrigin(CUR_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		SetVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 110)));
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
