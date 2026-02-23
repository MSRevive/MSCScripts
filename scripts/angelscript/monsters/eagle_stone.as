#pragma context server

#include "monsters/eagle_base.as"

namespace MS
{

class EagleStone : CGameScript
{
	int IS_UNHOLY;
	int NPC_GIVE_EXP;

	EagleStone()
	{
		IS_UNHOLY = 1;
		const int NO_DIVE = 1;
		const string DMG_ATTACK = Random(20, 60);
		NPC_GIVE_EXP = 300;
		const string SOUND_STRUCK = "weapons/axemetal1.wav";
		const string SOUND_PAIN = "weapons/axemetal2.wav";
		const string SOUND_PAIN2 = "debris/concrete1.wav";
	}

	void OnSpawn() override
	{
		SetName("Eagle made of stone");
		SetRace("demon");
		SetHealth(600);
		SetBloodType("none");
		SetWidth(32);
		SetHeight(32);
		SetModel("monsters/eagle.mdl");
		SetIdleAnim("flapping");
		SetMoveAnim("flapping");
		SetHearingSensitivity(11);
		SetRoam(true);
		SetFly(true);
		SetDamageResistance("all", 0.75);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("lightning", 0.5);
		SetProp(GetOwner(), "skin", 3);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(30, 300, 30));
	}

}

}
