#pragma context server

#include "monsters/bludgeon_gaz_base.as"

namespace MS
{

class BludgeonGaz1CorruptMini : CGameScript
{
	int AM_CORRUPT;
	int AM_MINI;
	string MONSTER_MODEL;

	BludgeonGaz1CorruptMini()
	{
		AM_CORRUPT = 1;
		MONSTER_MODEL = "monsters/bludgeon_gaz_mini.mdl";
		AM_MINI = 1;
	}

}

}
