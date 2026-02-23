#pragma context server

#include "monsters/spider_spitting.as"

namespace MS
{

class Darkspid : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(150);
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
		SetName("Veneficus Umbra");
		SetHearingSensitivity(7);
		SetModel("monsters/fer_spider_large.mdl");
		SetModelBody(0, 2);
		SetDamageResistance("all", ".8");
	}

}

}
