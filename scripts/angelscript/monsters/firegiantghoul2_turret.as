#pragma context server

#include "monsters/firegiantghoul.as"

namespace MS
{

class Firegiantghoul2Turret : CGameScript
{
	int AM_TURRET;
	int NO_ROAM;

	Firegiantghoul2Turret()
	{
		AM_TURRET = 1;
		NO_ROAM = 1;
	}

}

}
