#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Keledros : CGameScript
{
	int ALLOW_CHANGE;
	int AM_SKELE;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_CONE_OF_FIRE;
	int ATTACK_DMG_HIGH;
	int ATTACK_DMG_LOW;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int ATTACK_SPEED;
	int CANT_TRACK;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_HEAR;
	int CAN_HUNT;
	string CAN_RETALIATE;
	string DID_ALE_INTRO;
	int FIRE_BALL_DELAY;
	int FIRE_PULSE;
	int FIRE_PULSE_DELAY;
	int FLEE_CHANCE;
	int FLEE_DISTANCE;
	int FLEE_HEALTH;
	int INTRODUCED;
	int IS_UNHOLY;
	int I_DIED;
	string KSPELL_TARGET;
	string LIGHTNING_SPRITE;
	int MOVE_RANGE;
	string NEXT_TARGET;
	string NEXT_TARGET_ID;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string NPC_MOVE_TARGET;
	string PLAYING_DEAD;
	int REBUKE_DELAY;
	string REBUKE_TARGET;
	float RETALIATE_CHANCE;
	int RETAL_DELAY;
	string RE_REBUKING;
	int SCANNING_TARGETS;
	string SOUND_ATTACK1;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int SPAWNED;
	string START_TARG;
	int TOTAL_GUARDS;
	int kele.recharging;

	Keledros()
	{
		const int I_AM_TURNABLE = 0;
		if ((StringToLower(GetMapName())).findFirst("keledros") == 0)
		{
			NPC_IS_BOSS = 1;
		}
		const float NPC_BOSS_REGEN_RATE = 0.1;
		const float NPC_BOSS_RESTORATION = 0.5;
		IS_UNHOLY = 1;
		const int NPC_HEARDSOUND_OVERRIDE = 1;
		const int NPC_AUTO_DEATH = 0;
		const float SKEL_RESPAWN_CHANCE = 1.0;
		const int SKEL_RESPAWN_LIVES = 1;
		SetGlobalVar("DEAD_GUARDS", 2);
		TOTAL_GUARDS = 2;
		SetGlobalVar("TWO_IS_DEAD", 1);
		SetGlobalVar("THREE_IS_DEAD", 1);
		SetGlobalVar("FOUR_IS_DEAD", 1);
		ATTACK_HITCHANCE = 0.0;
		NPC_GIVE_EXP = 500;
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_ATTACK = "castspell";
		const string ANIM_RESPAWN_DEADIDLE = "lying_on_stomach";
		const int SKEL_HP = 2750;
		const string CAST_SCRIPT = "keledrosruins/keledros_cl_cast";
		const int HIGHER_THAN_ME_THRESHOLD = 140;
		const int AIM_RATIO = 80;
		INTRODUCED = 0;
		ALLOW_CHANGE = 0;
		MOVE_RANGE = 30;
		ATTACK_RANGE = 2000;
		ATTACK_HITRANGE = 130;
		const string SOUND_STRUCK1 = "voices/human/male_hit2.wav";
		const string SOUND_STRUCK2 = "voices/human/male_hit1.wav";
		const string SOUND_STRUCK3 = "voices/human/male_hit3.wav";
		const string SOUND_STRUCK4 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK5 = "weapons/cbar_hitbod1.wav";
		const string SOUND_ATTACK1 = "none";
		const string SOUND_ATTACK2 = "none";
		const string SOUND_DEATH = "voices/human/male_die.wav";
		const string SOUND_BOOM = "monsters/bear/giantbearstep2.wav";
		const string SOUND_POISON = "x/x_laugh1.wav";
		CAN_HUNT = 0;
		CAN_ATTACK = 0;
		NPC_MOVE_TARGET = "enemy";
		RETALIATE_CHANCE = 0.85;
		CAN_FLEE = 0;
		LIGHTNING_SPRITE = "lgtning.spr";
		const float SPELL_FREQ = 7.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1);
		if (ALLOW_CHANGE == 1)
		{
		}
		if (!(PLAYING_DEAD))
		{
		}
		string DIST = GetEntityDist(m_hLastSeen);
		if (DIST < 300)
		{
			ANIM_ATTACK = "attack1";
			MOVE_RANGE = 150;
			ATTACK_RANGE = 175;
		}
		if (DIST > 300)
		{
			ANIM_ATTACK = "attack2";
			MOVE_RANGE = 500;
			ATTACK_RANGE = 600;
		}
	}

	void game_precache()
	{
		Precache("items/proj_fire_ball");
		Precache("items/proj_fire_dart");
		Precache(LIGHTNING_SPRITE);
		Precache("monsters/animarmor.mdl");
		Precache("body/armour1.wav");
		Precache("body/armour2.wav");
		Precache("body/armour3.wav");
		Precache("misc/gold.wav");
	}

	void OnSpawn() override
	{
		SetHealth(SKEL_HP);
		if (!(AM_GENERIC))
		{
			SetName("The Insane Wizard, Keledros");
		}
		if ((AM_GENERIC))
		{
			SetName("Insane Wizard");
		}
		SetFOV(359);
		SetWidth(40);
		SetHeight(80);
		SetRoam(false);
		SetRace("demon");
		SetNoPush(true);
		SetModel("monsters/keledros.mdl");
		SetStepSize(16);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		SetHearingSensitivity(11);
		npcatk_suspend_ai();
		SetDamageResistance("slash", 1);
		SetDamageResistance("pierce", 1);
		SetDamageResistance("blunt", 1);
		SetDamageResistance("fire", 1);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("cold", 0.2);
		if ((AM_GENERIC))
		{
			ScheduleDelayedEvent(0.1, "go_intro");
		}
		if ((AM_GENERIC)) return;
		SetAngles("face");
		scan_for_players();
		SetInvincible(true);
	}

	void scan_for_players()
	{
		if ((INTRODUCED)) return;
		ScheduleDelayedEvent(0.1, "scan_for_players");
		string PLAYER_ID = /* TODO: $get_insphere */ $get_insphere("player", 384);
		if ((IsValidPlayer(PLAYER_ID)))
		{
			npcatk_target(PLAYER_ID);
			go_intro();
		}
		if (!(CanSee("player", 384))) return;
		npcatk_target(GetEntityIndex(m_hLastSeen));
		go_intro();
	}

	void go_intro()
	{
		if ((INTRODUCED)) return;
		INTRODUCED = 1;
		SetSayTextRange(2048);
		if (!(AM_GENERIC))
		{
			SayText("What's this? Visitors?");
		}
		ScheduleDelayedEvent(2.5, "start_it_up_yo");
		int EXIT_SUB = 1;
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((IsValidPlayer("ent_lastheard")))
		{
			if ((SCANNING_TARGETS))
			{
			}
			NEXT_TARGET = GetEntityOrigin("ent_lastheard");
			NEXT_TARGET_ID = GetEntityIndex("ent_lastheard");
		}
		if ((I_DIED))
		{
			if (GetEntityRange(m_hAttackTarget) > GetEntityRange("ent_lastheard"))
			{
			}
			npcatk_target(GetEntityIndex("ent_lastheard"));
		}
		if ((INTRODUCED)) return;
		if (!(IsValidPlayer("ent_lastheard"))) return;
		SetMoveDest("ent_lastheard");
		if (!(GetEntityRange("ent_lastheard") < 450)) return;
		npcatk_target(GetEntityIndex("ent_lastheard"));
		go_intro();
	}

	void start_it_up_yo()
	{
		SetMoveAnim(ANIM_WALK);
		SCANNING_TARGETS = 1;
		ScheduleDelayedEvent(1.0, "scan_targets");
		SPELL_FREQ("do_spells");
		npcatk_resume_ai();
		UseTrigger("lights");
		if (!(AM_GENERIC))
		{
			SayText("Please do stay for some...games.");
		}
		CAN_HUNT = 1;
		ANIM_ATTACK = "castspell";
		SetRoam(true);
		SetInvincible(false);
		PlayAnim("once", ANIM_ATTACK);
		START_TARG = GetEntityIndex("ent_lastheard");
		CANT_TRACK = 1;
		CAN_HEAR = 0;
		MOVE_RANGE = 30;
		SetMoveDest(/* TODO: $relpos */ $relpos(0, 600, 0));
		ScheduleDelayedEvent(10.0, "start_wander");
	}

	void scan_targets()
	{
		if (!(SCANNING_TARGETS)) return;
		if (!(false)) return;
		NEXT_TARGET = GetEntityOrigin(m_hLastSeen);
		NEXT_TARGET_ID = GetEntityIndex(m_hLastSeen);
		ScheduleDelayedEvent(0.5, "scan_targets");
	}

	void start_wander()
	{
		MOVE_RANGE = 10000;
	}

	void do_spells()
	{
		SPELL_FREQ("do_spells");
		if ((I_DIED)) return;
		if ((SUSPEND_AI)) return;
		SCANNING_TARGETS = 0;
		SetMoveDest(NEXT_TARGET);
		PlayAnim("once", ANIM_ATTACK);
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
		if ((I_DIED)) return;
		if (!(SKEL_RESPAWN_TIMES < 1)) return;
		SCANNING_TARGETS = 1;
		if (RE_REBUKING == 1)
		{
			RE_REBUKING = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string random = RandomInt(0, 3);
		if (random == 3)
		{
			if ((SPAWNED))
			{
				string random = RandomInt(0, 2);
			}
			if (DEAD_GUARDS < TOTAL_GUARDS)
			{
				string random = RandomInt(0, 2);
			}
		}
		string pos = NEXT_TARGET;
		string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
		string x = (pos).x;
		string y = (pos).y;
		Vector3 pos = Vector3(x, y, temp);
		string ME_POS = GetEntityOrigin(GetOwner());
		string MY_Z = (ME_POS).z;
		string TARGET_POS = GetEntityOrigin(HUNT_LASTTARGET);
		string TARGET_Z = (TARGET_POS).z;
		string TARGET_Z_DIFFERENCE = TARGET_Z;
		KSPELL_TARGET = HUNT_LASTTARGET;
		TARGET_Z_DIFFERENCE -= MY_Z;
		if (Distance(GetMonsterProperty("origin"), pos) < 1024)
		{
			int VALID_CON = 1;
		}
		if ((false))
		{
			int VALID_CON = 1;
		}
		if (!(VALID_CON)) return;
		int TARGET_HIGHER_THAN_ME = 0;
		if (TARGET_Z_DIFFERENCE > HIGHER_THAN_ME_THRESHOLD)
		{
			int TARGET_HIGHER_THAN_ME = 1;
		}
		if (!(TARGET_HIGHER_THAN_ME))
		{
			string EFFECT_SCRIPT = "effects/sfx_lightning";
			if (random == 0)
			{
				string EFFECT_SCRIPT = "monsters/summon/summon_blizzard";
				int SET_DAMAGE = 10;
				int SET_DURATION = 5;
				EmitSound(GetOwner(), CHAN_VOICE, "magic/ice_strike.wav", "game.sound.maxvol");
			}
			if (random == 1)
			{
				string EFFECT_SCRIPT = "monsters/summon/keledros_fire_wall";
				int SET_DAMAGE = 40;
				int SET_DURATION = 10;
				EmitSound(GetOwner(), CHAN_VOICE, "magic/fireball_strike.wav", "game.sound.maxvol");
			}
			if (random == 2)
			{
				string EFFECT_SCRIPT = "monsters/summon/summon_lightning_storm";
				int SET_DAMAGE = 20;
				int SET_DURATION = 10;
				EmitSound(GetOwner(), CHAN_VOICE, "magic/lightning_strike.wav", "game.sound.maxvol");
			}
			if (random == 3)
			{
				SetSayTextRange(1000);
				SayText("Come forth my undead minions!");
				SetSayTextRange(768);
				EmitSound(GetOwner(), CHAN_VOICE, "magic/heal_powerup.wav", "game.sound.maxvol");
				CallExternal(FindEntityByName("spawner5"), "make_undead");
				CallExternal(FindEntityByName("spawner6"), "make_undead");
				SetGlobalVar("DEAD_GUARDS", 0);
				CallExternal(FindEntityByName("spawner1"), "make_undead");
				CallExternal(FindEntityByName("spawner2"), "make_undead");
				CallExternal(FindEntityByName("spawner3"), "make_undead");
				CallExternal(FindEntityByName("spawner4"), "make_undead");
				UseTrigger("spawn_archers");
				SPAWNED = 1;
				ScheduleDelayedEvent(20, "allow_spawn");
			}
		}
		if (!(TARGET_HIGHER_THAN_ME))
		{
			if (!(I_DIED))
			{
				SpawnNPC(EFFECT_SCRIPT, pos, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), SET_DAMAGE, SET_DURATION
			}
		}
		if ((TARGET_HIGHER_THAN_ME))
		{
			SetSayTextRange(2048);
			SayText("No use hiding up there!");
			string ALT_SPELL_CHOICE = RandomInt(1, 2);
			if (ALT_SPELL_CHOICE == 1)
			{
				string AIM_ANGLE = GetEntityDist(m_hLastSeen);
				AIM_ANGLE /= AIM_RATIO;
				SetAngles("add_view.x");
				TossProjectile("proj_fire_ball", /* TODO: $relpos */ $relpos(0, 10, 35), "none", 1000, 400, 1, "none");
			}
			if (ALT_SPELL_CHOICE == 2)
			{
				SetVolume(10);
				EmitSound(GetOwner(), "debris/beamstart15.wav");
				Effect("beam", "point", LIGHTNING_SPRITE, 200, /* TODO: $relpos */ $relpos(0, 0, 0), GetEntityOrigin(KSPELL_TARGET), Vector3(255, 255, 0), 150, 50, 0.5);
				DoDamage(KSPELL_TARGET, "direct", 200, 100, GetOwner());
				ApplyEffect(HUNT_LASTTARGET, "effects/dot_lightning", 10, GetEntityIndex(GetOwner()), 10);
			}
		}
		ClientEvent("new", "all", CAST_SCRIPT, GetEntityIndex(GetOwner()), 15, 2);
		ClientEvent("new", "all", CAST_SCRIPT, GetEntityIndex(GetOwner()), 19, 2);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5
		array<string> sounds = {"game.sound.maxvol", SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(true)) return;
		I_DIED = 1;
		ANIM_ATTACK = "lying_on_stomach";
		if (!(AM_SKELE))
		{
			if (!(AM_GENERIC))
			{
				SayText("This isn't the end!");
			}
			string L_DEATHANIM = RandomInt(0, 1);
			ANIM_DEATH = "diesimple";
			if (L_DEATHANIM == 1)
			{
				ANIM_DEATH = "dieforward";
			}
			PlayAnim("hold", ANIM_DEATH);
			SetAlive(1);
			SetMoveDest("none");
			SetIdleAnim(ANIM_RESPAWN_DEADIDLE);
			SetInvincible(true);
			SetRoam(false);
			CAN_ATTACK = 0;
			CAN_HUNT = 0;
			CAN_RETALIATE = 0;
			CAN_HEAR = 1;
			PLAYING_DEAD = 1;
			ScheduleDelayedEvent(7.0, "skel_respawn");
		}
		if ((AM_SKELE))
		{
			PlayAnim("critical", ANIM_DEATH);
			UseTrigger("wizard_died");
			string L_MAP_NAME = StringToLower(GetMapName());
			if (L_MAP_NAME == "keledrosruins")
			{
				int DO_DROP = 1;
			}
			if (L_MAP_NAME == "aleyesu")
			{
				int DO_DROP = 1;
			}
			if ((DO_DROP))
			{
				SpawnNPC("chests/keledros", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy);
			}
			if (!(AM_GENERIC))
			{
			}
			string L_MAP_NAME = StringToLower(GetMapName());
			if (L_MAP_NAME == "keledrosruins")
			{
				string T_SPAWN = GetMonsterProperty("origin");
				T_SPAWN += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 100, 40));
				SpawnNPC("chests/bag_o_gold_25", T_SPAWN, ScriptMode::Legacy);
				string T_SPAWN = GetMonsterProperty("origin");
				T_SPAWN += /* TODO: $relpos */ $relpos(Vector3(0, 45, 0), Vector3(0, 100, 40));
				SpawnNPC("chests/bag_o_gold_25", T_SPAWN, ScriptMode::Legacy);
				string T_SPAWN = GetMonsterProperty("origin");
				T_SPAWN += /* TODO: $relpos */ $relpos(Vector3(0, 90, 0), Vector3(0, 100, 40));
				SpawnNPC("chests/bag_o_gold_25", T_SPAWN, ScriptMode::Legacy);
				string T_SPAWN = GetMonsterProperty("origin");
				T_SPAWN += /* TODO: $relpos */ $relpos(Vector3(0, 135, 0), Vector3(0, 100, 40));
				SpawnNPC("chests/bag_o_gold_50", T_SPAWN, ScriptMode::Legacy);
				string T_SPAWN = GetMonsterProperty("origin");
				T_SPAWN += /* TODO: $relpos */ $relpos(Vector3(0, 180, 0), Vector3(0, 100, 40));
				SpawnNPC("chests/bag_o_gold_50", T_SPAWN, ScriptMode::Legacy);
				string T_SPAWN = GetMonsterProperty("origin");
				T_SPAWN += /* TODO: $relpos */ $relpos(Vector3(0, 225, 0), Vector3(0, 100, 40));
				SpawnNPC("chests/bag_o_gold_25", T_SPAWN, ScriptMode::Legacy);
				string T_SPAWN = GetMonsterProperty("origin");
				T_SPAWN += /* TODO: $relpos */ $relpos(Vector3(0, 270, 0), Vector3(0, 100, 40));
				SpawnNPC("chests/bag_o_gold_25", T_SPAWN, ScriptMode::Legacy);
				string T_SPAWN = GetMonsterProperty("origin");
				T_SPAWN += /* TODO: $relpos */ $relpos(Vector3(0, 315, 0), Vector3(0, 100, 40));
				SpawnNPC("chests/bag_o_gold_25", T_SPAWN, ScriptMode::Legacy);
			}
		}
	}

	void skel_respawn()
	{
		AM_SKELE = 1;
		CANT_TRACK = 0;
		SetModel("monsters/skeleton3.mdl");
		SetDamageResistance("slash", ".7");
		SetDamageResistance("pierce", ".5");
		SetDamageResistance("blunt", 1.2);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("all", 0.7);
		if (!(AM_GENERIC))
		{
			SetName("The animated remains of Keledros");
		}
		SetHearingSensitivity(11);
		ATTACK_HITCHANCE = 0.85;
		ATTACK_DMG_LOW = 15;
		ATTACK_DMG_HIGH = 30;
		MOVE_RANGE = 150;
		ATTACK_RANGE = 175;
		ATTACK_HITRANGE = 200;
		ANIM_RUN = "walk";
		ANIM_ATTACK = "attack1";
		ATTACK_SPEED = 1000;
		ATTACK_CONE_OF_FIRE = 6;
		ALLOW_CHANGE = 1;
		SOUND_STRUCK1 = "zombie/zo_pain2.wav";
		SOUND_STRUCK2 = "zombie/zo_pain2.wav";
		SOUND_STRUCK3 = "zombie/zo_pain2.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_DEATH = "x/x_die1.wav";
		SetSkillLevel(NPC_GIVE_EXP);
		Precache(SOUND_DEATH);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		PlayAnim("critical", "getup");
		SetSolid("box");
		SKEL_RESPAWN_TIMES += 1;
		SetHealth(SKEL_HP);
		ScheduleDelayedEvent(2.5, "skel_respawn_revived");
	}

	void skel_respawn_revived()
	{
		PLAYING_DEAD = 0;
		SetMoveDest(HUNT_LASTTARGET);
		SetRoam(true);
		SetInvincible(false);
		CAN_ATTACK = 1;
		CAN_HUNT = 1;
		CAN_RETALIATE = 1;
		CAN_HEAR = 1;
		CAN_FLEE = 1;
		kele.recharging = 0;
		FLEE_HEALTH = 0;
		FLEE_CHANCE = 1;
		FLEE_DISTANCE = 4096;
		SayText("You can't defeat me so easily!");
		string MAP_NAME = StringToLower(GetMapName());
	}

	void attack_1()
	{
		string L_DMG = Random(ATTACK_DMG_LOW, ATTACK_DMG_HIGH);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, L_DMG, ATTACK_HITCHANCE, "slash");
	}

	void npc_targetsighted()
	{
		if (!(AM_SKELE)) return;
		if ((FIRE_BALL_DELAY)) return;
		FIRE_BALL_DELAY = 1;
		ScheduleDelayedEvent(2.0, "reset_fire_delay");
		if (!(GetEntityRange(param1) > 128)) return;
		AS_ATTACKING = GetGameTime();
		PlayAnim("once", "attack2");
	}

	void reset_fire_delay()
	{
		FIRE_BALL_DELAY = 0;
	}

	void attack_2()
	{
		string LCL_ATKDMG = Random(ATTACK_DMG_LOW, ATTACK_DMG_HIGH);
		string ATTACK_TYPE = RandomInt(1, 2);
		if (ATTACK_TYPE == 1)
		{
			TossProjectile("proj_fire_dart", /* TODO: $relpos */ $relpos(0, 10, 35), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
			TossProjectile("proj_fire_dart", /* TODO: $relpos */ $relpos(0, 10, 35), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
			TossProjectile("proj_fire_dart", /* TODO: $relpos */ $relpos(0, 10, 35), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
			TossProjectile("proj_fire_dart", /* TODO: $relpos */ $relpos(0, 10, 35), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
		}
		if (ATTACK_TYPE == 2)
		{
			TossProjectile("proj_fire_ball", /* TODO: $relpos */ $relpos(0, 10, 35), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
		}
		ANIM_ATTACK = "attack1";
		MOVE_RANGE = 150;
		ATTACK_RANGE = 175;
		ALLOW_CHANGE = 0;
		ScheduleDelayedEvent(2, "allow_change");
	}

	void allow_change()
	{
		ALLOW_CHANGE = 1;
	}

	void allow_spawn()
	{
		SPAWNED = 0;
	}

	void turn_undead()
	{
		if (!(GetMonsterProperty("isalive"))) return;
		if ((AM_SKELE)) return;
		if ((REBUKE_DELAY)) return;
		REBUKE_DELAY = 1;
		ScheduleDelayedEvent(2.0, "reset_rebuke_delay");
		string THE_EXCORCIST = param2;
		RE_REBUKING = 1;
		PlayAnim("once", "castspell");
		SetMoveDest(GetEntityIndex(THE_EXCORCIST));
		SetSayTextRange(1024);
		SayText("Your so-called 'divine' magics shall only get you burned!");
		REBUKE_TARGET = THE_EXCORCIST;
		ScheduleDelayedEvent(1, "rebuke_rebuker");
	}

	void reset_rebuke_delay()
	{
		REBUKE_DELAY = 0;
	}

	void rebuke_rebuker()
	{
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_POISON, 10);
		string ALT_SPELL_CHOICE = RandomInt(1, 2);
		if (ALT_SPELL_CHOICE == 1)
		{
			string ALT_SPELL_CHOICE = RandomInt(1, 2);
			string AIM_ANGLE = GetEntityDist(REBUKE_TARGET);
			AIM_ANGLE /= AIM_RATIO;
			SetAngles("add_view.x");
			TossProjectile("proj_fire_ball", /* TODO: $relpos */ $relpos(0, 10, 5), "none", 1000, 400, 1, "none");
		}
		if (ALT_SPELL_CHOICE == 2)
		{
			SetVolume(10);
			EmitSound(GetOwner(), "debris/beamstart15.wav");
			Effect("beam", "point", LIGHTNING_SPRITE, 200, /* TODO: $relpos */ $relpos(0, 0, 0), GetEntityOrigin(REBUKE_TARGET), Vector3(255, 255, 0), 150, 50, 0.5);
			DoDamage(REBUKE_TARGET, "direct", 200, 100, GetOwner());
			ApplyEffect(param1, "effects/dot_lightning", 10, GetEntityIndex(GetOwner()), 10);
		}
	}

	void OnDamage(int damage) override
	{
		if ((AM_SKELE)) return;
		if (!((param3).findFirst("holy") >= 0)) return;
		if ((RETAL_DELAY)) return;
		string H_ATTACKER = param1;
		RETAL_DELAY = 1;
		SetSayTextRange(1024);
		SayText("Holy weapons call for unholy magic!");
		ScheduleDelayedEvent(6.0, "reset_retal_delay");
		ScheduleDelayedEvent(1.0, "rebuke_rebuker");
	}

	void reset_retal_delay()
	{
		RETAL_DELAY = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		NEXT_TARGET = GetEntityOrigin(m_hLastStruck);
		NEXT_TARGET_ID = GetEntityIndex(m_hLastStruck);
		if ((AM_SKELE))
		{
			if (!(FIRE_PULSE_DELAY))
			{
			}
			if (!(DID_BURST_A))
			{
				if (GetMonsterHP() < 2500)
				{
				}
				if (GetEntityRange(m_hLastStruck) < 256)
				{
				}
				DID_BURST_A = 1;
				ScheduleDelayedEvent(0.1, "fire_pulse");
			}
			if (!(DID_BURST_B))
			{
				if (GetMonsterHP() < 2000)
				{
				}
				if (GetEntityRange(m_hLastStruck) < 256)
				{
				}
				DID_BURST_B = 1;
				ScheduleDelayedEvent(0.1, "fire_pulse");
			}
			if (!(DID_BURST_C))
			{
				if (GetMonsterHP() < 1500)
				{
				}
				if (GetEntityRange(m_hLastStruck) < 256)
				{
				}
				DID_BURST_C = 1;
				ScheduleDelayedEvent(0.1, "fire_pulse");
			}
			if (!(DID_BURST_D))
			{
				if (GetMonsterHP() < 500)
				{
				}
				if (GetEntityRange(m_hLastStruck) < 256)
				{
				}
				DID_BURST_D = 1;
				ScheduleDelayedEvent(0.1, "fire_pulse");
			}
		}
	}

	void fire_pulse()
	{
		if ((FIRE_PULSE_DELAY)) return;
		if (!(GetMonsterHP() > 0)) return;
		FIRE_PULSE_DELAY = 1;
		ScheduleDelayedEvent(5.0, "reset_fire_pulse_delay");
		FIRE_PULSE = 1;
		PlayAnim("critical", "throw_scientist");
		SpawnNPC("monsters/summon/flame_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 20.0
		npcatk_suspend_ai(1);
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 512, 0.0, 1.0, 0.0);
		ScheduleDelayedEvent(0.2, "reset_fire_pulse");
	}

	void reset_fire_pulse_delay()
	{
		FIRE_PULSE_DELAY = 0;
	}

	void reset_fire_pulse()
	{
		FIRE_PULSE = 0;
	}

	void game_dodamage()
	{
		if (!(FIRE_PULSE)) return;
		if (!(GetEntityRange(param2) < 256)) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 800, 800));
	}

}

}
