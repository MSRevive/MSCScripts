#pragma context server

#include "monsters/summon/base_summon.as"

namespace MS
{

class Skeleton : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_RUN_BASE;
	string ANIM_WALK;
	string ANIM_WALK_BASE;
	string ATK_MIN;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int HOVER_CLOSE;
	int HOVER_FAR;
	int I_R_PET;
	int MOVE_RANGE;
	string OWNER_SKILL;
	float RETALIATE_CHANCE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_STRUCK4;
	int SUMMON_CIRCLE_INDEX;
	string SUM_REPORT_SUFFIX;
	string SUM_SAY_ATTACK;
	string SUM_SAY_COME;
	string SUM_SAY_DEATH;
	string SUM_SAY_DEFEND;
	string SUM_SAY_GUARD;
	string SUM_SAY_HUNT;

	Skeleton()
	{
		SUMMON_CIRCLE_INDEX = 30;
		I_R_PET = 1;
		SUM_SAY_COME = "Yes, my master.";
		SUM_SAY_ATTACK = "It shall be more dead than I, my master.";
		SUM_SAY_HUNT = "Seeking prey for my master...";
		SUM_SAY_DEFEND = "I shall defend you with my unlife, my master.";
		SUM_SAY_DEATH = "No! I have failed my master!";
		SUM_SAY_GUARD = "I shall be as unmovable as the dead!";
		SUM_REPORT_SUFFIX = ", my master.";
		HOVER_FAR = 128;
		HOVER_CLOSE = 64;
		ANIM_WALK_BASE = "walk";
		ANIM_RUN_BASE = "walk";
		ANIM_IDLE = "idle1";
		ANIM_DEATH = "dieheadshot";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_ATTACK = "attack1";
		MOVE_RANGE = 32;
		ATTACK_RANGE = 75;
		ATTACK_HITRANGE = 125;
		ATTACK_HITCHANCE = 0.9;
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_STRUCK4 = "zombie/zo_pain2.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_DEATH = "zombie/zo_pain1.wav";
		ANIM_RUN_BASE = "walk";
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		CAN_HUNT = 1;
		CAN_HEAR = 0;
		CAN_FLINCH = 0;
	}

	void summon_spawn()
	{
		SetName("Skeleton");
		SetFOV(359);
		SetWidth(32);
		SetHeight(72);
		SetRoam(true);
		SetHearingSensitivity(3);
		SetSkillLevel(0);
		SetRace("human");
		SetModel("monsters/skeleton.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetBloodType("none");
		SetDamageResistance("slash", ".7");
		SetDamageResistance("pierce", ".5");
		SetDamageResistance("blunt", 1.2);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("holy", 3.0);
		SetDamageResistance("cold", 0.1);
		SetDamageResistance("poison", 0.0);
		CatchSpeech("skeleton_no", "play dead");
		CatchSpeech("skeleton_grave", "roll over");
		basesummon_attackall();
	}

	void pre_name_set()
	{
		OWNER_SKILL = GetSkillLevel(SUMMON_MASTER, "spellcasting");
		if (OWNER_SKILL == 8)
		{
			SetModelBody(0, 6);
		}
		if (OWNER_SKILL == 9)
		{
			SetModelBody(0, 6);
			SetModelBody(1, 1);
		}
		if (OWNER_SKILL == 10)
		{
			SetModelBody(0, 1);
			SetModelBody(1, 1);
		}
		if (OWNER_SKILL == 11)
		{
			SetModelBody(0, 1);
			SetModelBody(1, 4);
		}
		if (OWNER_SKILL == 12)
		{
			SetModelBody(0, 1);
			SetModelBody(1, 2);
		}
		if (OWNER_SKILL == 13)
		{
			SetModelBody(0, 5);
			SetModelBody(1, 0);
		}
		if (OWNER_SKILL == 14)
		{
			SetModelBody(0, 5);
			SetModelBody(1, 1);
		}
		if (OWNER_SKILL == 15)
		{
			SetModelBody(0, 3);
			SetModelBody(1, 4);
		}
		if (OWNER_SKILL == 16)
		{
			SetModelBody(0, 3);
			SetModelBody(1, 3);
		}
		if (OWNER_SKILL == 17)
		{
			SetModelBody(0, 4);
			SetModelBody(1, 1);
		}
		if (OWNER_SKILL == 18)
		{
			SetModelBody(0, 4);
			SetModelBody(1, 2);
		}
		if (OWNER_SKILL == 19)
		{
			SetModelBody(0, 4);
			SetModelBody(1, 4);
		}
		if (OWNER_SKILL >= 20)
		{
			SetModelBody(0, 8);
			SetModelBody(1, 0);
		}
	}

	void summon_summoned()
	{
		string TIME_LIVE = param2;
		TIME_LIVE++;
		ATK_MIN = param3;
		SetHealth(param2);
		PlayAnim("critical", "getup");
		ScheduleDelayedEvent(TIME_LIVE, "killme");
	}

	void attack_1()
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_ATTACK1
		array<string> sounds = {SOUND_ATTACK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATK_MIN, ATTACK_HITCHANCE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_STRUCK4, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK4, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void skeleton_no()
	{
		if (!(GetEntityIndex("ent_lastspoke") == SUMMON_MASTER)) return;
		npcatk_suspend_ai(3.0);
		PlayAnim("once", "throw_scientist");
		SetSayTextRange(1024);
		SayText("Not funny, master.");
	}

	void skeleton_grave()
	{
		if (!(GetEntityIndex("ent_lastspoke") == SUMMON_MASTER)) return;
		npcatk_suspend_ai(1.0);
		SetMoveDest(SUMMON_MASTER);
		SetSayTextRange(1024);
		SayText("In who's grave?");
	}

}

}
