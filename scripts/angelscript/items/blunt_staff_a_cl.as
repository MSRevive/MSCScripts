#pragma context server

namespace MS
{

class BluntStaffACl : CGameScript
{
	int FX_ACTIVE;
	string FX_OWNER;
	string NEXT_SPARK;

	BluntStaffACl()
	{
		const float BEAM_WIDTH = 10.0;
		const float BEAM_AMP = 0.01;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		SetCallback("render", "enable");
		FX_ACTIVE = 1;
		fx_loop();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "fx_loop");
		if (GetGameTime() > NEXT_SPARK)
		{
			NEXT_SPARK = GetGameTime();
			NEXT_SPARK += Random(0.25, 1.0);
			string BEAM_START = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment2");
			string BEAM_END = /* TODO: $getcl */ $getcl(FX_OWNER, "center");
			BEAM_END += "z";
			string OWNER_VIEWANGS = /* TODO: $getcl */ $getcl(FX_OWNER, "viewangles");
			BEAM_END += /* TODO: $relpos */ $relpos(OWNER_VIEWANGS, Vector3(0, 1280, 0));
			string TRACE_LINE = TraceLine(BEAM_START, BEAM_END);
			if (TRACE_LINE != BEAM_END)
			{
			}
			ClientEffect("spark", TRACE_LINE);
			string RND_SPARK = RandomInt(1, 3);
			if (RND_SPARK == 1)
			{
				EmitSound3D("buttons/spark1.wav", 5, TRACE_LINE);
			}
			if (RND_SPARK == 2)
			{
				EmitSound3D("buttons/spark2.wav", 5, TRACE_LINE);
			}
			if (RND_SPARK == 3)
			{
				EmitSound3D("buttons/spark4.wav", 5, TRACE_LINE);
			}
		}
		if ("game.localplayer.index" == FX_OWNER)
		{
			if (!("game.localplayer.thirdperson"))
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		string BEAM_START = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment2");
		string BEAM_END = BEAM_START;
		string OWNER_VIEWANGS = /* TODO: $getcl */ $getcl(FX_OWNER, "viewangles");
		BEAM_END += /* TODO: $relpos */ $relpos(OWNER_VIEWANGS, Vector3(0, 1280, 0));
		ClientEffect("beam_end", FX_OWNER, 1, BEAM_END, "lgtning.spr", 0.25, BEAM_WIDTH, BEAM_AMP, 0.3, 0.1, 30, Vector3(2, 0, 0));
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
		if (!("game.localplayer.index" == FX_OWNER)) return;
		if (("game.localplayer.thirdperson")) return;
		string BEAM_START = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "attachment2");
		string BEAM_END = /* TODO: $getcl */ $getcl(FX_OWNER, "center");
		BEAM_END += "z";
		string OWNER_VIEWANGS = /* TODO: $getcl */ $getcl(FX_OWNER, "viewangles");
		BEAM_END += /* TODO: $relpos */ $relpos(OWNER_VIEWANGS, Vector3(0, 1280, 0));
		string TRACE_LINE = TraceLine(BEAM_START, BEAM_END);
		ClientEffect("beam_points", BEAM_START, TRACE_LINE, "lgtning.spr", 0.001, BEAM_WIDTH, BEAM_AMP, 0.3, 0.1, 30, Vector3(2, 0, 0));
		ClientEffect("frameent", "sprite", "3dmflaora.spr", BEAM_START, "setup_flare");
	}

	void setup_flare()
	{
		ClientEffect("frameent", "set_current_prop", "renderamt", 200);
		ClientEffect("frameent", "set_current_prop", "rendermode", "add");
		ClientEffect("frameent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("frameent", "set_current_prop", "scale", 0.25);
		ClientEffect("frameent", "set_current_prop", "frame", 0);
	}

}

}
