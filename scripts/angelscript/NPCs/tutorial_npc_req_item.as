#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class TutorialNpcReqItem : CGameScript
{
	string ANIM_IDLE;
	string ANIM_OPEN_DOOR;
	int GOT_RAT_SKULL;

	TutorialNpcReqItem()
	{
		ANIM_IDLE = "idle1";
		ANIM_OPEN_DOOR = "gluonshow";
	}

	void OnSpawn() override
	{
		SetName("Old Hag");
		SetModel("npc/human2.mdl");
		SetHealth(1);
		SetWidth(32);
		SetHeight(96);
		SetInvincible(true);
		SetNoPush(true);
		SetRace("beloved");
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		SetSayTextRange(1024);
		SetMenuAutoOpen(1);
		CatchSpeech("say_hail", "hail");
		CatchSpeech("say_pretty", "pretty");
	}

	void game_menu_getoptions()
	{
		if ((GOT_RAT_SKULL)) return;
		if ((ItemExists(param1, "item_ratskull")))
		{
			SayText("My my , what a pretty skull you ve found there...");
			move_mouth();
			string reg.mitem.title = "Offer Golden Rat Skull";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_ratskull";
			string reg.mitem.callback = "got_rat_skull";
		}
		else
		{
			SayText("No one gets by this door until " + I + " get my [pretty]");
			move_mouth();
			string reg.mitem.title = "Your pretty?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_pretty";
		}
	}

	void say_hail()
	{
		if (!(GOT_RAT_SKULL))
		{
			SayText("No one gets by this door until " + I + " get my [pretty]");
			move_mouth();
		}
		else
		{
			SayText("Thank you for returning my pretty... " + I + " ll be sure to keep it safe, this time.");
		}
	}

	void say_pretty()
	{
		if (!(GOT_RAT_SKULL))
		{
			SayText("Yes! My golden rat skull. Bloody thing grew legs and wandered off... Again!");
			SayText("Find it for me , and " + I + " ll open this door - but not before!");
			move_mouth();
		}
		else
		{
			SayText("Thank you. " + I + " ve got my good eye on it now... It ll not wander off again.");
		}
	}

	void move_mouth()
	{
		Say("[0.2] [0.2] [0.3] [0.1] [0.1] [0.2] [0.1] [0.1]");
	}

	void got_rat_skull()
	{
		GOT_RAT_SKULL = 1;
		SayText("Finally! My pretty rat skull is returned to me! Alright... Here we go...");
		move_mouth();
		PlayAnim("critical", ANIM_OPEN_DOOR);
		ScheduleDelayedEvent(0.25, "open_door");
		SetMenuAutoOpen(0);
	}

	void open_door()
	{
		UseTrigger("hag_door");
	}

}

}
