#pragma context server

#include "items/base_melee.as"
#include "items/base_kick.as"

namespace MS
{

class GauntletsNormal : CGameScript
{
	string FISTS_LAST_ATTACK;
	string PUNCH_ATTACK;

	GauntletsNormal()
	{
		const int NO_IDLE = 1;
		const int MELEE_OVERRIDE = 1;
		const int ANIM_HANDS_DOWN = 3;
		const int ANIM_LIFT1 = 2;
		const int ANIM_LOWER = 3;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 4;
		const int ANIM_SHEATH = 3;
		const string MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		const int MODEL_VIEW_IDX = 2;
		const int MODEL_BODY_OFS = 54;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/axemetal1.wav";
		const string SOUND_HITWALL2 = "weapons/axemetal2.wav";
		const string SOUND_SWING = "weapons/swingsmall.wav";
		const string ANIM_PREFIX = "gauntlets";
		const int NO_WORLD_MODEL = 1;
		const int MELEE_RANGE = 50;
		const float MELEE_DMG_DELAY = 0.3;
		const float MELEE_ATK_DURATION = 0.9;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 80;
		const int MELEE_DMG_RANGE = 0;
		const string MELEE_DMG_TYPE = "blunt";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "martialarts";
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.05;
		const string PLAYERANIM_AIM = "fists";
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
		string l_elapsedtime = GetGameTime();
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
