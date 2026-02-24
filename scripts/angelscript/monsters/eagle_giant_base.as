#pragma context server

#include "monsters/base_propelled.as"
#include "monsters/base_monster.as"

namespace MS
{

class EagleGiantBase : CGameScript
{
	int AM_PERCHED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FIGIT;
	string ANIM_IDLE;
	string ANIM_IDLE_FLIGHT;
	string ANIM_PERCH1;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int ATTACK_RANGE_STANDARD;
	int COUNT_ATK;
	float DMG_ATTACK;
	int DMG_DIVE;
	int FLEE_COUNT;
	int FLY_VRANGE;
	int FLY_VSPEED_DOWN;
	int FLY_VSPEED_UP;
	int FREQ_DIVE;
	int MOVE_RANGE;
	int NPC_HACKED_MOVE_SPEED;
	int NPC_NO_END_FLY;
	int NPC_PROXACT_CONE;
	string NPC_PROXACT_EVENT;
	int NPC_PROXACT_FOV;
	string NPC_PROXACT_PLAYERID;
	int NPC_PROXACT_RANGE;
	string NPC_PROXACT_TRIPPED;
	int NPC_PROX_ACTIVATE;
	string SOUND_ATTACK;
	string SOUND_DEATH;
	string SOUND_FLAP1;
	string SOUND_FLAP2;
	string SOUND_PAIN;
	string SOUND_PAIN2;
	string SOUND_STRUCK;
	string SOUND_VICTORY;
	string SOUND_WARCRY;
	int SPEED_DIVE;
	int SPEED_STANDARD;

	EagleGiantBase()
	{
		NPC_NO_END_FLY = 1;
		ANIM_IDLE = "flapping";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "crash";
		ANIM_WALK = "flapping";
		ANIM_RUN = "flapping";
		MOVE_RANGE = 20;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 72;
		NPC_HACKED_MOVE_SPEED = 200;
		ANIM_PERCH1 = "idle";
		ANIM_FIGIT = "idle2";
		ANIM_IDLE_FLIGHT = "flapping";
		DMG_ATTACK = Random(15, 40);
		DMG_DIVE = RandomInt(30, 100);
		FREQ_DIVE = RandomInt(20, 30);
		SPEED_STANDARD = 200;
		SPEED_DIVE = 400;
		FLEE_COUNT = 10;
		ATTACK_RANGE_STANDARD = 64;
		FLY_VSPEED_UP = 25;
		FLY_VSPEED_DOWN = -25;
		FLY_VRANGE = 50;
		SOUND_FLAP1 = "monsters/bat/flap_big1.wav";
		SOUND_FLAP2 = "monsters/bat/flap_big2.wav";
		SOUND_WARCRY = "monsters/birds/bird.wav";
		SOUND_DEATH = "monsters/birds/hawk.wav";
		SOUND_ATTACK = "monsters/birds/flutter.wav";
		SOUND_STRUCK = "debris/flesh2.wav";
		SOUND_PAIN = "monsters/birds/vulture.wav";
		SOUND_PAIN2 = "monsters/birds/cry.wav";
		SOUND_VICTORY = "monsters/birds/hawkcaw.wav";
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetName("Giant Eagle");
		SetRace("wildanimal");
		SetHealth(1000);
		SetWidth(64);
		SetHeight(64);
		SetModel("monsters/eagle_large.mdl");
		SetIdleAnim("flapping");
		SetMoveAnim("flapping");
		SetHearingSensitivity(8);
		SetRoam(true);
		SetGravity(0);
		SetDamageResistance("poison", 2.0);
		COUNT_ATK = 0;
	}

	void npc_targetsighted()
	{
		if (!(IsValidPlayer(HUNT_LASTTARGET)))
		{
			ATTACK_RANGE = GetEntityHeight(HUNT_LASTTARGET);
			if (!(CYCLED_UP))
			{
				cycle_up();
			}
		}
		else
		{
			ATTACK_RANGE = ATTACK_RANGE_STANDARD;
		}
	}

	void start_perched()
	{
		SetIdleAnim("idle");
		SetMoveAnim("idle");
		SetRoam(false);
		AM_PERCHED = 1;
		SetHearingSensitivity(0);
		npcatk_suspend_ai();
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_RANGE = 384;
		NPC_PROXACT_EVENT = "un_perch";
		NPC_PROXACT_FOV = 1;
		NPC_PROXACT_CONE = 90;
		ScheduleDelayedEvent(0.1, "npcatk_proxact_scan");
	}

	void un_perch()
	{
		SetHearingSensitivity(8);
		AM_PERCHED = 0;
		SetIdleAnim(ANIM_WALK);
		SetMoveAnim(ANIM_WALK);
		npcatk_suspend_ai();
		NPC_HACKED_MOVE_SPEED = SPEED_STANDARD;
		PlayAnim("critical", "divestart");
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 100));
		SetMoveDest(DIVE_START);
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		ScheduleDelayedEvent(1.1, "target_invader");
	}

	void target_invader()
	{
		npcatk_target(NPC_PROXACT_PLAYERID);
	}

	void cycle_up()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((AM_PERCHED))
		{
			NPC_PROXACT_PLAYERID = GetEntityIndex(m_hLastStruck);
			NPC_PROXACT_TRIPPED = 1;
			un_perch();
		}
	}

	void attack1()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 5);
		DoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_ATTACK, 0.9, "slash");
	}

	void attack2()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 5);
		DoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_ATTACK, 0.9, "slash");
		COUNT_ATK += 1;
		if (COUNT_ATK > FLEE_COUNT)
		{
			COUNT_ATK = 0;
			npcatk_suspend_ai(3.0);
			SetMoveDest(HUNT_LASTTARGET);
		}
	}

	void flap_sound()
	{
		// PlayRandomSound from: SOUND_FLAP1, SOUND_FLAP2
		array<string> sounds = {SOUND_FLAP1, SOUND_FLAP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetGravity(1.0);
	}

	void my_target_died()
	{
		EmitSound(GetOwner(), 0, SOUND_VICTORY, 10);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((I_R_FROZEN)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		string MOVE_DEST_Z = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("movedest.origin"));
		MOVE_DEST_Z += 256;
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		if (MOVE_DEST_Z > MY_Z)
		{
			string Z_DIFF = MOVE_DEST_Z;
			Z_DIFF -= MY_Z;
			if (Z_DIFF > FLY_VRANGE)
			{
			}
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, FLY_VSPEED_UP));
		}
		if (MOVE_DEST_Z < MY_Z)
		{
			string Z_DIFF = MY_Z;
			Z_DIFF -= MOVE_DEST_Z;
			if (Z_DIFF > FLY_VRANGE)
			{
			}
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, FLY_VSPEED_DOWN));
		}
	}

}

}
