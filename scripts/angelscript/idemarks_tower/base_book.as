#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class BaseBook : CGameScript
{
	int CUR_PAGE;
	int NUM_PAGES;

	BaseBook()
	{
		const int CHAT_AUTO_HAIL = 0;
		const int CHAT_USE_CONV_ANIMS = 0;
		const int CHAT_FACE_ON_USE = 0;
		const int CHAT_AUTO_FACE = 0;
		const string CHAT_ARRAY_EVENT = "page";
		CUR_PAGE = 0;
		NUM_PAGES = 0;
	}

	void OnSpawn() override
	{
		SetMenuAutoOpen(1);
		SetInvincible(true);
		SetNoPush(true);
		SetModel("null.mdl");
		SetName("Your book name");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Read a Page";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "read_page";
	}

	void add_page()
	{
		chat_add_text(CHAT_ARRAY_EVENT, /* TODO: $pass */ $pass(param1), 0.1, "none", "none", "sound:magic/pageflip.wav");
		NUM_PAGES += 1;
	}

	void read_page()
	{
		if (!(CUR_PAGE))
		{
			chat_start_sequence(CHAT_ARRAY_EVENT);
			CUR_PAGE += 1;
		}
		else
		{
			chat_resume();
		}
		chat_pause();
		CUR_PAGE += 1;
		if (!(CUR_PAGE > NUM_PAGES)) return;
		CUR_PAGE = 0;
	}

}

}
