#pragma context server

#include "monsters/base_chat.as"
#include "monsters/base_npc.as"
#include "old_helena/base_old_helena_npc.as"

namespace MS
{

class Erkold : CGameScript
{
	int GAVE_REWARD;
	int HELENA_SAVED;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;

	Erkold()
	{
		NO_HAIL = 1;
		NO_RUMOR = 1;
		NO_JOB = 1;
	}

	void OnSpawn() override
	{
		SetHealth(1000);
		SetGold(0);
		SetName("Erkold");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(1, 2);
		SetBloodType("red");
	}

	void old_helena_warboss_died()
	{
		SetMenuAutoOpen(1);
		HELENA_SAVED = 1;
	}

	void game_menu_getoptions()
	{
		if (!(HELENA_SAVED)) return;
		if ((GAVE_REWARD)) return;
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "give_reward";
	}

	void give_reward()
	{
		if ((GAVE_REWARD))
		{
			PlayAnim("critical", "lean");
			bchat_mouth_move();
			SayText(I + "wish " + I + " had more to give , but most of my belongings went up with the flames.");
		}
		if ((GAVE_REWARD)) return;
		GAVE_REWARD = 1;
		bchat_mouth_move();
		SayText("Thank the gods you saved us! Here! Take this as a reward!");
		// TODO: offer PARAM1 GetRandomToken("scroll2_healing_circle_920;scroll_healing_circle", ";")
	}

}

}
