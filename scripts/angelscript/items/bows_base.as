#pragma context server

#include "items/base_ranged.as"

namespace MS
{

class BowsBase : CGameScript
{
	int ANIM_DEPLOY;
	int ANIM_FIRE;
	int ANIM_IDLE1;
	string ANIM_PREFIX;
	int ANIM_STRETCH;
	int IS_BOW;
	string RANGED_AIMANGLE;
	string RANGED_ATK_DURATION;
	string RANGED_DMG_TYPE;
	string RANGED_HOLD_MINMAX;
	string RANGED_PROJECTILE;
	float RANGED_PULLTIME;
	string RANGED_STAT;
	int STRETCHED;

	BowsBase()
	{
		STRETCHED = 0;
		IS_BOW = 1;
		ANIM_IDLE1 = 0;
		ANIM_DEPLOY = 1;
		ANIM_STRETCH = 2;
		ANIM_FIRE = 3;
		ANIM_PREFIX = "bow";
		RANGED_HOLD_MINMAX = "1.1;1.3";
		RANGED_ATK_DURATION = RANGED_POSTFIRE_DELAY;
		RANGED_DMG_TYPE = "pierce";
		RANGED_STAT = "archery";
		RANGED_PROJECTILE = "arrow";
		RANGED_AIMANGLE = Vector3(0, 9, 0);
		RANGED_PULLTIME = 0.8;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3.35);
		if (STRETCHED == 1)
		{
		}
		PlayOwnerAnim("critical", "bow_hold");
	}

	void weapon_spawn()
	{
		if (!(NOT_WEARABLE))
		{
			SetWearable(1);
		}
		SetAnimExt("bow");
		SetHand("both");
		SetHUDSprite("hand", "bow");
		SetHUDSprite("trade", ITEM_NAME);
		RegisterAttack();
		bow_spawn();
	}

	void ranged_start()
	{
		STRETCHED = 0;
		PlayViewAnim(ANIM_STRETCH);
		PlayOwnerAnim("critical", "bow_pull");
		RANGED_PULLTIME("ranged_stretchbow");
	}

	void ranged_stretchbow()
	{
		STRETCHED = 1;
		PlayOwnerAnim("critical", "bow_hold");
		basebow_stretchbow();
	}

	void ranged_toss()
	{
		EmitSound(GetOwner(), "game.sound.weapon", SOUND_SHOOT, "game.sound.maxvol");
		PlayViewAnim(ANIM_FIRE);
		PlayOwnerAnim("critical", "bow_release");
		STRETCHED = 0;
		ScheduleDelayedEvent(0.4, "shoot_returnstanding");
	}

	void ranged_end()
	{
		PlayViewAnim(ANIM_IDLE1);
	}

	void shoot_returnstanding()
	{
		if (("game.item.attacking")) return;
		PlayOwnerAnim("critical", "bow_aim_to_stand");
	}

	void game_wear()
	{
		SetModel(MODEL_WEAR);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 3;
		SetModelBody(0, L_SUBMODEL);
	}

	void game_show()
	{
		SetModel(MODEL_WEAR);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 3;
		SetModelBody(0, L_SUBMODEL);
	}

}

}
