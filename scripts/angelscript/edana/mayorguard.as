#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Mayorguard : CGameScript
{
	string ANIM_ATTACK;
	int ATTACK1_DAMAGE;
	int ATTACK_RANGE;
	int BRIBED;
	int EVIDENCE_FOUND;
	int HEAR_RANGE;
	int NO_RUMOR;
	int NPC_REACTS;
	int SHOW_APPLE;
	int THIEF_1;

	Mayorguard()
	{
		ANIM_ATTACK = "swordswing1_L";
		ATTACK1_DAMAGE = 30;
		ATTACK_RANGE = 128;
		NO_RUMOR = 1;
		HEAR_RANGE = 100;
		NPC_REACTS = 1;
	}

	void OnSpawn() override
	{
		SetName("mayorguard");
		SetHealth(1);
		SetName("Mayor s Guard");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/guard1.mdl");
		SetInvincible(true);
		SetActionAnim(ANIM_ATTACK);
		EVIDENCE_FOUND = 0;
		BRIBED = 0;
		THIEF_1 = 5;
		SHOW_APPLE = 0;
		SetMenuAutoOpen(1);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_mayor", "mayor");
		CatchSpeech("say_thief", "thief");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_name", "name");
	}

	void say_name()
	{
		EmitSound(GetOwner(), CHAN_VOICE, "npc/hello1.wav", 9);
		SetName("Dorian");
		SayText("My name is Dorian.");
	}

	void say_hi()
	{
		if (!(BRIBED == 0)) return;
		if (!(GetEntityDist("ent_lastspoke") <= HEAR_RANGE)) return;
		EmitSound(GetOwner(), CHAN_VOICE, "npc/edrin1.wav", 7);
		SayText("If you do not have business with the mayor , be on your way.");
	}

	void say_mayor()
	{
		if (BRIBED == 0)
		{
			if (!(EVIDENCE_FOUND))
			{
			}
			SayText("He is much too busy for the likes of you , move on!");
			PlayAnim("once", "no");
		}
		if (EVIDENCE_FOUND == 1)
		{
			SayText("The house is going to be locked until a new mayor is found");
			PlayAnim("once", "no");
		}
	}

	void npcreact_targetsighted()
	{
		if (!(BRIBED == 0)) return;
		SayText("Halt! What is your business?");
		PlayAnim("once", "pushbutton2");
	}

	void give_apple()
	{
		if (!(EVIDENCE_FOUND == 0)) return;
		ReceiveOffer("accept");
		SayText(A + " delicious treat , proceed traveller");
		UseTrigger("mayorsdoor");
		BRIBED = 1;
	}

	void give_map()
	{
		if (!(THIEF_1 == 7)) return;
		ReceiveOffer("accept");
		PlayAnim("once", "return_needle");
		SayText("Ah , what s this? A map of the thieves whereabouts? You have done well, my friend.");
		ScheduleDelayedEvent(4, "say_thiefloc");
	}

	void bribe()
	{
		ReceiveOffer("accept");
		SayText("*whispering* Thank you , traveller. Proceed.");
		PlayAnim("once", "lean");
		UseTrigger("mayorsdoor");
		BRIBED = 1;
	}

	void bribe_failed()
	{
		SayText("You call that a bribe? " + HA! + " If you offer 500 , give me 500!");
		PlayAnim("once", "no");
	}

	void attack_1()
	{
		DoDamage("ent_laststole", ATTACK_RANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
	}

	void say_job()
	{
		if (!(GetEntityDist("ent_lastspoke") <= HEAR_RANGE)) return;
		SayText("What , do " + I + " look like a tourguide? My job is to protect the mayor , now leave!");
		PlayAnim("once", "no");
	}

	void say_thief()
	{
		if (!(THIEF_1 == 5)) return;
		THIEF_1 = 6;
		EmitSound(GetOwner(), "npc/suspicious.wav");
		SayText("If you see anything suspicious around here , you let me know.");
		if (!(THIEF_1 == 6)) return;
		THIEF_1 = 7;
		SayText("If you see any thieves , try bribing them for information , or give threats that " + I + " will lock them up for good.");
		ScheduleDelayedEvent(4, "say_thief2");
	}

	void say_thief2()
	{
		SayText("Aye , " + I + "will have them thieves locked up , if not killed should " + I + " get my hands on them.");
	}

	void say_thiefloc()
	{
		SayText("Hmmmm... this map shows bandits in a few of the local areas , one being in the Thornlands.");
		ScheduleDelayedEvent(4, "say_thiefloc2");
	}

	void say_thiefloc2()
	{
		SayText("There will probably be thieves around the area. If not , look in the caves near the road to Edana.");
		ScheduleDelayedEvent(4, "say_thiefloc3");
	}

	void say_thiefloc3()
	{
		SayText("Bring me proof that you ve killed them and I ll reward you , if not killing them is reward enough.");
		ScheduleDelayedEvent(4, "say_thiefloc4");
	}

	void say_thiefloc4()
	{
		SetVolume(8);
		Say("guardwarn");
		SayText("Be wary , it is dangerous outside.");
	}

	void worldevent_evidence_found()
	{
		EVIDENCE_FOUND = 1;
	}

	void game_menu_getoptions()
	{
		if ((EVIDENCE_FOUND)) return;
		if ((ItemExists(param1, "health_apple")))
		{
			string reg.mitem.title = "Bribe with apple";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "health_apple";
			string reg.mitem.callback = "give_apple";
		}
		string reg.mitem.title = "Bribe (500g)";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "gold:500";
		string reg.mitem.callback = "bribe";
		string reg.mitem.cb_failed = "bribe_failed";
	}

	void bryan_said_so()
	{
		SHOW_APPLE = 1;
	}

}

}
