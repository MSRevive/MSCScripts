#pragma context server

#include "items/base_ranged.as"

namespace MS
{

class BowsBase : CGameScript
{
	int IS_BOW;
	int STRETCHED;

	BowsBase()
	{
		STRETCHED = 0;
		IS_BOW = 1;
		const int ANIM_IDLE1 = 0;
		const int ANIM_DEPLOY = 1;
		const int ANIM_STRETCH = 2;
		const int ANIM_FIRE = 3;
		const string ANIM_PREFIX = "bow";
		const string RANGED_HOLD_MINMAX = "1.1;1.3";
		const string RANGED_ATK_DURATION = RANGED_POSTFIRE_DELAY;
		const string RANGED_DMG_TYPE = "pierce";
		const string RANGED_STAT = "archery";
		const string RANGED_PROJECTILE = "arrow";
		const Vector3 RANGED_AIMANGLE = Vector3(0, 9, 0);
		const float RANGED_PULLTIME = 0.8;
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
