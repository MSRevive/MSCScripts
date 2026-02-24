#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerInvisible : CGameScript
{
	string ANIM_IDLE;
	int NO_FADE;
	float REMOVE_DELAY;
	int SHOW_FX;
	string SPAWNER_MODEL;

	SpellMakerInvisible()
	{
		ANIM_IDLE = "";
		SPAWNER_MODEL = "none";
		REMOVE_DELAY = 5.0;
		SHOW_FX = 0;
		NO_FADE = 1;
	}

}

}
