#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/sorc_base.as"

namespace MS
{

class SorcWarriorLesser : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_AXE;
	string ANIM_KICK;
	string ANIM_SWORD;
	string AS_ATTACKING;
	float ATTACK_ACCURACY;
	float CHANCE_KICK;
	float CHANCE_SHOCK;
	int DMG_KICK;
	int DMG_SWORD;
	int DMG_THROW;
	float DOT_SHOCK;
	float DOT_THROW_SHOCK;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	float FREQ_KICK;
	float FREQ_THROW;
	int KICK_ATTACK;
	string KICK_DELAY;
	string MY_AXE;
	int NPC_GIVE_EXP;
	int ORC_JUMPER;
	float SORC_LRESIST;
	float SORC_PRESIST;
	string SOUND_SHOCK1;
	string SOUND_SHOCK2;
	string SOUND_SHOCK3;
	int THROWING_AXE;
	int THROW_DELAY;

	SorcWarriorLesser()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(20, 46);
		DMG_THROW = 25;
		NPC_GIVE_EXP = 175;
		ANIM_SWORD = "swordswing1_L";
		ANIM_AXE = "battleaxe_swing1_L";
		FLINCH_CHANCE = 0.25;
		ANIM_ATTACK = "battleaxe_swing1_L";
		ATTACK_ACCURACY = 0.8;
		DMG_SWORD = RandomInt(50, 100);
		DOT_THROW_SHOCK = 40.0;
		DOT_SHOCK = 15.0;
		DMG_KICK = RandomInt(20, 50);
		ANIM_KICK = "kick";
		SOUND_SHOCK1 = "debris/zap8.wav";
		SOUND_SHOCK2 = "debris/zap3.wav";
		SOUND_SHOCK3 = "debris/zap4.wav";
		ORC_JUMPER = 1;
		CHANCE_SHOCK = 0.1;
		CHANCE_KICK = 0.3;
		FREQ_KICK = Random(5, 15);
		FREQ_THROW = Random(7, 15);
		SORC_LRESIST = 0.85;
		SORC_PRESIST = 1.1;
	}

	void orc_spawn()
	{
		SetName("Shadahar Warrior");
		SetModel("monsters/sorc.mdl");
		SetHealth(1000);
		SetDamageResistance("all", 0.7);
		SetStat("parry", 110);
		SetWidth(32);
		SetHeight(96);
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 7);
	}

	void swing_axe()
	{
		baseorc_yell();
		npcatk_dodamage(m_hLastSeen, ATTACK_HITRANGE, DMG_SWORD, ATTACK_ACCURACY, "slash");
		if (RandomInt(1, 100) < CHANCE_SHOCK)
		{
			if (!(THROWING_AXE))
			{
			}
			ApplyEffect(m_hAttackTarget, "effects/dot_lightning", 3, GetEntityIndex(GetOwner()), DOT_SHOCK);
			// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
			array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			LogDebug("temp me glow");
			Effect("glow", GetOwner(), Vector3(255, 255, 0), 128, 1, 1);
		}
		if (RandomInt(1, 100) < CHANCE_KICK)
		{
			if (!(THROWING_AXE))
			{
			}
			if (!(KICK_DELAY))
			{
			}
			KICK_DELAY = 1;
			FREQ_KICK("reset_kick_delay");
			ANIM_ATTACK = ANIM_KICK;
		}
		if (!(THROWING_AXE)) return;
		SetAnimFrameRate(0.00001);
	}

	void reset_kick_delay()
	{
		KICK_DELAY = 0;
	}

	void kick_land()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KICK, ATTACK_ACCURACY, "blunt");
		KICK_ATTACK = 1;
		ANIM_ATTACK = ANIM_AXE;
	}

	void npc_targetsighted()
	{
		if ((I_R_FROZEN)) return;
		if ((THROW_DELAY)) return;
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)) return;
		THROW_DELAY = 1;
		throw_axe(m_hAttackTarget);
	}

	void reset_throw_delay()
	{
		THROW_DELAY = 0;
	}

	void throw_axe()
	{
		AS_ATTACKING = GetGameTime();
		THROWING_AXE = 1;
		npcatk_suspend_ai();
		SetIdleAnim(ANIM_SWORD);
		SetMoveAnim(ANIM_SWORD);
		SetRoam(false);
		PlayAnim("once", "break");
		PlayAnim("hold", ANIM_SWORD);
		ScheduleDelayedEvent(0.5, "throw_axe2");
	}

	void throw_axe2()
	{
		SetModelBody(2, 0);
		string TARG_DEST = GetEntityOrigin(m_hAttackTarget);
		TARG_DEST += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 128, 0));
		if (!(IsValidPlayer(m_hAttackTarget)))
		{
			TARG_DEST += "z";
		}
		SpawnNPC("monsters/summon/sorc_axe", /* TODO: $relpos */ $relpos(0, 40, 5), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), TARG_DEST, DMG_THROW
		MY_AXE = GetEntityIndex(m_hLastCreated);
		throw_axe_loop();
	}

	void throw_axe_loop()
	{
		if (!(THROWING_AXE)) return;
		SetMoveDest(MY_AXE);
		ScheduleDelayedEvent(0.1, "throw_axe_loop");
	}

	void catch_axe()
	{
		npcatk_resume_ai();
		PlayAnim("once", "break");
		SetRoam(true);
		THROWING_AXE = 0;
		SetModelBody(2, 7);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		FREQ_THROW("reset_throw_delay");
		SetAnimFrameRate(1.0);
	}

	void game_dodamage()
	{
		if ((KICK_ATTACK))
		{
			KICK_ATTACK = 0;
			if ((param1))
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 200, 30));
			int NO_ATK = RandomInt(0, 1);
			ApplyEffect(param2, "effects/debuff_stun", RandomInt(2, 5), GetEntityIndex(GetOwner()));
		}
		if (!(THROWING_AXE)) return;
		string HIT_TARG = param2;
		CallExternal(MY_AXE, "do_shock", HIT_TARG, DOT_THROW_SHOCK);
	}

}

}
