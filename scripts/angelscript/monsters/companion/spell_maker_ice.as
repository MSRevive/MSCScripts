#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerIce : CGameScript
{
	string ANIM_IDLE;

	SpellMakerIce()
	{
		const string FX_SCRIPT = "none";
		ANIM_IDLE = "iceblade_idle";
		const string SPAWNER_MODEL = "weapons/P_weapons1.mdl";
		const int MODEL_OFSET = 8;
		const string SOUND_SPAWN = "magic/ice_powerup.wav";
		const int SPELL_MAKER_HEIGHT = 32;
		const float REMOVE_DELAY = 5.0;
		const int SHOW_FX = 0;
		const int NO_FADE = 0;
		const int FX_GLOW = 1;
		const Vector3 GLOW_COLOR = Vector3(128, 128, 255);
		Precache(SOUND_SPAWN);
	}

}

}
