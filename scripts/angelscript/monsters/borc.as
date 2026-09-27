#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_jumper.as"

namespace MS
{

class Borc : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DASH_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_LOOK;
	string ANIM_MIGHTY_BLOW;
	string ANIM_NPC_JUMP;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int ATTACK_REACH;
	int BJUMPER_CUSTOM_BOOST;
	int BJUMPER_FACTOR;
	int BJUMPER_NO_FORWARD;
	int DID_ALERT;
	int DMG_PUNCH_STRONG;
	int DMG_PUNCH_WEAK;
	float FREQ_MIGHTY_BLOW;
	string HALF_HEALTH;
	int HUNDERSWAMP_BORC;
	int MOVE_RANGE;
	float MSC_PUSH_RESIST;
	string NEXT_LOOK;
	string NEXT_MIGHTY_BLOW;
	int NPC_GIVE_EXP;
	int NPC_JUMPER;
	string QUART_HEALTH;
	string SOUND_ALERT;
	string SOUND_ATTACK;
	string SOUND_DEATH;
	string SOUND_MIGHTY1;
	string SOUND_MIGHTY2;
	string SOUND_NPC_JUMP;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;
	string SOUND_PAIN4;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Borc()
	{
		ANIM_IDLE = "anim_borsh_idle_norm";
		ANIM_WALK = "anim_borsh_walk";
		ANIM_RUN = "anim_borsh_run";
		ANIM_ATTACK = "anim_borsh_dashattack2";
		ANIM_DEATH = "anim_borsh_death";
		ANIM_LOOK = "anim_borsh_idle_look";
		ANIM_NPC_JUMP = "anim_borsh_jump";
		ANIM_MIGHTY_BLOW = "anim_borsh_dashattack1";
		ANIM_DASH_ATTACK = "anim_borsh_dashattack2";
		NPC_JUMPER = 1;
		MSC_PUSH_RESIST = 0.75;
		BJUMPER_CUSTOM_BOOST = 1;
		BJUMPER_NO_FORWARD = 1;
		BJUMPER_FACTOR = 4;
		NPC_GIVE_EXP = 1000;
		DMG_PUNCH_STRONG = 500;
		DMG_PUNCH_WEAK = 200;
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 128;
		ATTACK_REACH = 64;
		ATTACK_MOVERANGE = 80;
		MOVE_RANGE = 80;
		FREQ_MIGHTY_BLOW = Random(5.0, 10.0);
		SOUND_MIGHTY1 = "monsters/orc/attack1.wav";
		SOUND_MIGHTY2 = "monsters/orc/attack3.wav";
		SOUND_ATTACK = "monsters/orc/attack2.wav";
		SOUND_ALERT = "monsters/orc/battlecry.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN1 = "monsters/orc/zo_alert10.wav";
		SOUND_PAIN2 = "voices/orc/hit2.wav";
		SOUND_PAIN3 = "voices/orc/hit3.wav";
		SOUND_PAIN4 = "voices/orc/hit.wav";
		SOUND_DEATH = "voices/orc/die2.wav";
		SOUND_NPC_JUMP = "monsters/orc/attack1.wav";
	}

	void OnSpawn() override
	{
		SetName("Feral Borsh");
		SetModel("monsters/borsh.mdl");
		SetWidth(64);
		SetHeight(64);
		SetHealth(4000);
		SetRace("orc");
		SetRoam(true);
		SetHearingSensitivity(2);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetModelBody(1, RandomInt(0, 1));
		ScheduleDelayedEvent(2.0, "finalize_npc");
	}

	void finalize_npc()
	{
		string MAX_HP = GetEntityMaxHealth(GetOwner());
		HALF_HEALTH = MAX_HP;
		HALF_HEALTH *= 0.5;
		QUART_HEALTH = MAX_HP;
		HALF_HEALTH *= 0.25;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		string MY_HP = GetEntityHealth(GetOwner());
		if (MY_HP > HALF_HEALTH)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (MY_HP <= HALF_HEALTH)
		{
			if (MY_HP > QUART_HEALTH)
			{
			}
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN2, SOUND_PAIN1
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN2, SOUND_PAIN1};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (MY_HP <= QUART_HEALTH)
		{
			// TODO: UNCONVERTED: if ( MY_HP <= QUART_HEALTH ) layrandomsound 0 10 SOUND_STRUCK1 SOUND_STRUCK2 SOUND_STRUCK3 SOUND_STRUCK1 SOUND_PAIN1 SOUND_PAIN2 SOUND_PAIN3 SOUND_PAIN4
		}
	}

	void npcatk_lost_sight()
	{
		LogDebug("npcatk_lost_sight");
		if (!(GetGameTime() > NEXT_LOOK)) return;
		NEXT_LOOK = GetGameTime();
		NEXT_LOOK += 15.0;
		PlayAnim("once", ANIM_LOOK);
	}

	void npc_targetsighted()
	{
		if ((DID_ALERT)) return;
		DID_ALERT = 1;
		NEXT_MIGHTY_BLOW = GetGameTime();
		NEXT_MIGHTY_BLOW += FREQ_MIGHTY_BLOW;
	}

	void npc_selectattack()
	{
		if (!(GetGameTime() > NEXT_MIGHTY_BLOW)) return;
		NEXT_MIGHTY_BLOW = GetGameTime();
		NEXT_MIGHTY_BLOW += 200;
		ANIM_ATTACK = ANIM_MIGHTY_BLOW;
	}

	void frame_jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_NPC_JUMP_STR, NPC_UP_JUMP_STR));
	}

	void frame_jump_land()
	{
		npcatk_resume_ai();
	}

	void frame_attack_dash2a()
	{
		// PlayRandomSound from: SOUND_MIGHTY1, SOUND_MIGHTY2
		array<string> sounds = {SOUND_MIGHTY1, SOUND_MIGHTY2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_PUNCH_STRONG, 0.8, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:strong_punch");
	}

	void frame_attack_dash2b()
	{
		// svplaysound: svplaysound 0 10 SOUND_ATTACK
		EmitSound(0, 10, SOUND_ATTACK);
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_PUNCH_WEAK, 0.8, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:weak_punch");
	}

	void frame_mighty_blow()
	{
		// svplaysound: svplaysound 0 10 voices/orc/attack3.wav
		EmitSound(0, 10, "voices/orc/attack3.wav");
		NEXT_MIGHTY_BLOW = GetGameTime();
		NEXT_MIGHTY_BLOW += FREQ_MIGHTY_BLOW;
		ANIM_ATTACK = ANIM_DASH_ATTACK;
		XDoDamage(m_hAttackTarget, ATTACK_REACH, DMG_PUNCH_STRONG, 0.9, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:mighty_blow");
	}

	void strong_punch_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 350, 180));
		if (!(RandomInt(1, 3) == 1)) return;
		ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
	}

	void weak_punch_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 110, 110));
	}

	void mighty_blow_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 300, 400));
		ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(GetGameTime() > NEXT_LOOK)) return;
		NEXT_LOOK = GetGameTime();
		NEXT_LOOK += Random(10.0, 20.0);
		LogDebug("npcatk_hunt look");
		PlayAnim("once", ANIM_LOOK);
	}

	void frame_run_land()
	{
		// PlayRandomSound from: "common/bodydrop1.wav", "common/bodydrop2.wav", "common/bodydrop3.wav", "common/bodydrop4.wav"
		array<string> sounds = {"common/bodydrop1.wav", "common/bodydrop2.wav", "common/bodydrop3.wav", "common/bodydrop4.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void set_hunderswamp_north_borc()
	{
		LogDebug("set_hunderswamp_north_borc");
		HUNDERSWAMP_BORC = 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(HUNDERSWAMP_BORC)) return;
		if (!(RandomInt(1, 2) == 1)) return;
		SpawnNPC("chests/hunderswamp1_borc", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy);
		CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()), 2);
	}

}

}
