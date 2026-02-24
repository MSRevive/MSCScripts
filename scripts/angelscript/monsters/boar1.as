#pragma context server

#include "monsters/boar.as"

namespace MS
{

class Boar1 : CGameScript
{
	int NPC_GIVE_EXP;

	void OnSpawn() override
	{
		SetHealth(15);
		SetWidth(50);
		SetHeight(40);
		if ((StringToLower(GetMapName())).findFirst("goblin") >= 0)
		{
			SetRace("goblin");
		}
		else
		{
			SetRace("wildanimal");
		}
		SetName("Tamed Boar");
		SetRoam(true);
		SetHearingSensitivity(0);
		NPC_GIVE_EXP = 6;
		SetModel("monsters/boar.mdl");
		SetModelBody(1, 0);
		SetIdleAnim("idle1");
		SetMoveAnim("walk");
		SetActionAnim("gore_forward");
		SetEntitySkin(GetOwner(), SKIN_NAME);
	}

	void npc_enemysighted()
	{
		SetMoveSpeed(1);
	}

	void npc_attack()
	{
	}

}

}
