#pragma context server

#include "items/base_weapon.as"

namespace MS
{

class CrossbowHeavy : CGameScript
{
	int ANIM_FIRE;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	int ANIM_STRETCH;
	float ATTACK_ACCURACYDEFAULT;
	string ATTACK_ACCURACYSTAT;
	int ATTACK_ALIGN_BASE;
	int ATTACK_ALIGN_TIP;
	string ATTACK_DAMAGE_TYPE;
	string ATTACK_DONE_EVENT;
	float ATTACK_DURATION;
	float ATTACK_ENERGY;
	string ATTACK_EVENT;
	string ATTACK_KEYS;
	string ATTACK_LAND_EVENT;
	int ATTACK_PRIORITY;
	string ATTACK_PROJECTILE;
	float ATTACK_PROJMAXHOLD;
	float ATTACK_PROJMINHOLD;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	string ITEM_NAME;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WEAR;
	string MODEL_WORLD;
	string SOUND_SHOOT;

	CrossbowHeavy()
	{
		ANIM_IDLE1 = 0;
		ANIM_LIFT1 = 4;
		ANIM_STRETCH = 8;
		ANIM_FIRE = 7;
		MODEL_VIEW = "weapons/bows/v_crossbow.mdl";
		MODEL_HANDS = "weapons/bows/p_crossbow.mdl";
		MODEL_WORLD = "weapons/bows/w_crossbow.mdl";
		MODEL_WEAR = "weapons/bows/crossbow_back.mdl";
		SOUND_SHOOT = "weapons/bow/crossbow.wav";
		ITEM_NAME = "xbow";
	}

	void weapon_spawn()
	{
		SetName("Heavy Crossbow");
		SetDescription("A heavier crossbow that allows bolts to fly further");
		SetWeight(95);
		SetSize(12);
		SetValue(3000);
		SetWearable(1);
		SetAnimExt("bow");
		SetWorldModel(MODEL_WORLD);
		SetViewModel(MODEL_VIEW);
		SetPlayerModel(MODEL_HANDS);
		SetHand("both");
		SetHUDSprite("hand", "bow");
		SetHUDSprite("trade", ITEM_NAME);
		register_shoot();
		SetModelBody(0, 1);
		Precache(MODEL_VIEW);
	}

	void deploy()
	{
		SetViewModel(MODEL_VIEW);
		// TODO: UNCONVERTED: setholdmodel ITEM_NAME
		SetModelBody(0, 1);
	}

	void pickup()
	{
		PlayViewAnim(ANIM_LIFT1);
	}

	void switchhands()
	{
		PlayViewAnim(ANIM_IDLE1);
	}

	void wear()
	{
		SetViewModel("none");
		SetModel(MODEL_WEAR);
		SendPlayerMessage("You", "sling a crossbow onto your back.");
	}

	void removefromowner()
	{
		SetModelBody(0, 0);
		CallOwnerEvent("drop_orcbow");
	}

	void register_shoot()
	{
		ATTACK_TYPE = "charge-throw-projectile";
		ATTACK_DAMAGE_TYPE = "none";
		ATTACK_KEYS = "+attack1";
		ATTACK_PRIORITY = 0;
		ATTACK_EVENT = "shoot";
		ATTACK_LAND_EVENT = "shoot_fire";
		ATTACK_DONE_EVENT = "shoot_done";
		ATTACK_RANGE = 1900;
		ATTACK_ENERGY = 0.1;
		ATTACK_PROJMINHOLD = 2.0;
		ATTACK_PROJMAXHOLD = 2.0;
		ATTACK_DURATION = 0.001;
		ATTACK_ACCURACYSTAT = "archery";
		ATTACK_ACCURACYDEFAULT = 0.01;
		ATTACK_ALIGN_BASE = 0;
		ATTACK_ALIGN_TIP = 0;
		ATTACK_PROJECTILE = "bolt";
		RegisterAttack();
	}

	void shoot()
	{
		PlayViewAnim(ANIM_STRETCH);
		PlayOwnerAnim("break");
		PlayOwnerAnim("hold", "bow_fire");
		CallOwnerEvent("commenceattack");
	}

	void shoot_fire()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SHOOT);
		PlayViewAnim(ANIM_FIRE);
		CallOwnerEvent("attackstrike");
	}

	void shoot_done()
	{
		PlayViewAnim(ANIM_LIFT1);
		PlayOwnerAnim("critical", "aim_bow");
		ScheduleDelayedEvent(1, "shoot_returnstanding");
	}

	void shoot_returnstanding()
	{
		if (!(CURRENTLY_ATTACKING == 0)) return;
		PlayOwnerAnim("once", "bow_aim_to_stand");
	}

}

}
