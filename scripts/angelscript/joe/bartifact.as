#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Bartifact : CGameScript
{
	int THE_PLAYER;

	void OnSpawn() override
	{
		SetHealth(1000);
		SetName("A Bloodshrine Artifact");
		SetWidth(12);
		SetHeight(6);
		SetRace("beloved");
		SetModel("misc/bartifact.mdl");
		SetInvincible(true);
		SetAlive(0);
		SetAngles("face");
		SetMenuAutoOpen(1);
		THE_PLAYER = 0;
	}

	void itemtook()
	{
		THE_PLAYER = param1;
		UseTrigger("door_event");
		DeleteEntity(GetOwner());
	}

	void game_menu_getoptions()
	{
		string reg.mitem.id = "takeitem";
		string reg.mitem.title = "Remove the stone";
		string reg.mitem.callback = "itemtook";
	}

}

}
