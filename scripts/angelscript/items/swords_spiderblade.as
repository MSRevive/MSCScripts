#pragma context server

#include "items/swords_base_twohanded.as"

namespace MS
{

class SwordsSpiderblade : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT;
	int ANIM_LUNGE;
	int ANIM_PARRY1;
	int ANIM_PARRY1_RETRACT;
	int ANIM_PARRY_DEBUG;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int ANIM_UNPARRY_DEBUG;
	int ANIM_UNSHEATH;
	int ATTACK_ANIMS;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	int MELEE_NEW_PARRY_CHANCE;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	int PARRY_ON;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	string SOUND_DRAW;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SHOUT;
	string SOUND_SWIPE;
	string SWING_ANIM;
	int SWORD_MANUAL_PARRY;

	SwordsSpiderblade()
	{
		BASE_LEVEL_REQ = 15;
		SWORD_MANUAL_PARRY = 1;
		ANIM_LIFT = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 2;
		ANIM_ATTACK3 = 2;
		ATTACK_ANIMS = 1;
		ANIM_LUNGE = 3;
		ANIM_PARRY1 = 4;
		ANIM_PARRY1_RETRACT = 5;
		ANIM_UNSHEATH = 6;
		ANIM_SHEATH = 7;
		ANIM_PARRY_DEBUG = 4;
		ANIM_UNPARRY_DEBUG = 5;
		MODEL_VIEW = "viewmodels/v_2hswords.mdl";
		MODEL_VIEW_IDX = 2;
		MODEL_HANDS = "weapons/p_weapons1.mdl";
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		SOUND_DRAW = "weapons/swords/sworddraw.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		MODEL_BODY_OFS = 36;
		ANIM_PREFIX = "spiderblade";
		MELEE_RANGE = 80;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.3;
		MELEE_ENERGY = 1;
		MELEE_DMG = 180;
		MELEE_DMG_RANGE = 140;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.7;
		MELEE_STAT = "swordsmanship";
		MELEE_ALIGN_BASE = 3;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.3;
		MELEE_NEW_PARRY_CHANCE = 30;
		PLAYERANIM_AIM = "sword_double_idle";
		PLAYERANIM_SWING = "sword_double_swing";
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
		int SWING = RandomInt(1, 3);
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
