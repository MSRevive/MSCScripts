#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsFirebird : CGameScript
{
	BowsFirebird()
	{
		const int BASE_LEVEL_REQ = 25;
		const int MODEL_VIEW_IDX = 7;
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string MODEL_WEAR = "weapons/p_weapons3.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "longbow";
		const string ANIM_PREFIX = "standard";
		const int MODEL_BODY_OFS = 40;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
		const int CUSTOM_ATTACK = 1;
	}

	void bow_spawn()
	{
		SetName("Phoenix Bow");
		SetDescription("A magical bow that shoots explosive projectiles.");
		SetWeight(100);
		SetValue(1500);
		SetHUDSprite("trade", 129);
		custom_register();
	}

	void custom_register()
	{
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.keys = "+attack1";
		string reg.attack.hold_min&max = "1.1;1.3";
		string reg.attack.dmg.type = "magic";
		int reg.attack.range = 1324;
		int reg.attack.energydrain = 1;
		string reg.attack.stat = "archery";
		string reg.attack.COF = "1;1";
		string reg.attack.projectile = "proj_arrow_phx";
		int reg.attack.priority = 0;
		float reg.attack.delay.strike = 0.8;
		float reg.attack.delay.end = 0.8;
		Vector3 reg.attack.ofs.startpos = Vector3(0, 0, 10);
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		int reg.attack.ammodrain = 0;
		string reg.attack.callback = "ranged";
		int reg.attack.noise = 1000;
		RegisterAttack();
	}

}

}
