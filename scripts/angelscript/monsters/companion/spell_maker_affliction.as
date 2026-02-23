#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerAffliction : CGameScript
{
	string ANIM_IDLE;

	SpellMakerAffliction()
	{
		const string FX_SCRIPT = "none";
		ANIM_IDLE = "idle_standard";
		const string SPAWNER_MODEL = "weapons/projectiles.mdl";
		const int MODEL_OFSET = 8;
		const string SOUND_SPAWN = "x/x_laugh1.wav";
		const float REMOVE_DELAY = 5.0;
		const int SHOW_FX = 0;
		const int NO_FADE = 0;
		const int SPELL_MAKER_HEIGHT = 72;
		const int FX_GLOW = 1;
		const Vector3 GLOW_COLOR = Vector3(0, 255, 0);
		const int GLOW_AMT = 255;
	}

}

}
