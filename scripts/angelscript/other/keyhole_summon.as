#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeSummon : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeSummon()
	{
		KEY_NAME = "item_summon_crystal";
		KEYHOLE_NAME = "Crystal Holder";
		KEYHOLE_TITLE = "Place the Summoning Crystal";
		RETURN_KEY = 0;
	}

	void OnSpawn() override
	{
		SetName(KEYHOLE_NAME);
		SetWidth(2);
		SetHeight(16);
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(2);
		SetFly(true);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SetMenuAutoOpen(1);
	}

}

}
