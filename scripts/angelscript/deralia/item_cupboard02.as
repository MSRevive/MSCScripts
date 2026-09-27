#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ItemCupboard02 : CGameScript
{
	string ANIM_CLOSE;
	string ANIM_IDLE;
	string ANIM_OPEN;

	ItemCupboard02()
	{
		ANIM_OPEN = "seq-name";
		ANIM_CLOSE = "seq-name";
		ANIM_IDLE = "seq-name";
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
		AddStoreItem("cupboard01", "axes_axe", 1, 0);
		AddStoreItem("cupboard01", "swords_longsword", 1, 0);
	}

}

}
