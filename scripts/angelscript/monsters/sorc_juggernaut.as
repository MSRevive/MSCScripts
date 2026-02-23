#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/sorc_base.as"

namespace MS
{

class SorcJuggernaut : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	string ANIM_ATTACK2;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int DID_LEAPSTUN;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	string LAST_SWORD_HIT;
	int LEAPING;
	string LEAP_END;
	string LEAP_TARGET;
	int LUNGE_DELAY;
	string MY_SCRIPT_IDX;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;

	SorcJuggernaut()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(150, 220);
		NPC_GIVE_EXP = 1750;
		ANIM_ATTACK1 = "battleaxe_swing1_L";
		ANIM_ATTACK2 = "swordswing1_L";
		FLINCH_CHANCE = 0.25;
		const string DMG_KICK = Random(25, 100);
		ANIM_ATTACK = ANIM_ATTACK1;
		const float ATTACK_ACCURACY = 0.7;
		const string DMG_SWORD = RandomInt(400, 800);
		const float FREQ_LUNGE = 10.0;
		const int LUNGE_RANGE = 256;
		const string SOUND_WALK1 = "monsters/troll/step1.wav";
		const string SOUND_WALK2 = "monsters/troll/step2.wav";
		const string SOUND_UPSWING = "monsters/orc/attack1.wav";
		const string SOUND_SWINGHIT = "monsters/orc/pain.wav";
		const string SOUND_SWINGMISS = "debris/bustmetal2.wav";
		const float AS_MAX_ATTACK_TIME = 10.0;
		const float SORC_LRESIST = 0.6;
		const float SORC_PRESIST = 1.2;
	}

	void orc_spawn()
	{
		SetName("Shadahar Juggernaut");
		SetModel("monsters/sorc_huge.mdl");
		SetHealth(5000);
		SetDamageResistance("all", 0.5);
		SetStat("parry", 110);
		SetWidth(48);
		SetHeight(128);
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetModelBody(2, 5);
	}

	void OnPostSpawn() override
	{
		ATTACK_MOVERANGE = 96;
		ATTACK_RANGE = 128;
		ATTACK_HITRANGE = 200;
	}

	void swing_axe()
	{
		baseorc_yell();
		npcatk_dodamage(m_hLastSeen, ATTACK_HITRANGE, DMG_SWORD, ATTACK_ACCURACY, "slash");
		AddVelocity(m_hLastSeen, /* TODO: $relvel */ $relvel(-120, 120, 150));
		if (!(RandomInt(1, 10) == 1)) return;
		ANIM_ATTACK = "kick";
		EmitSound(GetOwner(), 2, SOUND_SWINGMISS, 10);
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
		ClientEvent("new", "all", "effects/sfx_motionblur_perm", GetEntityIndex(GetOwner()), 0);
		MY_SCRIPT_IDX = "game.script.last_sent_id";
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
		ScheduleDelayedEvent(1.0, "leap_end");
	}

	void leap_end()
	{
		ClientEvent("remove", "all", MY_SCRIPT_IDX);
	}

	void leap_scan()
	{
		if (!(GetGameTime() < LEAP_END)) return;
		ScheduleDelayedEvent(0.1, "leap_scan");
		LogDebug("temp leap_scan GetEntityName(LEAP_TARGET) GetEntityRange(LEAP_TARGET)");
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

	void run_step1()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK2, 8);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 128, 10, 1, 256);
	}

	void run_step2()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK1, 8);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 128, 10, 1, 256);
	}

	void swing_start()
	{
		EmitSound(GetOwner(), 1, SOUND_UPSWING, 10);
	}

	void kick_land()
	{
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			LAST_SWORD_HIT = GetGameTime();
		}
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KICK, ATTACK_ACCURACY, "blunt");
		ANIM_ATTACK = "battleaxe_swing1_L";
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		ApplyEffect(m_hAttackTarget, "effects/debuff_stun", Random(5, 10), GetEntityIndex(GetOwner()));
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(-100, 200, 150));
	}

}

}
