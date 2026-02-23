#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemGwond : CGameScript
{
	string NEXT_USE;
	int SCROLL_USED;

	ItemGwond()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Galat s Wondrous Scroll");
		SetDescription("This one time use scroll summons Galat s Wondrous Chest");
		SetHUDSprite("trade", "letter");
	}

	void OnDeploy() override
	{
		NEXT_USE = GetGameTime();
		NEXT_USE += 1.0;
	}

	void game_attack1()
	{
		if (!(GetGameTime() > NEXT_USE)) return;
		if ((SCROLL_USED)) return;
		SCROLL_USED = 1;
		summon_chest();
	}

	void summon_chest()
	{
		string OWNER_POS = GetEntityOrigin(GetOwner());
		string OWNER_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		string SPAWN_POS = OWNER_POS;
		SPAWN_POS += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, 64, 0));
		SpawnNPC("chests/bank1", SPAWN_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		DeleteEntity(GetOwner());
	}

}

}
