#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestValor : CGameScript
{
	CrestValor()
	{
		const int MODEL_CREST_OFS = 6;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Knights of Valor");
		SetDescription("The crest worn by the members of The Knights of Valor");
	}

}

}
