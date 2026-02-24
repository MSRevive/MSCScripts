#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerFire : CGameScript
{
	string ANIM_IDLE;
	string FX_SCRIPT;
	int MODEL_OFSET;
	int NO_FADE;
	float REMOVE_DELAY;
	int SHOW_FX;
	string SOUND_SPAWN;
	string SPAWNER_MODEL;

	SpellMakerFire()
	{
		FX_SCRIPT = "none";
		SPAWNER_MODEL = "weapons/projectiles.mdl";
		MODEL_OFSET = 50;
		SOUND_SPAWN = "scream/battlecry.wav";
		ANIM_IDLE = "stukabat_Hover";
		REMOVE_DELAY = 5.0;
		SHOW_FX = 0;
		NO_FADE = 0;
		SOUND_SPAWN = "scream/battlecry.wav";
	}

}

}
