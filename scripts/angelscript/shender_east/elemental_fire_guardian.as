#pragma context server

#include "shender_east/elemental_ice_guardian.as"

namespace MS
{

class ElementalFireGuardian : CGameScript
{
	int DOT_FROST;
	string GUARD_ELEMENT;
	string ICE_GUARD_DOT_EFFECT;
	float ICE_GUARD_FIRE_VULN;
	int ICE_GUARD_HEIGHT;
	float ICE_GUARD_ICE_VULN;
	int ICE_GUARD_LEVEL;
	string ICE_GUARD_MODEL;
	string ICE_GUARD_NAME;
	int ICE_GUARD_WIDTH;
	int NPC_BASE_EXP;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	ElementalFireGuardian()
	{
		ICE_GUARD_NAME = "Lesser Nightmare of Fire";
		ICE_GUARD_MODEL = "monsters/fire_guardian.mdl";
		ICE_GUARD_LEVEL = 1;
		ICE_GUARD_WIDTH = 32;
		ICE_GUARD_HEIGHT = 96;
		NPC_BASE_EXP = 500;
		GUARD_ELEMENT = "fire";
		ICE_GUARD_ICE_VULN = 1.5;
		ICE_GUARD_FIRE_VULN = 0.0;
		ICE_GUARD_DOT_EFFECT = "effects/dot_fire";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		DOT_FROST = 60;
	}

}

}
