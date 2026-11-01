#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfWooden : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfWooden()
	{
		BQ_QUIVER_TYPE = "proj_arrow_wooden";
		BQ_BUNDLE_SIZE = 30;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Wooden Arrows");
	}

}

}
