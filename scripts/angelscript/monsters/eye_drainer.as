#pragma context server

#include "monsters/base_flyer.as"
#include "monsters/base_propelled.as"
#include "monsters/base_monster.as"

namespace MS
{

class EyeDrainer : CGameScript
{
	int AM_SUMMONED;
	int ANG_HOVER;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BEAM_ACTIVE;
	string BEAM_ID;
	int DOING_DODGE;
	string DOING_FS_DODGE;
	string EYE_STUCK_POS;
	int IDLE_MODE;
	int IS_UNHOLY;
	int MOVE_RANGE;
	string MY_OWNER;
	string NEXT_RENDER_CHECK;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;

	EyeDrainer()
	{
		NPC_GIVE_EXP = 200;
		const int NPC_NO_END_FLY = 1;
		NPC_HACKED_MOVE_SPEED = 100;
		MOVE_RANGE = 128;
		ATTACK_RANGE = 128;
		ATTACK_HITRANGE = 128;
		ANIM_ATTACK = "idle_standard";
		ANIM_WALK = "idle_standard";
		ANIM_RUN = "idle_standard";
		ANIM_IDLE = "spin_horizontal_slow";
		ANIM_DEATH = "spin_horizontal_fast";
		const string ANIM_SPIN = "spin_horizontal_slow";
		IS_UNHOLY = 1;
		const string SOUND_BEAM_LOOP = "x/x_teleattack1.wav";
		const string SOUND_STRUCK = "weapons/cbar_hitbod1.wav";
		const string SOUND_PAIN1 = "houndeye/he_pain2.wav";
		const string SOUND_PAIN2 = "houndeye/he_pain5.wav";
		const string SOUND_KILL = "houndeye/he_blast3.wav";
		const string SOUND_DEATH = "turret/tu_die2.wav";
		const string SOUND_HOVER_LOOP = "ambience/labdrone2.wav";
		Precache(SOUND_DEATH);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		// svplaysound: svplaysound 4 0 SOUND_HOVER_LOOP
		EmitSound(4, 0, SOUND_HOVER_LOOP);
		ScheduleDelayedEvent(0.1, "hover_loop");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		if ((AM_SUMMONED))
		{
		}
		if (!(BEAM_ACTIVE))
		{
		}
		if (EYE_STUCK_POS == GetMonsterProperty("origin"))
		{
			npc_suicide();
		}
		EYE_STUCK_POS = "game.monstemr.origin";
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(1.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		string MY_POS = GetMonsterProperty("origin");
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(MY_POS);
		string GROUND_LOC = MY_POS;
		GROUND_LOC = "z";
		if (Distance(MY_POS, GROUND_LOC) < 16)
		{
			if (!(DOING_FS_DODGE))
			{
			}
			DOING_FS_DODGE = 1;
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, -110));
			ScheduleDelayedEvent(1.0, "reset_fs_dodge");
		}
		string UP_POS = MY_POS;
		UP_POS += "z";
		string UP_POS = TraceLine(MY_POS, UP_POS);
		if (Distance(MY_POS, UP_POS) < 16)
		{
			if (!(DOING_FS_DODGE))
			{
			}
			DOING_FS_DODGE = 1;
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 110));
			ScheduleDelayedEvent(1.0, "reset_fs_dodge");
		}
	}

	void game_dynamically_created()
	{
		AM_SUMMONED = 1;
		MY_OWNER = param1;
		ScheduleDelayedEvent(60.0, "npc_suicide");
	}

	void OnSpawn() override
	{
		SetHealth(450);
		SetWidth(16);
		SetHeight(16);
		SetName("Eye of Death");
		SetHearingSensitivity(10);
		SetRoam(true);
		SetRace("demon");
		SetModel("monsters/eye_medium_float.mdl");
		SetIdleAnim(ANIM_SPIN);
		SetMoveAnim(ANIM_WALK);
		SetMonsterClip(0);
		SetGravity(0);
		SetFly(true);
		// svplaysound: svplaysound 4 10 SOUND_HOVER_LOOP
		EmitSound(4, 10, SOUND_HOVER_LOOP);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetProp(GetOwner(), "renderfx", 16);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("pierce", 4.0);
		ANG_HOVER = 0;
		IDLE_MODE = 1;
		ScheduleDelayedEvent(3.0, "solidify_me");
		ScheduleDelayedEvent(0.1, "init_beam");
	}

	void OnPostSpawn() override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetProp(GetOwner(), "renderfx", 16);
	}

	void solidify_me()
	{
		SetProp(GetOwner(), "renderfx", 0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void init_beam()
	{
		Effect("beam", "ents", "laserbeam.spr", 30, GetOwner(), 0, GetOwner(), 0, Vector3(64, 64, 255), 0, 30, -1);
		BEAM_ID = GetEntityIndex(m_hLastCreated);
	}

	void npc_targetsighted()
	{
		if ((IDLE_MODE))
		{
			SetMoveAnim(ANIM_WALK);
			SetIdleAnim(ANIM_WALK);
			IDLE_MODE = 0;
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetGameTime() > NEXT_RENDER_CHECK)
		{
			NEXT_RENDER_CHECK = GetGameTime();
			NEXT_RENDER_CHECK += 5.0;
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 255);
		}
		if (m_hAttackTarget == "unset")
		{
			if ((BEAM_ACTIVE))
			{
			}
			beam_off();
		}
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		string TARGET_RANGE = GetEntityRange(m_hAttackTarget);
		if ((BEAM_ACTIVE))
		{
			if (TARGET_RANGE > ATTACK_RANGE)
			{
				beam_off();
			}
			else
			{
				string SEE_TARGET = false;
				if ((SEE_TARGET))
				{
					GiveMP(m_hAttackTarget);
					if (GetGameTime() > LASTATK_MESSAGE)
					{
						LASTATK_MESSAGE = GetGameTime();
						LASTATK_MESSAGE += 2.0;
						SendPlayerMessage(m_hAttackTarget, "Your soul is being drained!");
						Effect("screenfade", m_hAttackTarget, 2, 1, Vector3(0, 0, 255), 180, "fadein");
					}
					if (GetEntityMP(m_hAttackTarget) <= 0)
					{
					}
					slay_target();
				}
				if (!(SEE_TARGET))
				{
					beam_off();
				}
			}
		}
		if ((BEAM_ACTIVE)) return;
		if (!(TARGET_RANGE < ATTACK_RANGE)) return;
		beam_on();
	}

	void my_target_died()
	{
		beam_off();
	}

	void npcatk_clear_targets()
	{
		IDLE_MODE = 1;
		SetMoveAnim(ANIM_SPIN);
		SetIdleAnim(ANIM_SPIN);
	}

	void beam_on()
	{
		BEAM_ACTIVE = 1;
		Effect("beam", "update", BEAM_ID, "end_target", m_hAttackTarget, 0);
		Effect("beam", "update", BEAM_ID, "brightness", 200);
		// svplaysound: svplaysound 1 10 SOUND_BEAM_LOOP
		EmitSound(1, 10, SOUND_BEAM_LOOP);
	}

	void beam_off()
	{
		// svplaysound: svplaysound 1 0 SOUND_BEAM_LOOP
		EmitSound(1, 0, SOUND_BEAM_LOOP);
		Effect("beam", "update", BEAM_ID, "end_target", GetEntityIndex(GetOwner()), 0);
		Effect("beam", "update", BEAM_ID, "brightness", 0);
		BEAM_ACTIVE = 0;
	}

	void slay_target()
	{
		SendPlayerMessage(m_hAttackTarget, "Your soul has been drained.");
		DoDamage(m_hAttackTarget, "direct", 99999, 1.0, GetOwner());
		EmitSound(GetOwner(), 2, SOUND_KILL, 10);
	}

	void hover_loop()
	{
		// svplaysound: svplaysound 4 10 SOUND_HOVER_LOOP
		EmitSound(4, 10, SOUND_HOVER_LOOP);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		beam_off();
		Effect("beam", "update", BEAM_ID, "remove", 0.1);
		// svplaysound: svplaysound 4 0 SOUND_HOVER_LOOP
		EmitSound(4, 0, SOUND_HOVER_LOOP);
		// svplaysound: svplaysound 1 0 SOUND_BEAM_LOOP
		EmitSound(1, 0, SOUND_BEAM_LOOP);
		CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()), 5);
		if (!(AM_SUMMONED)) return;
		if (!(IsEntityAlive(MY_OWNER))) return;
		CallExternal(MY_OWNER, "eye_died");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(DOING_DODGE))
		{
			do_dodge();
		}
		EmitSound(GetOwner(), 1, SOUND_STRUCK, 5);
	}

	void do_dodge()
	{
		if ((DOING_FS_DODGE)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		DOING_DODGE = 1;
		string RND_FB = Random(0, -120);
		string RND_RL = Random(-120, 120);
		string RND_UD = Random(-120, 120);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_RL, RND_FB, RND_UD));
		ScheduleDelayedEvent(1.0, "reset_dodge");
	}

	void reset_dodge()
	{
		DOING_DODGE = 0;
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
	}

	void reset_fs_dodge()
	{
		DOING_FS_DODGE = 0;
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
	}

}

}
