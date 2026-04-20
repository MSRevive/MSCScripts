#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class ZombieZygol : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_DEATH3;
	string ANIM_DEATH4;
	string ANIM_DEATH5;
	string ANIM_DISEASE;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SWIPE;
	string ANIM_WALK;
	float ATTACK_DAMAGE;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float BASE_FRAMERATE;
	float BASE_MOVERATE;
	float BEAM_DUR;
	int CAN_FLINCH;
	int DID_WARCRY;
	int DISEASE_DELAY;
	float DISEASE_DMG;
	int DISEASE_DUR;
	float DISEASE_FREQ;
	int EYE_HP;
	int EYE_POWER;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	float FREQ_TBEAM;
	int HEAR_RANGE_MAX;
	int HEAR_RANGE_PLAYER;
	int I_ATTACKING;
	int I_DISEASE;
	int ME_NO_WANDER;
	string MONSTER_MODEL;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int N_EYES;
	int PAIN_DELAY;
	string SOUND_DEATH;
	string SOUND_HIT1;
	string SOUND_HIT2;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_IDLE4;
	string SOUND_MISS1;
	string SOUND_MISS2;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;
	string SOUND_RAGE1;
	string SOUND_RAGE2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_WARCRY1;
	string SOUND_WARCRY2;
	string SOUND_WARCRY3;
	int TBEAM_DELAY;
	string TBEAM_IDX;
	string TBEAM_LASTFX;
	int TBEAM_ON;
	string TBEAM_TARG;
	int TBEAM_VIS;

	ZombieZygol()
	{
		if (StringToLower(GetMapName()) == "lostcaverns")
		{
			NPC_IS_BOSS = 1;
		}
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_RESTORATION = 0.5;
		FREQ_TBEAM = 30.0;
		BEAM_DUR = 15.0;
		EYE_HP = 1000;
		EYE_POWER = 50;
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_SWIPE = "attack1";
		ANIM_DISEASE = "attack2";
		ANIM_ATTACK = ANIM_SWIPE;
		ANIM_DEATH = "diesimple";
		ANIM_IDLE = "idle1";
		ANIM_DEATH1 = "diesimple";
		ANIM_DEATH2 = "diebackward";
		ANIM_DEATH3 = "dieheadshot";
		ANIM_DEATH4 = "dieheadshot2";
		ANIM_DEATH5 = "dieforward";
		ANIM_DEATH = ANIM_DEATH1;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 30;
		SOUND_IDLE1 = "garg/gar_breathe1.wav";
		SOUND_IDLE2 = "garg/gar_breathe2.wav";
		SOUND_IDLE3 = "garg/gar_breathe3.wav";
		SOUND_IDLE4 = "garg/gar_idle4.wav";
		SOUND_PAIN1 = "garg/gar_idle1.wav";
		SOUND_PAIN2 = "garg/gar_idle2.wav";
		SOUND_PAIN3 = "garg/gar_idle3.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_WARCRY1 = "garg/gar_alert1.wav";
		SOUND_WARCRY2 = "garg/gar_alert2.wav";
		SOUND_WARCRY3 = "garg/gar_alert3.wav";
		SOUND_RAGE1 = "garg/gar_attack1.wav";
		SOUND_RAGE2 = "garg/gar_attack2.wav";
		SOUND_DEATH = "garg/gar_die1.wav";
		SOUND_MISS1 = "zombie/claw_miss1.wav";
		SOUND_MISS2 = "zombie/claw_miss2.wav";
		SOUND_HIT1 = "zombie/claw_strike1.wav";
		SOUND_HIT2 = "zombie/claw_strike2.wav";
		Precache(SOUND_DEATH);
		ATTACK_DAMAGE = Random(100, 200);
		ATTACK_RANGE = 120;
		ATTACK_HITRANGE = 150;
		ATTACK_HITCHANCE = 80;
		ATTACK_MOVERANGE = 80;
		DISEASE_FREQ = 5.0;
		DISEASE_DMG = Random(13, 16);
		DISEASE_DUR = RandomInt(20, 25);
		NPC_GIVE_EXP = 1000;
		MONSTER_MODEL = "monsters/zombie_huge.mdl";
		Precache(MONSTER_MODEL);
		ME_NO_WANDER = 1;
		HEAR_RANGE_MAX = 200;
		HEAR_RANGE_PLAYER = 200;
	}

	void OnSpawn() override
	{
		SetName("Zygoli , The All Seeing");
		SetModel(MONSTER_MODEL);
		SetHealth(6000);
		SetWidth(50);
		SetHeight(110);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		PlayAnim("once", ANIM_IDLE);
		SetRace("undead");
		SetHearingSensitivity(3);
		SetRoam(true);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("fire", 2.0);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("blunt", 1.0);
		SetDamageResistance("slash", 1.0);
		BASE_MOVERATE = 1.5;
		BASE_FRAMERATE = 1.5;
		SetMoveSpeed(1.5);
		SetAnimMoveSpeed(1.5);
		SetAnimFrameRate(1.5);
		ScheduleDelayedEvent(1.0, "idle_sounds");
		ScheduleDelayedEvent(0.1, "setup_eyes");
	}

	void setup_eyes()
	{
		N_EYES = 4;
		update_eyes();
		string EYE_POS = GetEntityOrigin(GetOwner());
		EYE_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 64, 100));
		SpawnNPC("monsters/summon/zy_eye", EYE_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), EYE_HP, EYE_POWER
		ScheduleDelayedEvent(0.1, "setup_eye2");
	}

	void setup_eye2()
	{
		string EYE_POS = GetEntityOrigin(GetOwner());
		EYE_POS += /* TODO: $relpos */ $relpos(Vector3(0, 90, 0), Vector3(0, 64, 100));
		SpawnNPC("monsters/summon/zy_eye", EYE_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), EYE_HP, EYE_POWER
		ScheduleDelayedEvent(0.1, "setup_eye3");
	}

	void setup_eye3()
	{
		string EYE_POS = GetEntityOrigin(GetOwner());
		EYE_POS += /* TODO: $relpos */ $relpos(Vector3(0, 180, 0), Vector3(0, 64, 100));
		SpawnNPC("monsters/summon/zy_eye", EYE_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), EYE_HP, EYE_POWER
		ScheduleDelayedEvent(0.1, "setup_eye4");
	}

	void setup_eye4()
	{
		string EYE_POS = GetEntityOrigin(GetOwner());
		EYE_POS += /* TODO: $relpos */ $relpos(Vector3(0, 270, 0), Vector3(0, 64, 100));
		SpawnNPC("monsters/summon/zy_eye", EYE_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), EYE_HP, EYE_POWER
	}

	void respawn_eye()
	{
		SendInfoMsg("all", "ZYGOLI THE ALL SEEING Has summoned a new eye.");
		N_EYES += 1;
		SpawnNPC("monsters/summon/zy_eye", /* TODO: $relpos */ $relpos(0, 0, 150), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), EYE_HP, EYE_POWER
		ScheduleDelayedEvent(0.1, "update_eyes");
	}

	void ext_eye_died()
	{
		N_EYES -= 1;
		npc_flinch();
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 200, 1.0, 1.0);
		ScheduleDelayedEvent(0.1, "update_eyes");
		ScheduleDelayedEvent(120.0, "respawn_eye");
	}

	void update_eyes()
	{
		if (N_EYES == 0)
		{
			SetDamageResistance("all", 1.0);
		}
		if (N_EYES == 1)
		{
			SetDamageResistance("all", 0.5);
		}
		if (N_EYES == 2)
		{
			SetDamageResistance("all", 0.3);
		}
		if (N_EYES == 3)
		{
			SetDamageResistance("all", 0.1);
		}
		if (N_EYES < 4)
		{
			SetInvincible(false);
		}
		if (N_EYES == 4)
		{
			SetDamageResistance("all", 0.0);
			SetInvincible(true);
		}
	}

	void idle_sounds()
	{
		if (m_hAttackTarget == "unset")
		{
			// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4
			array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (m_hAttackTarget != "unset")
		{
			// PlayRandomSound from: SOUND_RAGE1, SOUND_RAGE2
			array<string> sounds = {SOUND_RAGE1, SOUND_RAGE2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
		float NEXT_SOUND = Random(4, 15);
		NEXT_SOUND("idle_sounds");
	}

	void walk_step1()
	{
		EmitSound(GetOwner(), 0, "garg/gar_step1.wav", 10);
	}

	void walk_step2()
	{
		EmitSound(GetOwner(), 0, "garg/gar_step2.wav", 10);
	}

	void walk_step3()
	{
		EmitSound(GetOwner(), 0, "garg/gar_step1.wav", 10);
	}

	void walk_step4()
	{
		EmitSound(GetOwner(), 0, "garg/gar_step2.wav", 10);
	}

	void walk_step5()
	{
		EmitSound(GetOwner(), 0, "garg/gar_step1.wav", 10);
	}

	void walk_step6()
	{
		EmitSound(GetOwner(), 0, "garg/gar_step2.wav", 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		int PICK_DEATH = RandomInt(1, 5);
		if (PICK_DEATH == 1)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
		if (PICK_DEATH == 2)
		{
			ANIM_DEATH = ANIM_DEATH2;
		}
		if (PICK_DEATH == 3)
		{
			ANIM_DEATH = ANIM_DEATH3;
		}
		if (PICK_DEATH == 4)
		{
			ANIM_DEATH = ANIM_DEATH4;
		}
		if (PICK_DEATH == 5)
		{
			ANIM_DEATH = ANIM_DEATH5;
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(PAIN_DELAY))
		{
			ScheduleDelayedEvent(0.1, "pain_sound");
		}
	}

	void pain_sound()
	{
		PAIN_DELAY = 1;
		string Random(5, 10) = NEXT_PAIN;
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		NEXT_PAIN("pain_delay_reset");
	}

	void pain_delay_reset()
	{
		PAIN_DELAY = 0;
	}

	void OnFlinch()
	{
		int R_FLINCH = RandomInt(1, 4);
		if (R_FLINCH == 1)
		{
			FLINCH_ANIM = "flinchsmall";
		}
		if (R_FLINCH == 2)
		{
			FLINCH_ANIM = "flinch";
		}
		if (R_FLINCH == 3)
		{
			FLINCH_ANIM = "bigflinch";
		}
		if (R_FLINCH == 4)
		{
			FLINCH_ANIM = "llflinch";
		}
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void attack_1()
	{
		I_ATTACKING = 1;
		string F_ATTACK_DAMAGE = ATTACK_DAMAGE;
		F_ATTACK_DAMAGE *= N_EYES;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, F_ATTACK_DAMAGE, ATTACK_HITCHANCE, "blunt");
	}

	void attack_2()
	{
		I_ATTACKING = 1;
		string F_ATTACK_DAMAGE = ATTACK_DAMAGE;
		F_ATTACK_DAMAGE *= N_EYES;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, F_ATTACK_DAMAGE, ATTACK_HITCHANCE, "blunt");
		I_DISEASE = 1;
		ANIM_ATTACK = ANIM_SWIPE;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((DID_WARCRY)) return;
		DID_WARCRY = 1;
		DISEASE_DELAY = 1;
		DISEASE_FREQ("reset_disease_delay");
		// PlayRandomSound from: SOUND_WARCRY1, SOUND_WARCRY2, SOUND_WARCRY3
		array<string> sounds = {SOUND_WARCRY1, SOUND_WARCRY2, SOUND_WARCRY3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		FREQ_TBEAM("do_tbeam");
	}

	void npc_selectattack()
	{
		if ((DISEASE_DELAY)) return;
		DISEASE_DELAY = 1;
		DISEASE_FREQ("reset_disease_delay");
		ANIM_ATTACK = ANIM_DISEASE;
	}

	void game_dodamage()
	{
		if (!(I_ATTACKING)) return;
		I_ATTACKING = 0;
		if ((param1))
		{
			// PlayRandomSound from: SOUND_HIT1, SOUND_HIT2
			array<string> sounds = {SOUND_HIT1, SOUND_HIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (!(param1))
		{
			// PlayRandomSound from: SOUND_MISS1, SOUND_MISS2
			array<string> sounds = {SOUND_MISS1, SOUND_MISS2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (!(I_DISEASE)) return;
		I_DISEASE = 0;
		if (!(param1)) return;
		ApplyEffect(param2, "effects/dot_poison", DISEASE_DUR, GetEntityIndex(GetOwner()), DISEASE_DMG, "none");
	}

	void reset_tbeam_delay()
	{
		TBEAM_DELAY = 0;
	}

	void do_tbeam()
	{
		FREQ_TBEAM("do_tbeam");
		if (!(false)) return;
		TBEAM_TARG = GetEntityIndex(m_hLastSeen);
		TBEAM_ON = 1;
		TBEAM_VIS = 0;
		tbeam_loop();
		BEAM_DUR("end_tbeam");
	}

	void end_tbeam()
	{
		ClientEvent("update", "all", TBEAM_IDX, "dbeam_off");
		TBEAM_ON = 0;
		TBEAM_VIS = 0;
	}

	void tbeam_loop()
	{
		if (!(TBEAM_ON)) return;
		ScheduleDelayedEvent(0.2, "tbeam_loop");
		string CAN_SEE_BTARG = false;
		if ((CAN_SEE_BTARG))
		{
			AddVelocity(TBEAM_TARG, /* TODO: $relvel */ $relvel(10, -300, 10));
			if (GetEntityRange(TBEAM_TARG) > ATTACK_RANGE)
			{
				NPC_FORCED_MOVEDEST = 1;
				SetMoveDest(TBEAM_TARG);
			}
			if (!(TBEAM_VIS))
			{
				TBEAM_VIS = 1;
				ClientEvent("update", "all", TBEAM_IDX, "dbeam_target", GetEntityIndex(TBEAM_TARG));
			}
			float DIFF_TIME = GetGameTime();
			DIFF_TIME -= TBEAM_LASTFX;
			if (DIFF_TIME > 5.0)
			{
			}
			TBEAM_LASTFX = GetGameTime();
			DoDamage(TBEAM_TARG, "direct", 10.0, 1.0, GetOwner());
			EmitSound(GetOwner(), 0, "magic/pulsemachine_noloop.wav", 5);
		}
		if (!(CAN_SEE_BTARG))
		{
			TBEAM_VIS = 0;
			ClientEvent("update", "all", TBEAM_IDX, "dbeam_off");
		}
	}

	void OnPostSpawn() override
	{
		ClientEvent("new", "all", "effects/dynamic_beam_cl", GetEntityIndex(GetOwner()), Vector3(255, 0, 0), 100);
		TBEAM_IDX = "game.script.last_sent_id";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("update", "all", TBEAM_IDX, "effect_die");
		CallExternal("all", "zygoli_died");
	}

}

}
