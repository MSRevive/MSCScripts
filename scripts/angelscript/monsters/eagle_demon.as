#pragma context server

#include "monsters/eagle_base.as"

namespace MS
{

class EagleDemon : CGameScript
{
	int AM_PHLAMES;
	float DMG_ATTACK;
	int DMG_DOT_BURN;
	int IS_UNHOLY;
	int MELEE_ATTACK;
	int NO_DIVE;
	int NPC_GIVE_EXP;
	int NPC_SUMMON;

	EagleDemon()
	{
		IS_UNHOLY = 1;
		NO_DIVE = 1;
		DMG_DOT_BURN = RandomInt(20, 40);
		DMG_ATTACK = Random(10, 40);
		NPC_GIVE_EXP = 250;
	}

	void OnSpawn() override
	{
		SetName("Fowl Demon");
		SetRace("demon");
		SetHealth(600);
		SetWidth(32);
		SetHeight(32);
		SetModel("monsters/eagle.mdl");
		SetIdleAnim("flapping");
		SetMoveAnim("flapping");
		SetHearingSensitivity(11);
		SetRoam(true);
		SetFly(true);
		SetDamageResistance("poison", 1.0);
		SetDamageResistance("cold", 3.0);
		SetDamageResistance("holy", 3.0);
		SetDamageResistance("fire", 0.0);
		SetProp(GetOwner(), "skin", 1);
	}

	void game_dodamage()
	{
		LogDebug("game_dodamage");
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			if (RandomInt(1, 5) == 1)
			{
				ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_DOT_BURN);
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(20, 200, 10));
		}
		MELEE_ATTACK = 0;
	}

	void phlames_eagle()
	{
		AM_PHLAMES = 1;
		G_FLAMES_EAGLES += 1;
		G_NPC_SUMMON_COUNT += 1;
		NPC_SUMMON = 1;
		LogDebug("set_summon G_NPC_SUMMON_COUNT");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		G_FLAMES_EAGLES -= 1;
	}

}

}
