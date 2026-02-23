#pragma context server

#include "items/swords_shortsword.as"

namespace MS
{

class SwordsPoison1 : CGameScript
{
	SwordsPoison1()
	{
		const int BASE_LEVEL_REQ = 6;
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string random = RandomInt(1, 100);
		if (!(random > 50)) return;
		ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", RandomInt(3, 6), GetEntityIndex(GetOwner()), Random(1.5, 2.5), "swordsmanship");
	}

	void weapon_spawn()
	{
		SetName("Envenomed Shortsword");
		SetDescription("This shortsword is laced with vile poison that oozes along the blade.");
		SetWeight(30);
		SetSize(7);
		SetValue(500);
		SetHUDSprite("trade", "shortsword");
	}

}

}
