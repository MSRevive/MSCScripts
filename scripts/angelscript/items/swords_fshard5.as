#pragma context server

#include "items/swords_fshard1.as"

namespace MS
{

class SwordsFshard5 : CGameScript
{
	void weapon_spawn()
	{
		SetName("Felewyn Shard V");
		SetDescription("A shard of the legendary Felewyn Blade");
		SetWeight(100);
		SetSize(10);
		SetValue(5000);
		SetHUDSprite("trade", 132);
		SetHand("both");
	}

}

}
