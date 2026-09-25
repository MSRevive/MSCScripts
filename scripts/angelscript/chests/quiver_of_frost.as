#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfFrost : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfFrost()
	{
		BQ_QUIVER_TYPE = "proj_arrow_frost";
		BQ_BUNDLE_SIZE = 60;
	}

}

}
