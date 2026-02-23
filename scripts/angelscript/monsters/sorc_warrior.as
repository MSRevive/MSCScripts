#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/sorc_base.as"

namespace MS
{

class SorcWarrior : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_AXE;
	string ANIM_SWORD;
	string AS_ATTACKING;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	int KICK_ATTACK;
	string KICK_DELAY;
	string MY_AXE;
	int NPC_GIVE_EXP;
	int ORC_JUMPER;
	int THROWING_AXE;
	int THROW_DELAY;

	SorcWarrior()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(20, 80);
		const int DMG_THROW = 25;
		NPC_GIVE_EXP = 300;
		ANIM_SWORD = "swordswing1_L";
		ANIM_AXE = "battleaxe_swing1_L";
		FLINCH_CHANCE = 0.25;
		ANIM_ATTACK = "battleaxe_swing1_L";
		const float ATTACK_ACCURACY = 0.8;
		const string DMG_SWORD = RandomInt(50, 200);
		const float DOT_THROW_SHOCK = 40.0;
		const float DOT_SHOCK = 15.0;
		const string DMG_KICK = RandomInt(20, 50);
		const string ANIM_KICK = "kick";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
		ORC_JUMPER = 1;
		const float CHANCE_SHOCK = 0.1;
		const float CHANCE_KICK = 0.3;
		const string FREQ_KICK = Random(5, 15);
		const string FREQ_THROW = Random(7, 15);
		const float SORC_LRESIST = 0.65;
		const float SORC_PRESIST = 1.15;
	}

	void orc_spawn()
	{
		SetName("Shadahar Warrior");
		SetModel("monsters/sorc.mdl");
		SetHealth(2000);
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
			string NO_ATK = RandomInt(0, 1);
			ApplyEffect(param2, "effects/debuff_stun", RandomInt(2, 5), GetEntityIndex(GetOwner()));
		}
		if (!(THROWING_AXE)) return;
		string HIT_TARG = param2;
		CallExternal(MY_AXE, "do_shock", HIT_TARG, DOT_THROW_SHOCK);
	}

}

}
