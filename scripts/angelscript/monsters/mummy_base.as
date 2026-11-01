#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class MummyBase : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK_LONG;
	string ANIM_ATTACK_SHORT;
	string ANIM_BITE;
	string ANIM_BREATH;
	string ANIM_BREATH_PREP;
	string ANIM_BREATH_START;
	string ANIM_BREATH_WALK;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_DEATH_IDLE;
	string ANIM_DEATH_IDLE1;
	string ANIM_DEATH_IDLE2;
	string ANIM_EAT;
	string ANIM_EAT_TO_STAND;
	string ANIM_FLINCH1;
	string ANIM_FLINCH2;
	string ANIM_HEAL;
	string ANIM_IDLE;
	string ANIM_PIKE_HOLD;
	string ANIM_PRE_REBIRTH1;
	string ANIM_PRE_REBIRTH2;
	string ANIM_REBIRTH1;
	string ANIM_REBIRTH2;
	string ANIM_RUN;
	string ANIM_SQUAT;
	string ANIM_SQUAT_TO_STAND;
	string ANIM_STEELPIPE;
	string ANIM_SUMMON;
	string ANIM_UNARMED1;
	string ANIM_UNARMED2;
	string ANIM_UNARMED3;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITCHANCE;
	string ATTACK_HITRANGE;
	int ATTACK_HITRANGE_BITE;
	int ATTACK_HITRANGE_LONG;
	int ATTACK_HITRANGE_SHORT;
	string ATTACK_MOVERANGE;
	string ATTACK_RANGE;
	int ATTACK_RANGE_BITE;
	int ATTACK_RANGE_LONG;
	int ATTACK_RANGE_SHORT;
	string ATTACK_TYPE;
	int AURA_RANGE;
	int AURA_TYPE;
	int CAN_HEAR;
	int DMG_BITE;
	int DMG_LONGSLASH;
	int DMG_PUSH_BEAM;
	int DMG_SLASH;
	int DMG_STAB;
	int DMG_STEELPIPE;
	string FLINCH_ANIM;
	float FLINCH_CHANCE;
	string FLINCH_HEALTH;
	float FLINCH_HEALTH_RATIO;
	float FREQ_MUMMY_BEAM_ATTACK;
	float FREQ_MUMMY_BITE;
	float FREQ_MUMMY_BREATH_ATTACK;
	int MUMMY_BACKHAND;
	int MUMMY_BEAMING;
	string MUMMY_BEAM_ABORT_TIME;
	int MUMMY_BEAM_ATTACK;
	float MUMMY_BEAM_DUR;
	string MUMMY_BEAM_ID;
	string MUMMY_BEAM_TARGET;
	int MUMMY_BREATHING;
	int MUMMY_BREATH_ATTACK;
	string MUMMY_BREATH_ATTACK_CLSCRIPT;
	int MUMMY_BREATH_ATTACK_OFS;
	int MUMMY_BREATH_ATTACK_RANGE;
	string MUMMY_BREATH_ATTACK_TYPE;
	int MUMMY_BREATH_CONE;
	int MUMMY_BREATH_DOT;
	float MUMMY_BREATH_DOT_DURATION;
	float MUMMY_BREATH_DURATION;
	string MUMMY_BREATH_TARGET;
	string MUMMY_BREATH_TARGETS;
	string MUMMY_CANT_GET_UP;
	int MUMMY_CLERIC_RANGE;
	string MUMMY_CUR_CYCLE_ATTACK;
	int MUMMY_CYCLES_STARTED;
	string MUMMY_DEFAULT_ANIM_IDLE;
	string MUMMY_DEFAULT_ANIM_RUN;
	string MUMMY_DEFAULT_ANIM_WALK;
	string MUMMY_DMG_LONGSLASH;
	string MUMMY_DMG_SLASH;
	string MUMMY_DMG_STAB;
	string MUMMY_DMG_STEELPIPE;
	string MUMMY_HEAL_FLAG;
	string MUMMY_HEAL_LIST;
	string MUMMY_HEAL_TARGET;
	int MUMMY_HIT_BY_HOLY;
	string MUMMY_ICE_TARGETS;
	int MUMMY_IS_CLERIC;
	string MUMMY_LIVES;
	string MUMMY_MELEE_DMG_TYPE;
	string MUMMY_MELEE_DMG_TYPE_FINAL;
	int MUMMY_MUNCHES;
	string MUMMY_NAME;
	string MUMMY_NEXT_BITE;
	string MUMMY_NEXT_PIKE_TOSS;
	string MUMMY_NEXT_SUMMON;
	string MUMMY_NO_HEALS;
	string MUMMY_PUSH_ATTACK;
	string MUMMY_REALLY_CANT_GET_UP;
	string MUMMY_REBIRTH_SCAN;
	string MUMMY_RESUME_MODE;
	int MUMMY_STARTING_LIVES;
	string MUMMY_START_EAT;
	string MUMMY_START_SQUAT;
	string MUMMY_STUN_ATTACK;
	string MUMMY_TOSSING_PIKE;
	int NO_STUCK_CHECKS;
	int NPC_FORCED_MOVEDEST;
	int NPC_NO_ATTACK;
	string NPC_PREV_TARGET;
	int NPC_PROXACT_CONE;
	string NPC_PROXACT_EVENT;
	int NPC_PROXACT_FOV;
	int NPC_PROXACT_IFSEEN;
	string NPC_PROXACT_RANGE;
	int NPC_PROXACT_TRIPPED;
	int NPC_PROX_ACTIVATE;
	int PLAYING_DEAD;
	string REPULSE_TARGETS;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_BEAM_LOOP;
	string SOUND_BEAM_START;
	string SOUND_BITE_HIT;
	string SOUND_BITE_START;
	string SOUND_BREATH_END;
	string SOUND_BREATH_LOOP;
	string SOUND_BREATH_PREP;
	string SOUND_DEATH;
	string SOUND_HEALED;
	string SOUND_HEAL_OTHER;
	string SOUND_LOOP_AURA1;
	string SOUND_LOOP_AURA2;
	string SOUND_MUMMY_BREATH;
	string SOUND_PIKE_TOSS;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_SUMMON;

	MummyBase()
	{
		ANIM_DEATH = "dieforward";
		ANIM_BREATH_START = "walkB";
		ANIM_BREATH_WALK = "walkB1";
		ANIM_EAT = "eat";
		ANIM_SQUAT = "trauma";
		ANIM_EAT_TO_STAND = "Egetup";
		ANIM_SQUAT_TO_STAND = "Tgetup";
		ANIM_BREATH_PREP = "walkB";
		ANIM_BREATH = "walkB1";
		ANIM_ATTACK_SHORT = "steelpipe";
		ANIM_ATTACK_LONG = "longslash";
		ANIM_HEAL = "stab";
		ANIM_FLINCH1 = "flinch";
		ANIM_FLINCH2 = "flinch1";
		ANIM_DEATH1 = "dieforward";
		ANIM_DEATH2 = "diebackward";
		ANIM_DEATH1 = "dieforward";
		ANIM_PRE_REBIRTH1 = "seizure";
		ANIM_REBIRTH1 = "getupforw";
		ANIM_DEATH_IDLE1 = "dieforward_idle";
		ANIM_DEATH2 = "diebackward";
		ANIM_PRE_REBIRTH2 = "seizure1";
		ANIM_REBIRTH2 = "getupback";
		ANIM_DEATH_IDLE2 = "diebackward_idle";
		ANIM_UNARMED1 = "slash";
		ANIM_UNARMED2 = "slash1";
		ANIM_UNARMED3 = "stab1";
		ANIM_BITE = "bite";
		ANIM_STEELPIPE = "steelpipe";
		ANIM_PIKE_HOLD = "pike_hold";
		ANIM_SUMMON = "pike_hold";
		FLINCH_CHANCE = 0.2;
		FLINCH_HEALTH_RATIO = 0.25;
		MUMMY_MELEE_DMG_TYPE = "slash";
		MUMMY_MUNCHES = 0;
		FREQ_MUMMY_BITE = 10.0;
		MUMMY_CLERIC_RANGE = 1024;
		ATTACK_RANGE_SHORT = 64;
		ATTACK_HITRANGE_SHORT = 96;
		ATTACK_RANGE_LONG = 140;
		ATTACK_HITRANGE_LONG = 175;
		ATTACK_RANGE_BITE = 52;
		ATTACK_HITRANGE_BITE = 53;
		ATTACK_HITCHANCE = 80;
		ATTACK_TYPE = "short";
		MUMMY_STARTING_LIVES = 1;
		AURA_TYPE = 0;
		AURA_RANGE = 100;
		DMG_SLASH = 200;
		DMG_LONGSLASH = 400;
		DMG_STAB = 400;
		DMG_STEELPIPE = 200;
		DMG_BITE = 1000;
		MUMMY_IS_CLERIC = 0;
		MUMMY_BREATH_ATTACK = 0;
		MUMMY_BREATH_ATTACK_TYPE = "bile";
		MUMMY_BREATH_DOT = 50;
		MUMMY_BREATH_DOT_DURATION = 10.0;
		MUMMY_BREATH_ATTACK_RANGE = 300;
		MUMMY_BREATH_ATTACK_OFS = 150;
		MUMMY_BREATH_CONE = 30;
		FREQ_MUMMY_BREATH_ATTACK = 35.0;
		MUMMY_BREATH_DURATION = 4.0;
		MUMMY_BREATH_ATTACK_CLSCRIPT = "monsters/mummy_bile_attack_cl";
		MUMMY_BEAM_ATTACK = 0;
		FREQ_MUMMY_BEAM_ATTACK = Random(20.0, 30.0);
		DMG_PUSH_BEAM = 50;
		MUMMY_BEAM_DUR = 5.0;
		SOUND_LOOP_AURA1 = "magic/chant_loop.wav";
		SOUND_LOOP_AURA2 = "magic/haunted_loop.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_DEATH = "agrunt/ag_die3.wav";
		SOUND_BREATH_PREP = "monsters/mummy/c_mummycom_bat2.wav";
		SOUND_MUMMY_BREATH = "monsters/mummy/c_mummycom_bat1.wav";
		SOUND_BREATH_LOOP = "magic/bolt_loop.wav";
		SOUND_BREATH_END = "magic/bolt_end.wav";
		SOUND_HEALED = "magic/heal_strike.wav";
		SOUND_HEAL_OTHER = "magic/cast.wav";
		SOUND_BITE_START = "monsters/mummy/c_mummycom_bat2.wav";
		SOUND_BITE_HIT = "bullchicken/bc_bite3.wav";
		SOUND_PIKE_TOSS = "zombie/claw_miss2.wav";
		SOUND_SUMMON = "magic/spawn_loud.wav";
		SOUND_BEAM_START = "magic/bolt_end.wav";
		SOUND_BEAM_LOOP = "magic/bolt_loop.wav";
	}

	void OnSpawn() override
	{
		SetModel("monsters/mummy.mdl");
		SetWidth(28);
		SetHeight(72);
		SetBloodType("none");
		SetRace("undead");
		MUMMY_MELEE_DMG_TYPE_FINAL = MUMMY_MELEE_DMG_TYPE;
		MUMMY_DMG_SLASH = DMG_SLASH;
		MUMMY_DMG_LONGSLASH = DMG_LONGSLASH;
		MUMMY_DMG_STAB = DMG_STAB;
		MUMMY_DMG_STEELPIPE = DMG_STEELPIPE;
		mummy_immunes();
		mummy_spawn();
		MUMMY_NAME = GetEntityProperty(GetOwner(), "name.full");
		MUMMY_LIVES = MUMMY_STARTING_LIVES;
		if ((MUMMY_START_EAT))
		{
			mummy_force_eat_mode("init");
		}
		if ((MUMMY_START_SQUAT))
		{
			mummy_force_squat_mode("init");
		}
		if (AURA_TYPE == 1)
		{
			SetModelBody(3, 1);
			mummy_aura_sound1();
			mummy_repulse_aura();
			NPC_PROXACT_RANGE = 384;
		}
		if (AURA_TYPE == 2)
		{
			SetModelBody(3, 4);
			mummy_aura_sound1();
			mummy_ice_aura();
			NPC_PROXACT_RANGE = 384;
		}
		if (AURA_TYPE == 3)
		{
			SetModelBody(3, 4);
			mummy_aura_sound2();
			mummy_necro_aura();
			NPC_PROXACT_RANGE = 384;
		}
		if (!(NPC_PROX_ACTIVATE))
		{
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_WALK);
			SetHearingSensitivity(6);
			SetRoam(true);
		}
		if ((MUMMY_IS_CLERIC))
		{
			ScheduleDelayedEvent(1.0, "mummy_cleric_cycle");
		}
		if ((MUMMY_THROWS_PIKE))
		{
			ScheduleDelayedEvent(1.0, "mummy_pike_check");
		}
		if ((MUMMY_IS_NECRO))
		{
			ScheduleDelayedEvent(1.0, "mummy_necro_summon");
		}
		MUMMY_DEFAULT_ANIM_RUN = ANIM_RUN;
		MUMMY_DEFAULT_ANIM_WALK = ANIM_WALK;
		MUMMY_DEFAULT_ANIM_IDLE = ANIM_IDLE;
		FLINCH_HEALTH = GetEntityHealth(GetOwner());
		FLINCH_HEALTH *= FLINCH_HEALTH_RATIO;
		if (ATTACK_TYPE == "unarmed")
		{
			ATTACK_RANGE = 80;
			ATTACK_HITRANGE = 128;
			ATTACK_MOVERANGE = 48;
		}
		if (ATTACK_TYPE == "melee")
		{
			ATTACK_RANGE = 80;
			ATTACK_HITRANGE = 128;
			ATTACK_MOVERANGE = 48;
		}
		if (ATTACK_TYPE == "long")
		{
			ATTACK_RANGE = ATTACK_RANGE_LONG;
			ATTACK_HITRANGE = ATTACK_HITRANGE_LONG;
		}
	}

	void game_dynamically_created()
	{
		LogDebug("game_dynamically_created PARAM1 PARAM2");
		if (param1 == "squat")
		{
			MUMMY_START_SQUAT = 1;
			mummy_force_squat_mode("init");
		}
		if (param1 == "eat")
		{
			MUMMY_START_EAT = 1;
			mummy_force_eat_mode("init");
		}
	}

	void mummy_immunes()
	{
		SetDamageResistance("holy", 1.25);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("poison", 0);
		SetDamageResistance("blunt", 1.0);
		SetDamageResistance("slash", 1.1);
		SetDamageResistance("pierce", 0.5);
	}

	void cycle_up()
	{
		if ((MUMMY_CYCLES_STARTED)) return;
		MUMMY_CYCLES_STARTED = 1;
		if ((MUMMY_BREATH_ATTACK))
		{
			if (!(MUMMY_DOUBLE_CYCLE))
			{
			}
			FREQ_MUMMY_BREATH_ATTACK("mummy_breath_attack");
		}
		if ((MUMMY_BEAM_ATTACK))
		{
			if (!(MUMMY_DOUBLE_CYCLE))
			{
			}
			FREQ_MUMMY_BEAM_ATTACK("mummy_beam_attack");
		}
		if ((MUMMY_DOUBLE_CYCLE))
		{
			MUMMY_CUR_CYCLE_ATTACK = 0;
			ScheduleDelayedEvent(1.0, "mummy_double_cycle_event");
		}
	}

	void frame_slash()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK1, 10);
		LogDebug("frame_slash MUMMY_DMG_SLASH");
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE_SHORT, MUMMY_DMG_SLASH, ATTACK_HITCHANCE, "slash");
	}

	void frame_slash1()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK1, 10);
		LogDebug("frame_slash MUMMY_DMG_SLASH");
		MUMMY_BACKHAND = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE_SHORT, MUMMY_DMG_SLASH, ATTACK_HITCHANCE, "slash");
	}

	void frame_stab1()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK1, 10);
		LogDebug("frame_slash MUMMY_DMG_SLASH");
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE_SHORT, MUMMY_DMG_SLASH, ATTACK_HITCHANCE, "slash");
	}

	void frame_longslash()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK2, 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE_LONG, MUMMY_DMG_LONGSLASH, ATTACK_HITCHANCE, "slash");
	}

	void frame_stab()
	{
		if ((MUMMY_HEAL_FLAG))
		{
			MUMMY_HEAL_FLAG = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		EmitSound(GetOwner(), 0, SOUND_ATTACK2, 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE_LONG, MUMMY_DMG_STAB, ATTACK_HITCHANCE, "pierce");
	}

	void frame_steelpipe()
	{
		LogDebug("frame_steelpipe MUMMY_TOSSING_PIKE");
		if ((MUMMY_THROWS_PIKE))
		{
			MUMMY_PUSH_ATTACK = 1;
		}
		if ((MUMMY_TOSSING_PIKE))
		{
			SetModelBody(2, 0);
			MUMMY_PUSH_ATTACK = 0;
			TossProjectile(MUMMY_PROJ_NAME, /* TODO: $relpos */ $relpos(10, 64, 12), m_hAttackTarget, MUMMY_PIKE_SPEED, DMG_PIKE, 0, "none");
			EmitSound(GetOwner(), 0, SOUND_PIKE_TOSS, 10);
			MUMMY_TOSSING_PIKE = 0;
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_ATTACK2, 10);
			XDoDamage(m_hAttackTarget, ATTACK_HITRANGE_SHORT, MUMMY_DMG_STEELPIPE, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", MUMMY_MELEE_DMG_TYPE_FINAL, "dmgevent:steelpipe");
			if (MUMMY_STUN_CHANCE > 0)
			{
				MUMMY_STUN_ATTACK = 1;
			}
		}
	}

	void frame_bite_start()
	{
		EmitSound(GetOwner(), 0, SOUND_BITE_START, 10);
	}

	void frame_bite_dmg()
	{
		EmitSound(GetOwner(), 0, SOUND_BITE_HIT, 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE_BITE, DMG_BITE, 1.0, "magic");
		MUMMY_NEXT_BITE = GetGameTime();
		MUMMY_NEXT_BITE += FREQ_MUMMY_BITE;
	}

	void game_dodamage()
	{
		if ((MUMMY_STUN_ATTACK))
		{
			MUMMY_STUN_ATTACK = 0;
			if ((param1))
			{
			}
			if (RandomInt(1, 100) < MUMMY_STUN_CHANCE)
			{
			}
			ApplyEffect(param2, "effects/debuff_stun", 7.0, GetEntityIndex(GetOwner()));
		}
		if ((MUMMY_BACKHAND))
		{
			MUMMY_BACKHAND = 0;
			float RND_LF = Random(-50, 50);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(RND_LF, 300, 110));
		}
		if ((MUMMY_PUSH_ATTACK))
		{
			MUMMY_PUSH_ATTACK = 0;
			if ((param1))
			{
			}
			float RND_LF = Random(-50, 50);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(RND_LF, 600, 110));
		}
	}

	void npc_selectattack()
	{
		if (!(ATTACK_TYPE == "unarmed")) return;
		int RND_ATTACK = RandomInt(1, 3);
		if (RND_ATTACK == 1)
		{
			ANIM_ATTACK = ANIM_UNARMED1;
		}
		if (RND_ATTACK == 2)
		{
			ANIM_ATTACK = ANIM_UNARMED2;
		}
		if (RND_ATTACK == 3)
		{
			ANIM_ATTACK = ANIM_UNARMED3;
		}
		if (!(MUMMY_MUNCHES)) return;
		if (!(GetGameTime() > MUMMY_NEXT_BITE)) return;
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_RANGE_BITE)) return;
		ANIM_ATTACK = ANIM_BITE;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (ATTACK_TYPE == "long")
		{
			if (GetEntityRange(m_hAttackTarget) <= ATTACK_RANGE_SHORT)
			{
				ANIM_ATTACK = ANIM_ATTACK_SHORT;
				ATTACK_RANGE = ATTACK_RANGE_SHORT;
				ATTACK_HITRANGE = ATTACK_HITRANGE_SHORT;
				if ((MUMMY_MUNCHES))
				{
					if (GetGameTime() > MUMMY_NEXT_BITE)
					{
					}
					if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE_BITE)
					{
						ANIM_ATTACK = ANIM_BITE;
						ATTACK_RANGE = ATTACK_RANGE_BITE;
						ATTACK_HITRANGE = ATTACK_HITRANGE_BITE;
					}
				}
			}
			else
			{
				ANIM_ATTACK = ANIM_ATTACK_LONG;
				ATTACK_RANGE = ATTACK_RANGE_LONG;
				ATTACK_HITRANGE = ATTACK_HITRANGE_LONG;
			}
		}
		if (AURA_TYPE == 2)
		{
			if ((GetEntityProperty(m_hAttackTarget, "scriptvar")))
			{
			}
			if (GetEntityRange(m_hAttackTarget) <= AURA_RANGE)
			{
				ATTACK_MOVERANGE = 32;
				ANIM_ATTACK = ANIM_BITE;
				ATTACK_RANGE = ATTACK_RANGE_BITE;
				ATTACK_HITRANGE = ATTACK_HITRANGE_BITE;
			}
			else
			{
				ATTACK_MOVERANGE = 128;
				ANIM_ATTACK = ANIM_ATTACK_LONG;
				ATTACK_RANGE = ATTACK_RANGE_LONG;
				ATTACK_HITRANGE = ATTACK_HITRANGE_LONG;
			}
		}
	}

	void mummy_repulse_aura()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(0.5, "mummy_repulse_aura");
		REPULSE_TARGETS = FindEntitiesInSphere("enemy", AURA_RANGE);
		LogDebug("mummy_repulse_aura REPULSE_TARGETS");
		if (!(REPULSE_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(REPULSE_TARGETS, ";"); i++)
		{
			mummy_repulse_targets();
		}
	}

	void mummy_repulse_targets()
	{
		string CUR_TARG = GetToken(REPULSE_TARGETS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void mummy_aura_sound1()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		// svplaysound: svplaysound 2 0 SOUND_LOOP_AURA1
		EmitSound(2, 0, SOUND_LOOP_AURA1);
		// svplaysound: svplaysound 2 5 SOUND_LOOP_AURA1
		EmitSound(2, 5, SOUND_LOOP_AURA1);
		ScheduleDelayedEvent(30.0, "mummy_aura_sound1");
	}

	void mummy_aura_sound2()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		// svplaysound: svplaysound 2 0 SOUND_LOOP_AURA2
		EmitSound(2, 0, SOUND_LOOP_AURA2);
		// svplaysound: svplaysound 2 5 SOUND_LOOP_AURA2
		EmitSound(2, 5, SOUND_LOOP_AURA2);
		ScheduleDelayedEvent(30.0, "mummy_aura_sound2");
	}

	void mummy_ice_aura()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(1.0, "mummy_ice_aura");
		MUMMY_ICE_TARGETS = FindEntitiesInSphere("enemy", AURA_RANGE);
		if (!(MUMMY_ICE_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(MUMMY_ICE_TARGETS, ";"); i++)
		{
			mummy_ice_targets();
		}
	}

	void mummy_ice_targets()
	{
		string CUR_TARG = GetToken(MUMMY_ICE_TARGETS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", 5.0, GetEntityIndex(GetOwner()), AURA_DOT);
	}

	void mummy_necro_aura()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(0.5, "mummy_necro_aura");
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), AURA_RANGE, DMG_AURA, 1.0, 0);
	}

	void spawn_squatting()
	{
		MUMMY_START_SQUAT = 1;
		mummy_force_squat_mode("init");
	}

	void spawn_eating()
	{
		MUMMY_START_EAT = 1;
		mummy_force_eat_mode("init");
	}

	void mummy_getup_now()
	{
		NPC_PROXACT_TRIPPED = 1;
		if ((MUMMY_START_SQUAT))
		{
			mummy_squat_to_stand();
		}
		if ((MUMMY_START_EAT))
		{
			mummy_eat_to_stand();
		}
	}

	void mummy_force_eat_mode()
	{
		SetHearingSensitivity(0);
		SetRoam(false);
		NPC_PROXACT_TRIPPED = 0;
		NPC_PROXACT_IFSEEN = 0;
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_RANGE = 64;
		NPC_PROXACT_EVENT = "mummy_eat_to_stand";
		NPC_PROXACT_FOV = 1;
		NPC_PROXACT_CONE = 90;
		SetIdleAnim(ANIM_EAT);
		SetMoveAnim(ANIM_EAT);
		PlayAnim("critical", ANIM_EAT);
		npcatk_suspend_ai();
		if (param1 != "init")
		{
			npcatk_proxact_scan();
		}
		MUMMY_RESUME_MODE = "eat";
	}

	void mummy_force_squat_mode()
	{
		SetHearingSensitivity(0);
		SetRoam(false);
		NPC_PROXACT_TRIPPED = 0;
		NPC_PROXACT_IFSEEN = 0;
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_RANGE = 96;
		NPC_PROXACT_EVENT = "mummy_squat_to_stand";
		NPC_PROXACT_FOV = 1;
		NPC_PROXACT_CONE = 90;
		SetIdleAnim(ANIM_SQUAT);
		SetMoveAnim(ANIM_SQUAT);
		PlayAnim("critical", ANIM_SQUAT);
		npcatk_suspend_ai();
		if (param1 != "init")
		{
			npcatk_proxact_scan();
		}
		MUMMY_RESUME_MODE = "squat";
	}

	void mummy_eat_to_stand()
	{
		SetHearingSensitivity(6);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		SetRoam(true);
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_EAT_TO_STAND);
		if (!(IsEntityAlive(NPC_PROXACT_PLAYERID))) return;
		ScheduleDelayedEvent(1.1, "mummy_target_disturber");
	}

	void mummy_squat_to_stand()
	{
		SetHearingSensitivity(6);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		SetRoam(true);
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_SQUAT_TO_STAND);
		if (!(IsEntityAlive(NPC_PROXACT_PLAYERID))) return;
		ScheduleDelayedEvent(1.1, "mummy_target_disturber");
	}

	void mummy_target_disturber()
	{
		if (!(IsEntityAlive(NPC_PROXACT_PLAYERID))) return;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		npcatk_settarget(NPC_PROXACT_PLAYERID);
	}

	void my_target_died()
	{
		ScheduleDelayedEvent(1.0, "mummy_return_to_proxscan");
	}

	void mummy_return_to_proxscan()
	{
		if (!(FindEntitiesInSphere("enemy", 256) == "none")) return;
		if ((false)) return;
		if (MUMMY_RESUME_MODE == "squat")
		{
			mummy_force_squat_mode();
		}
		if (MUMMY_RESUME_MODE == "eat")
		{
			mummy_force_eat_mode();
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		mummy_auras_off();
		if (MUMMY_BREATH_ATTACK_TYPE == "lightning")
		{
			// svplaysound: if ( MUMMY_BREATH_ATTACK_TYPE equals lightning ) svplaysound 2 0 SOUND_BREATH_LOOP
			EmitSound(2, 0, SOUND_BREATH_LOOP);
		}
		if (MUMMY_BREATH_ATTACK_TYPE == "ice")
		{
			// svplaysound: if ( MUMMY_BREATH_ATTACK_TYPE equals ice ) svplaysound 3 0 SOUND_BREATH_LOOP
			EmitSound(3, 0, SOUND_BREATH_LOOP);
		}
		int RND_DEATH = RandomInt(1, 2);
		if (RND_DEATH == 1)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
		if (RND_DEATH == 2)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((MUMMY_HIT_BY_HOLY)) return;
		if (!(MUMMY_LIVES > 1)) return;
		MUMMY_LIVES -= 1;
		PLAYING_DEAD = 1;
		if (ANIM_DEATH == ANIM_DEATH1)
		{
			ANIM_DEATH_IDLE = ANIM_DEATH_IDLE1;
		}
		if (ANIM_DEATH == ANIM_DEATH2)
		{
			ANIM_DEATH_IDLE = ANIM_DEATH_IDLE2;
		}
		npcatk_suspend_ai();
		NPC_NO_ATTACK = 1;
		NO_STUCK_CHECKS = 1;
		CAN_HEAR = 0;
		SetSolid("none");
		SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
		SetInvincible(true);
		SetMoveDest("none");
		ANIM_RUN = ANIM_DEATH_IDLE;
		ANIM_WALK = ANIM_DEATH_IDLE;
		ANIM_IDLE = ANIM_DEATH_IDLE;
		SetIdleAnim(ANIM_DEATH_IDLE);
		SetMoveAnim(ANIM_DEATH_IDLE);
		SetAlive(1);
		SetRoam(false);
		RandomInt(5, 15)("mummy_rebirth_check");
	}

	void mummy_rebirth_check()
	{
		npcatk_suspend_ai();
		NPC_NO_ATTACK = 1;
		MUMMY_REBIRTH_SCAN = FindEntitiesInSphere("any", 96);
		if (ANIM_DEATH == ANIM_DEATH1)
		{
			PlayAnim("critical", ANIM_PRE_REBIRTH1);
		}
		if (ANIM_DEATH == ANIM_DEATH2)
		{
			PlayAnim("critical", ANIM_PRE_REBIRTH2);
		}
		if (MUMMY_REBIRTH_SCAN != "none")
		{
			MUMMY_CANT_GET_UP = 1;
			MUMMY_REALLY_CANT_GET_UP = 0;
			for (int i = 0; i < GetTokenCount(MUMMY_REBIRTH_SCAN, ";"); i++)
			{
				mummy_rebirth_scan_loop();
			}
			if ((MUMMY_REALLY_CANT_GET_UP))
			{
				MUMMY_CANT_GET_UP = 1;
			}
		}
		if (MUMMY_REBIRTH_SCAN == "none")
		{
			MUMMY_CANT_GET_UP = 0;
		}
		if ((MUMMY_CANT_GET_UP))
		{
			ScheduleDelayedEvent(1.0, "mummy_rebirth_check");
		}
		else
		{
			mummy_rebirth();
		}
	}

	void mummy_rebirth_scan_loop()
	{
		string CUR_TARG = GetToken(MUMMY_REBIRTH_SCAN, i, ";");
		if ((GetEntityProperty(CUR_TARG, "itemname")).findFirst("mummy") >= 0)
		{
			if ((GetEntityProperty(CUR_TARG, "scriptvar")))
			{
				if (GetGameTime() > G_MUMMY_NEXT_REBIRTH)
				{
				}
				SetGlobalVar("G_MUMMY_NEXT_REBIRTH", GetGameTime());
				G_MUMMY_NEXT_REBIRTH += 5.0;
				MUMMY_CANT_GET_UP = 0;
				LogDebug("can get up game.time vs. G_MUMMY_NEXT_REBIRTH");
			}
			else
			{
				MUMMY_CANT_GET_UP = 1;
				MUMMY_REALLY_CANT_GET_UP = 1;
			}
		}
		else
		{
			MUMMY_CANT_GET_UP = 1;
			MUMMY_REALLY_CANT_GET_UP = 1;
		}
	}

	void mummy_rebirth()
	{
		SetSolid("box");
		SetRace("undead");
		SetHealth(GetEntityMaxHealth(GetOwner()));
		NPC_GIVE_EXP /= 2;
		SetSkillLevel(NPC_GIVE_EXP);
		PLAYING_DEAD = 0;
		ScheduleDelayedEvent(1.0, "mummy_rebirth2");
	}

	void mummy_rebirth2()
	{
		SetInvincible(false);
		ANIM_RUN = MUMMY_DEFAULT_ANIM_RUN;
		ANIM_WALK = MUMMY_DEFAULT_ANIM_WALK;
		ANIM_IDLE = MUMMY_DEFAULT_ANIM_IDLE;
		NO_STUCK_CHECKS = 0;
		CAN_HEAR = 1;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		if (ANIM_DEATH == ANIM_DEATH1)
		{
			PlayAnim("critical", ANIM_REBIRTH1);
		}
		if (ANIM_DEATH == ANIM_DEATH2)
		{
			PlayAnim("critical", ANIM_REBIRTH2);
		}
		NPC_PREV_TARGET = "unset";
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		NPC_NO_ATTACK = 0;
		ScheduleDelayedEvent(1.1, "mummy_rebirth3");
	}

	void mummy_rebirth3()
	{
		SetRoam(true);
	}

	void OnDamage(int damage) override
	{
		if (!(param3 == "holy")) return;
		MUMMY_HIT_BY_HOLY = 1;
		MUMMY_LIVES = 1;
	}

	void mummy_auras_off()
	{
		SetModelBody(3, 0);
		if (AURA_TYPE == 1)
		{
			// svplaysound: if ( AURA_TYPE == 1 ) svplaysound 2 0 SOUND_LOOP_AURA1
			EmitSound(2, 0, SOUND_LOOP_AURA1);
		}
		if (AURA_TYPE == 2)
		{
			// svplaysound: if ( AURA_TYPE == 2 ) svplaysound 2 0 SOUND_LOOP_AURA2
			EmitSound(2, 0, SOUND_LOOP_AURA2);
		}
	}

	void set_no_fake_death()
	{
		MUMMY_LIVES = 1;
	}

	void mummy_cleric_cycle()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(3.0, "mummy_cleric_cycle");
		if (MUMMY_NO_HEALS > GetGameTime())
		{
			ATTACK_MOVERANGE = 48;
		}
		MUMMY_HEAL_LIST = FindEntitiesInSphere("ally", MUMMY_CLERIC_RANGE);
		if (MUMMY_HEAL_LIST == "none")
		{
			MUMMY_NO_HEALS = GetGameTime();
			MUMMY_NO_HEALS += 10.0;
		}
		if (!(MUMMY_HEAL_LIST != "none")) return;
		ATTACK_MOVERANGE = 1024;
		ScrambleTokens(MUMMY_HEAL_LIST, ";");
		MUMMY_HEAL_TARGET = "none";
		mummy_find_heal_target();
		if (!(MUMMY_HEAL_TARGET != "none")) return;
		CallExternal(MUMMY_HEAL_TARGET, "mummy_healed");
		EmitSound(GetOwner(), 0, SOUND_HEAL_OTHER, 10);
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 64, 1, 1);
		npcatk_suspend_ai(1.0);
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(MUMMY_HEAL_TARGET);
		ScheduleDelayedEvent(0.1, "mummy_cleric_heal_anim");
	}

	void mummy_cleric_heal_anim()
	{
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_HEAL);
		MUMMY_HEAL_FLAG = 1;
	}

	void mummy_find_heal_target()
	{
		string CUR_TARG = GetToken(MUMMY_HEAL_LIST, i, ";");
		if (!(IsEntityAlive(CUR_TARG))) return;
		if (!(GetEntityHealth(CUR_TARG) < GetEntityMaxHealth(CUR_TARG))) return;
		if (!((GetEntityProperty(CUR_TARG, "itemname")).findFirst("mummy") >= 0)) return;
		MUMMY_HEAL_TARGET = CUR_TARG;
	}

	void mummy_healed()
	{
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 256, 1, 1);
		EmitSound(GetOwner(), 0, SOUND_HEALED, 10);
		SetHealth(GetMonsterMaxHP());
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((MUMMY_BEAMING))
		{
			mummy_beam_new_target(GetEntityIndex(m_hLastStruck));
		}
		if (!(MUMMY_IS_CLERIC)) return;
		if (!(ATTACK_MOVE_RANGE == 1024)) return;
		if (!(GetEntityRange(m_hLastStruck) < 128)) return;
		ATTACK_MOVERANGE = 48;
	}

	void ext_setbody()
	{
		SetModelBody(param1, param2);
	}

	void OnFlinch()
	{
		int RND_FLINCH = RandomInt(1, 2);
		if (RND_FLINCH == 1)
		{
			FLINCH_ANIM = ANIM_FLINCH1;
		}
		if (RND_FLINCH == 1)
		{
			FLINCH_ANIM = ANIM_FLINCH2;
		}
	}

	void mummy_pike_check()
	{
		ScheduleDelayedEvent(1.0, "mummy_pike_check");
		if (!(false)) return;
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_RANGE_LONG)) return;
		if (!(GetGameTime() > MUMMY_NEXT_PIKE_TOSS)) return;
		MUMMY_NEXT_PIKE_TOSS = GetGameTime();
		MUMMY_NEXT_PIKE_TOSS += FREQ_MUMMY_PIKE_TOSS;
		MUMMY_TOSSING_PIKE = 1;
		if (!(MUMMY_PIKE_NOGLOW))
		{
			SetModelBody(2, 7);
		}
		npcatk_suspend_ai();
		SetMoveDest(m_hAttackTarget);
		ANIM_RUN = ANIM_PIKE_HOLD;
		ANIM_IDLE = ANIM_PIKE_HOLD;
		SetMoveAnim(ANIM_PIKE_HOLD);
		SetIdleAnim(ANIM_PIKE_HOLD);
		NPC_FORCED_MOVEDEST = 1;
		SetRoam(false);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 2.0;
		PlayAnim("critical", ANIM_STEELPIPE);
		ScheduleDelayedEvent(1.5, "mummy_pike_reload");
	}

	void mummy_pike_reload()
	{
		SetModelBody(2, 7);
		SetRoam(true);
		npcatk_resume_ai();
		ANIM_RUN = MUMMY_DEFAULT_ANIM_RUN;
		ANIM_IDLE = MUMMY_DEFAULT_ANIM_IDLE;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		MUMMY_TOSSING_PIKE = 0;
		ScheduleDelayedEvent(0.5, "mummy_pike_reload2");
	}

	void mummy_pike_reload2()
	{
		SetModelBody(2, 6);
	}

	void ext_projectile_hit()
	{
		MUMMY_NEXT_PIKE_TOSS += 10.0;
	}

	void mummy_necro_summon()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(1.0, "mummy_necro_summon");
		if (!(m_hAttackTarget != "unset")) return;
		int L_MAX_SUMMONS = 2;
		if (L_MAX_SUMMONS < GetPlayerCount())
		{
			string L_MAX_SUMMONS = GetPlayerCount();
		}
		if (!(MUMMY_NSUMMONS < L_MAX_SUMMONS)) return;
		if (!(GetGameTime() > MUMMY_NEXT_SUMMON)) return;
		MUMMY_NEXT_SUMMON = GetGameTime();
		MUMMY_NEXT_SUMMON += FREQ_MUMMY_SUMMON;
		npcatk_suspend_ai();
		ANIM_RUN = ANIM_SUMMON;
		ANIM_IDLE = ANIM_SUMMON;
		SetRoam(false);
		SetMoveAnim(ANIM_SUMMON);
		SetIdleAnim(ANIM_SUMMON);
		ScheduleDelayedEvent(1.0, "mummy_necro_summon2");
	}

	void mummy_necro_summon2()
	{
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 128, 1, 1);
		EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
		MUMMY_NSUMMONS += 1;
		string SUMMON_POINT = /* TODO: $relpos */ $relpos(0, 64, 0);
		SpawnNPC(MUMMY_SUMMON_SCRIPT, SUMMON_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), m_hAttackTarget, SUMMON_POINT
		ScheduleDelayedEvent(2.0, "mummy_necro_summon3");
	}

	void mummy_necro_summon3()
	{
		npcatk_resume_ai();
		ANIM_RUN = MUMMY_DEFAULT_ANIM_RUN;
		ANIM_IDLE = MUMMY_DEFAULT_ANIM_IDLE;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		SetRoam(true);
	}

	void ext_wraith_died()
	{
		MUMMY_NSUMMONS -= 1;
		MUMMY_NEXT_SUMMON = GetGameTime();
		MUMMY_NEXT_SUMMON += FREQ_MUMMY_SUMMON;
	}

	void mummy_beam_attack()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(MUMMY_DOUBLE_CYCLE))
		{
			FREQ_MUMMY_BEAM_ATTACK("mummy_beam_attack");
		}
		if ((PLAYING_DEAD)) return;
		if ((MUMMY_BREATHING)) return;
		if ((MUMMY_BEAMING)) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (!(false)) return;
		MUMMY_BEAMING = 1;
		MUMMY_BEAM_TARGET = m_hAttackTarget;
		npcatk_suspend_ai();
		ANIM_RUN = ANIM_PIKE_HOLD;
		ANIM_IDLE = ANIM_PIKE_HOLD;
		SetRoam(false);
		SetMoveAnim(ANIM_PIKE_HOLD);
		SetIdleAnim(ANIM_PIKE_HOLD);
		Effect("beam", "ents", "lgtning.spr", 200, GetOwner(), 2, MUMMY_BEAM_TARGET, 0, Vector3(255, 255, 0), 255, 20, MUMMY_BEAM_DUR);
		MUMMY_BEAM_ID = m_hLastCreated;
		EmitSound(GetOwner(), 0, SOUND_BEAM_START, 10);
		// svplaysound: svplaysound 2 10 SOUND_BEAM_LOOP
		EmitSound(2, 10, SOUND_BEAM_LOOP);
		ClientEvent("new", "all", "effects/sfx_attach_sprite", "0;1.0;255;add;(255,255,0);30;1", GetEntityIndex(GetOwner()), 1, MUMMY_BEAM_DUR, "3dmflaora.spr");
		MUMMY_BEAM_ABORT_TIME = GetGameTime();
		MUMMY_BEAM_ABORT_TIME += MUMMY_BEAM_DUR;
		MUMMY_BEAM_ABORT_TIME += 1.0;
		mummy_beam_attack_loop();
		MUMMY_BEAM_DUR("mummy_beam_attack_end");
	}

	void mummy_beam_attack_end()
	{
		Effect("beam", "update", MUMMY_BEAM_ID, "remove", 0.1);
		// svplaysound: svplaysound 2 0 SOUND_BEAM_LOOP
		EmitSound(2, 0, SOUND_BEAM_LOOP);
		MUMMY_BEAMING = 0;
		npcatk_resume_ai();
		ANIM_RUN = MUMMY_DEFAULT_ANIM_RUN;
		ANIM_IDLE = MUMMY_DEFAULT_ANIM_IDLE;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		SetRoam(true);
	}

	void mummy_beam_new_target()
	{
		if (!((param1 !is null))) return;
		if (!(IsEntityAlive(param1))) return;
		string MY_STAFF_ORG = GetEntityProperty(GetOwner(), "attachpos");
		string ATTACKER_ORG = GetEntityOrigin(param1);
		string TRACE_LINE = TraceLine(MY_STAFF_ORG, ATTACKER_ORG);
		if (!(TRACE_LINE == ATTACKER_ORG)) return;
		MUMMY_BEAM_TARGET = param1;
		Effect("beam", "update", MUMMY_BEAM_ID, "end_target", MUMMY_BEAM_TARGET, 0);
	}

	void mummy_beam_attack_loop()
	{
		if (GetGameTime() > MUMMY_BEAM_ABORT_TIME)
		{
			mummy_beam_attack_end();
		}
		if (!(MUMMY_BEAMING)) return;
		ScheduleDelayedEvent(0.1, "mummy_beam_attack_loop");
		if (!(IsEntityAlive(MUMMY_BEAM_TARGET)))
		{
			Effect("beam", "update", MUMMY_BEAM_ID, "brightness", 0);
			string NEW_TARGET = FindEntitiesInSphere("enemy", 1024);
			ScrambleTokens(NEW_TARGET, ";");
			mummy_beam_new_target(NEW_TARGET);
		}
		else
		{
			SetMoveDest(MUMMY_BEAM_TARGET);
			string BEAM_START = GetEntityProperty(GetOwner(), "attachpos");
			string BEAM_END = GetEntityOrigin(MUMMY_BEAM_TARGET);
			string BEAM_TRACE = TraceLine(BEAM_START, BEAM_END);
			if (BEAM_TRACE != BEAM_END)
			{
				Effect("beam", "update", MUMMY_BEAM_ID, "brightness", 0);
			}
			else
			{
				Effect("beam", "update", MUMMY_BEAM_ID, "brightness", 255);
				string VEL_SET = /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(-500, 1000, 30));
				SetVelocity(MUMMY_BEAM_TARGET, VEL_SET);
				DoDamage(MUMMY_BEAM_TARGET, "direct", DMG_PUSH_BEAM, 1.0, GetOwner());
			}
		}
	}

	void mummy_breath_attack()
	{
		if ((IsEntityAlive(GetOwner())))
		{
			if (!(PLAYING_DEAD))
			{
			}
			if (!(MUMMY_BREATHING))
			{
			}
			if (!(MUMMY_BEAMING))
			{
			}
			if ((IsEntityAlive(m_hAttackTarget)))
			{
			}
			if ((CanSee(m_hAttackTarget, 512)))
			{
			}
			int DO_BREATH_ATTACK = 1;
		}
		if ((DO_BREATH_ATTACK))
		{
			if (!(MUMMY_DOUBLE_CYCLE))
			{
			}
			FREQ_MUMMY_BREATH_ATTACK("mummy_breath_attack");
		}
		else
		{
			if (!(MUMMY_DOUBLE_CYCLE))
			{
			}
			ScheduleDelayedEvent(2.0, "mummy_breath_attack");
		}
		if (!(DO_BREATH_ATTACK)) return;
		MUMMY_BREATHING = 1;
		MUMMY_DEFAULT_ANIM_RUN = ANIM_RUN;
		ANIM_RUN = ANIM_BREATH_WALK;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_BREATH_WALK);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		PlayAnim("critical", ANIM_BREATH_PREP);
		EmitSound(GetOwner(), 0, SOUND_BREATH_PREP, 10);
		ScheduleDelayedEvent(1.5, "mummy_breath_start");
		MUMMY_BREATH_DURATION("mummy_breath_stop");
		MUMMY_BREATH_TARGET = m_hAttackTarget;
		npcatk_suspend_ai();
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(m_hAttackTarget);
	}

	void mummy_breath_start()
	{
		if (MUMMY_BREATH_ATTACK_TYPE == "lightning")
		{
			// svplaysound: if ( MUMMY_BREATH_ATTACK_TYPE equals lightning ) svplaysound 2 10 SOUND_BREATH_LOOP
			EmitSound(2, 10, SOUND_BREATH_LOOP);
		}
		if (MUMMY_BREATH_ATTACK_TYPE == "ice")
		{
			// svplaysound: if ( MUMMY_BREATH_ATTACK_TYPE equals ice ) svplaysound 3 10 SOUND_BREATH_LOOP
			EmitSound(3, 10, SOUND_BREATH_LOOP);
		}
		EmitSound(GetOwner(), 0, SOUND_MUMMY_BREATH, 10);
		ClientEvent("new", "all", MUMMY_BREATH_ATTACK_CLSCRIPT, GetEntityIndex(GetOwner()), MUMMY_BREATH_DURATION);
		mummy_breath_loop();
	}

	void mummy_breath_loop()
	{
		if (!(MUMMY_BREATHING)) return;
		ScheduleDelayedEvent(0.5, "mummy_breath_loop");
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(m_hAttackTarget);
		string BREATH_CENTER = GetEntityOrigin(GetOwner());
		BREATH_CENTER += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, MUMMY_BREATH_ATTACK_OFS, 0));
		MUMMY_BREATH_TARGETS = FindEntitiesInSphere("enemy", MUMMY_BREATH_ATTACK_RANGE);
		if (!(MUMMY_BREATH_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(MUMMY_BREATH_TARGETS, ";"); i++)
		{
			mummy_breath_affect_targets();
		}
	}

	void mummy_breath_stop()
	{
		npcatk_resume_ai();
		MUMMY_BREATHING = 0;
		ANIM_RUN = MUMMY_DEFAULT_ANIM_RUN;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("critical", ANIM_BREATH_WALK);
		if (MUMMY_BREATH_ATTACK_TYPE == "lightning")
		{
			ScheduleDelayedEvent(1.0, "mummy_breath_stop_sound");
		}
		if (MUMMY_BREATH_ATTACK_TYPE == "ice")
		{
			// svplaysound: if ( MUMMY_BREATH_ATTACK_TYPE equals ice ) svplaysound 3 0 SOUND_BREATH_LOOP
			EmitSound(3, 0, SOUND_BREATH_LOOP);
		}
	}

	void mummy_breath_stop_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_BREATH_END, 10);
		// svplaysound: svplaysound 2 0 SOUND_BREATH_LOOP
		EmitSound(2, 0, SOUND_BREATH_LOOP);
	}

	void mummy_breath_affect_targets()
	{
		string CUR_TARG = GetToken(MUMMY_BREATH_TARGETS, i, ";");
		if (!(GetEntityRange(CUR_TARG) < MUMMY_BREATH_ATTACK_RANGE)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		string MY_MOUTH_ORG = GetEntityProperty(GetOwner(), "attachpos");
		string TRACE_LINE = TraceLine(MY_MOUTH_ORG, TARG_ORG);
		if (!(TRACE_LINE == TARG_ORG)) return;
		if (MUMMY_BREATH_ATTACK_TYPE == "bile")
		{
			ApplyEffect(CUR_TARG, "effects/dot_poison_blind", MUMMY_BREATH_DOT_DURATION, GetEntityIndex(GetOwner()), MUMMY_BREATH_DOT);
		}
		if (MUMMY_BREATH_ATTACK_TYPE == "lightning")
		{
			DoDamage(CUR_TARG, "direct", MUMMY_BREATH_DOT, 1.0, GetOwner());
			ApplyEffect(CUR_TARG, "effects/dot_lightning", MUMMY_BREATH_DOT_DURATION, GetEntityIndex(GetOwner()), MUMMY_BREATH_DOT);
			string ZAP_TARG_RESIST = /* TODO: $get_takedmg */ $get_takedmg(CUR_TARG, "lightning");
			float ZAP_ROLL = Random(0.0, 2.0);
			if (ZAP_ROLL < ZAP_TARG_RESIST)
			{
			}
			string TARG_ORG = GetEntityOrigin(CUR_TARG);
			string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
			SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 10)));
		}
		if (MUMMY_BREATH_ATTACK_TYPE == "ice")
		{
			ApplyEffect(CUR_TARG, "effects/dot_cold", MUMMY_BREATH_DOT_DURATION, GetEntityIndex(GetOwner()), MUMMY_BREATH_DOT);
		}
	}

	void mummy_double_cycle_event()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		MUMMY_FREQ_DOUBLE_CYCLE("mummy_double_cycle_event");
		if ((PLAYING_DEAD)) return;
		if ((MUMMY_BREATHING)) return;
		if ((MUMMY_BEAMING)) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		MUMMY_CUR_CYCLE_ATTACK += 1;
		if (MUMMY_CUR_CYCLE_ATTACK == 1)
		{
			mummy_beam_attack();
		}
		if (MUMMY_CUR_CYCLE_ATTACK == 2)
		{
			mummy_breath_attack();
			MUMMY_CUR_CYCLE_ATTACK = 0;
		}
	}

	void set_cleric_range()
	{
		MUMMY_CLERIC_RANGE = param2;
	}

}

}
