#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class BgoblinShaman : CGameScript
{
	string ANIM_ATTACK;
	string AS_ATTACKING;
	float ATTACK_HITCHANCE;
	int ATTACK_MOVERANGE;
	int CAN_FIREBALL;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	int FLAME_FIST;
	int GOB_JUMP_SCANNING;
	string LAST_STRUCK;
	int MOVE_RANGE;
	string MY_CL_SCRIPT_IDX;
	string NEXT_FIREBALL;
	string NEXT_FIREWALL;
	string NEXT_FLEE;
	string NEXT_SUMMON;
	int NO_DEATH_EVENT;
	int NO_SUMMONS;
	int SUMMON_ALIVE;
	string SUMMON_POS;
	string TOSS_FIREBALL;

	BgoblinShaman()
	{
		const int NEW_MODEL = 1;
		const int GOB_JUMPER = 0;
		const int GOB_CHARGER = 0;
		CAN_FIREBALL = 1;
		const float FREQ_FIREBALL = 3.0;
		const int DMG_FIREBALL = 150;
		const int DMG_FIREBALL_DOT = 25;
		const float FREQ_FIREBALL = 20.0;
		const int DMG_FIST = 10;
		const int DOT_FIST = 50;
		const int DMG_FIREWALL = 100;
		ATTACK_HITCHANCE = 0.75;
		const int NPC_BASE_EXP = 800;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(50, 75);
		ATTACK_MOVERANGE = 800;
		MOVE_RANGE = 800;
		const float FREQ_FLEE = 20.0;
		const float FREQ_FIREWALL = 18.0;
		const float FREQ_SUMMON = 15.0;
		const int MIN_FIREBALL_DIST = 70;
		const string FIRE_FIST_SCRIPT = "monsters/fire_fist_cl";
		ANIM_ATTACK = "swordswing1_L";
		const string SUMMON_SCRIPT = "monsters/elemental_fire1";
		const string DEATH_SCRIPT = "monsters/elemental_fire2";
		const string FIREWALL_SCRIPT = "traps/fire_wall2";
	}

	void goblin_spawn()
	{
		SetName("Blood Goblin Evoker");
		SetRace("goblin");
		SetBloodType("red");
		SetHealth(800);
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
			SetProp(GetOwner(), "skin", 2);
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
			SetProp(GetOwner(), "skin", 1);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		ClientEvent("persist", "all", FIRE_FIST_SCRIPT, GetEntityIndex(GetOwner()), 19);
		MY_CL_SCRIPT_IDX = "game.script.last_sent_id";
		Precache("ambience/burning2.wav");
	}

	void game_precache()
	{
		Precache(SUMMON_SCRIPT);
		Precache(DEATH_SCRIPT);
		Precache(FIREWALL_SCRIPT);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_CL_SCRIPT_IDX);
		if ((NO_DEATH_EVENT)) return;
		SpawnNPC(DEATH_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy);
		CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()), 5);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		LAST_STRUCK = GetGameTime();
		if (GetEntityRange(m_hAttackTarget) < 96)
		{
			if (GetGameTime() > NEXT_FLEE)
			{
			}
			NEXT_FLEE = GetGameTime();
			NEXT_FLEE += FREQ_FLEE;
			SetMoveAnim(ANIM_RUN);
			SetMoveSpeed(2.0);
			ScheduleDelayedEvent(5.0, "reset_move_speed");
			npcatk_flee(/* TODO: $get with insufficient args */ null, 5.0);
		}
	}

	void reset_move_speed()
	{
		SetMoveSpeed(1.0);
	}

	void swing_sword()
	{
		if ((TOSS_FIREBALL))
		{
			TOSS_FIREBALL = 0;
			TossProjectile("proj_fire_ball", /* TODO: $relpos */ $relpos(0, 48, 0), m_hAttackTarget, 400, DMG_FIREBALL, 0.5, "none");
			CallExternal("ent_lastprojectile", "lighten", DMG_FIREBALL_DOT, 0.01);
			EmitSound(GetOwner(), 0, SOUND_FIREBALL, 10);
		}
		if ((TOSS_FIREBALL)) return;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		FLAME_FIST = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_FIST, ATTACK_HITCHANCE, "blunt");
	}

	void gob_cycle_up()
	{
		NEXT_FIREBALL = GetGameTime();
		NEXT_FIREBALL += 3.0;
		NEXT_FIREWALL = GetGameTime();
		NEXT_FIREWALL += Random(5.0, 10.0);
		NEXT_SUMMON = GetGameTime();
		NEXT_SUMMON += Random(15.0, 20.0);
		if ((GOB_JUMP_SCANNING)) return;
		GOB_JUMP_SCANNING = 1;
		EmitSound(GetOwner(), 0, SOUND_SHAM_ALERT, 10);
		gob_jump_check();
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((FLAME_FIST))
			{
			}
			ApplyEffect(param2, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DOT_FIST);
			FLAME_FIST = 0;
		}
	}

	void gob_hunt()
	{
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if ((SUSPEND_AI)) return;
		if ((IS_FLEEING)) return;
		if (GetGameTime() > NEXT_FIREWALL)
		{
			if ((false))
			{
			}
			NEXT_FIREWALL = GetGameTime();
			NEXT_FIREWALL += FREQ_FIREWALL;
			PlayAnim("critical", ANIM_WARCRY);
			npcatk_suspend_ai(1.5);
			EmitSound(GetOwner(), 0, SOUND_SHAM_ALERT, 10);
			string FIREWALL_POS = GetEntityOrigin(m_hAttackTarget);
			string FIREWALL_OFS = RandomInt(1, 4);
			if (FIREWALL_OFS == 1)
			{
				FIREWALL_POS += "x";
			}
			if (FIREWALL_OFS == 2)
			{
				FIREWALL_POS += "y";
			}
			if (FIREWALL_OFS == 3)
			{
				FIREWALL_POS += "x";
			}
			if (FIREWALL_OFS == 4)
			{
				FIREWALL_POS += "y";
			}
			SpawnNPC(FIREWALL_SCRIPT, FIREWALL_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(m_hAttackTarget, "angles.y"), DMG_FIREWALL
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SUMMON_ALIVE))
		{
			if (!(NO_SUMMONS))
			{
			}
			if (GetGameTime() > NEXT_SUMMON)
			{
			}
			if (GetEntityRange(m_hAttackTarget) < 1024)
			{
			}
			NEXT_SUMMON = GetGameTime();
			NEXT_SUMMON += FREQ_SUMMON;
			PlayAnim("critical", ANIM_WARCRY);
			npcatk_suspend_ai(1.5);
			EmitSound(GetOwner(), 0, SOUND_SHAM_ALERT, 10);
			SUMMON_POS = GetEntityOrigin(m_hAttackTarget);
			if ((IsValidPlayer(m_hAttackTarget)))
			{
				SUMMON_POS += "z";
			}
			AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(-120, 500, 200));
			ScheduleDelayedEvent(0.2, "summon_elemental");
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
			PlayAnim("critical", ANIM_SWIPE);
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 10.0;
			EmitSound(GetOwner(), 0, SOUND_FIREBALL_CAST, 10);
		}
		if ((false))
		{
			string STRUCK_CHECK = GetGameTime();
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

	void summon_elemental()
	{
		SUMMON_ALIVE = 1;
		SpawnNPC(SUMMON_SCRIPT, SUMMON_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
	}

	void elemental_died()
	{
		NEXT_SUMMON = GetGameTime();
		NEXT_SUMMON += FREQ_SUMMON;
		SUMMON_ALIVE = 0;
	}

	void set_no_summons()
	{
		NO_SUMMONS = 1;
	}

	void no_death_event()
	{
		NO_DEATH_EVENT = 1;
	}

}

}
