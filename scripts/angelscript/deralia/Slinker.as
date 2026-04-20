#pragma context server

#include "monsters/base_monster.as"
#include "monsters/base_chat.as"

namespace MS
{

class Slinker : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	string ANIM_WALK;
	int ASKED;
	int ATTACK_DAMAGE;
	int ATTACK_HITRANGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_HUNT;
	int CAN_RETALIATE;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	int GAVE_QUEST;
	string LAST_SPOKE_TO;
	int MISSION_OVER;
	int MOVE_RANGE;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	string PLAYER_SPLOTTED;
	string QUEST_WINNER;
	int REQ_QUEST_NOTDONE;
	int SEE_RANGE;
	int T_QUEST_COMPLETE;

	Slinker()
	{
		CAN_ATTACK = 0;
		CAN_HUNT = 0;
		CAN_FLEE = 1;
		CAN_RETALIATE = 1;
		FLEE_HEALTH = 25;
		FLEE_CHANCE = 0.5;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 200;
		ATTACK_DAMAGE = 8;
		MOVE_RANGE = 90;
		ATTACK_PERCENTAGE = 0.95;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "beatdoor";
		NO_RUMOR = 1;
		NO_JOB = 1;
		NO_HAIL = 1;
		SEE_RANGE = 350;
		Precache("voices/deralia/slinker_ring.wav");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3.0);
		if (!(MISSION_OVER))
		{
		}
		if (!(CAN_HUNT))
		{
		}
		if ((CanSee("player", SEE_RANGE)))
		{
		}
		PLAYER_SPLOTTED = GetEntityIndex(m_hLastSeen);
		if (LAST_SPOKE_TO != PLAYER_SPLOTTED)
		{
		}
		SetMoveDest(PLAYER_SPLOTTED);
		SetSayTextRange(512);
		SayText("Hey, want to make some fast cash?");
		EmitSound(GetOwner(), 0, "voices/deralia/slinker1.wav", 10);
		LAST_SPOKE_TO = PLAYER_SPLOTTED;
	}

	void OnSpawn() override
	{
		SetName("Slinker");
		SetHealth(150);
		REQ_QUEST_NOTDONE = 1;
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Slinker");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(0, 3);
		SetModelBody(1, 1);
		SetMoveAnim("walk");
		MISSION_OVER = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_no", "no");
		CatchSpeech("say_yes", "yes");
		ASKED = -1;
		GAVE_QUEST = 2;
	}

	void say_hi()
	{
		if (param1 != "PARAM1")
		{
			string L_PLAYER = param1;
		}
		else
		{
			string L_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (!(CanSee(L_PLAYER, SEE_RANGE))) return;
		if ((CAN_HUNT)) return;
		if (ASKED < 1)
		{
			SayText("You aren't a goody-two-shoes good guy, are ya?");
			EmitSound(GetOwner(), 0, "voices/deralia/slinker2.wav", 10);
			bchat_mouth_move();
			ASKED = 0;
			LAST_SPOKE_TO = L_PLAYER;
		}
		if (ASKED == 1)
		{
			SayText("Well, get goin' already!");
			bchat_mouth_move();
		}
		if (T_QUEST_COMPLETE == 1)
		{
			SayText("I've got no further business with you.");
			bchat_mouth_move();
		}
	}

	void say_no()
	{
		if ((CAN_HUNT)) return;
		if (!(ASKED == 0)) return;
		SayText("Alright, here's the scoop. Master Proffund, that snobby nobleman who always hangs out at the bank, owes me a little money.");
		EmitSound(GetOwner(), 0, "voices/deralia/slinker3.wav", 10);
		bchat_auto_mouth_move(9.2);
		ASKED = 1;
		ScheduleDelayedEvent(9.2, "say_instruct");
	}

	void say_instruct()
	{
		SayText("A gambling man, he is, but not a very good one. Anyway, he owes me so much money, I've decided to settle for the deed to one of his nice farm properties.");
		EmitSound(GetOwner(), 0, "voices/deralia/slinker4.wav", 10);
		bchat_auto_mouth_move(11.5);
		ScheduleDelayedEvent(11.5, "say_instruct2");
	}

	void say_instruct2()
	{
		SayText("Go and get that deed from him for me, and I'll pay you handsomely.");
		EmitSound(GetOwner(), 0, "voices/deralia/slinker5.wav", 10);
		CallExternal(FindEntityByName("Proffund"), "quest_start");
	}

	void mortal()
	{
		SetRace("orc");
	}

	void give_deed()
	{
		ReceiveOffer("accept");
		QUEST_WINNER = param1;
		ScheduleDelayedEvent(1, "say_letter");
	}

	void say_letter()
	{
		if ((T_QUEST_COMPLETE)) return;
		PlayAnim("once", "yes");
		SayText("Nice work, here's your reward.");
		bchat_mouth_move();
		EmitSound(GetOwner(), 0, "voices/deralia/slinker_reward.wav", 10);
		// TODO: offer QUEST_WINNER gold 15
		// TODO: offer QUEST_WINNER health_spotion
		T_QUEST_COMPLETE = 1;
		MISSION_OVER = 1;
		REQ_QUEST_NOTDONE = 0;
		ASKED = 2;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(FindEntityByName("Proffund"), "slinker_dead");
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, Random(6.0, 9.0), ATTACK_PERCENTAGE, "slash");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "say";
		int l.say = RandomInt(1, 4);
		if (l.say == 1)
		{
			string reg.mitem.data = "Hello";
		}
		else
		{
			if (l.say == 2)
			{
				string reg.mitem.data = "Hi";
			}
			else
			{
				if (l.say == 3)
				{
					string reg.mitem.data = "Hail";
				}
				else
				{
					if (l.say == 4)
					{
						string reg.mitem.data = "Greetings!";
					}
				}
			}
		}
		if (ASKED == 0)
		{
			if (param1 == LAST_SPOKE_TO)
			{
				string reg.mitem.title = "No";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_no";
			}
		}
		if ((ItemExists(param1, "item_deed")))
		{
			string reg.mitem.title = "Give deed";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_deed";
			string reg.mitem.callback = "give_deed";
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		CAN_ATTACK = 1;
		CAN_HUNT = 1;
		SetRace("orc");
		SetRoam(true);
		npcatk_target(GetEntityIndex(m_hLastStruck));
	}

	void my_target_died()
	{
		CAN_ATTACK = 0;
		CAN_HUNT = 0;
		SetRace("human");
	}

}

}
