#pragma context server

#include "monsters/bat_base.as"

namespace MS
{

class GbatHunter : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE_FLY;
	string ANIM_IDLE_HANG;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string BAT_STATUS;
	int BAT_SUMMONING;
	int BAT_SUMMON_BLOCKED;
	string BAT_SUMMON_NUM;
	int BAT_SUMMON_RISING;
	int CAN_ATTACK;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int CAN_STTACK;
	string CL_FLAP_SND;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	string NPC_MOVE_TARGET;

	GbatHunter()
	{
		ANIM_RUN = "fly";
		ANIM_WALK = "fly";
		ANIM_ATTACK = "attack2";
		ANIM_IDLE_HANG = "idlehang";
		ANIM_IDLE_FLY = "idle";
		const string ANIM_DROP = "hangtofly";
		ANIM_DEATH = "die";
		MOVE_RANGE = 70;
		const int ATTACK_DAMAGE = 15;
		ATTACK_RANGE = 120;
		ATTACK_HITRANGE = 180;
		const float ATTACK_HITCHANCE = 0.85;
		NPC_GIVE_EXP = 150;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN1 = "monsters/bat/pain1.wav";
		const string SOUND_PAIN2 = "monsters/bat/pain2.wav";
		const string SOUND_ATTACK1 = "monsters/skeleton/claw_miss1.wav";
		const string SOUND_ATTACK2 = "monsters/skeleton/claw_miss2.wav";
		const string SOUND_ATTACK3 = "monsters/orc/attack3.wav";
		const string SOUND_ALERT = "monsters/bat/alert.wav";
		const string SOUND_FLAP1 = "monsters/bat/flap_big1.wav";
		const string SOUND_FLAP2 = "monsters/bat/flap_big2.wav";
		const string SOUND_DEATH = "monsters/bat/death.wav";
		Precache("monsters/bat.mdl");
		const string BAT_SUMMON_SCRIPT = "monsters/bat_summon";
		const int BAT_SUMMON_AMT = 5;
		const int BAT_SUMMON_LIFETIME = 15;
		const int BAT_SUMMON_DMG = 4;
		const int BAT_SUMMON_HEIGHT = 300;
		const float BAT_SUMMON_CHANCE = 0.6;
		const string BAT_SUMMON_SND_RETREAT = "monsters/bat/pain1.wav";
		const string BAT_SUMMON_SND_SUMMON = "monsters/bat/death.wav";
		Precache("monsters/bat_summon");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3);
		if ((IS_HUNTING))
		{
		}
		if (GetMonsterProperty("last_seen.distance") < 128)
		{
		}
		if (!(BAT_SUMMONING))
		{
		}
		if (!(BAT_SUMMON_BLOCKED))
		{
		}
		if (RandomInt(0, 99) < BAT_SUMMON_CHANCE)
		{
		}
		if ((GetEntityProperty(GetOwner(), "alive")))
		{
		}
		string L_TARGETPOS = GetEntityOrigin(GetOwner());
		L_TARGETPOS += /* TODO: $relvel */ $relvel(0, -128, 0);
		SetRoam(false);
		SetMoveDest(L_TARGETPOS);
		BAT_SUMMONING = 1;
		BAT_SUMMON_BLOCKED = 1;
		CAN_ATTACK = 0;
		NPC_MOVE_TARGET = �NONE�;
		CAN_RETALIATE = 0;
		CAN_HEAR = 0;
		EmitSound(GetOwner(), CHAN_VOICE, BAT_SUMMON_SND_RETREAT, "game.sound.maxvol");
		ScheduleDelayedEvent(0.75, "bat_summon_flyup");
	}

	void bat_spawn()
	{
		SetName("Giant Bat");
		SetHealth(500);
		SetWidth(50);
		SetHeight(60);
		SetHearingSensitivity(10);
		SetModel("monsters/giant_bat.mdl");
		SetVolume(10);
		SetSolid("none");
		CAN_STTACK = 0;
	}

	void bat_drop_down()
	{
		PlayAnim("once", ANIM_DROP);
		BAT_STATUS = BAT_DROPPING;
		CAN_ATTACK = 0;
		CAN_HUNT = 0;
		EmitSound(GetOwner(), SOUND_ALERT);
	}

	void frame_hangdone()
	{
		BAT_STATUS = BAT_FLYING;
		CAN_ATTACK = 1;
		CAN_HUNT = 1;
		SetIdleAnim(ANIM_IDLE_FLY);
		SetRoam(true);
	}

	void frame_attack1()
	{
		attack_yell();
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void frame_attack2()
	{
		attack_yell();
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void attack_yell()
	{
		if (!(RandomInt(0, 1) == 0)) return;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), CHAN_BODY, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void bat_summon_flyup()
	{
		string L_TARGETPOS = GetEntityOrigin(GetOwner());
		Vector3 L_RAY_UP = Vector3(0, 0, 0);
		L_RAY_UP += BAT_SUMMON_HEIGHT;
		L_RAY_UP += ")";
		L_TARGETPOS += L_RAY_UP;
		BAT_SUMMON_RISING = 1;
		SetMoveDest(L_TARGETPOS);
	}

	void game_stopmoving()
	{
		if (!(BAT_SUMMON_RISING)) return;
		BAT_SUMMON_RISING = 0;
		ScheduleDelayedEvent(0.75, "bat_summon_all");
	}

	void bat_summon_all()
	{
		EmitSound(GetOwner(), CHAN_VOICE, BAT_SUMMON_SND_SUMMON, "game.sound.maxvol");
		PlayAnim("once", "attack2");
		BAT_SUMMON_NUM = BAT_SUMMON_AMT;
		ScheduleDelayedEvent(0.5, "bat_summon_loop");
		ScheduleDelayedEvent(1, "bat_summon_done");
	}

	void bat_summon_loop()
	{
		if (!(BAT_SUMMON_NUM)) return;
		BAT_SUMMON_NUM -= 1;
		string L_TARGETPOS = GetEntityOrigin(GetOwner());
		string L_OFS_X = RandomInt(-100, 100);
		string L_OFS_Y = RandomInt(-100, 100);
		L_TARGETPOS += Vector3(L_OFS_X, L_OFS_Y, -64);
		SpawnNPC(BAT_SUMMON_SCRIPT, L_TARGETPOS, ScriptMode::Legacy); // params: BAT_SUMMON_LIFETIME, BAT_SUMMON_DMG, HUNT_LASTTARGET
		ScheduleDelayedEvent(0.001, "bat_summon_loop");
	}

	void bat_summon_done()
	{
		BAT_SUMMONING = 0;
		BAT_SUMMON_RISING = 0;
		CAN_ATTACK = 1;
		NPC_MOVE_TARGET = "enemy";
		CAN_RETALIATE = 1;
		CAN_HEAR = 1;
		BAT_SUMMON_LIFETIME("bat_summon_reset");
	}

	void bat_summon_reset()
	{
		BAT_SUMMON_BLOCKED = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(FindEntityByName("spawner"), "makechest");
	}

	void cl_frame_flap()
	{
		SetVolume(10);
		if (!(CL_FLAP_SND))
		{
			EmitSound(GetOwner(), SOUND_FLAP1);
			CL_FLAP_SND = 1;
		}
		else
		{
			EmitSound(GetOwner(), SOUND_FLAP2);
			CL_FLAP_SND = 0;
		}
	}

}

}
