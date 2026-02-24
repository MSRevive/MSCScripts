#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsEth : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	string ETHER_ABORT;
	float MELEE_ACCURACY;
	float MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	float MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND_DELAY;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	SmallarmsEth()
	{
		BASE_LEVEL_REQ = 25;
		MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_BODY_OFS = 48;
		MODEL_VIEW_IDX = 12;
		MELEE_RANGE = 50;
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 0.6;
		MELEE_DMG = 225;
		MELEE_DMG_RANGE = 50;
		MELEE_DMG_TYPE = "dark";
		MELEE_ACCURACY = 0.85;
		MELEE_ALIGN_BASE = 3.6;
		MELEE_ALIGN_TIP = 0;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.05;
		PLAYERANIM_AIM = "knife";
		PLAYERANIM_SWING = "swing_knife";
		SOUND_HITWALL1 = "debris/glass1.wav";
		SOUND_HITWALL2 = "debris/glass2.wav";
		ANIM_PREFIX = "standard";
	}

	void weapon_spawn()
	{
		SetName("Ethereal Dagger");
		SetDescription("A ghostly dagger");
		SetWeight(3);
		SetSize(2);
		SetValue(3000);
		SetHUDSprite("hand", 136);
		SetHUDSprite("trade", 136);
	}

	void melee_damaged_other()
	{
		if ((ETHER_ABORT)) return;
		if (!(IsEntityAlive(param1))) return;
		string ENEMY_ARMOR = GetEntityProperty(param1, "scriptvar");
		string IN_DAMAGE = param2;
		if (!(ENEMY_ARMOR > 0)) return;
		adj_damage(ENEMY_ARMOR, IN_DAMAGE);
	}

	void special_02_damaged_other()
	{
		if ((ETHER_ABORT)) return;
		if (!(IsEntityAlive(param1))) return;
		string ENEMY_ARMOR = GetEntityProperty(param1, "scriptvar");
		string IN_DAMAGE = param2;
		if (!(ENEMY_ARMOR > 0)) return;
		adj_damage(ENEMY_ARMOR, IN_DAMAGE);
	}

	void adj_damage()
	{
		string ENEMY_ARMOR = param1;
		string IN_DAMAGE = param2;
		if (!(IN_DAMAGE > 0)) return;
		if (!(ENEMY_ARMOR < 1)) return;
		int MULT_DAMAGE = 1;
		MULT_DAMAGE /= ENEMY_ARMOR;
		LogDebug("adj_damage armr ENEMY_ARMOR dmg IN_DAMAGE");
		string OUT_DAMAGE = IN_DAMAGE;
		OUT_DAMAGE *= MULT_DAMAGE;
		SetDamage("dmg");
		return;
	}

	void ext_ether()
	{
		if ((ETHER_ABORT))
		{
			ETHER_ABORT = 0;
		}
		else
		{
			ETHER_ABORT = 1;
		}
		LogDebug("ext_ether ETHER_ABORT");
	}

}

}
