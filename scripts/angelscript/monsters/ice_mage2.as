#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class IceMage2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_BURST;
	string ANIM_DEATH;
	string ANIM_FLY;
	string ANIM_FREEZE_RAY;
	string ANIM_IDLE;
	string ANIM_IDLE_ALERT;
	string ANIM_LOOK;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BUGGER_ID;
	int BUGGER_IN_WAY;
	int BUGGER_IN_WAY_COUNT;
	string CL_LIGHT_IDX;
	int DOING_BEAM;
	int DOING_BURST;
	float DOT_FREEZE;
	int FOUND_NEAR_TARGET;
	float FREEZE_RAY_BASEDOT;
	int FREEZE_RAY_SLOW_AMT;
	float FREQ_BURST;
	float FREQ_BURST_SHORT;
	float FREQ_DODGE;
	string LAST_BEAM;
	string LAST_TELE;
	string LIGHT_COLOR;
	int LIGHT_RAD;
	int MOVE_RANGE;
	string NEAR_DEST;
	string NEW_TARGET;
	string NEXT_BURST;
	string NEXT_CL_REFRESH;
	string NEXT_DODGE;
	string NExT_BURST;
	int NPC_GIVE_EXP;
	int NPC_RANGED;
	int N_TELES;
	int RENDER_COUNT;
	int SEARCH_RAD;
	string SOUND_BURST;
	string SOUND_BURST_CHARGE;
	string SOUND_FREEZE_RAY;
	string TELE_ANG;
	string TELE_ANGS;
	string TELE_DEST;
	string TELE_ID1;
	string TELE_ID2;
	string TELE_ID3;
	string TELE_ID4;

	IceMage2()
	{
		ANIM_IDLE = "idle";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die_simple";
		ANIM_BURST = "crouch_idle";
		MOVE_RANGE = 512;
		ATTACK_MOVERANGE = 512;
		ATTACK_RANGE = 1024;
		ATTACK_HITRANGE = 1024;
		ANIM_IDLE_ALERT = "alert_idle";
		ANIM_ATTACK = "ref_shoot_staff";
		ANIM_FREEZE_RAY = "ref_shoot_rayspell";
		ANIM_FLY = "jump";
		ANIM_LOOK = "look";
		NPC_GIVE_EXP = 1000;
		NPC_RANGED = 1;
		FREQ_DODGE = 5.0;
		LIGHT_COLOR = Vector3(200, 200, 255);
		LIGHT_RAD = 96;
		FREQ_BURST = Random(30.0, 60.0);
		FREQ_BURST_SHORT = 10.0;
		DOT_FREEZE = 100.0;
		FREEZE_RAY_BASEDOT = 25.0;
		FREEZE_RAY_SLOW_AMT = 1;
		SOUND_FREEZE_RAY = "magic/freezeray_loop.wav";
		SOUND_BURST_CHARGE = "weapons/magic/ice_powerup.wav";
		SOUND_BURST = "weapons/magic/frost_reverse.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_TELE);
		if (N_TELES > 0)
		{
		}
		float LAST_TELE_DIFF = GetGameTime();
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
			SendInfoMessageToAll("green " + ICE_MAGE: + "found " + GetEntityName(NEW_TARGET) + "near " + FOUND_NEAR_TARGET);
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
		SetName("Frost Mage");
		SetModel("monsters/ice_mage.mdl");
		SetHealth(4000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("cold", 0);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("poison", 0.5);
		SetWidth(32);
		SetHeight(96);
		SetRoam(true);
		SetHearingSensitivity(4);
		SetProp(GetOwner(), "skin", 1);
		NExT_BURST = GetGameTime();
		NEXT_BURST += FREQ_BURST;
		ScheduleDelayedEvent(1.0, "get_teleporters");
	}

	void npc_targetsighted()
	{
		if (!(DID_INTRO))
		{
			NEXT_BURST = GetGameTime();
			NEXT_BURST += FREQ_BURST;
		}
		if (GetGameTime() > NEXT_BURST)
		{
			if (GetEntityRange(m_hAttackTarget) < 200)
			{
				do_burst();
			}
			else
			{
				NEXT_BURST = GetGameTime();
				NEXT_BURST += FREQ_BURST_SHORT;
			}
		}
	}

	void do_burst()
	{
		if ((DOING_BEAM))
		{
			beam_end();
		}
		DOING_BURST = 1;
		SetRoam(false);
		npcatk_suspend_movement("crouch_aim_staff", 6.0);
		npcatk_suspend_ai(6.0);
		EmitSound(GetOwner(), 0, SOUND_BURST_CHARGE, 10);
		ScheduleDelayedEvent(3.0, "do_burst2");
		ScheduleDelayedEvent(6.0, "do_burst3");
		ClientEvent("new", "all", "effects/sfx_burst_sphere", GetEntityOrigin(GetOwner()));
	}

	void do_burst2()
	{
		EmitSound(GetOwner(), 0, SOUND_BURST, 10);
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 256, DOT_FREEZE, 1.0, GetOwner(), GetOwner(), "none", "cold_effect", "dmgevent:freeze");
	}

	void do_burst3()
	{
		SetRoam(true);
		DOING_BURST = 0;
	}

	void freeze_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_cold_freeze", 7.0, GetEntityIndex(GetOwner()), DOT_FREEZE, "none", 9999);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (m_hAttackTarget == "unset")
		{
			if ((DOING_BEAM))
			{
			}
			beam_end();
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (GetGameTime() > NEXT_CL_REFRESH)
		{
			ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), LIGHT_COLOR, LIGHT_RAD, 15.0);
			CL_LIGHT_IDX = "game.script.last_sent_id";
			NEXT_CL_REFRESH = GetGameTime();
			NEXT_CL_REFRESH += 15.0;
		}
		if ((DOING_BURST)) return;
		if ((false))
		{
			if (!(DOING_BEAM))
			{
				beam_start();
			}
			else
			{
				ApplyEffect(m_hAttackTarget, "effects/dot_cold", 10, GetEntityIndex(GetOwner()), FREEZE_RAY_BASEDOT, "none");
			}
		}
		else
		{
			if ((DOING_BEAM))
			{
			}
			beam_end();
		}
	}

	void OnDamage(int damage) override
	{
		if ((param3).findFirst("effect") >= 0)
		{
			int NO_DODGE = 1;
		}
		if (!(GetGameTime() > NEXT_DODGE)) return;
		NEXT_DODGE = GetGameTime();
		NEXT_DODGE += FREQ_DODGE;
		shadow_shift();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", CL_LIGHT_IDX);
		if ((DOING_BEAM))
		{
			beam_end();
		}
	}

	void shadow_shift()
	{
		ClientEvent("persist", "all", "effects/sfx_motionblur_temp", GetEntityIndex(GetOwner()), 0, 1, 3.0);
		float RND_ANG = Random(0, 359);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, RND_ANG, 0), Vector3(0, 1000, 0)));
		EmitSound(GetOwner(), 0, SOUND_DODGE, 10);
		ScheduleDelayedEvent(0.25, "stop_shadow_shift");
	}

	void stop_shadow_shift()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 0));
	}

	void beam_start()
	{
		DOING_BEAM = 1;
		Effect("beam", "ents", "lgtning.spr", 1, m_hAttackTarget, 1, GetOwner(), 1, Vector3(0, 128, 255), 200, 0, 60.0);
		LAST_BEAM = m_hLastCreated;
		EmitSound(GetOwner(), 1, SOUND_FREEZE_RAY, 10);
	}

	void beam_end()
	{
		if ((DOING_BEAM))
		{
			CallExternal(m_hAttackTarget, "ext_freeze_ray_remove", GetEntityIndex(GetOwner()));
		}
		DOING_BEAM = 0;
		EmitSound(GetOwner(), 1, SOUND_FREEZE_RAY, 0);
		Effect("beam", "update", LAST_BEAM, "remove");
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
