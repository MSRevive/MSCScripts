#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfPoison : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfPoison()
	{
		BQ_QUIVER_TYPE = "proj_arrow_poison";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Envenomed Arrows");
	}

}

}
