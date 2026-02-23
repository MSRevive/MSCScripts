#pragma context server

#include "items/base_melee.as"
#include "items/base_kick.as"

namespace MS
{

class FistBare : CGameScript
{
	string FISTS_LAST_ATTACK;
	string PUNCH_ATTACK;

	FistBare()
	{
		const int NO_PARRY = 1;
		const int NO_IDLE = 1;
		const int ANIM_HANDS_DOWN = 3;
		const int ANIM_LIFT1 = 2;
		const int ANIM_LOWER = 3;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 4;
		const int ANIM_SHEATH = 3;
		const string MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "none";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hitbod2.wav";
		const int MODEL_BODY_OFS = 0;
		const string ANIM_PREFIX = "fists";
		const int MELEE_RANGE = 50;
		const float MELEE_DMG_DELAY = 0.3;
		const float MELEE_ATK_DURATION = 0.9;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 60;
		const int MELEE_DMG_RANGE = 0;
		const string MELEE_DMG_TYPE = "blunt";
		const float MELEE_ACCURACY = 0.7;
		const string MELEE_STAT = "martialarts";
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.0;
		const string PLAYERANIM_AIM = "fists";
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
		string l_elapsedtime = GetGameTime();
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
