#pragma context server

#include "keledrosprelude/bat.as"

namespace MS
{

class Bookbat : CGameScript
{
	void OnSpawn() override
	{
		SetName("Lesser Firebat");
		SetHealth(25);
	}

}

}
