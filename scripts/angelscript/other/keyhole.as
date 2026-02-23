#pragma context server

namespace MS
{

class Keyhole : CGameScript
{
	int KEY_USED;

	void OnSpawn() override
	{
		SetName("keyhole");
		SetWidth(2);
		SetHeight(16);
		SetRoam(false);
		SetModel("misc/keyhole.mdl");
		SetInvincible(2);
		KEY_USED = 0;
		SetFly(true);
		1 = float(1);
		SetMenuAutoOpen(1);
	}

	void rusty_use_the_key()
	{
		ReceiveOffer("accept");
		UseTrigger("item_key_rusty");
	}

	void storage_use_the_key()
	{
		ReceiveOffer("accept");
		UseTrigger("item_storageroomkey");
	}

	void game_menu_getoptions()
	{
		if ((ItemExists(param1, "item_key_rusty")))
		{
			string reg.mitem.title = "Use the rusty key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_key_rusty";
			string reg.mitem.callback = "rusty_use_the_key";
		}
	}

	void game_menu_getoptions()
	{
		if ((ItemExists(param1, "item_storageroomkey")))
		{
			string reg.mitem.title = "Use the storage key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_storageroomkey";
			string reg.mitem.callback = "storage_use_the_key";
		}
		if ((ItemExists(param1, "key_red")))
		{
			string reg.mitem.title = "Use the crimson key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "key_red";
			string reg.mitem.callback = "key_red";
		}
		if ((ItemExists(param1, "key_blue")))
		{
			string reg.mitem.title = "Use the sapphire key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "key_blue";
			string reg.mitem.callback = "key_blue";
		}
		if ((ItemExists(param1, "key_green")))
		{
			string reg.mitem.title = "Use the emerald key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "key_green";
			string reg.mitem.callback = "key_green";
		}
		if ((ItemExists(param1, "key_skeleton")))
		{
			string reg.mitem.title = "Use the skeleton key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "key_skeleton";
			string reg.mitem.callback = "key_skeleton";
		}
		if ((ItemExists(param1, "key_brass")))
		{
			string reg.mitem.title = "Use the brass key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "key_brass";
			string reg.mitem.callback = "key_brass";
		}
		if ((ItemExists(param1, "key_gold")))
		{
			string reg.mitem.title = "Use the gold key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "key_gold";
			string reg.mitem.callback = "key_gold";
		}
		if ((ItemExists(param1, "key_treasury")))
		{
			string reg.mitem.title = "Use the treasury key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "key_treasury";
			string reg.mitem.callback = "key_treasury";
		}
		if ((ItemExists(param1, "key_forged")))
		{
			string reg.mitem.title = "Use the forged key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "key_forged";
			string reg.mitem.callback = "key_forged";
		}
		if ((ItemExists(param1, "key_ice")))
		{
			string reg.mitem.title = "Use the ice key";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "key_ice";
			string reg.mitem.callback = "key_ice";
		}
	}

	void key_red()
	{
		ReceiveOffer("accept");
		UseTrigger("key_red");
	}

	void key_blue()
	{
		ReceiveOffer("accept");
		UseTrigger("key_blue");
	}

	void key_green()
	{
		ReceiveOffer("accept");
		UseTrigger("key_green");
	}

	void key_skeleton()
	{
		ReceiveOffer("accept");
		UseTrigger("key_skeleton");
	}

	void key_brass()
	{
		ReceiveOffer("accept");
		UseTrigger("key_brass");
	}

	void key_gold()
	{
		ReceiveOffer("accept");
		UseTrigger("key_gold");
	}

	void key_treasury()
	{
		ReceiveOffer("accept");
		UseTrigger("key_treasury");
	}

	void key_forged()
	{
		ReceiveOffer("accept");
		UseTrigger("key_forged");
	}

	void key_ice()
	{
		ReceiveOffer("accept");
		UseTrigger("key_forged");
	}

}

}
