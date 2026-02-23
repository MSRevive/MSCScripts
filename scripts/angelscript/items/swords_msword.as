#pragma context server

#include "items/base_weapon.as"

namespace MS
{

class SwordsMsword : CGameScript
{
	string ATTACK_ACCURACYDEFAULT;
	string ATTACK_ACCURACYSTAT;
	int ATTACK_ALIGN_BASE;
	int ATTACK_ALIGN_TIP;
	string ATTACK_DAMAGE;
	string ATTACK_DAMAGE_RANGE;
	string ATTACK_DAMAGE_TYPE;
	string ATTACK_DONE_EVENT;
	string ATTACK_DURATION;
	string ATTACK_ENERGY;
	string ATTACK_EVENT;
	string ATTACK_KEYS;
	float ATTACK_LAND_DELAY;
	string ATTACK_LAND_EVENT;
	int ATTACK_PRIORITY;
	string ATTACK_RANGE;
	string ATTACK_TYPE;

	SwordsMsword()
	{
		const int BASE_LEVEL_REQ = 15;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MODEL_VIEW = "weapons/swords/shortsword_rview.mdl";
		const string MODEL_HANDS = "weapons/swords/p_swords.mdl";
		const string MODEL_WORLD = "weapons/swords/p_swords.mdl";
		const string MODEL_BLOCK = "armor/shields/p_shields.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int SWING_DELAY = 1;
		const float SWING_ENERGY = 0.4;
		const int SWING_RANGE = 60;
		const int ACCURACY_NORMAL = 80;
		const int SWING_DAMAGE = 290;
		const int SWING_DAMAGE_RANGE = 160;
		const string ITEM_NAME = "shortsword";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "shortsword";
	}

	void weapon_spawn()
	{
		SetName("Mithril Shortsword");
		SetDescription("A heavy mithril shortsword");
		SetWeight(80);
		SetSize(7);
		SetValue(800);
		SetWorldModel(MODEL_WORLD);
		SetPlayerModel(MODEL_HANDS);
		SetViewModel(MODEL_VIEW);
		SetHand("right");
		SetHUDSprite("hand", "sword");
		SetHUDSprite("trade", ITEM_NAME);
		registerattack_swing1();
		registerattack_swing2();
		registerattack_swing3();
		registerattack_parryside();
	}

	void registerattack_swing1()
	{
		ATTACK_TYPE = "strike-land";
		ATTACK_DAMAGE_TYPE = "slash";
		ATTACK_KEYS = "+attack1";
		ATTACK_PRIORITY = 1;
		ATTACK_DURATION = SWING_DELAY;
		ATTACK_LAND_DELAY = 0.6;
		ATTACK_EVENT = "swing1";
		ATTACK_LAND_EVENT = "swing_land";
		ATTACK_RANGE = SWING_RANGE;
		ATTACK_DAMAGE = SWING_DAMAGE;
		ATTACK_DAMAGE_RANGE = SWING_DAMAGE_RANGE;
		ATTACK_ENERGY = SWING_ENERGY;
		ATTACK_ACCURACYSTAT = "swordsmanship";
		ATTACK_ACCURACYDEFAULT = ACCURACY_NORMAL;
		ATTACK_ALIGN_BASE = 4;
		ATTACK_ALIGN_TIP = 0;
		RegisterAttack();
	}

	void registerattack_swing2()
	{
		ATTACK_TYPE = "strike-land";
		ATTACK_DAMAGE_TYPE = "slash";
		ATTACK_KEYS = "+attack1";
		ATTACK_PRIORITY = 1;
		ATTACK_DURATION = SWING_DELAY;
		ATTACK_LAND_DELAY = 0.6;
		ATTACK_EVENT = "swing1";
		ATTACK_LAND_EVENT = "swing_land";
		ATTACK_RANGE = SWING_RANGE;
		ATTACK_DAMAGE = SWING_DAMAGE;
		ATTACK_DAMAGE_RANGE = SWING_DAMAGE_RANGE;
		ATTACK_ENERGY = SWING_ENERGY;
		ATTACK_ACCURACYSTAT = "swordsmanship";
		ATTACK_ACCURACYDEFAULT = ACCURACY_NORMAL;
		ATTACK_ALIGN_BASE = 4;
		ATTACK_ALIGN_TIP = 0;
		RegisterAttack();
	}

	void registerattack_swing3()
	{
		ATTACK_TYPE = "strike-land";
		ATTACK_DAMAGE_TYPE = "slash";
		ATTACK_KEYS = "+attack1";
		ATTACK_PRIORITY = 1;
		ATTACK_DURATION = SWING_DELAY;
		ATTACK_LAND_DELAY = 0.6;
		ATTACK_EVENT = "swing1";
		ATTACK_LAND_EVENT = "swing_land";
		ATTACK_RANGE = SWING_RANGE;
		ATTACK_DAMAGE = SWING_DAMAGE;
		ATTACK_DAMAGE_RANGE = SWING_DAMAGE_RANGE;
		ATTACK_ENERGY = SWING_ENERGY;
		ATTACK_ACCURACYSTAT = "swordsmanship";
		ATTACK_ACCURACYDEFAULT = ACCURACY_NORMAL;
		ATTACK_ALIGN_BASE = 4;
		ATTACK_ALIGN_TIP = 0;
		RegisterAttack();
	}

	void swing1()
	{
		PlayViewAnim(ANIM_ATTACK1);
		swing();
	}

	void swing2()
	{
		PlayViewAnim(ANIM_ATTACK2);
		swing();
	}

	void swing3()
	{
		PlayViewAnim(ANIM_ATTACK3);
		swing();
	}

	void swing()
	{
		PlayOwnerAnim("once", "swordswing1");
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SWIPE);
		CallOwnerEvent("commenceattack");
	}

	void swing_land()
	{
		CallOwnerEvent("attackstrike");
	}

	void registerattack_parryside()
	{
		ATTACK_TYPE = "strike-hold";
		ATTACK_DAMAGE_TYPE = "slash";
		ATTACK_PRIORITY = 0;
		ATTACK_LAND_DELAY = 0;
		ATTACK_EVENT = "parryside";
		ATTACK_LAND_EVENT = "parryside_block";
		ATTACK_DONE_EVENT = "parryside_retract";
		ATTACK_RANGE = 20;
		ATTACK_ENERGY = 0.5;
		ATTACK_ACCURACYSTAT = "parry";
		ATTACK_ACCURACYDEFAULT = 0.45;
		RegisterAttack();
	}

}

}
