#pragma context server

#include "effects/base_effect.as"

namespace MS
{

class Protection : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string SOUND_CHARGE;
	string local.effect.damage;

	Protection()
	{
		SOUND_CHARGE = "turret/tu_die2.wav";
		Precache(SOUND_CHARGE);
		EFFECT_ID = "effect_protect";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		local.effect.damage = param2;
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 96, EFFECT_DURATION, EFFECT_DURATION);
		EmitSound(GetOwner(), "game.sound.item", "magic/heal_strike.wav", "game.sound.maxvol");
		SendPlayerMessage(GetEntityIndex(GetOwner()), "You are protected by a magical barrier.");
	}

	void OnDamage(int damage) override
	{
		if (!(param2 > 0)) return;
		Effect("screenfade", GetOwner(), 0.5, 0, Vector3(255, 255, 255), 40, "fadein");
		return;
		EmitSound(GetOwner(), 2, "player/pl_metal2.wav", 5);
	}

	void effect_die()
	{
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 8);
		Effect("tempent", "trail", "lgtning.spr", /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 80), 10, 2, 5, 10, 20);
		SendPlayerMessage(GetEntityIndex(GetOwner()), "Your protection spell has expired!");
	}

}

}
