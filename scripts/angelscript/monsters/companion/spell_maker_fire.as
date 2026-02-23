#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerFire : CGameScript
{
	SpellMakerFire()
	{
		const string FX_SCRIPT = "none";
		const string SPAWNER_MODEL = "weapons/projectiles.mdl";
		const int MODEL_OFSET = 50;
		const string SOUND_SPAWN = "scream/battlecry.wav";
		const string ANIM_IDLE = "stukabat_Hover";
		const float REMOVE_DELAY = 5.0;
		const int SHOW_FX = 0;
		const int NO_FADE = 0;
		const string SOUND_SPAWN = "scream/battlecry.wav";
	}

}

}
