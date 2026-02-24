#pragma context server

namespace MS
{

class WallOfTextGuy : CGameScript
{
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetName("Wall of Text Guy");
		SetModel("npc/human1.mdl");
		SetRace("beloved");
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetWidth(32);
		SetHeight(96);
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		SetMenuAutoOpen(1);
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Show me Text1";
		string reg.mitem.type = "callback";
		string reg.mitem.data = "text1";
		string reg.mitem.callback = "do_text";
		string reg.mitem.title = "Show me Text2";
		string reg.mitem.type = "callback";
		string reg.mitem.data = "text2";
		string reg.mitem.callback = "do_text2";
	}

	void do_text2()
	{
		// TODO: localmenu.reset PARAM1
		string reg.local.menu.title = "Test title";
		// TODO: registerlocal.menu PARAM1
		string reg.local.button.text = "Button1";
		int reg.local.button.closeonclick = 0;
		int reg.local.button.enabled = 1;
		int reg.local.button.docallback = 1;
		string reg.local.button.callback = "CB_TEST1";
		// TODO: registerlocal.button PARAM1
		string reg.local.button.text = "Button2";
		int reg.local.button.closeonclick = 1;
		int reg.local.button.enabled = 0;
		int reg.local.button.docallback = 0;
		// TODO: registerlocal.button PARAM1
		string reg.local.button.text = "Button3";
		int reg.local.button.closeonclick = 1;
		int reg.local.button.enabled = 1;
		int reg.local.button.docallback = 0;
		string reg.local.button.callback = "CB_TEST2";
		// TODO: registerlocal.button PARAM1
		string reg.local.paragraph.source.type = "file";
		string reg.local.paragraph.source = "Credits_Original";
		// TODO: registerlocal.paragraph PARAM1
		// TODO: localmenu.open PARAM1
	}

	void do_text()
	{
		string PARAM_OUT = param2;
		PlayAnim("once", "give_shot");
		SayText("Take a look at wall of text: " + PARAM_OUT);
		ClientEvent("update", param1, "const.localplayer.scriptID", "cl_show_text", PARAM_OUT);
	}

	void CB_TEST1()
	{
		SayText(CB_TEST1 + param1);
		// TODO: localmenu.close PARAM1
	}

	void CB_TEST2()
	{
		SayText(CB_TEST2 + param1);
	}

}

}
