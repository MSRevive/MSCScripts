#pragma context server

#include "monsters/bludgeon_gaz_base.as"

namespace MS
{

class BludgeonGaz2Corrupt : CGameScript
{
	int AM_CORRUPT;
	int AM_HAMMER;

	BludgeonGaz2Corrupt()
	{
		AM_CORRUPT = 1;
		AM_HAMMER = 1;
	}

}

}
