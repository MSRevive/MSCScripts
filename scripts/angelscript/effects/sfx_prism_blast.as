#pragma context server

namespace MS
{

class SfxPrismBlast : CGameScript
{
	string BALL_COL_IDX;
	string BALL_ROT;
	string BALL_SPD;
	string CIRCLE_COUNT;
	string CIRCLE_COUNT_MAX;
	string CIRCLE_DIST_INC;
	string CIRCLE_RAD;
	int CIRCLE_ROT;
	string CUR_SIZE;
	int DO_LIGHT;
	string EFFECT_COLORS;
	string EFFECT_ELEMENTS;
	int FX_ACTIVE;
	string FX_AOE;
	string FX_COLOR;
	string FX_LIGHT_ID;
	string FX_LIGHT_RAD;
	string FX_ORIGIN;

	SfxPrismBlast()
	{
		EFFECT_ELEMENTS = "acid;fire;cold;poison;dark;lightning;holy";
		EFFECT_COLORS = "(64,255,64);(255,64,0);(128,128,255);(0,255,0);(255,0,255);(255,255,0);(255,255,255)";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		if ((FX_ACTIVE))
		{
		}
		if (CUR_SIZE <= 1)
		{
		}
		CUR_SIZE += 0.02;
		if (CUR_SIZE > 1)
		{
			CUR_SIZE = 1;
		}
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_AOE = param2;
		string L_COLOR = param3;
		FX_ACTIVE = 1;
		string L_IDX = FindToken(EFFECT_ELEMENTS, param3, ";");
		FX_COLOR = GetToken(EFFECT_COLORS, L_IDX, ";");
		DO_LIGHT = 1;
		if ((DO_LIGHT))
		{
			FX_LIGHT_RAD = (FX_AOE * 1.5);
			SetCallback("render", "enable");
			ClientEffect("light", "new", FX_ORIGIN, FX_LIGHT_RAD, FX_COLOR, 0.5);
			FX_LIGHT_ID = "game.script.last_light_id";
		}
		EmitSound3D("magic/dburst_large_sdr_darkness.wav", 10, FX_ORIGIN);
		if ((DO_SPRITES))
		{
			BALL_ROT = 0;
			BALL_COL_IDX = 0;
			BALL_SPD = 400;
			array<string> ARRAY_SPR_COLORS;
			array<string> ARRAY_SPR_POS;
			for (int i = 0; i < 17; i++)
			{
				setup_bawls();
			}
		}
		else
		{
			CIRCLE_RAD = 0;
			string L_N_CIRCLES = GetTokenCount(EFFECT_COLORS, ";");
			CIRCLE_DIST_INC = FX_AOE;
			CIRCLE_DIST_INC /= L_N_CIRCLES;
			CIRCLE_COUNT = 0;
			CIRCLE_COUNT_MAX = L_N_CIRCLES;
			do_circles();
		}
		ScheduleDelayedEvent(1.0, "end_fx");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		if (!(DO_LIGHT)) return;
		ClientEffect("light", FX_LIGHT_ID, FX_ORIGIN, /* TODO: $ratio */ $ratio(CUR_SIZE, 0, FX_LIGHT_RAD), FX_COLOR, 0.5);
	}

	void do_circles()
	{
		if (!(CIRCLE_COUNT < CIRCLE_COUNT_MAX)) return;
		ScheduleDelayedEvent(0.1, "do_circles");
		beam_circle();
		CIRCLE_COUNT += 1;
	}

	void beam_circle()
	{
		CIRCLE_RAD += CIRCLE_DIST_INC;
		CIRCLE_ROT = 0;
		for (int i = 0; i < 16; i++)
		{
			draw_circle_loop();
		}
	}

	void draw_circle_loop()
	{
		string L_BEAM_START = FX_ORIGIN;
		L_BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, CIRCLE_ROT, 0), Vector3(0, CIRCLE_RAD, 0));
		CIRCLE_ROT += 22.5;
		string L_BEAM_END = FX_ORIGIN;
		L_BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, CIRCLE_ROT, 0), Vector3(0, CIRCLE_RAD, 0));
		ClientEffect("beam_points", L_BEAM_START, L_BEAM_END, "3dmflagry.spr", 1.0, 10, 0.2, 1, 30, 30, /* TODO: $clcol */ $clcol(FX_COLOR));
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

}

}
