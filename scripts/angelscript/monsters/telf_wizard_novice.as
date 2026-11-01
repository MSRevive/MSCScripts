#pragma context server

#include "monsters/elf_wizard_base.as"

namespace MS
{

class TelfWizardNovice : CGameScript
{
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int ELF_CAN_GUIDED;
	string ELF_GUIDED_DMG_TYPE;
	int ELF_IS_NOVICE;
	int ELF_PALM_ATTACK;
	int ELF_PALM_TYPE;
	int NPC_GIVE_EXP;

	TelfWizardNovice()
	{
		NPC_GIVE_EXP = 3000;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 300;
		ELF_IS_NOVICE = 1;
		ELF_PALM_ATTACK = 1;
		ELF_CAN_GUIDED = 1;
		ELF_GUIDED_DMG_TYPE = "magic";
		ELF_PALM_TYPE = RandomInt(1, 3);
	}

	void elf_spawn()
	{
		SetName("Torkalath Novice");
		SetHealth(5000);
		SetRace("torkie");
		SetModelBody(1, 0);
		SetProp(GetOwner(), "skin", 0);
	}

}

}
