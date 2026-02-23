#pragma context server

#include "monsters/summon/npc_poison_cloud.as"

namespace MS
{

class NpcSporeCloud : CGameScript
{
	NpcSporeCloud()
	{
		const string EFFECT_SCRIPT = "effects/poison_spore";
		const string CHECK_EFFECT = "DOT_gpoison";
	}

}

}
