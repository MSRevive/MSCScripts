#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EmoteIdle : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string TEXT_IDLE;
	string TEXT_NORMAL;
	string game.effect.displayname;
	int game.effect.removeondeath;
	string game.effect.updateplayer;
	int local.idling;

	EmoteIdle()
	{
		EFFECT_ID = "player_standidle";
		EFFECT_FLAGS = "player_action";
		EFFECT_SCRIPT = currentscript;
		game.effect.removeondeath = 0;
		TEXT_IDLE = #ACTION_STAND_IDLE;
		TEXT_NORMAL = #ACTION_STAND_NORMAL;
		game.effect.displayname = TEXT_IDLE;
		local.idling = 0;
	}

	void game_player_activate()
	{
		if (!(local.idling))
		{
			CallExternal(GetOwner(), "emote_stop");
			PlayAnim("hold", "attention");
			local.idling = 1;
			game.effect.displayname = TEXT_NORMAL;
			game.effect.updateplayer = 1;
		}
		else
		{
			idle_stop();
		}
	}

	void idle_stop()
	{
		PlayAnim("once", "break");
		local.idling = 0;
		game.effect.displayname = TEXT_IDLE;
		game.effect.updateplayer = 1;
	}

	void game_animate()
	{
		if (!(local.idling)) return;
		if (!("game.player.speed")) return;
		idle_stop();
	}

	void emote_stop()
	{
		idle_stop();
	}

}

}
