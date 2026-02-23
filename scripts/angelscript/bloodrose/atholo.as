#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Atholo : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_CAST;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SLASH;
	string ANIM_SMASH;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float BURST_FREQ;
	int CAN_FLINCH;
	string CHOSEN_ONE;
	string DAMAGE_ATTACK1;
	string DAMAGE_ATTACK2;
	int FIREBALL_DELAY;
	string FIREBALL_TARGET;
	int FIRE_ATTACK;
	string FIRE_DAMAGE;
	float FIRE_DURATION;
	string FREEZE_DAMAGE;
	float FREEZE_DURATION;
	string GLOW_COLOR;
	int GLOW_RAD;
	int I_AM_TURNABLE;
	int I_R_GLOWING;
	int MISS_ATTACK;
	string MONSTER_MODEL;
	int MOVE_RANGE;
	string MY_LIGHT_SCRIPT;
	int NO_STEP_ADJ;
	int NPC_ALLY_RESPONSE_RANGE;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int NPC_MUST_SEE_TARGET;
	int REGEN_AMT;
	float REGEN_RATE;
	int ROAM_ON;
	string SKEL_ID;
	string SKEL_LIGHT_ID;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_IDLE;
	string SOUND_PAIN;
	string SOUND_PISSED;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_TAUNT;
	int SWIPES_COUNT;
	string VENGENCE_TARGET;

	Atholo()
	{
		if (StringToLower(GetMapName()) == "bloodrose")
		{
			NPC_GIVE_EXP = 5000;
			NPC_IS_BOSS = 1;
		}
		else
		{
			NPC_GIVE_EXP = 1500;
		}
		const int NPC_BOSS_REGEN_RATE = 0;
		const int NPC_BOSS_RESTORATION = 0;
		REGEN_AMT = 60;
		REGEN_RATE = 5.0;
		const int NPC_BOSS_REGEN_RATE = 0;
		NPC_ALLY_RESPONSE_RANGE = 6000;
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN = "controller/con_pain2.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_PISSED = "garg/gar_die1.wav";
		const string SOUND_DEATH = "garg/gar_die2.wav";
		SOUND_TAUNT = "nihilanth/nil_die.wav";
		SOUND_IDLE = "garg/gar_idle2.wav";
		ATTACK_HITRANGE = 240;
		ATTACK_RANGE = 180;
		MOVE_RANGE = 50;
		ATTACK_MOVERANGE = 64;
		ATTACK_HITCHANCE = 0.9;
		DAMAGE_ATTACK1 = RandomInt(50, 90);
		DAMAGE_ATTACK2 = RandomInt(100, 200);
		FIRE_DAMAGE = RandomInt(50, 100);
		FIRE_DURATION = 5.0;
		FREEZE_DAMAGE = RandomInt(25, 50);
		FREEZE_DURATION = 5.0;
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_SLASH = "attack1";
		ANIM_SMASH = "attack2";
		ANIM_CAST = "castspell";
		ANIM_DEATH = "dieforward";
		NO_STEP_ADJ = 1;
		BURST_FREQ = 15.0;
		Precache(SOUND_DEATH);
		MONSTER_MODEL = "monsters/skeleton_boss2.mdl";
		Precache(MONSTER_MODEL);
		I_AM_TURNABLE = 0;
		MISS_ATTACK = 0;
		NPC_MUST_SEE_TARGET = 0;
		GLOW_COLOR = Vector3(255, 255, 128);
		GLOW_RAD = 200;
		const int NO_LOOP_DETECT = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(REGEN_RATE);
		if (GetMonsterHP() < GetMonsterMaxHP())
		{
		}
		string HP_GIVE = REGEN_AMT;
		string GIVE_TEST = GetMonsterMaxHP();
		GIVE_TEST -= REGEN_AMT;
		if (GetMonsterHP() < GIVE_TEST)
		{
		}
		HealEntity(GetOwner(), REGEN_AMT);
		EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 96, 1, 1);
	}

	void game_precache()
	{
		Precache("kfortress/nh_appear_cl");
	}

	void game_dynamically_created()
	{
		SetAngles("face");
		VENGENCE_TARGET = param2;
		ScheduleDelayedEvent(0.1, "set_vengence");
	}

	void set_vengence()
	{
		if (GetEntityRange(VENGENCE_TARGET) < 2048)
		{
			npcatk_settarget(VENGENCE_TARGET);
		}
	}

	void OnSpawn() override
	{
		SetName("boss_atholo");
		SetName("|Atholo");
		SetInvincible(true);
		SetHealth(7000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("dark", 0.75);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.2);
		SetDamageResistance("lightning", 0.5);
		SetWidth(40);
		SetHeight(128);
		SetRace("undead");
		SetRoam(false);
		SetHearingSensitivity(6);
		SetModel(MONSTER_MODEL);
		SetModelBody(0, 9);
		SetModelBody(1, 6);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ANIM_ATTACK = "attack1";
		SetMoveSpeed(1.0);
		SetStepSize(64);
		// TODO: UNCONVERTED: maxslope 90
		EmitSound(GetOwner(), 0, SOUND_TAUNT, 10);
		SWIPES_COUNT = 0;
		ScheduleDelayedEvent(2.0, "rt_adj_stepsize");
		ScheduleDelayedEvent(30.0, "return_home");
	}

	void rt_adj_stepsize()
	{
		ScheduleDelayedEvent(2.0, "rt_adj_stepsize");
		if (!(IsValidPlayer(HUNT_LASTTARGET))) return;
		string MY_ORG = GetMonsterProperty("origin");
		string MY_Z = (MY_ORG).z;
		string TARG_ORG = GetEntityOrigin(HUNT_LASTTARGET);
		string TARG_Z = (TARG_ORG).z;
		TARG_Z += PLAYER_HALF_HEIGHT;
		int DIFF = 0;
		if (TARG_Z > MY_Z)
		{
			string DIFF = TARG_Z;
			DIFF -= MY_Z;
		}
		if (TARG_Z < MY_Z)
		{
			string DIFF = MY_Z;
			DIFF -= TARG_Z;
		}
		if (DIFF > 64)
		{
			SetStepSize(300);
		}
		if (DIFF <= 64)
		{
			SetStepSize(64);
		}
	}

	void attack_1()
	{
		MISS_ATTACK += 1;
		if (MISS_ATTACK > 5)
		{
			MISS_ATTACK = 0;
			chicken_run(3.0);
		}
		if (GetEntityRange(HUNT_LASTTARGET) < ATTACK_HITRANGE)
		{
			XDoDamage(HUNT_LASTTARGET, "direct", DAMAGE_ATTACK1, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner()), "none", "slash", "dmgevent:swing");
		}
		FIRE_ATTACK = 1;
		SWIPES_COUNT += 1;
		if (!(SWIPES_COUNT > 20)) return;
		SWIPES_COUNT = 0;
		ANIM_ATTACK = ANIM_SMASH;
	}

	void attack_2()
	{
		MISS_ATTACK += 1;
		if (MISS_ATTACK > 5)
		{
			MISS_ATTACK = 0;
			chicken_run(3.0);
		}
		if (GetEntityRange(HUNT_LASTTARGET) < ATTACK_HITRANGE)
		{
			XDoDamage(HUNT_LASTTARGET, "direct", DAMAGE_ATTACK1, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner()), "none", "slash", "dmgevent:swing");
		}
		FIRE_ATTACK = 2;
		ANIM_ATTACK = ANIM_SLASH;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		if (!(GetEntityRange(m_hLastStruck) > 200)) return;
		if ((FIREBALL_DELAY)) return;
		FIREBALL_DELAY = 1;
		SetAngles("face_origin");
		FIREBALL_TARGET = GetEntityIndex(m_hLastStruck);
		ScheduleDelayedEvent(0.1, "throw_fireball");
	}

	void throw_fireball()
	{
		string MY_ANG = GetMonsterProperty("angles");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANG);
		SetAngles("face");
		PlayAnim("critical", "attack3");
		EmitSound(GetOwner(), 0, "magic/fireball_strike.wav", 10);
		string DIST = GetEntityRange(FIREBALL_TARGET);
		npcatk_suspend_ai(0.3);
		act_toss();
		if (DIST > 300)
		{
			ScheduleDelayedEvent(0.1, "act_toss");
		}
		if (DIST > 400)
		{
			ScheduleDelayedEvent(0.2, "act_toss");
		}
		ScheduleDelayedEvent(5.0, "reset_fireball_delay");
	}

	void act_toss()
	{
		TossProjectile("proj_fire_ball", /* TODO: $relpos */ $relpos(0, 48, 32), FIREBALL_TARGET, 400, 400, 10, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0);
		SetProp("ent_lastprojectile", "rendermode", 5);
		SetProp("ent_lastprojectile", "renderamt", 255);
	}

	void reset_fireball_delay()
	{
		FIREBALL_DELAY = 0;
	}

	void taunt()
	{
		SetRepeatDelay(RandomInt(15, 60));
		if (!(GetMonsterProperty("isalive"))) return;
		EmitSound(GetOwner(), 2, SOUND_TAUNT, 10);
	}

	void vulnerable()
	{
		SetInvincible(false);
		EmitSound(GetOwner(), 0, SOUND_PISSED, 10);
		SetSayTextRange(1024);
		CAN_FLINCH = 1;
		SayText("Fools! I shall destroy you all!");
	}

	void my_target_died()
	{
		EmitSound(GetOwner(), 0, SOUND_TAUNT, 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		UseTrigger("atholo_died");
		string RYZA_NAME = FindEntityByName("ryza");
		string RYZA_ID = GetEntityIndex(RYZA_NAME);
		CallExternal(RYZA_ID, "atholo_done");
	}

	void cycle_up()
	{
		if ((true))
		{
			light_on();
		}
		if ((ROAM_ON)) return;
		ROAM_ON = 1;
		BURST_FREQ("flame_burst_check");
		SetRoam(true);
	}

	void swing_dodamage()
	{
		MISS_ATTACK = 0;
		if (!(param1)) return;
		if (FIRE_ATTACK == 1)
		{
			ApplyEffect(param2, "effects/dot_fire", FIRE_DURATION, GetEntityIndex(GetOwner()), FIRE_DAMAGE);
		}
		if (FIRE_ATTACK == 2)
		{
			ApplyEffect(param2, "effects/dot_cold_freeze", FREEZE_DURATION, GetEntityIndex(GetOwner()), FREEZE_DAMAGE);
		}
		FIRE_ATTACK = 0;
	}

	void client_activate()
	{
		SKEL_ID = param1;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		string L_ORIGIN = "(63,1776,-3519)";
		for (int i = 0; i < GetPlayerCount(); i++)
		{
			get_chosen_one();
		}
		if (CHOSEN_ONE != "CHOSEN_ONE")
		{
			ClientEvent("new", "all", "kfortress/nh_appear_cl", L_ORIGIN, 0);
			SpawnItem("item_ring_ryza", L_ORIGIN);
			CallExternal(m_hLastCreated, "bitem_reserve", CHOSEN_ONE);
		}
	}

	void get_chosen_one()
	{
		if (i == 0)
		{
			CallExternal(GAME_MASTER, "gm_find_strongest_reset");
		}
		else
		{
			CallExternal(GAME_MASTER, "gm_find_strongest_player");
		}
		string L_STRONGEST = GetEntityProperty(GAME_MASTER, "scriptvar");
		string L_QUEST = GetPlayerQuestData(L_STRONGEST, "manaring");
		string L_ITEM = ItemExists(L_STRONGEST, "item_ring_ryza");
		if (L_QUEST != "0")
		{
			return;
		}
		if ((L_ITEM))
		{
			return;
		}
		CHOSEN_ONE = L_STRONGEST;
		break;
	}

	void light_on()
	{
		if ((I_R_GLOWING)) return;
		I_R_GLOWING = 1;
		ClientEvent("persist", "all", currentscript, GetEntityIndex(GetOwner()));
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

	void flame_burst_check()
	{
		BURST_FREQ("flame_burst_check");
		if (!(CanSee("enemy", 128))) return;
		PlayAnim("once", "break");
		npcatk_suspend_ai(1.0);
		ScheduleDelayedEvent(0.1, "flame_burst");
	}

	void flame_burst()
	{
		PlayAnim("critical", ANIM_CAST);
		SpawnNPC("monsters/summon/flame_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), FLAME_BURST_DAMAGE
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 512, 0.0, 1.0, 0.0);
		ScheduleDelayedEvent(0.2, "stop_throwing");
	}

	void return_home()
	{
		ScheduleDelayedEvent(15.0, "return_home");
		if (!(HUNT_LASTTARGET == �NONE�)) return;
		SetMoveDest(NPC_SPAWN_LOC);
	}

}

}
