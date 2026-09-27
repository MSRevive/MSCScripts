#pragma context server

namespace MS
{

class Web : CGameScript
{
	Web()
	{
		SetCallback("touch", "enable");
		SetProp(GetOwner(), "solid", 1);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(GetEntityRace(param1) != "spider")) return;
		UseTrigger("web_touched");
		SendPlayerMessage(param1, "You have been webbed!");
		EmitSound(GetOwner(), 0, "barnacle/bcl_chew2.wav", 10);
		ApplyEffect(param1, "effects/webbed", 10.0, GAME_MASTER);
		SetCallback("touch", "disable");
		RemoveScript();
	}

}

}
