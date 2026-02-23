#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesGthunder11 : CGameScript
{
	AxesGthunder11()
	{
		const string MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int MODEL_BODY_OFS = 124;
		const string MELEE_DMG_TYPE = "lightning";
		const float MELEE_ACCURACY = 0.35;
		const int BASE_LEVEL_REQ = 20;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string ANIM_PREFIX = "axe";
		const int MELEE_RANGE = 100;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.5;
		const int MELEE_ENERGY = 3;
		const int MELEE_DMG = 400;
		const int MELEE_DMG_RANGE = 50;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Greater Thunderaxe");
		SetDescription("An axe enchanted with powerful lightning magics");
		SetWeight(110);
		SetSize(15);
		SetValue(3000);
		SetHUDSprite("hand", 122);
		SetHUDSprite("trade", 122);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "axehandling");
	}

}

}
