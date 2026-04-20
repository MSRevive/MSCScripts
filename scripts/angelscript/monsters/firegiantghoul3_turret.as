#pragma context server

#include "monsters/firegiantghoul3.as"

namespace MS
{

class Firegiantghoul3Turret : CGameScript
{
	int AM_TURRET;
	int NO_ROAM;

	Firegiantghoul3Turret()
	{
		AM_TURRET = 1;
		NO_ROAM = 1;
	}

}

}
