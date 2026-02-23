#pragma context shared

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsGb : CGameScript
{
	string POTENTIALLY_INACCURATE_GIB_DAMAGE;

	SwordsGb()
	{
		const int BASE_LEVEL_REQ = 37;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 2;
		const int ANIM_ATTACK3 = 2;
		const int ANIM_SHEATH = 5;
		const string MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		const int MODEL_VIEW_IDX = 10;
		const string MODEL_HANDS = "weapons/p_weapons4.mdl";
		const string MODEL_WORLD = "weapons/p_weapons4.mdl";
		const int MODEL_BODY_OFS = 62;
		const int PMODEL_IDX_FLOOR = 63;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const string ANIM_PREFIX = "standard";
		const string PLAYERANIM_AIM = "axe_twohand";
		const string PLAYERANIM_SWING = "axe_twohand_swing";
		const int MELEE_RANGE = 100;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.4;
		const int MELEE_ENERGY = 10;
		const int MELEE_DMG = 540;
		const int MELEE_DMG_RANGE = 150;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 4;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.15;
		const int SWORD_MANUAL_PARRY = 0;
		const string DOT_DAMAGE = /* TODO: $func */ $func("func_dot_damage");
		const string GIB_EXPLODE_DAMAGE = /* TODO: $func */ $func("func_gib_damage");
	}

	void weapon_spawn()
	{
		SetName("Gut Buster");
		SetDescription("The sickly sword thrives on flesh.");
		SetWeight(90);
		SetSize(5);
		SetValue(2500);
		SetHUDSprite("trade", 199);
		SetHand("both");
	}

	void game_precache()
	{
		Precache("gib_b_bone.mdl");
		Precache("gib_b_gib.mdl");
		Precache("gib_lung.mdl");
		Precache("gib_legbone.mdl");
		Precache("agibs.mdl");
		Precache("bloodspray.spr");
		Precache("char_breath.spr");
	}

	void weapon_damaged_other()
	{
		if ((BITEM_UNDERSKILLED)) return;
		if (!(param2 > 0)) return;
		if ((GetEntityProperty(param1, "scriptvar"))) return;
		if ((GetEntityProperty(param1, "scriptvar"))) return;
		inflict_bleed(/* TODO: $pass */ $pass(param1));
		string L_BLOOD = GetEntityProperty(param1, "blood");
		if (!(L_BLOOD != "none")) return;
		string L_SOUND = "leech/leech_bite";
		EmitSound(GetOwner(), 0, L_SOUND, 10);
		string L_VEL = /* TODO: $relvel */ $relvel(GetEntityProperty(GetOwner(), "viewangles"), Vector3(-35, 50, 350));
		SpawnNPC("effects/swords_gb/gb_gib_explode", GetEntityOrigin(param1), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), L_VEL, GIB_EXPLODE_DAMAGE, "swordsmanship", L_BLOOD, GetEntityIndex(GetOwner())
	}

	void gib_dodamage()
	{
		if (!(param1)) return;
		if (!(param6)) return;
		inflict_bleed(/* TODO: $pass */ $pass(param2));
	}

	void inflict_bleed()
	{
		string L_BLOOD = GetEntityProperty(param1, "blood");
		if (!(L_BLOOD != "none")) return;
		ApplyEffect(param1, "effects/swords_gb/gut_buster", 5, GetEntityIndex(GetOwner()), DOT_DAMAGE, "swordsmanship", GetEntityIndex(GetOwner()));
	}

	void func_dot_damage()
	{
		string L_DMG = GetSkillLevel(GetOwner(), "swordsmanship");
		L_DMG -= BASE_LEVEL_REQ;
		string L_DMG = /* TODO: $math(multiply) */ L_DMG;
		string L_DMG = /* TODO: $math(add) */ L_DMG;
		return;
		return;
	}

	void func_gib_damage()
	{
		string L_DMG = GetSkillLevel(GetOwner(), "swordsmanship");
		L_DMG *= 2.75;
		POTENTIALLY_INACCURATE_GIB_DAMAGE = L_DMG;
		return;
		return;
	}

	void special_01_start()
	{
		PlayViewAnim(8);
	}

	void game_fall()
	{
		SetModelBody(0, PMODEL_IDX_FLOOR);
	}

}

}
