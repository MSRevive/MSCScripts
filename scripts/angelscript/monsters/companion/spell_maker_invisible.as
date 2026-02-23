#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerInvisible : CGameScript
{
	string ANIM_IDLE;

	SpellMakerInvisible()
	{
		ANIM_IDLE = "";
		const string SPAWNER_MODEL = "none";
		const float REMOVE_DELAY = 5.0;
		const int SHOW_FX = 0;
		const int NO_FADE = 1;
	}

}

}
