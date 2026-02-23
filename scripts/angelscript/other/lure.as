#pragma context server

#include "monsters/base_npc.as"
#include "monsters/debug.as"

namespace MS
{

class Lure : CGameScript
{
	string LURE_HOME_POS;
	string NEW_NAME;
	int NPC_CRITICAL;
	int NPC_CRIT_WARN_DELAY;
	int NPC_DMG_MULTI;
	string NPC_DO_EVENTS;
	int NPC_HP_MULTI;

	void OnSpawn() override
	{
		SetHealth(1);
		SetRoam(false);
		SetRace("human");
		SetBloodType("none");
		SetSkillLevel(0);
		SetWidth(32);
		SetHeight(32);
		SetModel("null.mdl");
		SetNoPush(true);
		SetSolid("trigger");
		ScheduleDelayedEvent(1.0, "get_pos");
	}

	void get_pos()
	{
		LURE_HOME_POS = GetMonsterProperty("origin");
		ScheduleDelayedEvent(20.0, "maintain_pos");
	}

	void OnSpawn() override
	{
		SetBloodType("none");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		UseTrigger("lure_died");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		SetEntityOrigin(GetOwner(), LURE_HOME_POS);
		if (!(IsValidPlayer(m_hLastStruck) == 1)) return;
		HealEntity(GetOwner(), param1);
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		LogDebug("game_takedamage GetEntityName(param1) GetEntityName(param2) PARAM3 PARAM4");
		if ((IsValidPlayer(param1)))
		{
			SetDamage("dmg");
			return;
		}
		if ((IsValidPlayer(param2)))
		{
			SetDamage("dmg");
			return;
		}
	}

	void OnDamage(int damage) override
	{
		LogDebug("game_takedamage GetEntityName(param1)");
		if (!(IsValidPlayer(param1))) return;
		SetDamage("dmg");
		SetDamage("hit");
		return;
	}

	void maintain_pos()
	{
		SetEntityOrigin(GetOwner(), LURE_HOME_POS);
		ScheduleDelayedEvent(20.0, "maintain_pos");
	}

	void make_sun()
	{
		SetName("The sun");
		SetInvincible(true);
		SetRace("hated");
	}

	void game_postspawn()
	{
		LogDebug("game_postspawn got name PARAM1 dmg PARAM2 hp PARAM3 PARAMS: PARAM4");
		NEW_NAME = param1;
		if (NEW_NAME != "default")
		{
			SetName(NEW_NAME);
		}
		NPC_DMG_MULTI = 1;
		if (param2 > 1)
		{
			NPC_DMG_MULTI += param2;
			SetDamageMultiplier(param2);
		}
		NPC_HP_MULTI = 1;
		if (param3 > 1)
		{
			NPC_HP_MULTI = param3;
		}
		NPC_DO_EVENTS = param4;
		if (!(param4 != "none")) return;
		for (int i = 0; i < GetTokenCount(NPC_DO_EVENTS, ";"); i++)
		{
			npcatk_do_events();
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(NPC_CRITICAL)) return;
		string INFO_TITLE = "A CRITICAL OBJECT HAS BEEN DESTROYED!";
		string INFO_MSG = GetEntityName(GetOwner());
		INFO_MSG += " has been destroyed! ";
		SendInfoMsg("all", "INFO_TITLE INFO_MSG");
		CallExternal(GAME_MASTER, "gm_crit_npc_died", GetEntityIndex(GetOwner()), GetEntityIndex(m_hLastStruck));
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((NPC_CRITICAL))
		{
			if (!(NPC_CRIT_WARN_DELAY))
			{
				NPC_CRIT_WARN_DELAY = 1;
				NPC_FREQ_WARN("npcatk_reset_warn_delay");
				string INFO_TITLE = "Critical Object Under Attack!";
				string INFO_MSG = GetEntityName(GetOwner());
				INFO_MSG += " is under attack!";
				SendInfoMsg("all", "INFO_TITLE INFO_MSG");
			}
		}
	}

	void critical_npc()
	{
		SetInvincible(false);
		NPC_CRITICAL = 1;
		if (G_CRITICAL_NPCS.length() > 0) G_CRITICAL_NPCS += ";";
		G_CRITICAL_NPCS += GetEntityIndex(GetOwner());
		SetGlobalVar("G_SIEGE_MAP", 1);
		string FIRST_TOKEN = GetToken(G_CRITICAL_NPCS, 0, ";");
		if (!(IsEntityAlive(FIRST_TOKEN)))
		{
			RemoveToken(G_CRITICAL_NPCS, 0, ";");
		}
	}

	void npcatk_reset_warn_delay()
	{
		NPC_CRIT_WARN_DELAY = 0;
	}

}

}
