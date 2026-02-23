#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class IceMage : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BEAM_DEFINED;
	string BEAM_ID;
	string BEAM_ON;
	string BEAM_TARGET;
	string BEAM_TRACE_END;
	string BEAM_TRACE_START;
	string BOLT_DELAY;
	string BUGGER_ID;
	int BUGGER_IN_WAY;
	int BUGGER_IN_WAY_COUNT;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	int FBEAM_ATTACK;
	int FOUND_NEAR_TARGET;
	string FREEZE_SOUND_DELAY;
	int ICE_SUMMONED;
	int IS_UNHOLY;
	string LAST_TELE;
	string MY_LIGHT_SCRIPT;
	string NEAR_DEST;
	string NEW_FREEZE_TARGET;
	string NEW_TARGET;
	int NPC_GIVE_EXP;
	int N_TELES;
	string OWNER_ID;
	string PROJSET_DAMAGE;
	float PROJSET_DURATION;
	int RENDER_COUNT;
	int SEARCH_RAD;
	string TELE_ANG;
	string TELE_ANGS;
	string TELE_DEST;
	string TELE_ID1;
	string TELE_ID2;
	string TELE_ID3;
	string TELE_ID4;

	IceMage()
	{
		const string FREQ_TELE = Random(5, 10);
		IS_UNHOLY = 1;
		ANIM_IDLE = "idle";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "ref_shoot_staff";
		ANIM_DEATH = "die_simple";
		const string ANIM_IDLE_ALERT = "alert_idle";
		const string ANIM_JUMP = "long_jump";
		const string ANIM_FREEZE_RAY = "ref_shoot_rayspell";
		const string ANIM_CAST = "cast";
		const string ANIM_FLY = "jump";
		const string ANIM_LOOK = "look";
		const string ANIM_DEATH1 = "die_simple";
		const string ANIM_DEATH2 = "die_backwards1";
		const string ANIM_DEATH3 = "die_backwards";
		const string ANIM_DEATH4 = "die_forwards";
		const string ANIM_DEATH5 = "headshot";
		const string ANIM_DEATH6 = "die_spin";
		const string ANIM_DEATH7 = "gutshot";
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 170;
		ATTACK_MOVERANGE = 300;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(10, 20);
		NPC_GIVE_EXP = 350;
		const Vector3 LIGHT_COLOR = Vector3(200, 200, 255);
		const int LIGHT_RAD = 96;
		const string FINGER_ADJ = "$relpos($vec(0,MY_YAW,0),$vec(0,30,54))";
		const string DMG_SWIPE = RandomInt(20, 50);
		const string DMG_STAFF = RandomInt(100, 200);
		const string DMG_BOLT = RandomInt(100, 200);
		const string DMG_DOT_BOLT = RandomInt(30, 50);
		const string DMG_SOLID = RandomInt(20, 30);
		const int DMG_BEAM = 3;
		const int FBEAM_RANGE = 1024;
		const float ATTACK_HITCHANCE = 0.95;
		const float FREQ_BOLT = 2.0;
		const float FREQ_FREEZE = 1.0;
		const float FREQ_FREEZE_SOUND = 1.6;
		const int BOLT_SPEED = 300;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_DEATH = "voices/kcult_pain1.wav";
		const string SOUND_FROSTBOLT = "magic/frost_pulse.wav";
		const string SOUND_FREEZE_BEAM = "magic/freezeray_loop.wav";
		const string SOUND_BLIZZARD = "doors/aliendoor3.wav";
		const string SOUND_STUCK1 = "debris/glass1.wav";
		const string SOUND_STUCK2 = "debris/glass2.wav";
		const string SOUND_TELE = "magic/teleport.wav";
		Precache(SOUND_DEATH);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_TELE);
		if (N_TELES > 0)
		{
		}
		string LAST_TELE_DIFF = GetGameTime();
		LAST_TELE_DIFF -= G_ICE_TELE;
		if (LAST_TELE_DIFF > 5)
		{
		}
		if (!(CanSee(m_hAttackTarget, 256)))
		{
		}
		string TOTAL_TELES = N_TELES;
		TOTAL_TELES += 1;
		GetAllPlayers(PLAYER_LIST);
		FOUND_NEAR_TARGET = 0;
		SEARCH_RAD = 512;
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			find_near_teleporter();
		}
		if (FOUND_NEAR_TARGET > 0)
		{
		}
		npcatk_settarget(NEW_TARGET);
		if ((G_DEVELOPER_MODE))
		{
			SendInfoMessageToAll("green ICE_MAGE: found GetEntityName(NEW_TARGET) near FOUND_NEAR_TARGET");
		}
		string PICK_TELE = FOUND_NEAR_TARGET;
		if (PICK_TELE == 1)
		{
			TELE_DEST = GetEntityOrigin(TELE_ID1);
			TELE_ANG = GetEntityAngles(TELE_ID1);
			CallExternal(TELE_ID1, "tele_used");
		}
		if (PICK_TELE == 2)
		{
			TELE_DEST = GetEntityOrigin(TELE_ID2);
			TELE_ANG = GetEntityAngles(TELE_ID2);
			CallExternal(TELE_ID2, "tele_used");
		}
		if (PICK_TELE == 3)
		{
			TELE_DEST = GetEntityOrigin(TELE_ID3);
			TELE_ANG = GetEntityAngles(TELE_ID3);
			CallExternal(TELE_ID3, "tele_used");
		}
		if (PICK_TELE == 4)
		{
			TELE_DEST = GetEntityOrigin(TELE_ID4);
			TELE_ANG = GetEntityAngles(TELE_ID4);
			CallExternal(TELE_ID4, "tele_used");
		}
		if (PICK_TELE > N_TELES)
		{
			TELE_DEST = NPC_SPAWN_LOC;
			TELE_DEST += "z";
			TELE_ANGS = NPC_SPAWN_ANGLES;
		}
		SpawnNPC("monsters/summon/ibarrier", TELE_DEST, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 64, 2, 0, 0, 0, 1
		LAST_TELE = GetGameTime();
		SetGlobalVar("G_ICE_TELE", GetGameTime());
		ScheduleDelayedEvent(0.25, "flicker_out");
		ScheduleDelayedEvent(0.75, "tele_out");
		ScheduleDelayedEvent(1.5, "tele_in");
	}

	void OnSpawn() override
	{
		if (!(ICE_SUMMONED))
		{
			SetName("Ice Mage");
		}
		SetModel("monsters/ice_mage.mdl");
		SetHealth(1500);
		SetRace("demon");
		SetWidth(32);
		if (!(AM_TURRET))
		{
			SetHeight(72);
		}
		if ((AM_TURRET))
		{
			SetHeight(48);
		}
		SetRoam(true);
		SetHearingSensitivity(4);
		SetFly(false);
		SetProp(GetOwner(), "skin", 1);
		PROJSET_DURATION = 10.0;
		PROJSET_DAMAGE = DMG_DOT_BOLT;
		ScheduleDelayedEvent(1.0, "get_teleporters");
	}

	void OnPostSpawn() override
	{
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("cold", 0);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("poison", 0.5);
		light_me();
		Effect("beam", "ents", "lgtning.spr", 10, GetOwner(), 1, GetOwner(), 2, Vector3(200, 200, 255), 0, 0, -1);
		BEAM_ID = GetEntityIndex(m_hLastCreated);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (G_BEAMER == GetEntityIndex(GetOwner()))
		{
			SetGlobalVar("G_BEAMER", "unset");
		}
		if (G_BEAMER == GetEntityIndex(GetOwner()))
		{
			SetGlobalVar("G_ICE_TELE", 0);
		}
		if ((ICE_SUMMONED))
		{
			CallExternal(OWNER_ID, "ext_ice_mage_died");
		}
		Effect("beam", "update", BEAM_ID, "remove", 0.1);
		string RND_DEATH = RandomInt(1, 7);
		if (RND_DEATH == 1)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
		if (RND_DEATH == 2)
		{
			ANIM_DEATH = ANIM_DEATH2;
		}
		if (RND_DEATH == 3)
		{
			ANIM_DEATH = ANIM_DEATH3;
		}
		if (RND_DEATH == 4)
		{
			ANIM_DEATH = ANIM_DEATH4;
		}
		if (RND_DEATH == 5)
		{
			ANIM_DEATH = ANIM_DEATH5;
		}
		if (RND_DEATH == 6)
		{
			ANIM_DEATH = ANIM_DEATH6;
		}
		if (RND_DEATH == 7)
		{
			ANIM_DEATH = ANIM_DEATH7;
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetEntityIndex(G_BEAMER) != GetEntityIndex(GetOwner()))
		{
			if ((BEAM_ON))
			{
			}
			Effect("beam", "update", BEAM_ID, "brightness", 0);
			BEAM_ON = 0;
		}
	}

	void npc_targetsighted()
	{
		if ((I_R_FROZEN)) return;
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)) return;
		if (!(BOLT_DELAY))
		{
			if (GetEntityIndex(G_BEAMER) != GetEntityIndex(GetOwner()))
			{
			}
			BOLT_DELAY = 1;
			FREQ_BOLT("reset_bolt_delay");
			PlayAnim("critical", ANIM_CAST);
			string L_POS = GetEntityOrigin(GetOwner());
			L_POS += "z";
			TossProjectile("proj_ice_bolt2", L_POS, m_hAttackTarget, BOLT_SPEED, DMG_BOLT, 0, "none");
			EmitSound(GetOwner(), 0, SOUND_FROSTBOLT, 10);
		}
		if ((IsEntityAlive(G_BEAMER)))
		{
			if (GetEntityIndex(G_BEAMER) != GetEntityIndex(GetOwner()))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((GetEntityProperty(m_hAttackTarget, "scriptvar")))
		{
			SetGlobalVar("G_BEAMER", "unset");
		}
		if (!(GetEntityProperty(m_hAttackTarget, "scriptvar") != 1)) return;
		if (!(GetEntityRange(m_hAttackTarget) < FBEAM_RANGE)) return;
		if (!(FREEZE_SOUND_DELAY))
		{
			// svplaysound: svplaysound 2 5 SOUND_FREEZE_BEAM
			EmitSound(2, 5, SOUND_FREEZE_BEAM);
			FREEZE_SOUND_DELAY = 1;
			FREQ_FREEZE_SOUND("reset_freeze_sound_delay");
			if ((BEAM_DEFINED))
			{
				string L_BEAM_START = GetMonsterProperty("origin");
				string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
				L_BEAM_START += FINGER_ADJ;
				string BEAM_DUR = FREQ_FREEZE_SOUND;
				BEAM_DUR += 0.25;
			}
		}
		AS_ATTACKING = GetGameTime();
		PlayAnim("once", "cast");
		FBEAM_ATTACK = 1;
		SetGlobalVar("G_BEAMER", GetEntityIndex(GetOwner()));
		if (!(BEAM_ON))
		{
			Effect("beam", "update", BEAM_ID, "brightness", 255);
			BEAM_ON = 1;
		}
		npcatk_dodamage(m_hAttackTarget, FBEAM_RANGE, DMG_BEAM, 1.0, "cold");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(false))
		{
			ATTACK_MOVERANGE = GetMonsterProperty("moveprox");
		}
		if ((false))
		{
			ATTACK_MOVERANGE = 300;
		}
		if (!(GetEntityIndex(G_BEAMER) == GetEntityIndex(GetOwner()))) return;
		if (GetEntityRange(m_hAttackTarget) > FBEAM_RANGE)
		{
			SetGlobalVar("G_BEAMER", "unset");
		}
		if (!(false))
		{
			SetGlobalVar("G_BEAMER", "unset");
		}
	}

	void reset_freeze_sound_delay()
	{
		// svplaysound: svplaysound 2 0 SOUND_FREEZE_BEAM
		EmitSound(2, 0, SOUND_FREEZE_BEAM);
		FREEZE_SOUND_DELAY = 0;
	}

	void reset_bolt_delay()
	{
		BOLT_DELAY = 0;
	}

	void game_dodamage()
	{
		if ((FBEAM_ATTACK))
		{
			FBEAM_ATTACK = 0;
			string TRACE_START = GetEntityOrigin(GetOwner());
			string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
			TRACE_START += FINGER_ADJ;
			string TRACE_END = GetEntityOrigin(m_hAttackTarget);
			string TRACE_IT = TraceLine(TRACE_START, TRACE_END);
			string MY_FINGER = GetEntityIndex(GetOwner());
			BEAM_TRACE_START = TRACE_START;
			BEAM_TRACE_END = TRACE_IT;
			BEAM_DEFINED = 1;
			if ((param1))
			{
			}
			ApplyEffect(param2, "effects/dot_cold", 1, GetEntityIndex(GetOwner()), Random(5, 15), "none");
			BEAM_TARGET = GetEntityIndex(param2);
			Effect("beam", "update", BEAM_ID, "end_target", BEAM_TARGET, 0);
		}
	}

	void reset_freeze_target()
	{
		NEW_FREEZE_TARGET = "unset";
	}

	void OnPostSpawn() override
	{
		ClientEvent("persist", "all", "monsters/lighted_cl", GetEntityIndex(GetOwner()), LIGHT_COLOR, LIGHT_RAD);
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// svplaysound: svplaysound 2 0 SOUND_FREEZE_BEAM
		EmitSound(2, 0, SOUND_FREEZE_BEAM);
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		ClientEvent("update", "all", MY_LIGHT_SCRIPT, "remove_me");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STUCK1, SOUND_STUCK2
		array<string> sounds = {SOUND_STUCK1, SOUND_STUCK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void staff_strike()
	{
		// svplaysound: svplaysound 2 0 SOUND_FREEZE_BEAM
		EmitSound(2, 0, SOUND_FREEZE_BEAM);
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_STAFF, ATTACK_HITCHANCE, "pierce");
		if (RandomInt(1, 5) == 1)
		{
			npcatk_flee(m_hAttackTarget, 512, 5.0);
		}
		if (GetEntityIndex(G_BEAMER) == GetEntityIndex(GetOwner()))
		{
			SetGlobalVar("G_BEAMER", "unset");
		}
	}

	void my_target_died()
	{
		// svplaysound: svplaysound 2 0 SOUND_FREEZE_BEAM
		EmitSound(2, 0, SOUND_FREEZE_BEAM);
	}

	void game_dynamically_created()
	{
		SetName(param1);
		OWNER_ID = param2;
		ICE_SUMMONED = 1;
	}

	void get_teleporters()
	{
		N_TELES = 0;
		TELE_ID1 = FindEntityByName("sorc_telepoint1");
		TELE_ID2 = FindEntityByName("sorc_telepoint2");
		TELE_ID3 = FindEntityByName("sorc_telepoint3");
		TELE_ID4 = FindEntityByName("sorc_telepoint4");
		if (((TELE_ID1 !is null)))
		{
			N_TELES += 1;
		}
		if (((TELE_ID2 !is null)))
		{
			N_TELES += 1;
		}
		if (((TELE_ID3 !is null)))
		{
			N_TELES += 1;
		}
		if (((TELE_ID4 !is null)))
		{
			N_TELES += 1;
		}
	}

	void flicker_out()
	{
		RENDER_COUNT -= 50;
		if (!(RENDER_COUNT > 0)) return;
		ScheduleDelayedEvent(0.1, "flicker_out");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RENDER_COUNT);
	}

	void tele_out()
	{
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		SetEntityOrigin(GetOwner(), Vector3(-20000, 10000, -20000));
	}

	void tele_in()
	{
		NEAR_DEST = FindEntitiesInSphere("any", 64);
		BUGGER_IN_WAY = 0;
		for (int i = 0; i < GetTokenCount(NEAR_DEST, ";"); i++)
		{
			check_near_dest();
		}
		if ((BUGGER_IN_WAY))
		{
			BUGGER_IN_WAY_COUNT += 1;
			LogDebug("tele_in GetEntityName(BUGGER_ID) / GetEntityProperty(BUGGER_ID, "scriptvar") @ TELE_DEST");
			ScheduleDelayedEvent(0.1, "tele_in");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		BUGGER_IN_WAY_COUNT = 0;
		SetEntityOrigin(GetOwner(), TELE_DEST);
		SetAngles("face");
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		RENDER_COUNT = 0;
		flicker_in();
		LAST_TELE = GetGameTime();
		SetGlobalVar("G_ICE_TELE", GetGameTime());
	}

	void check_near_dest()
	{
		string CUR_ENT = GetToken(NEAR_DEST, i, ";");
		if ((GetEntityName(CUR_ENT)).findFirst("Barrier") >= 0)
		{
			int ENT_OKAY = 1;
		}
		if ((GetEntityProperty(CUR_ENT, "scriptvar")))
		{
			int ENT_OKAY = 1;
		}
		if ((ENT_OKAY)) return;
		BUGGER_IN_WAY = 1;
		BUGGER_ID = CUR_ENT;
	}

	void flicker_in()
	{
		RENDER_COUNT += 50;
		if (RENDER_COUNT >= 255)
		{
			SetProp(GetOwner(), "rendermode", 0);
			SetProp(GetOwner(), "renderamt", 255);
		}
		if (!(RENDER_COUNT < 255)) return;
		ScheduleDelayedEvent(0.1, "flicker_in");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RENDER_COUNT);
	}

	void find_near_teleporter()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		string PLAYER_ORG = GetEntityOrigin(CUR_PLAYER);
		if (!(FOUND_NEAR_TARGET == 0)) return;
		if (!(N_TELES >= 1)) return;
		string TEST_TELE = GetEntityOrigin(TELE_ID1);
		TEST_TELE = "z";
		if (Distance(PLAYER_ORG, TEST_TELE) < SEARCH_RAD)
		{
			FOUND_NEAR_TARGET = 1;
			NEW_TARGET = CUR_PLAYER;
		}
		if (!(N_TELES >= 2)) return;
		string TEST_TELE = GetEntityOrigin(TELE_ID2);
		TEST_TELE = "z";
		if (Distance(PLAYER_ORG, TEST_TELE) < SEARCH_RAD)
		{
			FOUND_NEAR_TARGET = 2;
			NEW_TARGET = CUR_PLAYER;
		}
		if (!(N_TELES >= 3)) return;
		string TEST_TELE = GetEntityOrigin(TELE_ID3);
		TEST_TELE = "z";
		if (Distance(PLAYER_ORG, TEST_TELE) < SEARCH_RAD)
		{
			FOUND_NEAR_TARGET = 3;
			NEW_TARGET = CUR_PLAYER;
		}
		if (!(N_TELES >= 4)) return;
		string TEST_TELE = GetEntityOrigin(TELE_ID4);
		TEST_TELE = "z";
		if (Distance(PLAYER_ORG, TEST_TELE) < SEARCH_RAD)
		{
			FOUND_NEAR_TARGET = 4;
			NEW_TARGET = CUR_PLAYER;
		}
		string TEST_TELE = NPC_SPAWN_LOC;
		if (Distance(PLAYER_ORG, TEST_TELE) < SEARCH_RAD)
		{
			FOUND_NEAR_TARGET = 5;
			NEW_TARGET = CUR_PLAYER;
		}
	}

}

}
