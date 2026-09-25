#pragma context server

#include "items/base_medal.as"

namespace MS
{

class ItemSorcv : CGameScript
{
	string MEDAL_FX_SCRIPT;

	ItemSorcv()
	{
		MEDAL_FX_SCRIPT = "items/item_sorcv_cl";
		Precache("medals.spr");
	}

	void medal_spawn()
	{
		SetName("Shadahar Medal");
		SetDescription("Achievement Medal for Shadahar Village");
	}

	void medal_activate()
	{
		string OWNER_MEDALS = GetPlayerQuestData(GetOwner(), "a");
		string OWNER_ACHIEVE_LEVEL = GetToken(OWNER_MEDALS, 0, ";");
		OWNER_ACHIEVE_LEVEL -= 1;
		if (OWNER_ACHIEVE_LEVEL == 0)
		{
			string OUT_MSG = "Has Achieved Tin Status in the Shadahar Village Challenge";
		}
		if (OWNER_ACHIEVE_LEVEL == 1)
		{
			string OUT_MSG = "Has Achieved Bronze Status in the Shadahar Village Challenge";
		}
		if (OWNER_ACHIEVE_LEVEL == 2)
		{
			string OUT_MSG = "Has Achieved Silver Status in the Shadahar Village Challenge";
		}
		if (OWNER_ACHIEVE_LEVEL == 3)
		{
			string OUT_MSG = "Has Achieved Gold Status in the Shadahar Village Challenge";
		}
		if (OWNER_ACHIEVE_LEVEL == 4)
		{
			string OUT_MSG = "Has Achieved Platinum Status in the Shadahar Village Challenge";
		}
		if (OWNER_ACHIEVE_LEVEL == 5)
		{
			string OUT_MSG = "Has Achieved Diamond Status in the Shadahar Village Challenge";
		}
		if (OWNER_ACHIEVE_LEVEL == 6)
		{
			string OUT_MSG = "Has Achieved LORELDIAN Status in the Shadahar Village Challenge";
		}
		SendInfoMsg("all", GetEntityName(GetOwner()) + OUT_MSG);
		string SPAWN_POINT = GetEntityOrigin(GetOwner());
		string MY_ANGLES = GetEntityAngles(GetOwner());
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 128, 0));
		SPAWN_POINT = "z";
		SPAWN_POINT += "z";
		ClientEvent("new", "all", MEDAL_FX_SCRIPT, SPAWN_POINT, OWNER_ACHIEVE_LEVEL, MY_YAW, 20.0);
	}

}

}
