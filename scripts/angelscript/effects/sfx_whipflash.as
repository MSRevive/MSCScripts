#pragma context server

namespace MS
{

class SfxWhipflash : CGameScript
{
	int FX_ACTIVE;
	string game.cleffect.view_ofs.z;

	void client_activate()
	{
		LogDebug("** $currentscript PARAM1");
		game.cleffect.view_ofs.z = param1;
	}

	void change_height()
	{
		game.cleffect.view_ofs.z = param1;
	}

	void do_whip()
	{
	}

	void remove_fx()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

}

}
