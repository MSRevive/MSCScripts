#pragma context server

#include "nashalrath/base_storm_brush.as"

namespace MS
{

class BrushStormLightning1 : CGameScript
{
	int BASE_RENDERAMT;
	int BASE_RENDERMODE;

	BrushStormLightning1()
	{
		SetName("brush_storm_lightning1");
		BASE_RENDERMODE = 5;
		BASE_RENDERAMT = 180;
	}

}

}
