#pragma context server

#include "monsters/summon/circle_of_ice_lesser.as"

namespace MS
{

class CircleOfIceSword : CGameScript
{
	CircleOfIceSword()
	{
		const string SEAL_MODEL = "weapons/magic/seals.mdl";
		const int SEAL_OFS = 7;
		const string SOUND_MANIFEST = "magic/spawn.wav";
		const string SOUND_PULSE = "magic/frost_forward.wav";
		const string SOUND_FADE = "magic/frost_reverse.wav";
		const float PULSE_PLAYTIME = 1.0;
		const string FX_SPRITE = "glassgibs.mdl";
		const int CIRCLE_RADIUS = 110;
		const int NO_RAIN_FX = 1;
		const string APPLY_EFFECT = "effects/dot_cold";
	}

}

}
