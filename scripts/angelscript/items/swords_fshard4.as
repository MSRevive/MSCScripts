#pragma context server

#include "items/swords_fshard1.as"

namespace MS
{

class SwordsFshard4 : CGameScript
{
	void weapon_spawn()
	{
		SetName("Felewyn Shard IV");
		SetDescription("A shard of the legendary Felewyn Blade");
		SetWeight(100);
		SetSize(10);
		SetValue(5000);
		SetHUDSprite("trade", 132);
		SetHand("both");
	}

}

}
