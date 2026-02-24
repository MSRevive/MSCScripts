#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntTest : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	float MELEE_ENERGY;
	int MELEE_RANGE;
	string MELEE_STAT;
	int MODEL_BODY_OFS;
	string MODEL_PLAYER;
	string MODEL_VIEW;
	string MODEL_WORLD;
	int SECONDARY_DMG;
	string SOUND_BITE;
	string SOUND_POISON;
	string SOUND_SUMMON;

	BluntTest()
	{
		MODEL_VIEW = "viewmodels/gearshield_rview.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_PLAYER = "weapons/staff/snake_staff_player.mdl";
		MODEL_BODY_OFS = 58;
		ANIM_PREFIX = "khopesh";
		MELEE_STAT = "spellcasting.affliction";
		SECONDARY_DMG = 0;
		MELEE_DMG_TYPE = "poison";
		SOUND_SUMMON = "magic/spawn.wav";
		SOUND_BITE = "bullchicken/bc_bite2.wav";
		SOUND_POISON = "monsters/snakeman/sm_alert1.wav";
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 0;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 1;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 5;
		ANIM_SHEATH = 4;
		MELEE_RANGE = 100;
		MELEE_DMG_DELAY = 0.3;
		MELEE_ATK_DURATION = 0.6;
		MELEE_ENERGY = 0.3;
		MELEE_DMG = 30;
		MELEE_DMG_RANGE = 60;
		MELEE_ACCURACY = 0.65;
	}

	void weapon_spawn()
	{
		SetName("Test Item");
		SetDescription("Test stuff");
		SetWeight(10);
		SetSize(1);
		SetValue(500);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "package");
	}

}

}
