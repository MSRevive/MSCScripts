#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestValor : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestValor()
	{
		MODEL_CREST_OFS = 6;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Knights of Valor");
		SetDescription("The crest worn by the members of The Knights of Valor");
	}

}

}
