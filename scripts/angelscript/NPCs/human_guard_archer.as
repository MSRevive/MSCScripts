#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_guard_friendly_new.as"

namespace MS
{

class HumanGuardArcher : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string ATTACK_HITRANGE;
	string ATTACK_RANGE;
	int CAN_ATTACK;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int HUNT_AGRO;
	string MOVE_RANGE;
	int NPC_GIVE_EXP;
	int NPC_NO_PLAYER_DMG;

	HumanGuardArcher()
	{
		const string SOUND_STRUCK = "body/flesh1.wav";
		const string SOUND_WARCRY = "voices/human/male_guard_shout.wav";
		const string SOUND_ATTACK = "weapons/bow/bowslow.wav";
		const string SOUND_DEATH = "voices/human/male_die.wav";
		Precache(SOUND_DEATH);
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die_fallback";
		ANIM_ATTACK = "shootorcbow";
		const int ATTACK_SPEED = 500;
		MOVE_RANGE = ATTACK_SPEED;
		ATTACK_RANGE = ATTACK_SPEED;
		ATTACK_HITRANGE = ATTACK_SPEED;
		const string ATTACK_DAMAGE = "$rand(8,12)";
		const int ATTACK_COF = 0;
		CAN_HUNT = 1;
		CAN_ATTACK = 1;
		HUNT_AGRO = 1;
		CAN_RETALIATE = 1;
		NPC_GIVE_EXP = 0;
	}

	void OnSpawn() override
	{
		SetName("Human Archer");
		SetHealth(120);
		SetHearingSensitivity(12);
		SetWidth(32);
		SetHeight(85);
		SetRace("hguard");
		SetRoam(false);
		SetModel("npc/archer.mdl");
		SetDamageResistance("all", ".9");
		SetModelBody(2, 2);
		SetStat("parry", 2);
		SetMoveSpeed(0.0);
		if (!(true)) return;
		if (!(StringToLower(GetMapName()) == "foutpost")) return;
		SetDamageResistance("all", 0.25);
		SetRace("human");
		NPC_NO_PLAYER_DMG = 1;
	}

	void shoot_arrow()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 10);
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		if (!(IsValidPlayer(TARG_ORG)))
		{
			TARG_ORG += "z";
		}
		string TARG_DIST = Distance(TARG_ORG, GetMonsterProperty("origin"));
		TARG_DIST /= 25;
		SetAngles("add_view.pitch");
		TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, 3), "none", ATTACK_SPEED, ATTACK_DAMAGE, ATTACK_COF, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0.4);
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
