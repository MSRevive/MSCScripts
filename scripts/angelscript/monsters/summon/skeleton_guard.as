#pragma context server

#include "monsters/summon/skeleton.as"

namespace MS
{

class SkeletonGuard : CGameScript
{
	float BASE_FRAMERATE;

	SkeletonGuard()
	{
		const int SUMMON_CIRCLE_INDEX = 30;
		const string SUM_SAY_COME = "Yes... my maaaster.";
		const string SUM_SAY_ATTACK = "Death... Approaches...";
		const string SUM_SAY_HUNT = "I am... Hunt...ing...";
		const string SUM_SAY_DEFEND = "Your... Defense... Is all.";
		const string SUM_SAY_DEATH = "No longer... Can I... Hold.";
		const string SUM_SAY_GUARD = "I... Shall hold.";
		const string SUM_REPORT_SUFFIX = ", master.";
		const string ANIM_WALK_BASE = "walk";
		const string ANIM_RUN_BASE = "walk";
		const string GUARD_STRUCK1 = "body/armour1.wav";
		const string GUARD_STRUCK2 = "body/armour2.wav";
		const string GUARD_STRUCK3 = "body/armour3.wav";
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
