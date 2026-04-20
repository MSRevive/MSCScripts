#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsRune : CGameScript
{
	int BLOCK_CHANCE_DOWN;
	int BLOCK_CHANCE_UP;
	float DMG_BLOCK_UP;
	int EFFECT_RANGE;
	float MELEE_ACCURACY;
	int MELEE_ENERGY;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	float NOPUSH_CHANCE;
	float PARRY_MULTI;
	int SHIELD_BASE_PARRY;
	string SHIELD_HEALTH;
	int SHIELD_IMMORTAL;
	string SHIELD_MAXHEALTH;
	int SHIELD_REPORT_HITS;
	string SOUND_BLOCK;

	ShieldsRune()
	{
		NOPUSH_CHANCE = 0.75;
		PARRY_MULTI = 2.0;
		SHIELD_BASE_PARRY = 25;
		MODEL_VIEW = "viewmodels/v_shields.mdl";
		MODEL_VIEW_IDX = 2;
		SHIELD_REPORT_HITS = 1;
		MODEL_BODY_OFS = 69;
		MELEE_ENERGY = 15;
		MELEE_ACCURACY = 0.9;
		BLOCK_CHANCE_UP = 100;
		DMG_BLOCK_UP = 0.35;
		BLOCK_CHANCE_DOWN = 30;
		SHIELD_MAXHEALTH = "infinite";
		SHIELD_IMMORTAL = 1;
		SHIELD_HEALTH = "infinite";
		SOUND_BLOCK = "doors/doorstop5.wav";
		EFFECT_RANGE = 150;
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
		int FROST_ROLL = RandomInt(1, FROST_CHANCE);
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
