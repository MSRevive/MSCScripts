#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntBf : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	string BURST_DMG;
	string BURST_POS;
	string BURST_STUN_DURATION;
	float DEMON_ATK_DURATION;
	float DEMON_DMG_DELAY;
	string DOT_FIRE;
	string GAME_PVP;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	int STUN_BURST_MP;

	BluntBf()
	{
		BASE_LEVEL_REQ = 35;
		STUN_BURST_MP = 40;
		MELEE_RANGE = 90;
		MELEE_DMG_DELAY = 0.5;
		MELEE_ATK_DURATION = 1.1;
		DEMON_DMG_DELAY = 0.25;
		DEMON_ATK_DURATION = 0.7;
		MELEE_ENERGY = 2;
		MELEE_DMG = 600;
		MELEE_DMG_RANGE = 40;
		MELEE_ACCURACY = 0.8;
		MELEE_PARRY_AUGMENT = 0.2;
		MELEE_DMG_TYPE = "fire";
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 12;
		MODEL_WORLD = "weapons/p_weapons4.mdl";
		MODEL_BODY_OFS = 34;
		ANIM_PREFIX = "standard";
	}

	void weapon_spawn()
	{
		SetName("Fire Breaker");
		SetDescription("An Earth Breaker imbued with elemental fire");
		SetWeight(80);
		SetSize(10);
		SetValue(7000);
		SetHUDSprite("hand", "hammer");
		SetHUDSprite("trade", 194);
	}

	void OnDeploy() override
	{
		GAME_PVP = "game.pvp";
	}

	void melee_damaged_other()
	{
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		string L_DOT = GetSkillLevel(GetOwner(), "spellcasting.fire");
		L_DOT *= 0.5;
		ApplyEffect(param1, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), L_DOT, "bluntarms");
	}

	void special_02_strike()
	{
		string ATTACK_END_POS = param2;
		if (GetEntityMP(GetOwner()) < STUN_BURST_MP)
		{
			SendColoredMessage(GetOwner(), "Fire Breaker: Insufficient Mana for Fire Burst");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ATTACK_END_POS = "z";
		GiveMP(GetOwner());
		ClientEvent("new", "all", "effects/sfx_fire_burst", ATTACK_END_POS, 250, 1, Vector3(255, 128, 0));
		BURST_POS = ATTACK_END_POS;
		BURST_POS += 32;
		if (GetSkillLevel(GetOwner(), "spellcasting.fire") > 20)
		{
			CallExternal(GetOwner(), "ext_fissure");
		}
		BURST_STUN_DURATION = GetSkillLevel(GetOwner(), "bluntarms");
		BURST_DMG = BURST_STUN_DURATION;
		BURST_STUN_DURATION *= 0.5;
		BURST_DMG *= 4.0;
		LogDebug("special_02_strike stundur BURST_STUN_DURATION");
		DOT_FIRE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		XDoDamage(BURST_POS, 128, BURST_DMG, 0, GetOwner(), GetOwner(), "spellcasting.fire", "fire_effect", "dmgevent:*burst");
	}

	void burst_dodamage()
	{
		string CUR_TARG = param2;
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(CUR_TARG, "effects/debuff_stun", BURST_STUN_DURATION, GetEntityIndex(GetOwner()));
		if (DOT_FIRE >= 10)
		{
			ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE, "bluntarms");
		}
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = BURST_POS;
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 800, 110)));
	}

}

}
