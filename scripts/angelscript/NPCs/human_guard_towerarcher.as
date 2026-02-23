#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class HumanGuardTowerarcher : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string ARROW_TARGET;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_ATTACK;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int HUNT_AGRO;
	string MOVE_RANGE;
	string NPCATK_TARGET;
	int NPC_GIVE_EXP;
	int NPC_NO_PLAYER_DMG;
	int PLAYING_DEAD;

	HumanGuardTowerarcher()
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
		const int ATTACK_SPEED = 900;
		const string ARROW_TYPE = "proj_arrow_jagged";
		MOVE_RANGE = ATTACK_SPEED;
		ATTACK_RANGE = 2000;
		ATTACK_HITRANGE = 2000;
		const string ATTACK_DAMAGE = "$rand(8,12)";
		const int ATTACK_COF = 5;
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
		SetBlind(true);
		SetRace("hguard");
		SetRoam(false);
		SetModel("npc/archer.mdl");
		SetDamageResistance("all", ".9");
		SetModelBody(2, 2);
		SetStat("parry", 2);
		SetMoveSpeed(0.0);
		SetAnimMoveSpeed(0.0);
		npcatk_suspend_ai();
		ScheduleDelayedEvent(1.0, "scan_for_nme");
		PLAYING_DEAD = 1;
		if (!(true)) return;
		if (!(StringToLower(GetMapName()) == "foutpost")) return;
		SetRace("human");
		NPC_NO_PLAYER_DMG = 1;
	}

	void scan_for_nme()
	{
		ScheduleDelayedEvent(1.0, "scan_for_nme");
		string T_BOX = /* TODO: $get_tbox */ $get_tbox("enemy", 1800);
		if (!(T_BOX != "none")) return;
		string T_BOX = /* TODO: $sort_entlist */ $sort_entlist(T_BOX, "range");
		ARROW_TARGET = GetToken(T_BOX, 0, ";");
		if (GetEntityRace(ARROW_TARGET) == "human")
		{
			ARROW_TARGET = "unset";
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		shoot_target();
	}

	void shoot_target()
	{
		SetMoveDest(ARROW_TARGET);
		PlayAnim("once", ANIM_ATTACK);
	}

	void shoot_arrow()
	{
		NPCATK_TARGET = ARROW_TARGET;
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		if (!(IsValidPlayer(TARG_ORG)))
		{
			TARG_ORG += "z";
		}
		string TARG_DIST = Distance(TARG_ORG, GetMonsterProperty("origin"));
		TARG_DIST /= 15;
		SetAngles("add_view.pitch");
		TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, 30), "none", 400, ATTACK_DAMAGE, 0, "none");
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		ARROW_TARGET = GetEntityIndex(m_hLastStruck);
		shoot_target();
		EmitSound(GetOwner(), 0, SOUND_STRUCK, 5);
	}

	void baseguard_tobattle()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
	}

	void catapults_fire()
	{
		string RAND = RandomInt(1, 100);
		if (RAND > 60)
		{
			SetSayTextRange(1024);
			if (RAND < 85)
			{
				SayText("Take cover!");
			}
			else
			{
				SayText("Projectiles inbound!");
			}
		}
	}

}

}
