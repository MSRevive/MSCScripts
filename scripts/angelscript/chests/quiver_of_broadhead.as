#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfBroadhead : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfBroadhead()
	{
		BQ_QUIVER_TYPE = "proj_arrow_broadhead";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Broadhead Arrows");
	}

}

}
