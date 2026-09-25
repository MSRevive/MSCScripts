#pragma context server

#include "sfor/wizard_base.as"

namespace MS
{

class Wizard4 : CGameScript
{
	string SAYTEXT_GOT_SYMBOL;
	string SYMB_ITEM;
	string SYMB_ITEM_NAME;
	string SYM_QUEST_NAME;

	Wizard4()
	{
		SetName("Brother Quatra");
		SetName("wizard4");
		SYMB_ITEM = "item_s4";
		SYMB_ITEM_NAME = "the forth symbol";
		SAYTEXT_GOT_SYMBOL = "When the beast comes, aim for the horn atop his head.";
		SYM_QUEST_NAME = "sym4";
	}

}

}
