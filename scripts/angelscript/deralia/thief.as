#pragma context server

#include "monsters/base_npc_attack.as"
#include "monsters/attack_hack.as"

namespace MS
{

class Thief : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	int ATTACK_FREQUENCY;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string CAN_ATTACK;
	int CAN_FLEE;
	int CAN_FLINCH;
	string CAN_HUNT;
	int CAN_RETALIATE;
	int CAN_STTACK;
	float FLEE_CHANCE;
	int FLEE_DISTANCE;
	int FLEE_HEALTH;
	string FLINCH_ANIM;
	float FLINCH_CHANCE;
	int FLINCH_DELAY;
	int FOLLOWING;
	int GOLD;
	int OFFER_GIVEN;
	int QUEST_DONE;
	int REWARD_NAO_PLZ;
	string SOUND_DEATH;
	int STEAL;
	int STEALING;
	int THIEF;

	Thief()
	{
		CAN_STTACK = 0;
		CAN_FLEE = 1;
		FLEE_HEALTH = 34;
		FLEE_CHANCE = 1.0;
		FLEE_DISTANCE = 1000;
		CAN_RETALIATE = 0;
		CAN_FLINCH = 1;
		FLINCH_ANIM = "llflinch";
		FLINCH_CHANCE = 0.5;
		FLINCH_DELAY = 1;
		ANIM_DEATH = "dieforward";
		SOUND_DEATH = "player/stomachhit1.wav";
		ANIM_WALK = "walk";
		GOLD = 10;
		ATTACK_DAMAGE = 7;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 150;
		ATTACK_HITCHANCE = 0.7;
		ATTACK_FREQUENCY = 10;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "franticbutton";
		FOLLOWING = 0;
		if (STEAL == 1)
		{
		}
		SetVolume(8);
		Say("hello1[.83] [.33] [.91] [.91] [.38] [.36]");
		SetRoam(false);
		ScheduleDelayedEvent(4, "resumeroam");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1);
		if (!(STEAL))
		{
		}
		if ((CanSee("player", 256)))
		{
		}
		SetMoveDest(m_hLastSeen);
		if (STEAL == 0)
		{
		}
		STEALING = RandomInt(-15, -5);
		// TODO: offer GetEntityIndex(m_hLastSeen) gold STEALING
		GOLD -= STEALING;
		PlayAnim("once", "return_needle");
		SetRoam(false);
		ScheduleDelayedEvent(1, "resumeroam");
		ScheduleDelayedEvent(5, "resumesteal");
		SetGold(GOLD);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(1);
		if (FOLLOWING == 1)
		{
			if (CanSee(FindEntityByName("knight_lord"), 256) == 1)
			{
				SetMoveDest(FindEntityByName("knight_lord"));
				ScheduleDelayedEvent(3, "turn_in_now");
				FOLLOWING = 0;
			}
			else
			{
				SetMoveDest(APPREHENDER);
			}
		}
	}

	void OnSpawn() override
	{
		SetName("thief");
		SetHealth(45);
		SetGold(GOLD);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Commoner");
		SetRoam(true);
		SetModel("npc/human1.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 5);
		SetMoveAnim("walk");
		THIEF = 0;
		STEAL = 0;
	}

	void resumeroam()
	{
		SetRoam(true);
	}

	void resumesteal()
	{
		STEAL = 1;
	}

	void say_accept()
	{
		OFFER_GIVEN = 1;
		if (REWARD_NAO_PLZ != 1)
		{
			SayText("Thank you good Sir! " + I + " shall follow you to the Lord of the Land.");
			SetGlobalVar("APPREHENDER", param1);
			SetRace("beloved");
			SetMoveAnim(ANIM_RUN);
			FOLLOWING = 1;
		}
	}

	void quest_done()
	{
		DeleteEntity(GetEntityIndex(GetOwner()), true); // fade out
	}

	void turn_in_now()
	{
		SetMoveDest(FindEntityByName("knight_lord"));
		SayText("Sir , " + I + "am turning myself in for " + I + " have commited crime.");
		SayText(I + " have stolen from people.");
		CallExternal(FindEntityByName("knight_lord"), "2", "say_jail");
		PlayAnim("once", "kneel");
	}

	void turned_in()
	{
		REWARD_NAO_PLZ = 1;
		OpenMenu(APPREHENDER);
		QUEST_DONE = 1;
	}

	void game_menu_cancel()
	{
		if (REWARD_NAO_PLZ != 1)
		{
			SayText("Then " + I + " shall fight you!");
			SetRace("orc");
			SetName("A Thief!");
			ANIM_RUN = "run";
			CAN_RETALIATE = 1;
			CAN_ATTACK = 1;
			CAN_HUNT = 1;
			SetRace("orc");
			SetRoam(true);
			npcatk_target(GetEntityIndex(m_hLastStruck));
		}
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Accept";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_accept";
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if (OFFER_GIVEN == 0)
		{
			SetName("Thief");
			SayText("Please spare me , good Sir , for " + I + " am but a petty thief.");
			SayText(I + " shall turn myself in if you would be so kind as to let me live.");
			PlayAnim("critical", "crouch");
			OpenMenu(GetEntityIndex(m_hLastStruck));
			STEAL = 1;
			SetRoam(false);
		}
	}

	void attack()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
	}

	void my_target_died()
	{
		SetRace("human");
		SetName("Commoner");
		// TODO: UNCONVERTED: STEAL 0
		SetRoam(true);
	}

	void dbg_find_thief()
	{
		SetSayTextRange(4096);
		SayText(OVER + HERE!);
		LogDebug("thief present");
	}

}

}
