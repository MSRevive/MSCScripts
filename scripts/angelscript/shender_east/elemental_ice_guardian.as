#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_flyer_grav.as"
#include "monsters/base_propelled.as"

namespace MS
{

class ElementalIceGuardian : CGameScript
{
	string ANIM_ALERT;
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	string ANIM_ATTACK2;
	string ANIM_BREATH_LOOP;
	string ANIM_BREATH_START;
	string ANIM_DEATH;
	string ANIM_DODGE;
	string ANIM_FAKE_DEATH;
	string ANIM_FAKE_DEATH_IDLE;
	string ANIM_FLINCH_CUSTOM;
	string ANIM_ICE_BALL;
	string ANIM_IDLE;
	string ANIM_LUNGE;
	string ANIM_MULTI_PROJECTILE;
	string ANIM_PROJECTILE;
	string ANIM_PUSH;
	string ANIM_PUSHL;
	string ANIM_RESSURECT;
	string ANIM_RUN;
	string ANIM_SPELL_LOOP;
	string ANIM_STUN_BURST;
	string ANIM_SUMMON;
	string ANIM_TAUNT;
	string ANIM_THROW;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_COUNT;
	int ATTACK_HITRANGE;
	int ATTACK_HITRANGE_DEF;
	int ATTACK_MOVERANGE;
	int ATTACK_MOVERANGE_AGRO;
	int ATTACK_MOVERANGE_DEF;
	int ATTACK_RANGE;
	int ATTACK_RANGE_DEF;
	int BE_AGGRESSIVE;
	int BFLY_VSPEED_DOWN;
	int BFLY_VSPEED_UP;
	string BURST_START;
	string BURST_TARGS;
	string CIRCLE_TARGS;
	string CL_FX_INDEX;
	string CL_FX_SCRIPT;
	string CUR_SHOCK_TARG_IDX;
	int DID_WARCRY;
	int DMG_BURST;
	int DMG_LUNGE;
	int DMG_STAFF;
	string DODGE_TARGET;
	int DOT_FROST;
	int DOT_SHOCK;
	string FLIGHT_HEIGHT;
	float FREQ_CHANGE_STANCE;
	float FREQ_CHARGE;
	float FREQ_DODGE;
	float FREQ_FLINCH;
	float FREQ_ICE_BALL;
	float FREQ_ICE_CIRCLE;
	float FREQ_LUNGE;
	float FREQ_PROJECTILE;
	float FREQ_SHOCK_STORM;
	float FREQ_STAFF_MODE_CHANGE;
	float FREQ_STUN_BURST;
	float FREQ_TAUNT;
	float FREQ_THROW;
	string GUARD_ELEMENT;
	string HALF_HP;
	float HIT_DELAY;
	int ICE_CIRCLE_ACTIVE;
	int ICE_CIRCLE_FXRAD;
	string ICE_CIRCLE_ORIGIN;
	int ICE_CIRCLE_RAD;
	string ICE_GUARD_DOT_EFFECT;
	float ICE_GUARD_FIRE_VULN;
	int ICE_GUARD_HEIGHT;
	int ICE_GUARD_HP;
	float ICE_GUARD_ICE_VULN;
	int ICE_GUARD_LEVEL;
	string ICE_GUARD_MODEL;
	string ICE_GUARD_NAME;
	int ICE_GUARD_WIDTH;
	int IMMUNE_VAMPIRE;
	int IN_STANCE;
	int IS_UNHOLY;
	int LUNGE_RANGE_MAX;
	int LUNGE_RANGE_MAX_HITRANGE;
	int LUNGE_RANGE_MIN;
	int MELEE_ATTACK;
	string METEOR_MODE;
	int MOVE_RANGE;
	string NEXT_CALM;
	string NEXT_CHARGE;
	string NEXT_CL_REFRESH;
	string NEXT_DODGE;
	string NEXT_FLINCH;
	string NEXT_ICE_BALL;
	string NEXT_ICE_CIRCLE;
	string NEXT_LUNGE;
	string NEXT_METEOR;
	string NEXT_PROJECTILE;
	string NEXT_SHOCK_STORM;
	string NEXT_STAFF_MODE_CHANGE;
	string NEXT_STANCE_CHANGE;
	string NEXT_STUN_BURST;
	string NEXT_TARG_CHECK;
	string NEXT_TAUNT;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string PROJECTILE_LOOP_ON;
	int PROJ_SPEED;
	string SHOCK_MODE;
	string SHOCK_STORM_BEAM_ID;
	int SHOCK_STORM_ON;
	string SHOCK_TARGS;
	string SOUND_ALERT;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_DODGE;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PROJECTILE;
	string SOUND_SHOCK_HIT;
	string SOUND_SHOCK_LOOP;
	string SOUND_SHOCK_START;
	string SOUND_STAFF_ON;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_SUMMON;
	string SOUND_SWIPE1;
	string SOUND_SWIPE2;
	string SOUND_SWIPE_STRONG1;
	string SOUND_SWIPE_STRONG2;
	string SOUND_SWIPE_STRONG3;
	string SOUND_TAUNT;
	int SPEED_FAST;
	int SPEED_SLOW;
	string STAFF_ALT_EFFECT;
	string STAFF_BEAM_COLOR;
	int STAFF_ON;
	string STORM_TARGS;
	int VEL_BURST_F;
	int VEL_BURST_U;
	int VEL_DODGE_F;
	int VEL_DODGE_L;
	int VEL_FBURST_F;
	int VEL_LONG_F;
	int VEL_PUSH_ATK_F;
	int VEL_SHOCK_F;
	int VEL_THROW_ATK_F;
	int VEL_THROW_ATK_L;

	ElementalIceGuardian()
	{
		ICE_GUARD_NAME = "Lesser Nightmare of Ice";
		ICE_GUARD_HP = 1000;
		ICE_GUARD_FIRE_VULN = 1.5;
		ICE_GUARD_LEVEL = 1;
		ICE_GUARD_MODEL = "monsters/ice_guardian.mdl";
		ICE_GUARD_WIDTH = 32;
		ICE_GUARD_HEIGHT = 96;
		ICE_GUARD_ICE_VULN = 0.0;
		GUARD_ELEMENT = "ice";
		ICE_GUARD_DOT_EFFECT = "effects/dot_cold";
		ANIM_IDLE = "idle_ready";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "explode";
		ANIM_ATTACK1 = "attack1";
		ANIM_ATTACK2 = "attack2";
		ANIM_STUN_BURST = "attack_smash";
		ANIM_THROW = "attack_throw";
		ANIM_PUSH = "attack_push";
		ANIM_LUNGE = "attack_long";
		ANIM_ICE_BALL = "release_spell";
		ANIM_SPELL_LOOP = "spell_loop";
		ANIM_SUMMON = "summon";
		ANIM_ALERT = "alert";
		ANIM_FLINCH_CUSTOM = "flinch";
		ANIM_TAUNT = "taunt";
		ANIM_PROJECTILE = "projectile";
		ANIM_MULTI_PROJECTILE = "multi_projectile";
		ANIM_DODGE = "attack_pushr";
		ANIM_PUSHL = "attack_pushl";
		ANIM_BREATH_START = "ccastout";
		ANIM_BREATH_LOOP = "ccastoutlp";
		ANIM_FAKE_DEATH = "long_death";
		ANIM_RESSURECT = "ressurect";
		ANIM_FAKE_DEATH_IDLE = "dead_idle";
		VEL_PUSH_ATK_F = 400;
		VEL_THROW_ATK_L = -400;
		VEL_THROW_ATK_F = 400;
		VEL_BURST_F = 500;
		VEL_FBURST_F = 800;
		VEL_BURST_U = 100;
		VEL_LONG_F = 300;
		VEL_DODGE_F = 300;
		VEL_DODGE_L = 300;
		VEL_SHOCK_F = 600;
		if (StringToLower(GetMapName()) != "shender_east")
		{
			VEL_PUSH_ATK_F *= 1.25;
			VEL_THROW_ATK_L = -600;
			VEL_THROW_ATK_F *= 1.25;
			VEL_BURST_F *= 1.25;
			VEL_FBURST_F *= 1.25;
			VEL_BURST_U *= 1.25;
			VEL_LONG_F *= 1.25;
			VEL_DODGE_F *= 1.25;
			VEL_DODGE_L *= 1.25;
			VEL_SHOCK_F *= 1.25;
		}
		IS_UNHOLY = 1;
		NPC_HACKED_MOVE_SPEED = 100;
		IMMUNE_VAMPIRE = 1;
		SPEED_SLOW = 100;
		SPEED_FAST = 200;
		BFLY_VSPEED_UP = 5;
		BFLY_VSPEED_DOWN = -50;
		MOVE_RANGE = 50;
		ATTACK_MOVERANGE = 50;
		ATTACK_MOVERANGE_DEF = 50;
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 75;
		ATTACK_RANGE_DEF = 60;
		ATTACK_HITRANGE_DEF = 75;
		ATTACK_MOVERANGE_AGRO = 60;
		LUNGE_RANGE_MIN = 75;
		LUNGE_RANGE_MAX = 175;
		LUNGE_RANGE_MAX_HITRANGE = 125;
		STAFF_BEAM_COLOR = Vector3(128, 128, 255);
		STAFF_ALT_EFFECT = "effects/dot_lightning";
		NPC_GIVE_EXP = 750;
		FREQ_STUN_BURST = Random(20.0, 30.0);
		FREQ_ICE_BALL = Random(20.0, 30.0);
		FREQ_ICE_CIRCLE = Random(20.0, 30.0);
		FREQ_THROW = Random(10.0, 20.0);
		FREQ_STAFF_MODE_CHANGE = 20.0;
		FREQ_LUNGE = 5.0;
		FREQ_DODGE = Random(8.0, 12.0);
		FREQ_FLINCH = 20.0;
		FREQ_CHANGE_STANCE = 20.0;
		FREQ_TAUNT = 20.0;
		FREQ_CHARGE = 20.0;
		FREQ_PROJECTILE = 3.0;
		FREQ_SHOCK_STORM = 30.0;
		DMG_BURST = 50;
		DMG_LUNGE = 100;
		DMG_STAFF = 50;
		DOT_FROST = 15;
		DOT_SHOCK = 30;
		ICE_CIRCLE_RAD = 172;
		ICE_CIRCLE_FXRAD = 172;
		CL_FX_SCRIPT = "monsters/elemental_ice_guardian_cl";
		SOUND_PROJECTILE = "magic/ice_strike.wav";
		SOUND_STAFF_ON = "magic/elecidle.wav";
		SOUND_SHOCK_LOOP = "magic/bolt_loop.wav";
		SOUND_SHOCK_START = "magic/bolt_start.wav";
		SOUND_SHOCK_HIT = "magic/bolt_end.wav";
		SOUND_STRUCK1 = "debris/glass1.wav";
		SOUND_STRUCK2 = "debris/glass2.wav";
		SOUND_STRUCK3 = "debris/glass3.wav";
		SOUND_SWIPE1 = "zombie/claw_miss1.wav";
		SOUND_SWIPE2 = "zombie/claw_miss2.wav";
		SOUND_SWIPE_STRONG1 = "zombie/claw_strike1.wav";
		SOUND_SWIPE_STRONG2 = "zombie/claw_strike2.wav";
		SOUND_SWIPE_STRONG3 = "zombie/claw_strike3.wav";
		SOUND_ATTACK1 = "monsters/ice_guardian/c_elemwatr_atk1.wav";
		SOUND_ATTACK2 = "monsters/ice_guardian/c_elemwatr_atk2.wav";
		SOUND_ATTACK3 = "monsters/ice_guardian/c_elemwatr_atk3.wav";
		SOUND_TAUNT = "monsters/ice_guardian/c_elemwatr_bat1.wav";
		SOUND_ALERT = "monsters/ice_guardian/c_elemwatr_slct.wav";
		SOUND_SUMMON = "monsters/ice_guardian/c_elemwatr_bat2.wav";
		SOUND_DODGE = "monsters/ice_guardian/c_elemwatr_slct.wav";
		SOUND_PAIN1 = "monsters/ice_guardian/c_elemwatr_hit1.wav";
		SOUND_PAIN2 = "monsters/ice_guardian/c_elemwatr_hit2.wav";
		SOUND_DEATH = "monsters/ice_guardian/c_elemwatr_dead.wav";
	}

	void OnSpawn() override
	{
		SetName(ICE_GUARD_NAME);
		SetHealth(ICE_GUARD_HP);
		SetRace("demon");
		SetModel(ICE_GUARD_MODEL);
		SetWidth(ICE_GUARD_WIDTH);
		SetHeight(ICE_GUARD_HEIGHT);
		SetRoam(true);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("cold", ICE_GUARD_ICE_VULN);
		SetDamageResistance("fire", ICE_GUARD_FIRE_VULN);
		SetDamageResistance("holy", 1.5);
		SetBloodType("none");
		SetHearingSensitivity(6);
		PlayAnim("once", ANIM_IDLE);
		if (!(true)) return;
		ATTACK_COUNT = 0;
		STAFF_ON = 0;
		IN_STANCE = 0;
		NEXT_STANCE_CHANGE = GetGameTime();
		NEXT_STANCE_CHANGE += 20.0;
		ScheduleDelayedEvent(0.1, "refresh_client_fx");
		ScheduleDelayedEvent(2.0, "finalize_npc");
	}

	void finalize_npc()
	{
		HALF_HP = GetEntityMaxHealth(GetOwner());
		HALF_HP *= 0.5;
		ATTACK_MOVERANGE = ATTACK_MOVERANGE_DEF;
		ATTACK_RANGE = ATTACK_RANGE_DEF;
		ATTACK_HITRANGE = ATTACK_HITRANGE_DEF;
	}

	void refresh_client_fx()
	{
		if (!(ICE_GUARD_LEVEL > 1)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		if (CL_FX_INDEX != "CL_FX_INDEX")
		{
			ClientEvent("update", "all", CL_FX_INDEX, "end_fx");
		}
		ClientEvent("new", "all", CL_FX_SCRIPT, GetEntityIndex(GetOwner()), STAFF_ON);
		CL_FX_INDEX = "game.script.last_sent_id";
		NEXT_CL_REFRESH = GetGameTime();
		NEXT_CL_REFRESH += 45.0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, 0)));
		SetGravity(1);
		ClientEvent("update", "all", CL_FX_INDEX, "guardian_death");
		CallExternal(GAME_MASTER, "gm_vanish_que", GetEntityIndex(GetOwner()), 3.0);
		if ((SHOCK_STORM_ON))
		{
			// svplaysound: svplaysound 3 0 SOUND_SHOCK_LOOP
			EmitSound(3, 0, SOUND_SHOCK_LOOP);
			Effect("beam", "update", SHOCK_STORM_BEAM_ID, "brightness", 0);
		}
	}

	void game_stopmoving()
	{
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
	}

	void npc_targetsighted()
	{
		if ((DID_WARCRY)) return;
		DID_WARCRY = 1;
		refresh_client_fx();
		float GAME_TIME = GetGameTime();
		int RND_WARCRY = RandomInt(1, 2);
		AS_ATTACKING = GAME_TIME;
		AS_ATTACKING += 5.0;
		SetRoam(false);
		ScheduleDelayedEvent(2.0, "restore_roam");
		SetMoveDest(m_hAttackTarget);
		if (RND_WARCRY == 1)
		{
			PlayAnim("critical", ANIM_ALERT);
		}
		if (RND_WARCRY == 2)
		{
			PlayAnim("critical", ANIM_TAUNT);
		}
		NEXT_STUN_BURST = GAME_TIME;
		NEXT_STUN_BURST += FREQ_STUN_BURST;
		NEXT_LUNGE = GAME_TIME;
		NEXT_LUNGE += 1.0;
		NEXT_CHARGE = GAME_TIME;
		NEXT_CHARGE += FREQ_CHARGE;
		NEXT_ICE_BALL = GAME_TIME;
		NEXT_ICE_BALL += FREQ_ICE_BALL;
		NEXT_ICE_CIRCLE = GAME_TIME;
		NEXT_ICE_CIRCLE += FREQ_ICE_CIRCLE;
		NEXT_STAFF_MODE_CHANGE = GAME_TIME;
		NEXT_STAFF_MODE_CHANGE += FREQ_STAFF_MODE_CHANGE;
		NEXT_METEOR = GAME_TIME;
		NEXT_METEOR += FREQ_METEOR;
	}

	void restore_roam()
	{
		SetRoam(true);
	}

	void frame_alert()
	{
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
	}

	void frame_taunt()
	{
		EmitSound(GetOwner(), 0, SOUND_TAUNT, 10);
	}

	void cycle_down()
	{
		DID_WARCRY = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		float GAME_TIME = GetGameTime();
		if (m_hAttackTarget == "unset")
		{
			if (GAME_TIME > NEXT_TARG_CHECK)
			{
			}
			NEXT_TARG_CHECK = GAME_TIME;
			NEXT_TARG_CHECK += Random(5.0, 20.0);
			if (StringToLower(GetMapName()) == "shender_east")
			{
			}
			Vector3 CHECK_POINT = Vector3(0, 0, -3760);
			string CHECK_TARGS = FindEntitiesInSphere("player", 1024);
			if (CHECK_TARGS != "none")
			{
			}
			string CHECK_TARGS = /* TODO: $sort_entlist */ $sort_entlist(CHECK_TARGS, "range");
			string NEW_TARGET = GetToken(CHECK_TARGS, 0, ";");
			npcatk_settarget(NEW_TARGET);
		}
		if (ICE_GUARD_LEVEL > 1)
		{
			if (GAME_TIME > NEXT_CL_REFRESH)
			{
			}
			refresh_client_fx();
		}
		if (GAME_TIME > NEXT_STANCE_CHANGE)
		{
			NEXT_STANCE_CHANGE = GAME_TIME;
			NEXT_STANCE_CHANGE += FREQ_STANCE_CHANGE;
			IN_STANCE += 1;
			if (IN_STANCE == 1)
			{
				ANIM_WALK = "run";
				ANIM_RUN = "walk";
				NPC_HACKED_MOVE_SPEED = SPEED_SLOW;
			}
			else
			{
				ANIM_WALK = "walk";
				ANIM_RUN = "run";
				NPC_HACKED_MOVE_SPEED = SPEED_FAST;
				IN_STANCE = 0;
			}
		}
		if ((SUSPEND_AI)) return;
		if (!(m_hAttackTarget != "unset")) return;
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		if (TARG_RANGE < ATTACK_HITRANGE)
		{
			string L_TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			string L_MY_ORG = GetEntityOrigin(GetOwner());
			string L_Z_DIFF = (L_MY_ORG).z;
			L_Z_DIFF -= (L_TARG_ORG).z;
			if (L_Z_DIFF > ATTACK_RANGE)
			{
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, -100));
				SetGravity(1);
			}
			else
			{
				if (L_Z_DIFF > 0)
				{
				}
				SetGravity(0.5);
			}
		}
		else
		{
			SetGravity(0);
		}
		string MY_POS = GetEntityOrigin(GetOwner());
		string GROUND_HEIGHT = /* TODO: $get_ground_height */ $get_ground_height(MY_POS);
		FLIGHT_HEIGHT = (MY_POS).z;
		if (FLIGHT_HEIGHT > GROUND_HEIGHT)
		{
			FLIGHT_HEIGHT -= GROUND_HEIGHT;
		}
		else
		{
			GROUND_HEIGHT -= FLIGHT_HEIGHT;
			FLIGHT_HEIGHT = GROUND_HEIGHT;
		}
		if (ICE_GUARD_LEVEL >= 2)
		{
			if (GAME_TIME > NEXT_CALM)
			{
				if ((BE_AGGRESSIVE))
				{
					ATTACK_MOVERANGE = ATTACK_MOVERANGE_AGRO;
					NPC_HACKED_MOVE_SPEED = SPEED_FAST;
				}
				else
				{
					ATTACK_MOVERANGE = ATTACK_MOVERANGE_DEF;
				}
			}
			else
			{
				ATTACK_MOVERANGE = ATTACK_MOVERANGE_AGRO;
				NPC_HACKED_MOVE_SPEED = SPEED_FAST;
			}
		}
		if (TARG_RANGE > LUNGE_RANGE_MIN)
		{
			if (TARG_RANGE < LUNGE_RANGE_MAX)
			{
			}
			if (GAME_TIME > NEXT_LUNGE)
			{
			}
			ATTACK_HITRANGE = LUNGE_RANGE_MAX_HITRANGE;
			ATTACK_RANGE = LUNGE_RANGE_MAX;
			ANIM_ATTACK = ANIM_LUNGE;
		}
		if (GAME_TIME > NEXT_STUN_BURST)
		{
			if (FLIGHT_HEIGHT < 30)
			{
			}
			ANIM_ATTACK = ANIM_STUN_BURST;
		}
		if (GAME_TIME > NEXT_CHARGE)
		{
			if (ICE_GUARD_LEVEL == 1)
			{
			}
			if (TARG_RANGE > 300)
			{
			}
			NEXT_CHARGE = GAME_TIME;
			NEXT_CHARGE += FREQ_CHARGE;
			PlayAnim("critical", ANIM_LUNGE);
			PROJECTILE_LOOP_ON = 0;
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 800, 0));
		}
		if (!(ICE_GUARD_LEVEL >= 2)) return;
		if (ICE_GUARD_LEVEL == 3)
		{
			if (GAME_TIME > NEXT_STAFF_MODE_CHANGE)
			{
			}
			NEXT_STAFF_MODE_CHANGE = GAME_TIME;
			NEXT_STAFF_MODE_CHANGE += FREQ_STAFF_MODE_CHANGE;
			staff_mode_switch();
		}
		if (GAME_TIME > NEXT_ICE_BALL)
		{
			if (TARG_RANGE < 300)
			{
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 110));
			}
			ATTACK_RANGE = 2048;
			ATTACK_HITRANGE = 2048;
			if ((BE_AGGRESSIVE))
			{
				ATTACK_RANGE = 768;
				ATTACK_HITRANGE = 768;
			}
			ANIM_ATTACK = ANIM_ICE_BALL;
			if (!(CIRCLE_POS_SET))
			{
				FIRE_CIRCLE_POS = NPC_LASTSEEN_POS;
				CIRCLE_POS_SET = 1;
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GAME_TIME > NEXT_ICE_CIRCLE)
		{
			if (GUARD_TYPE == "ice")
			{
				if ((false))
				{
				}
				if (!(ICE_CIRCLE_ACTIVE))
				{
				}
				ATTACK_RANGE = 2048;
				ATTACK_HITRANGE = 2048;
				if ((BE_AGGRESSIVE))
				{
					ATTACK_RANGE = 768;
				}
				ANIM_ATTACK = ANIM_SUMMON;
				SUMMON_TYPE = "circle";
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (ICE_GUARD_LEVEL == 2)
		{
			if (GAME_TIME > NEXT_PROJECTILE)
			{
			}
			if ((false))
			{
			}
			if (TARG_RANGE > LUNGE_RANGE_MAX)
			{
			}
			if (TARG_RANGE < 300)
			{
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 110));
			}
			ATTACK_RANGE = 2048;
			ATTACK_HITRANGE = 2048;
			if ((BE_AGGRESSIVE))
			{
				ATTACK_RANGE = 768;
				ATTACK_HITRANGE = 768;
			}
			ANIM_ATTACK = ANIM_PROJECTILE;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (ICE_GUARD_LEVEL == 3)
		{
			if (GUARD_ELEMENT == "ice")
			{
				if (GAME_TIME > NEXT_PROJECTILE)
				{
				}
				if ((false))
				{
				}
				if (TARG_RANGE > LUNGE_RANGE_MAX)
				{
				}
				if (TARG_RANGE < 300)
				{
					AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 110));
				}
				ATTACK_RANGE = 2048;
				ATTACK_HITRANGE = 2048;
				if ((BE_AGGRESSIVE))
				{
					ATTACK_RANGE = 768;
					ATTACK_HITRANGE = 768;
				}
				ANIM_ATTACK = ANIM_MULTI_PROJECTILE;
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (GAME_TIME > NEXT_METEOR)
		{
			if (GUARD_ELEMENT == "fire")
			{
				NEXT_METEOR = GAME_TIME;
				NEXT_METEOR += FREQ_METEOR;
				if (TARG_RANGE < 300)
				{
					AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 110));
				}
				ATTACK_RANGE = 2048;
				ATTACK_HITRANGE = 2048;
				if ((BE_AGGRESSIVE))
				{
					ATTACK_RANGE = 768;
					ATTACK_HITRANGE = 768;
				}
				METEOR_MODE = 1;
				ANIM_ATTACK = ANIM_ICE_BALL;
				int EXIT_SUB = 1;
				delay_specials();
			}
			if (!(EXIT_SUB))
			{
			}
		}
		if (ICE_GUARD_LEVEL == 3)
		{
			if (GAME_TIME > NEXT_SHOCK_STORM)
			{
			}
			NEXT_SHOCK_STORM = GAME_TIME;
			NEXT_SHOCK_STORM += FREQ_SHOCK_STORM;
			if ((SHOCK_MODE))
			{
			}
			if (TARG_RANGE < 300)
			{
				if (GUARD_ELEMENT == "ice")
				{
				}
				if (!(BE_AGGRESSIVE))
				{
					AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 110));
				}
			}
			PROJECTILE_LOOP_ON = 0;
			PlayAnim("critical", ANIM_SPELL_LOOP);
			npcatk_suspend_ai(10.0);
			npcatk_suspend_movement(ANIM_SPELL_LOOP, 10.0);
			do_shock_storm();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
	}

	void frame_multi_projectile_start()
	{
		NEXT_PROJECTILE = GetGameTime();
		NEXT_PROJECTILE += FREQ_PROJECTILE;
		ANIM_ATTACK = "attack1";
		ATTACK_RANGE = ATTACK_RANGE_DEF;
		ATTACK_HITRANGE = ATTACK_HITRANGE_DEF;
		delay_specials();
		PROJ_SPEED = 1500;
		HIT_DELAY = 0.2;
		PROJECTILE_LOOP_ON = 1;
		ScheduleDelayedEvent(5.0, "frame_multi_projectile_end");
		projectile_loop();
	}

	void frame_multi_projectile_end()
	{
		if (!(PROJECTILE_LOOP_ON)) return;
		PROJECTILE_LOOP_ON = 0;
	}

	void projectile_loop()
	{
		if (!(PROJECTILE_LOOP_ON)) return;
		do_projectile();
		ScheduleDelayedEvent(0.3, "projectile_loop");
	}

	void frame_projectile()
	{
		NEXT_PROJECTILE = GetGameTime();
		NEXT_PROJECTILE += FREQ_PROJECTILE;
		PROJ_SPEED = 800;
		HIT_DELAY = 0.5;
		ANIM_ATTACK = "attack1";
		ATTACK_RANGE = ATTACK_RANGE_DEF;
		ATTACK_HITRANGE = ATTACK_HITRANGE_DEF;
		delay_specials();
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		do_projectile();
	}

	void do_projectile()
	{
		if (GUARD_ELEMENT == "ice")
		{
			EmitSound(GetOwner(), 0, SOUND_PROJECTILE, 10);
			string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
			string TRACE_END = GetEntityOrigin(m_hAttackTarget);
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
			string TARG_ANG = /* TODO: $angles3d */ $angles3d(TRACE_START, TRACE_LINE);
			TARG_ANG = "x";
			if (GetEntityRange(m_hAttackTarget) < 200)
			{
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 110));
			}
			if (TRACE_LINE == TRACE_END)
			{
				int HIT_TARGET = 1;
			}
			ClientEvent("update", "all", CL_FX_INDEX, "fire_projectile", TARG_ANG, TRACE_END, HIT_TARGET, PROJ_SPEED);
			if ((HIT_TARGET))
			{
			}
			HIT_DELAY("projectile_strike");
		}
		if (GUARD_ELEMENT == "fire")
		{
			TossProjectile("proj_flame_jet2", /* TODO: $relpos */ $relpos(0, 16, 16), m_hAttackTarget, 300, DMG_SPIT, 2, "none");
			ClientEvent("update", "all", CL_FX_INDEX, "staff_glow");
		}
	}

	void projectile_strike()
	{
		DoDamage(m_hAttackTarget, "direct", DMG_STAFF, 1.0, GetOwner());
		if (ICE_GUARD_LEVEL == 2)
		{
			if (RandomInt(1, 3) == 1)
			{
				ApplyEffect(m_hAttackTarget, ICE_GUARD_DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
			}
		}
		if (GUARD_ELEMENT == "ice")
		{
			if (ICE_GUARD_LEVEL == 3)
			{
				if (RandomInt(1, 5) == 1)
				{
					ApplyEffect(m_hAttackTarget, "effects/dot_cold_freeze", 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
				}
				else
				{
					ApplyEffect(m_hAttackTarget, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
				}
			}
		}
	}

	void frame_summon()
	{
		NEXT_ICE_CIRCLE = GetGameTime();
		NEXT_ICE_CIRCLE += FREQ_ICE_CIRCLE;
		ANIM_ATTACK = "attack1";
		ATTACK_RANGE = ATTACK_RANGE_DEF;
		ATTACK_HITRANGE = ATTACK_HITRANGE_DEF;
		if (SUMMON_TYPE == "circle")
		{
			if ((IsEntityAlive(m_hAttackTarget)))
			{
			}
			if ((false))
			{
			}
			do_ice_circle(GetEntityOrigin(m_hAttackTarget));
			delay_specials();
		}
	}

	void frame_spell()
	{
		NEXT_ICE_BALL = GetGameTime();
		NEXT_ICE_BALL += FREQ_ICE_BALL;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((METEOR_MODE))
		{
			METEOR_MODE = 0;
			int EXIT_SUB = 1;
			string SPELL_POS = GetEntityOrigin(m_hAttackTarget);
			string TRACE_START = SPELL_POS;
			string TRACE_END = SPELL_POS;
			TRACE_END += "z";
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
			string METEOR_SPAWN = TRACE_LINE;
			METEOR_SPAWN += "z";
			SpawnNPC("monsters/summon/meteor_deployer", METEOR_SPAWN, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner())
			ANIM_ATTACK = "attack1";
			ATTACK_RANGE = ATTACK_RANGE_DEF;
			ATTACK_HITRANGE = ATTACK_HITRANGE_DEF;
			delay_specials();
		}
		if ((EXIT_SUB)) return;
		if (GUARD_ELEMENT == "ice")
		{
			if (FLIGHT_HEIGHT > 100)
			{
				TossProjectile("proj_freezing_sphere", /* TODO: $relpos */ $relpos(0, 16, 64), m_hAttackTarget, 100, 0, 0, "none");
			}
			else
			{
				PASS_FREEZE_DMG = DOT_FROST;
				PASS_FREEZE_DUR = 8.0;
				SetMoveDest(m_hAttackTarget);
				SetAngles("view.pitch");
				SetAngles("view.roll");
				SetAngles("view.yaw");
				TossProjectile("proj_freezing_sphere", /* TODO: $relpos */ $relpos(0, 16, 64), "none", 100, 0, 0, "none");
			}
			ANIM_ATTACK = "attack1";
			ATTACK_RANGE = ATTACK_RANGE_DEF;
			ATTACK_HITRANGE = ATTACK_HITRANGE_DEF;
			delay_specials();
		}
		if (GUARD_ELEMENT == "fire")
		{
			if (FIRE_CIRCLE_POS == "unset")
			{
				CIRCLE_POS_SET = 0;
				ANIM_ATTACK = "attack1";
				ATTACK_RANGE = ATTACK_RANGE_DEF;
				ATTACK_HITRANGE = ATTACK_HITRANGE_DEF;
				delay_specials();
			}
			else
			{
				BURST_POS = FIRE_CIRCLE_POS;
				BURST_POS = "z";
				ClientEvent("new", "all", "effects/sfx_fire_staff", BURST_POS);
				BURST_POS += "z";
				XDoDamage(BURST_POS, 96, DMG_FIRE_BURST, 0.01, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:burst");
				CIRCLE_POS_SET = 0;
				ANIM_ATTACK = "attack1";
				ATTACK_RANGE = ATTACK_RANGE_DEF;
				ATTACK_HITRANGE = ATTACK_HITRANGE_DEF;
				delay_specials();
			}
		}
	}

	void burst_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, ICE_GUARD_DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = BURST_POS;
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, VEL_FBURST_F, 110)));
	}

	void flamejet_dodamage()
	{
		ApplyEffect(param2, ICE_GUARD_DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
	}

	void frame_attack()
	{
		// PlayRandomSound from: SOUND_SWIPE1, SOUND_SWIPE2
		array<string> sounds = {SOUND_SWIPE1, SOUND_SWIPE2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
		MELEE_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_STAFF, 0.9, "slash");
		ATTACK_COUNT += 1;
		string DIV_ATTACK_COUNT = ATTACK_COUNT;
		DIV_ATTACK_COUNT /= 2;
		LogDebug("DIV_ATTACK_COUNT vs. int(DIV_ATTACK_COUNT) [ FLIGHT_HEIGHT ]");
		if (DIV_ATTACK_COUNT == int(DIV_ATTACK_COUNT))
		{
			ANIM_ATTACK = ANIM_ATTACK1;
		}
		else
		{
			ANIM_ATTACK = ANIM_ATTACK2;
		}
		if (ATTACK_COUNT == 5)
		{
			ATTACK_COUNT += 1;
			ANIM_ATTACK = ANIM_PUSH;
		}
		if (ATTACK_COUNT >= 10)
		{
			ATTACK_COUNT = 0;
			ANIM_ATTACK = ANIM_THROW;
		}
	}

	void frame_attack_push()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		// PlayRandomSound from: SOUND_SWIPE1, SOUND_SWIPE2
		array<string> sounds = {SOUND_SWIPE1, SOUND_SWIPE2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
		ANIM_ATTACK = "attack1";
		MELEE_ATTACK = 1;
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_LUNGE, 1.0, GetOwner(), GetOwner(), "blunt", "none", "dmgevent:pushatk");
	}

	void pushatk_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			if (!(SHOCK_MODE))
			{
				ApplyEffect(param2, ICE_GUARD_DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
			}
			else
			{
				ApplyEffect(param2, STAFF_ALT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
			}
		}
		MELEE_ATTACK = 0;
		if (!(param1)) return;
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, VEL_PUSH_ATK_F, 110));
	}

	void frame_attack_throw()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		// PlayRandomSound from: SOUND_SWIPE_STRONG1, SOUND_SWIPE_STRONG2, SOUND_SWIPE_STRONG3
		array<string> sounds = {SOUND_SWIPE_STRONG1, SOUND_SWIPE_STRONG2, SOUND_SWIPE_STRONG3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
		ANIM_ATTACK = "attack1";
		ATTACK_COUNT += 1;
		MELEE_ATTACK = 1;
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_LUNGE, 1.0, GetOwner(), GetOwner(), "blunt", "none", "dmgevent:throwatk");
	}

	void throwatk_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			if (!(SHOCK_MODE))
			{
				ApplyEffect(param2, ICE_GUARD_DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
			}
			else
			{
				ApplyEffect(param2, STAFF_ALT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
			}
		}
		MELEE_ATTACK = 0;
		if (!(param1)) return;
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(VEL_THROW_ATK_L, VEL_THROW_ATK_F, 200));
		ApplyEffect(CUR_TARG, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
	}

	void frame_smash()
	{
		NEXT_STUN_BURST = GetGameTime();
		NEXT_STUN_BURST += FREQ_STUN_BURST;
		delay_specials();
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ANIM_ATTACK = "attack1";
		BURST_START = /* TODO: $relpos */ $relpos(0, 64, 0);
		ClientEvent("new", "all", "effects/sfx_stun_burst", BURST_START, 256, 0);
		BURST_TARGS = FindEntitiesInSphere("enemy", 256);
		if (!(BURST_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(BURST_TARGS, ";"); i++)
		{
			burst_affect_targets();
		}
	}

	void burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURST_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/debuff_stun", 8.0, GetEntityIndex(GetOwner()));
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = BURST_START;
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		XDoDamage(CUR_TARG, "direct", DMG_BURST, 1.0, GetOwner(), GetOwner(), "none", "blunt");
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, VEL_BURST_F, VEL_BURST_U)));
	}

	void frame_long_attack()
	{
		NEXT_LUNGE = GetGameTime();
		NEXT_LUNGE += FREQ_LUNGE;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		// PlayRandomSound from: SOUND_SWIPE1, SOUND_SWIPE2
		array<string> sounds = {SOUND_SWIPE1, SOUND_SWIPE2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ATTACK_RANGE = ATTACK_RANGE_DEF;
		ATTACK_HITRANGE = ATTACK_HITRANGE_DEF;
		ANIM_ATTACK = "attack1";
		MELEE_ATTACK = 1;
		XDoDamage(m_hAttackTarget, LUNGE_RANGE_MAX, DMG_LUNGE, 0.9, GetOwner(), GetOwner(), "slash", "none", "dmgevent:longatk");
	}

	void longatk_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			if (!(SHOCK_MODE))
			{
				ApplyEffect(param2, ICE_GUARD_DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
			}
			else
			{
				ApplyEffect(param2, STAFF_ALT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
			}
		}
		MELEE_ATTACK = 0;
		if (!(param1)) return;
		float RND_RL = Random(-200.0, 100.0);
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(RND_RL, VEL_LONG_F, 110));
	}

	void game_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			if (!(SHOCK_MODE))
			{
				ApplyEffect(param2, ICE_GUARD_DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
			}
			else
			{
				ApplyEffect(param2, STAFF_ALT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
			}
		}
		MELEE_ATTACK = 0;
	}

	void delay_specials()
	{
		float GAME_TIME = GetGameTime();
		string TIME_PLUS5 = GAME_TIME;
		TIME_PLUS5 += 5.0;
		if (TIME_PLUS5 > NEXT_STUN_BURST)
		{
			NEXT_STUN_BURST = GAME_TIME;
			NEXT_STUN_BURST += Random(1.0, 5.0);
		}
		if (TIME_PLUS5 > NEXT_CHARGE)
		{
			NEXT_CHARGE = GAME_TIME;
			NEXT_CHARGE += Random(1.0, 5.0);
		}
		if (TIME_PLUS5 > NEXT_ICE_BALL)
		{
			NEXT_ICE_BALL = GAME_TIME;
			NEXT_ICE_BALL += Random(1.0, 5.0);
		}
		if (TIME_PLUS5 > NEXT_ICE_CIRCLE)
		{
			NEXT_ICE_CIRCLE = GAME_TIME;
			NEXT_ICE_CIRCLE += Random(1.0, 5.0);
		}
		if (TIME_PLUS5 > NEXT_PROJECTILE)
		{
			NEXT_PROJECTILE = GAME_TIME;
			NEXT_PROJECTILE += Random(1.0, 5.0);
		}
		if (TIME_PLUS5 > NEXT_METEOR)
		{
			NEXT_METEOR = GAME_TIME;
			NEXT_METEOR += Random(1.0, 5.0);
		}
	}

	void OnDamage(int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		NEXT_CALM = GetGameTime();
		NEXT_CALM += 5.0;
		if (GetGameTime() > NEXT_DODGE)
		{
			NEXT_DODGE = GetGameTime();
			NEXT_DODGE += FREQ_DODGE;
			PlayAnim("critical", ANIM_DODGE);
			PROJECTILE_LOOP_ON = 0;
			DODGE_TARGET = param1;
		}
		if (GetEntityHealth(GetOwner()) < HALF_HP)
		{
			if (GetGameTime() > NEXT_FLINCH)
			{
			}
			NEXT_FLINCH = GetGameTime();
			// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2
			array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
			NEXT_FLINCH += FREQ_FLINCH;
			ANIM_IDLE = "idle_scared";
			SetIdleAnim("idle_scared");
			PlayAnim("critical", ANIM_FLINCH_CUSTOM);
			PROJECTILE_LOOP_ON = 0;
			if (!(BE_AGGRESSIVE))
			{
				SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -600, 150));
			}
		}
	}

	void frame_attack_pushr()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(-300, -100, 0));
		EmitSound(GetOwner(), 0, SOUND_DODGE, 10);
		if (!(IsEntityAlive(DODGE_TARGET))) return;
		if (GetEntityRange(DODGE_TARGET) < 200)
		{
			AddVelocity(DODGE_TARGET, /* TODO: $relvel */ $relvel(VEL_DODGE_L, VEL_DODGE_F, 110));
		}
	}

	void my_target_died()
	{
		if (!(GetGameTime() > NEXT_TAUNT)) return;
		NEXT_TAUNT = GetGameTime();
		NEXT_TAUNT += FREQ_TAUNT;
		PlayAnim("critical", ANIM_TAUNT);
		PROJECTILE_LOOP_ON = 0;
	}

	void do_ice_circle()
	{
		EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
		ICE_CIRCLE_ACTIVE = 1;
		ICE_CIRCLE_ORIGIN = param1;
		ICE_CIRCLE_ORIGIN = "z";
		ClientEvent("new", "all", "effects/sfx_seal", ICE_CIRCLE_ORIGIN, ICE_CIRCLE_FXRAD, 8, 15.0, "freeze_solid");
		ScheduleDelayedEvent(1.0, "ice_circle_loop");
		ScheduleDelayedEvent(15.0, "ice_circle_end");
	}

	void ice_circle_end()
	{
		ICE_CIRCLE_ACTIVE = 0;
	}

	void ice_circle_loop()
	{
		if (!(ICE_CIRCLE_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "ice_circle_loop");
		CIRCLE_TARGS = FindEntitiesInSphere("enemy", ICE_CIRCLE_RAD);
		if (!(CIRCLE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(CIRCLE_TARGS, ";"); i++)
		{
			circle_affect_targets();
		}
	}

	void circle_affect_targets()
	{
		string CUR_TARG = GetToken(CIRCLE_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", 8.0, GetEntityIndex(GetOwner()), DOT_FROST);
	}

	void staff_mode_switch()
	{
		if (!(SHOCK_MODE))
		{
			SHOCK_MODE = 1;
			EmitSound(GetOwner(), 0, SOUND_STAFF_ON, 10);
			Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 3, STAFF_BEAM_COLOR, 200, 10, FREQ_STAFF_MODE_CHANGE);
		}
		else
		{
			SHOCK_MODE = 0;
		}
	}

	void do_shock_storm()
	{
		delay_specials();
		SHOCK_STORM_ON = 1;
		if (GUARD_ELEMENT == "ice")
		{
			ClientEvent("update", "all", CL_FX_INDEX, "shock_storm_on");
			shock_storm_loop();
			ScheduleDelayedEvent(10.0, "shock_storm_end");
			Effect("beam", "ents", "lgtning.spr", 60, GetOwner(), 2, GetOwner(), 4, Vector3(128, 128, 255), 200, 60, 10.0);
			SHOCK_STORM_BEAM_ID = GetEntityIndex(m_hLastCreated);
			SHOCK_TARGS = FindEntitiesInSphere("enemy", 1024);
			EmitSound(GetOwner(), 1, SOUND_SHOCK_START, 10);
			// svplaysound: svplaysound 3 10 SOUND_SHOCK_LOOP
			EmitSound(3, 10, SOUND_SHOCK_LOOP);
			CUR_SHOCK_TARG_IDX = 0;
		}
		if (GUARD_ELEMENT == "fire")
		{
			npcatk_suspend_roam(10.0);
			SetNoPush(true);
			string TRACE_START = GetEntityOrigin(GetOwner());
			string TRACE_END = TRACE_START;
			TRACE_END += "z";
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
			ClientEvent("update", "all", CL_FX_INDEX, "poison_storm_on", (TRACE_LINE).z);
			poison_storm_loop();
			ScheduleDelayedEvent(10.0, "poison_storm_end");
			Effect("beam", "ents", "lgtning.spr", 60, GetOwner(), 2, GetOwner(), 4, STAFF_BEAM_COLOR, 200, 60, 10.0);
			SHOCK_STORM_BEAM_ID = GetEntityIndex(m_hLastCreated);
			EmitSound(GetOwner(), 1, SOUND_SHOCK_START, 10);
			CUR_SHOCK_TARG_IDX = 0;
		}
	}

	void poison_storm_loop()
	{
		if (!(SHOCK_STORM_ON)) return;
		ScheduleDelayedEvent(0.5, "poison_storm_loop");
		STORM_TARGS = FindEntitiesInSphere("enemy", 768);
		if (!(STORM_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(STORM_TARGS, ";"); i++)
		{
			poison_storm_affect_targets();
		}
	}

	void poison_storm_affect_targets()
	{
		string CUR_TARG = GetToken(STORM_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_poison", 10.0, GetEntityIndex(GetOwner()), FLAME_JET_DOT);
	}

	void poison_storm_end()
	{
		SetNoPush(false);
		SHOCK_STORM_ON = 0;
		// svplaysound: svplaysound 3 0 SOUND_SHOCK_LOOP
		EmitSound(3, 0, SOUND_SHOCK_LOOP);
		ClientEvent("update", "all", CL_FX_INDEX, "poison_storm_end");
		delay_specials();
	}

	void shock_storm_loop()
	{
		if (!(SHOCK_STORM_ON)) return;
		ScheduleDelayedEvent(0.5, "shock_storm_loop");
		if (!(SHOCK_TARGS != "none")) return;
		string N_SHOCK_TARGS_M1 = GetTokenCount(SHOCK_TARGS, ";");
		N_SHOCK_TARGS_M1 -= 1;
		if (CUR_SHOCK_TARG_IDX > N_SHOCK_TARGS_M1)
		{
			CUR_SHOCK_TARG_IDX = 0;
		}
		string CUR_TARG = GetToken(SHOCK_TARGS, CUR_SHOCK_TARG_IDX, ";");
		string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
		string TRACE_END = GetEntityOrigin(CUR_TARG);
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (TRACE_LINE == TRACE_END)
		{
			EmitSound(GetOwner(), 0, SOUND_SHOCK_HIT, 10);
			string L_DOT_SHOCK = DOT_SHOCK;
			L_DOT_SHOCK *= 2;
			XDoDamage(CUR_TARG, "direct", L_DOT_SHOCK, 1.0, GetOwner(), GetOwner(), "none", "lightning");
			ApplyEffect(CUR_TARG, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
			string TARG_ORG = GetEntityOrigin(CUR_TARG);
			string MY_ORG = GetEntityOrigin(GetOwner());
			string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, VEL_SHOCK_F, 110)));
			Effect("beam", "update", SHOCK_STORM_BEAM_ID, "end_target", CUR_TARG);
			Effect("beam", "update", SHOCK_STORM_BEAM_ID, "brightness", 200);
		}
		else
		{
			Effect("beam", "update", SHOCK_STORM_BEAM_ID, "end_target", GetOwner());
			Effect("beam", "update", SHOCK_STORM_BEAM_ID, "brightness", 0);
		}
		CUR_SHOCK_TARG_IDX += 1;
	}

	void shock_storm_end()
	{
		SHOCK_STORM_ON = 0;
		// svplaysound: svplaysound 3 0 SOUND_SHOCK_LOOP
		EmitSound(3, 0, SOUND_SHOCK_LOOP);
		ClientEvent("update", "all", CL_FX_INDEX, "shock_storm_end");
		delay_specials();
	}

	void ext_shender_fail()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void set_agro()
	{
		BE_AGGRESSIVE = 1;
	}

}

}
