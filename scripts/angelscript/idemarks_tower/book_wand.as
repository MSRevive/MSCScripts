#pragma context server

#include "idemarks_tower/base_book.as"

namespace MS
{

class BookWand : CGameScript
{
	void OnSpawn() override
	{
		SetName("The Way of the Wand");
		add_page("There is a power beneath magic, a very ancient one. It's called fate.");
		add_page("It has limitless power - magic, as we all know, has many limitations, but not fate.");
	}

}

}
