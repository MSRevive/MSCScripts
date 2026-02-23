#pragma context server

#include "test_scripts/npc_externals.as"
#include "$currentmap_npc_externals.as"
#include "dq/externals/dq_monster_externals.as"
#include "monsters/debug.as"

namespace MS
{

class Externals : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	string ATTACK_HITRANGE;
	string ATTACK_RANGE;
	string BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int CANT_TURN;
	int CAN_FLEE;
	float CONTAINER_DROP_CHANCE;
	int DEMON_BLOOD;
	int DROP_GOLD;
	float DROP_ITEM1_CHANCE;
	float DROP_ITEM2_CHANCE;
	float DROP_ITEM3_CHANCE;
	float DROP_ITEM4_CHANCE;
	string EFFECT_FREEZE_AMT;
	string EXTPLAY_SOUND;
	string EXT_DBG_LOOP_ON;
	string EXT_DEBUG_PARAM;
	float EXT_DEMON_BLOOD_RATIO;
	string EXT_FADE_ON_DEATH;
	int FLEE_DISTANCE;
	string FREEZE_WAS_SUSPEND;
	int HIT_BY_MANABALL;
	string ICE_CAGE_OLD_CANT_TURN;
	string ICE_CAGE_OLD_ROAM;
	string ICE_CAGE_OLD_STUCK_CHECK;
	int IN_ICECAGE;
	int IS_BLOODLESS;
	int I_R_FROZEN;
	int MAKE_NOISE;
	string MONSTER_WIDTH;
	string MY_OLD_NAME;
	string NEXT_CIRCLE_HEAL;
	int NO_STEP_ADJ;
	int NO_STUCK_CHECKS;
	string NPCATK_TARGET;
	string NPC_ADJ_DOWN;
	string NPC_ADJ_FLAGS;
	int NPC_ATTACK_UNTIL_SPOTTED;
	string NPC_BOSS_KNOWS;
	string NPC_BOSS_KNOWS_AMTS;
	string NPC_CMUSIC_FILE;
	int NPC_CRITICAL;
	int NPC_CUSTOM_COMBAT_MUSIC;
	string NPC_CUSTOM_SKIN;
	string NPC_DELAY_TARGET;
	int NPC_DID_DEATH;
	string NPC_DIE_NT_BASE;
	string NPC_DIE_NT_FIRST_RUN;
	string NPC_DIE_NT_NEXT_CHECK;
	int NPC_DIE_ON_SPAWN_REMOVAL;
	string NPC_DMG_MULTI;
	int NPC_DOT_COLD;
	float NPC_DOT_COLD_RATIO;
	int NPC_DOT_FIRE;
	float NPC_DOT_FIRE_RATIO;
	int NPC_DOT_LIGHTNING;
	float NPC_DOT_LIGHTNING_RATIO;
	int NPC_DOT_POISON;
	float NPC_DOT_POISON_RATIO;
	int NPC_DO_SPAWN_SOUND;
	int NPC_DUMP_XP;
	string NPC_EXP_REDUCT;
	string NPC_FADEIN_RATE;
	int NPC_FADEIN_SET;
	int NPC_FORCED_MOVEDEST;
	string NPC_FORCE_ROAM;
	int NPC_GHOST;
	string NPC_GLOW;
	string NPC_HP_MULTI;
	string NPC_INVISIBLE_SUICIDE;
	int NPC_IS_BOSS;
	int NPC_IS_TURRET;
	string NPC_LAST_SUICDE_ABORT;
	string NPC_MODEL_SCALED;
	string NPC_MOVE_SPEED_ADJ;
	int NPC_MUST_SEE_TARGET;
	int NPC_NO_AGRO;
	int NPC_NO_AUTO_ACTIVATE;
	string NPC_NO_COUNT;
	int NPC_NO_DROPS;
	int NPC_NO_PLAYER_DMG;
	int NPC_NO_ROAM;
	int NPC_NO_SIEGE_HUNT;
	string NPC_ORG_HEIGHT;
	string NPC_ORG_HITRANGE;
	string NPC_ORG_RANGE;
	string NPC_ORG_WIDTH;
	int NPC_OVERRIDE_DEATH;
	int NPC_RENDER_AMT;
	int NPC_RENDER_MODE;
	string NPC_SAY_ON_DIE;
	string NPC_SAY_ON_SPOT;
	int NPC_SELF_ADJUST;
	int NPC_SELF_ADJUST_NOAVG;
	string NPC_SET_RANGE;
	string NPC_SET_RANGE_RATIO;
	string NPC_SILENT_DEATH;
	string NPC_SILENT_SUICIDE;
	int NPC_SPRITE_IN;
	int NPC_SUMMON;
	int NPC_TELEHUNT;
	int NPC_TELEHUNTER_FX;
	string NPC_TELEHUNT_FREQ;
	int NPC_TELEHUNT_RANDOM;
	int NPC_USES_HANDLE_EVENTS;
	int NPC_WINKED_OUT;
	string NPC_WINK_IN_POINT;
	int NPC_XPTR;
	string NPC_XPTR_MAXXP;
	string NPC_XPTR_TIME;
	string PLAYING_DEAD;
	string PLR_SCAN_TOKEN;
	string PLR_SCAN_TOKEN_SORTED;
	int SKELE_TURNED;
	int SKEL_RESPAWN_TIMES;
	int STRUCK_BY_HOLY;
	int STRUCK_HOLY;

	Externals()
	{
		const float NPC_FADE_IN_SPEED = 0.1;
		EXT_DEMON_BLOOD_RATIO = 5.0;
	}

	void orc_race()
	{
		SetRace("orc");
	}

	void demon_race()
	{
		SetRace("demon");
	}

	void undead_race()
	{
		SetRace("undead");
	}

	void human_race()
	{
		SetRace("human");
	}

	void spider_race()
	{
		SetRace("spider");
	}

	void wildanimal_race()
	{
		SetRace("wildanimal");
	}

	void hated_race()
	{
		SetRace("hated");
	}

	void beloved_race()
	{
		SetRace("beloved");
	}

	void evil_race()
	{
		SetRace("evil");
	}

	void good_race()
	{
		SetRace("good");
	}

	void vermin_race()
	{
		SetRace("vermin");
	}

	void rogue_race()
	{
		SetRace("rogue");
	}

	void hguard_race()
	{
		SetRace("hguard");
	}

	void neutral_race()
	{
		SetRace("neutral");
	}

	void lightning_immune()
	{
		SetDamageResistance("lightning", 0.0);
	}

	void fire_immune()
	{
		SetDamageResistance("fire", 0.0);
	}

	void poison_immune()
	{
		SetDamageResistance("poison", 0.0);
	}

	void cold_immune()
	{
		SetDamageResistance("cold", 0.0);
	}

	void normal_immune()
	{
		SetDamageResistance("cold", 1.0);
		SetDamageResistance("fire", 1.0);
		SetDamageResistance("lightning", 1.0);
		SetDamageResistance("poison", 1.0);
	}

	void fifty_armor()
	{
		SetDamageResistance("all", 0.5);
	}

	void eighty_armor()
	{
		SetDamageResistance("all", 0.2);
	}

	void no_armor()
	{
		SetDamageResistance("all", 1.0);
	}

	void weakened_armor()
	{
		SetDamageResistance("all", 2.0);
	}

	void make_invulnerable()
	{
		MY_OLD_NAME = GetEntityName(GetOwner());
		string MY_NEW_NAME = "Invincible ";
		MY_NEW_NAME += MY_OLD_NAME;
		SetName(MY_NEW_NAME);
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 64, -1, 0);
		NPC_GLOW = Vector3(255, 255, 255);
		SetInvincible(true);
	}

	void make_vulnerable()
	{
		if (MY_OLD_NAME != "MY_OLD_NAME")
		{
			SetName(MY_OLD_NAME);
		}
		SetInvincible(false);
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 128, 1, 1);
		NPC_GLOW = "NPC_GLOW";
	}

	void add_10_health()
	{
		string CURRENT_HP = GetEntityHealth(GetOwner());
		CURRENT_HP += 10;
		SetHealth(CURRENT_HP);
	}

	void add_100_health()
	{
		string CURRENT_HP = GetEntityHealth(GetOwner());
		CURRENT_HP += 100;
		SetHealth(CURRENT_HP);
	}

	void add_500_health()
	{
		string CURRENT_HP = GetEntityHealth(GetOwner());
		CURRENT_HP += 500;
		SetHealth(CURRENT_HP);
	}

	void add_1000_health()
	{
		string CURRENT_HP = GetEntityHealth(GetOwner());
		CURRENT_HP += 1000;
		SetHealth(CURRENT_HP);
	}

	void double_health()
	{
		string MY_OLDHP_NAME = GetEntityName(GetOwner());
		string MY_NEWHP_NAME = "Strong ";
		MY_NEWHP_NAME += MY_OLDHP_NAME;
		SetName(MY_NEWHP_NAME);
		string CURRENT_HP = GetEntityHealth(GetOwner());
		CURRENT_HP *= 2.0;
		SetHealth(CURRENT_HP);
	}

	void quad_health()
	{
		string MY_OLDHP_NAME = GetEntityName(GetOwner());
		string MY_NEWHP_NAME = "Very Strong ";
		MY_NEWHP_NAME += MY_OLDHP_NAME;
		SetName(MY_NEWHP_NAME);
		string CURRENT_HP = GetEntityHealth(GetOwner());
		CURRENT_HP *= 4.0;
		SetHealth(CURRENT_HP);
	}

	void half_health()
	{
		string MY_OLDHP_NAME = GetEntityName(GetOwner());
		string MY_NEWHP_NAME = "Weakened ";
		MY_NEWHP_NAME += MY_OLDHP_NAME;
		SetName(MY_NEWHP_NAME);
		NPC_GIVE_EXP /= 2;
		SetSkillLevel(NPC_GIVE_EXP);
		string CURRENT_HP = GetEntityHealth(GetOwner());
		CURRENT_HP *= 0.5;
		SetHealth(CURRENT_HP);
	}

	void npc_fade_away()
	{
		SetAlive(0);
		DeleteEntity(GetOwner(), true); // fade out
	}

	void go_roam()
	{
		SetRoam(true);
	}

	void no_roam()
	{
		SetRoam(false);
	}

	void set_stun_prot()
	{
		SetDamageResistance("stun", param1);
	}

	void npc_suicide()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((I_R_COMPANION)) return;
		string SINCE_SPAWN = GetGameTime();
		SINCE_SPAWN -= NPC_SPAWN_TIME;
		if (SINCE_SPAWN < 2.0)
		{
			if (param1 == "dienow")
			{
				SetAnimFrameRate(0);
				SetAnimMoveSpeed(0);
				NPC_OVERRIDE_DEATH = 1;
				DeleteEntity(GetOwner(), true); // fade out
				int EXIT_SUB = 1;
			}
			else
			{
				NPC_QUED_FOR_DEATH = 1;
				ScheduleDelayedEvent(2.1, "npc_suicide");
				LogDebug("npc_suicide - not_ready_to_die - qued for death");
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (param1 == "no_pets")
		{
			if ((I_R_PET))
			{
			}
			int EXIT_SUB = 1;
		}
		if (param1 == "only_bad")
		{
			if (GetEntityRace(GetOwner()) == "human")
			{
				int EXIT_SUB = 1;
			}
			if (GetEntityRace(GetOwner()) == "hguard")
			{
				int EXIT_SUB = 1;
			}
			if (GetEntityRace(GetOwner()) == "beloved")
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if ((NPC_SILENT_SUICIDE))
		{
			NPC_SILENT_DEATH = 1;
		}
		if ((NPC_INVISIBLE_SUICIDE))
		{
			SetEntityOrigin(GetOwner(), Vector3(20000, -20000, -20000));
		}
		SetInvincible(false);
		SetRace("hated");
		SKEL_RESPAWN_TIMES = 99;
		DoDamage(GetOwner(), "direct", 99999, 100, GAME_MASTER);
	}

	void freeze_solid_start()
	{
		if (BASE_FRAMERATE == "BASE_FRAMERATE")
		{
			BASE_FRAMERATE = 1.0;
		}
		string ICE_CAGE_DURATION = param1;
		if (m_hAttackTarget == "unset")
		{
			NPCATK_TARGET = param2;
		}
		ICE_CAGE_OLD_CANT_TURN = CANT_TURN;
		ICE_CAGE_OLD_STUCK_CHECK = NO_STUCK_CHECKS;
		ICE_CAGE_OLD_ROAM = GetRoam(GetOwner());
		LogDebug("freeze_solid_start roamstate ICE_CAGE_OLD_ROAM");
		FREEZE_WAS_SUSPEND = SUSPEND_AI;
		if (!(SUSPEND_AI))
		{
			npcatk_suspend_ai(ICE_CAGE_DURATION);
		}
		I_R_FROZEN = 1;
		IN_ICECAGE = 1;
		CANT_TURN = 1;
		NO_STUCK_CHECKS = 1;
		SetRoam(false);
		SetAnimFrameRate(0.0001);
		ICE_CAGE_DURATION("freeze_solid_end");
	}

	void freeze_solid_end()
	{
		LogDebug("thaw");
		if (!(I_R_FROZEN)) return;
		if (param1 == 1)
		{
			if (!(FREEZE_WAS_SUSPEND))
			{
			}
			npcatk_resume_ai();
		}
		I_R_FROZEN = 0;
		IN_ICECAGE = 0;
		CANT_TURN = ICE_CAGE_OLD_CANT_TURN;
		NO_STUCK_CHECKS = ICE_CAGE_OLD_STUCK_CHECK;
		SetRoam(ICE_CAGE_OLD_ROAM);
		SetAnimFrameRate(BASE_FRAMERATE);
		PlayAnim("once", "break");
		if ((NEW_AI))
		{
			if (m_hAttackTarget != "unset")
			{
				SetMoveDest(m_hAttackTarget);
			}
		}
		else
		{
			if ((IsEntityAlive(HUNT_LASTTARGET)))
			{
				SetMoveDest(HUNT_LASTTARGET);
			}
		}
	}

	void double_unfreeze()
	{
		LogDebug("double_unfreeze");
		PlayAnim("critical", ANIM_ATTACK);
	}

	void tally_race()
	{
		if (GetMonsterProperty("race") == "orc")
		{
			G_ORC_TALLY += 1;
		}
		if (GetMonsterProperty("race") == "rogue")
		{
			G_ROGUE_TALLY += 1;
		}
		if (GetMonsterProperty("race") == "demon")
		{
			G_DEMON_TALLY += 1;
		}
		if (GetMonsterProperty("race") == "undead")
		{
			G_UNDEAD_TALLY += 1;
		}
		if (GetMonsterProperty("race") == "spider")
		{
			G_SPIDER_TALLY += 1;
		}
		if (GetMonsterProperty("race") == "human")
		{
			G_HUMAN_TALLY += 1;
		}
		if (GetMonsterProperty("race") == "hguard")
		{
			G_HGUARD_TALLY += 1;
		}
	}

	void tally_enemy()
	{
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		G_ENEMY_TALLY += 1;
	}

	void send_damage()
	{
		DoDamage(param1, param2, param3, param4, param5);
	}

	void demon_blood()
	{
		if ((param1).findFirst(PARAM) == 0)
		{
			if (param1 > 1)
			{
			}
			EXT_DEMON_BLOOD_RATIO = param1;
		}
		EmitSound(GetOwner(), 0, "monsters/troll/trollidle2.wav", 10);
		MAKE_NOISE = 2;
		DEMON_BLOOD = 1;
		if (NPC_ADJ_FLAGS == "NPC_ADJ_FLAGS")
		{
			NPC_ADJ_FLAGS = "";
		}
		if (NPC_ADJ_FLAGS.length() > 0) NPC_ADJ_FLAGS += ";";
		NPC_ADJ_FLAGS += "demon_blood";
		ScheduleDelayedEvent(1.0, "demon_blood_loop");
	}

	void demon_blood_loop()
	{
		if (!(DEMON_BLOOD)) return;
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 256, 1.9, 1.9);
		if (!(GetMonsterHP() > 11)) return;
		ScheduleDelayedEvent(2.0, "demon_blood_loop");
		MAKE_NOISE += 1;
		if (MAKE_NOISE > 5)
		{
			// PlayRandomSound from: "monsters/troll/trollidle2.wav", "monsters/troll/trollidle.wav"
			array<string> sounds = {"monsters/troll/trollidle2.wav", "monsters/troll/trollidle.wav"};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			MAKE_NOISE = 0;
		}
		if (!(DEMON_NOHP_LOSS))
		{
			HealEntity(GetOwner(), DEMON_BLOOD_LOSS);
		}
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 32, 10, 1, 32);
		if (MAKE_NOISE > 0)
		{
			EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
		}
		DEMON_BLOOD = 1;
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(DEMON_BLOOD)) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		return;
		// PlayRandomSound from: "monsters/troll/trollpain.wav", "monsters/troll/trollattack.wav"
		array<string> sounds = {"monsters/troll/trollpain.wav", "monsters/troll/trollattack.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void ext_hit_manaball()
	{
		if ((HIT_BY_MANABALL)) return;
		HIT_BY_MANABALL = 1;
		ScheduleDelayedEvent(1.0, "reset_hit_by_manaball");
	}

	void reset_hit_by_manaball()
	{
		HIT_BY_MANABALL = 0;
	}

	void ext_playsound_kiss()
	{
		EmitSound(GetOwner(), param1, param3, param2);
	}

	void ext_svplaysound_kiss()
	{
		LogDebug("ext_svplaysound_kiss PARAM1 PARAM2 PARAM3 PARAM4 PARAM5");
		// svplaysound: svplaysound PARAM1 PARAM2 PARAM3 PARAM4 PARAM5
		EmitSound(param1, param2, param3, param4, param5);
	}

	void ext_mon_playsound()
	{
		if (param3 != "PARAM3")
		{
			string SOURCE_ORG = param2;
			if (Distance(GetMonsterProperty("origin"), SOURCE_ORG) > param3)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		EXTPLAY_SOUND = param1;
		ScheduleDelayedEvent(0.1, "ext_playsound2");
	}

	void turn_undead()
	{
		if (!(GetMonsterProperty("isalive"))) return;
		if ((CUSTOM_TURN_UNDEAD)) return;
		if (!(/* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "holy") != 0)) return;
		string EXT_INC_HOLY_DMG = param1;
		string EXT_THE_EXCORCIST = param2;
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 512, 1, 1);
		STRUCK_BY_HOLY = 1;
		SKELE_TURNED = 1;
		STRUCK_HOLY = 1;
		XDoDamage(GetEntityIndex(GetOwner()), "direct", EXT_INC_HOLY_DMG, 100, EXT_THE_EXCORCIST, EXT_THE_EXCORCIST, "spellcasting.divination", "holy_effect");
		if (EXT_INC_HOLY_DMG > GetMonsterHP())
		{
			EXT_FADE_ON_DEATH = 1;
		}
		if (!(I_AM_TURNABLE)) return;
		TURN_STRENGTH *= 7;
		if (TURN_STRENGTH > 1000)
		{
			int TURN_STRENGTH = 1000;
		}
		if ((IS_FLEEING)) return;
		if (!(TURN_STRENGTH > MY_CURRENT_HP)) return;
		string TURN_RESISTANCE = MY_MAX_HP;
		TURN_RESISTANCE /= 25;
		string TURN_RESISTANCE = int(TURN_RESISTANCE);
		if (TURN_RESISTANCE < 2)
		{
			int TURN_RESISTANCE = 2;
		}
		string TURNCHANCE = RandomInt(1, TURN_RESISTANCE);
		if (!(TURNCHANCE == 1)) return;
		string TURN_DURATION = GetSkillLevel(THE_EXCORCIST, "spellcasting.divination");
		if (TURN_DURATION < 5)
		{
			int TURN_DURATION = 5;
		}
		if (TURN_DURATION > 15)
		{
			int TURN_DURATION = 15;
		}
		FLEE_DISTANCE = 2048;
		SetVolume(10);
		// PlayRandomSound from: SOUND_TURNED1, SOUND_TURNED2, SOUND_TURNED3, SOUND_TURNED4
		array<string> sounds = {SOUND_TURNED1, SOUND_TURNED2, SOUND_TURNED3, SOUND_TURNED4};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		CAN_FLEE = 1;
		npcatk_flee(THE_EXCORCIST, FLEE_DISTANCE, TURN_DURATION);
	}

	void ext_speak()
	{
		SetSayTextRange(2048);
		SayText("PARAM1");
	}

	void give_hp()
	{
		HealEntity(GetOwner(), param1);
	}

	void ext_invalidate()
	{
		PLAYING_DEAD = param1;
	}

	void ext_dodamage()
	{
		DoDamage(param1, param2, param3, param4, param5);
	}

	void ext_set_freeze_amt()
	{
		EFFECT_FREEZE_AMT = param1;
	}

	void ext_flash_bang()
	{
		if (!(Distance(GetMonsterProperty("origin"), param1) < param2)) return;
		npcatk_flee(GetEntityIndex(param3), 1024, 5.0);
	}

	void speed_x2()
	{
		SetMoveSpeed(1.5);
		SetAnimMoveSpeed(1.5);
		SetAnimFrameRate(1.5);
		BASE_MOVESPEED = 1.5;
		BASE_FRAMERATE = 1.5;
		if (NPC_ADJ_FLAGS == "NPC_ADJ_FLAGS")
		{
			NPC_ADJ_FLAGS = "";
		}
		if (NPC_ADJ_FLAGS.length() > 0) NPC_ADJ_FLAGS += ";";
		NPC_ADJ_FLAGS += "speed_x2";
	}

	void speed_x2_5()
	{
		SetMoveSpeed(1.75);
		SetAnimMoveSpeed(1.75);
		SetAnimFrameRate(1.75);
		BASE_MOVESPEED = 1.75;
		BASE_FRAMERATE = 1.75;
		if (NPC_ADJ_FLAGS == "NPC_ADJ_FLAGS")
		{
			NPC_ADJ_FLAGS = "";
		}
		if (NPC_ADJ_FLAGS.length() > 0) NPC_ADJ_FLAGS += ";";
		NPC_ADJ_FLAGS += "speed_x2";
	}

	void speed_x3()
	{
		SetMoveSpeed(2.0);
		SetAnimMoveSpeed(2.0);
		SetAnimFrameRate(2.0);
		BASE_MOVESPEED = 2.0;
		BASE_FRAMERATE = 2.0;
		if (NPC_ADJ_FLAGS == "NPC_ADJ_FLAGS")
		{
			NPC_ADJ_FLAGS = "";
		}
		if (NPC_ADJ_FLAGS.length() > 0) NPC_ADJ_FLAGS += ";";
		NPC_ADJ_FLAGS += "speed_x3";
	}

	void speed_x4()
	{
		SetMoveSpeed(3.0);
		SetAnimMoveSpeed(3.0);
		SetAnimFrameRate(3.0);
		BASE_MOVESPEED = 3.0;
		BASE_FRAMERATE = 3.0;
		if (NPC_ADJ_FLAGS == "NPC_ADJ_FLAGS")
		{
			NPC_ADJ_FLAGS = "";
		}
		if (NPC_ADJ_FLAGS.length() > 0) NPC_ADJ_FLAGS += ";";
		NPC_ADJ_FLAGS += "speed_x4";
	}

	void critical_npc()
	{
		SetInvincible(false);
		NPC_CRITICAL = 1;
		if (G_CRITICAL_NPCS.length() > 0) G_CRITICAL_NPCS += ";";
		G_CRITICAL_NPCS += GetEntityIndex(GetOwner());
		SetGlobalVar("G_SIEGE_MAP", 1);
		string FIRST_TOKEN = GetToken(G_CRITICAL_NPCS, 0, ";");
		if (!(IsEntityAlive(FIRST_TOKEN)))
		{
			RemoveToken(G_CRITICAL_NPCS, 0, ";");
		}
	}

	void ext_monsterspawn_removed()
	{
		if (!(GetSpawner(GetOwner()) == param1)) return;
		string L_MAP_NAME = StringToLower(GetMapName());
		if ((L_MAP_NAME).findFirst("helena") >= 0)
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "aleyesu")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "b_castle")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "bloodrose")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "calruin2")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "cleicert")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "demontemple")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "foutpost")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "gatecity")
		{
			npc_suicide("dienow");
		}
		if ((L_MAP_NAME).findFirst("gertenheld") >= 0)
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "keledrosruins")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "kfortress")
		{
			npc_suicide("dienow");
		}
		if ((L_MAP_NAME).findFirst("lodagond") >= 0)
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "ms_wicardoven")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "mscave")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "shad_palace")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "sorc_villa")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "the_keep")
		{
			npc_suicide("dienow");
		}
		if ((L_MAP_NAME).findFirst("islesofdread") >= 0)
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "the_wall")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "umulak")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "ww1")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "ww2b")
		{
			npc_suicide("dienow");
		}
		if (L_MAP_NAME == "ww3d")
		{
			npc_suicide("dienow");
		}
		if ((NPC_DIE_ON_SPAWN_REMOVAL))
		{
			npc_suicide("dienow");
		}
	}

	void glow_red()
	{
		NPC_GLOW = Vector3(255, 0, 0);
	}

	void glow_green()
	{
		NPC_GLOW = Vector3(0, 255, 0);
	}

	void glow_blue()
	{
		NPC_GLOW = Vector3(0, 0, 255);
	}

	void glow_yellow()
	{
		NPC_GLOW = Vector3(255, 255, 0);
	}

	void glow_purple()
	{
		NPC_GLOW = Vector3(255, 0, 255);
	}

	void glow_custom()
	{
		NPC_GLOW = param1;
	}

	void glow_remove()
	{
		NPC_GLOW = "NPC_GLOW";
	}

	void remove_ghost()
	{
		NPC_GHOST = 0;
	}

	void make_ghost()
	{
		NPC_GHOST = 1;
	}

	void OnPostSpawn() override
	{
		if ((NPC_GHOST))
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 255);
			ScheduleDelayedEvent(10.1, "npcatk_reset_ghost");
		}
		if (NPC_GLOW != "NPC_GLOW")
		{
			LogDebug("npc_post_spawn [externals] initiated glow NPC_GLOW");
			Effect("glow", GetOwner(), NPC_GLOW, 64, 20, 0);
			ScheduleDelayedEvent(10.1, "npcatk_reset_glow");
		}
	}

	void npcatk_reset_glow()
	{
		if (!(NPC_GLOW != "NPC_GLOW")) return;
		Effect("glow", GetOwner(), NPC_GLOW, 64, 20, 0);
		ScheduleDelayedEvent(10.1, "npcatk_reset_glow");
	}

	void npcatk_reset_ghost()
	{
		if (!(NPC_GHOST)) return;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		ScheduleDelayedEvent(10.1, "npcatk_reset_ghost");
	}

	void set_race()
	{
		SetRace(param1);
	}

	void set_model()
	{
		SetModel(param1);
		SetSolid("box");
	}

	void ext_report_armor()
	{
		LogMessage("PARAM2 GetEntityName(GetOwner()) Armor: MSC_ARMOR_ALL PARAM1 : /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), param1)");
	}

	void ext_set_parry()
	{
		SetStat("parry", param1);
	}

	void ext_blind()
	{
		SetBlind(true);
	}

	void ext_unblind()
	{
		SetBlind(false);
	}

	void game_drain_death()
	{
		DoDamage(GetOwner(), "direct", param1, 100, 1.0);
	}

	void ext_wink_out()
	{
		SetEntityOrigin(GetOwner(), Vector3(20000, 10000, -20000));
		NPC_WINK_IN_POINT = param1;
		NPC_WINKED_OUT = 1;
		PARAM2("ext_wink_in");
	}

	void ext_wink_in()
	{
		SetEntityOrigin(GetOwner(), NPC_WINK_IN_POINT);
		NPC_WINKED_OUT = 0;
	}

	void make_boss()
	{
		LogDebug("make_boss");
		NPC_IS_BOSS = 1;
		NPC_BOSS_KNOWS = "";
		NPC_BOSS_KNOWS_AMTS = "";
	}

	void ext_makepet()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		NPC_SILENT_DEATH = 1;
		ScheduleDelayedEvent(0.01, "npc_suicide");
		SpawnNPC(NPC_PET_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(param1), 1
	}

	void ext_set_health()
	{
		SetHealth(param1);
	}

	void ignore_critical_npc()
	{
		NPC_NO_SIEGE_HUNT = 1;
	}

	void ext_hit_chance()
	{
		SetHitMultiplier(GetOwner());
	}

	void ext_set_frozen()
	{
		I_R_FROZEN = 1;
		SetScriptFlags(GetOwner(), "add", "ext_set_frozen", "nopush", 1, param1, "none");
		PARAM1("ext_set_unfrozen");
	}

	void ext_set_unfrozen()
	{
		I_R_FROZEN = 0;
	}

	void ext_unsummon()
	{
		if (!(AM_SUMMONED)) return;
		SetAlive(0);
		DeleteEntity(GetOwner(), true); // fade out
	}

	void ext_sphere_token_x()
	{
		PLR_SCAN_TOKEN = FindEntitiesInSphere(param1, param2);
	}

	void ext_sphere_token()
	{
		PLR_SCAN_TOKEN = FindEntitiesInSphere(param1, param2);
	}

	void ext_box_token()
	{
		PLR_SCAN_TOKEN = /* TODO: $get_tbox */ $get_tbox(param1, param2, param3);
	}

	void ext_reduct_xp()
	{
		if (!(param1 < 1)) return;
		if (NPC_EXP_REDUCT == "NPC_EXP_REDUCT")
		{
			NPC_EXP_REDUCT = param1;
		}
		else
		{
			NPC_EXP_REDUCT -= param1;
		}
	}

	void ext_no_drops()
	{
		NPC_NO_DROPS = 1;
		ScheduleDelayedEvent(1.5, "ext_no_drops2");
	}

	void ext_no_drops2()
	{
		SetGold(0);
		DROP_GOLD = 0;
		DROP_ITEM1_CHANCE = 0.0;
		DROP_ITEM2_CHANCE = 0.0;
		DROP_ITEM3_CHANCE = 0.0;
		DROP_ITEM4_CHANCE = 0.0;
		CONTAINER_DROP_CHANCE = 0.0;
	}

	void ext_ent_list_sort()
	{
		string SCAN_TYPE = param1;
		string SCAN_RANGE = param2;
		string SCAN_ORIGIN = param3;
		string SORT_TYPE = param4;
		ext_sphere_token(SCAN_TYPE, SCAN_RANGE, SCAN_ORIGIN);
		PLR_SCAN_TOKEN_SORTED = /* TODO: $sort_entlist */ $sort_entlist(PLR_SCAN_TOKEN, SORT_TYPE);
	}

	void ext_no_player_damage()
	{
		NPC_NO_PLAYER_DMG = 1;
	}

	void ext_setrender()
	{
		LogDebug("got ext_setrender PARAM1");
		// TODO: UNCONVERTED: setrender PARAM1
	}

	void set_scale_nr()
	{
		string L_PASS = param1;
		ext_scale(L_PASS, 0, 1);
	}

	void set_scale_nb()
	{
		string L_PASS = param1;
		ext_scale(L_PASS, 1, 0);
	}

	void set_scale_nbr()
	{
		string L_PASS = param1;
		ext_scale(L_PASS, 1, 1);
	}

	void ext_scale()
	{
		LogDebug("ext_scale PARAM1 PARAM2 PARAM3");
		if (!(param1 > 0)) return;
		string MY_WIDTH = GetEntityWidth(GetOwner());
		string MY_HEIGHT = GetEntityHeight(GetOwner());
		if (NPC_ORG_WIDTH == "NPC_ORG_WIDTH")
		{
			NPC_ORG_WIDTH = MY_WIDTH;
			NPC_ORG_HEIGHT = MY_HEIGHT;
		}
		else
		{
			string MY_WIDTH = NPC_ORG_WIDTH;
			string MY_HEIGHT = NPC_ORG_HEIGHT;
		}
		SetProp(GetOwner(), "scale", param1);
		MY_WIDTH *= param1;
		MY_HEIGHT *= param1;
		if (MY_WIDTH < 16)
		{
			int MY_WIDTH = 16;
		}
		if (MY_HEIGHT < 16)
		{
			int MY_HEIGHT = 16;
		}
		SetWidth(MY_WIDTH);
		SetHeight(MY_WIDTH);
		MONSTER_WIDTH = MY_WIDTH;
		NPC_MODEL_SCALED = param1;
		NPC_USES_HANDLE_EVENTS = 1;
		string L_HALF_W = MY_WIDTH;
		L_HALF_W *= 0.5;
		if (param2 != 1)
		{
			SetBBox(Vector3(/* TODO: $neg */ $neg(L_HALF_W), /* TODO: $neg */ $neg(L_HALF_W), 0), Vector3(L_HALF_W, L_HALF_W, MY_HEIGHT));
		}
		if (param1 > 1)
		{
			if (BASE_MOVESPEED == "BASE_MOVESPEED")
			{
				BASE_MOVESPEED = param1;
				NPC_ORG_BASE_MOVESPEED = BASE_MOVESPEED;
			}
			else
			{
				if (NPC_ORG_BASE_MOVESPEED == "NPC_ORG_BASE_MOVESPEED")
				{
					BASE_MOVESPEED = NPC_ORG_BASE_MOVESPEED;
				}
				else
				{
					NPC_ORG_BASE_MOVESPEED = BASE_MOVESPEED;
				}
				BASE_MOVESPEED += param1;
			}
			SetAnimMoveSpeed(BASE_MOVESPEED);
			SetMoveSpeed(BASE_MOVESPEED);
		}
		NPC_MODEL_SCALED = param1;
		if (!(param3 != 1)) return;
		if (!(NPC_RANGED))
		{
			LogDebug("ext_scale adjusting ranges");
			ScheduleDelayedEvent(1.9, "ext_adjust_scale_range");
		}
		else
		{
			LogDebug("ext_scale not changing reach , mob is ranged");
		}
	}

	void set_scale()
	{
		string L_PASS = param1;
		ext_scale(L_PASS);
	}

	void ext_adjust_scale_range()
	{
		LogDebug("ext_adjust_scale_range entered");
		string L_CUR_WIDTH = GetEntityWidth(GetOwner());
		string L_CUR_HEIGHT = GetEntityHeight(GetOwner());
		if (NPC_ORG_RANGE == "NPC_ORG_RANGE")
		{
			NPC_ORG_RANGE = ATTACK_RANGE;
		}
		if (NPC_ORG_HITRANGE == "NPC_ORG_HITRANGE")
		{
			NPC_ORG_HITRANGE = ATTACK_HITRANGE;
		}
		ATTACK_RANGE = NPC_ORG_RANGE;
		ATTACK_HITRANGE = NPC_ORG_HITRANGE;
		if (ATTACK_RANGE >= 512)
		{
			LogDebug("ext_adjust_scale_range base range > 512 - npc ranged without flag?");
		}
		if (!(ATTACK_RANGE < 512)) return;
		string L_MIN_RANGE = L_CUR_WIDTH;
		if (L_CUR_WIDTH < L_CUR_HEIGHT)
		{
			string L_MIN_RANGE = L_CUR_HEIGHT;
		}
		if (NPC_MODEL_SCALED > 1)
		{
			L_MIN_RANGE *= 0.85;
		}
		if (L_MIN_RANGE < 38)
		{
			int L_MIN_RANGE = 38;
		}
		ATTACK_RANGE = L_MIN_RANGE;
		ATTACK_RANGE *= 1.5;
		ATTACK_HITRANGE = L_MIN_RANGE;
		ATTACK_HITRANGE *= 2.0;
		NPC_SET_RANGE = ATTACK_RANGE;
		NPC_SET_RANGE_RATIO = ATTACK_RANGE;
		NPC_SET_RANGE_RATIO /= NPC_ORG_ATTACK_RANGE;
		LogDebug("ext_adjust_scale_range ATTACK_RANGE ATTACK_HITRANGE");
	}

	void set_attack_until_spotted()
	{
		NPC_ATTACK_UNTIL_SPOTTED = 1;
	}

	void OnPostSpawn() override
	{
		if (!(NPC_ATTACK_UNTIL_SPOTTED)) return;
		npcatk_attack_till_spotted();
	}

	void npcatk_attack_till_spotted()
	{
		if (!(m_hAttackTarget == "unset")) return;
		ScheduleDelayedEvent(0.25, "npcatk_attack_till_spotted");
		PlayAnim("once", ANIM_ATTACK);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		string FACE_SPOT = NPC_HOME_LOC;
		string FACE_DIR = /* TODO: $vec.yaw */ $vec.yaw(NPC_HOME_ANG);
		FACE_SPOT += /* TODO: $relpos */ $relpos(Vector3(0, FACE_DIR, 0), Vector3(0, 256, 0));
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(FACE_SPOT);
	}

	void set_fade_in()
	{
		if ((NPC_FADEIN_SET)) return;
		NPC_FADEIN_SET = 1;
		NPC_RENDER_AMT = 0;
		NPC_RENDER_MODE = 2;
		SetProp(GetOwner(), "renderamt", NPC_RENDER_AMT);
		SetProp(GetOwner(), "rendermode", NPC_RENDER_MODE);
		string L_FADE_DELAY = param1;
		if (L_FADE_DELAY == 0)
		{
			float L_FADE_DELAY = 0.1;
		}
		NPC_FADEIN_RATE = param1;
		if (NPC_FADEIN_RATE < 10)
		{
			NPC_FADEIN_RATE = 10;
		}
		L_FADE_DELAY("set_fade_in_loop");
	}

	void set_fade_in_loop()
	{
		NPC_RENDER_AMT += 10;
		if (NPC_RENDER_AMT < 255)
		{
			SetProp(GetOwner(), "renderamt", NPC_RENDER_AMT);
			NPC_FADE_IN_SPEED("set_fade_in_loop");
		}
		else
		{
			SetProp(GetOwner(), "renderamt", 255);
			SetProp(GetOwner(), "rendermode", 0);
			NPC_RENDER_AMT = 255;
			NPC_RENDER_MODE = 0;
			npc_fadein_done();
		}
	}

	void set_no_step_adj()
	{
		NO_STEP_ADJ = 1;
	}

	void set_npc_turret()
	{
		SetMoveSpeed(0.0);
		BASE_MOVESPEED = 0.0;
		SetMoveAnim(ANIM_IDLE);
		SetRoam(false);
		NO_STUCK_CHECKS = 1;
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		NPC_IS_TURRET = 1;
		ScheduleDelayedEvent(0.1, "set_npc_turret2");
	}

	void set_npc_turret2()
	{
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		SetMoveAnim(ANIM_IDLE);
	}

	void set_summon_circle()
	{
		set_fade_in(1.0);
		if (!(NPC_HANDLES_SUMMON_CIRCLES))
		{
			SetAnimFrameRate(0);
		}
		ScheduleDelayedEvent(0.1, "set_summon_circle2");
	}

	void set_summon_circle2()
	{
		if (!(NPC_HANDLES_SUMMON_CIRCLES))
		{
			npcatk_suspend_ai();
			SetAnimFrameRate(0);
		}
		string CIRCLE_ORG = GetEntityOrigin(GetOwner());
		CIRCLE_ORG = "z";
		if (GetEntityHeight(GetOwner()) < 90)
		{
			ClientEvent("new", "all", "effects/sfx_summon_circle", CIRCLE_ORG, 3);
		}
		else
		{
			ClientEvent("new", "all", "effects/sfx_summon_circle", CIRCLE_ORG, 5);
		}
		ScheduleDelayedEvent(1.0, "set_summon_circle3");
	}

	void set_summon_circle3()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		if ((NPC_HANDLES_SUMMON_CIRCLES)) return;
		npcatk_resume_ai();
		if (BASE_FRAMERATE == "BASE_FRAMERATE")
		{
			SetAnimFrameRate(1.0);
		}
		else
		{
			SetAnimFrameRate(BASE_FRAMERATE);
		}
	}

	void set_takedmg_holy()
	{
		SetDamageResistance("holy", param1);
	}

	void set_stepsize()
	{
		SetStepSize(param1);
	}

	void ext_playanim()
	{
		LogDebug("ext_playanim PARAM1");
		PlayAnim("critical", param1);
	}

	void bs_global_command()
	{
		if (!(param3 == "death")) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		LogDebug("bs_global_command clearplayerhits GetEntityName(param1)");
		if ((NPC_IS_BOSS)) return;
		// TODO: clearplayerhits ent_me PARAM1
	}

	void ext_dbg()
	{
		if (param1 != "off")
		{
			EXT_DEBUG_PARAM = param1;
			EXT_DBG_LOOP_ON = 1;
			ext_dbg_loop();
		}
		else
		{
			EXT_DBG_LOOP_ON = 0;
		}
	}

	void ext_dbg_loop()
	{
		if (!(EXT_DBG_LOOP_ON)) return;
		ScheduleDelayedEvent(0.1, "ext_dbg_loop");
		LogDebug("GetEntityProperty(GetOwner(), "ext_debug_param")");
	}

	void set_blind_attack()
	{
		NPC_MUST_SEE_TARGET = 0;
	}

	void ext_spawn_sound()
	{
		NPC_USES_HANDLE_EVENTS = 1;
		NPC_DO_SPAWN_SOUND = 1;
	}

	void setfx_spawn_sound()
	{
		ext_spawn_sound();
	}

	void setfx_summon_circle()
	{
		set_summon_circle();
	}

	void setfx_fade_in()
	{
		set_fade_in();
	}

	void setfx_tele_in()
	{
		set_fade_in(20);
		ScheduleDelayedEvent(0.01, "setfx_tele_in2");
	}

	void setfx_tele_in2()
	{
		string MY_POS_GROUND = GetEntityOrigin(GetOwner());
		MY_POS_GROUND = "z";
		ClientEvent("new", "all", "effects/sfx_repulse_burst", MY_POS_GROUND, 128, 1.0);
	}

	void set_no_player_damage()
	{
		NPC_NO_PLAYER_DMG = 1;
	}

	void ext_setmodelbody()
	{
		SetModelBody(param1, param2);
	}

	void set_die_on_spawn_removed()
	{
		NPC_DIE_ON_SPAWN_REMOVAL = 1;
	}

	void set_dosr()
	{
		NPC_DIE_ON_SPAWN_REMOVAL = 1;
	}

	void set_no_roam()
	{
		NPC_NO_ROAM = 1;
		SetRoam(false);
	}

	void set_roam()
	{
		if ((param1).findFirst(PARAM) == 0)
		{
			NPC_FORCE_ROAM = 1;
			SetRoam(true);
		}
		else
		{
			if (param1 == 1)
			{
				NPC_FORCE_ROAM = 1;
				SetRoam(true);
			}
			else
			{
				if (param1 == 0)
				{
					NPC_NO_ROAM = 1;
					SetRoam(false);
				}
			}
		}
	}

	void trig_damage()
	{
		string TRIG_DMG = param2;
		string TRIG_DMG_TYPE = param3;
		TRIG_DMG_TYPE += "_effect";
		XDoDamage(GetOwner(), "direct", TRIG_DMG, 1.0, GAME_MASTER, GAME_MASTER, "none", TRIG_DMG_TYPE);
	}

	void set_self_adj()
	{
		LogDebug("set_self_adj PARAM1");
		if ((NPC_SELF_ADJUST)) return;
		NPC_SELF_ADJUST = 1;
		if ((param1).findFirst("PARAM") == 0)
		{
			int NO_ADJ = 1;
		}
		if ((NO_ADJ)) return;
		if (!(param1 > 0)) return;
		NPC_ADJ_DOWN = param1;
	}

	void set_no_avg()
	{
		NPC_SELF_ADJUST_NOAVG = 1;
	}

	void set_poisonous()
	{
		string L_PASS = param1;
		add_dot_poison(L_PASS);
	}

	void add_dot_poison()
	{
		NPC_DOT_POISON = 1;
		NPC_DOT_POISON_RATIO = 1.0;
		if (param1 > 0)
		{
			NPC_DOT_POISON_RATIO = param1;
		}
		NPC_GLOW = Vector3(0, 255, 0);
	}

	void add_dot_cold()
	{
		NPC_DOT_COLD = 1;
		NPC_DOT_COLD_RATIO = 1.0;
		if (param1 > 0)
		{
			NPC_DOT_COLD_RATIO = param1;
		}
		NPC_GLOW = Vector3(0, 128, 255);
	}

	void add_dot_fire()
	{
		NPC_DOT_FIRE = 1;
		NPC_DOT_FIRE_RATIO = 1.0;
		if (param1 > 0)
		{
			NPC_DOT_FIRE_RATIO = param1;
		}
		NPC_GLOW = Vector3(255, 64, 0);
	}

	void add_dot_lightning()
	{
		NPC_DOT_LIGHTNING = 1;
		NPC_DOT_LIGHTNING_RATIO = 1.0;
		if (param1 > 0)
		{
			NPC_DOT_LIGHTNING_RATIO = param1;
		}
		NPC_GLOW = Vector3(255, 255, 0);
	}

	void set_no_auto_activate()
	{
		NPC_NO_AUTO_ACTIVATE = 1;
	}

	void set_non_agro()
	{
		NPC_NO_AGRO = 1;
		npcatk_suspend_ai();
	}

	void setfx_sprite_in()
	{
		NPC_USES_HANDLE_EVENTS = 1;
		NPC_SPRITE_IN = 1;
		set_fade_in();
	}

	void setfx_sprite_inx()
	{
		NPC_USES_HANDLE_EVENTS = 1;
		NPC_SPRITE_IN = 2;
		set_fade_in();
	}

	void set_summon()
	{
		NPC_SUMMON = 1;
		G_NPC_SUMMON_COUNT += 1;
		LogDebug("set_summon G_NPC_SUMMON_COUNT");
	}

	void ext_summon_fade()
	{
		if (!(NPC_SUMMON)) return;
		G_NPC_SUMMON_COUNT -= 1;
		LogDebug("ext_summon_fade G_NPC_SUMMON_COUNT");
		SetAnimFrameRate(0);
		SetAnimMoveSpeed(0);
		SetGravity(0);
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		NPC_DID_DEATH = 1;
		NPC_OVERRIDE_DEATH = 1;
		SKEL_RESPAWN_TIMES = 99;
		DoDamage(GetOwner(), "direct", 99999, 100, GAME_MASTER);
		DeleteEntity(GetOwner(), true); // fade out
	}

	void set_fadein_delayed()
	{
		set_fade_in(1.0);
	}

	void setfx_beam_in()
	{
		set_fade_in();
		string BEAM_START = GetEntityOrigin(GetOwner());
		BEAM_START = "z";
		string BEAM_END = BEAM_START;
		BEAM_END += "z";
		Effect("beam", "point", "lgtning.spr", 90, BEAM_START, BEAM_END, Vector3(64, 128, 255), 200, 20, 2.0);
		EmitSound(GetOwner(), 0, "weather/Storm_exclamation.wav", 10);
	}

	void set_xp_tr()
	{
		NPC_XPTR = 1;
		NPC_XPTR_TIME = param1;
		NPC_XPTR_TIME *= 60.0;
		if (NPC_XPTR_TIME > GetGameTime())
		{
			LogDebug("set_xp_tr NPC_XPTR_TIME");
			ScheduleDelayedEvent(2.0, "set_xp_timeramp_start");
		}
		else
		{
			LogDebug("set_xp_tr [time elapsed]");
		}
	}

	void set_xp_timeramp_start()
	{
		NPC_XPTR_MAXXP = NPC_GIVE_EXP;
		set_xp_timeramp_loop();
		LogDebug("set_xp_timeramp_start TIME_RATIO [ NPC_XPTR_TIME ]");
	}

	void set_xp_timeramp_loop()
	{
		if (!(NPC_XPTR)) return;
		ScheduleDelayedEvent(60.0, "set_xp_timeramp_loop");
		string L_TIME_RATIO = GetGameTime();
		L_TIME_RATIO /= NPC_XPTR_TIME;
		if (L_TIME_RATIO > 1)
		{
			NPC_XPTR = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string NEW_XP = /* TODO: $ratio */ $ratio(L_TIME_RATIO, 0, NPC_XPTR_MAXXP);
		SetSkillLevel(NEW_XP);
		LogDebug("set_xp_timeramp_loop L_TIME_RATIO = NEW_XP / NPC_XPTR_MAXXP [ NPC_XPTR_TIME ]");
	}

	void game_scriptflag_update()
	{
		if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "nopush", "type_exists")))
		{
			SetNoPush(true);
		}
		else
		{
			SetNoPush(false);
		}
		if (param1 == "add")
		{
			int L_CHECK_EXPIRE = 1;
		}
		if (param1 == "edit")
		{
			int L_CHECK_EXPIRE = 1;
		}
		if (!(L_CHECK_EXPIRE)) return;
		string L_CHECK_EXPTIME = param5;
		if (L_CHECK_EXPTIME > -1)
		{
			L_CHECK_EXPTIME += 0.1;
			L_CHECK_EXPTIME("check_flags_expired");
		}
	}

	void check_flags_expired()
	{
		SetScriptFlags(GetOwner(), "remove_expired");
		CallExternal(GetOwner(), "ext_scriptflag_expired");
	}

	void OnPostSpawn() override
	{
		if (!(GetEntityProperty(GetOwner(), "nopush"))) return;
		SetScriptFlags(GetOwner(), "add", "npspawn", "nopush");
	}

	void set_cbm_file()
	{
		if ((NPC_CUSTOM_COMBAT_MUSIC)) return;
		NPC_CUSTOM_COMBAT_MUSIC = 1;
		NPC_CMUSIC_FILE = param1;
	}

	void set_cbm()
	{
		string L_PASS = param1;
		set_cbm_file(L_PASS);
	}

	void ext_conflict()
	{
	}

	void ext_showflags()
	{
		string L_TEST = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "listall");
	}

	void set_mclip()
	{
		SetMonsterClip(param1);
	}

	void ext_teleportfx1()
	{
		ScheduleDelayedEvent(0.1, "ext_teleportfx1_delay");
	}

	void ext_teleportfx2()
	{
		EmitSound(GetOwner(), 0, "debris/beamstart8.wav", 10);
	}

	void ext_teleportfx1_delay()
	{
		string MY_FEET = GetEntityOrigin(GetOwner());
		MY_FEET = "z";
		ClientEvent("update", "all", "const.localplayer.scriptID", "cl_tele1_fx", MY_FEET);
	}

	void ext_beam_follow_test()
	{
		LogDebug("beam_follow_test");
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 0, 5, 30.0, 255, Vector3(255, 0, 0));
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 1, 5, 30.0, 255, Vector3(255, 0, 255));
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 2, 5, 30.0, 255, Vector3(255, 255, 0));
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 3, 5, 30.0, 255, Vector3(255, 255, 255));
	}

	void set_cadj()
	{
		if (!(param1 > 0)) return;
		LogDebug("set_cadj PARAM1");
		string L_ADJ_RATIO = param1;
		if (!(L_ADJ_RATIO < 1)) return;
		NPC_DMG_MULTI = L_ADJ_RATIO;
		NPC_HP_MULTI = L_ADJ_RATIO;
		SetDamageMultiplier(NPC_DMG_MULTI);
		L_ADJ_RATIO *= 0.5;
		NPC_EXP_REDUCT = L_ADJ_RATIO;
	}

	void ext_dmgmulti()
	{
		SetDamageMultiplier(param1);
	}

	void set_die_nt()
	{
		LogDebug("set_die_nt PARAM1");
		if (!(NPC_DIE_NT_FIRST_RUN))
		{
			if (param1 <= 0)
			{
				return;
			}
			NPC_DIE_NT_FIRST_RUN = 1;
			NPC_DIE_NT_NEXT_CHECK = param1;
			NPC_DIE_NT_BASE = param1;
			NPC_LAST_SUICDE_ABORT = GetGameTime();
			NPC_DIE_NT_NEXT_CHECK("set_die_nt");
			return;
		}
		if ((IsEntityAlive(m_hAttackTarget)))
		{
			if (GetEntityRange(m_hAttackTarget) < 256)
			{
				int L_NO_SUICIDE = 1;
			}
		}
		string L_GAME_TIME = GetGameTime();
		string L_LAST = /* TODO: $math(add) */ NPC_LASTSEEN_ENEMY_TIME;
		if (L_GAME_TIME < L_LAST)
		{
			int L_NO_SUICIDE = 1;
		}
		string L_LAST = /* TODO: $math(add) */ NPC_LAST_DAMAGED_TIME;
		if (L_GAME_TIME < L_LAST)
		{
			int L_NO_SUICIDE = 1;
		}
		string L_LAST = /* TODO: $math(add) */ NPC_LAST_DAMAGED_OTHER_TIME;
		if (L_GAME_TIME < L_LAST)
		{
			int L_NO_SUICIDE = 1;
		}
		if ((L_NO_SUICIDE))
		{
			NPC_LAST_SUICDE_ABORT = L_GAME_TIME;
			NPC_DIE_NT_NEXT_CHECK("set_die_nt");
		}
		else
		{
			NPC_SILENT_SUICIDE = 1;
			NPC_INVISIBLE_SUICIDE = 1;
			NPC_NO_COUNT = 1;
			npc_suicide();
		}
	}

	void ext_rmines_clear()
	{
		npcatk_clear_targets();
		NPC_DIE_NT_NEXT_CHECK = 10.0;
	}

	void set_mspeed()
	{
		LogDebug("set_mspeed PARAM1");
		if (!(param1 > 0)) return;
		if (BASE_MOVESPEED == "BASE_MOVESPEED")
		{
			BASE_MOVESPEED = 1.0;
		}
		BASE_MOVESPEED *= param1;
		NPC_MOVE_SPEED_ADJ = BASE_MOVESPEED;
		SetMoveSpeed(BASE_MOVESPEED);
		SetAnimMoveSpeed(BASE_MOVESPEED);
		LogDebug("set_mspeed newspeed BASE_MOVESPEED");
		PlayAnim("once", "break");
		NPC_USES_HANDLE_EVENTS = 1;
		if (NPC_ADJ_FLAGS == "NPC_ADJ_FLAGS")
		{
			NPC_ADJ_FLAGS = "";
		}
		if (NPC_ADJ_FLAGS.length() > 0) NPC_ADJ_FLAGS += ";";
		NPC_ADJ_FLAGS += "mspeed";
	}

	void set_mspeedt()
	{
		LogDebug("setanim.movespeed PARAM1");
		SetAnimMoveSpeed(param1);
	}

	void set_mspeed2()
	{
		LogDebug("movespeed PARAM1");
		SetMoveSpeed(param1);
	}

	void set_bbox()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		LogDebug("ext_setbbox PARAM1");
		if ((param2).findFirst(PARAM) == 0)
		{
		}
		else
		{
			SetBBox(param1, param2);
		}
	}

	void set_range()
	{
		if (!(param1 > 0)) return;
		if (NPC_ORG_RANGE == "NPC_ORG_RANGE")
		{
			NPC_ORG_RANGE = ATTACK_RANGE;
		}
		NPC_SET_RANGE = param1;
		NPC_SET_RANGE_RATIO = NPC_ORG_RANGE;
		NPC_SET_RANGE_RATIO /= NPC_ORG_RANGE;
		ScheduleDelayedEvent(2.0, "set_range2");
	}

	void set_range2()
	{
		ATTACK_RANGE = NPC_SET_RANGE;
		ATTACK_HITRANGE = NPC_SET_RANGE;
		ATTACK_HITRANGE *= 2.0;
	}

	void set_tele_hunter()
	{
		if ((NPC_TELEHUNT)) return;
		LogDebug("set_tele_hunter PARAM1");
		NPC_TELEHUNT = 1;
		NPC_TELEHUNTER_FX = 1;
		NPC_TELEHUNT_FREQ = param1;
		if ((param1).findFirst(PARAM) == 0)
		{
			NPC_TELEHUNT_FREQ = 20.0;
		}
		NPC_DO_SPAWN_SOUND = 1;
		NPC_TELEHUNT_FREQ("npcatk_tele_hunter_loop");
		if (NPC_ADJ_FLAGS == "NPC_ADJ_FLAGS")
		{
			NPC_ADJ_FLAGS = "";
		}
		if (NPC_ADJ_FLAGS.length() > 0) NPC_ADJ_FLAGS += ";";
		NPC_ADJ_FLAGS += "telehunt";
	}

	void set_tele_hunter_random()
	{
		if ((NPC_TELEHUNT)) return;
		LogDebug("set_tele_hunter_random PARAM1");
		PlayAnim("once", "break");
		NPC_TELEHUNT = 1;
		NPC_TELEHUNTER_FX = 1;
		NPC_TELEHUNT_FREQ = param1;
		NPC_TELEHUNT_RANDOM = 1;
		if ((param1).findFirst(PARAM) == 0)
		{
			NPC_TELEHUNT_FREQ = 20.0;
		}
		NPC_DO_SPAWN_SOUND = 1;
		NPC_TELEHUNT_FREQ("npcatk_tele_hunter_loop");
		if (NPC_ADJ_FLAGS == "NPC_ADJ_FLAGS")
		{
			NPC_ADJ_FLAGS = "";
		}
		if (NPC_ADJ_FLAGS.length() > 0) NPC_ADJ_FLAGS += ";";
		NPC_ADJ_FLAGS += "telehunt";
	}

	void set_skin()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		NPC_CUSTOM_SKIN = param1;
		SetProp(GetOwner(), "skin", param1);
	}

	void set_say_spawn()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		SetSayTextRange(2048);
		SayText("PARAM1");
	}

	void set_say_spot()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		SetSayTextRange(2048);
		NPC_DO_ON_SPOT += 1;
		NPC_SAY_ON_SPOT = param1;
	}

	void set_say_die()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		SetSayTextRange(2048);
		NPC_DO_ON_DIE += 1;
		NPC_SAY_ON_DIE = param1;
	}

	void set_dump_xp()
	{
		LogDebug("set_dump_xp set");
		NPC_DUMP_XP = 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(NPC_DUMP_XP)) return;
		LogDebug("dumping xp... [ /* TODO: $get_array_amt */ $get_array_amt(ARRAY_XP_PLAYERS) ]");
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_XP_PLAYERS); i++)
		{
			dbg_dump_xp();
		}
	}

	void dbg_dump_xp()
	{
		string CUR_HIT = i;
		string CUR_PLR = /* TODO: $get_array */ $get_array(ARRAY_XP_PLAYERS, CUR_HIT);
		string CUR_PLR = GetEntityName(CUR_PLR);
		string CUR_SKL = /* TODO: $get_array */ $get_array(ARRAY_XP_SKILLS, CUR_HIT);
		string CUR_EXP = /* TODO: $get_array */ $get_array(ARRAY_XP_AMTS, CUR_HIT);
		LogDebug("dbg_dump_xp CUR_PLR CUR_SKL CUR_EXP");
	}

	void set_solid()
	{
		LogDebug("set_solid PARAM1");
		if (param1 == "none")
		{
			SetSolid(param1);
		}
		if (param1 == "box")
		{
			SetSolid(param1);
		}
		if (param1 == "slidebox")
		{
			SetSolid(param1);
		}
		if (param1 == "trigger")
		{
			SetSolid(param1);
		}
	}

	void ext_clearfx()
	{
		LogDebug("ext_clearfx");
		ClearFX();
	}

	void ext_remove_effect()
	{
		LogDebug("ext_remove_effect PARAM1");
		RemoveEffect(GetOwner(), param1);
	}

	void ext_break()
	{
		LogDebug("ext_break");
		PlayAnim("once", "break");
	}

	void ext_bleed()
	{
		LogDebug("ext_bleed col PARAM1 amt PARAM2");
		Bleed(GetOwner(), param1, param2);
	}

	void set_takedmg()
	{
		string L_DMG_TYPE = /* TODO: $string_upto */ $string_upto(param1, ":");
		string L_DMG_RATIO = /* TODO: $string_from */ $string_from(param1, ":");
		SetDamageResistance(L_DMG_TYPE, L_DMG_RATIO);
	}

	void set_notarget()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		PLAYING_DEAD = param1;
	}

	void ext_set_next_circle_heal()
	{
		NEXT_CIRCLE_HEAL = param1;
	}

	void ext_delay_target()
	{
		NPC_DELAY_TARGET = param2;
		if (!((NPC_DELAY_TARGET).findFirst(PARAM) == 0)) return;
		PARAM1("ext_delay_target2");
	}

	void ext_delay_target2()
	{
		if (NPC_DELAY_TARGET == "enemy")
		{
			int L_DO_SCAN = 1;
		}
		if (!(IsEntityAlive(NPC_DELAY_TARGET)))
		{
			int L_DO_SCAN = 1;
		}
		if ((L_DO_SCAN))
		{
			string L_TARGS = FindEntitiesInSphere("enemy", 2048);
			string L_TARGS = /* TODO: $sort_entlist */ $sort_entlist(L_TARGS, "range");
			npcatk_settarget(GetToken(L_TARGS, 0, ";"));
		}
		else
		{
			npcatk_settarget(NPC_DELAY_TARGET);
		}
	}

	void set_world_spawn()
	{
		ApplyEffect(GetEntityIndex(GetOwner()), "effects/add_dynamic_spawn", "world");
	}

	void set_dyn_spawn()
	{
		ApplyEffect(GetEntityIndex(GetOwner()), "effects/add_dynamic_spawn");
	}

	void toggle_invincible()
	{
		if ((GetEntityProperty(GetOwner(), "invincible")))
		{
			SetInvincible(false);
		}
		else
		{
			SetInvincible(true);
		}
	}

	void make_phys_immune()
	{
		immune_ghost();
	}

	void immune_ghost()
	{
		SetDamageResistance("slash", 0);
		SetDamageResistance("blunt", 0);
		SetDamageResistance("pierce", 0);
		ext_eresist_adj("lightning", 1.5, -1);
		ext_eresist_adj("holy", 2.0, -1);
		IS_BLOODLESS = 1;
	}

	void ext_hearingsensitivity()
	{
		SetHearingSensitivity(param1);
	}

}

}
