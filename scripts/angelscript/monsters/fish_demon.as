#pragma context server

#include "monsters/fish_base.as"

namespace MS
{

class FishDemon : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CYCLES_ON;
	string FLIGHT_STUCK;
	string LAST_POS;
	string LAST_PROG;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;

	FishDemon()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "swim";
		ANIM_RUN = "thrust";
		ANIM_DEATH = "die1";
		ANIM_ATTACK = "bite_r";
		const string ANIM_ATK_BIG = "srattack1";
		const string ANIM_ATK1 = "bite_r";
		const string ANIM_ATK2 = "bite_l";
		const float CHANCE_SWALLOW = 0.1;
		const string DMG_BITE = RandomInt(25, 60);
		const string DMG_BITE2 = RandomInt(50, 100);
		const string DMG_BITE3 = RandomInt(100, 200);
		const int PUSH_RANGE = 140;
		const string FREQ_SWALLOW = Random(20, 30);
		const int ATTACK_HITCHANCE = 70;
		const string SOUND_IDLE1 = "ichy/ichy_idle1.wav";
		const string SOUND_IDLE2 = "ichy/ichy_idle2.wav";
		const string SOUND_ATTACK1 = "ichy/ichy_bite1.wav";
		const string SOUND_ATTACK2 = "ichy/ichy_bite2.wav";
		const string SOUND_STRUCK1 = "ichy/ichy_pain2.wav";
		const string SOUND_STRUCK2 = "ichy/ichy_pain3.wav";
		const string SOUND_STRUCK3 = "ichy/ichy_pain5.wav";
		const string SOUND_STRUCK4 = "ichy/ichy_pain3.wav";
		const string SOUND_STRUCK5 = "ichy/ichy_pain5.wav";
		const string SOUND_DEATH = "ichy/ichy_die2.wav";
		Precache(SOUND_DEATH);
		MOVE_RANGE = 40;
		ATTACK_RANGE = 140;
		ATTACK_HITRANGE = 200;
		NPC_HACKED_MOVE_SPEED = 300;
		NPC_GIVE_EXP = 300;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		if ((IsEntityAlive(HUNT_LASTTARGET)))
		{
		}
		if (GetEntityRange(HUNT_LASTTARGET) < PUSH_RANGE)
		{
		}
		AddVelocity(HUNT_LASTTARGET, /* TODO: $relvel */ $relvel(0, 125, 0));
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.5);
		if (GetEntityRange(HUNT_LASTTARGET) < ATTACK_RANGE)
		{
			PlayAnim("once", ANIM_ATTACK);
		}
		if ((IS_HUNTING))
		{
		}
		npcatk_faceattacker();
		if (GetEntityRange(HUNT_LASTTARGET) > MOVE_RANGE)
		{
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 0));
		}
		if (GetEntityRange(HUNT_LASTTARGET) <= MOVE_RANGE)
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if (FLIGHT_STUCK > 4)
		{
			do_rand_tweedee();
			npcatk_suspend_ai(Random(0.3, 0.9));
			SetMoveDest(NEW_DEST);
			ScheduleDelayedEvent(0.1, "horror_boost");
			FLIGHT_STUCK = 0;
		}
		string TARG_POS = GetEntityOrigin(m_hAttackTarget);
		if (!(SUSPEND_AI))
		{
			SetAngles("face_origin");
		}
		if (!(IS_FLEEING))
		{
		}
		if (!(SPITTING))
		{
		}
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
		}
		string CUR_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		if (LAST_PROG >= CUR_PROG)
		{
			FLIGHT_STUCK += 1;
		}
		LAST_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		LAST_POS = GetMonsterProperty("origin");
	}

	void OnSpawn() override
	{
		SetHealth(1500);
		SetName("Demon Fish");
		SetModel("monsters/devil_fish1.mdl");
		SetWidth(96);
		SetHeight(96);
		SetHearingSensitivity(10);
		SetGravity(0.02);
	}

	void bite_r()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 7);
		if (ANIM_ATTACK == "bite_l")
		{
			npcatk_dodamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_BITE, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
			AddVelocity(HUNT_LASTTARGET, Vector3(100, 0, 0));
			ANIM_ATTACK = "bite_r";
		}
		else
		{
			npcatk_dodamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_BITE, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
			AddVelocity(HUNT_LASTTARGET, Vector3(-100, 0, 0));
			ANIM_ATTACK = "bite_l";
		}
	}

	void big_bite1()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		npcatk_dodamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_BITE2, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
		AddVelocity(HUNT_LASTTARGET, Vector3(-100, 200, 0));
		ANIM_ATTACK = "bite_l";
	}

	void big_bite2()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		npcatk_dodamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_BITE3, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
		AddVelocity(HUNT_LASTTARGET, Vector3(100, 200, 0));
		ANIM_ATTACK = "bite_r";
	}

	void cycle_up()
	{
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		FREQ_SWALLOW("do_swallow");
	}

	void do_swallow()
	{
		FREQ_SWALLOW("do_swallow");
		if (!(HUNT_LASTTARGET != �NONE�)) return;
		ANIM_ATTACK = ANIM_ATK_BIG;
	}

	void chicken_run()
	{
		ScheduleDelayedEvent(0.1, "horror_boost");
	}

	void horror_boost()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 500, 0));
	}

}

}
