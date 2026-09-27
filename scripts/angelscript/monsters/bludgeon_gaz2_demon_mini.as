#pragma context server

#include "monsters/bludgeon_gaz_base.as"

namespace MS
{

class BludgeonGaz2DemonMini : CGameScript
{
	int AM_DEMON;
	int AM_HAMMER;
	int AM_MINI;
	string MONSTER_MODEL;

	BludgeonGaz2DemonMini()
	{
		AM_DEMON = 1;
		AM_HAMMER = 1;
		MONSTER_MODEL = "monsters/bludgeon_gaz_mini.mdl";
		AM_MINI = 1;
	}

}

}
