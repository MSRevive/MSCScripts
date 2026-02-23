#pragma context server

#include "monsters/spider_spitting.as"

namespace MS
{

class SpiderFireSpitting : CGameScript
{
	int DOT_FIRE;
	int NPC_GIVE_EXP;

	SpiderFireSpitting()
	{
		const string PROJ_TYPE = "proj_fire_xolt";
		const Vector3 PROJ_OFS = Vector3(0, 0, 32);
		DOT_FIRE = 3;
	}

	void spider_spawn()
	{
		SetHealth(100);
		if (!(AM_CLIPPED))
		{
			SetWidth(64);
			SetHeight(64);
		}
		if ((AM_CLIPPED))
		{
			SetWidth(32);
			SetHeight(20);
		}
		SetName("Fire Spider");
		SetHearingSensitivity(7);
		SetModel("monsters/fer_spider_large.mdl");
		SetProp(GetOwner(), "skin", 1);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 0.0);
		NPC_GIVE_EXP = 90;
	}

	void bite_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DOT_FIRE);
	}

}

}
