#pragma context server

namespace MS
{

class GlowBlock : CGameScript
{
	GlowBlock()
	{
		SetCallback("touch", "enable");
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(GetEntityProperty(param1, "scriptvar")))
		{
			CallExternal(param1, "ext_glow_block", 1);
		}
		if ((GetEntityProperty(param1, "scriptvar")))
		{
			CallExternal("ext_glow_block", "1");
		}
	}

}

}
