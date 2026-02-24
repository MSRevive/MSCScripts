#pragma context server

#include "sfor/wizard_base.as"

namespace MS
{

class Wizard3 : CGameScript
{
	string SAYTEXT_GOT_SYMBOL;
	string SYMB_ITEM;
	string SYMB_ITEM_NAME;
	string SYM_QUEST_NAME;

	Wizard3()
	{
		SetName("Brother Tress");
		SetName("wizard3");
		SYMB_ITEM = "item_s3";
		SYMB_ITEM_NAME = "the third symbol";
		SAYTEXT_GOT_SYMBOL = "Remember, it will take the last of our energies to cast this spell, when the dark one comes we will not be here to assist you.";
		SYM_QUEST_NAME = "sym3";
	}

}

}
