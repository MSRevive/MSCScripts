#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class BaseBook : CGameScript
{
	int CUR_PAGE;
	string MAX_PAGE;
	string MODEL_HOLD;
	string MODEL_WORLD;

	BaseBook()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HOLD = "misc/p_misc.mdl";
	}

	void OnSpawn() override
	{
		SetWeight(1);
		SetSize(2);
		SetWorldModel(MODEL_WORLD);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "book");
		book_spawn();
	}

	void OnDeploy() override
	{
		SetViewModel("none");
		SetModel(MODEL_HOLD);
		int L_SUBMODEL = 15;
		L_SUBMODEL += "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		MAX_PAGE = GetTokenCount(BOOK_PAGES, ";");
		MAX_PAGE -= 1;
		CUR_PAGE = 0;
	}

	void game_fall()
	{
		SetModel(MODEL_WORLD);
		SetModelBody(0, 17);
		PlayAnim("once", "package_floor_idle");
	}

	void game_attack1()
	{
		if (!(false)) return;
		read_book();
	}

	void read_book()
	{
		CUR_PAGE = 0;
		turn_page();
	}

	void turn_page()
	{
		// TODO: localmenu.reset
		string DISP_PAGE = CUR_PAGE;
		DISP_PAGE += 1;
		string DISP_MAX = MAX_PAGE;
		DISP_MAX += 1;
		string DISP_TITLE = BOOK_TITLE;
		DISP_TITLE += ", Page ";
		DISP_TITLE += int(DISP_PAGE);
		DISP_TITLE += "/";
		DISP_TITLE += int(DISP_MAX);
		string reg.local.menu.title = DISP_TITLE;
		// TODO: registerlocal.menu
		if (CUR_PAGE > MAX_PAGE)
		{
			CUR_PAGE = MAX_PAGE;
		}
		if (CUR_PAGE < 0)
		{
			CUR_PAGE = 0;
		}
		string reg.local.paragraph.source.type = GetToken(BOOK_PAGES_SRC, CUR_PAGE, ";");
		string reg.local.paragraph.source = "";
		if (reg.local.paragraph.source.type == "file")
		{
			reg.local.paragraph.source += "books/";
		}
		reg.local.paragraph.source += GetToken(BOOK_PAGES, CUR_PAGE, ";");
		// TODO: registerlocal.paragraph
		int ENABLE_PREV = 1;
		if (CUR_PAGE == 0)
		{
			int ENABLE_PREV = 0;
		}
		int ENABLE_NEXT = 1;
		if (CUR_PAGE == MAX_PAGE)
		{
			int ENABLE_NEXT = 0;
		}
		string reg.local.button.text = "Previous";
		int reg.local.button.closeonclick = 0;
		string reg.local.button.enabled = ENABLE_PREV;
		int reg.local.button.docallback = 1;
		string reg.local.button.callback = "prev_page";
		// TODO: registerlocal.button
		string reg.local.button.text = "Next";
		int reg.local.button.closeonclick = 0;
		string reg.local.button.enabled = ENABLE_NEXT;
		int reg.local.button.docallback = 1;
		string reg.local.button.callback = "next_page";
		// TODO: registerlocal.button
		// TODO: localmenu.open
	}

	void next_page()
	{
		CUR_PAGE += 1;
		turn_page();
	}

	void prev_page()
	{
		CUR_PAGE -= 1;
		turn_page();
	}

	void game_removefromowner()
	{
		CancelAttack();
		if (!(false)) return;
		// TODO: localmenu.close
	}

}

}
