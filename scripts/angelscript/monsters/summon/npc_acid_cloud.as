#pragma context server

#include "monsters/summon/npc_poison_cloud.as"

namespace MS
{

class NpcAcidCloud : CGameScript
{
	NpcAcidCloud()
	{
		const string AOE_SCAN_TYPE = "noscan";
		const Vector3 SPRITE_COLOR = Vector3(255, 8, 30);
	}

	void aoe_scan_loop()
	{
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 256, MY_BASE_DAMAGE, 0, MY_OWNER, MY_OWNER, "spellcasting.affliction", "acid");
	}

}

}
