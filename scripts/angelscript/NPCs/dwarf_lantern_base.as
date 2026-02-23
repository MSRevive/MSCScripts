#pragma context server

namespace MS
{

class DwarfLanternBase : CGameScript
{
	string CUSTOM_LANTERN_COLOR;
	string LANTERN_ACTIVE;
	string LANTERN_CL_IDX;
	int LANTERN_ON;
	int LANTERN_SET;
	string NEXT_LANTERNCL_REFRESH;

	DwarfLanternBase()
	{
		const float FREQ_LANTERNCL_REFRESH = 30.0;
		const int LANTERN_HAND_SUBMODEL = 1;
		const int LANTERN_HAND_INDEX = 1;
		const Vector3 LANTERN_COLOR = Vector3(128, 64, 0);
	}

	void game_precache()
	{
		Precache("3dmflagry.spr");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(LANTERN_ON)) return;
		if (!(GetGameTime() > NEXT_LANTERNCL_REFRESH)) return;
		NEXT_LANTERNCL_REFRESH = GetGameTime();
		NEXT_LANTERNCL_REFRESH += FREQ_LANTERNCL_REFRESH;
		if (!(LANTERN_ACTIVE))
		{
			LANTERN_ACTIVE = 1;
			SetModelBody(2, LANTERN_HAND_SUBMODEL);
		}
		if (CUSTOM_LANTERN_COLOR != "CUSTOM_LANTERN_COLOR")
		{
			string L_LANTERN_COLOR = CUSTOM_LANTERN_COLOR;
		}
		else
		{
			string L_LANTERN_COLOR = LANTERN_COLOR;
		}
		ClientEvent("new", "all", "NPCs/dwarf_lantern_cl", GetEntityIndex(GetOwner()), LANTERN_HAND_INDEX, L_LANTERN_COLOR, FREQ_LANTERNCL_REFRESH);
		LANTERN_CL_IDX = "game.script.last_sent_id";
	}

	void set_lantern()
	{
		LANTERN_ON = 1;
		LANTERN_SET = 1;
		if (param1 == 0)
		{
			ClientEvent("update", "all", LANTERN_CL_IDX, "end_fx");
			SetModelBody(2, 0);
			LANTERN_ON = 0;
			LANTERN_ACTIVE = 0;
		}
		else
		{
			if ((param1).findFirst("(") == 0)
			{
			}
			CUSTOM_LANTERN_COLOR = param1;
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("update", "all", LANTERN_CL_IDX, "end_fx");
	}

}

}
