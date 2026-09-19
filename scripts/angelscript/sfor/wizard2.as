#pragma context server

#include "sfor/wizard_base.as"

namespace MS
{

class Wizard2 : CGameScript
{
	string SAYTEXT_GOT_SYMBOL;
	string SYMB_ITEM;
	string SYMB_ITEM_NAME;
	string SYM_QUEST_NAME;

	Wizard2()
	{
		SetName("Brother Duae");
		SetName("wizard2");
		SYMB_ITEM = "item_s2";
		SYMB_ITEM_NAME = "the second symbol";
		SAYTEXT_GOT_SYMBOL = "Thank you, there may yet be hope to end this.";
		SYM_QUEST_NAME = "sym2";
	}

}

}
