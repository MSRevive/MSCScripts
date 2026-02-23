#pragma context server

#include "items/base_weapon.as"

namespace MS
{

class SwordsM2sword : CGameScript
{
	string ATTACK_ACCURACYDEFAULT;
	string ATTACK_ACCURACYSTAT;
	int ATTACK_ALIGN_BASE;
	int ATTACK_ALIGN_TIP;
	string ATTACK_DAMAGE;
	string ATTACK_DAMAGE_RANGE;
	string ATTACK_DAMAGE_TYPE;
	int ATTACK_DONE_EVENT;
	float ATTACK_DURATION;
	string ATTACK_ENERGY;
	string ATTACK_EVENT;
	string ATTACK_KEYS;
	float ATTACK_LAND_DELAY;
	string ATTACK_LAND_EVENT;
	int ATTACK_PRIORITY;
	int ATTACK_RANGE;
	string ATTACK_TYPE;

	SwordsM2sword()
	{
		const int BASE_LEVEL_REQ = 15;
		const int ANIM_LIFT = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_PARRY1 = 4;
		const int ANIM_PARRY1_RETRACT = 5;
		const int ANIM_UNSHEATH = 6;
		const int ANIM_SHEATH = 7;
		const string MODEL_VIEW = "weapons/swords/highsword_rview.mdl";
		const string MODEL_HANDS = "weapons/swords/p_swords.mdl";
		const string MODEL_WORLD = "weapons/swords/p_swords.mdl";
		const string MODEL_BLOCK = "armor/shields/p_shields.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit1.wav";
		const string SOUND_DRAW = "weapons/swords/sworddraw.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const float SWING_DELAY = 1.1;
		const float SWING_ENERGY = 1.5;
		const float SWING_ACCURACY = 0.8;
		const int SWING_DAMAGE = 300;
		const int SWING_DAMAGE_RANGE = 180;
		const string ITEM_NAME = "longsword";
		const int MODEL_BODY_OFS = 4;
		const string ANIM_PREFIX = "highsword";
	}

	void weapon_spawn()
	{
		SetName("Mithril Sword");
		SetDescription("A heavy , two-handed Mithril sword");
		SetWeight(110);
		SetSize(9);
		SetValue(1000);
		SetWorldModel(MODEL_WORLD);
		SetPlayerModel(MODEL_HANDS);
		SetViewModel(MODEL_VIEW);
		SetHUDSprite("hand", "sword");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("both");
		registerattack_swingside();
		registerattack_swingoverhead();
		registerattack_parryside();
	}

	void registerattack_swingoverhead()
	{
		ATTACK_TYPE = "strike-land";
		ATTACK_DAMAGE_TYPE = "slash";
		ATTACK_KEYS = "+back+attack1";
		ATTACK_PRIORITY = 1;
		ATTACK_DURATION = 1.3;
		ATTACK_LAND_DELAY = 0.3;
		ATTACK_EVENT = "swingoverhead";
		ATTACK_LAND_EVENT = "swingoverhead_land";
		ATTACK_DONE_EVENT = 0;
		ATTACK_RANGE = 80;
		ATTACK_DAMAGE = SWING_DAMAGE;
		ATTACK_DAMAGE_RANGE = SWING_DAMAGE_RANGE;
		ATTACK_ENERGY = SWING_ENERGY;
		ATTACK_ACCURACYSTAT = "swordsmanship";
		ATTACK_ACCURACYDEFAULT = SWING_ACCURACY;
		ATTACK_ALIGN_BASE = 3;
		ATTACK_ALIGN_TIP = 0;
		RegisterAttack();
	}

	void swingoverhead()
	{
		PlayViewAnim(ANIM_ATTACK2);
		PlayOwnerAnim("once", "longsword_swipe");
		CallOwnerEvent("commenceattack");
	}

	void swingoverhead_land()
	{
		CallOwnerEvent("attackstrike");
	}

	void registerattack_swingside()
	{
		ATTACK_TYPE = "strike-land";
		ATTACK_DAMAGE_TYPE = "slash";
		ATTACK_KEYS = "+attack1";
		ATTACK_PRIORITY = 0;
		ATTACK_DURATION = 1.3;
		ATTACK_LAND_DELAY = 0.3;
		ATTACK_EVENT = "swingside";
		ATTACK_LAND_EVENT = "swingside_land";
		ATTACK_DONE_EVENT = 0;
		ATTACK_RANGE = 70;
		ATTACK_DAMAGE = SWING_DAMAGE;
		ATTACK_DAMAGE_RANGE = SWING_DAMAGE_RANGE;
		ATTACK_ENERGY = SWING_ENERGY;
		ATTACK_ACCURACYSTAT = "swordsmanship";
		ATTACK_ACCURACYDEFAULT = SWING_ACCURACY;
		ATTACK_ALIGN_BASE = -20;
		ATTACK_ALIGN_TIP = 20;
		RegisterAttack();
	}

	void swingside()
	{
		PlayViewAnim(ANIM_ATTACK1);
		PlayOwnerAnim("once", "longsword_swipe");
		SetVolume(10);
		// TODO: UNCONVERTED: playrandomsoundcl 0 SOUND_SWIPE
		CallOwnerEvent("commenceattack");
	}

	void swingside_land()
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
		ATTACK_ACCURACYDEFAULT = 0.65;
		RegisterAttack();
	}

	void parryside_retract()
	{
		PlayViewAnim(ANIM_PARRY1_RETRACT);
		PlayOwnerAnim("break");
	}

}

}
