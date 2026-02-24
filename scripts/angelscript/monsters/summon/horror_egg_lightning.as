#pragma context server

#include "monsters/summon/horror_egg.as"

namespace MS
{

class HorrorEggLightning : CGameScript
{
	string EGG_SCRIPT;
	string GLOW_SHELL;

	HorrorEggLightning()
	{
		EGG_SCRIPT = "monsters/horror_lightning";
		GLOW_SHELL = Vector3(255, 255, 0);
	}

}

}
