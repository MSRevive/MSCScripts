#pragma context server

#include "monsters/summon/summon_volcano.as"

namespace MS
{

class PresetVolcano : CGameScript
{
	int AOE_DMG;
	int FIXED_VOLCANO;
	string VOLCANO_EXT_EVENT;

	PresetVolcano()
	{
		VOLCANO_EXT_EVENT = "ext_volcano_hit";
		AOE_DMG = 25;
		FIXED_VOLCANO = 1;
	}

}

}
