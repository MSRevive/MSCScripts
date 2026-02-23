#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SlimeMagmaLarge : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string MOMMY_KILLER;
	int MOVE_RANGE;
	int NO_SPAWN_STUCK_CHECK;
	string NPC_DMG_MULTI;
	string NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	string NPC_HP_MULTI;
	int NPC_MUST_SEE_TARGET;

	SlimeMagmaLarge()
	{
		const string SOUND_DEATH = "monsters/sludge/bio.wav";
		const string SOUND_STRUCK1 = "barnacle/bcl_bite3.wav";
		const string SOUND_STRUCK2 = "barnacle/bcl_die3.wav";
		const string SOUND_IDLE = "barnacle/bcl_alert2.wav";
		const string SOUND_ATTACK1 = "barnacle/bcl_tongue1.wav";
		const string SOUND_ATTACK2 = "barnacle/bcl_chew3.wav";
		Precache(SOUND_DEATH);
		ANIM_IDLE = "walk";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		MOVE_RANGE = 30;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 120;
		const float ATTACK_HITCHANCE = 0.7;
		const string ATTACK_DAMAGE = Random(66, 99);
		NPC_MUST_SEE_TARGET = 0;
		const string CHILD_SCRIPT = "test_scripts/example_scripts/monsters/slime_magma_small";
		const int CHILD_DIST = 20;
		Precache("dwarvencave/slime_ecave.mdl");
		NO_SPAWN_STUCK_CHECK = 1;
	}

	void OnSpawn() override
	{
		SetName("Magma Pudding");
		SetHealth(840);
		SetWidth(40);
		SetHeight(44);
		SetModel("dwarvencave/slime_ecave.mdl");
		SetModelBody(0, 1);
		SetHearingSensitivity(7);
		SetRace("wildanimal");
		if ((ME_NO_WANDER))
		{
			SetRoam(true);
		}
		if (!(ME_NO_WANDER))
		{
			SetRoam(false);
		}
		NPC_GIVE_EXP = 840;
		ScheduleDelayedEvent(1.0, "slime_cycle");
		SetBloodType("red");
		SetSolid("none");
		SetDamageResistance("pierce", 0.25);
		SetDamageResistance("slash", 0.75);
		SetDamageResistance("blunt", 1.0);
		SetDamageResistance("cold", 1.2);
		SetDamageResistance("fire", 0);
		SetDamageResistance("stun", 0.15);
	}

	void bite1()
	{
		npcatk_dodamage(HUNT_LASTTARGET, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "fire");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		spawn_children();
	}

	void spawn_children()
	{
		string MY_KILLER = GetEntityIndex(m_hLastStruck);
		string CHILD_MOVE_DEST = GetMonsterProperty("origin");
		string LOC_OFFSET = /* TODO: $relpos */ $relpos(0, -20, 0);
		CHILD_MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, 45, 0), Vector3(0, 128, 0));
		CallExternal(GAME_MASTER, "gm_createnpc", 0.1, CHILD_SCRIPT, /* TODO: $relpos */ $relpos(0, -20, 0), CHILD_MOVE_DEST, MY_KILLER, NPC_DMG_MULTI, NPC_HP_MULTI);
		string CHILD_MOVE_DEST = GetMonsterProperty("origin");
		string LOC_OFFSET = /* TODO: $relpos */ $relpos(0, 20, 0);
		CHILD_MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, 135, 0), Vector3(0, 128, 0));
		CallExternal(GAME_MASTER, "gm_createnpc2", 0.2, CHILD_SCRIPT, LOC_OFFSET, CHILD_MOVE_DEST, MY_KILLER, NPC_DMG_MULTI, NPC_HP_MULTI);
		string CHILD_MOVE_DEST = GetMonsterProperty("origin");
		string LOC_OFFSET = /* TODO: $relpos */ $relpos(20, 0, 0);
		CHILD_MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, 225, 0), Vector3(0, 128, 0));
		CallExternal(GAME_MASTER, "gm_createnpc3", 0.3, CHILD_SCRIPT, LOC_OFFSET, CHILD_MOVE_DEST, MY_KILLER, NPC_DMG_MULTI, NPC_HP_MULTI);
		string CHILD_MOVE_DEST = GetMonsterProperty("origin");
		string LOC_OFFSET = /* TODO: $relpos */ $relpos(-20, 0, 0);
		CHILD_MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, 315, 0), Vector3(0, 128, 0));
		CallExternal(GAME_MASTER, "gm_createnpc4", 0.4, CHILD_SCRIPT, /* TODO: $relpos */ $relpos(-20, 0, 0), CHILD_MOVE_DEST, MY_KILLER, NPC_DMG_MULTI, NPC_HP_MULTI);
	}

	void slime_cycle()
	{
		if (m_hAttackTarget == "unset")
		{
			if (RandomInt(1, 10) == 1)
			{
			}
			EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		}
		if (m_hAttackTarget != "unset")
		{
			if (!(NO_COMBAT_REPOS))
			{
			}
			if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
			{
			}
			if (RandomInt(1, 3) == 1)
			{
			}
			string DEST_POS = GetEntityOrigin(m_hAttackTarget);
			npcatk_suspend_ai(1.0, "combat_reposition");
			NPC_FORCED_MOVEDEST = 1;
			string RND_ANG = RandomInt(0, 359);
			DEST_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, ATTACK_RANGE, 0));
			SetMoveDest(DEST_POS);
		}
		ScheduleDelayedEvent(2.0, "slime_cycle");
	}

	void game_dynamically_created()
	{
		MOMMY_KILLER = param2;
		npcatk_suspend_ai(0.5);
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.75, "avenge_mommy", param2);
		NPC_DMG_MULTI = param3;
		NPC_HP_MULTI = param4;
		if (NPC_DMG_MULTI > 0)
		{
			SetDamageMultiplier(param4);
		}
	}

	void avenge_mommy()
	{
		npcatk_settarget(MOMMY_KILLER, "he_killed_mommy!");
	}

	void cycle_up()
	{
		if ((ME_NO_WANDER))
		{
			SetRoam(true);
		}
	}

}

}
