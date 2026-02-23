#pragma context server

#include "monsters/sorc_warrior.as"
#include "bloodshrine/base_sorc_friendly.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class SorcWarrior2Friendly : CGameScript
{
	string CHAT_CURRENT_SPEAKER;
	int DID_ASHINKAHR;
	string DID_INTRO;
	string FOLLOW_PLR_DIST;
	string FOLLOW_PLR_ID;
	int GAVE_REWARD;
	string LEADER_ID;
	string NPCATK_TARGET;
	string ZOMBIE_ID;

	SorcWarrior2Friendly()
	{
		const string DMG_SWORD = RandomInt(200, 300);
		const float DOT_THROW_SHOCK = 120.0;
		const float DOT_SHOCK = 60.0;
		const string DMG_KICK = RandomInt(40, 100);
		const int CHAT_USE_CONV_ANIMS = 0;
		const int CHAT_NO_CLOSE_MOUTH = 1;
		const int CHAT_NEVER_INTERRUPT = 1;
		const int NPC_EXTRA_VALIDATIONS = 1;
	}

	void orc_spawn()
	{
		SetName("Shadahar Lieutenant");
		SetName("fsorc_second");
		SetModel("monsters/sorc.mdl");
		SetHealth(8000);
		SetDamageResistance("all", 0.5);
		SetStat("parry", 110);
		SetRace("human");
		SetRoam(false);
		SetWidth(32);
		SetHeight(96);
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 7);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(DID_INTRO))
		{
			if ((false))
			{
			}
			CHAT_CURRENT_SPEAKER = GetEntityIndex(m_hLastSeen);
			if (!(IsEntityAlive(m_hLastSeen)))
			{
				CHAT_CURRENT_SPEAKER = FindEntitiesInSphere("player", 512);
				CHAT_CURRENT_SPEAKER = /* TODO: $sort_entlist */ $sort_entlist(CHAT_CURRENT_SPEAKER, "range");
				CHAT_CURRENT_SPEAKER = GetToken(CHAT_CURRENT_SPEAKER, 0, ";");
			}
			FOLLOW_PLR_ID = CHAT_CURRENT_SPEAKER;
			FOLLOW_PLR_DIST = 200;
			DID_INTRO = 1;
			do_intro();
		}
	}

	void do_intro()
	{
		chat_now("Humans!? Attack!!!", 3.0, ANIM_ATTACK, "add_to_que");
		ScheduleDelayedEvent(1.0, "leader_interrupt");
	}

	void leader_interrupt()
	{
		LEADER_ID = FindEntityByName("fsorc_leader");
		SetMoveDest(LEADER_ID);
		CallExternal(LEADER_ID, "ext_do_leader_intro");
	}

	void ext_zombie_react()
	{
		SetName("Vurinahr , the Lieutenant");
		string FIND_ZOMBIE = FindEntitiesInSphere("enemy", 1024);
		ZOMBIE_ID = GetToken(FIND_ZOMBIE, 0, ";");
		npcatk_settarget(ZOMBIE_ID);
		NPCATK_TARGET = ZOMBIE_ID;
		SetMoveDest(ZOMBIE_ID);
		ScheduleDelayedEvent(1.5, "alert_others");
		bfsorc_follow_normal();
		chat_now("Make that three! Ashinkahr has changed!", 3.0, ANIM_ATTACK, "add_to_que");
	}

	void alert_others()
	{
		CallExternal("all", "fsorc_zombie_alert", ZOMBIE_ID);
	}

	void my_target_died()
	{
		if ((DID_ASHINKAHR)) return;
		DID_ASHINKAHR = 1;
		npcatk_suspend_ai(3.0);
		chat_now("That should put him to rest once and for all.", 3.0, "add_to_que");
		CallExternal(LEADER_ID, "ext_leader_ash");
	}

	void npc_targetvalidate()
	{
		if (m_hAttackTarget == SBOSS_ID)
		{
			NPCATK_TARGET = "unset";
		}
	}

	void give_reward_options()
	{
		if ((GAVE_REWARD)) return;
		string reg.mitem.title = "Gather Reward";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "give_reward";
	}

	void give_reward()
	{
		GAVE_REWARD = 1;
		// TODO: offer PARAM1 axes_thunder11
		chat_now("It's a meager reward, for bravery, but I'm sure you'll find one who make use of it.", 3.0, "nod_yes");
		ScheduleDelayedEvent(6.0, "ready_to_go");
	}

}

}
