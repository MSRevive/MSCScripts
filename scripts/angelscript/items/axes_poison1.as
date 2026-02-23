#pragma context server

#include "items/axes_battleaxe.as"

namespace MS
{

class AxesPoison1 : CGameScript
{
	void weapon_spawn()
	{
		SetName("Envenomed Battleaxe");
		SetDescription("This battleaxe has been laced with a fast acting poison");
		SetWeight(80);
		SetSize(15);
		SetValue(500);
		SetHUDSprite("hand", "battleaxe");
		SetHUDSprite("trade", "battleaxe");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string L_RAND = RandomInt(0, 1);
		if (!(L_RAND)) return;
		ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", RandomInt(6, 12), GetEntityIndex(GetOwner()), Random(3.5, 5.5), "axehandling");
	}

}

}
