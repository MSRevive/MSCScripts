#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class HobgoblinArcher : CGameScript
{
	string ANIM_ATTACK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FIREBALL;
	int CAN_STUN;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	int KICK_ATTACK;
	int MOVE_RANGE;
	string NEXT_KICK;
	int NPC_RANGED;

	HobgoblinArcher()
	{
		const int NPC_BASE_EXP = 150;
		const string SOUND_ATTACK1 = "monsters/goblin/c_gargoyle_atk1.wav";
		const string SOUND_ATTACK2 = "monsters/goblin/c_gargoyle_atk2.wav";
		const string SOUND_ATTACK3 = "monsters/goblin/c_gargoyle_atk3.wav";
		const string SOUND_BREATH = "monsters/goblin/sps_fogfire.wav";
		const int STEP_SIZE_NORM = 36;
		const string SOUND_BOW = "weapons/bow/bow.wav";
		CAN_STUN = 0;
		const int GOB_JUMPER = 0;
		const int GOB_CHARGER = 0;
		const string DMG_BOW = RandomInt(75, 150);
		const string DMG_KICK = RandomInt(10, 20);
		const int KICK_RANGE = 128;
		const int KICK_HITCHANCE = 90;
		const float FREQ_KICK = 10.0;
		CAN_FIREBALL = 0;
		NPC_RANGED = 1;
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_jagged";
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(20, 40);
		ANIM_ATTACK = "shootorcbow";
		const string DMG_AXE = RandomInt(40, 75);
		const int DMG_CHARGE = 50;
		ATTACK_HITCHANCE = 0.95;
		const string SOUND_DEATH = "monsters/goblin/c_goblin_dead.wav";
		Precache(SOUND_DEATH);
	}

	void goblin_spawn()
	{
		SetName("Hobgoblin Ranger");
		SetRace("goblin");
		SetBloodType("red");
		SetHealth(500);
		SetRoam(true);
		SetAnimFrameRate(1.5);
		SetHearingSensitivity(4);
		SetModel("monsters/goblin_new_boss.mdl");
		SetWidth(32);
		SetHeight(72);
		SetModelBody(0, 1);
		SetModelBody(1, 1);
		SetModelBody(2, 4);
		SetModelBody(3, 0);
		SetProp(GetOwner(), "skin", 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(0.01, "gob_extras");
	}

	void gob_extras()
	{
		MOVE_RANGE = 2000;
		ATTACK_RANGE = 2000;
		ATTACK_HITRANGE = 2000;
		DROP_GOLD_AMT = RandomInt(30, 50);
	}

	void grab_arrow()
	{
		SetModelBody(3, 1);
	}

	void shoot_arrow()
	{
		string TARGET_DIST = GetEntityRange(m_hLastSeen);
		string FINAL_TARGET = GetEntityOrigin(m_hLastSeen);
		FINAL_TARGET += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, TARGET_DIST));
		TARGET_DIST /= 100;
		SetAngles("add_view.pitch");
		TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, -4), "none", 900, DMG_BOW, 2, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0.4);
		SetModelBody(3, 0);
		EmitSound(GetOwner(), SOUND_BOW);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(3, 0);
	}

	void gob_hunt()
	{
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (!(GetEntityRange(m_hAttackTarget) < KICK_RANGE)) return;
		if (!(GetGameTime() > NEXT_KICK)) return;
		NEXT_KICK = GetGameTime();
		PlayAnim("once", "break");
		SetModelBody(3, 0);
		NEXT_KICK += FREQ_KICK;
		ANIM_ATTACK = ANIM_KICK;
	}

	void kick_land()
	{
		EmitSound(GetOwner(), 0, SOUND_BOW, 10);
		KICK_ATTACK = 1;
		DoDamage(m_hAttackTarget, KICK_RANGE, DMG_KICK, KICK_HITCHANCE, "blunt");
		ANIM_ATTACK = ANIM_BOW;
		npcatk_flee(m_hAttackTarget, 1024, 3.0);
	}

	void OnFlee()
	{
		SetMoveSpeed(2.0);
	}

	void npcatk_stopflee()
	{
		SetMoveSpeed(1.0);
	}

	void game_dodamage()
	{
		if ((KICK_ATTACK))
		{
			if ((param1))
			{
			}
			if (GetEntityRange(param2) < KICK_RANGE)
			{
			}
			ApplyEffect(param2, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
		}
		KICK_ATTACK = 0;
	}

}

}
