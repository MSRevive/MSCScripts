#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_guard_friendly_new.as"

namespace MS
{

class KnightLord : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string DROP_GOLD;
	int GAVE_RING;
	int JOBS_DONE;
	int NORMAL_MENU;
	int NO_STEP_ADJ;
	int NPC_GIVE_EXP;

	KnightLord()
	{
		DROP_GOLD = RandomInt(10, 50);
		const string SOUND_STRUCK1 = "body/armour1.wav";
		const string SOUND_STRUCK2 = "body/armour2.wav";
		const string SOUND_STRUCK3 = "body/armour3.wav";
		const string SOUND_WARCRY = "voices/human/male_guard_dismiss.wav";
		const string SOUND_ATTACK = "weapons/swingsmall.wav";
		const string SOUND_PAIN = "voices/human/male_hit1.wav";
		const string SOUND_IDLE = "voices/human/male_idle2.wav";
		const string SOUND_DEATH = "voices/human/male_die.wav";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "swordswing1_L";
		ANIM_DEATH = "dieforward";
		ATTACK_MOVERANGE = 45;
		ATTACK_RANGE = 65;
		ATTACK_HITRANGE = 150;
		const float ATTACK_HITCHANCE = 0.9;
		const int ATTACK_DAMAGE = 45;
		const float ATTACK_STUNCHANCE = 0.5;
		const int FLEE_HEALTH = 15;
		const float FLEE_CHANCE = 0.05;
		NORMAL_MENU = 1;
		JOBS_DONE = 0;
		const int BG_NO_GO_HOME = 1;
		const int BG_ROAM = 1;
		const int BG_MAX_HEAR_CIV = 32000;
		NO_STEP_ADJ = 1;
		const int NO_CHAT = 1;
		Precache(SOUND_DEATH);
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumor", "rumour");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		if (!(IS_HUNTING))
		{
		}
		SetVolume(5);
		EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
	}

	void OnSpawn() override
	{
		SetName("knight_lord");
		SetMenuAutoOpen(1);
		SetHealth(800);
		SetGold(DROP_GOLD);
		SetWidth(32);
		SetHeight(72);
		SetRace("hguard");
		SetName("Lord of the land");
		SetRoam(true);
		SetHearingSensitivity(10);
		NPC_GIVE_EXP = 100;
		SetDamageResistance("all", ".4");
		SetMoveSpeed(1.0);
		SetBloodType("red");
		SetModel("npc/guard2.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		GiveItem(GetOwner(), "ring_light2");
	}

	void say_hail()
	{
		string L_RAND = RandomInt(0, 1);
		if (L_RAND == 0)
		{
			SayText("Well met, adventurer.");
		}
		else
		{
			if (L_RAND == 1)
			{
				SayText("How do you do?");
			}
		}
	}

	void say_rumor()
	{
		string L_RAND = RandomInt(0, 2);
		if (L_RAND == 0)
		{
			SayText("Cathlain seems to be losing guards in the sewers... perhaps he could use some help.");
		}
		else
		{
			if (L_RAND == 1)
			{
				SayText("Master Proffund likes gambling too much. Hopefully he doesn't get in trouble with the wrong people.");
			}
			else
			{
				if (L_RAND == 2)
				{
					SayText("I recently stored one of Thordac's weapons in Galat's Wondrous Chest of Storage, but it was gone when I went to retrieve it...");
					SayText("Guilda wasn't very helpful when trying to figure out where it went.");
				}
			}
		}
	}

	void say_job()
	{
		if (!(JOBS_DONE))
		{
			SayText("I have been looking for a sneaky pick pocket, who has been troubling the townsfolk.");
			SayText("If you spot him, do try to apprehend him, as I am also quite busy with other matters.");
			SayText("Do not worry, for you will be generously rewarded for your actions.");
		}
		if (!(JOBS_DONE)) return;
		SayText("I am afraid that, at the moment, I've no other tasks for good samaritans such as yourself.");
	}

	void say_jail()
	{
		SetRoam(false);
		SetMoveDest(FindEntityByName("thief"));
		SetMoveAnim(ANIM_IDLE);
		SayText("You shall be taken away and locked behind bars, thief!");
		string QUEST_COMPLETER = GetEntityName(APPREHENDER);
		SayText("QUEST_COMPLETER , you have done well.");
		SayText("Please accept this ring as a token of my gratitude.");
		SayText("May it bring light in even the darkest of dungeons and caves.");
		CallExternal(FindEntityByName("thief"), "quest_done");
		JOBS_DONE = 1;
		NORMAL_MENU = 0;
		OpenMenu(APPREHENDER);
		ScheduleDelayedEvent(10, "resume_roam");
	}

	void offer_ring()
	{
		// TODO: offer APPREHENDER ring_light2
		NORMAL_MENU = 1;
		GAVE_RING = 1;
	}

	void game_menu_cancel()
	{
		string L_RAND = RandomInt(0, 1);
		if (L_RAND == 0)
		{
			SayText("Very well then.");
		}
		else
		{
			if (L_RAND == 1)
			{
				SayText("As you were.");
			}
		}
		NORMAL_MENU = 1;
	}

	void game_menu_getoptions()
	{
		if (NORMAL_MENU == 1)
		{
			string reg.mitem.title = "Hail";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hail";
			string reg.mitem.title = "Ask about Rumors";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_rumor";
			string reg.mitem.title = "Ask about Jobs";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_job";
		}
		if (JOBS_DONE == 1)
		{
			if (!(GAVE_RING))
			{
			}
			string reg.mitem.title = "Accept";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "offer_ring";
		}
	}

	void resume_roam()
	{
		SetRoam(true);
		SetMoveAnim(ANIM_WALK);
	}

	void baseguard_tobattle()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
	}

	void attack_1()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 10);
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (RandomInt(1, 100) <= ATTACK_STUNCHANCE)
		{
			ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", 3, GetEntityIndex(GetOwner()));
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_PAIN
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_PAIN};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

}

}
