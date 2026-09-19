#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfFrostArrows : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfFrostArrows()
	{
		BQ_QUIVER_TYPE = "proj_arrow_frost";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Frost Arrows");
	}

}

}
