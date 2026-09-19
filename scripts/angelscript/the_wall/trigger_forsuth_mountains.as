#pragma context server

namespace MS
{

class TriggerForsuthMountains : CGameScript
{
	TriggerForsuthMountains()
	{
		SetCallback("touch", "enable");
	}

	void OnTouch(CBaseEntity@ other) override
	{
		string FROSTY_ID = FindEntityByName("forsuth_frosty");
		LogDebug("forsuth_trigger FROSTY_ID vs PARAM1");
		if (!(GetEntityIndex(param1) == FindEntityByName("forsuth_frosty"))) return;
		LogDebug("forsuth_trigger Go frosty!");
		CallExternal(param1, "ext_mountain_comment");
		DeleteEntity(GetOwner());
	}

}

}
