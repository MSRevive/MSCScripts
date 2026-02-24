#pragma context server

#include "monsters/summon/circle_of_ice_lesser.as"

namespace MS
{

class CircleOfIcePlayer : CGameScript
{
	string APPLY_EFFECT;
	int CIRCLE_RADIUS;
	string FX_SPRITE;
	int NO_RAIN_FX;
	float PULSE_PLAYTIME;
	string SEAL_MODEL;
	int SEAL_OFS;
	string SOUND_FADE;
	string SOUND_MANIFEST;
	string SOUND_PULSE;

	CircleOfIcePlayer()
	{
		SEAL_MODEL = "weapons/magic/seals.mdl";
		SEAL_OFS = 7;
		SOUND_MANIFEST = "magic/spawn.wav";
		SOUND_PULSE = "magic/frost_forward.wav";
		SOUND_FADE = "magic/frost_reverse.wav";
		PULSE_PLAYTIME = 1.0;
		FX_SPRITE = "glassgibs.mdl";
		CIRCLE_RADIUS = 110;
		NO_RAIN_FX = 1;
		APPLY_EFFECT = "effects/dot_cold";
	}

}

}
