#pragma context server

#include "monsters/summon/skeleton.as"

namespace MS
{

class SkeletonGuard : CGameScript
{
	string ANIM_RUN_BASE;
	string ANIM_WALK_BASE;
	float BASE_FRAMERATE;
	string GUARD_STRUCK1;
	string GUARD_STRUCK2;
	string GUARD_STRUCK3;
	int SUMMON_CIRCLE_INDEX;
	string SUM_REPORT_SUFFIX;
	string SUM_SAY_ATTACK;
	string SUM_SAY_COME;
	string SUM_SAY_DEATH;
	string SUM_SAY_DEFEND;
	string SUM_SAY_GUARD;
	string SUM_SAY_HUNT;

	SkeletonGuard()
	{
		SUMMON_CIRCLE_INDEX = 30;
		SUM_SAY_COME = "Yes... my maaaster.";
		SUM_SAY_ATTACK = "Death... Approaches...";
		SUM_SAY_HUNT = "I am... Hunt...ing...";
		SUM_SAY_DEFEND = "Your... Defense... Is all.";
		SUM_SAY_DEATH = "No longer... Can I... Hold.";
		SUM_SAY_GUARD = "I... Shall hold.";
		SUM_REPORT_SUFFIX = ", master.";
		ANIM_WALK_BASE = "walk";
		ANIM_RUN_BASE = "walk";
		GUARD_STRUCK1 = "body/armour1.wav";
		GUARD_STRUCK2 = "body/armour2.wav";
		GUARD_STRUCK3 = "body/armour3.wav";
	}

	void pre_name_set()
	{
		SetModelBody(0, 3);
		SetModelBody(1, 3);
	}

	void summon_spawn()
	{
		SetName("Undead Guardian");
		SetAnimMoveSpeed(0.5);
		SetAnimFrameRate(0.5);
		SetDamageResistance("all", 0.5);
		SetBloodType("none");
		SetDamageResistance("slash", ".7");
		SetDamageResistance("pierce", ".5");
		SetDamageResistance("blunt", 1.2);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("holy", 3.0);
		SetDamageResistance("cold", 0.1);
		SetDamageResistance("poison", 0.0);
		BASE_FRAMERATE = 0.5;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: GUARD_STRUCK1, GUARD_STRUCK2, GUARD_STRUCK3
		array<string> sounds = {GUARD_STRUCK1, GUARD_STRUCK2, GUARD_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

}

}
