#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class BanditBossChest : CGameScript
{
	void OnSpawn() override
	{
		EmitSound(GetOwner(), 0, "amb/quest1.wav", 10);
	}

	void chest_additems()
	{
		add_gold(RandomInt(100, 1000));
		add_great_item();
		add_great_item();
		add_epic_item();
		add_epic_item();
	}

}

}
