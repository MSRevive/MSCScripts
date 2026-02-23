#pragma context server

#include "items/blunt_maul.as"

namespace MS
{

class BluntDarkmaul : CGameScript
{
	BluntDarkmaul()
	{
		const int BASE_LEVEL_REQ = 15;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 2;
		const int ANIM_SHEATH = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string PLAYERANIM_SWING = "swing_bluntdouble";
		const string MELEE_DMG_TYPE = "dark";
		const string MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		const int MODEL_VIEW_IDX = 4;
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const int MODEL_BODY_OFS = 62;
		const string ANIM_PREFIX = "darkmaul";
		Precache(MODEL_VIEW);
		Precache(MODEL_WORLD);
		Precache(MODEL_HANDS);
		const int MELEE_DMG = 240;
		const int MELEE_DMG_RANGE = 150;
		const int MELEE_ENERGY = 5;
		const float MELEE_ATK_DURATION = 1.5;
		const float MELEE_ACCURACY = 0.7;
		const string SOUND_HITWALL1 = "debris/metal6.wav";
		const string SOUND_HITWALL2 = "ambience/steamburst1.wav";
	}

	void weapon_spawn()
	{
		SetName("Dark Maul");
		SetDescription("This maul of scorched metal emits an evil aura");
		SetWeight(150);
		SetSize(15);
		SetValue(1500);
		SetHUDSprite("trade", 100);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURN_DAMAGE /= 2;
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "bluntarms");
	}

}

}
