#pragma context server

namespace MS
{

class GlowUnblock : CGameScript
{
	GlowUnblock()
	{
		SetCallback("touch", "enable");
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if ((GetEntityProperty(param1, "scriptvar")))
		{
			CallExternal(param1, "ext_glow_block", 0);
		}
	}

}

}
