#pragma context server

#include "traps/circle_of_death1.as"

namespace MS
{

class CircleOfDeath2 : CGameScript
{
	int CIRCLE_RAD;
	int CL_BODY;
	int CL_RAD;

	CircleOfDeath2()
	{
		CIRCLE_RAD = 140;
		CL_BODY = 4;
		CL_RAD = 156;
	}

}

}
