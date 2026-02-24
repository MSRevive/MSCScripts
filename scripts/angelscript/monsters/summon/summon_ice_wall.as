#pragma context server

namespace MS
{

class SummonIceWall : CGameScript
{
	string ANIM_DEATH;
	int CANT_TURN;
	int CAN_ATTACK;
	int CAN_HUNT;
	string SCANNING;
	int f1;
	int f2;
	int r1;
	int r2;
	string rotate;

	SummonIceWall()
	{
		Precache("blueflare1.spr");
		ANIM_DEATH = "";
		CAN_ATTACK = 0;
		CAN_HUNT = 0;
		CANT_TURN = 1;
		SetCallback("touch", "enable");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.5);
		if ((SCANNING))
		{
		}
		// svplaysound: emitsound ent_me $relpos(0,0,0) 10 0.25 combat
		EmitSound(GetOwner(), /* TODO: $relpos */ $relpos(0, 0, 0), 10, 0.25, "combat");
		string PLAYER_ABOUT = /* TODO: $get_insphere */ $get_insphere("any", 200);
		CallExternal(PLAYER_ABOUT, "npcatk_settarget", GetEntityIndex(GetOwner()));
		if (GetEntityProperty(PLAYER_ABOUT, "scriptvar") > 2)
		{
			ice_death();
		}
		if ((IsValidPlayer(PLAYER_ABOUT)))
		{
		}
		if (GetEntityRange(PLAYER_ABOUT) < 75)
		{
		}
		ice_death();
	}

	void OnSpawn() override
	{
		SetHealth(15);
		SetWidth(64);
		SetHeight(64);
		SetName("Ice Wall");
		SetRoam(false);
		SetDamageResistance("fire", 10.0);
		SetSkillLevel(0);
		SetHearingSensitivity(0);
		SetModel("misc/icewall.mdl");
		SetBloodType("none");
		SetRace("hated");
		SetTurnRate(0.01);
		ScheduleDelayedEvent(0, "icewall_up");
		ScheduleDelayedEvent(30, "ice_death");
	}

	void game_dynamically_created()
	{
		PARAM1++;
		SetAngles("face.y");
		if (param3 > 1)
		{
			string FINAL_HP = param3;
			FINAL_HP *= 2;
			SetHealth(FINAL_HP);
		}
		if (!(SCANNING))
		{
			SCANNING = 1;
		}
		if (!(param2 == "firstcast")) return;
		rotate = GetEntityProperty(GetOwner(), "angles.yaw");
		rotate++;
		r1 = RandomInt(50, 70);
		r2 = RandomInt(50, 70);
		r2 *= -1;
		f1 = RandomInt(-5, 5);
		f2 = RandomInt(-5, 5);
		SpawnNPC("monsters/summon/summon_ice_wall", /* TODO: $relpos */ $relpos(f1, r1, 0), ScriptMode::Legacy); // params: rotate, 1
		SpawnNPC("monsters/summon/summon_ice_wall", /* TODO: $relpos */ $relpos(f2, r2, 0), ScriptMode::Legacy); // params: rotate, 1
	}

	void icewall_up()
	{
		PlayAnim("hold", "up");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ice_death();
	}

	void ice_death()
	{
		SetCallback("touch", "disable");
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 32), 2, 0.1, 3, 30, 0);
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 32), /* TODO: $relpos */ $relpos(0, 0, 64), 2, 0.1, 3, 30, 0);
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 64), /* TODO: $relpos */ $relpos(0, 0, 96), 5, 0.1, 3, 30, 0);
		DeleteEntity(GetOwner());
	}

	void OnTouch(CBaseEntity@ other) override
	{
		LogDebug("game_touch GetEntityName(param1)");
		if (!(IsValidPlayer(param1))) return;
		ice_death();
	}

}

}
