#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfFire : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfFire()
	{
		BQ_QUIVER_TYPE = "proj_arrow_fire";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Fire Arrows");
	}

}

}
