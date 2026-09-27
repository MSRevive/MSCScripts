#pragma context server

#include "effects/dot_lightning	allowduplicate.as"

namespace MS
{

class DotLightningCage : CGameScript
{
	string CL_CAGE;
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string DOT_RESISTED;
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string MAX_HP;
	int game.effect.anim.framerate;
	int game.effect.canduck;
	int game.effect.canjump;
	int game.effect.movespeed;

	DotLightningCage()
	{
		EFFECT_ID = "dot_lightning_cage";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
		DOT_IM_AFFECTED = "You are held in a lightning field!";
		DOT_IM_RESIST = "You resist being held in a lightning field.";
		DOT_HE_IMMUNE = "is immune to lightning magic!";
	}

	void game_activate()
	{
		MAX_HP = param5;
		if (!(param5))
		{
			MAX_HP = 1500;
		}
	}

	void dot_check_canapply()
	{
		if (GetEntityHealth(GetOwner()) > MAX_HP)
		{
			SendPlayerMessage(DOT_ATTACKER, GetEntityName(GetOwner()) + " is too strong for a lightning field.");
			DOT_RESISTED = 1;
			RemoveScript();
			return;
		}
	}

	void dot_start()
	{
		game.effect.movespeed = 0;
		game.effect.canjump = 0;
		game.effect.canduck = 0;
		game.effect.anim.framerate = 0;
		SetScriptFlags(GetOwner(), "add", "light_cage", "nopush", 1, -1, "none");
		EmitSound(GetOwner(), 0, "magic/bolt_start.wav", 10);
		string L_POS = GetEntityOrigin(GetOwner());
		if (!(IsValidPlayer(GetOwner())))
		{
			L_POS += "z";
		}
		if ((CL_CAGE))
		{
			ClientEvent("update", "all", CL_CAGE, "effect_die");
		}
		ClientEvent("new", "all", "effects/sfx_lightning_cage", 60, L_POS);
		CL_CAGE = "game.script.last_sent_id";
	}

	void effect_die()
	{
		if ((DOT_RESISTED)) return;
		SendPlayerMessage(GetOwner(), "The lightning field dissipates.");
		SetScriptFlags(GetOwner(), "remove", "light_cage");
		SetScriptFlags(GetOwner(), "remove", DOT_FLAG_NAME);
		if ((CL_CAGE))
		{
			ClientEvent("update", "all", CL_CAGE, "end_fx");
		}
		EmitSound(GetOwner(), 0, "magic/energy1_loud.wav", 10);
	}

}

}
