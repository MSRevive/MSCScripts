#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsTelf1 : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	int CUSTOM_ATTACK;
	string DAMAGE_TYPE;
	float DMG_ADJ;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WEAR;
	string MODEL_WORLD;
	string RANGED_AIMANGLE;
	float RANGED_ATK_DURATION;
	string RANGED_HOLD_MINMAX;
	float RANGED_POSTFIRE_DELAY;
	float RANGED_PULLTIME;
	string RANGED_STAT;
	string SOUND_SHOOT;
	string TORKIE_BOW_TYPE;

	BowsTelf1()
	{
		BASE_LEVEL_REQ = 30;
		MODEL_VIEW_IDX = 9;
		MODEL_VIEW = "viewmodels/v_bows.mdl";
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_WEAR = "weapons/p_weapons3.mdl";
		SOUND_SHOOT = "weapons/bow/bow.wav";
		ITEM_NAME = "longbow";
		ANIM_PREFIX = "standard";
		MODEL_BODY_OFS = 54;
		RANGED_POSTFIRE_DELAY = 1.0;
		RANGED_ATK_DURATION = 1.0;
		RANGED_AIMANGLE = Vector3(0, 0, 0);
		CUSTOM_ATTACK = 1;
		DAMAGE_TYPE = "fire_effect";
		RANGED_HOLD_MINMAX = "1.1;1.3";
		RANGED_STAT = "archery";
		RANGED_PULLTIME = 1.0;
		DMG_ADJ = 0.65;
	}

	void bow_spawn()
	{
		SetName("Torkalath Fire Bow");
		SetDescription("Spiral flames are engraved in this ornate bow.");
		SetWeight(100);
		SetValue(1500);
		SetHUDSprite("trade", 166);
		custom_register();
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		set_bow_type();
	}

	void set_bow_type()
	{
		string DMG_AMT = GetSkillLevel(GetOwner(), "spellcasting.fire");
		DMG_AMT *= DMG_ADJ;
		if ((UNDER_SKILLED))
		{
			DMG_AMT *= 0.1;
		}
		TORKIE_BOW_TYPE = "fire";
		CallExternal(GetOwner(), "ext_set_spiral", TORKIE_BOW_TYPE, DMG_AMT);
	}

	void custom_register()
	{
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.keys = "+attack1";
		string reg.attack.hold_min&max = RANGED_HOLD_MINMAX;
		string reg.attack.dmg.type = DAMAGE_TYPE;
		float reg.attack.dmg.multi = 1.0;
		int reg.attack.range = 512;
		int reg.attack.energydrain = 1;
		string reg.attack.stat = "archery";
		string reg.attack.COF = "0.1;0.1";
		string reg.attack.projectile = "proj_arrow_spiral";
		int reg.attack.priority = 0;
		string reg.attack.delay.strike = RANGED_DMG_DELAY;
		string reg.attack.delay.end = RANGED_ATK_DURATION;
		Vector3 reg.attack.ofs.startpos = Vector3(0, 0, 10);
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		int reg.attack.ammodrain = 0;
		string reg.attack.callback = "ranged";
		int reg.attack.noise = 1000;
		RegisterAttack();
	}

	void ranged_start()
	{
		if (!(true)) return;
		string OWNER_SKILL = GetSkillLevel(GetOwner(), "spellcasting.fire");
		if (!(OWNER_SKILL < 15)) return;
		SendColoredMessage(GetOwner(), "You lack the fire affinity to activate this bow s magic.");
		CancelAttack();
	}

	void bow_underskilled()
	{
		set_bow_type();
	}

	void bow_underskilled_restore()
	{
		set_bow_type();
	}

}

}
