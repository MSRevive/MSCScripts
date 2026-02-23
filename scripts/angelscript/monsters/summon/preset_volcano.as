#pragma context server

#include "monsters/summon/summon_volcano.as"

namespace MS
{

class PresetVolcano : CGameScript
{
	PresetVolcano()
	{
		const string VOLCANO_EXT_EVENT = "ext_volcano_hit";
		const int AOE_DMG = 25;
		const int FIXED_VOLCANO = 1;
	}

}

}
