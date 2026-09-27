#pragma context server

#include "items/blunt_maul.as"

namespace MS
{

class BluntDarkmaul : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string PLAYERANIM_SWING;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	BluntDarkmaul()
	{
		BASE_LEVEL_REQ = 15;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 2;
		ANIM_SHEATH = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		PLAYERANIM_SWING = "swing_bluntdouble";
		MELEE_DMG_TYPE = "dark";
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 4;
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		MODEL_HANDS = "weapons/p_weapons1.mdl";
		MODEL_BODY_OFS = 62;
		ANIM_PREFIX = "darkmaul";
		Precache(MODEL_VIEW);
		Precache(MODEL_WORLD);
		Precache(MODEL_HANDS);
		MELEE_DMG = 240;
		MELEE_DMG_RANGE = 150;
		MELEE_ENERGY = 5;
		MELEE_ATK_DURATION = 1.5;
		MELEE_ACCURACY = 0.7;
		SOUND_HITWALL1 = "debris/metal6.wav";
		SOUND_HITWALL2 = "ambience/steamburst1.wav";
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
