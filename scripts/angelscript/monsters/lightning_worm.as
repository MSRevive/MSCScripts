#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_noclip.as"

namespace MS
{

class LightningWorm : CGameScript
{
	int ACTIVE_HORRORS;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BEAM_ATTACK;
	string CENTER_POINT;
	int HORROR_LIMIT;
	int IS_UNHOLY;
	int MOVING_CENTER;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string NPC_NOCLIP_DEST;
	string QUARTER_HP;
	string WORM_TARGET;

	LightningWorm()
	{
		if (StringToLower(GetMapName()) == "cleicert")
		{
			NPC_IS_BOSS = 1;
		}
		const float NPC_BOSS_REGEN_RATE = 0.05;
		const float NPC_BOSS_RESTORATION = 0.5;
		IS_UNHOLY = 1;
		ANIM_ATTACK = "treadwater";
		const string ANIM_EGG = "headshot";
		ANIM_DEATH = "die_simple";
		ATTACK_MOVERANGE = 1;
		ANIM_IDLE = "swim";
		ANIM_RUN = "swim";
		ANIM_WALK = "swim";
		NPC_GIVE_EXP = 1500;
		const string SOUND_LOOP1 = "ambience/alien_creeper.wav";
		const string SOUND_LOOP2 = "ambience/alien_frantic.wav";
		const string SOUND_STRUCK1 = "bullchicken/bc_bite1.wav";
		const string SOUND_STRUCK2 = "bullchicken/bc_bite3.wav";
		const string SOUND_STRUCK3 = "debris/bustflesh2.wav";
		const string SOUND_EGG = "tentacle/te_roar1.wav";
		const string SOUND_CHARGE1 = "houndeye/he_attack1.wav";
		const string SOUND_CHARGE2 = "houndeye/he_attack2.wav";
		const string SOUND_CHARGE3 = "houndeye/he_attack3.wav";
		const string SOUND_SHOOT1 = "houndeye/he_blast1.wav";
		const string SOUND_SHOOT2 = "houndeye/he_blast2.wav";
		const string SOUND_SHOOT3 = "houndeye/he_blast3.wav";
		const string DMG_SHOCK = RandomInt(100, 200);
		const string DOT_SHOCK = RandomInt(20, 40);
		const int ROAM_RADIUS = 256;
		const string VERT_RANGE_FULL = Random(-196, 128);
		const string VERT_RANGE_HALF = Random(-196, 0);
		ATTACK_RANGE = 2048;
		const string FREQ_SHOOT = Random(5, 10);
		const string FREQ_EGG = Random(30, 60);
		const float FREQ_SOUND = 10.0;
		const float FREQ_REND = 0.5;
		Precache("ambience/the_horror1.wav");
		Precache("ambience/the_horror2.wav");
		Precache("ambience/the_horror3.wav");
		Precache("ambience/the_horror4.wav");
		Precache("monsters/egg.mdl");
		Precache("debris/bustflesh1.wav");
		Precache("weapons/g_bounce1.wav");
		Precache("player/pl_fallpain1.wav");
		const int FWD_SPEED = 10;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_REND);
		if (GetMonsterHP() < QUARTER_HP)
		{
			if (RandomInt(1, 5) == 1)
			{
			}
			Effect("glow", GetOwner(), Vector3(255, 0, 0), 64, 1, 1);
		}
		if (RandomInt(1, 20) == 1)
		{
			PlayAnim("critical", "crouch_idle");
		}
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RandomInt(128, 255));
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(FREQ_SOUND);
		// svplaysound: svplaysound 2 0 null.wav
		EmitSound(2, 0, "null.wav");
		ScheduleDelayedEvent(0.1, "loop_sound");
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(FREQ_SHOOT);
		if ((IsEntityAlive(WORM_TARGET)))
		{
		}
		// PlayRandomSound from: SOUND_CHARGE1, SOUND_CHARGE2, SOUND_CHARGE3
		array<string> sounds = {SOUND_CHARGE1, SOUND_CHARGE2, SOUND_CHARGE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		string SHOOT_DELAY = Random(1.5, 2);
		PlayAnim("critical", ANIM_ATTACK);
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 128, 5, 5);
		SHOOT_DELAY("do_lightning");
	}

	void OnRepeatTimer_3()
	{
		SetRepeatDelay(FREQ_EGG);
		if (ACTIVE_HORRORS < HORROR_LIMIT)
		{
		}
		PlayAnim("critical", ANIM_EGG);
		EmitSound(GetOwner(), 0, SOUND_EGG, 10);
		ScheduleDelayedEvent(0.5, "lay_egg");
	}

	void OnSpawn() override
	{
		SetName("Ethereal Vermicular");
		SetRace("demon");
		SetHealth(4000);
		SetModel("monsters/weird_worm.mdl");
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("holy", 1.0);
		SetBloodType("green");
		SetFly(true);
		SetWidth(72);
		SetHeight(72);
		SetMoveAnim("swim");
		SetIdleAnim("swim");
		ACTIVE_HORRORS = 0;
		npcatk_suspend_ai();
		ScheduleDelayedEvent(0.1, "set_centerpoint");
	}

	void set_centerpoint()
	{
		CENTER_POINT = GetMonsterProperty("origin");
		CENTER_POINT += "z";
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
	}

	void OnPostSpawn() override
	{
		loop_sound();
		npcatk_suspend_ai();
		QUARTER_HP = GetMonsterMaxHP();
		QUARTER_HP *= 0.25;
		SetMoveDest(CENTER_POINT);
		MOVING_CENTER = 1;
		HORROR_LIMIT = 4;
		if ("game.players.totalhp" > 1600)
		{
			HORROR_LIMIT += 1;
		}
		if ("game.players.totalhp" > 3200)
		{
			HORROR_LIMIT += 1;
		}
	}

	void loop_sound()
	{
		if (GetMonsterHP() > QUARTER_HP)
		{
			// svplaysound: if ( game.monster.hp > QUARTER_HP ) svplaysound 2 10 SOUND_LOOP1
			EmitSound(2, 10, SOUND_LOOP1);
		}
		if (GetMonsterHP() < QUARTER_HP)
		{
			// svplaysound: if ( game.monster.hp < QUARTER_HP ) svplaysound 2 10 SOUND_LOOP2
			EmitSound(2, 10, SOUND_LOOP2);
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		WORM_TARGET = GetEntityIndex(m_hLastStruck);
	}

	void do_lightning()
	{
		// PlayRandomSound from: SOUND_SHOOT1, SOUND_SHOOT2, SOUND_SHOOT3
		array<string> sounds = {SOUND_SHOOT1, SOUND_SHOOT2, SOUND_SHOOT3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		BEAM_ATTACK = 1;
		DoDamage(WORM_TARGET, ATTACK_RANGE, DMG_SHOCK, 1.0, "lightning");
	}

	void game_dodamage()
	{
		if (!(param1))
		{
			if ((BEAM_ATTACK))
			{
			}
			BEAM_ATTACK = 0;
			if (!(IsEntityAlive(param2)))
			{
			}
			string TRACE_START = GetEntityOrigin(GetOwner());
			string TRACE_END = GetEntityOrigin(WORM_TARGET);
			string TRACE_IT = TraceLine(TRACE_START, TRACE_END);
			Effect("beam", "point", "lgtning.spr", 60, TRACE_START, TRACE_IT, Vector3(255, 255, 50), 200, 60, 1.0);
		}
		if (!(param1)) return;
		if (!(BEAM_ATTACK)) return;
		BEAM_ATTACK = 0;
		ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), DOT_SHOCK);
		string L_BEAM_START = GetEntityOrigin(GetOwner());
		string L_BEAM_END = GetEntityOrigin(WORM_TARGET);
		Effect("beam", "point", "lgtning.spr", 60, L_BEAM_START, L_BEAM_END, Vector3(255, 255, 50), 200, 60, 1.0);
	}

	void lay_egg()
	{
		if (!(IsInWater(GetOwner()) == 0)) return;
		SpawnNPC("monsters/summon/horror_egg_lightning", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		ACTIVE_HORRORS += 1;
	}

	void basenoclip_flight()
	{
		LogDebug("temp dist Distance(GetMonsterProperty("origin"), CENTER_POINT) MOVING_CENTER");
		if ((MOVING_CENTER))
		{
			NPC_NOCLIP_DEST = CENTER_POINT;
			if (Distance(GetMonsterProperty("origin"), NPC_NOCLIP_DEST) < 96)
			{
			}
			MOVING_CENTER = 0;
		}
		if ((MOVING_CENTER)) return;
		if (Distance(GetMonsterProperty("origin"), NPC_NOCLIP_DEST) < 96)
		{
			DEST_ROT += 45;
			if (DEST_ROT > 359)
			{
				DEST_ROT -= 359;
			}
			NPC_NOCLIP_DEST = CENTER_POINT;
			string L_VERT_RANGE = VERT_RANGE_FULL;
			if (RandomInt(1, 2) == 1)
			{
				string L_VERT_RANGE = VERT_RANGE_HALF;
			}
			NPC_NOCLIP_DEST += /* TODO: $relpos */ $relpos(Vector3(0, DEST_ROT, 0), Vector3(0, ROAM_RADIUS, L_VERT_RANGE));
		}
	}

	void horror_died()
	{
		ACTIVE_HORRORS -= 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(GAME_MASTER, "gm_worm_gold", GetEntityIndex(GetOwner()), "chests/bag_o_gold_50");
		// svplaysound: svplaysound 2 0 null.wav
		EmitSound(2, 0, "null.wav");
		SetProp(GetOwner(), "movetype", "const.movetype.bounce");
		SetVelocity(GetOwner(), Vector3(-110, 110, 110));
	}

}

}
