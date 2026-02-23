#pragma context server

#include "items/base_weapon.as"

namespace MS
{

class BowsCrossbowHeavy33 : CGameScript
{
	string HITSCAN_DMG_MULTI;
	int STRETCHED;
	string UNDER_SKILLED;
	string WEAPON_PRIMARY_SKILL;
	int XBOW_RELOADING;

	BowsCrossbowHeavy33()
	{
		const int BASE_LEVEL_REQ = 20;
		const int NO_PARRY = 1;
		const int ANIM_IDLE = 12;
		const int ANIM_IDLE_DEEP1 = 13;
		const int ANIM_IDLE_DEEP2 = 14;
		const int ANIM_DEPLOY = 20;
		const int ANIM_RELOAD = 19;
		const int ANIM_FIRE = 16;
		const string MODEL_VIEW = "viewmodels/v_xbows.mdl";
		const int MODEL_VIEW_IDX = 1;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string MODEL_WEAR = "weapons/p_weapons3.mdl";
		const string SOUND_SHOOT = "weapons/bow/crossbow.wav";
		const string ITEM_NAME = "xbow";
		const int MODEL_BODY_OFS = 13;
		const int NO_WORLD_MODEL = 1;
		const float XBOW_RELOAD_TIME = 3.0;
		const string ANIM_PREFIX = "standard";
		const string RANGED_PROJECTILE = "bolt";
		const string RANGED_HOLD_MINMAX = "0;0";
		const float RANGED_ATK_DURATION = 0.0;
		const string RANGED_DMG_TYPE = "pierce";
		const string RANGED_STAT = "archery";
		const float RANGED_DMG_DELAY = 0.0;
		const int RANGED_NOISE = 10;
		const int RANGED_ENERGY = 20;
		const float RANGED_DMG_MULTI = 2.0;
		WEAPON_PRIMARY_SKILL = RANGED_STAT;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
		const Vector3 RANGED_STARTPOS = Vector3(2, 12, -8);
		const string RANGED_ACCURACY = "0;0";
		const int RANGED_FORCE = 1000;
		const int NO_IDLE = 1;
	}

	void weapon_spawn()
	{
		SetName("Heavy Crossbow");
		SetDescription("This mighty crossbow has some kick to it");
		SetWeight(1);
		SetSize(3);
		SetValue(3000);
		SetWearable(0);
		SetAnimExt("bow");
		SetWorldModel(MODEL_WORLD);
		SetViewModel(MODEL_VIEW);
		SetPlayerModel(MODEL_HANDS);
		SetHand("both");
		SetHUDSprite("hand", 127);
		SetHUDSprite("trade", 127);
		register_bow();
	}

	void register_bow()
	{
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.keys = "+attack1";
		string reg.attack.hold_min&max = "0.1;0.1";
		int reg.attack.noautoaim = 1;
		string reg.attack.dmg.type = "pierce";
		int reg.attack.range = 600;
		int reg.attack.energydrain = 0;
		string reg.attack.stat = "archery";
		int reg.attack.COF = 0;
		string reg.attack.projectile = "bolt";
		int reg.attack.priority = 10;
		float reg.attack.delay.strike = 0.0;
		string reg.attack.delay.end = XBOW_RELOAD_TIME;
		string reg.attack.ofs.startpos = RANGED_STARTPOS;
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		string reg.attack.callback = "ranged";
		string reg.attack.dmg.multi = RANGED_DMG_MULTI;
		int reg.attack.noise = 10;
		RegisterAttack();
	}

	void ranged_start()
	{
		if ((XBOW_RELOADING))
		{
			CancelAttack();
		}
		if ((XBOW_RELOADING)) return;
		PlayOwnerAnim("hold", "xbow_idle");
	}

	void ranged_toss()
	{
		PlayViewAnim(ANIM_FIRE);
		EmitSound(GetOwner(), "game.sound.weapon", SOUND_SHOOT, "game.sound.maxvol");
		PlayOwnerAnim("critical", "xbow_reload");
		XBOW_RELOADING = 1;
		STRETCHED = 0;
		ScheduleDelayedEvent(0.2, "reload_now");
		string HEAVYONE = GetEntityProperty("ent_lastprojectile", "scriptvar");
		if (HEAVYONE == "HEAVY_BOLT")
		{
			CallExternal("ent_lastprojectile", "ext_lighten", 0.01);
		}
		if (HEAVYONE > 0)
		{
			CallExternal("ent_lastprojectile", "ext_lighten", HEAVYONE);
		}
	}

	void reload_now()
	{
		PlayViewAnim(ANIM_RELOAD);
		PlayOwnerAnim("critical", "xbow_reload");
		XBOW_RELOAD_TIME("done_reload");
	}

	void done_reload()
	{
		PlayViewAnim(ANIM_IDLE);
		XBOW_RELOADING = 0;
	}

	void ranged_returnstanding()
	{
		if (("game.item.attacking")) return;
		PlayOwnerAnim("critical", "bow_aim_to_stand");
	}

	void ranged_noammo()
	{
	}

	void OnDeploy() override
	{
		if ((false))
		{
			PlayViewAnim(ANIM_IDLE);
		}
		if (!(true)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		ScheduleDelayedEvent(0.1, "check_newb");
	}

	void check_newb()
	{
		string FIND_MELEE_STAT = "skill.";
		if (GetEntityProperty(GetOwner(), "find_melee_stat") < BASE_LEVEL_REQ)
		{
			SendColoredMessage(GetOwner(), "You lack the skill to properly wield this weapon!");
			string OUT_STR = "You lack the proficiency to wield this weapon. ( requires: ";
			OUT_STR += RANGED_STAT;
			OUT_STR += " proficiency ";
			OUT_STR += BASE_LEVEL_REQ;
			OUT_STR += " )";
			SendInfoMsg(GetOwner(), "Insufficient Skill OUT_STR");
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 0);
			UNDER_SKILLED = 1;
		}
		else
		{
			if ((UNDER_SKILLED))
			{
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
			}
			UNDER_SKILLED = 0;
		}
		if (!(UNDER_SKILLED))
		{
			HITSCAN_DMG_MULTI = RANGED_DMG_MULTI;
		}
		else
		{
			HITSCAN_DMG_MULTI = 0.1;
		}
	}

}

}
