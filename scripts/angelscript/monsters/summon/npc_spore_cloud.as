#pragma context server

#include "monsters/summon/npc_poison_cloud.as"

namespace MS
{

class NpcSporeCloud : CGameScript
{
	string CHECK_EFFECT;
	string EFFECT_SCRIPT;

	NpcSporeCloud()
	{
		EFFECT_SCRIPT = "effects/poison_spore";
		CHECK_EFFECT = "DOT_gpoison";
	}

}

}
