#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class KeyChest : CGameScript
{
	string ANIM_CLOSE;
	string ANIM_IDLE;
	string ANIM_OPEN;

	KeyChest()
	{
		ANIM_OPEN = "seq-name";
		ANIM_CLOSE = "seq-name";
		ANIM_IDLE = "seq-name";
	}

	void OnSpawn() override
	{
		SetName("Old Dresser");
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
		add_gold(RandomInt(13, 26));
		AddStoreItem(STORENAME, "health_mpotion", 1, 0);
		AddStoreItem(STORENAME, "key_red", 1, 0);
	}

}

}
