#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SorcBase : CGameScript
{
	int AM_ESCORT;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_KNEEL;
	string ANIM_RUN;
	string ANIM_WALK;
	int CALLED_HELP;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	string CHIEF_ID;
	int DID_SPOT_SPEECH;
	float FLINCH_CHANCE;
	int FLINCH_DELAY;
	string FWD_JUMP_STR;
	int HUNT_AGRO;
	string KNEEL_MODE;
	string LAST_ENEMY;
	string NEXT_SORCJUMP;
	int NO_CLOSE_MOUTH;
	int NPC_SILENT_DEATH;
	string ORC_JUMPER;
	string PLAYER_LIST;
	string SORC_CUR_TELE_IDX;
	string SORC_FINAL_TELEDEST;
	int SORC_NO_TELE;
	string SORC_REPULSE_TARGETS;
	string SORC_SCAN_BEST_DIST;
	string SORC_SCAN_BEST_IDX;
	int SORC_SCAN_BEST_SET;
	int SORC_SCAN_IDX;
	string SORC_SCAN_SET;
	int SORC_TELE_CYCLE_ON;
	string SORC_TELE_ORG;
	string SORC_TELE_SET1;
	string SORC_TELE_SET2;
	string SORC_TELE_SET3;
	string SORC_TELE_SETS;
	string SPAWN_SPEECH;
	float SPAWN_SPEECH_DELAY;
	string SPOT_SPEECH;
	string UP_SORCJUMP_STR;

	SorcBase()
	{
		NO_CLOSE_MOUTH = 1;
		if (!(SORC_NOJUMP))
		{
			ORC_JUMPER = 1;
			if ((StringToLower(GetMapName())).findFirst("sorc_palace") >= 0)
			{
				SORC_SUPERJUMP = 1;
			}
			if ((SORC_SUPERJUMP))
			{
			}
			ORC_JUMPER = 0;
		}
		ANIM_KNEEL = "kneel";
		const string ANIM_SORCJUMP = "battleaxe_swing1_L";
		const float FREQ_SORCJUMP = 5.0;
		const int SORC_MAX_JUMP_RANGE = 600;
		const int ORC_JUMP_RANGE = 512;
		const int ORC_JUMP_CUTOFF = 400;
		const string ORC_JUMP_POWER = RandomInt(550, 650);
		const string FREQ_TELE = Random(5.0, 10.0);
		const int SORC_TELEPORTS = 1;
		const float SORC_LRESIST = 0.75;
		const float SORC_PRESIST = 1.10;
		const string SOUND_STRUCK1 = "body/armour1.wav";
		const string SOUND_STRUCK2 = "body/armour2.wav";
		const string SOUND_STRUCK3 = "body/armour3.wav";
		const string SOUND_HIT = "voices/orc/hit.wav";
		const string SOUND_HIT2 = "voices/orc/hit2.wav";
		const string SOUND_HIT3 = "voices/orc/hit3.wav";
		const string SOUND_PAIN = "monsters/orc/pain.wav";
		const string SOUND_WARCRY1 = "monsters/orc/battlecry.wav";
		const string SOUND_ATTACK1 = "voices/orc/attack.wav";
		const string SOUND_ATTACK2 = "voices/orc/attack2.wav";
		const string SOUND_ATTACK3 = "voices/orc/attack3.wav";
		NPC_SILENT_DEATH = 1;
		const string SOUND_HELP = "voices/orc/help.wav";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die_fallback";
		HUNT_AGRO = 1;
		CAN_HEAR = 1;
		CAN_FLEE = 0;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 0.3;
		ANIM_FLINCH = "flinch";
		FLINCH_DELAY = 4;
		LAST_ENEMY = "NONE";
		const string SOUND_ZOMB_STRUCK1 = "debris/flesh2.wav";
		const string SOUND_ZOMB_STRUCK2 = "agrunt/ag_pain3.wav";
		const string SOUND_ZOMB_STRUCK3 = "agrunt/ag_pain5.wav";
		const string SOUND_ZOMB_ATK1 = "zombie/claw_miss1.wav";
		const string SOUND_ZOMB_ATK2 = "zombie/claw_miss2.wav";
		const string SOUND_ZOMB_ATK3 = "zombie/claw_strike1.wav";
		const string SOUND_ZOMB_ALERT1 = "monsters/zombie1/orc_zo_alert10.wav";
		const string SOUND_ZOMB_ALERT2 = "monsters/zombie1/orc_zo_alert20.wav";
		const string SOUND_ZOMB_ALERT3 = "monsters/zombie1/orc_zo_alert30.wav";
		Precache("voices/orc/help.wav");
	}

	void OnSpawn() override
	{
		SetDamageResistance("lightning", SORC_LRESIST);
		SetDamageResistance("poison", SORC_PRESIST);
		SetDamageResistance("acid", SORC_PRESIST);
	}

	void cycle_up()
	{
		if (!(G_SORC_TELE_POINTS > 0)) return;
		if (!(SORC_TELEPORTS)) return;
		if ((SORC_NO_TELE)) return;
		if ((SORC_TELE_CYCLE_ON)) return;
		SORC_TELE_CYCLE_ON = 1;
		SORC_TELE_SETS = GetEntityProperty(GAME_MASTER, "scriptvar");
		SORC_TELE_SET1 = GetEntityProperty(GAME_MASTER, "scriptvar");
		if (SORC_TELE_SETS > 1)
		{
			SORC_TELE_SET2 = GetEntityProperty(GAME_MASTER, "scriptvar");
		}
		if (SORC_TELE_SETS > 2)
		{
			SORC_TELE_SET3 = GetEntityProperty(GAME_MASTER, "scriptvar");
		}
		FREQ_TELE("sorc_check_tele_points");
	}

	void ext_list_telepoints()
	{
		for (int i = 0; i < GetTokenCount(SORC_TELE_SET1, ";"); i++)
		{
			list_tele_points1();
		}
		if (SORC_TELE_SETS > 1)
		{
			for (int i = 0; i < GetTokenCount(SORC_TELE_SET2, ";"); i++)
			{
				list_tele_points2();
			}
		}
		if (SORC_TELE_SETS > 2)
		{
			for (int i = 0; i < GetTokenCount(SORC_TELE_SET3, ";"); i++)
			{
				list_tele_points3();
			}
		}
	}

	void list_tele_points1()
	{
		LogDebug("set1: game.script.iteration GetToken(SORC_TELE_SET1, i, ";")");
	}

	void list_tele_points2()
	{
		LogDebug("set2: game.script.iteration GetToken(SORC_TELE_SET2, i, ";")");
	}

	void list_tele_points3()
	{
		LogDebug("set3: game.script.iteration GetToken(SORC_TELE_SET3, i, ";")");
	}

	void no_teleport()
	{
		SORC_NO_TELE = 1;
	}

	void sorc_check_tele_points()
	{
		FREQ_TELE("sorc_check_tele_points");
		if ((SUSPEND_AI)) return;
		string L_LAST_ATK = AS_ATTACKING;
		L_LAST_ATK += 10.0;
		LogDebug("Last Attack game.time vs L_LAST_ATK");
		if (!(GetGameTime() > L_LAST_ATK)) return;
		if (!(GetGameTime() > G_SORC_NEXT_TELE)) return;
		if (m_hAttackTarget != "unset")
		{
			if (GetEntityRange(m_hAttackTarget) <= ATTACK_HITRANGE)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		PLAYER_LIST = "";
		GetAllPlayers(PLAYER_LIST);
		ScrambleTokens(PLAYER_LIST, ";");
		SORC_SCAN_BEST_SET = 0;
		SORC_SCAN_IDX = 1;
		SORC_SCAN_SET = SORC_TELE_SET1;
		for (int i = 0; i < GetTokenCount(SORC_SCAN_SET, ";"); i++)
		{
			sorc_scan_tele_points();
		}
		if (SORC_TELE_SETS > 1)
		{
			SORC_SCAN_IDX = 2;
			SORC_SCAN_SET = SORC_TELE_SET2;
			for (int i = 0; i < GetTokenCount(SORC_SCAN_SET, ";"); i++)
			{
				sorc_scan_tele_points();
			}
		}
		if (SORC_TELE_SETS > 2)
		{
			SORC_SCAN_IDX = 3;
			SORC_SCAN_SET = SORC_TELE_SET3;
			for (int i = 0; i < GetTokenCount(SORC_SCAN_SET, ";"); i++)
			{
				sorc_scan_tele_points();
			}
		}
		if (SORC_SCAN_BEST_SET == 1)
		{
			SORC_SCAN_BEST_SET = SORC_TELE_SET1;
		}
		if (SORC_SCAN_BEST_SET == 2)
		{
			SORC_SCAN_BEST_SET = SORC_TELE_SET2;
		}
		if (SORC_SCAN_BEST_SET == 3)
		{
			SORC_SCAN_BEST_SET = SORC_TELE_SET3;
		}
		SORC_FINAL_TELEDEST = GetToken(SORC_SCAN_BEST_SET, SORC_SCAN_BEST_IDX, ";");
		SetGlobalVar("G_SORC_NEXT_TELE", GetGameTime());
		G_SORC_NEXT_TELE += 5.0;
		npcatk_suspend_ai();
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		ScheduleDelayedEvent(0.20, "sorc_tele_out");
		ScheduleDelayedEvent(0.25, "sorc_repulse");
		ScheduleDelayedEvent(0.5, "sorc_finalize_teleport");
	}

	void sorc_tele_out()
	{
		SetEntityOrigin(GetOwner(), Vector3(20000, -20000, -20000));
	}

	void sorc_finalize_teleport()
	{
		SetEntityOrigin(GetOwner(), SORC_FINAL_TELEDEST);
		npcatk_resume_ai();
		ScheduleDelayedEvent(0.25, "sorc_reset_renderprops");
	}

	void sorc_reset_renderprops()
	{
		SetProp(GetOwner(), "rendermode", 0);
	}

	void sorc_repulse()
	{
		string REPULSE_AOE = GetMonsterProperty("moveprox");
		REPULSE_AOE *= 1.5;
		ClientEvent("new", "all", "effects/sfx_repulse_burst", SORC_FINAL_TELEDEST, REPULSE_AOE, 1.0);
		SORC_REPULSE_TARGETS = FindEntitiesInSphere("any", ATTACK_RANGE);
		if (!(SORC_REPULSE_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(SORC_REPULSE_TARGETS, ";"); i++)
		{
			sorc_repulse_targets();
		}
	}

	void sorc_repulse_targets()
	{
		string CUR_TARG = GetToken(SORC_REPULSE_TARGETS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(SORC_FINAL_TELEDEST, TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 800, 0)));
	}

	void sorc_scan_tele_points()
	{
		LogDebug("Checking: SORC_CUR_TELE_IDX of GetTokenCount(SORC_SCAN_SET, ";") in set SORC_SCAN_IDX cur_best_dist SORC_SCAN_BEST_DIST");
		SORC_CUR_TELE_IDX = i;
		SORC_TELE_ORG = GetToken(SORC_SCAN_SET, SORC_CUR_TELE_IDX, ";");
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			sorc_scan_tele_find_nearest_player();
		}
	}

	void sorc_scan_tele_find_nearest_player()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		if (!(IsEntityAlive(CUR_PLAYER))) return;
		string CUR_PLAYER_ORG = GetEntityOrigin(CUR_PLAYER);
		string DIST_FROM_POINT = Distance(SORC_TELE_ORG, CUR_PLAYER_ORG);
		if (SORC_SCAN_BEST_SET == 0)
		{
			LogDebug("First: SORC_SCAN_BEST_IDX");
			SORC_SCAN_BEST_SET = SORC_SCAN_IDX;
			SORC_SCAN_BEST_IDX = SORC_CUR_TELE_IDX;
			SORC_SCAN_BEST_DIST = DIST_FROM_POINT;
		}
		else
		{
			LogDebug("Better: SORC_SCAN_BEST_IDX SORC_SCAN_BEST_DIST vs. SORC_CUR_TELE_IDX DIST_FROM_POINT");
			if (DIST_FROM_POINT < SORC_SCAN_BEST_DIST)
			{
				SORC_SCAN_BEST_SET = SORC_SCAN_IDX;
				SORC_SCAN_BEST_IDX = SORC_CUR_TELE_IDX;
				SORC_SCAN_BEST_DIST = DIST_FROM_POINT;
			}
		}
	}

	void sorc_tele_fx()
	{
		string REPULSE_AOE = GetMonsterProperty("moveprox");
		REPULSE_AOE *= 1.5;
		string L_ORG = param1;
		L_ORG = "z";
		ClientEvent("new", "all", "effects/sfx_repulse_burst", L_ORG, REPULSE_AOE, 1.0);
	}

	void set_tele_in()
	{
		set_fade_in(1.0);
		ScheduleDelayedEvent(0.1, "set_tele_in2");
	}

	void set_tele_in2()
	{
		sorc_tele_fx(GetEntityOrigin(GetOwner()));
	}

	void OnSpawn() override
	{
		SetRoam(true);
		SetRace("orc");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		orc_spawn();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(2, 0);
		SetModelBody(4, 0);
		orc_death();
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		string LASTSEEN_ENEMY = m_hAttackTarget;
		if (!(LASTSEEN_ENEMY != LAST_ENEMY)) return;
		LAST_ENEMY = LASTSEEN_ENEMY;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if (ORC_SHIELD == 1)
		{
			if (!(BO_ZOMBIE_MODE))
			{
			}
			string block = RandomInt(0, 99);
			if (block < 30)
			{
				if (block < 5)
				{
					PlayAnim("critical", "deflectcounter");
					swing_axe();
				}
				else
				{
					string rand = RandomInt(0, 1);
					if (rand == 0)
					{
						PlayAnim("critical", "shielddeflect1");
					}
					if (rand == 1)
					{
						PlayAnim("critical", "shielddeflect2");
					}
				}
			}
			else
			{
				sound_struck();
			}
		}
		else
		{
			sound_struck();
		}
		orc_struck();
	}

	void sound_struck()
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void baseorc_yell()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(ATTACK_PUSH != "ATTACK_PUSH")) return;
		if (!(ATTACK_PUSH != "none")) return;
		AddVelocity(m_hLastStruckByMe, ATTACK_PUSH);
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnAidingAlly(CBaseEntity@ ally, CBaseEntity@ enemy)
	{
		if ((CALLED_HELP)) return;
		CALLED_HELP = 1;
		CallExternal(GetEntityIndex(param2), "ext_mon_playsound", 0, 10, "voices/orc/help.wav");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		EmitSound(GetOwner(), 0, "voices/orc/die.wav", 5);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		string GAME_TIME = GetGameTime();
		if (!(GAME_TIME > NEXT_SORCJUMP)) return;
		if (!(GetEntityRange(m_hAttackTarget) < SORC_MAX_JUMP_RANGE)) return;
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
		if ((IsValidPlayer(m_hAttackTarget)))
		{
			TARG_Z -= 38;
		}
		string Z_DIFF = TARG_Z;
		Z_DIFF -= MY_Z;
		if (Z_DIFF > ATTACK_RANGE)
		{
			sorc_hop(Z_DIFF);
			int EXIT_SUB = 1;
			NEXT_SORCJUMP = GAME_TIME;
			NEXT_SORCJUMP += FREQ_SORCJUMP;
		}
	}

	void sorc_hop()
	{
		EmitSound(GetOwner(), 0, "monsters/orc/attack1.wav", 10);
		UP_SORCJUMP_STR = param1;
		UP_SORCJUMP_STR *= 5;
		npcatk_suspend_ai(1.0);
		FWD_JUMP_STR = GetEntityRange(m_hAttackTarget);
		PlayAnim("critical", ANIM_SORCJUMP);
		ScheduleDelayedEvent(0.1, "sorc_jump_boost");
	}

	void sorc_jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_JUMP_STR, UP_SORCJUMP_STR));
	}

	void npc_targetsighted()
	{
		if ((DID_SPOT_SPEECH)) return;
		DID_SPOT_SPEECH = 1;
		if (!(SPOT_SPEECH != "SPOT_SPEECH")) return;
		SayText("SPOT_SPEECH");
	}

	void OnPostSpawn() override
	{
		if (!(SPAWN_SPEECH != "SPAWN_SPEECH")) return;
		SPAWN_SPEECH_DELAY("say_spawn_speech");
		if (!(KNEEL_MODE)) return;
		SetIdleAnim(ANIM_KNEEL);
		SetMoveAnim(ANIM_KNEEL);
		SetRoam(false);
	}

	void say_spawn_speech()
	{
		SayText("SPAWN_SPEECH");
	}

	void set_sorcpal_jailer1()
	{
		SetSayTextRange(2048);
		SPAWN_SPEECH = "What's all that racket down there?";
		SPAWN_SPEECH_DELAY = 1.0;
		SPOT_SPEECH = "Sound the alarm! Introduers!";
	}

	void set_sorcpal_jailer2()
	{
		SetSayTextRange(2048);
		SPAWN_SPEECH = "I don't know...";
		SPAWN_SPEECH_DELAY = 2.0;
		SPOT_SPEECH = "Intruders! ...and they let the beef escape!!!";
		if (G_ONE_SHOT >= 1)
		{
			SPAWN_SPEECH = "SPAWN_SPEECH";
			SPOT_SPEECH = "SPOT_SPEECH";
		}
		SetGlobalVar("G_ONE_SHOT", 1);
	}

	void set_sorcpal_kennel1()
	{
		SetSayTextRange(2048);
		SPOT_SPEECH = "Go get em Fido!";
	}

	void set_sorcpal_wrecked1()
	{
		SetSayTextRange(2048);
		SPAWN_SPEECH = "We really gotta fix this place someday.";
		SPAWN_SPEECH_DELAY = 0.1;
		SPOT_SPEECH = "Intruders!! Armed humans within the palace walls!";
	}

	void set_sorcpal_wrecked2()
	{
		SetSayTextRange(2048);
		SPAWN_SPEECH = "Just shut up and do your patrol.";
		SPAWN_SPEECH_DELAY = 2.0;
	}

	void set_sorcpal_reward1()
	{
		SetSayTextRange(2048);
		SPOT_SPEECH = "Runegahr will promote us good if we smash these guys!";
	}

	void set_sorcpal_reached1()
	{
		SetSayTextRange(2048);
		SPOT_SPEECH = "The intruders have reached the north east hall!";
	}

	void set_sorcpal_reached2()
	{
		SetSayTextRange(2048);
		if (GetPlayerCount() > 1)
		{
			SPOT_SPEECH = "How did a couple of humans get this far into the palace!?";
		}
		else
		{
			SPOT_SPEECH = "How did one armed human get THIS far into the palace!?";
		}
	}

	void set_sorcpal_reached3()
	{
		SetSayTextRange(2048);
		if (GetPlayerCount() > 1)
		{
			SPOT_SPEECH = "They've reached the east tower!";
		}
		else
		{
			SPOT_SPEECH = "He's reached the east tower!";
		}
	}

	void set_sorcpal_killthem1()
	{
		SetSayTextRange(2048);
		if (GetPlayerCount() > 1)
		{
			SPOT_SPEECH = "Kill them! Kill them NOW!";
		}
		else
		{
			SPOT_SPEECH = "Kill him! Kill him NOW!";
		}
	}

	void set_sorc_villa_first_guard()
	{
		SPOT_SPEECH = "Humans! Humans have entered the town from the palace! SOUND THE ALARM!";
	}

	void set_sorcpal_throne()
	{
		SetSayTextRange(2048);
		SORC_NO_TELE = 1;
		AM_ESCORT = 1;
		if ((G_SORC_CHIEF_PRESENT))
		{
			CHIEF_ID = FindEntityByName("the_warchief");
			if (!(GetEntityProperty(CHIEF_ID, "scriptvar")))
			{
			}
			SetInvincible(2);
			KNEEL_MODE = 1;
			SetIdleAnim(ANIM_KNEEL);
			SetMoveAnim(ANIM_KNEEL);
			npcatk_suspend_ai();
			SetRoam(false);
		}
	}

	void sorcs_confirm_order()
	{
		SayText("Yes , warchief.");
		Say("[.16] [.32] [.32] [.16]");
	}

	void ext_chief_orders_attack()
	{
		if (!(KNEEL_MODE)) return;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		npcatk_resume_ai();
		SetInvincible(false);
		KNEEL_MODE = 0;
	}

}

}
