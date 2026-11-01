#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfJagged : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfJagged()
	{
		BQ_QUIVER_TYPE = "proj_arrow_jagged";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Jagged Arrows");
	}

}

}
