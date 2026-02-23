#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonIceWarrior : CGameScript
{
	string ANIM_ATTACK;
	float ATTACK_DAMAGE_HIGH;
	float ATTACK_DAMAGE_LOW;
	int BOLT_CHECKING;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	string FREEZE_ATTACK;
	int ICE_BLASTING;
	int NPC_GIVE_EXP;

	SkeletonIceWarrior()
	{
		const int SKEL_HP = 1000;
		const float ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE_LOW = 20.5;
		ATTACK_DAMAGE_HIGH = 30.5;
		NPC_GIVE_EXP = 120;
		const string SMASH_DAMAGE = "$rand(50,100)";
		ANIM_ATTACK = "attack1";
		const string ANIM_SWIPE = "attack1";
		const string ANIM_SMASH = "attack2";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 20;
		DROP_GOLD_MAX = 35;
		const float SKEL_RESPAWN_CHANCE = 0.5;
		const int SKEL_RESPAWN_LIVES = 1;
		const string ANIM_BLAST = "rlflinch";
		const string SOUND_BOLT = "magic/ice_strike.wav";
		const float BOLT_FREQUENCY = 10.0;
		const int BOLT_DAMAGE = 30;
		const float FREEZE_CHANCE = 0.5;
		DROP_ITEM1 = "swords_liceblade";
		DROP_ITEM1_CHANCE = 0.1;
		Precache("items/proj_ice_bolt");
	}

	void skeleton_spawn()
	{
		SetName("Ice Bone Warrior");
		SetRace("undead");
		SetRoam(true);
		SetDamageResistance("all", ".7");
		SetDamageResistance("fire", 1.2);
		SetDamageResistance("lightning", ".5");
		SetDamageResistance("cold", 0.0);
		SetModel("monsters/skeleton.mdl");
		SetHearingSensitivity(5);
		SetModelBody(0, 7);
		SetModelBody(1, 4);
		SetStat("concentration", 30);
		SetStat("spellcasting", 30);
	}

	void cast_bolts()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		BOLT_FREQUENCY("cast_bolts");
		if (!(false)) return;
		if ((ICE_BLASTING)) return;
		if ((PLAYING_DEAD)) return;
		ICE_BLASTING = 1;
		ScheduleDelayedEvent(0.1, "end_blast");
		PlayAnim("critcal", ANIM_BLAST);
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 2048, 0, 1.0, 0);
	}

	void end_blast()
	{
		ICE_BLASTING = 0;
	}

	void skele_swing_dodamage()
	{
		if (!(ICE_BLASTING))
		{
			if (!(FREEZE_ATTACK))
			{
				if (RandomInt(1, 4) == 1)
				{
					ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/dot_cold", 5, GetOwner(), RandomInt(3, 5), "none");
				}
			}
		}
		if ((FREEZE_ATTACK))
		{
			string FREEZE_ROLL = RandomInt(1, 100);
			if (FREEZE_ROLL <= FREEZE_CHANCE)
			{
				ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/dot_cold_freeze", 10, GetEntityIndex(GetOwner()));
			}
			if (FREEZE_ROLL > FREEZE_CHANCE)
			{
				if ((param1))
				{
					SendPlayerMessage(param2, "Ice Bone Warrior attempts to freeze you!");
				}
			}
			FREEZE_ATTACK = 0;
		}
		if (!(ICE_BLASTING)) return;
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_BOLT, 10);
		SetMoveDest(param2);
		TossProjectile("proj_ice_bolt", /* TODO: $relpos */ $relpos(0, 5, 10), GetEntityIndex(param2), 500, BOLT_DAMAGE, 1, "none");
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((BOLT_CHECKING)) return;
		BOLT_CHECKING = 1;
		ScheduleDelayedEvent(4.0, "cast_bolts");
	}

	void attack_1()
	{
		attack_snd();
		DoDamage(m_hLastSeen, ATTACK_RANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_HITCHANCE, "slash");
		if (RandomInt(1, 20) == 1)
		{
			ANIM_ATTACK = "attack2";
		}
	}

	void attack_2()
	{
		Effect("glow", GetOwner(), Vector3(128, 128, 255), 80, 2, 2);
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
		DoDamage(m_hLastSeen, ATTACK_RANGE, SMASH_DAMAGE, ATTACK_HITCHANCE, "slash");
		FREEZE_ATTACK = 1;
		ANIM_ATTACK = "attack1";
		attack_snd();
	}

}

}
