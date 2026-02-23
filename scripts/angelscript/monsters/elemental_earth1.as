#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"
#include "monsters/base_struck.as"

namespace MS
{

class ElementalEarth1 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int AS_SUMMON_TELE_CHECK;
	string ATTACK_CYCLE;
	string ATTACK_HITRANGE;
	string ATTACK_MOVERANGE;
	string ATTACK_RANGE;
	string BURST_POS;
	string CL_SHIELD_IDX;
	string DID_ALERT;
	string DID_SPECIAL;
	int EARTHQUAKE_ACTIVE;
	string EARTHQUAKE_TARGS;
	string FISSURE_ANG;
	string FISSURE_CHECK_POS;
	int FISSURE_COUNT;
	string FISSURE_DIR;
	string FISSURE_MOVESTEP;
	string FISSURE_ORG;
	int IMMUNE_VAMPIRE;
	int IS_BLOODLESS;
	int IS_UNHOLY;
	string NEXT_ACTION;
	string NEXT_BEAM;
	string NEXT_FISSURE;
	string NEXT_LONG;
	string NEXT_ROCK;
	string NEXT_SHIELD_HITFX;
	string NPCATK_TARGET;
	string NPC_GIVE_EXP;
	string NPC_HACKED_MOVE_SPEED;
	int NPC_NO_ATTACK;
	string ROCK_STRIKE_POS;
	int SHIELD_ACTIVE;
	string SHIELD_TARGET;
	string SUSPEND_CYCLE;

	ElementalEarth1()
	{
		AS_SUMMON_TELE_CHECK = 1;
		ANIM_IDLE = "idle1";
		ANIM_WALK = "idle1";
		ANIM_RUN = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "die1";
		NPC_NO_ATTACK = 1;
		const string ANIM_SEARCH = "dunno";
		const int ELEMENTAL_EXP = 300;
		NPC_GIVE_EXP = ELEMENTAL_EXP;
		const int MOVE_FAST = 100;
		const int MOVE_NORMAL = 50;
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		const int ELEMENTAL_MOVERANGE = 2048;
		ATTACK_RANGE = ELEMENTAL_MOVERANGE;
		ATTACK_HITRANGE = ELEMENTAL_MOVERANGE;
		ATTACK_MOVERANGE = ELEMENTAL_MOVERANGE;
		const string SOUND_DEATH = "garg/gar_die1.wav";
		const string NPC_MATERIAL_TYPE = "stone";
		const int NPC_USE_FLINCH = 1;
		ANIM_FLINCH = "flinch";
		const int NPC_PITCH_FLINCH = 60;
		const string SOUND_FLINCH1 = "debris/bustflesh2.wav";
		const string SOUND_FLINCH2 = "agrunt/ag_pain1.wav";
		const string SOUND_FLINCH3 = "agrunt/ag_pain4.wav";
		const int NPC_USE_PAIN = 1;
		const int NPC_PITCH_PAIN = 60;
		const string SOUND_PAIN1 = "debris/bustflesh2.wav";
		const string SOUND_PAIN2 = "agrunt/ag_pain1.wav";
		const string SOUND_PAIN3 = "agrunt/ag_pain4.wav";
		const int NPC_USE_IDLE = 1;
		const int NPC_PITCH_IDLE = 60;
		const string SOUND_IDLE1 = "agrunt/ag_alert1.wav";
		const string SOUND_IDLE2 = "agrunt/ag_die1.wav";
		const string SOUND_IDLE3 = "agrunt/ag_idle1.wav";
		const int ELEMENTAL_LEVEL = 1;
		const int SWIPE_RANGE = 100;
		const int SWIPE_HITRANGE = 150;
		const string SOUND_ALERT = "agrunt/ag_alert5.wav";
		const int PITCH_LEVEL = 60;
		const string SOUND_SWIPE_MISS = "weapons/debris1.wav";
		const string SOUND_SWIPE_HIT = "weapons/cbar_hitbod1.wav";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
		const string SOUND_EARTHQUAKE_START = "magic/volcano_start.wav";
		const string SOUND_EARTHQUAKE_LOOP = "magic/volcano_loop.wav";
		const float FREQ_ROCK = 3.0;
		const string FREQ_FISSURE = Random(8.0, 12.0);
		const string FREQ_LONG = Random(20.0, 30.0);
		const int NUM_LONGS = 1;
		const float SHIELD_DURATION = 10.0;
		const float EARTHQUAKE_DURATION = 10.0;
		const int EARTHQUAKE_AOE = 512;
		const int HITCHANCE_SWIPE = 80;
		const string DMG_SWIPE = RandomInt(60, 100);
		const string DMG_ROCK = RandomInt(150, 200);
		const string DMG_FISSURE = RandomInt(60, 100);
		const string DMG_STORM = RandomInt(75, 150);
		const int DOT_EARTHQUAKE = 100;
		const int FISSURE_LENGTH = 768;
		const string ANIM_TOCHARGE = "tocharge";
		const string ANIM_CHARGEIDLE = "charging";
		const string ANIM_FROMCHARGE = "fromcharge";
		const string ANIM_ALERT = "yes";
		const string ANIM_ROCK = "no";
		const string ANIM_FIRE_BALL = "fireball";
		const string ANIM_QUICKBLOCK = "block";
	}

	void game_precache()
	{
		Precache("rockgibs.mdl");
		Precache("rain_ripple.spr");
		Precache("monsters/elemental_earth_cl");
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_SHOCK1
		EmitSound(0, 0, SOUND_SHOCK1);
		// svplaysound: svplaysound 0 0 SOUND_SHOCK2
		EmitSound(0, 0, SOUND_SHOCK2);
		// svplaysound: svplaysound 0 0 SOUND_SHOCK3
		EmitSound(0, 0, SOUND_SHOCK3);
		// svplaysound: svplaysound 0 0 weapons/debris1.wav
		EmitSound(0, 0, "weapons/debris1.wav");
		// svplaysound: svplaysound 0 0 SOUND_EARTHQUAKE_START
		EmitSound(0, 0, SOUND_EARTHQUAKE_START);
		// svplaysound: svplaysound 0 0 SOUND_EARTHQUAKE_LOOP
		EmitSound(0, 0, SOUND_EARTHQUAKE_LOOP);
	}

	void OnSpawn() override
	{
		elemental_spawn();
	}

	void elemental_spawn()
	{
		SetName("Earth Elemental");
		SetModel("monsters/elementals_lesser.mdl");
		SetHealth(500);
		SetWidth(32);
		SetHeight(96);
		SetRace("demon");
		SetBloodType("none");
		IS_BLOODLESS = 1;
		IMMUNE_VAMPIRE = 1;
		IS_UNHOLY = 1;
		SetDamageResistance("all", 0.30);
		SetDamageResistance("holy", 3.0);
		SetDamageResistance("poison", 0.0);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(5);
		SetModelBody(0, 3);
	}

	void npc_targetsighted()
	{
		string L_GAME_TIME = GetGameTime();
		if (!(L_GAME_TIME > NEXT_ACTION)) return;
		if ((SUSPEND_AI)) return;
		if (!(DID_ALERT))
		{
			EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
			PlayAnim("critical", ANIM_ALERT);
			DID_ALERT = 1;
			NEXT_ACTION = L_GAME_TIME;
			NEXT_ACTION += 0.5;
			int EXIT_SUB = 1;
			ATTACK_CYCLE = 0;
			NEXT_ROCK = L_GAME_TIME;
			NEXT_ROCK += FREQ_ROCK;
			NEXT_FISSURE = L_GAME_TIME;
			NEXT_FISSURE += FREQ_FISSURE;
			NEXT_LONG = L_GAME_TIME;
			NEXT_LONG += FREQ_LONG;
		}
		if ((EXIT_SUB)) return;
		if ((I_R_FROZEN)) return;
		if ((SUSPEND_CYCLE)) return;
		if (L_GAME_TIME > NEXT_LONG)
		{
			if (GetEntityRange(m_hAttackTarget) < 640)
			{
			}
			DID_SPECIAL = 1;
			if (LONG_SELECT >= NUM_LONGS)
			{
				LONG_SELECT = 0;
			}
			LONG_SELECT += 1;
			NEXT_LONG = L_GAME_TIME;
			NEXT_LONG += FREQ_LONG;
			if (LONG_SELECT == 1)
			{
				NEXT_ACTION = L_GAME_TIME;
				NEXT_ACTION += 1.0;
				do_shield();
				int EXIT_SUB = 1;
			}
			else
			{
				if (LONG_SELECT == 2)
				{
					do_earthquake();
					int EXIT_SUB = 1;
				}
				else
				{
					if (LONG_SELECT == 3)
					{
						NEXT_ACTION = L_GAME_TIME;
						NEXT_ACTION += 1.0;
						do_storm();
						int EXIT_SUB = 1;
					}
				}
			}
		}
		if ((EXIT_SUB)) return;
		if (L_GAME_TIME > NEXT_FISSURE)
		{
			if (GetEntityRange(m_hAttackTarget) < 640)
			{
			}
			NEXT_FISSURE = L_GAME_TIME;
			NEXT_FISSURE += FREQ_FISSURE;
			NEXT_ACTION = L_GAME_TIME;
			NEXT_ACTION += 4.0;
			NEXT_ROCK = L_GAME_TIME;
			NEXT_ROCK += 5.0;
			PlayAnim("critical", ANIM_FIRE_BALL);
			DID_SPECIAL = 1;
			do_fissure();
		}
		if ((EXIT_SUB)) return;
		if (L_GAME_TIME > NEXT_ROCK)
		{
			PlayAnim("critical", ANIM_ROCK);
			summon_rock(GetEntityOrigin(m_hAttackTarget));
			NEXT_ROCK = L_GAME_TIME;
			NEXT_ROCK += FREQ_ROCK;
			DID_SPECIAL = 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetEntityRange(m_hAttackTarget) < SWIPE_RANGE)
		{
			if ((DID_SPECIAL))
			{
			}
			NEXT_ROCK = L_GAME_TIME;
			NEXT_ROCK += FREQ_ROCK;
			PlayAnim("once", ANIM_ATTACK);
		}
	}

	void attack1_strike()
	{
		if (RandomInt(1, 3) == 1)
		{
			DID_SPECIAL = 0;
		}
		XDoDamage(m_hAttackTarget, SWIPE_HITRANGE, DMG_SWIPE, HITCHANCE_SWIPE, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:swipe");
	}

	void swipe_dodamage()
	{
		if (!(param1))
		{
			EmitSound(GetOwner(), 0, SOUND_SWIPE_MISS, 10);
		}
		if (!(param1)) return;
		EmitSound(GetOwner(), 0, SOUND_SWIPE_HIT, 10);
		if (!(GetRelationship(param2) == "enemy")) return;
		if (!(RandomInt(1, 3) == 1)) return;
		if (ELEMENTAL_LEVEL == 1)
		{
			ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		}
		else
		{
			ApplyEffect(param2, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
		}
	}

	void summon_rock()
	{
		string L_POS = param1;
		string L_TRACE_START = L_POS;
		string L_TRACE_END = L_POS;
		L_TRACE_END += "z";
		string L_TRACE = TraceLine(L_TRACE_START, L_TRACE_END);
		string L_POS = L_TRACE;
		if (L_TRACE != L_TRACE_END)
		{
			L_POS += "z";
		}
		ClientEvent("new", "all", "monsters/elemental_earth_cl", GetEntityIndex(GetOwner()), "spawn_rock", L_POS);
		string L_GROUND = /* TODO: $get_ground_height */ $get_ground_height(L_POS);
		string L_DROP_DIST = /* TODO: $math(subtract) */ L_GROUND;
		if (L_DROP_DIST < 0)
		{
			string L_DROP_DIST = /* TODO: $neg */ $neg(L_DROP_DIST);
		}
		string L_DROP_TIME = /* TODO: $math(divide) */ L_DROP_DIST;
		L_DROP_TIME += 2;
		ROCK_STRIKE_POS = Vector3((L_POS).x, (L_POS).y, L_GROUND);
		L_DROP_TIME("ext_mob_clreturn");
	}

	void ext_mob_clreturn()
	{
		string L_GIB_POS = ROCK_STRIKE_POS;
		L_GIB_POS = "z";
		L_GIB_POS += "z";
		Effect("tempent", "gibs", "rockgibs.mdl", ROCK_STRIKE_POS, 10.0, /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, 300)), 50, 100, 5);
		Effect("screenshake", ROCK_STRIKE_POS, 100, 5, 3, 500);
		BURST_POS = ROCK_STRIKE_POS;
		XDoDamage(ROCK_STRIKE_POS, 128, DMG_ROCK, 0.1, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:rock");
	}

	void rock_dodamage()
	{
		if (!(ELEMENTAL_LEVEL > 1)) return;
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		string CUR_TARG = param2;
		repel_target(CUR_TARG, Vector3(0, 500, 110), BURST_POS);
	}

	void repel_target()
	{
		string L_TARG_ORG = GetEntityOrigin(param1);
		string L_MY_ORG = param3;
		string L_TARG_ANG = /* TODO: $angles */ $angles(L_MY_ORG, L_TARG_ORG);
		string L_NEW_YAW = L_TARG_ANG;
		SetVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, L_NEW_YAW, 0), param2));
	}

	void OnDamage(int damage) override
	{
		if ((param3).findFirst("lightning") >= 0)
		{
			SetDamage("dmg");
			SetDamage("hit");
			ReturnData(0);
			if (GetRelationship(param1) == "enemy")
			{
			}
			string L_RND_SND = RandomInt(1, 3);
			if (L_RND_SND == 1)
			{
				EmitSound3D(SOUND_SHOCK1, 10, GetEntityOrigin(param1));
			}
			else
			{
				if (L_RND_SND == 2)
				{
					EmitSound3D(SOUND_SHOCK2, 10, GetEntityOrigin(param1));
				}
				else
				{
					if (L_RND_SND == 3)
					{
						EmitSound3D(SOUND_SHOCK3, 10, GetEntityOrigin(param1));
					}
				}
			}
			// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
			array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
			if (GetGameTime() > NEXT_SHOCK_MSG)
			{
				SendPlayerMessage(param1, "GetEntityName(GetOwner()) redirects your electrical attacks!");
				NEXT_SHOCK_MSG = GetGameTime();
				NEXT_SHOCK_MSG += 5.0;
			}
			XDoDamage(param1, 1024, param2, 1.0, GetOwner(), GetOwner(), "lightning_effect", "dmgevent:zap");
			if (GetGameTime() > NEXT_BEAM)
			{
			}
			NEXT_BEAM = GetGameTime();
			NEXT_BEAM += 0.5;
			if (ELEMENTAL_LEVEL > 1)
			{
				HealEntity(GetOwner(), param2);
				Effect("glow", GetOwner(), Vector3(0, 255, 0), 22, 0.5, 0.25);
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SHIELD_ACTIVE)) return;
		if (!((param3).findFirst("effect") >= 0)) return;
		string L_ATK_ORG = GetEntityOrigin(param1);
		string L_MY_ORG = GetEntityOrigin(GetOwner());
		string L_MY_ANG = GetEntityAngles(GetOwner());
		if ((WithinCone2D(L_ATK_ORG, L_MY_ORG, L_MY_ANG)))
		{
			SetDamage("dmg");
			SetDamage("hit");
			ReturnData(0);
			int L_BLOCKED = 1;
		}
		if (!(L_BLOCKED)) return;
		if (GetGameTime() > NEXT_SHIELD_HITFX)
		{
			NEXT_SHIELD_HITFX = GetGameTime();
			NEXT_SHIELD_HITFX += 0.1;
			ClientEvent("update", "all", CL_SHIELD_IDX, "shield_hit");
			EmitSound(GetOwner(), 2, "player/pl_metal2.wav", 10);
			SendColoredMessage(param1, "GetEntityName(GetOwner()) blocks your attack.");
		}
	}

	void zap_dodamage()
	{
		if (!(param1)) return;
		Effect("beam", "end", "lgtning.spr", 30, GetEntityOrigin(param2), GetOwner(), 0, Vector3(128, 128, 255), 200, 10, 0.5);
	}

	void do_fissure()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 4.0;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -1000, 0));
		SetMoveDest(m_hAttackTarget);
		ScheduleDelayedEvent(0.5, "do_fissure2");
	}

	void do_fissure2()
	{
		LogDebug("attack1_strike");
		string L_MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		string L_FISSURE_END = GetEntityOrigin(GetOwner());
		L_FISSURE_END += /* TODO: $relpos */ $relpos(Vector3(0, L_MY_YAW, 0), Vector3(0, FISSURE_LENGTH, 0));
		ClientEvent("new", "all", "effects/sfx_fissure", GetEntityOrigin(GetOwner()), L_MY_YAW, L_FISSURE_END, FISSURE_LENGTH, 0, 1);
		FISSURE_ORG = GetEntityOrigin(GetOwner());
		FISSURE_ANG = GetEntityAngles(GetOwner());
		FISSURE_DIR = (L_FISSURE_END - FISSURE_ORG).Normalize();
		FISSURE_MOVESTEP = /* TODO: $math(multiply) */ FISSURE_LENGTH;
		FISSURE_COUNT = 0;
		fissure_travel_loop();
	}

	void fissure_travel_loop()
	{
		FISSURE_COUNT += 1;
		string L_FISSURE_CHECK_POS = FISSURE_ORG;
		string L_FISSURE_MOVEAMT = FISSURE_DIR;
		L_FISSURE_MOVEAMT *= /* TODO: $math(multiply) */ FISSURE_MOVESTEP;
		L_FISSURE_CHECK_POS += L_FISSURE_MOVEAMT;
		L_FISSURE_CHECK_POS += "z";
		L_FISSURE_CHECK_POS = "z";
		FISSURE_CHECK_POS = L_FISSURE_CHECK_POS;
		XDoDamage(L_FISSURE_CHECK_POS, FISSURE_MOVESTEP, 0, 0, GetOwner(), GetOwner(), "none", "target", "dmgevent:fissure");
		if (FISSURE_COUNT < 7)
		{
			ScheduleDelayedEvent(0.20, "fissure_travel_loop");
		}
		if ((G_DEVELOPER_MODE))
		{
			string L_VEC_UP = L_FISSURE_CHECK_POS;
			L_VEC_UP += "z";
			Effect("beam", "point", "lgtning.spr", 10, L_FISSURE_CHECK_POS, L_VEC_UP, Vector3(255, 0, 255), 255, 0, 0.25);
		}
		EmitSound3D("weapons/debris1.wav", 10, L_FISSURE_CHECK_POS, 0.8, 0, 30);
	}

	void fissure_dodamage()
	{
		if (!(param1)) return;
		string CUR_TARG = param2;
		string CUR_TARG_POS = GetEntityOrigin(CUR_TARG);
		string L_MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(FISSURE_ANG);
		string L_RND_LR = RandomInt(0, 1);
		int L_LR = -400;
		if (L_RND_LR == 1)
		{
			int L_LR = 400;
		}
		Vector3 L_VEL = Vector3(L_LR, 0, 400);
		string CUR_TARG_ANGS = GetEntityAngles(CUR_TARG);
		SetVelocity(param2, /* TODO: $relvel */ $relvel(FISSURE_ANG, L_VEL));
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		ApplyEffect(CUR_TARG, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
		string L_DMG = DMG_ROCK;
		if ((GetEntityProperty(CUR_TARG, "nopush")))
		{
			L_DMG *= 5;
		}
		XDoDamage(CUR_TARG, "direct", L_DMG, 1.0, GetOwner(), GetOwner(), "none", "blunt_effect");
	}

	void func_inrange()
	{
		if (param1 >= /* TODO: $math(subtract) */ param2)
		{
			int L_IN_RANGE = 1;
		}
		if (param1 <= /* TODO: $math(add) */ param2)
		{
			L_IN_RANGE += 1;
		}
		if (L_IN_RANGE > 1)
		{
			return;
		}
		else
		{
			return;
		}
	}

	void do_shield()
	{
		SHIELD_TARGET = m_hAttackTarget;
		SHIELD_ACTIVE = 1;
		SHIELD_DURATION("end_shield");
		if (ELEMENTAL_LEVEL == 1)
		{
			npcatk_suspend_movement(ANIM_CHARGEIDLE);
			SUSPEND_CYCLE = 1;
			shield_loop();
		}
		else
		{
			PlayAnim("critical", ANIM_TOCHARGE);
		}
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 16, 2, 1);
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
		ClientEvent("new", "all", "monsters/elemental_earth_cl", GetEntityIndex(GetOwner()), "do_shield", SHIELD_DURATION);
		CL_SHIELD_IDX = "game.script.last_sent_id";
	}

	void shield_loop()
	{
		if (!(SHIELD_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "shield_loop");
		SetMoveDest(SHIELD_TARGET);
	}

	void npc_targetvalidate()
	{
		if (!(SHIELD_ACTIVE)) return;
		if (!(m_hAttackTarget != SHIELD_TARGET)) return;
		NPCATK_TARGET = SHIELD_TARGET;
	}

	void end_shield()
	{
		if (ELEMENTAL_LEVEL == 1)
		{
			npcatk_resume_movement();
			SUSPEND_CYCLE = 0;
		}
		SHIELD_ACTIVE = 0;
	}

	void do_storm()
	{
		PlayAnim("once", ANIM_ALERT);
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		SpawnNPC("monsters/summon/rock_storm", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 4, DMG_STORM, 64, 100
	}

	void do_earthquake()
	{
		ATTACK_MOVERANGE = 9999;
		EARTHQUAKE_ACTIVE = 1;
		npcatk_suspend_movement(ANIM_CHARGEIDLE);
		SUSPEND_CYCLE = 1;
		// svplaysound: svplaysound 1 10 SOUND_EARTHQUAKE_START 0.8 PITCH_LEVEL
		EmitSound(1, 10, SOUND_EARTHQUAKE_START, 0.8, PITCH_LEVEL);
		// svplaysound: svplaysound 3 10 SOUND_EARTHQUAKE_LOOP 0.8 PITCH_LEVEL
		EmitSound(3, 10, SOUND_EARTHQUAKE_LOOP, 0.8, PITCH_LEVEL);
		EARTHQUAKE_DURATION("earthquake_end");
		ScheduleDelayedEvent(0.1, "earthquake_loop");
		Effect("screenshake", GetEntityOrigin(GetOwner()), 50, 10, EARTHQUAKE_DURATION, /* TODO: $math(multiply) */ EARTHQUAKE_AOE);
		ClientEvent("new", "all", "effects/sfx_quake", GetEntityIndex(GetOwner()), 1, EARTHQUAKE_AOE, EARTHQUAKE_DURATION);
	}

	void earthquake_loop()
	{
		if (!(EARTHQUAKE_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "earthquake_loop");
		EARTHQUAKE_TARGS = FindEntitiesInSphere("enemy", EARTHQUAKE_AOE);
		if (!(EARTHQUAKE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(EARTHQUAKE_TARGS, ";"); i++)
		{
			earthquake_applyeffect();
		}
	}

	void earthquake_applyeffect()
	{
		string CUR_TARG = GetToken(EARTHQUAKE_TARGS, i, ";");
		if (!(IsOnGround(CUR_TARG))) return;
		ApplyEffect(CUR_TARG, "effects/effect_quake", EARTHQUAKE_DURATION, GetEntityIndex(GetOwner()), EARTHQUAKE_AOE, DOT_EARTHQUAKE, GetEntityIndex(GetOwner()), 1);
	}

	void earthquake_end()
	{
		ATTACK_MOVERANGE = ELEMENTAL_MOVERANGE;
		// svplaysound: svplaysound 3 0 SOUND_EARTHQUAKE_LOOP
		EmitSound(3, 0, SOUND_EARTHQUAKE_LOOP);
		EARTHQUAKE_ACTIVE = 0;
		npcatk_resume_movement();
		SUSPEND_CYCLE = 0;
	}

}

}
