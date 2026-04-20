#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/sorc_base.as"

namespace MS
{

class SorcGuard : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	string ANIM_ATTACK2;
	float ATTACK_ACCURACY;
	int DID_LEAPSTUN;
	int DMG_SWORD;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	float FREQ_LUNGE;
	int LEAPING;
	string LEAP_END;
	string LEAP_TARGET;
	int LUNGE_DELAY;
	int LUNGE_RANGE;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int ORC_JUMPER;

	SorcGuard()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 30);
		NPC_GIVE_EXP = 250;
		ANIM_ATTACK1 = "swordswing1_L";
		ANIM_ATTACK2 = "battleaxe_swing1_L";
		FLINCH_CHANCE = 0.25;
		ANIM_ATTACK = ANIM_ATTACK1;
		ATTACK_ACCURACY = 0.7;
		DMG_SWORD = RandomInt(30, 150);
		ORC_JUMPER = 1;
		FREQ_LUNGE = 10.0;
		LUNGE_RANGE = 256;
	}

	void orc_spawn()
	{
		SetName("Shadahar Guard");
		SetModel("monsters/sorc.mdl");
		SetHealth(1000);
		SetDamageResistance("all", 0.7);
		SetStat("parry", 110);
		SetRace("orc");
		SetWidth(32);
		SetHeight(96);
		SetModelBody(0, 2);
		SetModelBody(1, 0);
		SetModelBody(2, 6);
	}

	void swing_axe()
	{
		baseorc_yell();
		npcatk_dodamage(m_hLastSeen, ATTACK_HITRANGE, DMG_SWORD, ATTACK_ACCURACY);
	}

	void npc_targetsighted()
	{
		if ((I_R_FROZEN)) return;
		if ((LUNGE_DELAY)) return;
		if (!(GetEntityRange(m_hAttackTarget) < LUNGE_RANGE)) return;
		LUNGE_DELAY = 1;
		FREQ_LUNGE("reset_lunge_delay");
		leap_at(m_hAttackTarget);
	}

	void reset_lunge_delay()
	{
		LUNGE_DELAY = 0;
	}

	void leap_at()
	{
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		LEAP_TARGET = param1;
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "leap_at2");
		DID_LEAPSTUN = 0;
		LEAPING = 1;
		LEAP_END = GetGameTime();
		LEAP_END += 1;
		leap_scan();
	}

	void leap_scan()
	{
		if (!(GetGameTime() < LEAP_END)) return;
		ScheduleDelayedEvent(0.1, "leap_scan");
		if (!(GetEntityRange(LEAP_TARGET) < ATTACK_RANGE)) return;
		AddVelocity(LEAP_TARGET, /* TODO: $relvel */ $relvel(0, 120, 105));
		if ((DID_LEAPSTUN)) return;
		DID_LEAPSTUN = 1;
		ApplyEffect(LEAP_TARGET, "effects/debuff_stun", 2, GetEntityIndex(GetOwner()));
	}

	void leap_at2()
	{
		// PlayRandomSound from: "voices/orc/hit.wav", "voices/orc/hit2.wav", "voices/orc/hit3.wav"
		array<string> sounds = {"voices/orc/hit.wav", "voices/orc/hit2.wav", "voices/orc/hit3.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_ATTACK2);
		ScheduleDelayedEvent(0.1, "leap_boost");
	}

	void leap_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 350, 120));
	}

}

}
