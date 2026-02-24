#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class VgoblinShaman : CGameScript
{
	string ANIM_ATTACK;
	string AS_ATTACKING;
	float ATTACK_HITCHANCE;
	int ATTACK_MOVERANGE;
	int CAN_FIREBALL;
	string CLOUD_SCRIPT;
	string DEATH_SCRIPT;
	int DMG_FIREBALL;
	int DMG_FIREBALL_DOT;
	int DMG_FIST;
	int DMG_NOVA;
	int DOT_FIST;
	int DOT_POISON;
	string FIST_SCRIPT;
	float FREQ_CLOUD;
	float FREQ_FIREBALL;
	float FREQ_NOVA;
	float FREQ_SUMMON;
	int GOB_CHARGER;
	int GOB_JUMPER;
	int GOB_JUMP_SCANNING;
	string LAST_EGG;
	int MOVE_RANGE;
	string MY_CL_SCRIPT_IDX;
	int NEW_MODEL;
	string NEXT_CLOUD;
	string NEXT_FIREBALL;
	string NEXT_NOVA;
	string NEXT_SUMMON;
	string NOVA_SCRIPT;
	int NO_DEATH_HORROR;
	int NPC_BASE_EXP;
	int POISON_FIST;
	string SOUND_FIREBALL;
	int SUMMON_ALIVE;
	string SUMMON_SCRIPT;
	int TOSS_FIREBALL;

	VgoblinShaman()
	{
		NEW_MODEL = 1;
		NPC_BASE_EXP = 800;
		GOB_JUMPER = 0;
		GOB_CHARGER = 0;
		DMG_FIST = 10;
		DMG_FIREBALL = 75;
		DOT_POISON = RandomInt(20, 40);
		CAN_FIREBALL = 1;
		FREQ_FIREBALL = 2.0;
		DMG_FIREBALL = 150;
		DMG_FIREBALL_DOT = 25;
		DMG_NOVA = 200;
		DOT_FIST = 50;
		FREQ_NOVA = 10.0;
		FREQ_CLOUD = Random(10.0, 20.0);
		FREQ_SUMMON = Random(10.0, 20.0);
		ATTACK_MOVERANGE = 800;
		MOVE_RANGE = 800;
		ATTACK_HITCHANCE = 0.75;
		ANIM_ATTACK = "swordswing1_L";
		SOUND_FIREBALL = "bullchicken/bc_attack2.wav";
		SUMMON_SCRIPT = "monsters/summon/horror_egg";
		DEATH_SCRIPT = "monsters/horror2";
		CLOUD_SCRIPT = "monsters/summon/npc_poison_cloud2";
		NOVA_SCRIPT = "monsters/summon/poison_burst";
		FIST_SCRIPT = "monsters/poison_fist_cl";
	}

	void game_precache()
	{
		Precache(SUMMON_SCRIPT);
		Precache(DEATH_SCRIPT);
		Precache(CLOUD_SCRIPT);
		Precache(NOVA_SCRIPT);
		Precache(FIST_SCRIPT);
	}

	void goblin_spawn()
	{
		SetName("Vile Goblin Poisoner");
		SetRace("goblin");
		SetBloodType("green");
		SetHealth(1000);
		SetWidth(32);
		SetHeight(60);
		SetRoam(true);
		SetHearingSensitivity(2);
		if (!(NEW_MODEL))
		{
			SetModel("monsters/goblin2.mdl");
			SetWidth(32);
			SetHeight(60);
			SetModelBody(0, 0);
			SetModelBody(1, 4);
			SetModelBody(2, 0);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 3);
		}
		else
		{
			SetModel("monsters/goblin_new.mdl");
			SetWidth(24);
			SetHeight(50);
			SetModelBody(0, 0);
			SetModelBody(1, 4);
			SetModelBody(2, 0);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 2);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("lightning", 1.5);
		ClientEvent("persist", "all", FIST_SCRIPT, GetEntityIndex(GetOwner()), 19);
		MY_CL_SCRIPT_IDX = "game.script.last_sent_id";
	}

	void toss_fireball()
	{
		TOSS_FIREBALL = 0;
		TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 48, 0), m_hAttackTarget, 400, DMG_FIREBALL, 0.5, "none");
		EmitSound(GetOwner(), 0, SOUND_FIREBALL, 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_CL_SCRIPT_IDX);
		if ((NO_DEATH_HORROR)) return;
		SpawnNPC(DEATH_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy);
		CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()), 5);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetEntityRange(m_hAttackTarget) < 96)
		{
			if (GetGameTime() > NEXT_NOVA)
			{
			}
			NEXT_NOVA = GetGameTime();
			EmitSound(GetOwner(), 0, SOUND_SHAM_ALERT, 10);
			PlayAnim("critical", ANIM_WARCRY);
			AS_ATTACKING = GetGameTime();
			NEXT_NOVA += FREQ_NOVA;
			do_nova();
		}
	}

	void do_nova()
	{
		SpawnNPC(NOVA_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 256, 1, DMG_NOVA, DOT_POISON
	}

	void swing_sword()
	{
		if ((TOSS_FIREBALL))
		{
			toss_fireball();
		}
		if ((TOSS_FIREBALL)) return;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		POISON_FIST = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_FIST, ATTACK_HITCHANCE, "blunt");
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((POISON_FIST))
			{
			}
			ApplyEffect(param2, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_FIST);
		}
		POISON_FIST = 0;
	}

	void gob_cycle_up()
	{
		NEXT_FIREBALL = GetGameTime();
		NEXT_FIREBALL += 3.0;
		NEXT_CLOUD = GetGameTime();
		NEXT_CLOUD += Random(5.0, 10.0);
		NEXT_SUMMON = GetGameTime();
		NEXT_SUMMON += Random(15.0, 20.0);
		if ((GOB_JUMP_SCANNING)) return;
		GOB_JUMP_SCANNING = 1;
		EmitSound(GetOwner(), 0, SOUND_SHAM_ALERT, 10);
	}

	void gob_hunt()
	{
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if ((SUSPEND_AI)) return;
		if ((IS_FLEEING)) return;
		if (GetGameTime() > NEXT_CLOUD)
		{
			if ((false))
			{
			}
			NEXT_CLOUD = GetGameTime();
			NEXT_CLOUD += FREQ_CLOUD;
			PlayAnim("critical", ANIM_WARCRY);
			npcatk_suspend_ai(1.5);
			EmitSound(GetOwner(), 0, SOUND_SHAM_ALERT, 10);
			string CLOUD_POS = GetEntityOrigin(m_hAttackTarget);
			if ((IsValidPlayer(m_hAttackTarget)))
			{
				CLOUD_POS += "z";
			}
			SpawnNPC(CLOUD_SCRIPT, CLOUD_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_FIREBALL_DOT, 10.0, 1
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SUMMON_ALIVE))
		{
			if (GetGameTime() > NEXT_SUMMON)
			{
			}
			NEXT_SUMMON = GetGameTime();
			NEXT_SUMMON += FREQ_SUMMON;
			PlayAnim("critical", ANIM_SMASH);
			AS_ATTACKING = GetGameTime();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((CAN_FIREBALL))
		{
			if (GetGameTime() > NEXT_FIREBALL)
			{
			}
			if (GetEntityRange(m_hAttackTarget) > MIN_FIREBALL_DIST)
			{
			}
			if ((false))
			{
			}
			NEXT_FIREBALL = GetGameTime();
			NEXT_FIREBALL += FREQ_FIREBALL;
			TOSS_FIREBALL = 1;
			PlayAnim("once", ANIM_SWIPE);
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 10.0;
			EmitSound(GetOwner(), 0, SOUND_FIREBALL_CAST, 10);
		}
		if ((false))
		{
			float STRUCK_CHECK = GetGameTime();
			STRUCK_CHECK -= 5.0;
			if (STRUCK_CHECK > LAST_STRUCK)
			{
				if (!(IS_FLEEING))
				{
				}
				SetMoveAnim(ANIM_IDLE);
				AS_ATTACKING = GetGameTime();
				AS_ATTACKING += 10.0;
			}
			else
			{
				SetMoveAnim(ANIM_RUN);
			}
		}
		else
		{
			SetMoveAnim(ANIM_RUN);
		}
	}

	void swing_axe()
	{
		summon_horror_egg();
	}

	void summon_horror_egg()
	{
		SUMMON_ALIVE = 1;
		SpawnNPC(SUMMON_SCRIPT, /* TODO: $relpos */ $relpos(0, 64, 16), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		LAST_EGG = GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.1, "boost_egg");
	}

	void boost_egg()
	{
		AddVelocity(LAST_EGG, /* TODO: $relvel */ $relvel(0, 130, 120));
	}

	void horror_died()
	{
		NEXT_SUMMON = GetGameTime();
		NEXT_SUMMON += FREQ_SUMMON;
		SUMMON_ALIVE = 0;
	}

	void no_death_event()
	{
		NO_DEATH_HORROR = 1;
	}

}

}
