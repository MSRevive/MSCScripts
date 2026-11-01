#pragma context server

#include "items/base_weapon.as"

namespace MS
{

class BowsCrossbowLight : CGameScript
{
	int ANIM_DEPLOY;
	int ANIM_FIRE;
	int ANIM_IDLE;
	string ANIM_PREFIX;
	int ANIM_RELOAD;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WEAR;
	string MODEL_WORLD;
	int NO_PARRY;
	int NO_WORLD_MODEL;
	string RANGED_ACCURACY;
	string RANGED_AIMANGLE;
	float RANGED_ATK_DURATION;
	float RANGED_DMG_DELAY;
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
	string WEAPON_PRIMARY_SKILL;
	int XBOW_RELOADING;
	float XBOW_RELOAD_TIME;

	BowsCrossbowLight()
	{
		NO_PARRY = 1;
		ANIM_IDLE = 0;
		ANIM_DEPLOY = 8;
		ANIM_RELOAD = 7;
		ANIM_FIRE = 4;
		MODEL_VIEW = "viewmodels/v_xbows.mdl";
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_WEAR = "weapons/p_weapons2.mdl";
		SOUND_SHOOT = "weapons/bow/crossbow.wav";
		ITEM_NAME = "xbow";
		MODEL_BODY_OFS = 52;
		NO_WORLD_MODEL = 1;
		XBOW_RELOAD_TIME = 2.0;
		ANIM_PREFIX = "orcbow";
		RANGED_PROJECTILE = "bolt";
		RANGED_HOLD_MINMAX = "0;0";
		RANGED_ATK_DURATION = 0.0;
		RANGED_DMG_TYPE = "pierce";
		RANGED_STAT = "archery";
		RANGED_AIMANGLE = Vector3(0, 0, 0);
		RANGED_DMG_DELAY = 0.0;
		RANGED_NOISE = 10;
		RANGED_ENERGY = 20;
		WEAPON_PRIMARY_SKILL = RANGED_STAT;
		RANGED_STARTPOS = Vector3(2, 12, -8);
		RANGED_ACCURACY = "0;0";
		RANGED_FORCE = 1000;
	}

	void weapon_spawn()
	{
		SetName("Crossbow");
		SetDescription("An accurate , long range crossbow");
		SetWeight(1);
		SetSize(3);
		SetValue(300);
		SetWearable(0);
		SetAnimExt("bow");
		SetWorldModel(MODEL_WORLD);
		SetViewModel(MODEL_VIEW);
		SetPlayerModel(MODEL_HANDS);
		SetHand("both");
		SetHUDSprite("hand", "bow");
		SetHUDSprite("trade", "xbow");
		register_bow();
		SetModelBody(0, 0);
		Precache(MODEL_VIEW);
	}

	void OnDeploy() override
	{
		if (!(false)) return;
		PlayViewAnim(ANIM_IDLE);
	}

	void register_bow()
	{
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.keys = "+attack1";
		string reg.attack.hold_min&max = "0.1;0.1";
		string reg.attack.dmg.type = "pierce";
		int reg.attack.range = 400;
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
		int reg.attack.noise = 10;
		RegisterAttack();
	}

	void ranged_start()
	{
		if ((XBOW_RELOADING)) return;
		PlayOwnerAnim("hold", "xbow_idle");
	}

	void ranged_toss()
	{
		PlayViewAnim(ANIM_FIRE);
		EmitSound(GetOwner(), "game.sound.weapon", SOUND_SHOOT, "game.sound.maxvol");
		PlayOwnerAnim("critical", "xbow_reload");
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
	}

	void ranged_end()
	{
		done_reload();
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

}

}
