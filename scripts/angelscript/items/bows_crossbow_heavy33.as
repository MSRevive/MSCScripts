#pragma context server

#include "items/base_weapon.as"

namespace MS
{

class BowsCrossbowHeavy33 : CGameScript
{
	int ANIM_DEPLOY;
	int ANIM_FIRE;
	int ANIM_IDLE;
	int ANIM_IDLE_DEEP1;
	int ANIM_IDLE_DEEP2;
	string ANIM_PREFIX;
	int ANIM_RELOAD;
	int BASE_LEVEL_REQ;
	string HITSCAN_DMG_MULTI;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WEAR;
	string MODEL_WORLD;
	int NO_IDLE;
	int NO_PARRY;
	int NO_WORLD_MODEL;
	string RANGED_ACCURACY;
	string RANGED_AIMANGLE;
	float RANGED_ATK_DURATION;
	float RANGED_DMG_DELAY;
	float RANGED_DMG_MULTI;
	string RANGED_DMG_TYPE;
	int RANGED_ENERGY;
	int RANGED_FORCE;
	string RANGED_HOLD_MINMAX;
	int RANGED_NOISE;
	string RANGED_PROJECTILE;
	string RANGED_STARTPOS;
	string RANGED_STAT;
	string SOUND_SHOOT;
	int STRETCHED;
	string UNDER_SKILLED;
	string WEAPON_PRIMARY_SKILL;
	int XBOW_RELOADING;
	float XBOW_RELOAD_TIME;

	BowsCrossbowHeavy33()
	{
		BASE_LEVEL_REQ = 20;
		NO_PARRY = 1;
		ANIM_IDLE = 12;
		ANIM_IDLE_DEEP1 = 13;
		ANIM_IDLE_DEEP2 = 14;
		ANIM_DEPLOY = 20;
		ANIM_RELOAD = 19;
		ANIM_FIRE = 16;
		MODEL_VIEW = "viewmodels/v_xbows.mdl";
		MODEL_VIEW_IDX = 1;
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_WEAR = "weapons/p_weapons3.mdl";
		SOUND_SHOOT = "weapons/bow/crossbow.wav";
		ITEM_NAME = "xbow";
		MODEL_BODY_OFS = 13;
		NO_WORLD_MODEL = 1;
		XBOW_RELOAD_TIME = 3.0;
		ANIM_PREFIX = "standard";
		RANGED_PROJECTILE = "bolt";
		RANGED_HOLD_MINMAX = "0;0";
		RANGED_ATK_DURATION = 0.0;
		RANGED_DMG_TYPE = "pierce";
		RANGED_STAT = "archery";
		RANGED_DMG_DELAY = 0.0;
		RANGED_NOISE = 10;
		RANGED_ENERGY = 20;
		RANGED_DMG_MULTI = 2.0;
		WEAPON_PRIMARY_SKILL = RANGED_STAT;
		RANGED_AIMANGLE = Vector3(0, 0, 0);
		RANGED_STARTPOS = Vector3(2, 12, -8);
		RANGED_ACCURACY = "0;0";
		RANGED_FORCE = 1000;
		NO_IDLE = 1;
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
			SendInfoMsg(GetOwner(), "Insufficient Skill " + OUT_STR);
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
