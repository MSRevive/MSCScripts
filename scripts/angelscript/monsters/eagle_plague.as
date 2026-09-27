#pragma context server

#include "monsters/eagle_base.as"

namespace MS
{

class EaglePlague : CGameScript
{
	float DMG_ATTACK;
	int DMG_DOT_BURN;
	int MELEE_ATTACK;
	int NO_DIVE;
	int NPC_GIVE_EXP;

	EaglePlague()
	{
		NO_DIVE = 1;
		DMG_DOT_BURN = RandomInt(5, 20);
		DMG_ATTACK = Random(10, 40);
		NPC_GIVE_EXP = 250;
	}

	void OnSpawn() override
	{
		SetName("Plague Bird");
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
		SetProp(GetOwner(), "skin", 2);
	}

	void game_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			if (RandomInt(1, 5) == 1)
			{
				ApplyEffect(param2, "effects/dot_poison", 20, GetEntityIndex(GetOwner()), DMG_DOT_BURN);
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(20, 200, 10));
		}
		MELEE_ATTACK = 0;
	}

}

}
