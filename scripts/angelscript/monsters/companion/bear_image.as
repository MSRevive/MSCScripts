#pragma context server

namespace MS
{

class BearImage : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	int DID_DEATH;
	string MY_OWNER;
	int PLAYING_DEAD;

	BearImage()
	{
		ANIM_ATTACK = "bear_claw";
		ANIM_IDLE = "bear_standingidle02";
	}

	void OnSpawn() override
	{
		SetModel("monsters/giant_rat.mdl");
		SetModelBody(0, 5);
		PLAYING_DEAD = 1;
		SetSolid("none");
		SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		SetInvincible(true);
		SetGravity(0);
		SetRoam(false);
		SetRace("beloved");
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		string OWNER_YAW = GetEntityProperty(MY_OWNER, "angles.yaw");
		SetAngles("face");
		SetFollow(MY_OWNER);
	}

	void ext_attack()
	{
		PlayAnim("once", ANIM_ATTACK);
	}

	void player_left()
	{
		LogDebug("bear_delete player_left");
		DeleteEntity(GetOwner());
	}

	void remove_bear()
	{
		LogDebug("bear_delete remove_bear");
		DeleteEntity(GetOwner());
	}

	void ext_bear_die()
	{
		LogDebug("bear_delete ext_bear_die PARAM1");
		if ((DID_DEATH)) return;
		DID_DEATH = 1;
		SetFollow("none");
		string OWNER_POS = GetEntityOrigin(MY_OWNER);
		OWNER_POS = "z";
		SetEntityOrigin(GetOwner(), OWNER_POS);
		string OWNER_YAW = GetEntityProperty(MY_OWNER, "angles.yaw");
		SetAngles("face");
		SetIdleAnim("bear_diestanding");
		SetMoveAnim("bear_diestanding");
		PlayAnim("once", "break");
		PlayAnim("hold", "bear_diestanding");
		ScheduleDelayedEvent(3.0, "bear_fade");
	}

	void bear_fade()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
