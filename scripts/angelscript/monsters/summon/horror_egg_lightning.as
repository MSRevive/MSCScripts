#pragma context server

#include "monsters/summon/horror_egg.as"

namespace MS
{

class HorrorEggLightning : CGameScript
{
	HorrorEggLightning()
	{
		const string EGG_SCRIPT = "monsters/horror_lightning";
		const Vector3 GLOW_SHELL = Vector3(255, 255, 0);
	}

}

}
