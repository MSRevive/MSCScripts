#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class MorcSniper : CGameScript
{
	int AM_TURRET;
	string ANIM_ATTACK;
	string ANIM_RUN;
	string ANIM_WALK;
	string ARROW_MISSED;
	int ATTACK_CONE_OF_FIRE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	string ATTACK_PUSH;
	int ATTACK_RANGE;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int IS_ARROW;
	int MELEE_ATK;
	int MOVE_RANGE;
	string NEXT_KICK;
	int NO_STUCK_CHECKS;
	string NPC_GIVE_EXP;

	MorcSniper()
	{
		const int DMG_DOT = 30;
		const float DOT_DUR = 5.0;
		const string ARROW_TYPE = "proj_arrow_npc_dyn";
		const int ATTACK_SPEED = 900;
		ATTACK_CONE_OF_FIRE = 2;
		const string DMG_BOW = RandomInt(100, 200);
		const int KICK_RANGE = 96;
		const int KICK_HITRANGE = 128;
		const int KICK_HITCHANCE = 90;
		const string ANIM_SMASH = "battleaxe_swing1_L";
		const string ANIM_SWIPE = "swordswing1_L";
		const string ANIM_BOW = "shootorcbow";
		const string ANIM_KICK = "kick";
		const string DMG_SMASH = "$rand(30,75)";
		const string DMG_SWIPE = "$rand(10,30)";
		const string DMG_KICK = "$rand(10,30)";
		const int ALT_ATTACKS = 1;
		const float FREQ_KICK = 10.0;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(10, 20);
		const string DROP_ITEM_BASE1 = "bows_longbow";
		DROP_ITEM1 = DROP_ITEM_BASE1;
		DROP_ITEM1_CHANCE = 0.05;
		DROPS_CONTAINER = 1;
		const string CONTAINER_BASE = "chests/quiver_of_frost_arrows";
		CONTAINER_DROP_CHANCE = 0.3;
		CONTAINER_SCRIPT = CONTAINER_BASE;
		ANIM_ATTACK = "shootorcbow";
		FLINCH_CHANCE = 0.45;
		const int FIN_EXP = 200;
		NPC_GIVE_EXP = FIN_EXP;
		MOVE_RANGE = 2000;
		ATTACK_RANGE = 2000;
		ATTACK_HITRANGE = 2000;
		ATTACK_MOVERANGE = 2000;
		const string SOUND_KICK = "zombie/claw_miss1.wav";
	}

	void orc_spawn()
	{
		SetName("Marogar Elite Archer");
		SetHealth(420);
		SetHearingSensitivity(2);
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		SetModel("monsters/morc.mdl");
		SetModelBody(0, 3);
		SetModelBody(1, 3);
		SetModelBody(2, 3);
		ScheduleDelayedEvent(1.0, "reset_range");
	}

	void reset_range()
	{
		ATTACK_HITRANGE = 2000;
	}

	void shoot_arrow()
	{
		string TARGET_DIST = GetEntityRange(m_hLastSeen);
		string FINAL_TARGET = GetEntityOrigin(m_hLastSeen);
		FINAL_TARGET += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, TARGET_DIST));
		TARGET_DIST /= 100;
		SetAngles("add_view.pitch");
		IS_ARROW = 1;
		TossProjectile(ARROW_TYPE, /* TODO: $relpos */ $relpos(0, 0, 18), "none", 900, DMG_BOW, ATTACK_CONE_OF_FIRE, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0.4);
		SetModelBody(3, 0);
		EmitSound(GetOwner(), 2, SOUND_BOW, 10);
		MELEE_ATK = 0;
	}

	void grab_arrow()
	{
		SetModelBody(3, 1);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(3, 0);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (GetEntityRange(m_hAttackTarget) >= KICK_RANGE)
		{
			ANIM_ATTACK = ANIM_BOW;
		}
		if (!(GetEntityRange(m_hAttackTarget) < KICK_RANGE)) return;
		if (!(GetGameTime() > NEXT_KICK)) return;
		if (!(ANIM_ATTACK == ANIM_BOW)) return;
		PlayAnim("once", "break");
		SetModelBody(3, 0);
		ANIM_ATTACK = ANIM_SWIPE;
	}

	void swing_sword()
	{
		ANIM_ATTACK = ANIM_KICK;
		EmitSound(GetOwner(), 0, SOUND_KICK, 10);
		ATTACK_PUSH = /* TODO: $relvel */ $relvel(-100, 130, 120);
		npcatk_dodamage(m_hAttackTarget, KICK_HITRANGE, DMG_SWIPE, KICK_HITCHANCE);
	}

	void kick_land()
	{
		ANIM_ATTACK = ANIM_SMASH;
		EmitSound(GetOwner(), 0, SOUND_KICK, 10);
		ATTACK_PUSH = /* TODO: $relvel */ $relvel(50, 130, 120);
		npcatk_dodamage(m_hAttackTarget, KICK_HITRANGE, DMG_KICK, KICK_HITCHANCE);
	}

	void swing_axe()
	{
		EmitSound(GetOwner(), 0, SOUND_KICK, 10);
		ATTACK_PUSH = /* TODO: $relvel */ $relvel(50, 130, 120);
		npcatk_dodamage(m_hAttackTarget, KICK_HITRANGE, DMG_SMASH, KICK_HITCHANCE);
		if (!(GetEntityRange(m_hAttackTarget) < KICK_HITRANGE)) return;
		if (!(RandomInt(1, 2) == 1)) return;
		ApplyEffect(GetEntityIndex(m_hAttackTarget), "effects/debuff_stun", 7, GetEntityIndex(GetOwner()));
		if (!(AM_TURRET))
		{
			npcatk_flee(m_hAttackTarget, 600, 2);
		}
		NEXT_KICK = GetGameTime();
		NEXT_KICK += FREQ_KICK;
	}

	void ext_arrow_hit()
	{
		if (!(param1))
		{
			ARROW_MISSED += 1;
		}
		if ((param1))
		{
			ARROW_MISSED = 0;
			AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 400, 110));
			ApplyEffect(param2, "effects/dot_cold", DOT_DUR, GetEntityIndex(GetOwner()), DOT_DMG);
		}
		if (!(ARROW_MISSED > 3)) return;
		change_position();
		ARROW_MISSED = 0;
	}

	void change_position()
	{
		if ((AM_TURRET)) return;
		PlayAnim("critical", ANIM_RUN);
		chicken_run(3);
	}

	void set_turret()
	{
		AM_TURRET = 1;
		SetMoveAnim(ANIM_IDLE);
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		NO_STUCK_CHECKS = 1;
		SetRoam(false);
	}

	void OnPostSpawn() override
	{
		if (!(AM_TURRET)) return;
		SetMoveAnim(ANIM_IDLE);
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		NO_STUCK_CHECKS = 1;
		SetRoam(false);
	}

}

}
