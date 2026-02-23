#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Flesheater : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_HEAR;
	int CLOUD_DELAY;
	int DIED_ONCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string GONE_ROAM;
	int I_AM_TURNABLE;
	int MOVE_RANGE;
	string MY_LIGHT_SCRIPT;
	string MY_SCRIPT_ID;
	int NPC_GIVE_EXP;
	int PLAYING_DEAD;

	Flesheater()
	{
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_ATTACK = "attack1";
		const string ANIM_CLOUDCAST = "attack2";
		const string ATTACK_DAMAGE = RandomInt(15, 25);
		ATTACK_RANGE = 120;
		MOVE_RANGE = 80;
		ATTACK_HITRANGE = 200;
		const float ATTACK_HITCHANCE = 0.85;
		const string SOUND_STRUCK1 = "controller/con_pain3.wav";
		const string SOUND_STRUCK2 = "controller/con_pain3.wav";
		const string SOUND_STRUCK3 = "controller/con_pain2.wav";
		const string SOUND_PAIN = "zombie/zo_pain2.wav";
		const string SOUND_ATTACK1 = "controller/con_attack1.wav";
		const string SOUND_ATTACK2 = "controller/con_attack2.wav";
		const string SOUND_DEATH1 = "zombie/zo_pain1.wav";
		const string SOUND_DEATH2 = "monsters/troll/trolldeath.wav";
		const string SOUND_IDLE = "controller/con_attack3.wav";
		const string SOUND_SPAWN = "monsters/skeleton/calrian2.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 100;
		DROP_GOLD_MAX = 150;
		const float SKEL_RESPAWN_CHANCE = 1.0;
		const int SKEL_HP = 3000;
		const string POISON_CLAW_DMG = RandomInt(13, 20);
		const int CLOUD_DURATION = 10;
		const int CLOUD_DAMAGE = 20;
		Precache("poison_cloud.spr");
		const string MONSTER_MODEL = "monsters/flesheater.mdl";
		Precache(MONSTER_MODEL);
		Precache("ambience/steamburst1.wav");
		Precache(SOUND_DEATH);
		const string ANIM_RESPAWN_DEADIDLE = "dead_on_stomach";
	}

	void OnSpawn() override
	{
		I_AM_TURNABLE = 0;
		MY_SCRIPT_ID = "unset";
		SetHealth(3000);
		int ON_UNREST = 0;
		string MAP_NAME = GetMapName();
		if (MAP_NAME == "unrest2")
		{
			int ON_UNREST = 1;
		}
		if (MAP_NAME == "unrest2_beta1")
		{
			int ON_UNREST = 2;
		}
		if (!(ON_UNREST))
		{
			SetWidth(50);
			SetHeight(100);
		}
		if ((ON_UNREST))
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 255);
			SetWidth(20);
			SetHeight(72);
		}
		SetName("Flesh Eater");
		SetRoam(false);
		SetHearingSensitivity(8);
		NPC_GIVE_EXP = 250;
		SetRace("undead");
		Precache(MONSTER_MODEL);
		SetModel(MONSTER_MODEL);
		SetModelBody(1, 0);
		SetDamageResistance("all", 0.65);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
	}

	void game_postspawn()
	{
	}

	void attack_1()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
		ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", 5, GetOwner(), POISON_CLAW_DMG);
		if (RandomInt(0, 1) == 0)
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
	}

	void attack_2()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
		ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", 5, GetOwner(), POISON_CLAW_DMG);
		if (RandomInt(0, 1) == 0)
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(GONE_ROAM))
		{
			SetRoam(true);
			GONE_ROAM = 1;
		}
		string MY_HP = GetEntityHealth(GetOwner());
		if (MY_HP <= 500)
		{
			if (MY_HP > 1)
			{
			}
			if (!(DIED_ONCE))
			{
			}
			npcatk_clear_targets();
			fake_death();
		}
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void fake_death()
	{
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_DEATH);
		PLAYING_DEAD = 1;
		EmitSound(GetOwner(), 0, SOUND_DEATH1, 10);
		string L_DEATHANIM = RandomInt(0, 1);
		ANIM_DEATH = "diesimple";
		if (LCL_DEATHANIM == 1)
		{
			ANIM_DEATH = "dieforward";
		}
		DIED_ONCE = 1;
		PLAYING_DEAD = 1;
		CAN_HEAR = 0;
		SetAlive(1);
		SetMoveDest("none");
		SetIdleAnim(ANIM_RESPAWN_DEADIDLE);
		SetInvincible(true);
		SetRoam(false);
		ScheduleDelayedEvent(8.0, "skel_respawn");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		UseTrigger("bloodreaver_died");
		string MAP_NAME = StringToLower(GetMapName());
		if (MAP_NAME != "bloodrose")
		{
			SayText("I shall return one day! ...and then your flesh shall adorn my bones!");
		}
		if (MAP_NAME == "bloodrose")
		{
			string L_SPAWN = FindEntityByName("slithar_caves1");
			if (((L_SPAWN !is null)))
			{
				DeleteEntity(L_SPAWN);
			}
			string L_SPAWN = FindEntityByName("slithar_caves1_tele");
			if (((L_SPAWN !is null)))
			{
				DeleteEntity(L_SPAWN);
			}
			string L_SPAWN = FindEntityByName("slithar_caves2");
			if (((L_SPAWN !is null)))
			{
				DeleteEntity(L_SPAWN);
			}
			string L_SPAWN = FindEntityByName("slithar_caves2_tele");
			if (((L_SPAWN !is null)))
			{
				DeleteEntity(L_SPAWN);
			}
			string L_SPAWN = FindEntityByName("slithar_caves3");
			if (((L_SPAWN !is null)))
			{
				DeleteEntity(L_SPAWN);
			}
			string L_SPAWN = FindEntityByName("slithar_caves3_tele");
			if (((L_SPAWN !is null)))
			{
				DeleteEntity(L_SPAWN);
			}
			string L_SPAWN = FindEntityByName("slithar_caves4");
			if (((L_SPAWN !is null)))
			{
				DeleteEntity(L_SPAWN);
			}
			string L_MASTER_ID = FindEntityByName("snake_lord");
			if ((IsEntityAlive(L_MASTER_ID)))
			{
				SayText("Slithar, I have failed! Finish them!");
				CallExternal(L_MASTER_ID, "slithar_resume");
			}
			else
			{
				SayText("For now, you have won, but you have not seen the last of me nor my master!");
			}
		}
	}

	void skel_respawn()
	{
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("critical", "getup");
		SetHealth(3000);
		SetSayTextRange(1024);
		SayText("No! I shall not be defeated so easily!");
		ScheduleDelayedEvent(2.5, "skel_respawn_revived");
	}

	void skel_respawn_revived()
	{
		PLAYING_DEAD = 0;
		SetMoveDest(HUNT_LASTTARGET);
		npcatk_resume_ai();
		CAN_HEAR = 1;
		SetRoam(true);
		SetInvincible(false);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((PLAYING_DEAD)) return;
		if ((CLOUD_DELAY)) return;
		if ((false))
		{
			string L_ORIG = GetEntityOrigin(m_hAttackTarget);
		}
		else
		{
			string L_ORIG = GetEntityOrigin(GetOwner());
		}
		SpawnNPC("monsters/summon/npc_poison_cloud2", L_ORIG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), CLOUD_DAMAGE, CLOUD_DURATION, 1
		PlayAnim("once", ANIM_CLOUDCAST);
		CLOUD_DELAY = 1;
		ScheduleDelayedEvent(10.0, "reset_cloud_delay");
	}

	void reset_cloud_delay()
	{
		CLOUD_DELAY = 0;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((GONE_ROAM)) return;
		GONE_ROAM = 1;
		SetRoam(true);
		EmitSound(GetOwner(), 2, SOUND_SPAWN, 10);
		if ((true))
		{
			light_loop();
		}
	}

	void light_loop()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(10.0, "light_loop");
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(0, 255, 0), 256, 10.0);
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((PLAYING_DEAD)) return;
		if (!(GetEntityHealth(GetOwner()) > 500)) return;
		string HP_TO_GIVE = param2;
		HP_TO_GIVE *= 0.25;
		string MAX_CHECK = GetMonsterHP();
		MAX_CHECK += HP_TO_GIVE;
		if (!(MAX_CHECK < GetMonsterMaxHP())) return;
		HealEntity(GetOwner(), HP_TO_GIVE);
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 80, 0.25, 0.25);
		EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
	}

	void my_target_died()
	{
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 255, 1.0, 1.0);
		ScheduleDelayedEvent(0.4, "skele_laugh");
		EmitSound(GetOwner(), 0, "ambience/particle_suck1.wav", 10);
		SetHealth(GetMonsterMaxHP());
	}

	void skele_laugh()
	{
		EmitSound(GetOwner(), 0, "x/x_laugh1.wav", 10);
	}

}

}
