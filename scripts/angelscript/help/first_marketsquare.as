#pragma context server

namespace MS
{

class FirstMarketsquare : CGameScript
{
	void game_targeted_by_player()
	{
		string TEXT = "You are looking at ";
		TEXT += GetMonsterProperty("name.full");
		TEXT += ".|You can pay him by pressing F11";
		ShowHelpTip(param1, "help_marketsq", "Merchant Square", TEXT);
	}

}

}
