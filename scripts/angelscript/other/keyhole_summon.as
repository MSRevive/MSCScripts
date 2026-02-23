#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeSummon : CGameScript
{
	int RETURN_KEY;

	KeyholeSummon()
	{
		const string KEY_NAME = "item_summon_crystal";
		const string KEYHOLE_NAME = "Crystal Holder";
		const string KEYHOLE_TITLE = "Place the Summoning Crystal";
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
