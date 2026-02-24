#pragma context server

#include "items/base_elemental_resist.as"
#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntStaffFOld : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	int ELM_AMT;
	string ELM_NAME;
	string ELM_TYPE;
	int ELM_WEAPON;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	string MELEE_STAT;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;

	BluntStaffFOld()
	{
		BASE_LEVEL_REQ = 30;
		ELM_NAME = "phlame";
		ELM_TYPE = "cold";
		ELM_AMT = 20;
		ELM_WEAPON = 1;
		MELEE_RANGE = 110;
		MELEE_DMG_DELAY = 0.4;
		MELEE_ATK_DURATION = 1.0;
		MELEE_ENERGY = 2;
		MELEE_DMG = 300;
		MELEE_DMG_RANGE = 20;
		MELEE_ACCURACY = 0.8;
		MELEE_PARRY_AUGMENT = 0.2;
		MELEE_DMG_TYPE = "fire";
		MELEE_STAT = "spellcasting.fire";
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 12;
		MODEL_WORLD = "weapons/p_weapons4.mdl";
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "standard";
		PLAYERANIM_AIM = "sword_double_idle";
		PLAYERANIM_SWING = "pole_swing";
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
