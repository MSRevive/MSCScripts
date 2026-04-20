#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"

namespace MS
{

class UndamaelHead : CGameScript
{
	int IMMUNE_VAMPIRE;
	string LAST_PLR_TOUCH;
	string MY_OWNER;
	int NO_SOLID;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string VULNERABLE;

	UndamaelHead()
	{
		SetCallback("touch", "enable");
		NPC_HACKED_MOVE_SPEED = 100;
		NPC_GIVE_EXP = 15000;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		string DEST_LOC = GetEntityProperty(MY_OWNER, "attachpos");
		SetEntityOrigin(GetOwner(), DEST_LOC);
		if (GetGameTime() < LAST_PLR_TOUCH)
		{
			SetSolid("trigger");
		}
		else
		{
			SetSolid("slidebox");
		}
	}

	void OnSpawn() override
	{
		SetName("head_undi");
		SetName("Undamael");
		SetRace("undead");
		SetHealth(20000);
		SetModel("monsters/undamael_hitbox.mdl");
		SetBloodType("red");
		SetWidth(128);
		SetHeight(128);
		SetRoam(false);
		SetFly(true);
		SetSolid("box");
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
		SetModelBody(0, 0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		IMMUNE_VAMPIRE = 1;
		SetNoPush(true);
		npcatk_suspend_ai();
		ScheduleDelayedEvent(1.0, "check_vulnerable");
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
	}

	void OnDamage(int damage) override
	{
		if ((VULNERABLE)) return;
		SetHealth(GetEntityMaxHealth(GetOwner()));
		DoDamage(param1, "direct", param2, 1.0, param3);
		SetDamage("dmg");
		SetDamage("hit");
		return;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		LogDebug("head struck");
		if (GetEntityProperty(MY_OWNER, "scriptvar") == "unset")
		{
			CallExternal(MY_OWNER, "npcatk_settarget", GetEntityIndex(m_hLastStruck), "struck");
		}
		else
		{
			if (RandomInt(1, 100) < 50)
			{
			}
			CallExternal(MY_OWNER, "npcatk_settarget", GetEntityIndex(m_hLastStruck), "struck");
		}
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(IsValidPlayer(param1))) return;
		LAST_PLR_TOUCH = GetGameTime();
		LAST_PLR_TOUCH += 0.25;
	}

	void ext_solid_on()
	{
		NO_SOLID = 0;
		SetSolid("slidebox");
	}

	void ext_show_head()
	{
		SetModelBody(0, 1);
		SetProp(GetOwner(), "renderamt", 64);
	}

	void ext_unsolid()
	{
		LAST_PLR_TOUCH = GetGameTime();
		LAST_PLR_TOUCH += param1;
		SetSolid("trigger");
	}

	void ext_vulnerable()
	{
		VULNERABLE = param1;
	}

	void do_nuke()
	{
		LogDebug("doing nuke");
		string L_DMG = param2;
		TossProjectile("proj_meteor", /* TODO: $relpos */ $relpos(0, 0, 0), GetEntityIndex(param1), 150, L_DMG, 2, "none");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(MY_OWNER, "death_sequence");
	}

	void check_vulnerable()
	{
		if (!(G_UNDAMAEL_VULNERABLE)) return;
		VULNERABLE = 1;
	}

}

}
