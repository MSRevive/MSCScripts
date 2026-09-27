#pragma context server

#include "monsters/eagle_base.as"

namespace MS
{

class EagleMetal : CGameScript
{
	float DMG_ATTACK;
	int DMG_DOT_BURN;
	int IS_UNHOLY;
	int MELEE_ATTACK;
	int NO_DIVE;
	int NPC_GIVE_EXP;
	string SOUND_PAIN;
	string SOUND_PAIN2;
	string SOUND_STRUCK;

	EagleMetal()
	{
		IS_UNHOLY = 1;
		NO_DIVE = 1;
		DMG_DOT_BURN = RandomInt(10, 30);
		DMG_ATTACK = Random(10, 40);
		NPC_GIVE_EXP = 400;
		SOUND_STRUCK = "weapons/axemetal1.wav";
		SOUND_PAIN = "weapons/axemetal2.wav";
		SOUND_PAIN2 = "doors/doorstop5.wav";
	}

	void OnSpawn() override
	{
		SetName("Eagle made of metal");
		SetRace("demon");
		SetHealth(800);
		SetBloodType("none");
		SetWidth(32);
		SetHeight(32);
		SetModel("monsters/eagle.mdl");
		SetIdleAnim("flapping");
		SetMoveAnim("flapping");
		SetHearingSensitivity(11);
		SetRoam(true);
		SetFly(true);
		SetDamageResistance("all", 0.25);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("lightning", 3.0);
		SetProp(GetOwner(), "skin", 5);
	}

	void game_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			if (RandomInt(1, 10) == 1)
			{
				ApplyEffect(param2, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(30, 300, 30));
		}
		MELEE_ATTACK = 0;
	}

}

}
