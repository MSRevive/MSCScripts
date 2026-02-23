#pragma context server

#include "idemarks_tower/base_book.as"

namespace MS
{

class BookFelewyn : CGameScript
{
	void OnSpawn() override
	{
		SetName("Felewyn 15:12");
		add_page("We are to chose apostles: mortal beings who will defend and enforce our ideals on the mortal plane.");
		add_page("Lanethan is his name, though that was also not his birth name, and he is the Dark Knight Aginor.");
		add_page("So shall he be known, as apostle of Felewyn, who shall enforce Order and peace.");
		add_page("Idemark I have chosen to represent my order, the most powerful of the apostles of good.");
		add_page("Her sister, Iquitas, I have chosen to represent my chaos, the most powerful of the apostles of evil.");
		add_page("So shall they be, apostles of Pathos, two sides of the same coin - the coin of balance.");
	}

}

}
