#pragma context server

#include "effects/base_effect.as"

namespace MS
{

class EffectShardshield : CGameScript
{
	float game.effect.anim.framerate;
	int game.effect.canattack;
	int game.effect.canjump;
	int game.effect.movespeed;
	string local.effect.damage;

	EffectShardshield()
	{
		const string EFFECT_ID = "effect_shardshield";
		const string EFFECT_FLAGS = "nostack";
	}

	void game_activate()
	{
		local.effect.damage = param2;
		game.effect.movespeed = 90;
		game.effect.canjump = 0;
		game.effect.anim.framerate = 0.9;
		game.effect.canattack = 0;
		Effect("glow", GetOwner(), Vector3(255, 192, 128), 72, EFFECT_DURATION, EFFECT_DURATION);
		EmitSound(GetOwner(), "game.sound.item", "magic/cast.wav", "game.sound.maxvol");
		SendColoredMessage(GetEntityIndex(GetOwner()), "You are protected by divine shield.");
	}

	void OnDamage(int damage) override
	{
		EmitSound(GetOwner(), 2, "magic/converted_magic13.wav", 5);
		Effect("screenfade", GetOwner(), 0.5, 0, Vector3(255, 192, 128), 40, "fadein");
		return;
	}

	void effect_die()
	{
		EmitSound(GetOwner(), 2, "magic/frost_reverse.wav", 5);
		SendPlayerMessage(GetOwner(), "The divine shield fades.");
	}

}

}
