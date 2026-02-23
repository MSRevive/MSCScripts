#pragma context server

#include "monsters/base_self_adjust.as"
#include "monsters/externals.as"

namespace MS
{

class BaseStrippedAi : CGameScript
{
	string IN_ICECAGE;
	int NPC_DID_DEATH;
	string NPC_GAVE_XP_MSG;

	void OnSpawn() override
	{
		if ((HAS_INCLUDE_NPC)) return;
		ScheduleDelayedEvent(1.0, "npc_post_spawn");
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
		ClearFX();
	}

}

}
