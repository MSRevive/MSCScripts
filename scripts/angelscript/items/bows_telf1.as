#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsTelf1 : CGameScript
{
	string TORKIE_BOW_TYPE;

	BowsTelf1()
	{
		const int BASE_LEVEL_REQ = 30;
		const int MODEL_VIEW_IDX = 9;
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string MODEL_WEAR = "weapons/p_weapons3.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "longbow";
		const string ANIM_PREFIX = "standard";
		const int MODEL_BODY_OFS = 54;
		const float RANGED_POSTFIRE_DELAY = 1.0;
		const float RANGED_ATK_DURATION = 1.0;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
		const int CUSTOM_ATTACK = 1;
		const string DAMAGE_TYPE = "fire_effect";
		const string RANGED_HOLD_MINMAX = "1.1;1.3";
		const string RANGED_STAT = "archery";
		const float RANGED_PULLTIME = 1.0;
		const float DMG_ADJ = 0.65;
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
