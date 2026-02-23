#pragma context server

#include "monsters/externals.as"
#include "monsters/base_self_adjust.as"

namespace MS
{

class BaseNpc : CGameScript
{
	int EFFECT_DAMAGE_DELAY;
	int EXT_DAMAGE_ADJUSTMENT;
	int EXT_HITCHANCE_ADJUSTMENT;
	int HAS_INCLUDE_NPC;
	string IMMUNE_VAMPIRE;
	string IN_ICECAGE;
	string IS_BLOODLESS;
	int NPC_CRIT_WARN_DELAY;
	int NPC_DID_DEATH;
	string NPC_FIGHTS_NPCS;
	string NPC_FRIENDLY;
	string NPC_GAVE_XP_MSG;
	string NPC_REACT_CANSEETARGET;
	string NPC_REACT_LAST_TARGET;
	string NPC_REACT_RESET_TARGET_TIME;

	BaseNpc()
	{
		const float NPC_FREQ_WARN = 5.0;
		HAS_INCLUDE_NPC = 1;
		const string NPC_DEATH_MSG = "unset";
		const int NPC_AUTO_DEATH = 1;
		const string SOUND_DEATH = "none";
	}

	void display_timing()
	{
		SendInfoMsg("all", "PARAM1 PARAM2");
	}

	void OnSpawn() override
	{
		SetBloodType("red");
		npc_spawn();
		ScheduleDelayedEvent(1.0, "npc_post_spawn");
		if ((G_CHRISTMAS_MODE))
		{
			if (GetEntityRace(GetOwner()) == "human")
			{
			}
			SetModelBody(2, 1);
		}
		string MY_RACE = GetMonsterProperty("race");
		if (MY_RACE == "human")
		{
			NPC_FRIENDLY = 1;
		}
		if (MY_RACE == "hguard")
		{
			NPC_FRIENDLY = 1;
		}
		if (MY_RACE == "elf")
		{
			NPC_FRIENDLY = 1;
		}
		if (MY_RACE == "dwarf")
		{
			NPC_FRIENDLY = 1;
		}
		if ((NPC_FRIENDLY))
		{
			NPC_FIGHTS_NPCS = 1;
		}
		if ((G_NPC_COMBAT_MAP))
		{
			NPC_FIGHTS_NPCS = 1;
		}
		if (MY_RACE != "undead")
		{
			if (/* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "holy") != 0)
			{
				if (!(IS_SKELETON))
				{
				}
				if (!(IS_UNHOLY))
				{
					SetDamageResistance("holy", 0.0);
				}
			}
		}
		else
		{
			SetDamageResistance("poison", 0.0);
			IMMUNE_VAMPIRE = 1;
		}
		EFFECT_DAMAGE_DELAY = 0;
	}

	void game_postspawn()
	{
		if ((NPC_REACTS))
		{
			npc_react_loop();
		}
		if ((GetEntityName(GetOwner())).findFirst("metal") >= 0)
		{
			IS_BLOODLESS = 1;
		}
		if ((GetEntityName(GetOwner())).findFirst("iron") >= 0)
		{
			IS_BLOODLESS = 1;
		}
		if ((GetEntityName(GetOwner())).findFirst("stone") >= 0)
		{
			IS_BLOODLESS = 1;
		}
		if ((IS_BLOODLESS))
		{
			IMMUNE_VAMPIRE = 1;
			SetDamageResistance("poison", 0.0);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((NPC_DID_DEATH)) return;
		NPC_DID_DEATH = 1;
		if ((true))
		{
			if ((G_APRIL_FOOLS_MODE))
			{
				CallExternal(GAME_MASTER, "gm_april_fools_spawn_add", GetEntityOrigin(GetOwner()));
			}
			if ((NPC_SUMMON))
			{
				G_NPC_SUMMON_COUNT -= 1;
				if (G_NPC_SUMMON_COUNT < 0)
				{
					SetGlobalVar("G_NPC_SUMMON_COUNT", 0);
				}
				LogDebug("game_death_summoned G_NPC_SUMMON_COUNT");
			}
		}
		if (!(NPC_NO_END_FLY))
		{
			SetFly(false);
		}
		if ((GOLD_BAGS))
		{
			if (!(NPC_NO_DROPS))
			{
			}
			bm_gold_spew(GOLD_PER_BAG, GOLD_BAGS_PPLAYER, GOLD_RADIUS, GOLD_BAGS_PPLAYER, GOLD_MAX_BAGS);
		}
		if (DROPS_CONTAINER == 1)
		{
			if (!(G_NO_DROP))
			{
			}
			if (RandomInt(1, 100) <= CONTAINER_DROP_CHANCE)
			{
				SpawnNPC(CONTAINER_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: CONTAINER_PARAM1, CONTAINER_PARAM2, CONTAINER_PARAM3, CONTAINER_PARAM4
			}
		}
		if ((EXT_FADE_ON_DEATH))
		{
			if (GetMonsterMaxHP() < 1000)
			{
			}
			if (!(NPC_NEVER_FADE))
			{
			}
			CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()));
		}
		SetAnimFrameRate(BASE_FRAMERATE);
		SetAnimMoveSpeed(BASE_MOVESPEED);
		if ((IN_ICECAGE))
		{
			ClientEvent("update", "all", SCRIPT_ICECAGE, "end_cage_fx");
			IN_ICECAGE = 0;
		}
		if ((NPC_CRITICAL))
		{
			string INFO_TITLE = "A CRITICAL NPC HAS DIED!";
			string INFO_MSG = GetEntityName(GetOwner());
			INFO_MSG += " has been slain! ";
			SendInfoMsg("all", "INFO_TITLE INFO_MSG");
			CallExternal(GAME_MASTER, "gm_crit_npc_died", GetEntityIndex(GetOwner()), GetEntityIndex(m_hLastStruck));
		}
		npc_death();
		if ((NPC_AUTO_DEATH))
		{
			SetMenuAutoOpen(0);
			if (!(NPC_ALERTED_ALL))
			{
				if ((HAS_AI))
				{
				}
				npcatk_alert_all_allies(GetEntityIndex(m_hLastStruck));
			}
			if (!(NPC_SILENT_DEATH))
			{
				if (NPC_ALT_SOUND_DEATH == "NPC_ALT_SOUND_DEATH")
				{
					EmitSound(GetOwner(), 0, SOUND_DEATH, 5);
				}
				else
				{
					EmitSound(GetOwner(), 0, NPC_ALT_SOUND_DEATH, 5);
				}
			}
			PlayAnim("critical", ANIM_DEATH);
			if ((CHEAT_MAP))
			{
				DeleteEntity(GetOwner(), true); // fade out
			}
			if (!(NPC_GAVE_XP_MSG))
			{
			}
			NPC_GAVE_XP_MSG = 1;
			string MON_FULL = GetMonsterProperty("name.full");
			string OUT_MSG = "You've slain ";
			OUT_MSG += MON_FULL;
			if (NPC_DEATH_MSG != "unset")
			{
				string OUT_MSG = NPC_DEATH_MSG;
			}
			SendColoredMessage(GetEntityIndex(m_hLastStruck), "OUT_MSG");
		}
		CallExternal(GetOwner(), "effect_die", "base_npc");
		ClearFX();
	}

	void game_fake_death()
	{
		NPC_DID_DEATH = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((NPC_CRITICAL))
		{
			if (!(NPC_CRIT_WARN_DELAY))
			{
				NPC_CRIT_WARN_DELAY = 1;
				NPC_FREQ_WARN("npcatk_reset_warn_delay");
				string INFO_TITLE = "Critical NPC Under Attack!";
				string INFO_MSG = GetEntityName(GetOwner());
				INFO_MSG += " is under attack!";
				SendInfoMsg("all", "INFO_TITLE INFO_MSG");
			}
		}
	}

	void npcatk_reset_warn_delay()
	{
		NPC_CRIT_WARN_DELAY = 0;
	}

	void npcatk_get_postspawn_properties()
	{
		LogDebug("npcatk_get_postspawn_properties NPC_HP_MULTI");
		EXT_HITCHANCE_ADJUSTMENT = 1;
		EXT_DAMAGE_ADJUSTMENT = 1;
	}

	void npc_react_loop()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(1.0, "npc_react_loop");
		if ((CanSee(NPC_REACT_SEETARGET, NPC_REACT_SEETARGET_RANGE)))
		{
			if (GetEntityIndex(m_hLastSeen) != NPC_REACT_LAST_TARGET)
			{
			}
			NPC_REACT_LAST_TARGET = GetEntityIndex(m_hLastSeen);
			NPC_REACT_RESET_TARGET_TIME = GetGameTime();
			NPC_REACT_RESET_TARGET_TIME += 60.0;
			if (!(NPC_REACT_CANSEETARGET))
			{
				npcreact_targetsighted(NPC_REACT_LAST_TARGET);
			}
			NPC_REACT_CANSEETARGET = 1;
		}
		else
		{
			if ((NPC_REACT_CANSEETARGET))
			{
				npc_react_sightlost();
			}
			NPC_REACT_CANSEETARGET = 0;
			if (GetGameTime() > NPC_REACT_RESET_TARGET_TIME)
			{
			}
			NPC_REACT_LAST_TARGET = 0;
		}
	}

	void OnPostSpawn() override
	{
		if (!(/* TODO: $anim_exists */ $anim_exists(ANIM_DEATH)))
		{
			LogDebug("WARNING! ANIM_DEATH does not exist in GetScriptName(GetOwner())");
			string TEST_ANIM_DEATH = "diesimple";
			if (/* TODO: $anim_exists */ $anim_exists(TEST_ANIM_DEATH) > -1)
			{
				ANIM_DEATH = TEST_ANIM_DEATH;
			}
			string TEST_ANIM_DEATH = "diesforward";
			if (/* TODO: $anim_exists */ $anim_exists(TEST_ANIM_DEATH) > -1)
			{
				ANIM_DEATH = TEST_ANIM_DEATH;
			}
			string TEST_ANIM_DEATH = "die";
			if (/* TODO: $anim_exists */ $anim_exists(TEST_ANIM_DEATH) > -1)
			{
				ANIM_DEATH = TEST_ANIM_DEATH;
			}
			string TEST_ANIM_DEATH = "die_fallback";
			if (/* TODO: $anim_exists */ $anim_exists(TEST_ANIM_DEATH) > -1)
			{
				ANIM_DEATH = TEST_ANIM_DEATH;
			}
			string TEST_ANIM_DEATH = "death";
			if (/* TODO: $anim_exists */ $anim_exists(TEST_ANIM_DEATH) > -1)
			{
				ANIM_DEATH = TEST_ANIM_DEATH;
			}
			if ((G_DEVELOPER_MODE))
			{
			}
			if (/* TODO: $anim_exists */ $anim_exists(ANIM_DEATH) > -1)
			{
				LogDebug("Substituting with ANIM_DEATH");
			}
			else
			{
				LogDebug("WARNING! COULD NOT FIND ALT DEATH ANIM FOR GetScriptName(GetOwner()) [ ANIM_DEATH ]");
			}
		}
	}

}

}
