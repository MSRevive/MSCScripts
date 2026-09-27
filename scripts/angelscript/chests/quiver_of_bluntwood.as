#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfBluntwood : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfBluntwood()
	{
		BQ_QUIVER_TYPE = "proj_arrow_bluntwooden";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Blunt Arrows");
	}

}

}
