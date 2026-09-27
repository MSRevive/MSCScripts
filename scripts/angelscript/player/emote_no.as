#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EmoteNo : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string TEXT_NOD;
	string game.effect.displayname;
	int game.effect.removeondeath;
	int local.idling;
	string local.noding;

	EmoteNo()
	{
		EFFECT_ID = "player_nodno";
		EFFECT_FLAGS = "player_action";
		EFFECT_SCRIPT = currentscript;
		game.effect.removeondeath = 0;
		TEXT_NOD = #ACTION_NOD_NO;
		game.effect.displayname = TEXT_NOD;
		local.idling = 0;
	}

	void game_player_activate()
	{
		if (!(local.idling))
		{
			CallExternal(GetOwner(), "emote_stop");
			PlayAnim("once", "nod_no");
			local.noding = 1;
		}
		else
		{
			idle_stop();
		}
	}

	void idle_stop()
	{
		PlayAnim("once", "break");
		local.noding = 0;
	}

	void game_animate()
	{
		if (!(local.noding)) return;
		if (!("game.player.speed")) return;
		idle_stop();
	}

	void emote_stop()
	{
		idle_stop();
	}

}

}
