#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonIce : CGameScript
{
	float ATTACK_DAMAGE_HIGH;
	float ATTACK_DAMAGE_LOW;
	int BOLTS_ON;
	int BOLT_CHECKING;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int MOVE_RANGE;
	string NEXT_BOLT;
	string NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	string SET_GREEK;

	SkeletonIce()
	{
		const int SKEL_HP = 700;
		const float ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE_LOW = 10.5;
		ATTACK_DAMAGE_HIGH = 15.5;
		NPC_GIVE_EXP = 120;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 20;
		DROP_GOLD_MAX = 35;
		const float SKEL_RESPAWN_CHANCE = 0.5;
		const int SKEL_RESPAWN_LIVES = 1;
		MOVE_RANGE = 300;
		const string ANIM_BLAST = "castspell";
		const string SOUND_BOLT = "magic/ice_strike.wav";
		const float BOLT_FREQUENCY = 3.0;
		const int BOLT_DAMAGE = 60;
		Precache("items/proj_ice_bolt");
		Precache("monsters/skeleton_boss1.mdl");
	}

	void skeleton_spawn()
	{
		SetName("Decayed Ice Bone");
		SetRace("undead");
		SetRoam(true);
		SetDamageResistance("all", 0.7);
		SetDamageResistance("fire", 1.2);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("cold", 0.0);
		SetModel("monsters/skeleton_boss1.mdl");
		SetModelBody(0, 5);
		SetModelBody(1, 8);
		SetHearingSensitivity(5);
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SET_GREEK = 1;
		}
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		BOLT_CHECKING = 0;
		SetStat("concentration", 30);
		SetStat("spellcasting", 30);
	}

	void cast_bolts()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(BOLT_CHECKING)) return;
		BOLT_FREQUENCY("cast_bolts");
		string SEE_NME = false;
		if (!(SEE_NME))
		{
			NO_STUCK_CHECKS = 0;
		}
		if (!(SEE_NME)) return;
		if (!(GetEntityRange(m_hLastSeen) > ATTACK_RANGE)) return;
		NO_STUCK_CHECKS = 1;
		EmitSound(GetOwner(), 0, "magic/frost_reverse.wav", 10);
		Effect("glow", GetOwner(), Vector3(128, 128, 255), 32, 2, 2);
		SetModelBody(1, 9);
		PlayAnim("once", "castspell");
		BOLTS_ON = 1;
		ScheduleDelayedEvent(1.0, "bolts_off");
	}

	void bolts_off()
	{
		BOLTS_ON = 0;
		SetModelBody(1, 8);
	}

	void extra_bolts()
	{
		string BOLT_DEST = GetEntityOrigin(GetOwner());
		string BOLT_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		BOLT_DEST += /* TODO: $relpos */ $relpos(Vector3(0, BOLT_YAW, 0), Vector3(0, 100, 40));
		TossProjectile("proj_ice_bolt", GetEntityProperty(GetOwner(), "attachpos"), BOLT_DEST, 500, BOLT_DAMAGE, 20, "none");
	}

	void npc_targetsighted()
	{
		if (!(BOLTS_ON)) return;
		if (!(GetGameTime() > NEXT_BOLT)) return;
		NEXT_BOLT = GetGameTime();
		NEXT_BOLT += 0.2;
		string BOLT_DEST = GetEntityOrigin(m_hAttackTarget);
		TossProjectile("proj_ice_bolt", GetEntityProperty(GetOwner(), "attachpos"), BOLT_DEST, 500, BOLT_DAMAGE, 10, "none");
	}

	void cycle_up()
	{
		if ((BOLT_CHECKING)) return;
		BOLT_CHECKING = 1;
		cast_bolts();
	}

	void cycle_down()
	{
		// TODO: UNCONVERTED: setvarad BOLT_CHECKING 0
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(1, 8);
	}

	void go_greek()
	{
		SetModelBody(0, 10);
		SET_GREEK = 1;
	}

}

}
