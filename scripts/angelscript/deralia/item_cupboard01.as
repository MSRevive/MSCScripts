#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ItemCupboard01 : CGameScript
{
	ItemCupboard01()
	{
		const string ANIM_OPEN = "seq-name";
		const string ANIM_CLOSE = "seq-name";
		const string ANIM_IDLE = "seq-name";
	}

	void OnSpawn() override
	{
		SetName("Cupboard");
		SetModel("props/Xen_furniture2.mdl");
		SetIdleAnim(ANIM_IDLE);
	}

	void trade_success()
	{
		// PlayRandomSound from: "items/creak.wav"
		array<string> sounds = {"items/creak.wav"};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void chest_additems()
	{
		add_gold(RandomInt(3, 6));
		AddStoreItem(STORENAME, "health_mpotion", 1, 0);
		AddStoreItem(STORENAME, "axes_axe", 1, 0);
		AddStoreItem(STORENAME, "swords_longsword", 1, 0);
	}

}

}
