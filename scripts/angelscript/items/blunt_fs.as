#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntFs : CGameScript
{
	string BURST_DOT_BURN;
	string BURST_POS;
	string FIRE_BURST_TARGS;

	BluntFs()
	{
		const int BASE_LEVEL_REQ = 20;
		const int FIRE_BURST_MP = 30;
		const string MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		const int MODEL_VIEW_IDX = 8;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 90;
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const int MELEE_ENERGY = 8;
		const int MELEE_DMG = 250;
		const int MELEE_DMG_RANGE = 140;
		const string MELEE_DMG_TYPE = "fire";
		const float MELEE_ACCURACY = 0.8;
		const string MELEE_STAT = "bluntarms";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_AUGMENT = 0.0;
	}

	void weapon_spawn()
	{
		SetName("Fire Star");
		SetDescription("A morning star forged with elemental fire");
		SetWeight(35);
		SetSize(6);
		SetValue(2000);
		SetHUDSprite("hand", "mace");
		SetHUDSprite("trade", 188);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURN_DAMAGE /= 2;
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "bluntarms");
	}

	void special_02_damaged_other()
	{
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURN_DAMAGE /= 2;
		BURN_DAMAGE += Random(1, 3);
		ApplyEffect(param1, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "bluntarms");
	}

	void special_02_strike()
	{
		string ATTACK_END_POS = param2;
		if (!((ATTACK_END_POS).z == /* TODO: $get_ground_height */ $get_ground_height(ATTACK_END_POS))) return;
		if (GetEntityMP(GetOwner()) < FIRE_BURST_MP)
		{
			string NO_GO_MSG = "Fire Star: Insufficient Mana for Flame Burst";
		}
		if (GetSkillLevel(GetOwner(), "spellcasting.fire") < 20)
		{
			string NO_GO_MSG = "Fire Star: Insufficient Fire Skill for Flame Burst";
		}
		if (NO_GO_MSG != "NO_GO_MSG")
		{
			SendColoredMessage(GetOwner(), "NO_GO_MSG");
		}
		if (!(NO_GO_MSG == "NO_GO_MSG")) return;
		EmitSound(GetOwner(), 0, "ambience/steamburst1.wav", 10);
		GiveMP(GetOwner());
		ClientEvent("new", "all", "effects/sfx_fire_burst", ATTACK_END_POS, 128, 1, Vector3(255, 0, 0));
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", 128, ATTACK_END_POS);
		FIRE_BURST_TARGS = GetEntityProperty(GetOwner(), "scriptvar");
		LogDebug("FIRE_BURST_TARGS");
		BURST_POS = ATTACK_END_POS;
		if (!(FIRE_BURST_TARGS != "none")) return;
		BURST_DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURST_DOT_BURN *= 0.5;
		for (int i = 0; i < GetTokenCount(FIRE_BURST_TARGS, ";"); i++)
		{
			fire_burst_affect_targs();
		}
	}

	void fire_burst_affect_targs()
	{
		string CUR_TARG = GetToken(FIRE_BURST_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TRACE_START = BURST_POS;
		string TRACE_END = TARG_ORG;
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		if (GetEntityHealth(CUR_TARG) < 1500)
		{
			string TARG_ORG = GetEntityOrigin(CUR_TARG);
			string MY_ORG = GetEntityOrigin(GetOwner());
			string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			string NEW_YAW = TARG_ANG;
			AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 800, 0)));
		}
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), BURST_DOT_BURN, "bluntarms");
	}

}

}
