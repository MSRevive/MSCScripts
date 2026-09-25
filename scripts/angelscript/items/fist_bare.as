#pragma context server

#include "items/base_melee.as"
#include "items/base_kick.as"

namespace MS
{

class FistBare : CGameScript
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
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	int NO_IDLE;
	int NO_PARRY;
	string PLAYERANIM_AIM;
	string PUNCH_ATTACK;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SWIPE;

	FistBare()
	{
		NO_PARRY = 1;
		NO_IDLE = 1;
		ANIM_HANDS_DOWN = 3;
		ANIM_LIFT1 = 2;
		ANIM_LOWER = 3;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 4;
		ANIM_SHEATH = 3;
		MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		MODEL_HANDS = "none";
		MODEL_WORLD = "none";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_HITWALL1 = "weapons/cbar_hitbod1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hitbod2.wav";
		MODEL_BODY_OFS = 0;
		ANIM_PREFIX = "fists";
		MELEE_RANGE = 50;
		MELEE_DMG_DELAY = 0.3;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 1;
		MELEE_DMG = 60;
		MELEE_DMG_RANGE = 0;
		MELEE_DMG_TYPE = "blunt";
		MELEE_ACCURACY = 0.7;
		MELEE_STAT = "martialarts";
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.0;
		PLAYERANIM_AIM = "fists";
	}

	void weapon_spawn()
	{
		SetName("Bare Fists");
		SetDescription("Your bare fists");
		SetWeight(0);
		SetSize(0);
		SetValue(0);
		SetHand("undroppable");
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
		// PlayRandomSound from: "game.sound.maxvol", SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {"game.sound.maxvol", SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void ext_activate_items()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		LogDebug("ext_activate_items ext_register_fists");
		CallExternal(GetOwner(), "ext_register_fists", GetEntityIndex(GetOwner()));
	}

}

}
