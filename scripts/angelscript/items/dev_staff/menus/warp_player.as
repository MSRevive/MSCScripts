#pragma context server

namespace MS
{

class WarpPlayer : CGameScript
{
	int TELEPORT_MODE;

	WarpPlayer()
	{
		array<string> A_PLAYERS;
		TELEPORT_MODE = 3;
	}

	void menu_tele_mode()
	{
		string reg.mitem.title = "Go to player";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_tele_mode";
		int reg.mitem.data = 0;
		string reg.mitem.title = "Bring player here";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_tele_mode";
		int reg.mitem.data = 1;
	}

	void set_tele_mode()
	{
		TELEPORT_MODE = param2;
		set_menu_type(0, 16);
	}

	void menu_tele_player()
	{
		GetAllPlayers(A_PLAYERS);
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(A_PLAYERS); i++)
		{
			add_player_to_menu();
		}
	}

	void add_player_to_menu()
	{
		string L_PLAYER = /* TODO: $get_array */ $get_array(A_PLAYERS, i);
		if (L_PLAYER != MY_OWNER)
		{
			string reg.mitem.title = GetEntityName(L_PLAYER);
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "teleport_player";
			string reg.mitem.data = L_PLAYER;
		}
	}

	void teleport_player()
	{
		if (TELEPORT_MODE == 0)
		{
			SetEntityOrigin(MY_OWNER, GetEntityOrigin(param2));
		}
		else
		{
			SetEntityOrigin(param2, GetEntityOrigin(MY_OWNER));
		}
	}

}

}
