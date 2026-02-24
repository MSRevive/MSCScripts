#pragma context server

#include "monsters/externals.as"

namespace MS
{

class TriggerBase : CGameScript
{
	float HOME_DELAY;
	string HOME_POS;
	int IAM_ON;
	int PLAYING_DEAD;
	float RESET_DELAY;
	int TAKE_IT;
	string TRIGGER_STRING;
	string TRIG_DELAY;

	TriggerBase()
	{
		HOME_DELAY = Random(10, 20);
		RESET_DELAY = 30.0;
	}

	void OnSpawn() override
	{
		SetNoPush(true);
		SetHealth(1500);
		TAKE_IT = 0;
		SetName("Elemental Shard");
		SetRace("demon");
		SetModel("crystal.mdl");
		SetWidth(15);
		SetHeight(60);
		SetMoveSpeed(0.0);
		SetBloodType("none");
		SetGravity(0);
		SetFly(true);
		TRIGGER_STRING = "toggle_";
		TRIGGER_STRING += ELEMENT_TYPE;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		ScheduleDelayedEvent(1.0, "get_origin");
		SetMoveAnim("spin");
		SetIdleAnim("spin");
		SetDamageResistance("all", 0.33);
		SetDamageResistance("stun", 0);
		PLAYING_DEAD = 1;
		HOME_DELAY("reset_pos");
		glow_loop();
		trigger_spawn();
	}

	void glow_loop()
	{
		ScheduleDelayedEvent(5.3, "glow_loop");
		if (getCount > 0)
		{
			CallExternal("all", "npcatk_ally_alert", getEnt1, GetEntityIndex(GetOwner()), "crystal_alert");
		}
		if (ELEMENT_TYPE == "lightning")
		{
			Effect("glow", GetOwner(), Vector3(255, 255, 0), 128, 10, 10);
		}
		if (ELEMENT_TYPE == "cold")
		{
			Effect("glow", GetOwner(), Vector3(4, 50, 128), 128, 10, 10);
		}
		if (ELEMENT_TYPE == "fire")
		{
			Effect("glow", GetOwner(), Vector3(255, 0, 0), 128, 10, 10);
		}
		if (ELEMENT_TYPE == "poison")
		{
			Effect("glow", GetOwner(), Vector3(0, 255, 0), 128, 10, 10);
		}
	}

	void get_origin()
	{
		HOME_POS = GetMonsterProperty("origin");
	}

	void reset_pos()
	{
		SetEntityOrigin(GetOwner(), HOME_POS);
		ScheduleDelayedEvent(11.0, "reset_pos");
	}

	void OnDamage(int damage) override
	{
		if (GetMonsterHP() < GetMonsterMaxHP())
		{
			string DIFF = GetMonsterMaxHP();
			DIFF -= GetMonsterHP();
			HealEntity(GetOwner(), DIFF);
		}
		SetEntityOrigin(GetOwner(), HOME_POS);
		string DMG_TYPE = param3;
		SetDamage("dmg");
		check_damage_type(DMG_TYPE);
	}

	void check_damage_type()
	{
		int L_DAMAGED = 0;
		if ((ELEMENT_TYPE).findFirst(param1) >= 0)
		{
			int L_DAMAGED = 1;
		}
		if ((param1).findFirst("acid") >= 0)
		{
			if ((ELEMENT_TYPE).findFirst("poison") >= 0)
			{
				int L_DAMAGED = 1;
			}
		}
		if (!(L_DAMAGED)) return;
		if (!(TRIG_DELAY))
		{
			TRIG_DELAY = 1;
		}
		element_on();
	}

	void trig_reset()
	{
		IAM_ON = 0;
		SetEntityOrigin(GetOwner(), HOME_POS);
		TRIG_DELAY = 0;
		string MON_NAME = FindEntityByName("ele_monitor");
		string MON_ID = GetEntityIndex(MON_NAME);
		if (!(TRIG_DELAY))
		{
			CallExternal(MON_ID, "trigger_off", ELEMENT_TYPE);
		}
		UseTrigger(TRIGGER_STRING);
	}

	void element_trigs_remove()
	{
		DeleteEntity(GetOwner());
	}

	void element_on()
	{
		if ((IAM_ON)) return;
		IAM_ON = 1;
		string MON_ID = FindEntityByName("ele_monitor");
		CallExternal(MON_ID, "trigger_on", ELEMENT_TYPE);
		UseTrigger(TRIGGER_STRING);
	}

	void effect_damage()
	{
		check_damage_type(param4);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SendInfoMsg("all", OMFG_WTF + " MAJOR MAP ERROR - AN A ELEMENTAL CRYSTAL DIED! WTF!?");
	}

}

}
