#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Keledros : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("scroll_lightning_storm", 100);
		tc_add_artifact("scroll_volcano", 100);
		tc_add_artifact("scroll_fire_wall", 100);
		tc_add_artifact("scroll_fire_ball", 100);
		tc_add_artifact("scroll_blizzard", 100);
		tc_add_artifact("scroll2_lightning_storm", 100);
		tc_add_artifact("scroll2_volcano", 100);
		tc_add_artifact("scroll2_fire_wall", 100);
		tc_add_artifact("scroll2_fire_ball", 100);
		tc_add_artifact("scroll2_blizzard", 100);
	}

	void chest_additems()
	{
		add_gold(100);
	}

}

}
