#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	void old_helena_warboss_died()
	{
		gold_spew(25, 2, 64, 8, 24, G_WARBOSS_ORIGIN);
		SendInfoMsg("all", "Old Helena has been saved! Click use on NPCs to purchase rewards.");
		SpawnItem("axes_greataxe", G_WARBOSS_ORIGIN);
		ApplyEffect(GetEntityIndex(m_hLastCreated), "old_helena/track_gaxe_pickup");
	}

}

}
