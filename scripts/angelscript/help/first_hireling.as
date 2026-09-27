#pragma context server

namespace MS
{

class FirstHireling : CGameScript
{
	void game_targeted_by_player()
	{
		string TEXT = "You are looking at ";
		TEXT += GetMonsterProperty("name");
		TEXT += ".|You can hire him to protect you.|Press 'use' on him and press 'Hire for X gold'.";
		ShowHelpTip(param1, "help_hireling", "Hired Help", TEXT);
	}

}

}
