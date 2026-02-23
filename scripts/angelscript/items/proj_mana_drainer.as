#pragma context server

namespace MS
{

class ProjManaDrainer : CGameScript
{
	string F_MP_DRAIN_RATE;
	string MP_DRAIN_OVERRIDE;

	ProjManaDrainer()
	{
		const int MP_DRAIN_RATE = 1;
		const string CL_SCRIPT = "items/proj_mana_drainer_cl";
		const string HOVER_SOUND = "ambience/labdrone2.wav";
		const string SOUND_POP = "turret/tu_die2.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		LogDebug("pulse");
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, Random(0, 359), 0), Vector3(0, 500, 0)));
		string SCAN_TARGET = /* TODO: $get_insphere */ $get_insphere("player", 64, GetMonsterProperty("origin"));
		if ((IsEntityAlive(SCAN_TARGET)))
		{
		}
		LogDebug("drain target GetEntityName(SCAN_TARGET) F_MP_DRAIN_RATE");
		SendColoredMessage(SCAN_TARGET, "A corpse light is draining your mana!");
		if (GetEntityMP(SCAN_TARGET) <= 0)
		{
			CallExternal("ent_expowner", "drainer_kill", SCAN_TARGET);
			ScheduleDelayedEvent(0.1, "end_life");
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(30.0);
		// svplaysound: svplaysound 1 5 HOVER_SOUND
		EmitSound(1, 5, HOVER_SOUND);
	}

	void game_precache()
	{
	}

	void OnSpawn() override
	{
		SetName("Mana Drainer");
		SetWidth(16);
		SetHeight(16);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 13);
		SetIdleAnim("spin_horizontal_slow");
		PlayAnim("once", "spin_horizontal_slow");
		// TODO: movetype normal
		SetSolid("none");
		SetGravity(0);
		SetFly(true);
		int reg.proj.dmg = 0;
		string reg.proj.dmgtype = "none";
		int reg.proj.aoe.range = 0;
		int reg.proj.aoe.falloff = 0;
		int reg.proj.stick.duration = 0;
		int reg.proj.collidehitbox = 0;
		int reg.proj.ignorenpc = 1;
		int reg.proj.ignoreworld = 1;
		SetMonsterClip(0);
		RegisterProjectile();
		ScheduleDelayedEvent(60.0, "end_life");
	}

	void game_tossprojectile()
	{
		// TODO: UNCONVERTED: usable 0
		F_MP_DRAIN_RATE = MP_DRAIN_RATE;
		MP_DRAIN_OVERRIDE = GetEntityProperty("ent_expowner", "scriptvar");
		if (MP_DRAIN_OVERRIDE != "DRAINER_POWER")
		{
			F_MP_DRAIN_RATE = MP_DRAIN_OVERRIDE;
		}
		// svplaysound: svplaysound 1 5 HOVER_SOUND
		EmitSound(1, 5, HOVER_SOUND);
	}

	void end_life()
	{
		CallExternal("ent_expowner", "drainer_died");
		// svplaysound: svplaysound 1 0 HOVER_SOUND
		EmitSound(1, 0, HOVER_SOUND);
		EmitSound(GetOwner(), 0, SOUND_POP, 10);
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
		RemoveScript();
	}

}

}
