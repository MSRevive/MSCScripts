#pragma context server

#include "items/base_elemental_resist.as"
#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntStaffFOld : CGameScript
{
	BluntStaffFOld()
	{
		const int BASE_LEVEL_REQ = 30;
		const string ELM_NAME = "phlame";
		const string ELM_TYPE = "cold";
		const int ELM_AMT = 20;
		const int ELM_WEAPON = 1;
		const int MELEE_RANGE = 110;
		const float MELEE_DMG_DELAY = 0.4;
		const float MELEE_ATK_DURATION = 1.0;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 300;
		const int MELEE_DMG_RANGE = 20;
		const float MELEE_ACCURACY = 0.8;
		const float MELEE_PARRY_AUGMENT = 0.2;
		const string MELEE_DMG_TYPE = "fire";
		const string MELEE_STAT = "spellcasting.fire";
		const string MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		const int MODEL_VIEW_IDX = 12;
		const string MODEL_WORLD = "weapons/p_weapons4.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "standard";
		const string PLAYERANIM_AIM = "sword_double_idle";
		const string PLAYERANIM_SWING = "pole_swing";
	}

	void weapon_spawn()
	{
		SetName("Phlame s Staff");
		SetDescription("A demonic staff of fire");
		SetWeight(60);
		SetSize(10);
		SetValue(7000);
		SetHUDSprite("hand", "hammer");
		SetHUDSprite("trade", 52);
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		cl_refresh_loop();
	}

	void cl_refresh_loop()
	{
		if (!(true)) return;
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int BEW_IS_WEILDED = 1;
		}
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int BEW_IS_WEILDED = 1;
		}
		if ((BEW_IS_WEILDED))
		{
			ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "phlames_viewfinder_on", GetEntityIndex(GetOwner()));
			ScheduleDelayedEvent(5.0, "cl_refresh_loop");
		}
		else
		{
			ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "phlames_viewfinder_off");
		}
	}

}

}
