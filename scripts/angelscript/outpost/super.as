#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_guard_friendly_new.as"
#include "monsters/base_chat.as"

namespace MS
{

class Super : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string ATTACK_ALERT;
	int CAN_TALK;
	string DID_PAINCRY;
	string DID_WARCRY;
	string GAVE_INTRO;
	int GIVE_INTRO_STEP;
	int GOING_HOME;
	string MADE_IT_HOME;
	string NO_HAIL;
	int NO_STUCK_CHECKS;
	string NPCATK_TARGET;
	int OH_IT_IS_ON;
	string QUEST_WINNER;
	int RECIEVED_HEAD;
	int REQ_QUEST_NOTDONE;
	int REWARD_STEP;
	int WAR_INPROGRESS;

	Super()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "swordswing1_L";
		const string SOUND_ATTACK = "weapons/cbar_miss1.wav";
		ANIM_DEATH = "dieforward";
		const int ATTACK_RANGE = 85;
		const int MOVE_RANGE = 75;
		const int ATTACK_HITRANGE = 150;
		const float ATTACK_HITCHANCE = 0.9;
		const int ATTACK_DAMAGE = 35;
		const string SOUND_WARCRY = "scientist/cough.wav";
		const string SOUND_DEATH = "scientist/scream21.wav";
		const string SOUND_PAINCRY1 = "scientist/sci_fear7.wav";
		const string SOUND_PAINCRY2 = "scientist/sci_fear11.wav";
		const string SOUND_PAINCRY3 = "scientist/sci_fear5.wav";
		const string SOUND_PAINCRY4 = "scientist/scream01.wav";
		const string SOUND_PAINCRY5 = "scientist/canttakemore.wav";
		const int PATROL_RANGE = 384;
		const int BG_ROAM = 0;
		Precache(SOUND_DEATH);
		const int NO_RUMOR = 1;
		const int NO_JOB = 1;
		CAN_TALK = 1;
		GIVE_INTRO_STEP = 0;
		NO_STUCK_CHECKS = 1;
	}

	void OnSpawn() override
	{
		SetName("outpost_super");
		SetNoPush(true);
		SetHealth(600);
		SetGold(10);
		SetName("Vadrel , the outpost supervisor");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/guard2.mdl");
		SetModelBody(1, 2);
		SetMoveAnim("walk");
		SetSkillLevel(0);
		SetStepSize(0);
		// TODO: UNCONVERTED: maxslope 10
		SetDamageResistance("all", 0.5);
		REQ_QUEST_NOTDONE = 1;
		SetGlobalVar("WARBOSS_DEAD", 0);
		WAR_INPROGRESS = 0;
		ScheduleDelayedEvent(1.0, "stay_home");
		SetInvincible(true);
		SetDamageResistance("stun", 0);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_yes", "yes");
		CatchSpeech("say_no", "no");
	}

	void say_job()
	{
		say_hi();
	}

	void stay_home()
	{
		if (Distance(GetMonsterProperty("origin"), NPC_SPAWN_LOC) > 384)
		{
			npcatk_clear_targets();
			if (!(GOING_HOME))
			{
				force_go_home();
			}
			SetMoveDest(NPC_SPAWN_LOC);
			npcatk_suspend_ai(2.0);
		}
		ScheduleDelayedEvent(1.0, "stay_home");
	}

	void attack_1()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 10);
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE);
	}

	void say_hi()
	{
		if (!(CAN_TALK)) return;
		npcatk_setmovedest("ent_lastspoke", 9999);
		if ((WARBOSS_DEAD))
		{
			PlayAnim("once", "yes");
			SayText("Thank you again for your help... Travel safely.");
		}
		if ((WARBOSS_DEAD)) return;
		if ((WAR_INPROGRESS))
		{
			PlayAnim("once", "fear1");
			SayText("What are you doing here? Protect the outpost!");
		}
		if ((WAR_INPROGRESS)) return;
		if (GIVE_INTRO_STEP == 7)
		{
			GIVE_INTRO_STEP = 0;
		}
		if (!(GIVE_INTRO_STEP == 0)) return;
		give_intro();
		PlayAnim("once", "lean");
	}

	void give_intro()
	{
		if (!(CAN_TALK)) return;
		GIVE_INTRO_STEP += 1;
		if (GIVE_INTRO_STEP == 1)
		{
			NO_HAIL = 1;
			GAVE_INTRO = 1;
			float L_STEP_DELAY = 0.1;
		}
		if (GIVE_INTRO_STEP == 2)
		{
			SayText("Hail. For the longest time , we have struggled here against the Orcish invaders from the south.");
			EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_1.wav", 10);
			float L_STEP_DELAY = 4.51;
		}
		if (GIVE_INTRO_STEP == 3)
		{
			PlayAnim("once", "whiteboard");
			SayText("King Ardelleron just recently allowed us the materials for the wall.");
			EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_2.wav", 10);
			float L_STEP_DELAY = 4.07;
		}
		if (GIVE_INTRO_STEP == 4)
		{
			SayText("However , even with the wall , our numbers are diminishing and the King has yet to send more troops.");
			EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_3.wav", 10);
			float L_STEP_DELAY = 4.7;
		}
		if (GIVE_INTRO_STEP == 5)
		{
			SayText("We can't hold this position any longer... or at least... not without help...");
			EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_4.wav", 10);
			float L_STEP_DELAY = 4.04;
		}
		if (GIVE_INTRO_STEP == 6)
		{
			SayText("If you help us to stop this invasion, I will reward you most graciously.");
			EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_5.wav", 10);
			float L_STEP_DELAY = 3.60;
		}
		if (GIVE_INTRO_STEP == 7)
		{
			PlayAnim("critical", "converse2");
			SayText("Do you accept?");
			EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_6.wav", 10);
		}
		if (!(GIVE_INTRO_STEP < 7)) return;
		L_STEP_DELAY("give_intro");
	}

	void say_no()
	{
		if (!(CAN_TALK)) return;
		if ((WAR_INPROGRESS)) return;
		PlayAnim("once", "pull_needle");
		SayText("Then begone from our lands , as another attack is imminent!");
		EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_7.wav", 10);
		UseTrigger("player_refused");
	}

	void say_yes()
	{
		if (!(CAN_TALK)) return;
		if ((WAR_INPROGRESS)) return;
		GIVE_INTRO_STEP = 8;
		UseTrigger("player_accepted");
		SetInvincible(false);
		WAR_INPROGRESS = 1;
		ScheduleDelayedEvent(10.0, "i_r_super_lure");
		PlayAnim("once", "pondering2");
		SayText("Ah! Wonderful. If you would , there is a guard tower where you can watch for them coming.");
		EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_8.wav", 10);
	}

	void game_menu_getoptions()
	{
		if ((GAVE_INTRO))
		{
			if (!(WAR_INPROGRESS))
			{
			}
			string reg.mitem.title = "Accept";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_yes";
		}
		if (!(WARBOSS_DEAD)) return;
		if ((RECIEVED_HEAD)) return;
		if ((ItemExists(param1, "item_warbosshead")))
		{
			string reg.mitem.title = "Offer Graznux's Head";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_warbosshead";
			string reg.mitem.callback = "gave_head";
		}
	}

	void gave_head()
	{
		REQ_QUEST_NOTDONE = 0;
		ReceiveOffer("accept");
		QUEST_WINNER = param1;
		REWARD_STEP = 0;
		if (!(WARBOSS_DEAD)) return;
		if ((RECIEVED_HEAD)) return;
		UseTrigger("gave_head");
		SetInvincible(true);
		REWARD_STEP = 0;
		ScheduleDelayedEvent(0.1, "reward_intro");
	}

	void reward_intro()
	{
		RECIEVED_HEAD = 1;
		REWARD_STEP += 1;
		if (REWARD_STEP == 1)
		{
			PlayAnim("once", "dryhands");
			SayText("Well done , travellers. Please , take a look around the armory and take what you wish.");
			EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_9.wav", 10);
			float L_STEP_DELAY = 4.15;
		}
		if (REWARD_STEP == 2)
		{
			SayText("No shoving now! There's enough for everyone!");
			EmitSound(GetOwner(), 0, "voices/foutpost/Vadrel_10.wav", 10);
		}
		if (!(REWARD_STEP < 2)) return;
		L_STEP_DELAY("reward_intro");
	}

	void npcatk_settarget()
	{
		CAN_TALK = 0;
		if (!(DID_WARCRY))
		{
			EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
			DID_WARCRY = 1;
		}
	}

	void my_target_died()
	{
		CAN_TALK = 1;
	}

	void force_go_home()
	{
		if ((MADE_IT_HOME)) return;
		GOING_HOME = 1;
		ScheduleDelayedEvent(1.0, "force_go_home");
		string MY_POS = GetEntityOrigin(GetOwner());
		if (GetMonsterProperty("movedest.origin") != MY_GUARD_POST)
		{
			npcatk_setmovedest(MY_GUARD_POST, 1);
		}
		if (Distance(MY_POS, MY_GUARD_POST) < 10)
		{
			if (!(OH_IT_IS_ON))
			{
			}
			string MY_POS = GetEntityOrigin(GetOwner());
			SetMoveDest("none");
			SetRoam(BG_ROAM);
			SetMoveSpeed(BG_ROAM);
			SetMoveAnim(ANIM_IDLE);
			SetActionAnim(ANIM_IDLE);
			SetAngles("face");
			MADE_IT_HOME = 1;
			GOING_HOME = 0;
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		string HURT_THRESHOLD = GetMonsterMaxHP();
		HURT_THRESHOLD *= 0.75;
		if (!(ATTACK_ALERT))
		{
			SendInfoMsg("all", "CRITICAL_NPC The outpost supervisor is under attack! Save him!");
			ATTACK_ALERT = 1;
			ScheduleDelayedEvent(5.0, "reset_attack_alert");
		}
		if (!(GetMonsterHP() < HURT_THRESHOLD)) return;
		if (!(DID_PAINCRY))
		{
			// PlayRandomSound from: SOUND_PAINCRY1, SOUND_PAINCRY2, SOUND_PAINCRY3, SOUND_PAINCRY4, SOUND_PAINCRY5
			array<string> sounds = {SOUND_PAINCRY1, SOUND_PAINCRY2, SOUND_PAINCRY3, SOUND_PAINCRY4, SOUND_PAINCRY5};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			DID_PAINCRY = 1;
			ScheduleDelayedEvent(5.0, "reset_paincry");
		}
	}

	void reset_attack_alert()
	{
		ATTACK_ALERT = 0;
	}

	void reset_paincry()
	{
		DID_PAINCRY = 0;
	}

	void baseguard_clear_targs()
	{
		OH_IT_IS_ON = 0;
		if (!(BG_NO_GO_HOME))
		{
			SetAngles("face_origin");
			npcatk_setmovedest(MY_GUARD_POST, 1);
		}
		MADE_IT_HOME = 0;
		going_home();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SendInfoMsg("all", "FAILURE! THE OUTPOST SUPERVISOR HAS DIED! You will not be allowed to proceed to the next area.");
	}

	void npcatk_clear_targets()
	{
		CAN_TALK = 1;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		string TARGET_ORG = GetEntityOrigin(param1);
		if (!(Distance(TARGET_ORG, NPC_SPAWN_LOC) >= PATROL_RANGE)) return;
		NPCATK_TARGET = "unset";
	}

	void i_r_super_lure()
	{
		CallExternal("all", "super_lure", GetEntityIndex(GetOwner()), "orc");
		ScheduleDelayedEvent(5.0, "i_r_super_lure");
	}

	void OnDamage(int damage) override
	{
		if (!(IsValidPlayer(param1))) return;
		SetDamage("dmg");
		SetDamage("hit");
		return;
	}

}

}
