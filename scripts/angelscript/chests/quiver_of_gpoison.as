#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfGpoison : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfGpoison()
	{
		BQ_QUIVER_TYPE = "proj_arrow_gpoison";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Deadly Arrows");
	}

}

}
