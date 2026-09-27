#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_guard_friendly_new.as"

namespace MS
{

class HumanGuardSword : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_ATTACK;
	int CAN_HUNT;
	int CAN_RETALIATE;
	string FINAL_DAMAGE;
	string FINAL_HITCHANCE;
	int HUNT_AGRO;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	int NPC_NO_PLAYER_DMG;
	string SOUND_ATTACK;
	string SOUND_DEATH;
	string SOUND_STRUCK;
	string SOUND_WARCRY;

	HumanGuardSword()
	{
		SOUND_STRUCK = "body/flesh1.wav";
		SOUND_WARCRY = "voices/human/male_guard_shout2.wav";
		SOUND_ATTACK = "weapons/bow/bowslow.wav";
		SOUND_DEATH = "voices/human/male_die.wav";
		Precache(SOUND_DEATH);
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_DEATH = "diebackward";
		ANIM_ATTACK = "swordswing1_l";
		MOVE_RANGE = 65;
		ATTACK_RANGE = 85;
		ATTACK_HITRANGE = 130;
		ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE = "$randf(5.0,8.0)";
		CAN_HUNT = 1;
		CAN_ATTACK = 1;
		HUNT_AGRO = 1;
		CAN_RETALIATE = 1;
		NPC_GIVE_EXP = 0;
	}

	void OnSpawn() override
	{
		if ((CUSTOM_GUARD)) return;
		SetName("Guard");
		SetHealth(170);
		SetHearingSensitivity(12);
		SetWidth(32);
		SetHeight(85);
		SetRace("hguard");
		SetRoam(false);
		SetModel("npc/guard1.mdl");
		SetDamageResistance("all", ".9");
		SetModelBody(2, 2);
		SetStat("parry", 10);
		SetMoveSpeed(0.0);
		if (!(true)) return;
		if (!(StringToLower(GetMapName()) == "foutpost")) return;
		SetRace("human");
		NPC_NO_PLAYER_DMG = 1;
	}

	void attack_1()
	{
		FINAL_HITCHANCE = ATTACK_HITRANGE;
		FINAL_DAMAGE = ATTACK_DAMAGE;
		basenpc_adj_attack();
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, FINAL_DAMAGE, FINAL_HITCHANCE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK, 5);
	}

	void baseguard_tobattle()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
	}

}

}
