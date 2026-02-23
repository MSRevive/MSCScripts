#pragma context server

#include "monsters/summon/base_summon.as"

namespace MS
{

class Rat : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string ATK_MIN;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int I_R_PET;
	int MOVE_RANGE;
	string RAT_HP;
	float RETALIATE_CHANCE;
	string SOUND_ATTACK1;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string TRICK_ANIM;

	Rat()
	{
		I_R_PET = 1;
		const int SUMMON_CIRCLE_INDEX = 12;
		const string SUM_SAY_COME = "*squeek!*";
		const string SUM_SAY_ATTACK = "*squeek!* *squeek!*";
		const string SUM_SAY_HUNT = "*squeek...*";
		const string SUM_SAY_DEFEND = "*squeekie!*";
		const string SUM_SAY_DEATH = "*SQUEEK!*";
		const string SUM_SAY_GUARD = "*squeek!*";
		const string SUM_REPORT_SUFFIX = "..er, I mean, *squeek*!?";
		const string ANIM_WALK_BASE = "walk";
		const string ANIM_RUN_BASE = "run";
		ANIM_IDLE = "idle1";
		const string ANIM_WALK_BASE = "walk";
		const string ANIM_RUN_BASE = "run";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		MOVE_RANGE = 20;
		ATTACK_RANGE = 75;
		ATTACK_HITRANGE = 100;
		ATTACK_HITCHANCE = 0.9;
		TRICK_ANIM = "idle2";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod1.wav";
		SOUND_PAIN = "monsters/rat/squeak1.wav";
		SOUND_ATTACK1 = "monsters/rat/squeak2.wav";
		SOUND_IDLE1 = "monsters/rat/squeak2.wav";
		const string SOUND_DEATH = "monsters/rat/squeak3.wav";
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		CAN_HUNT = 1;
		CAN_HEAR = 0;
		CAN_FLINCH = 0;
	}

	void summon_spawn()
	{
		SetName("Rat");
		SetFOV(359);
		SetWidth(32);
		SetHeight(20);
		SetRoam(true);
		SetHearingSensitivity(3);
		SetSkillLevel(0);
		SetRace("human");
		SetModel("monsters/rat.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		basesummon_attackall();
		CatchSpeech("rat_standup", "stand");
		CatchSpeech("rat_rollover", "rollover");
		CatchSpeech("rat_playdead", "play dead");
	}

	void summon_summoned()
	{
		string TIME_LIVE = param2;
		TIME_LIVE++;
		ATK_MIN = param3;
		RAT_HP = param2;
		RAT_HP /= 2;
		SetHealth(RAT_HP);
		ScheduleDelayedEvent(TIME_LIVE, "killme");
	}

	void bite1()
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_ATTACK1
		array<string> sounds = {SOUND_ATTACK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		XDoDamage(m_hLastSeen, ATTACK_HITRANGE, ATK_MIN, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bite");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void rat_standup()
	{
		if (!(GetEntityIndex("ent_lastspoke") == SUMMON_MASTER)) return;
		npcatk_suspend_ai(3.0);
		SetSayTextRange(1024);
		SayText("*squeek!* :D");
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_IDLE1);
		SetAngles("face");
		PlayAnim("hold", TRICK_ANIM);
	}

	void rat_rollover()
	{
		if (!(GetEntityIndex("ent_lastspoke") == SUMMON_MASTER)) return;
		npcatk_suspend_ai(3.0);
		SetSayTextRange(1024);
		SayText("*squeek?*");
		SetAngles("face");
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_IDLE1);
		PlayAnim("once", TRICK_ANIM);
	}

	void rat_playdead()
	{
		if (!(GetEntityIndex("ent_lastspoke") == SUMMON_MASTER)) return;
		npcatk_suspend_ai();
		SetSayTextRange(1024);
		SayText("*SQUEEK!*");
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_DEATH);
		SetAngles("face");
		PlayAnim("hold", ANIM_DEATH);
		ScheduleDelayedEvent(3, "stop_playing_dead");
	}

	void stop_playing_dead()
	{
		npcatk_resume_ai();
		PlayAnim("once", "run");
	}

}

}
