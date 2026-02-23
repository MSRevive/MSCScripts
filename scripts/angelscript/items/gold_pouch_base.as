#pragma context server

namespace MS
{

class GoldPouchBase : CGameScript
{
	string GOLD_VALUE;

	GoldPouchBase()
	{
		const int GOLD_AMT = 10;
		const string SOUND_GOLD = "misc/gold.wav";
	}

	void OnSpawn() override
	{
		SetName("Pouch of GOLD_AMT coins");
		SetDescription("You find some gold coins...");
		SetViewModel("none");
		SetWorldModel("none");
		SetModel("none");
		SetWeight(0);
		SetSize(0);
		SetHUDSprite("trade", "gold");
		SetAnimExt("blunt");
		GOLD_VALUE = GOLD_AMT;
	}

}

}
