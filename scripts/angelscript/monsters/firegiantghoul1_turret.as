#pragma context server

#include "monsters/firegiantghoul1.as"

namespace MS
{

class Firegiantghoul1Turret : CGameScript
{
	int AM_TURRET;
	int NO_ROAM;

	Firegiantghoul1Turret()
	{
		AM_TURRET = 1;
		NO_ROAM = 1;
	}

}

}
