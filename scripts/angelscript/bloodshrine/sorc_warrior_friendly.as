#pragma context server

#include "monsters/sorc_warrior.as"
#include "bloodshrine/base_sorc_friendly.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class SorcWarriorFriendly : CGameScript
{
	int CHAT_TEMP_NO_AUTO_FACE;
	int DID_ASHINKAHR;
	int DID_WAIT_COMMENT;
	int GAVE_REWARD;
	string NPCATK_TARGET;
	string SECOND_ID;
	string SHAMAN_ID;
	string ZOMBIE_ID;

	SorcWarriorFriendly()
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
		SetName("Brindahr , the Warleader");
		SetName("fsorc_leader");
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

	void ext_do_leader_intro()
	{
		chat_now("Wait!", 3.0, "neigh", "bfsorc_follow_close", "add_to_que");
		chat_now("I know you... You are of the humans who fought beside Chief Runegahr!", 5.0, "none", "face_second", "add_to_que");
		chat_now("Surely they will help us escape this accursed place!", 3.0, "none", "add_to_que");
		chat_now("We were exploring, outside these ruins, when a great shadow fell upon us.", 4.0, "add_to_que");
		chat_now("When we awoke, we found ourselves imprisoned here...", 4.0, "none", "call_shaman_lines", "add_to_que");
	}

	void face_second()
	{
		SECOND_ID = FindEntityByName("fsorc_second");
		CHAT_TEMP_NO_AUTO_FACE = 1;
		SetMoveDest(SECOND_ID);
		npcatk_suspend_ai();
		ScheduleDelayedEvent(0.1, "shew_second");
		ScheduleDelayedEvent(2.0, "resume_faceing_speaker");
		ScheduleDelayedEvent(2.5, "chat_face_speaker");
		bfsorc_follow_normal();
	}

	void resume_faceing_speaker()
	{
		CHAT_TEMP_NO_AUTO_FACE = 0;
	}

	void shew_second()
	{
		SetMoveDest(SECOND_ID);
		PlayAnim("critical", "swordswing1_L");
	}

	void call_shaman_lines()
	{
		ScheduleDelayedEvent(1.0, "call_shaman_lines2");
	}

	void call_shaman_lines2()
	{
		SHAMAN_ID = FindEntityByName("fsorc_shaman");
		SetMoveDest(SHAMAN_ID);
		ScheduleDelayedEvent(2.5, "chat_face_speaker");
		CallExternal(SHAMAN_ID, "ext_shaman_lines");
	}

	void fsorc_zombie_alert()
	{
		npcatk_resume_ai();
		ScheduleDelayedEvent(3.0, "ash_comment");
		SetMoveAnim(ANIM_RUN);
		ZOMBIE_ID = param1;
		npcatk_settarget(ZOMBIE_ID);
		NPCATK_TARGET = ZOMBIE_ID;
		SetMoveDest(ZOMBIE_ID);
	}

	void ash_comment()
	{
		chat_now("To battle! Rend his cursed corpse until it ceases to move!", 3.0, "warcry", "add_to_que");
	}

	void ext_leader_ash()
	{
		if ((DID_ASHINKAHR)) return;
		DID_ASHINKAHR = 1;
		ScheduleDelayedEvent(3.0, "ext_leader_ash2");
	}

	void ext_leader_ash2()
	{
		chat_now("Yes... Lead on, we shall follow.", 3.0, "add_to_que");
		ScheduleDelayedEvent(3.0, "sham_comment");
	}

	void sham_comment()
	{
		CallExternal(SHAMAN_ID, "ext_return_comment");
	}

	void npc_targetvalidate()
	{
		if (m_hAttackTarget == SBOSS_ID)
		{
			NPCATK_TARGET = "unset";
		}
	}

	void fsorc_wait()
	{
		if ((DID_WAIT_COMMENT)) return;
		DID_WAIT_COMMENT = 1;
		ScheduleDelayedEvent(1.0, "fsorc_wait_comment");
	}

	void fsorc_wait_comment()
	{
		chat_now("Very well. We trust in your judgement, elder.", 3.0, "nod_yes");
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
		// TODO: offer PARAM1 axes_gthunder11
		chat_now("It's a meager reward, for such a warrior, but I'm sure you'll make good use of it.", 3.0, "nod_yes");
		ScheduleDelayedEvent(6.0, "ready_to_go");
	}

}

}
