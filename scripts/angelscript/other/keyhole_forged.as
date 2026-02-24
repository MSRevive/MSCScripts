#pragma context server

namespace MS
{

class KeyholeForged : CGameScript
{
	string KEYHOLE_TITLE;
	string KEY_NAME;

	KeyholeForged()
	{
		KEY_NAME = "key_forged";
		KEYHOLE_TITLE = "Use the forged key";
	}

	void OnSpawn() override
	{
		SetName("Ornate Keyhole");
		SetWidth(2);
		SetHeight(16);
		SetRoam(false);
		SetModel("props/skullprop.mdl");
		SetModelBody(0, 0);
		SetInvincible(2);
		SetFly(true);
		1 = float(1);
		SetMenuAutoOpen(1);
	}

	void game_menu_getoptions()
	{
		if ((ItemExists(param1, KEY_NAME)))
		{
			string reg.mitem.title = KEYHOLE_TITLE;
			string reg.mitem.type = "payment";
			string reg.mitem.data = KEY_NAME;
			string reg.mitem.callback = "key_used";
		}
	}

	void key_used()
	{
		ReceiveOffer("accept");
		SetModelBody(0, 1);
		UseTrigger(KEY_NAME);
	}

}

}
