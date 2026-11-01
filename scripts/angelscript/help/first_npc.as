#pragma context server

namespace MS
{

class FirstNpc : CGameScript
{
	void game_targeted_by_player()
	{
		string TEXT = "You are looking at ";
		TEXT += GetMonsterProperty("name");
		TEXT += ".|To speak to him, change your text speech mode to|local [U] and say 'hello' or 'hail'";
		ShowHelpTip(param1, "help_speak", "Help Tip", TEXT);
	}

}

}
