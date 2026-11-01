#pragma context server

#include "items/base_book.as"

namespace MS
{

class ItemBookLatin : CGameScript
{
	string BOOK_PAGES;
	string BOOK_PAGES_SRC;
	string BOOK_TITLE;

	ItemBookLatin()
	{
		BOOK_TITLE = "Some latin crap or something";
		BOOK_PAGES = "#LOCALPAGE_TEST1;latin;latin2;latin3";
		BOOK_PAGES_SRC = "local;file;file;file";
	}

	void book_spawn()
	{
		SetName("Latin Book");
		SetDescription("What the hell does this even say?");
		SetValue(500);
	}

}

}
