#pragma context server

namespace MS
{

class FirstVendor : CGameScript
{
	void game_targeted_by_player()
	{
		string TEXT = "You are looking at ";
		TEXT += GetMonsterProperty("name");
		TEXT += ".|He sells items.  You can press the use key|or speak to him to gain access to his wares.";
		ShowHelpTip(param1, "help_vendor", "Vendor", TEXT);
	}

	void help_vendor_magic()
	{
		string TEXT = "You are looking at ";
		TEXT += GetMonsterProperty("name");
		TEXT += ".|He sells Tomes and Scrolls.|In order to use magic you must read the Scroll or Tome.|Tomes can be permanently memorized and re-selected|press 2 to select a memorized spell.|Scrolls must be activated for each use, |but need no be memorized.|Currently, you may only memorize eight spells.";
		ShowHelpTip(param1, "help_scrolls", "Scroll merchant", TEXT);
	}

}

}
