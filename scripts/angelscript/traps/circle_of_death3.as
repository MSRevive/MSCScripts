#pragma context server

#include "traps/circle_of_death1.as"

namespace MS
{

class CircleOfDeath3 : CGameScript
{
	int CIRCLE_RAD;
	int CL_BODY;
	int CL_RAD;

	CircleOfDeath3()
	{
		CIRCLE_RAD = 180;
		CL_BODY = 5;
		CL_RAD = 200;
	}

}

}
