#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class RabidSkeleBase : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int DID_WARCRY;
	int NPC_GIVE_EXP;

	RabidSkeleBase()
	{
		const string ANIM_IDLE1 = "idle1";
		const string ANIM_IDLE2 = "idle2";
		const string ANIM_IDLE3 = "idle3";
		const string ANIM_DUCK = "crouch";
		const string ANIM_JUMP = "jump";
		const string ANIM_SUMMON1 = "updown";
		const string ANIM_SUMMON2 = "downup";
		const string ANIM_SUMMON_FLYER = "jabber";
		const string ANIM_PARRY = "right";
		const string ANIM_SLASH = "attack1";
		const string ANIM_PROJECTILE = "zapattack1";
		const string ANIM_FLINCH1 = "flinch2";
		const string ANIM_FLINCH2 = "laflinch";
		const string ANIM_FLINCH3 = "raflinch";
		const string ANIM_FLINCH4 = "llflinch";
		const string ANIM_FLINCH5 = "rlflinch";
		const string ANIM_DEATH_FINAL = "diebackward";
		const string ANIM_DEATH_FAKE = "dieheadshot";
		const string ANIM_IDLE_DEAD = "cw_sleep_headshot";
		const string ANIM_GET_UP = "cw_awake_headshot";
		ANIM_RUN = "run1";
		ANIM_WALK = "walk1";
		ANIM_ATTACK = ANIM_SLASH;
		ANIM_IDLE = ANIM_IDLE3;
		ATTACK_MOVERANGE = 30;
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 164;
		const string FREQ_IDLE = Random(10, 20);
		const int TURN_REQ = 5;
		const string ANIM_BEG = "collar1";
		const string ANIM_ANGRY1 = "collar2";
		const string ANIM_ANGRY2 = "jibber";
		const string ANIM_TEASE = "cw_pepsiidle";
		const string ANIM_PLAY_DEAD1 = "cw_sleep_head";
		const string ANIM_AWAKE1 = "cw_awake_head";
		const string ANIM_PLAY_DEAD2 = "cw_sleep_back";
		const string ANIM_AWAKE2 = "cw_awake_back";
		const string SOUND_ALERT1 = "monsters/kelly_sounds/slv_alert1.wav";
		const string SOUND_ALERT2 = "monsters/kelly_sounds/slv_alert3.wav";
		const string SOUND_ALERT3 = "monsters/kelly_sounds/slv_alert4.wav";
		const string SOUND_ATTACK = "monsters/kelly_sounds/hc_attack3.wav";
		const string SOUND_DEATH1 = "monsters/kelly_sounds/slv_die1.wav";
		const string SOUND_DEATH2 = "monsters/kelly_sounds/slv_die2.wav";
		const string SOUND_STRUCK1 = "xxx";
		const string SOUND_STRUCK2 = "xxx";
		const string SOUND_PAIN1 = "monsters/kelly_sounds/slv_pain1.wav";
		const string SOUND_PAIN2 = "monsters/kelly_sounds/slv_pain2.wav";
		const string SOUND_IDLE1 = "monsters/kelly_sounds/slv_word1.wav";
		const string SOUND_IDLE2 = "monsters/kelly_sounds/slv_word2.wav";
		const string SOUND_IDLE3 = "monsters/kelly_sounds/slv_word3.wav";
		const string SOUND_IDLE4 = "monsters/kelly_sounds/slv_word4.wav";
		const string SOUND_IDLE5 = "monsters/kelly_sounds/slv_word5.wav";
		const string SOUND_IDLE6 = "monsters/kelly_sounds/slv_word6.wav";
		const string SOUND_IDLE7 = "monsters/kelly_sounds/slv_word7.wav";
		const string SOUND_IDLE8 = "monsters/kelly_sounds/slv_word8.wav";
	}

	void OnSpawn() override
	{
		SetDamageResistance("poison", 0.0);
		rabid_skele_spawn();
		ScheduleDelayedEvent(0.1, "idle_loop");
	}

	void rabid_skele_spawn()
	{
		SetName("Rabid Poisonbone");
		SetModel("monsters/rabid_skelly.mdl");
		SetRace("undead");
		SetBloodType("none");
		SetHearingSensitivity(4);
		NPC_GIVE_EXP = 60;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetWidth(32);
		SetHeight(64);
		SetProp(GetOwner(), "skin", 3);
		SetHealth(200);
		SetDamageResistance("holy", 2.0);
	}

	void idle_loop()
	{
		FREQ_IDLE("idle_loop");
		string RND_SOUND = RandomInt(1, 8);
		if (RND_SOUND == 1)
		{
			EmitSound(GetOwner(), 2, SOUND_IDLE1, 10);
		}
		if (RND_SOUND == 2)
		{
			EmitSound(GetOwner(), 2, SOUND_IDLE2, 10);
		}
		if (RND_SOUND == 3)
		{
			EmitSound(GetOwner(), 2, SOUND_IDLE3, 10);
		}
		if (RND_SOUND == 4)
		{
			EmitSound(GetOwner(), 2, SOUND_IDLE4, 10);
		}
		if (RND_SOUND == 5)
		{
			EmitSound(GetOwner(), 2, SOUND_IDLE5, 10);
		}
		if (RND_SOUND == 6)
		{
			EmitSound(GetOwner(), 2, SOUND_IDLE6, 10);
		}
		if (RND_SOUND == 7)
		{
			EmitSound(GetOwner(), 2, SOUND_IDLE7, 10);
		}
		if (RND_SOUND == 8)
		{
			EmitSound(GetOwner(), 2, SOUND_IDLE8, 10);
		}
		string RND_ANIM = RandomInt(1, 3);
		if (RND_ANIM == 1)
		{
			PlayAnim("once", ANIM_IDLE1);
		}
		if (RND_ANIM == 3)
		{
			PlayAnim("once", ANIM_IDLE3);
		}
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((param4).findFirst("effect") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		npcatk_flee(GetEntityIndex(m_hLastStruck), 1024, 5.0);
	}

	void npcatk_lost_sight()
	{
		PlayAnim("once", "idle1");
		DID_WARCRY = 0;
	}

	void my_target_died()
	{
		DID_WARCRY = 0;
	}

	void npc_targetsighted()
	{
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			do_warcry();
		}
		check_projectile();
	}

	void do_warcry()
	{
		PlayAnim("once", "idle2");
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void turn_undead()
	{
		EmitSound(GetOwner(), 0, SOUND_PAIN1, 10);
		if (RandomInt(1, param1) < TURN_REQ)
		{
			npcatk_flee(GetEntityIndex(param2), 1024, 5.0);
		}
	}

	void check_projectile()
	{
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
	}

}

}
