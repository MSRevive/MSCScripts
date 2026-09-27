#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Copy of undamael : CGameScript
{
	string ANIM_IDLE;
	int CAN_FLINCH;
	int IGNORE_ENEMY;
	int MOVE_RANGE;
	int SEE_ENEMY;

	Copy of undamael()
	{
		ANIM_IDLE = "idle1";
		MOVE_RANGE = 0;
		SEE_ENEMY = 0;
		IGNORE_ENEMY = 1;
		CAN_FLINCH = 0;
		Precache("lgtning.spr");
	}

	void OnSpawn() override
	{
		SetName("|Lord Undamael");
		SetInvincible(true);
		SetHealth(2900);
		SetGold(RandomInt(100, 400));
		SetFOV(359);
		SetWidth(50);
		SetHeight(128);
		SetRace("undead");
		SetRoam(false);
		SetHearingSensitivity(0);
		SetSkillLevel(400);
		SetModel("monsters/skeleton_hood.mdl");
		SetModelBody(0, 0);
		SetIdleAnim(ANIM_IDLE);
	}

	void fade_away()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
