#pragma context server

#include "effects/base_effect.as"

namespace MS
{

class Iceshield : CGameScript
{
	string DAMAGE_MULTIPLIER;
	string EFFECT_DURATION;
	string LAST_SHIELDER;

	Iceshield()
	{
		const string EFFECT_ID = "iceshield";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		LAST_SHIELDER = param2;
		DAMAGE_MULTIPLIER = param3;
		shield_me_baby();
		SendColoredMessage(GetOwner(), "You are protected by a shield of ice.");
		SendColoredMessage(GetOwner(), "Ice shield int(EFFECT_DURATION) seconds remain.");
		if (LAST_SHIELDER != GetEntityIndex(GetOwner()))
		{
			SendColoredMessage(LAST_SHIELDER, "You shield GetEntityName(GetOwner()) for EFFECT_DURATION seconds.");
		}
		check_do_bonus(EFFECT_DURATION);
	}

	void ext_refresh_ice_shield()
	{
		if (param1 > EFFECT_DURATION)
		{
			EFFECT_DURATION = param1;
		}
		LAST_SHIELDER = param2;
		effect_get_timeleft();
		string L_TIME_DIFF = /* TODO: $math(subtract) */ EFFECT_DURATION;
		effect_set_duration(EFFECT_DURATION);
		shield_me_baby();
		if (LAST_SHIELDER != GetEntityIndex(GetOwner()))
		{
			if ((IsValidPlayer(GetOwner())))
			{
				SendColoredMessage(GetOwner(), "GetEntityName(LAST_SHIELDER) has protected you with a shield of ice.");
				SendColoredMessage(GetOwner(), "Added int(L_TIME_DIFF) seconds to Ice Shield.");
			}
			SendColoredMessage(LAST_SHIELDER, "You shield GetEntityName(GetOwner()) for int(L_TIME_DIFF) more seconds.");
		}
		else
		{
			SendColoredMessage(GetOwner(), "Added int(L_TIME_DIFF) seconds to Ice Shield.");
		}
		check_do_bonus(L_TIME_DIFF);
	}

	void shield_me_baby()
	{
		// TODO: hud.addstatusicon ent_me hud/status/alpha_iceshield iceshield EFFECT_DURATION
		Effect("glow", GetEntityIndex(GetOwner()), Vector3(0, 0, 192), 72, EFFECT_DURATION, EFFECT_DURATION);
		EmitSound(GetOwner(), "game.sound.item", "magic/heal_strike.wav", "game.sound.maxvol");
	}

	void check_do_bonus()
	{
		string L_TIME_DIFF = param1;
		if (LAST_SHIELDER != GetEntityIndex(GetOwner()))
		{
			if ((IsValidPlayer(GetOwner())))
			{
				int ADD_BONUS = 1;
			}
		}
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			int ADD_BONUS = 1;
		}
		if (!(ADD_BONUS)) return;
		string L_BONUS_MSG = "for shielding ";
		L_BONUS_MSG += GetEntityName(GetOwner());
		string L_DMGPOINT_ADD = /* TODO: $math(multiply) */ /* TODO: $math(divide) */ L_TIME_DIFF;
		CallExternal(LAST_SHIELDER, "ext_dmgpoint_bonus", L_DMGPOINT_ADD, L_BONUS_MSG);
	}

	void OnDamage(int damage) override
	{
		if (!(param2 > 0)) return;
		Effect("screenfade", GetOwner(), 0.5, 0, Vector3(0, 0, 192), 40, "fadein");
		EmitSound(GetOwner(), 0, "player/pl_metal2.wav", 3);
		return;
	}

	void effect_die()
	{
		// TODO: hud.killstatusicon ent_me iceshield
		// svplaysound: svplaysound 0 2 "debris/bustglass2.wav"
		EmitSound(0, 2, "debris/bustglass2.wav");
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 40), 10, 2, 5, 10, 20);
		SendColoredMessage(GetEntityIndex(GetOwner()), "Your ice shield has collapsed!");
	}

}

}
