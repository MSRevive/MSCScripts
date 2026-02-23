#pragma context server

#include "items/base_crest.as"

namespace MS
{

class GownEdana : CGameScript
{
	GownEdana()
	{
		const int MODEL_CREST_OFS = 1;
	}

	void crest_spawn()
	{
		SetName("Crest of Edana");
		SetDescription("A Crest of Edana worn by the defenders of the Temple");
	}

}

}
