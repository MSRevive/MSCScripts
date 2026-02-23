#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsEth : CGameScript
{
	string ETHER_ABORT;

	SmallarmsEth()
	{
		const int BASE_LEVEL_REQ = 25;
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 48;
		const int MODEL_VIEW_IDX = 12;
		const int MELEE_RANGE = 50;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_DMG = 225;
		const int MELEE_DMG_RANGE = 50;
		const string MELEE_DMG_TYPE = "dark";
		const float MELEE_ACCURACY = 0.85;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.05;
		const string PLAYERANIM_AIM = "knife";
		const string PLAYERANIM_SWING = "swing_knife";
		const string SOUND_HITWALL1 = "debris/glass1.wav";
		const string SOUND_HITWALL2 = "debris/glass2.wav";
		const string ANIM_PREFIX = "standard";
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
