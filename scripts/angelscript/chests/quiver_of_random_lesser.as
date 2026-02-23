#pragma context server

#include "chests/base_quiver_of.as"

namespace MS
{

class QuiverOfRandomLesser : CGameScript
{
	int BQ_BUNDLE_SIZE;
	string BQ_QUIVER_TYPE;

	QuiverOfRandomLesser()
	{
		BQ_QUIVER_TYPE = "proj_arrow_silvertipped";
		BQ_BUNDLE_SIZE = 60;
	}

	void OnSpawn() override
	{
		SetName("Quiver of Arrows");
		ScheduleDelayedEvent(0.1, "pick_random_type");
	}

	void pick_random_type()
	{
		string ARROW_QUALITY = RandomInt(1, 3);
		if (ARROW_QUALITY < 3)
		{
			string ARROW_LIST = G_NOOB_ARROWS;
		}
		else
		{
			string ARROW_LIST = G_GOOD_ARROWS;
		}
		string N_ARROWS = GetTokenCount(ARROW_LIST, ";");
		N_ARROWS -= 1;
		string RND_ARROW = RandomInt(0, N_ARROWS);
		BQ_QUIVER_TYPE = GetToken(ARROW_LIST, RND_ARROW, ";");
	}

}

}
