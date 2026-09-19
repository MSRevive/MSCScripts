#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfLightning : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfLightning()
	{
		BQ_QUIVER_TYPE = "proj_arrow_lightning";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Lightning Arrows");
	}

}

}
