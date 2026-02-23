#pragma context server

#include "monsters/elemental_ice_guardian.as"

namespace MS
{

class ElementalFireGuardian : CGameScript
{
	ElementalFireGuardian()
	{
		const string ICE_GUARD_NAME = "Lesser Fire Guardian";
		const string ICE_GUARD_MODEL = "monsters/fire_guardian.mdl";
		const int ICE_GUARD_LEVEL = 1;
		const int ICE_GUARD_WIDTH = 32;
		const int ICE_GUARD_HEIGHT = 96;
		const int NPC_BASE_EXP = 750;
		const string GUARD_ELEMENT = "fire";
		const float ICE_GUARD_ICE_VULN = 1.5;
		const float ICE_GUARD_FIRE_VULN = 0.0;
		const string ICE_GUARD_DOT_EFFECT = "effects/dot_fire";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const int DOT_FROST = 60;
	}

}

}
