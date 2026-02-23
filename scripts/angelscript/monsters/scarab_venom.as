#pragma context server

#include "monsters/scarab_fire.as"

namespace MS
{

class ScarabVenom : CGameScript
{
	ScarabVenom()
	{
		const string EFFECT_SCRIPT = "effects/dot_poison";
		const float EFFECT_DURATION = 10.0;
	}

	void scarab_spawn()
	{
		SetName("Jade Scarab");
		SetModel("monsters/scarab.mdl");
		SetHealth(150);
		SetWidth(16);
		SetHeight(16);
		SetRoam(true);
		SetRace("vermin");
		SetHearingSensitivity(8);
		SetDamageResistance("holy", 0.0);
		SetBloodType("green");
		SetMoveAnim(ANIM_MOVE);
		SetIdleAnim(ANIM_IDLE);
		SetSolid("none");
		SetProp(GetOwner(), "skin", 1);
	}

}

}
