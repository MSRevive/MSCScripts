#pragma context server

namespace MS
{

class TriggerAvghp : CGameScript
{
	TriggerAvghp()
	{
		SetCallback("touch", "enable");
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(IsValidPlayer(param1))) return;
		string HP_MIN = GetToken(param2, 0, ";");
		string HP_MAX = GetToken(param2, 1, ";");
		string HP_PRESENT = "game.players.totalhp";
		HP_PRESENT /= GetPlayerCount();
		LogDebug("HP_PRESENT vs HP_MIN to HP_MAX");
		if ((G_DEVELOPER_MODE))
		{
			SendInfoMessageToAll("green " + HP_PRESENT + "vs " + HP_MIN + "- " + HP_MAX);
		}
		if (HP_PRESENT >= HP_MIN)
		{
			if (HP_PRESENT <= HP_MAX)
			{
			}
			int DO_TRIGGER = 1;
		}
		if ((DO_TRIGGER))
		{
			UseTrigger(param3);
		}
		SetCallback("touch", "disable");
		RemoveScript();
		DeleteEntity(GetOwner());
	}

}

}
