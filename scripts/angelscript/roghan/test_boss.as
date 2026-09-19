#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class TestBoss : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SMASH;
	string ANIM_SWING;
	string ANIM_WALK;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BOB_UP;
	int DMG_SMASH;
	int DMG_SWING;
	int MAX_SPIRITS;
	string MONSTER_MODEL;
	int MOVE_RANGE;
	int PHASE_NUM;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int SPIRIT_SIDE;
	int SUM_SPIRITS;

	TestBoss()
	{
		ANIM_ATTACK = "attack1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		MOVE_RANGE = 64;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 120;
		SOUND_DEATH = "voices/orc/die.wav";
		Precache(SOUND_DEATH);
		ANIM_SWING = "swordswing1_L";
		ANIM_SMASH = "battleaxe_swing1_L";
		DMG_SWING = RandomInt(20, 40);
		DMG_SMASH = RandomInt(30, 50);
		ATTACK_HITCHANCE = 80;
		SOUND_ATTACK1 = "voices/orc/attack.wav";
		SOUND_ATTACK2 = "voices/orc/attack2.wav";
		SOUND_ATTACK3 = "voices/orc/attack3.wav";
		SOUND_STRUCK1 = "body/armour1.wav";
		SOUND_STRUCK2 = "body/armour2.wav";
		SOUND_STRUCK3 = "body/armour3.wav";
		SOUND_PAIN = "monsters/orc/pain.wav";
		MONSTER_MODEL = "monsters/Orc.mdl";
		Precache(MONSTER_MODEL);
		Precache("nimble/crystal.mdl");
		Precache("npc/balancepriest1.mdl");
	}

	void OnSpawn() override
	{
		SetName("Elemental Master");
		SetRace("evil");
		SetHealth(1000);
		SetModel(MONSTER_MODEL);
		SetWidth(32);
		SetHeight(72);
		SetSayTextRange(10000);
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		SetDamageResistance("all", 0.7);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("cold", 0.25);
		SetInvincible(true);
		MAX_SPIRITS = 6;
		SUM_SPIRITS = 0;
		PHASE_NUM = 1;
		SPIRIT_SIDE = 1;
		BOB_UP = 0;
		SpawnNPC("roghan/test_npc", /* TODO: $relpos */ $relpos(45, -1000, 0), ScriptMode::Legacy);
		SetAngles("face");
		npcatk_suspend_ai();
	}

	void OnDamage(int damage) override
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN2
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void swing_sword()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, ATTACK_HITCHANCE, "slash");
	}

	void swing_axe()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SMASH, ATTACK_HITCHANCE, "slash");
	}

	void begin_float()
	{
		npcatk_suspend_ai();
		PlayAnim("once", "break");
		npcatk_clear_targets();
		SetGravity(0);
		SpawnNPC("roghan/crystal", /* TODO: $relpos */ $relpos(0, -150, 0), ScriptMode::Legacy);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 100));
		ScheduleDelayedEvent(2.0, "bob_float");
		ScheduleDelayedEvent(1.0, "phase_choose");
	}

	void bob_float()
	{
		if (BOB_UP == 0)
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 5));
			BOB_UP += 1;
		}
		else
		{
			SetVelocity(GetOwner(), Vector3(0, 0, -2.5));
			BOB_UP = 0;
		}
		if (PHASE_NUM == 1)
		{
			ScheduleDelayedEvent(3, "bob_float");
		}
		else
		{
			SetGravity(1);
		}
	}

	void phase_choose()
	{
		if (PHASE_NUM == 1)
		{
			SayText("Fools! Now feel the power of my Ice Spirits!");
			spirit_summon();
			ice_pulse();
		}
	}

	void spirit_summon()
	{
		if (SUM_SPIRITS < MAX_SPIRITS)
		{
			if (SPIRIT_SIDE == 1)
			{
				SpawnNPC("roghan/slow_walk", /* TODO: $relpos */ $relpos(150, 0, 0), ScriptMode::Legacy);
				SPIRIT_SIDE = 0;
				SUM_SPIRITS += 1;
				ScheduleDelayedEvent(5.0, "spirit_summon");
			}
			else
			{
				SpawnNPC("roghan/slow_walk", /* TODO: $relpos */ $relpos(-150, 0, 0), ScriptMode::Legacy);
				SPIRIT_SIDE = 1;
				SUM_SPIRITS += 1;
				ScheduleDelayedEvent(5.0, "spirit_summon");
			}
		}
		else
		{
			PHASE_NUM += 1;
		}
	}

	void ice_pulse()
	{
		string MY_POS = GetEntityOrigin(GetOwner());
		if (PHASE_NUM == 1)
		{
			XDoDamage(MY_POS, 100000, ".5", 0, GetOwner(), GetOwner(), "none", "cold_effect");
			ScheduleDelayedEvent(3.0, "ice_pulse");
		}
	}

}

}
