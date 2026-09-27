#pragma context server

#include "idemarks_tower/base_book.as"

namespace MS
{

class BookArmor : CGameScript
{
	void OnSpawn() override
	{
		SetName("Armor of the Dark Knight");
		add_page("When night is high / and hopes are naught");
		add_page("darkness saves / those men who fought,");
		string L_STR = "For even though he's / named Dark Knight";
		add_page(L_STR);
		add_page("Order is his cause, / he fights for light.");
	}

}

}
