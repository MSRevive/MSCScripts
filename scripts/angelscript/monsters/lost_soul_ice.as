#pragma context server

#include "monsters/lost_soul.as"

namespace MS
{

class LostSoulIce : CGameScript
{
	int AM_DEAD;
	int AM_SUMMONED;
	int COUNT_ATK;
	int CUSTOM_DAMAGE;
	int DEATH_ATTACK;
	string DEATH_TIME;
	int DMG_SPLODIE;
	int DOT_COLD;
	int IMMUNE_VAMPIRE;
	int MONSTER_HP;
	string MY_OWNER;
	int NO_DIVE;

	LostSoulIce()
	{
		MONSTER_HP = 500;
		DMG_SPLODIE = 200;
		DOT_COLD = 30;
		CUSTOM_DAMAGE = 1;
		NO_DIVE = 1;
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
		SetBloodType("none");
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
		SetDamageResistance("cold", 0.0);
		IMMUNE_VAMPIRE = 1;
		COUNT_ATK = 0;
		SetProp(GetOwner(), "skin", 1);
	}

	void skull_death()
	{
		DEATH_TIME = GetGameTime();
		AM_DEAD = 1;
		DEATH_TIME += 0.2;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		string SPLODE_POS = /* TODO: $relpos */ $relpos(0, 0, 0);
		ClientEvent("new", "all", "effects/sfx_splodie", SPLODE_POS, Vector3(128, 128, 255));
		DEATH_ATTACK = 1;
		XDoDamage(SPLODE_POS, 128, DMG_SPLODE, 0, GetOwner(), GetOwner(), "none", "blunt");
	}

	void game_dodamage()
	{
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
			ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_COLD);
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
			ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_COLD);
		}
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		SetRace(GetEntityRace(MY_OWNER));
		AM_SUMMONED = 1;
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

}

}
