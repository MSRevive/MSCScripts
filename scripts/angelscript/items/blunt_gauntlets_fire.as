#pragma context server

#include "items/base_melee.as"
#include "items/base_kick.as"

namespace MS
{

class BluntGauntletsFire : CGameScript
{
	string BWEAPON_CHARGE_PERCENT;
	string FISTS_LAST_ATTACK;
	string GAME_PVP;
	string PUNCH_ATTACK;

	BluntGauntletsFire()
	{
		const int MELEE_OVERRIDE = 1;
		const int SPECIAL1_OVERRIDE = 1;
		const string MELEE_CALLBACK = "gaunt";
		const string DOT_EFFECT = "effects/dot_fire";
		const int BASE_LEVEL_REQ = 15;
		const int ANIM_HANDS_DOWN = 3;
		const int ANIM_LIFT1 = 2;
		const int ANIM_LOWER = 3;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 4;
		const int ANIM_SHEATH = 3;
		const string MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		const int MODEL_VIEW_IDX = 3;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/axemetal1.wav";
		const string SOUND_HITWALL2 = "ambience/steamburst1.wav";
		const string SOUND_SWING = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 56;
		const int NO_WORLD_MODEL = 1;
		const string ANIM_PREFIX = "gauntlets";
		const int MELEE_RANGE = 40;
		const float MELEE_DMG_DELAY = 0.3;
		const float MELEE_ATK_DURATION = 0.9;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 100;
		const int MELEE_DMG_RANGE = 0;
		const string MELEE_DMG_TYPE = "fire";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "martialarts";
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.1;
		const string PLAYERANIM_AIM = "fists";
	}

	void weapon_spawn()
	{
		SetName("Gauntlets of Fire");
		SetDescription("These magical gauntlets are infused with elemental fire");
		SetWeight(3);
		SetSize(1);
		SetValue(2500);
		SetHand("both");
		SetHUDSprite("hand", 97);
		SetHUDSprite("trade", 97);
	}

	void weapon_deploy()
	{
		GAME_PVP = "game.pvp";
		PlayViewAnim(ANIM_HANDS_DOWN);
	}

	void gaunt_start()
	{
		PlayViewAnim(MELEE_VIEWANIM_ATK);
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

	void item_idle()
	{
	}

	void gaunt_damaged_other()
	{
		if (!(RandomInt(1, 2) == 1)) return;
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURN_DAMAGE /= 1.5;
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		ApplyEffect(param1, DOT_EFFECT, 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "martialarts");
		if ((BWEAPON_NO_PERCENT_CHARGE)) return;
		if (BWEAPON_CHARGE_PERCENT > 0.25)
		{
			BWEAPON_CHARGE_PERCENT -= 0.25;
			string CHARGE_RATIO = /* TODO: $ratio */ $ratio(BWEAPON_CHARGE_PERCENT, 1.25, BWEAPON_DBL_CHARGE_ADJ);
			string NEW_DMG = param2;
			NEW_DMG *= CHARGE_RATIO;
			SetDamage("dmg");
			return;
			LogDebug("Adjusted dmg x CHARGE_RATIO");
			BWEAPON_CHARGE_PERCENT = 0;
			string CUR_DRAIN = MELEE_ENERGY;
			CUR_DRAIN *= BWEAPON_CHARGE_PERCENT;
			DrainStamina(GetOwner());
		}
	}

	void gaunt_playsound()
	{
		EmitSound(GetOwner(), "const.snd.weapon", SOUND_SWIPE, "const.snd.maxvol");
	}

	void special_01_start()
	{
		gaunt_start();
		if (!(true)) return;
		// svplaysound: svplaysound 1 10 SPECIAL01_SND
		EmitSound(1, 10, SPECIAL01_SND);
	}

}

}
