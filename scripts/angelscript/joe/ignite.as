#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Ignite : CGameScript
{
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetName("Fuse");
		SetModel("misc/item_log.mdl");
		SetInvincible(false);
		SetNoPush(true);
		SetHealth(99999);
		SetDamageResistance("all", 0.01);
		SetDamageResistance("fire", 1.0);
		SetDamageResistance("cold", 0);
		SetDamageResistance("blunt", 0);
		SetDamageResistance("pierce", 0);
		SetDamageResistance("slash", 0);
		SetDamageResistance("dark", 0);
		SetDamageResistance("generic", 0);
		SetRace("beloved");
		PLAYING_DEAD = 1;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SetWidth(24);
		SetHeight(12);
		SetAlive(1);
		SetMenuAutoOpen(1);
	}

	void itemtaken()
	{
		UseTrigger("ignite");
		DeleteEntity(GetOwner());
	}

	void game_menu_getoptions()
	{
		if ((ItemExists(param1, "item_torch")))
		{
			string reg.mitem.id = "takeitem";
			string reg.mitem.title = "Lite with torch";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_torch";
			string reg.mitem.callback = "itemtaken";
		}
		else
		{
			SendColoredMessage(m_hLastUsed, "Nothing to lite fuse with.");
		}
	}

	void OnDamage(int damage) override
	{
		SetHealth(99999);
		if (!((param3).findFirst("fire") >= 0)) return;
		itemtaken();
	}

}

}
