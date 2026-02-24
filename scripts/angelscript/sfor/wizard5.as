#pragma context server

#include "sfor/wizard_base.as"

namespace MS
{

class Wizard5 : CGameScript
{
	string SAYTEXT_GOT_SYMBOL;
	string SYMB_ITEM;
	string SYMB_ITEM_NAME;
	string SYM_QUEST_NAME;

	Wizard5()
	{
		SetName("Brother Quinas");
		SetName("wizard5");
		SYMB_ITEM = "item_s5";
		SYMB_ITEM_NAME = "the fifth symbol";
		SAYTEXT_GOT_SYMBOL = "It is good you arrived when you did, I've my doubts we could hold this gate shut much longer.";
		SYM_QUEST_NAME = "sym5";
	}

}

}
