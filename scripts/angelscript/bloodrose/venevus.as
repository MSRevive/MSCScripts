#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Venevus : CGameScript
{
	int ACTIVE_VOLCANO;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string BEAM_ID;
	int BEING_SPLOITED_DMG;
	int BOLT_DELAY;
	int CASTING_SPELL_DELAY;
	int CHANGE_RETURN_POINT;
	int CKN_MY_OLD_POS;
	string DID_ALE_INTRO;
	int DMG_VOLCANO;
	string DO_ACID_BOLTS;
	string DO_DAMAGE_SITE;
	string DO_HOLY_MSG;
	string DO_LIGHTNING;
	string FIRE_AT;
	string HOLY_OFFENDER;
	int IR_DEADSKI;
	int IS_UNHOLY;
	int KILLED_A_PLAYER;
	string LAST_STUCK_CHECK_POS;
	string MAX_TELE_RANGE;
	string MOVE_LASTPOS;
	string MURDER_A_PLAYER;
	string NEXT_SPELL;
	int NO_STUCK_CHECKS;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string NPC_SPAWN_LOC;
	string OUTSPELL;
	string OUT_SPELL;
	int POISON_EM;
	string POISON_SITE;
	string PRESET_TARGET;
	float SNOWBALL_DURATION;
	int SPELL_SELECT;
	string SPELL_TARGET;
	int SPLOITED_CHECKED;
	string SPOTTING;
	string STATUE_ID;
	string STRUCK_BY_HOLY;
	int TELED_OUT;
	string THIS_MUST_DIE;
	int THROW_CHANCE;

	Venevus()
	{
		IS_UNHOLY = 1;
		if (StringToLower(GetMapName()) == "bloodrose")
		{
			NPC_GIVE_EXP = 3000;
			NPC_IS_BOSS = 1;
		}
		else
		{
			if (StringToLower(GetMapName()) == "aleyesu")
			{
				NPC_GIVE_EXP = 5000;
				NPC_IS_BOSS = 1;
			}
			else
			{
				NPC_GIVE_EXP = 1000;
			}
		}
		const float NPC_BOSS_REGEN_RATE = 0.1;
		const float NPC_BOSS_RESTORATION = 0.5;
		const int MAX_RANGE = 2048;
		const string ANIM_CAST = "castspell";
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		ANIM_DEATH = "castspell";
		const string ANIM_DEAD = "lying_on_stomach";
		SNOWBALL_DURATION = 10.0;
		const float SPELL_FREQ = 6.0;
		const float POISON_ALL_FREQ = 200.0;
		const string SOUND_LAUGH = "monsters/skeleton/cal_laugh.wav";
		const string SOUND_POWERUP = "ambience/particle_suck2.wav";
		const string SOUND_STEAM = "ambience/steamburst1.wav";
		const string SOUND_BOOM = "ambience/flameburst1.wav";
		const string SOUND_ACID_CHARGE = "bullchicken/bc_attack1.wav";
		const string SOUND_STRUCK1 = "zombie/zo_pain2.wav";
		const string SOUND_STRUCK2 = "zombie/zo_pain2.wav";
		const string SOUND_STRUCK3 = "zombie/zo_pain2.wav";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
		const string SOUND_SNOWBALL = "zombie/claw_miss1.wav";
		const string SOUND_ICEBLAST = "magic/temple.wav";
		const string SOUND_THROW = "debris/beamstart5.wav";
		const string SOUND_FIRE_WALL = "magic/fireball_strike.wav";
		const float POISON_CLOUD_DAMAGE = 40.0;
		const string POISON_CLOUD_DURATION = SPELL_FREQ;
		const int AIM_RATIO = 50;
		const int OFFSET_LIGHTNING = 100;
		const int OFFSET_POISON = 100;
		const int OFFSET_ICE = 100;
		const int OFFSET_FIRE = 100;
		const int ACID_BOLT_DAMAGE = 600;
		const int LIGHTNING_BOLT_DAMAGE = 40;
		const int SHOCK_DAMAGE = 30;
		const int SHOCK_DURATION = 1;
		NO_STUCK_CHECKS = 1;
		const int BEING_SPLOITED_THRESHOLD = 500;
		const int I_AM_TURNABLE = 0;
		const string MONSTER_MODEL = "monsters/venevus.mdl";
		const string LIGHTNING_SPRITE = "lgtning.spr";
		Precache(MONSTER_MODEL);
		Precache(LIGHTNING_SPRITE);
	}

	void OnSpawn() override
	{
		if (!(AM_GENERIC))
		{
			SetName("Venevus , the Corruptor");
		}
		if ((AM_GENERIC))
		{
			SetName("Evil Necromancer");
		}
		SetHealth(3000);
		SetFOV(359);
		SetWidth(40);
		SetHeight(80);
		SetRoam(false);
		SetRace("demon");
		Precache(MONSTER_MODEL);
		SetModel(MONSTER_MODEL);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetGold(200);
		SetDamageResistance("all", 0.4);
		SetDamageResistance("slash", 0.0);
		SetDamageResistance("pierce", 0.0);
		SetDamageResistance("blunt", 0.0);
		SetDamageResistance("fire", 0.25);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("dark", 0.5);
		SetDamageResistance("acid", 0.25);
		SetDamageResistance("poison", 0);
		SetDamageResistance("lightning", 1.2);
		SPELL_SELECT = 0;
		THROW_CHANCE = 0;
		ScheduleDelayedEvent(1.1, "post_spawn_props");
		if (!(AM_GENERIC))
		{
			scan_for_intro();
		}
		if ((AM_GENERIC))
		{
			ScheduleDelayedEvent(0.1, "pre_mortal_kombat");
		}
		if (!(AM_GENERIC))
		{
			SetInvincible(true);
		}
		ScheduleDelayedEvent(0.1, "init_beam");
		ACTIVE_VOLCANO = 0;
		DMG_VOLCANO = 50;
	}

	void post_spawn_props()
	{
		SetDamageResistance("holy", 2.0);
		NPC_SPAWN_LOC = GetMonsterProperty("origin");
		LAST_STUCK_CHECK_POS = GetMonsterProperty("origin");
		if ((StringToLower(GetMapName())).findFirst("aleyesu") >= 0)
		{
			MAX_TELE_RANGE = 768;
		}
		else
		{
			MAX_TELE_RANGE = 2048;
		}
	}

	void scan_for_intro()
	{
		if ((CanSee("enemy", 600)))
		{
			SetSayTextRange(2048);
			SetMoveDest(m_hLastSeen);
			SayText("My my, so you've shown your faces after all...");
			ScheduleDelayedEvent(3.0, "pre_mortal_kombat");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ScheduleDelayedEvent(0.5, "scan_for_intro");
	}

	void pre_mortal_kombat()
	{
		SetSayTextRange(2048);
		if (!(AM_GENERIC))
		{
			SayText("And here I took you for cowards... But obviously...");
		}
		ScheduleDelayedEvent(3.0, "let_mortal_kombat_begin");
		ScheduleDelayedEvent(2.0, "green_blast");
	}

	void let_mortal_kombat_begin()
	{
		EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
		SetSayTextRange(2048);
		if (!(AM_GENERIC))
		{
			SayText("...You are simply FOOLS!");
		}
		SetInvincible(false);
		SetRoam(true);
		ScheduleDelayedEvent(5.0, "select_random_spell");
		ScheduleDelayedEvent(10.0, "stuck_checks");
	}

	void green_blast()
	{
		PlayAnim("critical", ANIM_CAST);
		EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
		OUT_SPELL = "poison_all";
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 100, 5, 5);
		POISON_ALL_FREQ("poison_all_again");
	}

	void poison_all_again()
	{
		POISON_EM = 1;
	}

	void select_random_spell()
	{
		SPELL_SELECT += 1;
		if (SPELL_SELECT > 7)
		{
			SPELL_SELECT = 1;
		}
		if (SPELL_SELECT == 1)
		{
			NEXT_SPELL = "poison_cloud";
		}
		if (SPELL_SELECT == 2)
		{
			NEXT_SPELL = "chain_lightning";
		}
		if (SPELL_SELECT == 3)
		{
			NEXT_SPELL = "fire_wall";
		}
		if (SPELL_SELECT == 4)
		{
			NEXT_SPELL = "snow_ball";
		}
		if (SPELL_SELECT == 5)
		{
			NEXT_SPELL = "freezing_sphere";
		}
		if (SPELL_SELECT == 6)
		{
			NEXT_SPELL = "acid_bolt";
		}
		if (SPELL_SELECT == 7)
		{
			NEXT_SPELL = "volcano";
		}
		if (POISON_EM == 1)
		{
			NEXT_SPELL = "poison_all";
		}
		SPELL_FREQ("select_random_spell");
		SPELL_FREQ("setup_spell");
	}

	void setup_spell()
	{
		if ((IR_DEADSKI)) return;
		if ((TELED_OUT)) return;
		CASTING_SPELL_DELAY = 1;
		CKN_MY_OLD_POS = 0;
		if (NEXT_SPELL == "poison_all")
		{
			green_blast();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		OUT_SPELL = NEXT_SPELL;
		PlayAnim("critical", ANIM_CAST);
		if ((false))
		{
			SPELL_TARGET = GetEntityIndex(m_hLastSeen);
			SetMoveDest(SPELL_TARGET);
		}
		if (OUT_SPELL == "poison_cloud")
		{
			Effect("glow", GetOwner(), Vector3(0, 255, 0), 100, 5, 5);
			SpawnNPC("monsters/companion/spell_maker_affliction", /* TODO: $relpos */ $relpos(0, 0, 40), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "none", "none", OFFSET_POISON
		}
		if (OUT_SPELL == "volcano")
		{
			Effect("glow", GetOwner(), Vector3(255, 0, 0), 256, 5, 5);
			SpawnNPC("monsters/companion/spell_maker_fire", /* TODO: $relpos */ $relpos(0, 0, 40), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "none", "none", OFFSET_FIRE
		}
		if (OUT_SPELL == "fire_wall")
		{
			Effect("glow", GetOwner(), Vector3(255, 80, 80), 100, 5, 5);
			SpawnNPC("monsters/companion/spell_maker_fire", /* TODO: $relpos */ $relpos(0, 0, 40), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "none", "none", OFFSET_FIRE
		}
		if (OUT_SPELL == "snow_ball")
		{
			Effect("glow", GetOwner(), Vector3(80, 80, 255), 100, 5, 5);
			SpawnNPC("monsters/companion/spell_maker_ice", /* TODO: $relpos */ $relpos(0, 0, 40), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "none", "none", OFFSET_ICE
		}
		if (OUT_SPELL == "freezing_sphere")
		{
			Effect("glow", GetOwner(), Vector3(128, 128, 255), 512, 5, 5);
			SpawnNPC("monsters/companion/spell_maker_ice", /* TODO: $relpos */ $relpos(0, 0, 40), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "none", "none", OFFSET_ICE
		}
		if (OUT_SPELL == "acid_bolt")
		{
			Effect("glow", GetOwner(), Vector3(0, 255, 0), 200, 5, 5);
			EmitSound(GetOwner(), 0, SOUND_ACID_CHARGE, 10);
		}
		if (OUT_SPELL == "chain_lightning")
		{
			Effect("glow", GetOwner(), Vector3(255, 255, 0), 200, 5, 5);
			SpawnNPC("monsters/companion/spell_maker_lightning", /* TODO: $relpos */ $relpos(0, 0, 40), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "none", "none", OFFSET_LIGHTNING
		}
		if (OUT_SPELL == "kill")
		{
			Effect("glow", GetOwner(), Vector3(255, 255, 255), 200, 5, 5);
			EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
		}
	}

	void castspell()
	{
		if (!(DID_ALE_INTRO))
		{
			DID_ALE_INTRO = 1;
			if ((StringToLower(GetMapName())).findFirst("aleyesu") >= 0)
			{
			}
			do_ale_intro();
		}
		if ((IR_DEADSKI)) return;
		SetMoveDest(SPELL_TARGET);
		if (OUT_SPELL == "poison_all")
		{
			EmitSound(GetOwner(), 0, SOUND_BOOM, 10);
			Effect("screenfade", "all", 3, 1, Vector3(0, 255, 0), 255, "fadein");
			FIRE_AT = "unset";
			POISON_SITE = 1;
			SPOTTING = 1;
			DO_DAMAGE_SITE = 1;
			spot_targets();
			ScheduleDelayedEvent(1.0, "stop_spotting");
			ScheduleDelayedEvent(1.0, "reset_poison_site");
			POISON_EM = 0;
		}
		if (OUT_SPELL == "kill")
		{
			EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
			Effect("screenfade", "all", 3, 1, Vector3(255, 255, 255), 255, "fadein");
			ScheduleDelayedEvent(0.1, "kill_a_player");
		}
		if (OUT_SPELL == "poison_cloud")
		{
			if ((false))
			{
				string SPELL_TARG = GetEntityOrigin(m_hLastSeen);
			}
			if (GetRelationship(m_hLastSeen) == "enemy")
			{
				string NME_POS = "get";
				string NME_DIST = Distance(NME_POS, GetMonsterProperty("origin"));
				if (NME_DIST < MAX_RANGE)
				{
					string SPELL_TARG = GetEntityOrigin(m_hLastSeen);
				}
				if (NME_DIST > MAX_RANGE)
				{
					string SPELL_TARG = /* TODO: $relpos */ $relpos(0, 200, 0);
				}
			}
			if (SPELL_TARG == "SPELL_TARG")
			{
				string SPELL_TARG = /* TODO: $relpos */ $relpos(0, 10, 50);
			}
			EmitSound(GetOwner(), 0, SOUND_STEAM, 10);
			SpawnNPC("monsters/summon/npc_poison_cloud2", SPELL_TARG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), POISON_CLOUD_DAMAGE, POISON_CLOUD_DURATION
		}
		if (OUT_SPELL == "snow_ball")
		{
			if ((false))
			{
				string SPELL_TARG = GetEntityOrigin(m_hLastSeen);
			}
			if (SPELL_TARG == "SPELL_TARG")
			{
				string SPELL_TARG = /* TODO: $relpos */ $relpos(0, 640, 0);
			}
			string AIM_ANGLE = Distance(GetMonsterProperty("origin"), SPELL_TARG);
			AIM_ANGLE /= AIM_RATIO;
			SetAngles("add_view.x");
			EmitSound(GetOwner(), 0, SOUND_SNOWBALL, 10);
			TossProjectile("proj_snow_ball", /* TODO: $relpos */ $relpos(0, 52, 8), SPELL_TARG, 300, SNOWBALL_DAMAGE, 2, "none");
		}
		if (OUT_SPELL == "freezing_sphere")
		{
			string BALL_DEST = /* TODO: $relpos */ $relpos(0, 2000, 0);
			EmitSound(GetOwner(), 0, SOUND_ICEBLAST, 10);
			SpawnNPC("monsters/summon/ice_blast", /* TODO: $relpos */ $relpos(0, 64, 32), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10.0, BALL_DEST
		}
		if (OUT_SPELL == "volcano")
		{
			if ((false))
			{
				string pos = GetEntityOrigin(m_hLastSeen);
			}
			if (GetRelationship(m_hLastSeen) == "enemy")
			{
				string pos = GetEntityOrigin(m_hLastSeen);
			}
			if (!(false))
			{
				if (Distance(GetMonsterProperty("origin"), pos) > MAX_RANGE)
				{
				}
				Vector3 pos = Vector3(0, 0, 0);
				pos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 500, 0));
				string pos = TraceLine(GetMonsterProperty("origin"), pos);
			}
			string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
			string x = (pos).x;
			string y = (pos).y;
			Vector3 pos = Vector3(x, y, temp);
			SetGlobalVar("VOLCANO_DMG", 2);
			string VOLCANO_DURATION = SPELL_FREQ;
			VOLCANO_DURATION *= 6;
			SpawnNPC("monsters/summon/npc_volcano", pos, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 150, VOLCANO_DURATION
			ACTIVE_VOLCANO += 1;
			VOLCANO_DURATION("reset_active_volcano");
		}
		if (OUT_SPELL == "fire_wall")
		{
			if ((false))
			{
				string pos = GetEntityOrigin(m_hLastSeen);
			}
			if (GetRelationship(m_hLastSeen) == "enemy")
			{
				string pos = GetEntityOrigin(m_hLastSeen);
			}
			if (!(false))
			{
				if (Distance(pos, GetMonsterProperty("origin")) > MAX_RANGE)
				{
				}
				string pos = /* TODO: $relpos */ $relpos(0, 256, 0);
			}
			EmitSound(GetOwner(), 0, SOUND_FIRE_WALL, 10);
			string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
			string x = (pos).x;
			string y = (pos).y;
			Vector3 pos = Vector3(x, y, temp);
			int SET_DAMAGE = 80;
			string SET_DURATION = SPELL_FREQ;
			SpawnNPC("monsters/summon/keledros_fire_wall", pos, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), SET_DAMAGE, SET_DURATION
		}
		if (OUT_SPELL == "acid_bolt")
		{
			FIRE_AT = "unset";
			DO_ACID_BOLTS = 1;
			SPOTTING = 1;
			DO_DAMAGE_SITE = 0;
			spot_targets();
			ScheduleDelayedEvent(2.0, "stop_spotting");
			ScheduleDelayedEvent(2.0, "reset_acid_bolt");
		}
		if (OUT_SPELL == "chain_lightning")
		{
			FIRE_AT = "unset";
			DO_LIGHTNING = 1;
			SPOTTING = 1;
			DO_DAMAGE_SITE = 0;
			spot_targets();
			Effect("beam", "update", BEAM_ID, "brightness", 150);
			ScheduleDelayedEvent(3.0, "stop_spotting");
			ScheduleDelayedEvent(3.0, "reset_lightning");
		}
		CASTING_SPELL_DELAY = 0;
		OUTSPELL = "unset";
	}

	void reset_lightning()
	{
		DO_LIGHTNING = 0;
		Effect("beam", "update", BEAM_ID, "brightness", 0);
		Effect("beam", "update", BEAM_ID, "end_target", GetOwner(), 2);
	}

	void reset_acid_bolt()
	{
		DO_ACID_BOLTS = 0;
	}

	void stop_spotting()
	{
		SPOTTING = 0;
	}

	void reset_poison_site()
	{
		POISON_SITE = 0;
	}

	void spot_targets()
	{
		if (!(SPOTTING)) return;
		ScheduleDelayedEvent(0.1, "spot_targets");
		DO_DAMAGE_SITE += 1;
		if (DO_DAMAGE_SITE > 10)
		{
			DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 2048, 0, 1.0, 0);
		}
		if (!(false)) return;
		string OLD_FIRE_AT = FIRE_AT;
		FIRE_AT = GetEntityIndex(m_hLastSeen);
		if ((DO_ACID_BOLTS))
		{
			throw_acid_bolt();
		}
		if ((DO_LIGHTNING))
		{
			throw_lightning();
			if (OLD_FIRE_AT != FIRE_AT)
			{
			}
			LogDebug("spot_targets beam [ BEAM_ID ] @ GetEntityName(FIRE_AT)");
			Effect("beam", "update", BEAM_ID, "end_target", GetEntityIndex(FIRE_AT), 1);
			Effect("beam", "update", BEAM_ID, "brightness", 255);
		}
		if ((POISON_SITE))
		{
			ApplyEffect(FIRE_AT, "effects/dot_poison", 90.0, GetEntityIndex(GetOwner()), 1.0);
		}
	}

	void throw_lightning()
	{
		if ((BOLT_DELAY)) return;
		BOLT_DELAY = 1;
		ScheduleDelayedEvent(0.1, "reset_bolt_delay");
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		string BEAM_END = GetEntityOrigin(FIRE_AT);
		if (!(/* TODO: $get_takedmg */ $get_takedmg(FIRE_AT, "lightning") != 0)) return;
		DoDamage(FIRE_AT, "direct", LIGHTNING_BOLT_DAMAGE, 1.0, GetOwner());
		if ((GetEntityProperty(FIRE_AT, "haseffect"))) return;
		ApplyEffect(FIRE_AT, "effects/dot_lightning", SHOCK_DURATION, GetEntityIndex(GetOwner()), SHOCK_DAMAGE);
	}

	void throw_acid_bolt()
	{
		if ((BOLT_DELAY)) return;
		BOLT_DELAY = 1;
		ScheduleDelayedEvent(0.2, "reset_bolt_delay");
		TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 10, 10), GetEntityIndex(FIRE_AT), 300, ACID_BOLT_DAMAGE, 1, "none");
	}

	void reset_bolt_delay()
	{
		BOLT_DELAY = 0;
	}

	void game_dodamage()
	{
		if ((POISON_SITE))
		{
			ApplyEffect(param2, "effects/dot_poison", 90.0, GetEntityIndex(GetOwner()), 1.0);
		}
		if ((DO_ACID_BOLTS))
		{
			string CHECK_TARG = GetEntityIndex(param2);
			FIRE_AT = CHECK_TARG;
			throw_acid_bolt();
		}
		if ((DO_LIGHTNING))
		{
			string CHECK_TARG = GetEntityIndex(param2);
			FIRE_AT = CHECK_TARG;
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		Effect("beam", "update", BEAM_ID, "remove", 0);
		if ((AM_GENERIC))
		{
			SetAnimFrameRate(0.1);
			PlayAnim("critical", "dieforward");
			EmitSound(GetOwner(), 0, "x/x_die1.wav", 10);
		}
		if ((AM_GENERIC)) return;
		IR_DEADSKI = 1;
		SetAlive(1);
		SetInvincible(true);
		SetSolid("none");
		SetIdleAnim(ANIM_CAST);
		SetMoveAnim(ANIM_CAST);
		SetFly(true);
		STATUE_ID = FindEntityByName("atholo_statue");
		Effect("glow", GetEntityIndex(STATUE_ID), Vector3(255, 0, 0), 255, 5, 5);
		SetProp(GetOwner(), "solid", 0);
		SetProp(GetOwner(), "movetype", "const.movetype.noclip");
		SetAnimMoveSpeed(200);
		SetMoveDest(GetEntityIndex(STATUE_ID));
		SetSayTextRange(2048);
		SayText("I sacrifice my wretched life to release the greatest evil in this world...");
		MOVE_LASTPOS = GetMonsterProperty("origin");
		ScheduleDelayedEvent(0.1, "cycle_move");
		ScheduleDelayedEvent(6.0, "game_over");
	}

	void cycle_move()
	{
		SetMoveDest(GetEntityIndex(STATUE_ID));
		SetAnimMoveSpeed(200);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(-1, 100, 40));
		ScheduleDelayedEvent(0.2, "cycle_move");
	}

	void game_over()
	{
		SetSayTextRange(2048);
		EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
		CallExternal(STATUE_ID, "spawn_atholo", GetEntityIndex(m_hLastStruck));
		SayText("With my blood I bring you the legendary evil! ATHOLO!");
		UseTrigger("atholo_door");
		SetAlive(0);
		DeleteEntity(GetOwner(), true); // fade out
	}

	void reset_active_volcano()
	{
		ACTIVE_VOLCANO -= 1;
	}

	void OnDamage(int damage) override
	{
		if (!(GetRelationship(param1) == "enemy")) return;
		string INC_DMG = param2;
		BEING_SPLOITED_DMG += INC_DMG;
		INC_DMG *= 0.15;
		THROW_CHANCE += INC_DMG;
		if (GetMonsterHP() < 500)
		{
			if (KILLED_A_PLAYER == 0)
			{
				MURDER_A_PLAYER = 1;
			}
		}
		if (param3 == "holy")
		{
			int DID_THROW = 1;
			SetMoveDest(m_hLastStruck);
			EmitSound(GetOwner(), 0, SOUND_THROW, 10);
			AddVelocity(m_hLastStruck, /* TODO: $relvel */ $relvel(0, 500, 200));
			THROW_CHANCE = 0;
			if (INC_DMG > 200)
			{
			}
			STRUCK_BY_HOLY += 1;
			if (STRUCK_BY_HOLY > 2)
			{
			}
			STRUCK_BY_HOLY = 0;
			DO_HOLY_MSG = 1;
			MURDER_A_PLAYER = 1;
			PRESET_TARGET = 1;
			HOLY_OFFENDER = GetEntityIndex(m_hLastStruck);
		}
		if (RandomInt(1, 100) <= THROW_CHANCE)
		{
			if (!(DID_THROW))
			{
			}
			if (GetEntityRange(m_hLastStruck) < 200)
			{
			}
			SetMoveDest(m_hLastStruck);
			EmitSound(GetOwner(), 0, SOUND_THROW, 10);
			AddVelocity(m_hLastStruck, /* TODO: $relvel */ $relvel(0, 500, 200));
			THROW_CHANCE = 0;
		}
		if ((SPLOITED_CHECKED)) return;
		SPLOITED_CHECKED = 1;
		ScheduleDelayedEvent(5.0, "check_if_sploited");
	}

	void check_if_sploited()
	{
		if (BEING_SPLOITED_DMG > BEING_SPLOITED_THRESHOLD)
		{
			MURDER_A_PLAYER = 1;
		}
		BEING_SPLOITED_DMG = 0;
		SPLOITED_CHECKED = 0;
	}

	void kill_a_player()
	{
		TELED_OUT = 1;
		KILLED_A_PLAYER = 1;
		EmitSound(GetOwner(), 0, SOUND_BOOM, 10);
		SayText("Oh me oh my , where did he go...");
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
		if (!(PRESET_TARGET))
		{
			THIS_MUST_DIE = GetEntityIndex(m_hLastStruck);
		}
		if ((PRESET_TARGET))
		{
			THIS_MUST_DIE = HOLY_OFFENDER;
			PRESET_TARGET = 0;
		}
		CHANGE_RETURN_POINT = 0;
		ScheduleDelayedEvent(8.0, "murder_return");
		scan_for_death();
	}

	void scan_for_death()
	{
		if (!(TELED_OUT)) return;
		if (!(IsEntityAlive(THIS_MUST_DIE)))
		{
			CHANGE_RETURN_POINT = 1;
		}
		string KILL_TARG_ORIGIN = GetEntityOrigin(THIS_MUST_DIE);
		if (Distance(KILL_TARG_ORIGIN, NPC_SPAWN_LOC) > MAX_TELE_RANGE)
		{
			CHANGE_RETURN_POINT = 1;
		}
		if ((CHANGE_RETURN_POINT)) return;
		ScheduleDelayedEvent(0.1, "scan_for_death");
	}

	void murder_return()
	{
		TELED_OUT = 0;
		MURDER_A_PLAYER = 0;
		SPELL_SELECT = 0;
		if ((DO_HOLY_MSG))
		{
			DO_HOLY_MSG = 0;
			SendInfoMsg("all", "BEWARE! Venevus uses death magic to counter holy magic!");
		}
		EmitSound(GetOwner(), 0, SOUND_BOOM, 10);
		Effect("screenfade", "all", 3, 1, Vector3(255, 255, 255), 255, "fadein");
		string RETURN_POINT = GetEntityOrigin(THIS_MUST_DIE);
		if ((CHANGE_RETURN_POINT))
		{
			string RETURN_POINT = NPC_SPAWN_LOC;
		}
		if (!(CHANGE_RETURN_POINT))
		{
			ScheduleDelayedEvent(0.1, "kill_target");
		}
		SetEntityOrigin(GetOwner(), RETURN_POINT);
		ScheduleDelayedEvent(0.2, "murder_done");
	}

	void murder_done()
	{
		SetSayTextRange(2048);
		SayText("Who's next?");
		EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
	}

	void kill_target()
	{
		string TARGET_ORG = GetEntityOrigin(THIS_MUST_DIE);
		if (!(Distance(GetMonsterProperty("origin"), TARGET_ORG) < 100)) return;
		if (!(IsEntityAlive(THIS_MUST_DIE))) return;
		DoDamage(THIS_MUST_DIE, "direct", 10000, 1.0, GetOwner());
		ScheduleDelayedEvent(0.11, "kill_target");
	}

	void stuck_checks()
	{
		if (Distance(GetMonsterProperty("origin"), LAST_STUCK_CHECK_POS) == 0)
		{
			MURDER_A_PLAYER = 1;
		}
		LAST_STUCK_CHECK_POS = GetMonsterProperty("origin");
		ScheduleDelayedEvent(25.0, "stuck_checks");
	}

	void init_beam()
	{
		Effect("beam", "ents", LIGHTNING_SPRITE, 80, GetOwner(), 1, GetOwner(), 2, Vector3(255, 255, 255), 0, 50, -1);
		BEAM_ID = GetEntityIndex(m_hLastCreated);
	}

	void die_fast()
	{
		SetHealth(10);
	}

}

}
