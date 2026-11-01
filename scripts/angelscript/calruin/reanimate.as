#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Reanimate : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_FLINCH;
	string ANIM_GETUP;
	string ANIM_IDLE;
	string ANIM_IDLE_NORM;
	string ANIM_RUN;
	string ANIM_SIT;
	string ANIM_SWING;
	string ANIM_THROW;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string CYCLE_TIME;
	string DID_PUSH;
	int I_AM_TURNABLE;
	int LAST_STOLE_HP;
	int LEGIT_MAP;
	string MONSTER_MODEL;
	int MOVE_RANGE;
	int NPC_BOSS_REGEN_RATE;
	string NPC_EXP_MULTI;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int NPC_NO_MOVE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_BROTHER;
	string SOUND_HEAL;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_PUSH;
	string SOUND_SPAWN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int THROW_CHANCE;

	Reanimate()
	{
		if ((StringToLower(GetMapName())).findFirst("calruin") == 0)
		{
			NPC_IS_BOSS = 1;
		}
		if (!(NPC_IS_BOSS))
		{
			NPC_EXP_MULTI = 0.25;
		}
		NPC_BOSS_REGEN_RATE = 0;
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_SIT = "sitidle";
		ANIM_IDLE_NORM = "idle1";
		ANIM_GETUP = "sitstand";
		ANIM_SWING = "attack3";
		ANIM_THROW = "attack2";
		ANIM_ATTACK = ANIM_SWING;
		ATTACK_DAMAGE = 30;
		ATTACK_RANGE = 140;
		MOVE_RANGE = 65;
		ATTACK_HITRANGE = 175;
		ATTACK_HITCHANCE = 0.85;
		ANIM_IDLE = ANIM_IDLE_NORM;
		SOUND_STRUCK1 = "controller/con_pain3.wav";
		SOUND_STRUCK2 = "controller/con_pain3.wav";
		SOUND_STRUCK3 = "none";
		SOUND_PAIN = "zombie/zo_pain2.wav";
		SOUND_ATTACK1 = "controller/con_attack1.wav";
		SOUND_HEAL = "monsters/skeleton/calrian2.wav";
		SOUND_ATTACK2 = "controller/con_attack2.wav";
		SOUND_BROTHER = "monsters/skeleton/calrian.wav";
		SOUND_IDLE1 = "controller/con_attack3.wav";
		SOUND_SPAWN = "monsters/skeleton/calrian2.wav";
		SOUND_PUSH = "monsters/skeleton/calrain3.wav";
		ANIM_FLINCH = "laflinch";
		THROW_CHANCE = 30;
		Precache(SOUND_DEATH);
		Precache(SOUND_SPAWN);
		MONSTER_MODEL = "monsters/skeleton_boss1.mdl";
		Precache(MONSTER_MODEL);
	}

	void OnSpawn() override
	{
		I_AM_TURNABLE = 0;
		SetHealth(2000);
		SetWidth(32);
		SetHeight(80);
		SetName("the re-animated bones of|Lord Calrian");
		SetRoam(false);
		SetHearingSensitivity(8);
		NPC_GIVE_EXP = 1000;
		SetRace("undead");
		SetModel(MONSTER_MODEL);
		SetModelBody(0, 1);
		SetModelBody(1, 1);
		SetDamageResistance("all", 0.65);
		SetIdleAnim(ANIM_SIT);
		SetMoveAnim(ANIM_SIT);
		SetInvincible(true);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("fire", 0.25);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("stun", 0.6);
		string MAP_NAME = GetMapName();
		LEGIT_MAP = 0;
		if (MAP_NAME == "calruin")
		{
			LEGIT_MAP = 1;
		}
		if (MAP_NAME == "calruin2")
		{
			LEGIT_MAP = 1;
		}
		if ((LEGIT_MAP))
		{
			int CHANCE = RandomInt(1, 3);
			if (CHANCE == 1)
			{
				GiveItem(GetOwner(), "scroll_summon_undead");
			}
			if (CHANCE == 2)
			{
				GiveItem(GetOwner(), "scroll2_summon_undead");
			}
			if (CHANCE == 3)
			{
				GiveItem(GetOwner(), "scroll2_turn_undead");
			}
			GiveItem(GetOwner(), "blunt_calrianmace");
		}
		LAST_STOLE_HP = 10;
		npcatk_suspend_ai();
		ScheduleDelayedEvent(8.0, "bring_it_on");
	}

	void bring_it_on()
	{
		PlayAnim("critical", ANIM_GETUP);
		EmitSound(GetOwner(), 0, "x/x_recharge1.wav", 10);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (m_hAttackTarget == "unset")
		{
			if ((CanSee("enemy", 700)))
			{
				npcatk_settarget(GetEntityIndex(m_hLastSeen), "saw_new_enemy");
			}
		}
	}

	void stand_complete()
	{
		SetInvincible(false);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		NPC_NO_MOVE = 0;
		CYCLE_TIME = CYCLE_TIME_BATTLE;
		npcatk_resume_ai();
		LookAt(GetOwner());
	}

	void attack_3()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE);
		if (LAST_STOLE_HP > 0)
		{
			LAST_STOLE_HP -= 1;
		}
		if (DID_PUSH == 1)
		{
			DID_PUSH = 0;
			int I_DID_PUSH = 1;
		}
		if ((I_DID_PUSH)) return;
		if (RandomInt(0, 1) == 0)
		{
			if (LAST_STOLE_HP < 3)
			{
				// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
				array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
				EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
			}
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		UseTrigger("endboss");
		if (!(LEGIT_MAP)) return;
		EmitSound(GetOwner(), 2, SOUND_BROTHER, 10);
		bm_gold_spew(10, 3, 40, 4, 20);
		SayText("You're too late! ... My brother is already here!");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (RandomInt(1, THROW_CHANCE) == 1)
		{
			PlayAnim("critical", ANIM_THROW);
			EmitSound(GetOwner(), 2, SOUND_PUSH, 10);
			string MY_LOC = GetMonsterProperty("origin");
			string NME_LOC = GetEntityOrigin(m_hLastStruckByMe);
			float NME_DISTANCE = Distance(MY_LOC, NME_LOC);
			if (NME_DISTANCE < ATTACK_HITRANGE)
			{
				ApplyEffect(param2, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
			}
			DID_PUSH = 1;
		}
	}

	void OnDamage(int damage) override
	{
		if (!((param3).findFirst("fire") >= 0)) return;
		if (!(THROW_CHANCE != 10)) return;
		THROW_CHANCE = 10;
		ScheduleDelayedEvent(3.0, "throw_reset");
	}

	void my_target_died()
	{
		if (!(SOUL_TARGET == GetEntityIndex(param1))) return;
		if (!(LAST_STOLE_HP == 0)) return;
		string ENEMY_MAXHP = GetEntityMaxHealth(param1);
		string ICE_CREAM_NAME = "Ice Wall";
		string NME_NAME = GetEntityName(m_hLastStruckByMe);
		SendInfoMsg(param1, "Lord_Calrian Beware, Lord Calrian gains double your max health when he slays you!");
		SetSayTextRange(1024);
		if (NME_NAME == ICE_CREAM_NAME)
		{
			SayText("Mmmmmmm... Ice cream!");
		}
		if (NME_NAME != ICE_CREAM_NAME)
		{
			SayText("Not even death can save you from me!");
		}
		EmitSound(GetOwner(), 2, SOUND_HEAL, 10);
		ENEMY_MAXHP *= 2.0;
		if (GetMonsterHP() < GetMonsterMaxHP())
		{
			HealEntity(GetOwner(), ENEMY_MAXHP);
		}
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 255, 2, 2);
		LAST_STOLE_HP = 10;
	}

	void throw_reset()
	{
		THROW_CHANCE = 30;
	}

}

}
