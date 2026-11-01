#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerIce : CGameScript
{
	string ANIM_IDLE;
	int FX_GLOW;
	string FX_SCRIPT;
	string GLOW_COLOR;
	int MODEL_OFSET;
	int NO_FADE;
	float REMOVE_DELAY;
	int SHOW_FX;
	string SOUND_SPAWN;
	string SPAWNER_MODEL;
	int SPELL_MAKER_HEIGHT;

	SpellMakerIce()
	{
		FX_SCRIPT = "none";
		ANIM_IDLE = "iceblade_idle";
		SPAWNER_MODEL = "weapons/P_weapons1.mdl";
		MODEL_OFSET = 8;
		SOUND_SPAWN = "magic/ice_powerup.wav";
		SPELL_MAKER_HEIGHT = 32;
		REMOVE_DELAY = 5.0;
		SHOW_FX = 0;
		NO_FADE = 0;
		FX_GLOW = 1;
		GLOW_COLOR = Vector3(128, 128, 255);
		Precache(SOUND_SPAWN);
	}

}

}
