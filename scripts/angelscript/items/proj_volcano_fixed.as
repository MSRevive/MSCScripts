#pragma context server

#include "items/proj_volcano.as"

namespace MS
{

class ProjVolcanoFixed : CGameScript
{
	void game_dodamage()
	{
		if (!(param1)) return;
		string F_MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer(F_MY_OWNER);
		if ((IsValidPlayer(param2)))
		{
			if ((OWNER_ISPLAYER))
			{
			}
			if (!("game.pvp"))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		int DMG_FIRE = 50;
		ApplyEffect(param2, "effects/dot_fire", 5, F_MY_OWNER, DMG_FIRE, "spellcasting.fire");
	}

}

}
