#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class Webbed : CGameScript
{
	string CLFX_ID;
	int DID_COCOON;
	string EFFECT_DUPLICATED;
	string EFFECT_DURATION;
	string EFFECT_STARTED;
	string NEXT_DECAY;
	int WEBS_ATTACHED;
	int WEBS_TILL_COCOON;
	int WEB_DECAY_TIME;
	string game.effect.anim.framerate;
	int game.effect.canattack;
	int game.effect.canduck;
	string game.effect.canjump;
	string game.effect.canrun;
	string game.effect.movespeed;

	Webbed()
	{
		const string EFFECT_ID = "webbed";
		const string EFFECT_SCRIPT = currentscript;
		const int PLAYER_WEB_TILL_COCOON = 10;
		const int WEB_FOR_SIZE = 17;
		WEBS_ATTACHED = 0;
		WEBS_TILL_COCOON = 0;
		WEB_DECAY_TIME = 0;
	}

	void game_activate()
	{
		string L_DECAY_TIME = param1;
		if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "spider_resist", "type_exists")))
		{
			SendPlayerMessage(param2, "GetEntityName(GetOwner()) is immune to webs!");
			EFFECT_DUPLICATED = 1;
			RemoveScript();
			return;
		}
		if (!(EFFECT_DUPLICATED))
		{
			set_cocoon_amt();
			game.effect.canjump = 0;
			game.effect.canrun = 0;
			SendPlayerMessage(GetOwner(), "You have been webbed!");
		}
		CallExternal(GetEntityIndex(GetOwner()), "ext_webbed", L_DECAY_TIME);
	}

	void set_cocoon_amt()
	{
		if ((IsValidPlayer(GetOwner())))
		{
			WEBS_TILL_COCOON = PLAYER_WEB_TILL_COCOON;
		}
		else
		{
			string L_MY_SIZE = GetEntityHeight(GetOwner());
			L_MY_SIZE += GetEntityWidth(GetOwner());
			L_MY_SIZE /= WEB_FOR_SIZE;
			WEBS_TILL_COCOON = int(L_MY_SIZE);
			// TODO: capvar WEBS_TILL_COCOON 2 20
		}
	}

	void ext_webbed()
	{
		if ((EFFECT_DUPLICATED)) return;
		if ((DID_COCOON)) return;
		if (param1 > WEB_DECAY_TIME)
		{
			WEB_DECAY_TIME = param1;
		}
		WEBS_ATTACHED += 1;
		if (WEBS_ATTACHED < WEBS_TILL_COCOON)
		{
			EFFECT_STARTED = GetGameTime();
			EFFECT_DURATION = /* TODO: $math(multiply) */ WEB_DECAY_TIME;
			NEXT_DECAY = /* TODO: $math(add) */ GetGameTime();
			WEB_DECAY_TIME("web_decay");
			web_update();
			EmitSound(GetOwner(), 0, "bullchicken/bc_acid2.wav", 10);
		}
		else
		{
			start_cocoon();
		}
		if (!(CLFX_ID))
		{
			ClientEvent("new", "all", "effects/sfx_webbed", WEB_DECAY_TIME, GetEntityIndex(GetOwner()), WEBS_TILL_COCOON);
			CLFX_ID = "game.script.last_sent_id";
		}
		else
		{
			ClientEvent("update", "all", CLFX_ID, "ext_webbed", WEB_DECAY_TIME);
		}
	}

	void web_decay()
	{
		if ((DID_COCOON)) return;
		if (GetGameTime() >= NEXT_DECAY)
		{
			SendPlayerMessage(GetOwner(), "Some of the webs loosen.");
			WEBS_ATTACHED -= 1;
			NEXT_DECAY = /* TODO: $math(add) */ GetGameTime();
			WEB_DECAY_TIME("web_decay");
			web_update();
		}
	}

	void web_update()
	{
		string L_SPEED_FACTOR = /* TODO: $math(divide) */ WEBS_ATTACHED;
		string L_SPEED = /* TODO: $math(multiply) */ 50;
		game.effect.movespeed = /* TODO: $math(subtract) */ 100;
		game.effect.anim.framerate = /* TODO: $math(subtract) */ 1;
	}

	void start_cocoon()
	{
		DID_COCOON = 1;
		SendPlayerMessage(GetOwner(), "The sticky web envelopes you in a cocoon, rendering you immovable.");
		EmitSound(GetOwner(), 0, "debris/bustflesh1.wav", 10);
		SetScriptFlags(GetOwner(), "add", "cocooned", "nopush", 1, -1, "none");
		game.effect.canattack = 0;
		game.effect.canduck = 0;
		game.effect.movespeed = 0.001;
		game.effect.anim.framerate = 0.001;
		if (!(IsValidPlayer(GetOwner())))
		{
			CallExternal(GetOwner(), "freeze_solid_start", WEB_DECAY_TIME);
		}
		WEB_DECAY_TIME("end_cocoon");
	}

	void end_cocoon()
	{
		SetScriptFlags(GetOwner(), "remove", "cocooned");
		EmitSound(GetOwner(), 0, "debris/bustflesh1.wav", 10);
		RemoveScript();
	}

	void game_predeath()
	{
		game.effect.canattack = 1;
		game.effect.canduck = 1;
		game.effect.movespeed = 100;
		game.effect.anim.framerate = 1;
		CallExternal(GetOwner(), "freeze_solid_end", 1);
		end_cocoon();
	}

	void effect_die()
	{
		if ((EFFECT_DUPLICATED)) return;
		if ((IsValidPlayer(GetOwner())))
		{
			if (!(DID_COCOON))
			{
				SendPlayerMessage(GetOwner(), "The webs have fallen away.");
			}
			else
			{
				SendPlayerMessage(GetOwner(), "You struggle your way out of the cocoon.");
			}
		}
		if ((CLFX_ID))
		{
			ClientEvent("update", "all", CLFX_ID, "fx_die");
		}
	}

	void game_duplicated()
	{
		if (!(EFFECT_DUPLICATED))
		{
			EFFECT_DUPLICATED = 1;
			RemoveScript();
		}
	}

}

}
