#pragma context server

namespace MS
{

class BaseKeyhole : CGameScript
{
	int RETURN_KEY;

	void OnSpawn() override
	{
		SetName(KEYHOLE_NAME);
		SetWidth(5);
		SetHeight(16);
		SetRoam(false);
		SetModel("misc/keyhole.mdl");
		SetInvincible(true);
		SetFly(true);
		1 = float(1);
		SetSolid("none");
		SetNoPush(true);
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
		UseTrigger(KEY_NAME);
		if ((RETURN_KEY))
		{
			// TODO: offer PARAM1 KEY_NAME
		}
	}

	void return_keys()
	{
		RETURN_KEY = 1;
	}

}

}
