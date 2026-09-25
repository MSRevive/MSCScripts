#pragma context server

#include "monsters/elf_wizard_base.as"

namespace MS
{

class TelfNecro : CGameScript
{
	string ANIM_ATTACK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BARRIER_ON;
	int BARRIER_RAD;
	string BARRIER_TARGS;
	int CYCLES_ON;
	int DMG_BARRIER;
	int ELF_BEAM_ATTACK;
	string ELF_BEAM_COLOR;
	int ELF_BEAM_DMG;
	string ELF_BEAM_DMG_TYPE;
	int ELF_BEAM_DOT;
	float ELF_BEAM_DUR;
	string ELF_BEAM_EFFECT;
	string ELF_BEAM_PUSH_VEL;
	int ELF_BEAM_RANGE;
	float FREQ_BARRIER;
	float FREQ_BEAM_CHANGE;
	string NEXT_BARRIER;
	string NExT_BEAM_CHANGE;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int NPC_RETURN_HOME;
	float RETALIATE_CHANCE;
	string SOUND_BARRIER_RAISE;
	string SOUND_BARRIER_REPELL;
	string SOUND_BEAM_LOOP_FROST;
	string SOUND_BEAM_LOOP_HOLD;
	string SOUND_BEAM_LOOP_LIGHTNING;

	TelfNecro()
	{
		FREQ_BARRIER = 30.0;
		DMG_BARRIER = 200;
		BARRIER_RAD = 96;
		FREQ_BEAM_CHANGE = Random(10.0, 20.0);
		ELF_BEAM_RANGE = 1024;
		RETALIATE_CHANCE = 0.1;
		if (StringToLower(GetMapName()) == "the_wall")
		{
			NPC_GIVE_EXP = 15000;
			NPC_IS_BOSS = 1;
		}
		else
		{
			NPC_GIVE_EXP = 5000;
		}
		NPC_RETURN_HOME = 1;
		SOUND_BEAM_LOOP_HOLD = "ambience/dronemachine1.wav";
		SOUND_BEAM_LOOP_LIGHTNING = "magic/bolt_loop.wav";
		SOUND_BEAM_LOOP_FROST = "magic/freezeray_loop.wav";
		SOUND_BARRIER_RAISE = "magic/spawn.wav";
		SOUND_BARRIER_REPELL = "doors/aliendoor3.wav";
	}

	void game_precache()
	{
		Precache(SOUND_BEAM_LOOP_HOLD);
		Precache(SOUND_BEAM_LOOP_LIGHTNING);
		Precache(SOUND_BEAM_LOOP_FROST);
	}

	void elf_spawn()
	{
		GiveItem(GetOwner(), "item_telfh4");
		SetName("Ihotohr");
		SetHealth(10000);
		SetRace("necro");
		SetDamageResistance("all", 0.5);
		SetDamageResistance("holy", 1.0);
		SetSayTextRange(2048);
		SetModelBody(1, 1);
		SetProp(GetOwner(), "skin", 5);
	}

	void OnPostSpawn() override
	{
		ELF_BEAM_DMG = 300;
		ELF_BEAM_DOT = 100;
		ELF_BEAM_DMG_TYPE = "lightning";
		ELF_BEAM_PUSH_VEL = /* TODO: $relvel */ $relvel(0, 300, 110);
		ELF_BEAM_DUR = 5.0;
		ELF_BEAM_ATTACK = 1;
		ELF_BEAM_COLOR = Vector3(255, 255, 0);
		ELF_BEAM_EFFECT = "effects/dot_lightning";
		ANIM_ATTACK = "ref_shoot_crowbar";
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 120;
		ATTACK_MOVERANGE = 512;
	}

	void cycle_up()
	{
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		SayText("Ah , fresh corpses...");
		PlayAnim("critical", "ref_shoot_trip");
		UseTrigger("spawn_aod");
		AS_ATTACKING = GetGameTime();
		float GAME_TIME = GetGameTime();
		NEXT_BARRIER = GAME_TIME;
		NEXT_BARRIER += FREQ_BARRIER;
		NExT_BEAM_CHANGE = GAME_TIME;
		NEXT_BEAM_CHANGE += FREQ_BEAM_CHANGE;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		float GAME_TIME = GetGameTime();
		if (GAME_TIME > NEXT_BEAM_CHANGE)
		{
			if (!(ELF_BEAM_ON))
			{
			}
			RND_BEAM += 1;
			if (RND_BEAM > 3)
			{
				RND_BEAM = 1;
			}
			if (RND_BEAM == 1)
			{
				ELF_BEAM_COLOR = Vector3(255, 255, 0);
				ELF_BEAM_SPECIAL = "none";
				ELF_BEAM_DMG_TYPE = "lightning";
				ELF_BEAM_EFFECT = "effects/dot_lightning";
				ELF_BEAM_PUSH_VEL = /* TODO: $relvel */ $relvel(0, 400, 110);
				ELF_BEAM_DMG = 300;
				ELF_BEAM_DOT = 100;
				SOUND_ELF_BEAM_LOOP = SOUND_BEAM_LOOP_LIGHTNING;
			}
			if (RND_BEAM == 2)
			{
				ELF_BEAM_COLOR = Vector3(128, 128, 255);
				ELF_BEAM_SPECIAL = "none";
				ELF_BEAM_DMG_TYPE = "cold";
				ELF_BEAM_EFFECT = "effects/dot_cold";
				ELF_BEAM_PUSH_VEL = /* TODO: $relvel */ $relvel(0, 400, 110);
				ELF_BEAM_DMG = 100;
				ELF_BEAM_DOT = 50;
				SOUND_ELF_BEAM_LOOP = SOUND_BEAM_LOOP_FROST;
			}
			if (RND_BEAM == 3)
			{
				ELF_BEAM_COLOR = Vector3(255, 0, 0);
				ELF_BEAM_SPECIAL = "hold_person";
				ELF_BEAM_DMG_TYPE = "magic";
				ELF_BEAM_EFFECT = "effects/debuff_hold";
				ELF_BEAM_PUSH_VEL = /* TODO: $relvel */ $relvel(0, 0, 0);
				ELF_BEAM_DMG = 50;
				ELF_BEAM_DOT = 0;
				SOUND_ELF_BEAM_LOOP = SOUND_BEAM_LOOP_HOLD;
			}
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GAME_TIME > NEXT_BARRIER)) return;
		NEXT_BARRIER = GAME_TIME;
		NEXT_BARRIER += FREQ_BARRIER;
		do_barrier();
	}

	void elf_beam_special()
	{
		ApplyEffect(param1, "effects/debuff_hold", 10.0);
	}

	void do_barrier()
	{
		EmitSound(GetOwner(), 0, SOUND_BARRIER_RAISE, 10);
		SetModelBody(2, 1);
		BARRIER_ON = 1;
		ScheduleDelayedEvent(20.0, "end_barrier");
		barrier_loop();
	}

	void end_barrier()
	{
		BARRIER_ON = 0;
		SetModelBody(2, 0);
		EmitSound(GetOwner(), 0, SOUND_BARRIER_RAISE, 10);
	}

	void barrier_loop()
	{
		if (!(BARRIER_ON)) return;
		ScheduleDelayedEvent(0.5, "barrier_loop");
		BARRIER_TARGS = FindEntitiesInSphere("enemy", BARRIER_RAD);
		if (!(BARRIER_TARGS != "none")) return;
		EmitSound(GetOwner(), 0, SOUND_BARRIER_REPELL, 10);
		for (int i = 0; i < GetTokenCount(BARRIER_TARGS, ";"); i++)
		{
			barrier_affect_targets();
		}
	}

	void barrier_affect_targets()
	{
		string CUR_TARG = GetToken(BARRIER_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
		DoDamage(CUR_TARG, "direct", DMG_BARRIER, 1.0, GetOwner());
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SayText("Death... Awaits you... Beyond the door...");
		SetModelBody(2, 0);
	}

}

}
