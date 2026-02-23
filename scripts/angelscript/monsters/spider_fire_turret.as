#pragma context server

#include "monsters/spider_turret.as"

namespace MS
{

class SpiderFireTurret : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	int DOT_FIRE;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;

	SpiderFireTurret()
	{
		const string PROJ_TYPE = "proj_fire_xolt";
		const Vector3 PROJ_OFS = Vector3(0, 0, 32);
		DOT_FIRE = 3;
	}

	void spider_spawn()
	{
		SetHealth(150);
		if (!(AM_CLIPPED))
		{
			SetWidth(64);
			SetHeight(64);
		}
		if ((AM_CLIPPED))
		{
			SetWidth(32);
			SetHeight(20);
		}
		SetName("Fire Spider");
		SetHearingSensitivity(7);
		SetModel("monsters/fer_spider_large.mdl");
		SetProp(GetOwner(), "skin", 1);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 0.0);
		SetAnimMoveSpeed(0.0);
		SetMoveSpeed(0);
		SetMoveAnim(ANIM_IDLE);
		NO_STUCK_CHECKS = 1;
		NPC_GIVE_EXP = 100;
		ScheduleDelayedEvent(0.1, "make_turret");
	}

	void make_turret()
	{
		ANIM_RUN = "idle";
		ANIM_WALK = "idle";
	}

	void bite_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DOT_FIRE, 1, 1);
	}

}

}
