#pragma context server

namespace MS
{

class CannonManned : CGameScript
{
	string AIMER_ID;
	int AM_AIMING;
	int FIRE_DELAY;
	string SRC_YAW;

	CannonManned()
	{
		const string SPRITE_EXPLODE = "bigsmoke.spr";
		const string SOUND_CANNON = "weapons/explode3.wav";
		const float FREQ_FIRE = 30.0;
		const int DMG_CANNON = 1000;
	}

	void OnSpawn() override
	{
		SetName("Cannon");
		SetModel("props/cannon.mdl");
		SetInvincible(true);
		SetBloodType("none");
		SetWidth(32);
		SetHeight(48);
		SetHealth(20);
		SetRoam(false);
		SetMenuAutoOpen(1);
		SetNoPush(true);
		ScheduleDelayedEvent(0.1, "get_src_yaw");
	}

	void get_src_yaw()
	{
		SRC_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
	}

	void game_menu_getoptions()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		SRC_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		if (!(FIRE_DELAY))
		{
			if (!(AM_AIMING))
			{
				AM_AIMING = 1;
				aim_loop();
				AIMER_ID = param1;
			}
			string reg.mitem.title = "Fire!";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "fire_cannon";
			string reg.mitem.title = "Aim";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "aim_cannon";
		}
		if ((FIRE_DELAY))
		{
			string reg.mitem.title = "Reloading...";
			string reg.mitem.type = "disabled";
			string reg.mitem.callback = "none";
		}
	}

	void game_menu_cancel()
	{
		AM_AIMING = 0;
	}

	void aim_cannon()
	{
		AM_AIMING = 1;
		AIMER_ID = param1;
		aim_loop();
	}

	void aim_loop()
	{
		if (!(AM_AIMING)) return;
		if (GetEntityRange(AIMER_ID) > 64)
		{
			int EXIT_SUB = 1;
			AM_AIMING = 0;
		}
		if ((EXIT_LOOP)) return;
		ScheduleDelayedEvent(0.1, "aim_loop");
		string AIMER_YAW = GetEntityProperty(AIMER_ID, "angles.yaw");
		string ANG_DIFF = /* TODO: $anglediff */ $anglediff(AIMER_YAW, SRC_YAW);
		LogDebug("aim_loop ANG_DIFF");
		int AIM_OKAY = 0;
		if (ANG_DIFF >= -45)
		{
			if (ANG_DIFF <= 45)
			{
			}
			int AIM_OKAY = 1;
		}
		if (!(AIM_OKAY)) return;
		SetAngles("face");
	}

	void fire_cannon()
	{
		AM_AIMING = 0;
		EmitSound(GetOwner(), 0, SOUND_CANNON, 10);
		if (StringToLower(GetMapName()) != "oceancrossing")
		{
			SetAngles("add_view.x");
		}
		TossProjectile("proj_cannon_ball", /* TODO: $relpos */ $relpos(0, 32, 32), "none", 400, DMG_CANNON, 0, "none");
		Effect("tempent", "spray", SPRITE_EXPLODE, /* TODO: $relpos */ $relpos(0, 0, 0), 0, 1, 0, 0);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 380, 20, 1, 512);
		FIRE_DELAY = 1;
		FREQ_FIRE("reset_fire_delay");
		UseTrigger("cannon_fired");
		PlayAnim("critical", "shoot");
	}

	void reset_fire_delay()
	{
		FIRE_DELAY = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetMenuAutoOpen(0);
		EmitSound(GetOwner(), 0, "debris/bustcrate3.wav", 10);
		PlayAnim("critical", "die");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: "debris/wood1.wav", "debris/wood2.wav"
		array<string> sounds = {"debris/wood1.wav", "debris/wood2.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
