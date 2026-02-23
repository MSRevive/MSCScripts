#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsRune : CGameScript
{
	string SHIELD_HEALTH;

	ShieldsRune()
	{
		const float NOPUSH_CHANCE = 0.75;
		const float PARRY_MULTI = 2.0;
		const int SHIELD_BASE_PARRY = 25;
		const string MODEL_VIEW = "viewmodels/v_shields.mdl";
		const int MODEL_VIEW_IDX = 2;
		const int SHIELD_REPORT_HITS = 1;
		const int MODEL_BODY_OFS = 69;
		const int MELEE_ENERGY = 15;
		const float MELEE_ACCURACY = 0.9;
		const int BLOCK_CHANCE_UP = 100;
		const float DMG_BLOCK_UP = 0.35;
		const int BLOCK_CHANCE_DOWN = 30;
		const string SHIELD_MAXHEALTH = "infinite";
		const int SHIELD_IMMORTAL = 1;
		SHIELD_HEALTH = "infinite";
		const string SOUND_BLOCK = "doors/doorstop5.wav";
		const int EFFECT_RANGE = 150;
		Precache(SOUND_BLOCK);
	}

	void shield_spawn()
	{
		SetName("Rune Shield");
		SetDescription("This rune shield is cold to the touch");
		SetWeight(40);
		SetSize(45);
		SetValue(5000);
		SetQuality(2000);
		SetHUDSprite("hand", "ironshield");
		SetHUDSprite("trade", "runeshield");
	}

	void game_wear()
	{
		SendPlayerMessage("You", "sling a Rune Shield over your shoulder.");
	}

	void shield_hit()
	{
		if (!(IsEntityAlive(param1))) return;
		if ((GetEntityProperty(param2, "is_projectile"))) return;
		string MY_OWNER = GetEntityIndex(GetOwner());
		string THE_ATTACKER = GetEntityIndex(param1);
		if (!(THE_ATTACKER != GetEntityIndex(GetOwner()))) return;
		string OWNER_ORG = GetEntityOrigin(MY_OWNER);
		string ATTACKER_ORG = GetEntityOrigin(THE_ATTACKER);
		if (!(Distance(OWNER_ORG, ATTACKER_ORG) < EFFECT_RANGE)) return;
		if (!("game.item.attacking"))
		{
			int FROST_CHANCE = 25;
		}
		else
		{
			int FROST_CHANCE = 5;
		}
		string FROST_ROLL = RandomInt(1, FROST_CHANCE);
		LogDebug("frost_roll FROST_ROLL / FROST_CHANCE");
		if (FROST_ROLL == 1)
		{
			SendPlayerMessage(GetOwner(), "The rune shield's magic has frozen your enemy!");
			EmitSound(GetOwner(), 2, "debris/beamstart14.wav", "const.snd.fullvol");
			ApplyEffect(THE_ATTACKER, "effects/dot_cold", 10, GetEntityIndex(GetOwner()), Random(5, 15), "none");
		}
	}

}

}
