#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfSilver : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfSilver()
	{
		BQ_QUIVER_TYPE = "proj_arrow_silvertipped";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Elven Arrows");
	}

}

}
