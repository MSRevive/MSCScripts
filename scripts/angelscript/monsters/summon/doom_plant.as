#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class DoomPlant : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ATTACK_TARGET;
	int FIRST_SET_DONE;
	string GAME_PVP;
	int GROWING;
	int IAM_SUMMONED;
	string MY_DMG;
	string MY_DURATION;
	string MY_OWNER;
	string NEXT_GROW;
	string OWNER_ISPLAYER;
	int PLANT_LEVEL;
	int REPULSE;
	int SCAN_RANGE;
	int SHOOTING;
	int SHOOT_DELAY;
	int SPORE_DELAY;
	string SPORE_POISON_DMG;

	DoomPlant()
	{
		const int PLANT_HITCHANCE = 95;
		const string SHRUB_IDLE_ANIMS = "thornplant2_idle1_1;thornplant2_idle1_2;thornplant2_idle3_1;thornplant2_idle3_2;";
		const string BUSH_IDLE_ANIMS = "thornplant2_2_idle1;thornplant2_2_idle2;thornplant2_2_idle3;thornplant2_2_idle4_1;thornplant2_2_idle4_2;";
		const string TREE_IDLE_ANIMS = "thornplant2_3_idle1;thornplant2_3_idle2;thornplant2_3_idle3;thornplant2_3_idle4;thornplant2_3_idle5;";
		const int MELE_RANGE = 96;
		const float FREQ_GROW = 40.0;
		const float FREQ_SHOOT = 1.0;
		const float FREQ_SPORE = 10.0;
		const string MODEL_LEVEL1 = "monsters/dewm_shrub.mdl";
		const string MODEL_LEVEL2 = "monsters/dewm_bush.mdl";
		const string MODEL_LEVEL3 = "monsters/dewm_tree.mdl";
		const string GIB_MODEL = "cactusgibs.mdl";
		const string SOUND_GIB = "debris/bustflesh1.wav";
		const string SOUND_SLASH = "zombie/claw_miss1.wav";
		const string SOUND_SCRATCH = "headcrab/hc_attack1.wav";
		const string SOUND_SPORE = "weapons/bow/crossbow.wav";
		const string SOUND_GROW = "weapons/bow/stretch.wav";
		const string SOUND_STRUCK1 = "weapons/xbow_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/xbow_hitbod2.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if (!(SHOOTING))
		{
		}
		if (!(GROWING))
		{
		}
		if (!(SHOOT_DELAY))
		{
		}
		int TARGET_ENT = 0;
		if ((false))
		{
			if (GetEntityRange(m_hLastSeen) < SCAN_RANGE)
			{
			}
			if (!(GetEntityProperty(m_hLastSeen, "scriptvar")))
			{
			}
			string TARGET_ENT = GetEntityIndex(m_hLastSeen);
		}
		if (TARGET_ENT != 0)
		{
			if ((OWNER_ISPLAYER))
			{
				if ((IsValidPlayer(TARGET_ENT)))
				{
				}
				if (GAME_PVP == 0)
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			attack_target(TARGET_ENT);
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(3.0);
		if (!(SHOOTING))
		{
		}
		if (!(GROWING))
		{
		}
		select_idle_anim();
		PlayAnim("once", ANIM_IDLE);
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(5.0);
		if (PLANT_LEVEL < 3)
		{
		}
		grow_next_level();
	}

	void game_dynamically_created()
	{
		if (!(IsEntityAlive(param1)))
		{
			MY_OWNER = GetEntityIndex(GetOwner());
			MY_DMG = 20;
			MY_DURATION = "PARAM3";
			OWNER_ISPLAYER = 0;
			GAME_PVP = "game.pvp";
			SetRace("demon");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		IAM_SUMMONED = 1;
		MY_OWNER = param1;
		MY_DMG = param2;
		MY_DURATION = param3;
		OWNER_ISPLAYER = GetEntityIndex(param1);
		GAME_PVP = "game.pvp";
		SetRace(GetEntityRace(param1));
		if (MY_DURATION != "PARAM3")
		{
			MY_DURATION("plant_die");
		}
	}

	void OnSpawn() override
	{
		SetBloodType("green");
		if (!(START_STAGE))
		{
			setup_plant_level1();
		}
		if (START_STAGE == 2)
		{
			setup_plant_level2();
		}
		if (START_STAGE == 3)
		{
			setup_plant_level3();
		}
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("stun", 0);
		SetWidth(40);
		SetHeight(96);
		SetInvincible(true);
		SetHearingSensitivity(11);
		GROWING = 1;
		SetSolid("none");
		EmitSound(GetOwner(), 0, SOUND_GROW, 10);
		if (!(START_STAGE))
		{
			PlayAnim("critical", "thornplant2_grow");
		}
		if (START_STAGE == 2)
		{
			PlayAnim("critical", "thornplant2_2_grow");
		}
		if (START_STAGE == 3)
		{
			PlayAnim("critical", "thornplant2_3_grow");
		}
		FIRST_SET_DONE = 0;
		ScheduleDelayedEvent(5.0, "undo_invinc");
		REPULSE = 1;
		repulse_loop();
		set_next_grow();
		SetBloodType("green");
		SpawnNPC("monsters/summon/ibarrier", GetMonsterProperty("origin"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 60, 1, 1, 1, 0, 1
	}

	void game_postspawn()
	{
		if ((IAM_SUMMONED)) return;
		MY_OWNER = GetEntityIndex(GetOwner());
		MY_DMG = 20;
		MY_DURATION = "PARAM3";
		OWNER_ISPLAYER = 0;
		GAME_PVP = "game.pvp";
		SetRace("demon");
		int EXIT_SUB = 1;
	}

	void game_precache()
	{
		Precache("cactusgibs.mdl");
	}

	void undo_invinc()
	{
		end_repulse();
		SetInvincible(false);
		SetSolid("box");
		FIRST_SET_DONE = 1;
	}

	void repulse_loop()
	{
		if (!(REPULSE)) return;
		ScheduleDelayedEvent(0.1, "repulse_loop");
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 96, 0.0, 1.0, 0.0);
	}

	void end_repulse()
	{
		REPULSE = 0;
	}

	void game_dodamage()
	{
		if (!(REPULSE)) return;
		if (!(GetEntityIndex(param2) != GetEntityIndex(GetOwner()))) return;
		if (!(GetEntityRange(param2) < 128)) return;
		SetAngles("face");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		SetAngles("face");
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 1000, 100));
		if (PLANT_LEVEL == 1)
		{
			if ((param1))
			{
			}
			EmitSound(GetOwner(), 0, SOUND_SCRATCH, 10);
		}
		if (PLANT_LEVEL == 2)
		{
			if ((param1))
			{
			}
			if ((SHOOTING))
			{
			}
			if (GetEntityRange(ATTACK_TARGET) < MELE_RANGE)
			{
			}
			EmitSound(GetOwner(), 0, SOUND_SCRATCH, 10);
		}
		if (PLANT_LEVEL == 3)
		{
			if ((param1))
			{
			}
			if ((SHOOTING))
			{
			}
			if (GetEntityRange(ATTACK_TARGET) < MELE_RANGE)
			{
			}
			EmitSound(GetOwner(), 0, SOUND_SCRATCH, 10);
		}
	}

	void setup_plant_level1()
	{
		SetName("Doom Shrub");
		string F_HP = MY_DMG;
		if (MY_DMG == "MY_DMG")
		{
			ScheduleDelayedEvent(0.1, "setup_plant_level1");
		}
		F_HP *= 2;
		if (NPC_HP_MULTI > 1)
		{
			F_HP *= NPC_HP_MULTI;
		}
		SetHealth(F_HP);
		SetModel(MODEL_LEVEL1);
		if ((FIRST_SET_DONE))
		{
			SetSolid("box");
			LogDebug("set solid");
		}
		SCAN_RANGE = 96;
		PLANT_LEVEL = 1;
		ANIM_ATTACK = "thornplant2_attack";
		ANIM_DEATH = "thornplant2_harvest";
		select_idle_anim();
		SetIdleAnim(ANIM_IDLE);
	}

	void setup_plant_level2()
	{
		SetName("Doom Bush");
		string F_HP = MY_DMG;
		F_HP *= 10;
		if (NPC_HP_MULTI > 1)
		{
			F_HP *= NPC_HP_MULTI;
		}
		SetHealth(F_HP);
		SetModel(MODEL_LEVEL2);
		SetSolid("box");
		SCAN_RANGE = 512;
		PLANT_LEVEL = 2;
		ANIM_ATTACK = "thornplant2_2_attack";
		ANIM_DEATH = "thornplant2_2_harvest";
		select_idle_anim();
		SetIdleAnim(ANIM_IDLE);
	}

	void setup_plant_level3()
	{
		SetName("Doom Tree");
		string F_HP = MY_DMG;
		F_HP *= 50;
		if (NPC_HP_MULTI > 1)
		{
			F_HP *= NPC_HP_MULTI;
		}
		SetHealth(F_HP);
		SetModel(MODEL_LEVEL3);
		SetSolid("box");
		SCAN_RANGE = 1024;
		PLANT_LEVEL = 3;
		ANIM_ATTACK = "thornplant2_3_attack";
		ANIM_DEATH = "thornplant2_3_harvest";
		select_idle_anim();
		SetIdleAnim(ANIM_IDLE);
	}

	void grow_done()
	{
		GROWING = 0;
		SHOOTING = 0;
		SHOOT_DELAY = 0;
		SPORE_DELAY = 0;
		SetSolid("box");
	}

	void grow_next_level()
	{
		if ((GROWING)) return;
		if (!(GetGameTime() > NEXT_GROW)) return;
		set_next_grow();
		if (PLANT_LEVEL == 2)
		{
			ScheduleDelayedEvent(0.2, "grow_level3");
		}
		if (PLANT_LEVEL == 1)
		{
			ScheduleDelayedEvent(0.2, "grow_level2");
		}
		REPULSE = 1;
		repulse_loop();
		ScheduleDelayedEvent(1.0, "end_repulse");
	}

	void grow_level2()
	{
		SHOOTING = 0;
		setup_plant_level2();
		GROWING = 1;
		EmitSound(GetOwner(), 0, SOUND_GROW, 10);
		PlayAnim("critical", "thornplant2_2_grow");
	}

	void grow_level3()
	{
		SHOOTING = 0;
		setup_plant_level3();
		GROWING = 1;
		EmitSound(GetOwner(), 0, SOUND_GROW, 10);
		PlayAnim("critical", "thornplant2_3_grow");
	}

	void attack_done()
	{
		SHOOTING = 0;
		if (PLANT_LEVEL == 1)
		{
			SHOOT_DELAY = 0;
		}
		if (PLANT_LEVEL > 1)
		{
			FREQ_SHOOT("reset_shoot_delay");
		}
	}

	void attack_target()
	{
		if ((SHOOT_DELAY)) return;
		if ((SHOOTING)) return;
		if ((I_R_FROZEN)) return;
		SHOOT_DELAY = 1;
		ATTACK_TARGET = param1;
		SetMoveDest(ATTACK_TARGET);
		PlayAnim("critical", ANIM_ATTACK);
		SHOOTING = 1;
		attack_loop();
		if (!(PLANT_LEVEL == 3)) return;
		if ((SPORE_DELAY)) return;
		SPORE_DELAY = 1;
		FREQ_SPORE("reset_spore_delay");
		fire_spore(ATTACK_TARGET);
	}

	void attack_loop()
	{
		if (!(SHOOTING)) return;
		ScheduleDelayedEvent(0.5, "attack_loop");
		SetMoveDest(ATTACK_TARGET);
		if (!(GetEntityRange(ATTACK_TARGET) < SCAN_RANGE)) return;
		if (PLANT_LEVEL == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_SLASH, 10);
			DoDamage(ATTACK_TARGET, SCAN_RANGE, MY_DMG, PLANT_HITCHANCE, "slash");
		}
		if (PLANT_LEVEL == 2)
		{
			EmitSound(GetOwner(), 0, SOUND_SLASH, 10);
			DoDamage(ATTACK_TARGET, MELE_RANGE, MY_DMG, PLANT_HITCHANCE, "slash");
			TossProjectile("proj_thorn", /* TODO: $relpos */ $relpos(0, 32, -16), ATTACK_TARGET, 1000, MY_DMG, 0.1, "none");
		}
		if (PLANT_LEVEL == 3)
		{
			EmitSound(GetOwner(), 0, SOUND_SLASH, 10);
			DoDamage(ATTACK_TARGET, MELE_RANGE, MY_DMG, PLANT_HITCHANCE, "slash");
			TossProjectile("proj_thorn", /* TODO: $relpos */ $relpos(0, 32, 16), ATTACK_TARGET, 1000, MY_DMG, 0.1, "none");
			TossProjectile("proj_thorn", /* TODO: $relpos */ $relpos(0, 32, 16), ATTACK_TARGET, 800, MY_DMG, 1, "none");
			if (GetEntityRange(ATTACK_TARGET) < MELE_RANGE)
			{
				if (RandomInt(1, 10) == 1)
				{
				}
				ApplyEffect(ATTACK_TARGET, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
			}
		}
	}

	void fire_spore()
	{
		EmitSound(GetOwner(), 0, SOUND_SPORE, 10);
		string SPORE_DAMAGE = MY_DMG;
		SPORE_DAMAGE *= 4;
		SPORE_POISON_DMG = MY_DMG;
		TossProjectile("proj_spore", /* TODO: $relpos */ $relpos(0, 32, 16), ATTACK_TARGET, 500, SPORE_DAMAGE, 0.1, "none");
	}

	void reset_spore_delay()
	{
		SPORE_DELAY = 0;
	}

	void reset_shoot_delay()
	{
		SHOOT_DELAY = 0;
	}

	void select_idle_anim()
	{
		if (PLANT_LEVEL == 1)
		{
			string IDLE_ANIMS = SHRUB_IDLE_ANIMS;
		}
		if (PLANT_LEVEL == 2)
		{
			string IDLE_ANIMS = BUSH_IDLE_ANIMS;
		}
		if (PLANT_LEVEL == 3)
		{
			string IDLE_ANIMS = TREE_IDLE_ANIMS;
		}
		string NIDLE_ANIMS = GetTokenCount(IDLE_ANIMS, ";");
		NIDLE_ANIMS -= 1;
		string RND_IDLE = RandomInt(0, NIDLE_ANIMS);
		ANIM_IDLE = GetToken(IDLE_ANIMS, RND_IDLE, ";");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetAlive(1);
		GROWING = 1;
		SetInvincible(true);
		PlayAnim("critical", ANIM_DEATH);
		set_next_grow();
	}

	void shrink_done()
	{
		GROWING = 0;
		SHOOTING = 0;
		SHOOT_DELAY = 0;
		SPORE_DELAY = 0;
		SetInvincible(false);
		REPULSE = 1;
		repulse_loop();
		ScheduleDelayedEvent(1.0, "end_repulse");
		PLANT_LEVEL -= 1;
		if (PLANT_LEVEL == 2)
		{
			ScheduleDelayedEvent(0.1, "setup_plant_level2");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (PLANT_LEVEL == 1)
		{
			ScheduleDelayedEvent(0.1, "setup_plant_level1");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (PLANT_LEVEL == 0)
		{
			EmitSound(GetOwner(), 0, SOUND_GIB, 10);
			Effect("tempent", "gibs", GIB_MODEL, /* TODO: $relpos */ $relpos(0, 0, 0), 1.0, 100, 30, 20, 4.0);
			CallExternal(MY_OWNER, "plant_died");
			LogDebug("died");
			SetSolid("none");
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 0);
			SetModel("none");
			DeleteEntity(GetOwner());
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void OnDamage(int damage) override
	{
		ATTACK_TARGET = GetEntityIndex(m_hLastStruck);
		SetMoveDest(GetEntityIndex(m_hLastStruck));
		if ((SHOOTING)) return;
		if (PLANT_LEVEL > 1)
		{
			attack_target(ATTACK_TARGET);
		}
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((SHOOTING)) return;
		if ((GROWING)) return;
		string LAST_HEARD = GetEntityIndex("ent_lastheard");
		if (!(GetRelationship(LAST_HEARD) == "enemy")) return;
		SetMoveDest(LAST_HEARD);
		if (PLANT_LEVEL > 1)
		{
			attack_target(LAST_HEARD);
		}
		if (PLANT_LEVEL == 1)
		{
			if (GetEntityRange(LAST_HEARD) < MELE_RANGE)
			{
			}
			attack_target(LAST_HEARD);
		}
	}

	void master_stuck()
	{
		if (!(GetEntityRange(MY_MASTER) < 256)) return;
		SetSolid("none");
		AddVelocity(MY_OWNER, /* TODO: $relvel */ $relvel(0, 1000, 100));
		ScheduleDelayedEvent(0.2, "resume_solid");
	}

	void resume_solid()
	{
		SetSolid("box");
	}

	void set_next_grow()
	{
		NEXT_GROW = GetGameTime();
		NEXT_GROW += FREQ_GROW;
	}

}

}
