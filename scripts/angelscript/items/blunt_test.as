#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntTest : CGameScript
{
	BluntTest()
	{
		const string MODEL_VIEW = "viewmodels/gearshield_rview.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string MODEL_PLAYER = "weapons/staff/snake_staff_player.mdl";
		const int MODEL_BODY_OFS = 58;
		const string ANIM_PREFIX = "khopesh";
		const string MELEE_STAT = "spellcasting.affliction";
		const int SECONDARY_DMG = 0;
		const string MELEE_DMG_TYPE = "poison";
		const string SOUND_SUMMON = "magic/spawn.wav";
		const string SOUND_BITE = "bullchicken/bc_bite2.wav";
		const string SOUND_POISON = "monsters/snakeman/sm_alert1.wav";
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 0;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 1;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 5;
		const int ANIM_SHEATH = 4;
		const int MELEE_RANGE = 100;
		const float MELEE_DMG_DELAY = 0.3;
		const float MELEE_ATK_DURATION = 0.6;
		const float MELEE_ENERGY = 0.3;
		const int MELEE_DMG = 30;
		const int MELEE_DMG_RANGE = 60;
		const float MELEE_ACCURACY = 0.65;
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
