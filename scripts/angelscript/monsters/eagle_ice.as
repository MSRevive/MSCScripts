#pragma context server

#include "monsters/eagle_base.as"

namespace MS
{

class EagleIce : CGameScript
{
	int IS_UNHOLY;
	int MELEE_ATTACK;
	int NPC_GIVE_EXP;

	EagleIce()
	{
		IS_UNHOLY = 1;
		const int NO_DIVE = 1;
		const string DMG_DOT_BURN = RandomInt(10, 30);
		const string DMG_ATTACK = Random(10, 40);
		NPC_GIVE_EXP = 250;
		const string SOUND_STRUCK = "debris/glass1.wav";
		const string SOUND_PAIN = "debris/glass2.wav";
		const string SOUND_PAIN2 = "debris/glass3.wav";
	}

	void OnSpawn() override
	{
		SetName("Eagle made of ice");
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
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("fire", 3.0);
		SetProp(GetOwner(), "skin", 4);
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
				ApplyEffect(param2, "effects/dot_cold", 10, GetEntityIndex(GetOwner()), DMG_DOT_BURN);
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(20, 200, 10));
		}
		MELEE_ATTACK = 0;
	}

}

}
