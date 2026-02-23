#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"

namespace MS
{

class ElementalAir2 : CGameScript
{
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_SUMMON_TELE_CHECK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string BALL_TARGETS;
	string BEAM_ID;
	string BEAM_LIST;
	int BEAM_STEP;
	int CAN_FLINCH;
	string CHAIN_TARGETS;
	int CYCLES_ON;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	string HOVER_LOOP_DELAY;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int MOVE_RANGE;
	string MY_HURT_STAGE;
	string NEXT_GLOAT;
	int NO_MOVE;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string NPC_MOVE_DEST;
	string OLD_POS;
	int ROAM_ROT;
	int TELEPORT_ENABLED;

	ElementalAir2()
	{
		AS_SUMMON_TELE_CHECK = 1;
		ANIM_IDLE = "idle1";
		ANIM_WALK = "idle1";
		ANIM_RUN = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_FLINCH = "flinch";
		ANIM_DEATH = "die1";
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 10;
		FLINCH_ANIM = "flinch";
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 150;
		MOVE_RANGE = 65;
		NPC_HACKED_MOVE_SPEED = 100;
		const int MOVESPEED_SLOW = 100;
		const int MOVESPEED_FAST = 200;
		const string FREQ_CHAIN = Random(10, 15);
		const float FREQ_GLOAT = 10.0;
		const float FREQ_BALLS = 30.0;
		const string FREQ_TORNADO = Random(45, 120);
		const int DMG_CHAIN_DOT = 100;
		const int DMG_CHAIN_DRAIN = 50;
		const int DMG_BALL = 200;
		const string FREQ_TELEPORT = Random(20.0, 30.0);
		const string SOUND_THUNDER = "magic/bolt_end.wav";
		const string SOUND_THUNDER_CHARGE = "magic/bolt_start.wav";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
		const string SOUND_IDLE1 = "agrunt/ag_alert1.wav";
		const string SOUND_IDLE2 = "agrunt/ag_die1.wav";
		const string SOUND_IDLE3 = "agrunt/ag_idle1.wav";
		const string SOUND_SWIPE = "weapons/debris1.wav";
		const string SOUND_SWIPEHIT = "ambience/steamburst1.wav";
		const string SOUND_DEATH = "garg/gar_die1.wav";
		const string SOUND_PAIN0 = "debris/bustflesh2.wav";
		const string SOUND_PAIN1 = "agrunt/ag_pain1.wav";
		const string SOUND_PAIN2 = "agrunt/ag_pain4.wav";
		const string SOUND_GLOAT = "x/x_laugh1.wav";
		const string SOUND_HOVER = "fans/fan4on.wav";
		const float HURT_THRESHOLD = 0.5;
		const float PLAYTIME_HOVER = 3.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if ((NO_MOVE))
		{
			SetMoveDest("none");
			NPC_HACKED_MOVE_SPEED = 0;
			int EXIT_SUB = 1;
		}
		if (!(EXIT_SUB))
		{
		}
		if (NPC_MOVE_DEST == "unset")
		{
			ROAM_ROT += 10;
			if (ROAM_ROT > 359)
			{
				ROAM_ROT -= 359;
			}
			string MOVE_DEST = GetMonsterProperty("origin");
			MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, ROAM_ROT, 0), Vector3(0, 128, 0));
			SetMoveDest(MOVE_DEST);
			NPC_HACKED_MOVE_SPEED = MOVESPEED_SLOW;
		}
		else
		{
			NPC_HACKED_MOVE_SPEED = MOVESPEED_FAST;
			SetMoveDest(NPC_MOVE_DEST);
		}
		if ((I_R_FROZEN))
		{
			SetMoveDest("none");
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, -200));
			NPC_HACKED_MOVE_SPEED = 0;
		}
		else
		{
			if (Distance(OLD_POS, GetMonsterProperty("origin")) < 5)
			{
				string RND_RL = RandomInt(-100, 100);
				string RND_FB = RandomInt(-100, 100);
				string RND_UD = RandomInt(-100, 100);
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_RL, RND_FB, RND_UD));
			}
			OLD_POS = GetMonsterProperty("origin");
		}
	}

	void game_precache()
	{
		Precache("monsters/summon/tornado");
		Precache("monsters/summon/lightning_ball_guided");
		Precache(SOUND_THUNDER);
	}

	void OnSpawn() override
	{
		SetName("Greater Air Elemental");
		SetHealth(4000);
		SetWidth(64);
		SetHeight(64);
		SetRace("demon");
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("lightning", 0.0);
		SetBloodType("none");
		SetRoam(false);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(11);
		SetModel("monsters/elementals_greater_flyer.mdl");
		SetModelBody(0, 3);
		NPC_GIVE_EXP = 600;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetFly(true);
		MY_HURT_STAGE = GetEntityMaxHealth(GetOwner());
		MY_HURT_STAGE *= HURT_THRESHOLD;
		NPC_MOVE_DEST = "unset";
		ROAM_ROT = 0;
		BEAM_LIST = "";
		ScheduleDelayedEvent(0.1, "init_beam1");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		ScheduleDelayedEvent(0.1, "npcatk_hunt");
		if ((SUSPEND_AI)) return;
		if ((IS_FLEEING)) return;
		if ((false))
		{
			string LAST_SEEN_NME = GetEntityIndex(m_hLastSeen);
		}
		if (m_hAttackTarget == "unset")
		{
			npcatk_settarget(LAST_SEEN_NME);
		}
		if (GetEntityRange(m_hAttackTarget) > GetEntityRange(LAST_SEEN_NME))
		{
			if ((IsValidPlayer(LAST_SEEN_NME)))
			{
			}
			npcatk_settarget(LAST_SEEN_NME);
		}
		if (m_hAttackTarget != "unset")
		{
			NPC_MOVE_DEST = GetEntityOrigin(m_hAttackTarget);
			NPC_MOVE_DEST += "z";
			string RND_FB = Random(-128, 128);
			NPC_MOVE_DEST += "x";
		}
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(m_hAttackTarget == "unset")) return;
		string LAST_HEARD = GetEntityIndex("ent_lastheard");
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		npcatk_settarget(m_hAttackTarget);
	}

	void my_target_died()
	{
		NPC_MOVE_DEST = "unset";
		if (!(GetGameTime() > NEXT_GLOAT)) return;
		NEXT_GLOAT = GetGameTime();
		NEXT_GLOAT += FREQ_GLOAT;
		PlayAnim("critical", "idle2");
		suspend_move(1.0);
	}

	void suspend_move()
	{
		NO_MOVE = 1;
		PARAM1("resume_move");
	}

	void resume_move()
	{
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		NO_MOVE = 0;
	}

	void game_movingto_dest()
	{
		if (!(GetGameTime() > HOVER_LOOP_DELAY)) return;
		EmitSound(GetOwner(), CHAN_BODY, SOUND_HOVER, 8);
		HOVER_LOOP_DELAY = GetGameTime();
		HOVER_LOOP_DELAY += 3.0;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		string MY_HEALTH = GetEntityHealth(GetOwner());
		if (MY_HEALTH >= MY_HURT_STAGE)
		{
			// PlayRandomSound from: SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN1
			array<string> sounds = {SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN1};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (MY_HEALTH < MY_HURT_STAGE)
		{
			// PlayRandomSound from: SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN2
			array<string> sounds = {SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void cycle_up()
	{
		start_cycles();
	}

	void cycle_npc()
	{
		start_cycles();
	}

	void start_cycles()
	{
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		FREQ_CHAIN("do_chain");
		FREQ_BALLS("do_balls");
		FREQ_TORNADO("do_tornado");
		if (!(TELEPORT_ENABLED)) return;
		FREQ_TELEPORT("do_teleport");
	}

	void do_chain()
	{
		FREQ_CHAIN("do_chain");
		if (!(m_hAttackTarget != "unset")) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (!(GetEntityRange(m_hAttackTarget) < 2048)) return;
		if (!(false)) return;
		suspend_move(2.0);
		EmitSound(GetOwner(), 0, SOUND_THUNDER_CHARGE, 10);
		PlayAnim("critical", "tocharge");
		SetIdleAnim("charging");
		SetMoveAnim("charging");
		string TARGET_ORG = GetEntityOrigin(m_hAttackTarget);
		CHAIN_TARGETS = FindEntitiesInSphere("enemy", 1024);
		Effect("beam", "update", GetToken(BEAM_LIST, 0, ";"), "end_target", m_hAttackTarget, 0);
		Effect("beam", "update", GetToken(BEAM_LIST, 1, ";"), "end_target", m_hAttackTarget, 0);
		Effect("beam", "update", GetToken(BEAM_LIST, 0, ";"), "brightness", 200);
		Effect("beam", "update", GetToken(BEAM_LIST, 1, ";"), "brightness", 200);
		DoDamage(m_hAttackTarget, "direct", DMG_CHAIN_DRAIN, 1.0, GetOwner());
		ApplyEffect(m_hAttackTarget, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), DMG_CHAIN_DOT);
		BEAM_STEP = 0;
		ScheduleDelayedEvent(0.5, "setup_beams");
		ScheduleDelayedEvent(2.0, "clear_beams");
	}

	void setup_beams()
	{
		LogDebug("setup_beams stp BEAM_STEP targs CHAIN_TARGETS");
		BEAM_STEP += 1;
		string CUR_IDX = BEAM_STEP;
		if (!(CUR_IDX < 5)) return;
		if (!(CUR_IDX < GetTokenCount(CHAIN_TARGETS, ";"))) return;
		ScheduleDelayedEvent(0.25, "setup_beams");
		string BEAM_IDX = CUR_IDX;
		BEAM_IDX += 1;
		string CUR_BEAM = GetToken(BEAM_LIST, CUR_IDX, ";");
		string CUR_TARGET = GetToken(CHAIN_TARGETS, CUR_IDX, ";");
		string PREV_IDX = CUR_IDX;
		PREV_IDX -= 1;
		string PREV_TARGET = GetToken(CHAIN_TARGETS, PREV_IDX, ";");
		if (PREV_IDX == 0)
		{
			string PREV_TARGET = m_hAttackTarget;
		}
		Effect("beam", "update", CUR_BEAM, "start_target", PREV_TARGET, 0);
		Effect("beam", "update", CUR_BEAM, "end_target", CUR_TARGET, 0);
		Effect("beam", "update", CUR_BEAM, "brightness", 200);
		ApplyEffect(CUR_TARGET, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), DMG_CHAIN_DOT);
		DoDamage(CUR_TARGET, "direct", DMG_CHAIN_DRAIN, 1.0, GetOwner());
		CallExternal(CUR_TARGET, "ext_playsound_kiss", 0, 10, SOUND_THUNDER);
	}

	void clear_beams()
	{
		for (int i = 0; i < GetTokenCount(BEAM_LIST, ";"); i++)
		{
			clear_beams_loop();
		}
	}

	void clear_beams_loop()
	{
		Effect("beam", "update", GetToken(BEAM_LIST, i, ";"), "brightness", 0);
	}

	void init_beam1()
	{
		Effect("beam", "ents", "lgtning.spr", 60, GetOwner(), 1, GetOwner(), 0, Vector3(200, 200, 255), 0, 20, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		BEAM_ID = GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam1 BEAM_ID");
		ScheduleDelayedEvent(0.1, "init_beam2");
	}

	void init_beam2()
	{
		Effect("beam", "ents", "lgtning.spr", 60, GetOwner(), 2, GetOwner(), 0, Vector3(200, 200, 255), 0, 20, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam2 BEAM_LIST GetEntityIndex(m_hLastCreated)");
		ScheduleDelayedEvent(0.1, "init_beam3");
	}

	void init_beam3()
	{
		Effect("beam", "ents", "lgtning.spr", 60, GetOwner(), 1, GetOwner(), 0, Vector3(200, 200, 255), 0, 20, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam3 BEAM_LIST GetEntityIndex(m_hLastCreated)");
		ScheduleDelayedEvent(0.1, "init_beam4");
	}

	void init_beam4()
	{
		Effect("beam", "ents", "lgtning.spr", 60, GetOwner(), 2, GetOwner(), 0, Vector3(200, 200, 255), 0, 20, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam4 BEAM_LIST GetEntityIndex(m_hLastCreated)");
		ScheduleDelayedEvent(0.1, "init_beam5");
	}

	void init_beam5()
	{
		Effect("beam", "ents", "lgtning.spr", 60, GetOwner(), 2, GetOwner(), 0, Vector3(200, 200, 255), 0, 20, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam4 BEAM_LIST GetEntityIndex(m_hLastCreated)");
		ScheduleDelayedEvent(0.1, "init_beam6");
	}

	void init_beam6()
	{
		Effect("beam", "ents", "lgtning.spr", 60, GetOwner(), 2, GetOwner(), 0, Vector3(200, 200, 255), 0, 20, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam4 BEAM_LIST GetEntityIndex(m_hLastCreated)");
	}

	void do_balls()
	{
		FREQ_BALLS("do_balls");
		if (!(m_hAttackTarget != "unset")) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (!(GetEntityRange(m_hAttackTarget) < 2048)) return;
		if (!(CYCLED_TIME != CYCLE_TIME_IDLE)) return;
		BALL_TARGETS = FindEntitiesInSphere("enemy", 2048);
		ScrambleTokens(BALL_TARGETS, ";");
		if (!(GetTokenCount(BALL_TARGETS, ";") > 0)) return;
		PlayAnim("critical", "block");
		SpawnNPC("monsters/summon/lightning_ball_guided", /* TODO: $relpos */ $relpos(0, 64, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_BALL, 30.0, 192, GetToken(BALL_TARGETS, 0, ";")
		if (GetTokenCount(BALL_TARGETS, ";") == 1)
		{
			ScheduleDelayedEvent(0.1, "do_balls2");
			ScheduleDelayedEvent(0.2, "do_balls3");
		}
		if (!(GetTokenCount(BALL_TARGETS, ";") > 1)) return;
		ScheduleDelayedEvent(0.1, "do_balls2");
		if (!(GetTokenCount(BALL_TARGETS, ";") > 2)) return;
		ScheduleDelayedEvent(0.2, "do_balls3");
		if (!(GetTokenCount(BALL_TARGETS, ";") > 3)) return;
		ScheduleDelayedEvent(0.3, "do_balls4");
	}

	void do_balls2()
	{
		SpawnNPC("monsters/summon/lightning_ball_guided", /* TODO: $relpos */ $relpos(0, -64, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_BALL, 30.0, 192, GetToken(BALL_TARGETS, 1, ";")
	}

	void do_balls3()
	{
		SpawnNPC("monsters/summon/lightning_ball_guided", /* TODO: $relpos */ $relpos(64, 64, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_BALL, 30.0, 192, GetToken(BALL_TARGETS, 2, ";")
	}

	void do_balls4()
	{
		SpawnNPC("monsters/summon/lightning_ball_guided", /* TODO: $relpos */ $relpos(-64, 64, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_BALL, 30.0, 192, GetToken(BALL_TARGETS, 3, ";")
	}

	void do_tornado()
	{
		FREQ_TORNADO("do_tornado");
		if (!(m_hAttackTarget != "unset")) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (!(GetEntityRange(m_hAttackTarget) < 2048)) return;
		PlayAnim("critical", "block");
		SpawnNPC("monsters/summon/tornado", /* TODO: $relpos */ $relpos(0, 72, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 300, 20.0
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		for (int i = 0; i < GetTokenCount(BEAM_LIST, ";"); i++)
		{
			remove_beams_loop();
		}
	}

	void remove_beams_loop()
	{
		Effect("beam", "update", GetToken(BEAM_LIST, i, ";"), "remove", 0.1);
	}

	void game_dynamically_created()
	{
		AM_SUMMONED = 1;
		NO_SPAWN_STUCK_CHECK = 1;
		TELEPORT_ENABLED = 1;
	}

	void idle_sounds()
	{
		string NEXT_SOUND = Random(5, 15);
		NEXT_SOUND("idle_sounds");
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void do_teleport()
	{
		if (!(false))
		{
			int L_TELE_CHECK = 1;
		}
		if (GetEntityRange(m_hAttackTarget) > 1024)
		{
			int L_TELE_CHECK = 1;
		}
		LogDebug("do_teleport GetEntityRange(m_hAttackTarget) L_TELE_CHECK");
		if (!(L_TELE_CHECK))
		{
			FREQ_TELEPORT("do_teleport");
		}
		if (!(L_TELE_CHECK)) return;
		string L_TELE_POINT = GetEntityOrigin(m_hAttackTarget);
		string RND_ANG = Random(0, 359.99);
		L_TELE_POINT += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, 192, 34));
		string CUR_POS = GetEntityOrigin(GetOwner());
		SetEntityOrigin(GetOwner(), L_TELE_POINT);
		string reg.npcmove.endpos = L_TELE_POINT;
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(-16, 0, 0));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" <= 0)
		{
			LogDebug("do_teleport fail @ L_TELE_POINT");
			int L_TELE_FAIL = 1;
			SetEntityOrigin(GetOwner(), CUR_POS);
		}
		else
		{
			FREQ_TELEPORT("do_teleport");
			ClientEvent("new", "all", "effects/sfx_sprite_in_fancy", L_TELE_POINT, "c-tele1.spr", 25, 2.0, Vector3(255, 255, 255), 512, "magic/teleport.wav");
			ClientEvent("new", "all", "effects/sfx_sprite_in_fancy", CUR_POS, "c-tele1.spr", 25, 2.0, Vector3(255, 255, 255), 512, "magic/teleport.wav");
			for (int i = 0; i < GetTokenCount(BEAM_LIST, ";"); i++)
			{
				remove_beams_loop();
			}
			BEAM_LIST = "";
			ScheduleDelayedEvent(0.1, "init_beam1");
		}
		if (!(L_TELE_FAIL)) return;
		ScheduleDelayedEvent(5.0, "do_teleport");
	}

}

}
