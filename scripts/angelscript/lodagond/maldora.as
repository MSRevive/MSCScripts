#pragma context server

#include "lodagond/maldora_fragment.as"

namespace MS
{

class Maldora : CGameScript
{
	string APPLIED_BEAM;
	string AS_ATTACKING;
	string BARRIER_DELAY;
	float BASE_MOVESPEED;
	string BEAM_COUNT;
	string BEAM_ON;
	string BEAM_TARGET;
	string CHAIN_COUNT;
	string CHAIN_ON;
	string CUR_CHAIN_TARGET;
	int DMG_BARRIER;
	int EFFECT_DELAY;
	string G_DEVELOPER;
	int IMAGES_ALIVE;
	int IS_UNHOLY;
	string LAST_AXE_PICK;
	int ME_DEAD;
	int MINIONS_ALIVE;
	int NO_MOVE;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string RND_AXE;
	int SORC_SPAWNED;
	string SPELL_CHOICE;
	int SPELL_SUSPEND;
	int WAND_ATK;
	string WAND_TARGET;
	string WAND_TYPE;

	Maldora()
	{
		if ((StringToLower(GetMapName())).findFirst("lodagond") == 0)
		{
			NPC_IS_BOSS = 1;
		}
		const Vector3 LIGHT_COLOR = Vector3(128, 128, 128);
		const int LIGHT_RAD = 256;
		const int WAND_DOT = 40;
		const float NPC_BOSS_REGEN_RATE = 0.02;
		const float NPC_BOSS_RESTORATION = 0.25;
		BASE_MOVESPEED = 2.0;
		const int NUM_SPELLS = 8;
		const int AM_UBER = 1;
		IS_UNHOLY = 1;
		const string SHADOW_SCRIPT = "ms_wicardoven/maldora_image";
		const string MINION_SCRIPT = "monsters/maldora_gminion_random";
		const int MINION_LIMIT = 4;
		const float FREQ_SOUND = 10.0;
		const int NO_INTRO = 1;
		const int NPC_PROX_ACTIVATE = 1;
		const int NOT_FRAGMENT = 1;
		const int FIN_EXP = 20000;
		const int NPC_PROX_ACTIVATE = 1;
		const int NPC_PROXACT_RANGE = 640;
		const int NPC_PROXACT_IFSEEN = 1;
		const string NPC_PROXACT_EVENT = "combat_go";
		const string DMG_PUSH_BEAM = Random(20, 60);
		const string DMG_CHAIN = Random(20, 60);
		const float DMG_SHOCK = 100.0;
		const string DMG_ROCKS = RandomInt(200, 800);
		const string DMG_WAND = Random(200, 1000);
		DMG_BARRIER = 400;
		const Vector3 BARRIER_COLOR = Vector3(255, 0, 0);
	}

	void game_precache()
	{
		Precache("monsters/sorc_chief2");
		Precache("ms_wicardoven/maldora_dead");
		Precache("lodagond/maldora_fragment");
		Precache("monsters/summon/rock_storm");
		Precache("monsters/maldora_gminion_random");
		Precache("ms_wicardoven/maldora_image");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal("players", "ext_clear_valid_gauntlets");
		ME_DEAD = 1;
		CallExternal("all", "maldoraf_died");
		// svplaysound: svplaysound 2 0 ambience/alienvoices1.wav
		EmitSound(2, 0, "ambience/alienvoices1.wav");
		SetProp(GetOwner(), "renderamt", 0);
		if ((SORC_SPAWNED))
		{
			WAND_TYPE = -1;
		}
		SpawnNPC("ms_wicardoven/maldora_dead", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: "crow_final", WAND_TYPE
		SetSolid("none");
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
	}

	void OnSpawn() override
	{
		SetName("Maldora");
		SetHealth(10000);
		SetRace("demon");
		SetWidth(32);
		SetHeight(86);
		// svplaysound: svplaysound 2 0 ambience/alienvoices1.wav
		EmitSound(2, 0, "ambience/alienvoices1.wav");
		SetMoveSpeed(2.0);
		NPC_GIVE_EXP = FIN_EXP;
		SetRoam(false);
		WAND_TARGET = "unset";
		SetHearingSensitivity(11);
		SetInvincible(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetDamageResistance("all", 0.35);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("magic", 0.0);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("dark", 0.65);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("stun", 0);
		SetModel(MONSTER_MODEL);
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", 0);
		npcatk_suspend_ai();
		IMAGES_ALIVE = 0;
		MINIONS_ALIVE = 0;
		SetSayTextRange(2048);
		EmitSound(GetOwner(), 0, "magic/spawn_loud.wav", 10);
		ScheduleDelayedEvent(0.1, "fade_me_in");
		SetProp(GetOwner(), "skin", AXESKIN_NULL);
		combat_go();
		if (!(true)) return;
		if (!(G_SHAD_ORC)) return;
		ScheduleDelayedEvent(0.1, "spawn_shad");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void fade_me_in()
	{
		CallExternal(GAME_MASTER, "gm_fade_in", GetEntityIndex(GetOwner()), 2);
	}

	void fade_in_done()
	{
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void OnPostSpawn() override
	{
		SetGlobalVar("G_MALDORA_PRESENT", 1);
		ClientEvent("persist", "all", "effects/sfx_motionblur_perm", GetEntityIndex(GetOwner()), 0);
	}

	void reset_props()
	{
		SetRepeatDelay(FREQ_SOUND);
		if ((ME_DEAD)) return;
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), LIGHT_COLOR, LIGHT_RAD, FREQ_SOUND);
		// svplaysound: svplaysound 2 0 ambience/alienvoices1.wav
		EmitSound(2, 0, "ambience/alienvoices1.wav");
		ScheduleDelayedEvent(0.1, "sound_loop");
	}

	void sound_loop()
	{
		// svplaysound: svplaysound 2 8 ambience/alienvoices1.wav
		EmitSound(2, 8, "ambience/alienvoices1.wav");
	}

	void reset_effect_delay()
	{
		EFFECT_DELAY = 0;
	}

	void pick_spell()
	{
		SPELL_CHOICE = RandomInt(1, NUM_SPELLS);
		if ((BEAM_ON))
		{
			int EXIT_SUB = 1;
		}
		if ((CHAIN_ON))
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB))
		{
			ScheduleDelayedEvent(0.5, "pick_spell");
		}
		if ((EXIT_SUB)) return;
		if (G_DEVELOPER > 0)
		{
			SPELL_CHOICE = G_DEVELOPER;
			G_DEVELOPER = 0;
		}
		if (GetEntityRange(SPELL_TARGET) > 2048)
		{
			SPELL_CHOICE = 0;
		}
		if (!(IsEntityAlive(SPELL_TARGET)))
		{
			SPELL_CHOICE = 0;
		}
		if (GetRelationship(SPELL_TARGET) == "ally")
		{
			SPELL_CHOICE = 0;
		}
		if ((SPELL_SUSPEND))
		{
			SPELL_CHOICE = 0;
		}
		if (SPELL_CHOICE == 0)
		{
			int EXIT_SUB = 1;
			if (!(BARRIER_ON))
			{
			}
			if ((NO_MOVE))
			{
				resume_moving();
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB))
		{
			ScheduleDelayedEvent(0.5, "pick_spell");
		}
		if ((EXIT_SUB)) return;
		if (SPELL_CHOICE == 1)
		{
			if ((BARRIER_DELAY))
			{
				SPELL_CHOICE = RandomInt(2, NUM_SPELLS);
				LogDebug("barrier_no_go - barrier delay");
				int EXIT_SUB = 1;
			}
			if (!(BARRIER_DELAY))
			{
			}
			BARRIER_DELAY = 1;
			BARRIER_FREQ("reset_barrier_delay");
			ScheduleDelayedEvent(0.1, "raise_barrier");
		}
		if ((EXIT_SUB))
		{
			ScheduleDelayedEvent(0.5, "pick_spell");
		}
		if ((EXIT_SUB)) return;
		if (SPELL_CHOICE == 2)
		{
			BEAM_ON = 1;
			face_target(SPELL_TARGET);
			PlayAnim("critical", ANIM_BOLT);
			BEAM_COUNT = 0;
			APPLIED_BEAM = 0;
			BEAM_TARGET = SPELL_TARGET;
			ScheduleDelayedEvent(0.1, "beam_push");
		}
		if (SPELL_CHOICE == 3)
		{
			CHAIN_ON = 1;
			CUR_CHAIN_TARGET = 0;
			face_target(SPELL_TARGET);
			PlayAnim("critical", ANIM_CAST);
			CHAIN_COUNT = 0;
			ScheduleDelayedEvent(0.1, "chain_lightning");
		}
		if (SPELL_CHOICE == 4)
		{
			if ((G_MAL_ROCK_STORMS))
			{
				ScheduleDelayedEvent(0.2, "pick_spell");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			SetGlobalVar("G_MAL_ROCK_STORMS", 1);
			PlayAnim("critical", ANIM_CAST);
			string NUM_ROCKS = GetPlayerCount();
			if (NUM_ROCKS > 4)
			{
				int NUM_RUCKS = 4;
			}
			SpawnNPC("monsters/summon/rock_storm", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), NUM_ROCKS, DMG_ROCKS, 64, 90
		}
		if ((EXIT_SUB)) return;
		if (SPELL_CHOICE == 5)
		{
			if ((BARRIER_ON))
			{
				ScheduleDelayedEvent(0.2, "pick_spell");
				int EXIT_SUB = 1;
			}
			if (!(BARRIER_ON))
			{
			}
			if (IMAGES_ALIVE >= 1)
			{
				SPELL_CHOICE = RandomInt(6, NUM_SPELLS);
			}
			if (IMAGES_ALIVE == 0)
			{
			}
			if (RandomInt(1, 3) == 1)
			{
				if (!(AM_UBER))
				{
				}
				SayText("Shadows of my shadow...");
				EmitSound(GetOwner(), 0, "voices/lodagond-4/maldora_summoning.wav", 10);
			}
			ScheduleDelayedEvent(2.7, "laugh_it_up");
			stop_moving();
			PlayAnim("critical", ANIM_CAST);
			EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
			Effect("glow", GetOwner(), Vector3(255, 255, 255), 128, 2, 2);
			SpawnNPC(SHADOW_SCRIPT, /* TODO: $relpos */ $relpos(0, 64, -35), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPELL_TARGET, 45, AM_UBER
			ScheduleDelayedEvent(0.1, "make_shadow2");
			if ((AM_UBER))
			{
				ScheduleDelayedEvent(0.2, "make_shadow3");
				ScheduleDelayedEvent(0.4, "make_shadow4");
			}
			IMAGES_ALIVE = 2;
			ScheduleDelayedEvent(1.0, "resume_solid");
			ScheduleDelayedEvent(3.0, "resume_moving");
		}
		if (SPELL_CHOICE == 6)
		{
			if ((BARRIER_ON))
			{
				ScheduleDelayedEvent(0.2, "pick_spell");
				int EXIT_SUB = 1;
			}
			if (MINIONS_ALIVE >= MINION_LIMIT)
			{
				SPELL_CHOICE = RandomInt(7, NUM_SPELLS);
			}
			if (MINIONS_ALIVE < MINION_LIMIT)
			{
			}
			MINIONS_ALIVE += 1;
			PlayAnim("critical", ANIM_CAST);
			EmitSound(GetOwner(), 0, "monsters/skeleton/calrain3.wav", 10);
			Effect("glow", GetOwner(), Vector3(255, 255, 255), 128, 2, 2);
			SpawnNPC(MINION_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, -64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPELL_TARGET
			stop_moving(0.9);
			ScheduleDelayedEvent(1.0, "leap_away");
		}
		if (SPELL_CHOICE == 7)
		{
			string L_LAST_AXE_PICK = LAST_AXE_PICK;
			L_LAST_AXE_PICK += 20.0;
			if (GetGameTime() < L_LAST_AXE_PICK)
			{
				int EXIT_SUB = 1;
				ScheduleDelayedEvent(0.2, "pick_spell");
			}
			if (GetGameTime() > L_LAST_AXE_PICK)
			{
			}
			select_axe();
			LAST_AXE_PICK = GetGameTime();
		}
		if ((EXIT_SUB)) return;
		if (SPELL_CHOICE == 8)
		{
			ScheduleDelayedEvent(0.2, "pick_spell");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SPELL_FREQ("pick_spell");
	}

	void select_axe()
	{
		RND_AXE += 1;
		SetProp(GetOwner(), "skin", AXESKIN_WHITE);
		SPELL_SUSPEND = 1;
		NO_MOVE = 1;
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 256, 2, 2);
		EmitSound(GetOwner(), 0, "magic/spawn_loud.wav", 10);
		if (RND_AXE == 5)
		{
			RND_AXE = 0;
		}
		if (RND_AXE == 0)
		{
			Vector3 WAND_COLOR = Vector3(255, 0, 0);
			WAND_TYPE = AXESKIN_FIRE;
		}
		if (RND_AXE == 1)
		{
			Vector3 WAND_COLOR = Vector3(255, 255, 255);
			WAND_TYPE = AXESKIN_DARK;
		}
		if (RND_AXE == 2)
		{
			Vector3 WAND_COLOR = Vector3(64, 64, 255);
			WAND_TYPE = AXESKIN_COLD;
		}
		if (RND_AXE == 3)
		{
			Vector3 WAND_COLOR = Vector3(0, 255, 0);
			WAND_TYPE = AXESKIN_POISON;
		}
		if (RND_AXE == 4)
		{
			Vector3 WAND_COLOR = Vector3(255, 255, 0);
			WAND_TYPE = AXESKIN_LIGHTNING;
		}
		string BEAM_START = GetEntityProperty(GetOwner(), "attachpos");
		BEAM_START += "z";
		Effect("beam", "end", "lgtning.spr", 200, BEAM_START, GetEntityIndex(GetOwner()), 1, WAND_COLOR, 255, 100, 2.0);
		ScheduleDelayedEvent(1.5, "select_axe2");
	}

	void select_axe2()
	{
		SPELL_SUSPEND = 0;
		NO_MOVE = 0;
		SetProp(GetOwner(), "skin", WAND_TYPE);
	}

	void wand_strike_dmg()
	{
		WAND_ATK = 0;
		if (WAND_TYPE == "WAND_TYPE")
		{
			if (RandomInt(1, 5) == 1)
			{
			}
			ApplyEffect(param1, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
		}
	}

	void strike_wand()
	{
		AS_ATTACKING = GetGameTime();
		if (!(GetEntityRange(WAND_TARGET) < ATTACK_HITRANGE)) return;
		WAND_ATK = 1;
		if (WAND_TYPE == AXESKIN_FIRE)
		{
			string DMG_TYPE = "fire";
			string EFFECT_TYPE = WAND_FIRE_EFFECT;
		}
		if (WAND_TYPE == AXESKIN_DARK)
		{
			string DMG_TYPE = "magic";
			string EFFECT_TYPE = WAND_DARK_EFFECT;
		}
		if (WAND_TYPE == AXESKIN_COLD)
		{
			string DMG_TYPE = "cold";
			string EFFECT_TYPE = WAND_COLD_EFFECT;
		}
		if (WAND_TYPE == AXESKIN_POISON)
		{
			string DMG_TYPE = "poison";
			string EFFECT_TYPE = WAND_POISON_EFFECT;
		}
		if (WAND_TYPE == AXESKIN_LIGHTNING)
		{
			string DMG_TYPE = "lightning";
			string EFFECT_TYPE = WAND_LIGHTNING_EFFECT;
		}
		if (WAND_TYPE == "WAND_TYPE")
		{
			string DMG_TYPE = "blunt";
			string EFFECT_TYPE = "none";
		}
		DoDamage(WAND_TARGET, ATTACK_HITRANGE, DMG_WAND, 0.8, "blunt");
		if (EFFECT_TYPE == WAND_DARK_EFFECT)
		{
			ApplyEffect(WAND_TARGET, WAND_DARK_EFFECT, 10.0, 0, 1);
		}
		else
		{
			if (EFFECT_TYPE != "none")
			{
			}
			ApplyEffect(WAND_TARGET, EFFECT_TYPE, 5.0, GetEntityIndex(GetOwner()), WAND_DOT);
		}
	}

	void spawn_shad()
	{
		SORC_SPAWNED = 1;
		SetGlobalVar("G_SHAD_ORC", 0);
		SpawnNPC("monsters/sorc_chief2", /* TODO: $relpos */ $relpos(0, 64, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		ScheduleDelayedEvent(4.0, "spawn_shad2");
	}

	void spawn_shad2()
	{
		SayText("It'll take more than a renegade orc and a couple of wayward humans to defeat me!");
		EmitSound(GetOwner(), 0, "voices/lodagond-4/maldora_orcspot.wav", 10);
		ScheduleDelayedEvent(5.9, "laugh_it_up");
	}

}

}
