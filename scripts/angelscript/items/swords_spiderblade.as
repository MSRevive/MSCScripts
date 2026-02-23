#pragma context server

#include "items/swords_base_twohanded.as"

namespace MS
{

class SwordsSpiderblade : CGameScript
{
	int PARRY_ON;
	string SWING_ANIM;

	SwordsSpiderblade()
	{
		const int BASE_LEVEL_REQ = 15;
		const int SWORD_MANUAL_PARRY = 1;
		const int ANIM_LIFT = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 2;
		const int ANIM_ATTACK3 = 2;
		const int ATTACK_ANIMS = 1;
		const int ANIM_LUNGE = 3;
		const int ANIM_PARRY1 = 4;
		const int ANIM_PARRY1_RETRACT = 5;
		const int ANIM_UNSHEATH = 6;
		const int ANIM_SHEATH = 7;
		const int ANIM_PARRY_DEBUG = 4;
		const int ANIM_UNPARRY_DEBUG = 5;
		const string MODEL_VIEW = "viewmodels/v_2hswords.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const string SOUND_DRAW = "weapons/swords/sworddraw.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int MODEL_BODY_OFS = 36;
		const string ANIM_PREFIX = "spiderblade";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.3;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 180;
		const int MELEE_DMG_RANGE = 140;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.7;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 3;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.3;
		const int MELEE_NEW_PARRY_CHANCE = 30;
		const string PLAYERANIM_AIM = "sword_double_idle";
		const string PLAYERANIM_SWING = "sword_double_swing";
	}

	void weapon_spawn()
	{
		SetName("Spiderblade");
		SetDescription("A magical blade designed to fend off spiders.");
		SetWeight(25);
		SetSize(9);
		SetValue(500);
		SetHUDSprite("trade", 92);
		SetHand("both");
	}

	void melee_start()
	{
		string SWING = RandomInt(1, 3);
		if (SWING == 1)
		{
			SWING_ANIM = ANIM_ATTACK1;
		}
		if (SWING == 2)
		{
			SWING_ANIM = ANIM_ATTACK2;
		}
		if (SWING == 3)
		{
			SWING_ANIM = ANIM_ATTACK3;
		}
		PlayOwnerAnim("once", "sword_double_swing");
		PlayViewAnim(SWING_ANIM);
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SWIPE);
	}

	void special_01_start()
	{
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void blockmode_start()
	{
		PlayViewAnim(ANIM_PARRY1);
		PlayOwnerAnim("once", "sword_swing");
		PARRY_ON = 1;
	}

	void blockmode_end()
	{
		PlayViewAnim(ANIM_PARRY1_RETRACT);
		PARRY_ON = 0;
	}

	void parryanim()
	{
		PlayViewAnim(ANIM_PARRY1);
		PlayOwnerAnim("once", "sword_swing");
		ScheduleDelayedEvent(0.75, "unparryanim");
	}

	void unparryanim()
	{
		PlayViewAnim(ANIM_PARRY1_RETRACT);
	}

	void game_dodamage()
	{
		if (!(GetEntityRace(param2) == "spider")) return;
		if (GetSkillLevel(GetOwner(), "swordsmanship") < BASE_LEVEL_REQ)
		{
			SendColoredMessage(GetOwner(), "You lack the skill to activate this weapon's magic.");
		}
		if (!(GetSkillLevel(GetOwner(), "swordsmanship") >= BASE_LEVEL_REQ)) return;
		ApplyEffect(GetEntityIndex(param2), "effects/dot_fire", 10, GetEntityIndex(GetOwner()), Random(30, 50), "swordsmanship");
	}

}

}
