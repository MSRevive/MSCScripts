#pragma context server

#include "monsters/eagle_base.as"

namespace MS
{

class LostSoul : CGameScript
{
	int AM_DEAD;
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int COUNT_ATK;
	int DEATH_ATTACK;
	string DEATH_TIME;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int MONSTER_HP;
	string MY_OWNER;
	int NPC_GIVE_EXP;

	LostSoul()
	{
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		const int NO_DIVE = 1;
		const string DMG_ATTACK = Random(10, 40);
		NPC_GIVE_EXP = 100;
		MONSTER_HP = 300;
		const string SOUND_WARCRY = "controller/con_pain3.wav";
		const string SOUND_DEATH = "controller/con_die1.wav";
		const string SOUND_ATTACK = "controller/con_pain2.wav";
		const string SOUND_STRUCK = "debris/flesh2.wav";
		const string SOUND_PAIN = "controller/con_pain1.wav";
		const string SOUND_PAIN2 = "controller/con_die2.wav";
		const string SOUND_VICTORY = "controller/con_die2.wav";
		const int DMG_SPLODIE = 100;
		const int DMG_POISON = 25;
		ANIM_IDLE = "idle";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "idle";
		ANIM_WALK = "idle";
		ANIM_RUN = "idle";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.1, 1.0));
		if (m_hAttackTarget == "unset")
		{
		}
		AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(Random(-100, 100), 0, 0)));
	}

	void OnSpawn() override
	{
		skull_spawn();
	}

	void skull_spawn()
	{
		SetName("Lost Soul");
		SetRace("demon");
		if (MONSTER_HP == "MONSTER_HP")
		{
			SetHealth(300);
		}
		else
		{
			SetHealth(MONSTER_HP);
		}
		SetBloodType("green");
		SetWidth(16);
		SetHeight(16);
		SetModel("monsters/skull.mdl");
		SetIdleAnim("idle");
		SetMoveAnim("idle");
		SetHearingSensitivity(11);
		SetRoam(true);
		SetFly(true);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 4.0);
		IMMUNE_VAMPIRE = 1;
		COUNT_ATK = 0;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		SetRace(GetEntityRace(MY_OWNER));
		AM_SUMMONED = 1;
		MONSTER_HP = 300;
		SetMonsterClip(0);
		if (GetEntityRace(MY_OWNER) == 0)
		{
			SetRace("demon");
		}
		if (param2 != "PARAM2")
		{
			SetDamageMultiplier(param2);
			MONSTER_HP *= param2;
		}
		SetHealth(MONSTER_HP);
		if (!(param3 != "PARAM3")) return;
		string GO_BOOM = param3;
		GO_BOOM("self_destruct");
	}

	void self_destruct()
	{
		npc_suicide();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		skull_death();
	}

	void skull_death()
	{
		DEATH_TIME = GetGameTime();
		AM_DEAD = 1;
		DEATH_TIME += 0.2;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		string SPLODE_POS = /* TODO: $relpos */ $relpos(0, 0, 0);
		ClientEvent("new", "all", "effects/sfx_splodie", SPLODE_POS, Vector3(0, 255, 0));
		DEATH_ATTACK = 1;
		XDoDamage(SPLODE_POS, 128, DMG_SPLODE, 0, GetOwner(), GetOwner(), "none", "blunt");
	}

	void attack1()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 5);
		DoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_ATTACK, 0.9, "slash");
		COUNT_ATK += 1;
		if (COUNT_ATK > FLEE_COUNT)
		{
			COUNT_ATK = 0;
			npcatk_suspend_ai(3.0);
			SetMoveDest(HUNT_LASTTARGET);
		}
	}

	void game_dodamage()
	{
		if ((CUSTOM_DAMAGE)) return;
		if ((DEATH_ATTACK))
		{
			if (GetGameTime() < DEATH_TIME)
			{
			}
			if ((IsEntityAlive(param2)))
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			string TARGET_ORG = GetEntityOrigin(param2);
			string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
			string NEW_YAW = TARG_ANG;
			SetVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
			ApplyEffect(param2, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DMG_POISON);
		}
		else
		{
			if ((param1))
			{
			}
			if ((IsEntityAlive(GetOwner())))
			{
			}
			if ((IsEntityAlive(param2)))
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(20, 200, 10));
		}
	}

}

}
