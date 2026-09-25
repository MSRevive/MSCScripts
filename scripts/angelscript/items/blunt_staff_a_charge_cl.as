#pragma context server

namespace MS
{

class BluntStaffAChargeCl : CGameScript
{
	string CHARGE_COLOR;
	int CHARGE_LEVEL;
	int CUR_FRAME;
	int FX_ACTIVE;
	string FX_OWNER;
	int MAX_CHARGE;

	void client_activate()
	{
		LogDebug("cleyes_activate");
		MAX_CHARGE = 0;
		CHARGE_COLOR = Vector3(0, 255, 0);
		FX_OWNER = param1;
		FX_ACTIVE = 1;
		CHARGE_LEVEL = 1;
		CUR_FRAME = 0;
		SetCallback("render", "enable");
		add_charge_level();
		ScheduleDelayedEvent(20.0, "end_fx");
	}

	void add_charge_level()
	{
		if (!(FX_ACTIVE)) return;
		MAX_CHARGE = 0;
		CHARGE_LEVEL = param1;
		if (CHARGE_LEVEL == 1)
		{
			CHARGE_COLOR = Vector3(0, 255, 0);
		}
		if (CHARGE_LEVEL == 1.5)
		{
			MAX_CHARGE = 1;
		}
		if (CHARGE_LEVEL == 2)
		{
			CHARGE_COLOR = Vector3(255, 0, 0);
		}
		if (CHARGE_LEVEL == 2.5)
		{
			MAX_CHARGE = 1;
		}
		if (CHARGE_LEVEL == 3)
		{
			CHARGE_COLOR = Vector3(255, 255, 255);
		}
		if (CHARGE_LEVEL == 3.5)
		{
			MAX_CHARGE = 1;
		}
		if ((MAX_CHARGE))
		{
			if (!("game.localplayer.thirdperson"))
			{
			}
			ClientEffect("spark", /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "attachment2"));
			ClientEffect("spark", /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "attachment3"));
		}
		if ("game.localplayer.index" == FX_OWNER)
		{
			if (("game.localplayer.thirdperson"))
			{
			}
			string ANG_ADJ = /* TODO: $getcl */ $getcl(FX_OWNER, "viewangles");
			string ANG_ADJ = /* TODO: $vec.yaw */ $vec.yaw(ANG_ADJ);
			string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
			SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, 32, 32));
			ClientEffect("tempent", "sprite", "3dmflaora.spr", SPR_POS, "setup_thirdperson_flare");
		}
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		if (("game.localplayer.thirdperson")) return;
		CUR_FRAME += 1;
		if (CUR_FRAME > 15)
		{
			CUR_FRAME = 0;
		}
		if ((MAX_CHARGE))
		{
			string EYE_POS = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "attachment2");
			ClientEffect("frameent", "sprite", "3dmflaora.spr", EYE_POS, "setup_eye_max");
		}
		string EYE_POS = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "attachment2");
		ClientEffect("frameent", "sprite", "calflame_small.spr", EYE_POS, "setup_eye");
	}

	void setup_thirdperson_flare()
	{
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", CHARGE_COLOR);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "frame", 0);
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

	void setup_eye()
	{
		ClientEffect("frameent", "set_current_prop", "renderamt", 200);
		ClientEffect("frameent", "set_current_prop", "rendermode", "glow");
		ClientEffect("frameent", "set_current_prop", "rendercolor", CHARGE_COLOR);
		ClientEffect("frameent", "set_current_prop", "scale", 1.5);
		ClientEffect("frameent", "set_current_prop", "frame", CUR_FRAME);
	}

	void setup_eye_max()
	{
		ClientEffect("frameent", "set_current_prop", "renderamt", 200);
		ClientEffect("frameent", "set_current_prop", "rendermode", "glow");
		ClientEffect("frameent", "set_current_prop", "rendercolor", CHARGE_COLOR);
		ClientEffect("frameent", "set_current_prop", "scale", 1.5);
		ClientEffect("frameent", "set_current_prop", "frame", 0);
	}

}

}
