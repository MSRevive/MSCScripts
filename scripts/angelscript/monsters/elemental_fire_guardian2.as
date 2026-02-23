#pragma context server

#include "monsters/elemental_ice_guardian.as"

namespace MS
{

class ElementalFireGuardian2 : CGameScript
{
	int FLAME_JET_DMG;
	int FLAME_JET_DOT;

	ElementalFireGuardian2()
	{
		const string ICE_GUARD_NAME = "Fire Guardian";
		const int ICE_GUARD_HP = 6000;
		const float ICE_GUARD_FIRE_VULN = 0.0;
		const int ICE_GUARD_LEVEL = 2;
		const string ICE_GUARD_MODEL = "monsters/fire_guardian.mdl";
		const int ICE_GUARD_WIDTH = 32;
		const int ICE_GUARD_HEIGHT = 96;
		const int NPC_BASE_EXP = 2000;
		const int DMG_BURST = 200;
		const int DMG_LUNGE = 250;
		const int DMG_STAFF = 150;
		const int DOT_FROST = 150;
		const int DMG_FIRE_BURST = 400;
		FLAME_JET_DMG = 200;
		FLAME_JET_DOT = 100;
		const string FREQ_ICE_BALL = Random(10.0, 20.0);
		const string GUARD_ELEMENT = "fire";
		const string ICE_GUARD_DOT_EFFECT = "effects/dot_fire";
		const int ATTACK_MOVERANGE_DEF = 200;
		const float FREQ_PROJECTILE = 3.0;
		const string CL_FX_SCRIPT = "monsters/elemental_fire_guardian_cl";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		Precache("explode1.spr");
		Precache("xfireball3.spr");
	}

	void game_precache()
	{
		Precache("effects/sfx_seal");
		Precache("firemagic_8bit.spr");
	}

}

}
