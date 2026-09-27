#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoisonSpell : CGameScript
{
	int ARROW_BODY_OFS;
	string EFFECT_DURATION;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string POISON_DAMAGE;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;
	string SOUND_BURN;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjPoisonSpell()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 8;
		ARROW_BODY_OFS = 8;
		SOUND_HITWALL1 = "bullchicken/bc_acid1.wav";
		SOUND_HITWALL2 = "bullchicken/bc_acid1.wav";
		SOUND_BURN = "bullchicken/bc_acid1.wav";
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "poison";
		PROJ_DAMAGESTAT = "spellcasting.affliction";
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_DAMAGE = 50;
		PROJ_AOE_RANGE = 30;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 32;
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
