#pragma context server

#include "monsters/bludgeon_gaz_base.as"

namespace MS
{

class BludgeonGaz1Mini : CGameScript
{
	int AM_MINI;
	string MONSTER_MODEL;

	BludgeonGaz1Mini()
	{
		MONSTER_MODEL = "monsters/bludgeon_gaz_mini.mdl";
		AM_MINI = 1;
	}

}

}
