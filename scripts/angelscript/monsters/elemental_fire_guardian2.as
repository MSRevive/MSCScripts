#pragma context server

#include "monsters/elemental_ice_guardian.as"

namespace MS
{

class ElementalFireGuardian2 : CGameScript
{
	int ATTACK_MOVERANGE_DEF;
	string CL_FX_SCRIPT;
	int DMG_BURST;
	int DMG_FIRE_BURST;
	int DMG_LUNGE;
	int DMG_STAFF;
	int DOT_FROST;
	int FLAME_JET_DMG;
	int FLAME_JET_DOT;
	float FREQ_ICE_BALL;
	float FREQ_PROJECTILE;
	string GUARD_ELEMENT;
	string ICE_GUARD_DOT_EFFECT;
	float ICE_GUARD_FIRE_VULN;
	int ICE_GUARD_HEIGHT;
	int ICE_GUARD_HP;
	int ICE_GUARD_LEVEL;
	string ICE_GUARD_MODEL;
	string ICE_GUARD_NAME;
	int ICE_GUARD_WIDTH;
	int NPC_BASE_EXP;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	ElementalFireGuardian2()
	{
		ICE_GUARD_NAME = "Fire Guardian";
		ICE_GUARD_HP = 6000;
		ICE_GUARD_FIRE_VULN = 0.0;
		ICE_GUARD_LEVEL = 2;
		ICE_GUARD_MODEL = "monsters/fire_guardian.mdl";
		ICE_GUARD_WIDTH = 32;
		ICE_GUARD_HEIGHT = 96;
		NPC_BASE_EXP = 2000;
		DMG_BURST = 200;
		DMG_LUNGE = 250;
		DMG_STAFF = 150;
		DOT_FROST = 150;
		DMG_FIRE_BURST = 400;
		FLAME_JET_DMG = 200;
		FLAME_JET_DOT = 100;
		FREQ_ICE_BALL = Random(10.0, 20.0);
		GUARD_ELEMENT = "fire";
		ICE_GUARD_DOT_EFFECT = "effects/dot_fire";
		ATTACK_MOVERANGE_DEF = 200;
		FREQ_PROJECTILE = 3.0;
		CL_FX_SCRIPT = "monsters/elemental_fire_guardian_cl";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
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
