#pragma context server

#include "effects/base_debuff_diminishing.as"

namespace MS
{

class DebuffStun : CGameScript
{
	string BE_RESIST_STRING;
	string CL_FX;
	string DEBUFF_SCRIPTFLAG;
	string DOT_ATTACKER;
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string SOUND_RESIST;
	string STUN_RESISTANCE;
	float game.effect.anim.framerate;
	int game.effect.canattack;
	int game.effect.canjump;
	int game.effect.movespeed;

	DebuffStun()
	{
		EFFECT_ID = "debuff_stun";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
		SOUND_RESIST = "body/armour3.wav";
	}

	void game_precache()
	{
		Precache("effects/sfx_stunring");
	}

	void game_activate()
	{
		DOT_ATTACKER = param2;
		STUN_RESISTANCE = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun");
		check_immune_stun();
		if ((DEBUFF_SCRIPTFLAG)) return;
		check_block_stun();
		if ((DEBUFF_SCRIPTFLAG)) return;
		check_resist_stun();
	}

	void debuff_start()
	{
		game.effect.movespeed = 45;
		game.effect.anim.framerate = 0.4;
		game.effect.canjump = 0;
		game.effect.canattack = 0;
		if ((IsValidPlayer(GetOwner())))
		{
			// TODO: hud.addstatusicon ent_me hud/status/alpha_stun stun EFFECT_DURATION
		}
		ClientEvent("new", "all", "effects/sfx_stunring", GetEntityIndex(GetOwner()), EFFECT_DURATION, GetEntityHeight(GetOwner()));
		CL_FX = "game.script.last_sent_id";
	}

	void check_immune_stun()
	{
		if (STUN_RESISTANCE <= 0)
		{
			SendColoredMessage(GetOwner(), "You are immune to stun effects.");
			SendColoredMessage(DOT_ATTACKER, GetEntityName(GetOwner()) + " is immune to stun effects.");
			DEBUFF_SCRIPTFLAG = 1;
			return;
			RemoveScript();
		}
		if ((GetEntityProperty(GetOwner(), "nopush")))
		{
			SendColoredMessage(GetOwner(), "You are immune to stun effects.");
			SendColoredMessage(DOT_ATTACKER, GetEntityName(GetOwner()) + " is immune to stun effects.");
			DEBUFF_SCRIPTFLAG = 1;
			return;
			RemoveScript();
		}
	}

	void check_block_stun()
	{
		if ((IsValidPlayer(GetOwner())))
		{
			string CUR_WEAPON = GetEntityProperty(GetOwner(), "scriptvar");
			if (GetEntityProperty(CUR_WEAPON, "scriptvar") == 1)
			{
				int BLOCKED_ATTACK = 1;
			}
			if (GetEntityProperty(CUR_WEAPON, "scriptvar") == 1)
			{
				int BLOCKED_ATTACK = 1;
			}
			if ((BLOCKED_ATTACK))
			{
				SendPlayerMessage(GetOwner(), GetEntityName(CUR_WEAPON) + " blocked stun impact.");
				DEBUFF_SCRIPTFLAG = 1;
				return;
				RemoveScript();
			}
			string CUR_WEAPON = GetEntityProperty(GetOwner(), "scriptvar");
			if (GetEntityProperty(CUR_WEAPON, "scriptvar") == 1)
			{
				int BLOCKED_ATTACK = 1;
			}
			if (GetEntityProperty(CUR_WEAPON, "scriptvar") == 1)
			{
				int BLOCKED_ATTACK = 1;
			}
			if ((BLOCKED_ATTACK))
			{
				SendPlayerMessage(GetOwner(), GetEntityName(CUR_WEAPON) + " blocked the stun impact.");
				DEBUFF_SCRIPTFLAG = 1;
				return;
				RemoveScript();
			}
		}
	}

	void check_resist_stun()
	{
		int STUN_ROLL = RandomInt(1, 100);
		string L_STUN_RESIST_PERCENT = (STUN_RESISTANCE * 100);
		int L_STUN_RESIST_PERCENT = int((100 - L_STUN_RESIST_PERCENT));
		if (STUN_ROLL <= L_STUN_RESIST_PERCENT)
		{
			EmitSound(GetOwner(), 0, SOUND_RESIST, 10);
			BE_RESIST_STRING = "( ";
			SendColoredMessage(GetOwner(), "You resist being stunned! " + BE_RESIST_STRING);
			SendColoredMessage(DOT_ATTACKER, GetEntityName(GetOwner()) + "resists the stun effect. " + BE_RESIST_STRING);
			DEBUFF_SCRIPTFLAG = 1;
			return;
			RemoveScript();
		}
		else
		{
			SendPlayerMessage(GetOwner(), "You have been stunned! STUN_ROLL / L_STUN_RESIST_PERCENT");
		}
	}

	void effect_die()
	{
		if ((CL_FX))
		{
			ClientEvent("update", "all", CL_FX, "end_fx");
		}
	}

}

}
