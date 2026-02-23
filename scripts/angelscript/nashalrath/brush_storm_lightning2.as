#pragma context server

#include "nashalrath/base_storm_brush.as"

namespace MS
{

class BrushStormLightning2 : CGameScript
{
	BrushStormLightning2()
	{
		SetName("brush_storm_lightning2");
		const int BASE_RENDERMODE = 5;
		const int BASE_RENDERAMT = 255;
	}

	void do_flicker()
	{
		storm_show();
		Random(0_1, 0_5)("callevent", "storm_hide");
	}

}

}
