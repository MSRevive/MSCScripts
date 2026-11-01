#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerAffliction : CGameScript
{
	string ANIM_IDLE;
	int FX_GLOW;
	string FX_SCRIPT;
	int GLOW_AMT;
	string GLOW_COLOR;
	int MODEL_OFSET;
	int NO_FADE;
	float REMOVE_DELAY;
	int SHOW_FX;
	string SOUND_SPAWN;
	string SPAWNER_MODEL;
	int SPELL_MAKER_HEIGHT;

	SpellMakerAffliction()
	{
		FX_SCRIPT = "none";
		ANIM_IDLE = "idle_standard";
		SPAWNER_MODEL = "weapons/projectiles.mdl";
		MODEL_OFSET = 8;
		SOUND_SPAWN = "x/x_laugh1.wav";
		REMOVE_DELAY = 5.0;
		SHOW_FX = 0;
		NO_FADE = 0;
		SPELL_MAKER_HEIGHT = 72;
		FX_GLOW = 1;
		GLOW_COLOR = Vector3(0, 255, 0);
		GLOW_AMT = 255;
	}

}

}
