#pragma context shared

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsGb : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	string DOT_DAMAGE;
	string GIB_EXPLODE_DAMAGE;
	float MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	int PMODEL_IDX_FLOOR;
	string POTENTIALLY_INACCURATE_GIB_DAMAGE;
	string SOUND_SHOUT;
	string SOUND_SWIPE;
	int SWORD_MANUAL_PARRY;

	SwordsGb()
	{
		BASE_LEVEL_REQ = 37;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 2;
		ANIM_ATTACK3 = 2;
		ANIM_SHEATH = 5;
		MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		MODEL_VIEW_IDX = 10;
		MODEL_HANDS = "weapons/p_weapons4.mdl";
		MODEL_WORLD = "weapons/p_weapons4.mdl";
		MODEL_BODY_OFS = 62;
		PMODEL_IDX_FLOOR = 63;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		ANIM_PREFIX = "standard";
		PLAYERANIM_AIM = "axe_twohand";
		PLAYERANIM_SWING = "axe_twohand_swing";
		MELEE_RANGE = 100;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.4;
		MELEE_ENERGY = 10;
		MELEE_DMG = 540;
		MELEE_DMG_RANGE = 150;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.75;
		MELEE_STAT = "swordsmanship";
		MELEE_ALIGN_BASE = 4;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.15;
		SWORD_MANUAL_PARRY = 0;
		DOT_DAMAGE = "func_dot_damage"();
		GIB_EXPLODE_DAMAGE = "func_gib_damage"();
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
		inflict_bleed(param1);
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
		inflict_bleed(param2);
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
		string L_DMG = (L_DMG * 4);
		string L_DMG = (L_DMG + 55);
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
