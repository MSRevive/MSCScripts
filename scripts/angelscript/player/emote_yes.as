#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EmoteYes : CGameScript
{
	string game.effect.displayname;
	int local.idling;
	string local.noding;

	EmoteYes()
	{
		const string EFFECT_ID = "player_nodyes";
		const string EFFECT_FLAGS = "player_action";
		const string EFFECT_SCRIPT = currentscript;
		const int game.effect.removeondeath = 0;
		const string TEXT_NOD = #ACTION_NOD_YES;
		game.effect.displayname = TEXT_NOD;
		local.idling = 0;
	}

	void game_player_activate()
	{
		if (!(local.idling))
		{
			CallExternal(GetOwner(), "emote_stop");
			PlayAnim("once", "nod_yes");
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
