#pragma context server

#include "monsters/bat_base.as"

namespace MS
{

class BatGiant : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DROP;
	string ANIM_IDLE_FLY;
	string ANIM_IDLE_HANG;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BAT_SUMMON_AMT;
	float BAT_SUMMON_CHANCE;
	int BAT_SUMMON_DMG;
	int BAT_SUMMON_HEIGHT;
	int BAT_SUMMON_LIFETIME;
	string BAT_SUMMON_NUM;
	string BAT_SUMMON_SCRIPT;
	string BAT_SUMMON_SND_RETREAT;
	string BAT_SUMMON_SND_SUMMON;
	int CAN_HUNT;
	string CHAPEL_BAT;
	string CL_FLAP_SND;
	float FREQ_SUMMON;
	int HEAR_RANGE_MAX;
	int HEAR_RANGE_PLAYER;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	string OLD_TARG;
	string SOUND_ALERT;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_FLAP1;
	string SOUND_FLAP2;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	BatGiant()
	{
		HEAR_RANGE_PLAYER = 256;
		HEAR_RANGE_MAX = 300;
		ANIM_RUN = "fly";
		ANIM_WALK = "fly";
		ANIM_ATTACK = "attack2";
		ANIM_IDLE_HANG = "idle";
		ANIM_IDLE_FLY = "idle";
		ANIM_DROP = "idle";
		ANIM_DEATH = "die";
		MOVE_RANGE = 10;
		ATTACK_DAMAGE = 15;
		ATTACK_RANGE = 200;
		ATTACK_HITRANGE = 250;
		ATTACK_HITCHANCE = 0.85;
		NPC_GIVE_EXP = 150;
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN1 = "monsters/bat/pain1.wav";
		SOUND_PAIN2 = "monsters/bat/pain2.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_ATTACK3 = "monsters/orc/attack3.wav";
		SOUND_ALERT = "monsters/bat/alert.wav";
		SOUND_FLAP1 = "monsters/bat/flap_big1.wav";
		SOUND_FLAP2 = "monsters/bat/flap_big2.wav";
		SOUND_DEATH = "monsters/bat/death.wav";
		BAT_SUMMON_SCRIPT = "monsters/bat_summon";
		BAT_SUMMON_AMT = 5;
		BAT_SUMMON_LIFETIME = 15;
		BAT_SUMMON_DMG = 4;
		BAT_SUMMON_HEIGHT = 300;
		BAT_SUMMON_CHANCE = 0.6;
		BAT_SUMMON_SND_RETREAT = "monsters/bat/pain1.wav";
		BAT_SUMMON_SND_SUMMON = "monsters/bat/death.wav";
		Precache("monsters/bat_summon");
		FREQ_SUMMON = 17.0;
		Precache("monsters/bat.mdl");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if ((IsEntityAlive(m_hAttackTarget)))
		{
		}
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			PlayAnim("critical", ANIM_ATTACK);
		}
	}

	void bat_spawn()
	{
		SetName("Giant Bat");
		SetHealth(500);
		SetWidth(70);
		SetHeight(70);
		SetHearingSensitivity(10);
		SetModel("monsters/giant_bat.mdl");
		SetVolume(10);
		SetRace("demon");
	}

	void bat_hang()
	{
		SetRoam(true);
		CAN_HUNT = 1;
	}

	void OnPostSpawn() override
	{
		if (StringToLower(GetMapName()) == "chapel")
		{
			ATTACK_DAMAGE /= 2;
			NPC_GIVE_EXP /= 2;
			SetHealth(250);
			ATTACK_HITCHANCE = 75;
			CHAPEL_BAT = 1;
		}
	}

	void cycle_up()
	{
		SetIdleAnim(ANIM_IDLE_FLY);
		SetMoveAnim(ANIM_RUN);
		PlayAnim("critical", ANIM_DROP);
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		SetRoam(true);
		FREQ_SUMMON("make_babies");
	}

	void make_babies()
	{
		FREQ_SUMMON("make_babies");
		OLD_TARG = m_hAttackTarget;
		npcatk_suspend_ai(2.0);
		string DEST_POS = GetMonsterProperty("origin");
		DEST_POS += "z";
		SetMoveDest(DEST_POS);
		AddVelocity(GetOwner(), Vector3(0, -50, 900));
		ScheduleDelayedEvent(0.5, "make_babies2");
	}

	void make_babies2()
	{
		AddVelocity(GetOwner(), Vector3(0, -50, 900));
		SetMoveDest(OLD_TARG);
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		ScheduleDelayedEvent(0.1, "make_babies3");
	}

	void make_babies3()
	{
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		SetAngles("face");
		PlayAnim("critical", ANIM_ATTACK);
		ScheduleDelayedEvent(0.1, "bat_summon_all");
	}

	void bat_summon_all()
	{
		EmitSound(GetOwner(), CHAN_VOICE, BAT_SUMMON_SND_SUMMON, "game.sound.maxvol");
		PlayAnim("once", "attack2");
		BAT_SUMMON_NUM = BAT_SUMMON_AMT;
		ScheduleDelayedEvent(0.1, "bat_summon_loop");
	}

	void bat_summon_loop()
	{
		if (!(BAT_SUMMON_NUM)) return;
		BAT_SUMMON_NUM -= 1;
		string L_TARGETPOS = GetEntityOrigin(GetOwner());
		int L_OFS_X = RandomInt(-100, 100);
		int L_OFS_Y = RandomInt(-100, 100);
		L_TARGETPOS += Vector3(L_OFS_X, L_OFS_Y, -64);
		SpawnNPC(BAT_SUMMON_SCRIPT, L_TARGETPOS, ScriptMode::Legacy); // params: BAT_SUMMON_LIFETIME, BAT_SUMMON_DMG, HUNT_LASTTARGET
		ScheduleDelayedEvent(0.1, "bat_summon_loop");
	}

	void frame_attack1()
	{
		attack_yell();
		DoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void frame_attack2()
	{
		attack_yell();
		DoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
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

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(FindEntityByName("spawner"), "makechest");
	}

	void cl_frame_flap()
	{
		if (!(CL_FLAP_SND))
		{
			EmitSound(GetOwner(), 0, SOUND_FLAP1, 10);
			CL_FLAP_SND = 1;
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_FLAP2, 10);
			CL_FLAP_SND = 0;
		}
	}

	void npcatk_setmovedest()
	{
		if (GetEntityIndex(param1) != m_hAttackTarget)
		{
			SetMoveDest(param1);
		}
		if (GetEntityIndex(param1) == m_hAttackTarget)
		{
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			TARG_ORG += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 128));
			SetMoveDest(TARG_ORG);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(CHAPEL_BAT)) return;
		CallExternal(GAME_MASTER, "gm_createnpc", 0.1, "chests/chapel_bat", /* TODO: $relpos */ $relpos(0, 0, 0));
	}

}

}
