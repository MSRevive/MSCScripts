#pragma context server

#include "monsters/bandit_elite_dagger.as"

namespace MS
{

class BanditExtortionist : CGameScript
{
	string BAR_ID;
	string STARTED_SCENE;

	BanditExtortionist()
	{
		SetName("extorter");
		SetSayTextRange(1024);
	}

	void OnPostSpawn() override
	{
		SetRoam(false);
		npcatk_suspend_ai();
		ScheduleDelayedEvent(1.0, "get_bar_id");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((SUSPEND_AI))
		{
			npcatk_resume_ai();
		}
	}

	void get_bar_id()
	{
		BAR_ID = FindEntityByName("bartender");
		scan_for_players();
	}

	void scan_for_players()
	{
		if ((false))
		{
			if ((IsValidPlayer(m_hLastSeen)))
			{
			}
			STARTED_SCENE = 1;
			start_scene();
		}
		if ((STARTED_SCENE)) return;
		ScheduleDelayedEvent(1.0, "scan_for_players");
	}

	void start_scene()
	{
		SetMoveDest(BAR_ID);
		SayText("Helga , your payment is late , again. " + I + " warned you this this would be the last time.");
		ScheduleDelayedEvent(3.0, "helga_respond1");
	}

	void helga_respond1()
	{
		CallExternal(BAR_ID, "ext_harass1");
		ScheduleDelayedEvent(3.0, "me_harass2");
	}

	void me_harass2()
	{
		SayText("Come now , you surely have made enough for the payment by now.");
		ScheduleDelayedEvent(3.0, "helga_respond2");
	}

	void helga_respond2()
	{
		CallExternal(BAR_ID, "ext_harass2");
		ScheduleDelayedEvent(3.0, "me_harass3");
	}

	void me_harass3()
	{
		SayText("We have to keep the riff-raff , in line... We have to set... An example.");
		PlayAnim("hold", "stand_squatwalk1_L");
		ScheduleDelayedEvent(3.0, "helga_respond3");
	}

	void helga_respond3()
	{
		CallExternal(BAR_ID, "ext_harass3");
		ScheduleDelayedEvent(6.0, "me_kill_da_bitch");
	}

	void me_kill_da_bitch()
	{
		PlayAnim("critical", ANIM_ATTACK);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		CallExternal(BAR_ID, "npc_suicide");
		ScheduleDelayedEvent(2.0, "warn_all");
	}

	void warn_all()
	{
		SayText("Let that be a lesson to the rest of you. Do not defy the [insert name of bandit mafia here]!");
		PlayAnim("critical", "aim_punch1");
		SetRoam(true);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(IsEntityAlive(BAR_ID))) return;
		CallExternal(BAR_ID, "extorter_slain", GetEntityIndex(m_hLastStruck));
	}

}

}
