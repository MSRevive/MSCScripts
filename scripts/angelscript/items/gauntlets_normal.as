#pragma context server

#include "items/base_melee.as"
#include "items/base_kick.as"

namespace MS
{

class GauntletsNormal : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_HANDS_DOWN;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	int ANIM_LOWER;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	string FISTS_LAST_ATTACK;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	int MELEE_OVERRIDE;
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
	int NO_IDLE;
	int NO_WORLD_MODEL;
	string PLAYERANIM_AIM;
	string PUNCH_ATTACK;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SWING;
	string SOUND_SWIPE;

	GauntletsNormal()
	{
		NO_IDLE = 1;
		MELEE_OVERRIDE = 1;
		ANIM_HANDS_DOWN = 3;
		ANIM_LIFT1 = 2;
		ANIM_LOWER = 3;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 4;
		ANIM_SHEATH = 3;
		MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		MODEL_VIEW_IDX = 2;
		MODEL_BODY_OFS = 54;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_HITWALL1 = "weapons/axemetal1.wav";
		SOUND_HITWALL2 = "weapons/axemetal2.wav";
		SOUND_SWING = "weapons/swingsmall.wav";
		ANIM_PREFIX = "gauntlets";
		NO_WORLD_MODEL = 1;
		MELEE_RANGE = 50;
		MELEE_DMG_DELAY = 0.3;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 1;
		MELEE_DMG = 80;
		MELEE_DMG_RANGE = 0;
		MELEE_DMG_TYPE = "blunt";
		MELEE_ACCURACY = 0.75;
		MELEE_STAT = "martialarts";
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.05;
		PLAYERANIM_AIM = "fists";
	}

	void weapon_spawn()
	{
		SetName("a set of|Gauntlets");
		SetDescription("Strong metal gauntlets for otherwise unarmed combat");
		SetWeight(3);
		SetSize(1);
		SetValue(200);
		SetHand("both");
		SetHUDSprite("hand", "gauntlets");
		SetHUDSprite("trade", "gauntlets");
	}

	void weapon_deploy()
	{
		PlayViewAnim(ANIM_HANDS_DOWN);
	}

	void melee_start()
	{
		PlayViewAnim(ANIM_ATTACK1);
		if (PUNCH_ATTACK == 0)
		{
			string l.punch_anim = "stance_normal_lowjab_r1";
			PUNCH_ATTACK = 1;
		}
		else
		{
			if (PUNCH_ATTACK == 1)
			{
				string l.punch_anim = "stance_normal_lowjab_r2";
				PUNCH_ATTACK = 0;
			}
		}
		PlayOwnerAnim("once", l.punch_anim);
		EmitSound(GetOwner(), "const.sound.item", SOUND_SWING, 5);
		FISTS_LAST_ATTACK = GetGameTime();
		punch1_done();
	}

	void punch1_done()
	{
		SetRepeatDelay(1);
		if (!(FISTS_LAST_ATTACK)) return;
		float l_elapsedtime = GetGameTime();
		l_elapsedtime -= FISTS_LAST_ATTACK;
		if (!(l_elapsedtime > 5)) return;
		PlayViewAnim(ANIM_LOWER);
		FISTS_LAST_ATTACK = 0;
	}

	void hitwall()
	{
		// PlayRandomSound from: SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
