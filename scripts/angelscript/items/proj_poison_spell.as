#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoisonSpell : CGameScript
{
	string EFFECT_DURATION;
	string POISON_DAMAGE;

	ProjPoisonSpell()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 8;
		const int ARROW_BODY_OFS = 8;
		const string SOUND_HITWALL1 = "bullchicken/bc_acid1.wav";
		const string SOUND_HITWALL2 = "bullchicken/bc_acid1.wav";
		const string SOUND_BURN = "bullchicken/bc_acid1.wav";
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "poison";
		const string PROJ_DAMAGESTAT = "spellcasting.affliction";
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_DAMAGE = 50;
		const int PROJ_AOE_RANGE = 30;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDEHITBOX = 32;
	}

	void projectile_spawn()
	{
		SetName("Poisoner");
		SetWeight(500);
		SetSize(1);
		SetValue(5);
		SetGravity(0.0);
		SetGroupable(25);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 128, 100, 100);
	}

	void projectile_landed()
	{
		poison_landed();
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string ENT_HIT = GetEntityIndex(param2);
		string POISON_DAMAGE = GetSkillLevel(MY_OWNER, "spellcasting.affliction");
		POISON_DAMAGE *= 0.1;
		if (POISON_DAMAGE < 0.1)
		{
			POISON_DAMAGE = 0.1;
		}
		string EFFECT_DURATION = POISON_DAMAGE;
		EFFECT_DURATION *= 5;
		EFFECT_DURATION += 30;
		if (EFFECT_DURATION > 120)
		{
			EFFECT_DURATION = 120;
		}
		ApplyEffect(ENT_HIT, "effects/dot_poison", EFFECT_DURATION, MY_OWNER, POISON_DAMAGE, "spellcasting.affliction");
	}

}

}
