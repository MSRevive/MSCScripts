#pragma context server

#include "monsters/elf_wizard_base.as"

namespace MS
{

class TelfWizardXbow : CGameScript
{
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int NPC_GIVE_EXP;

	TelfWizardXbow()
	{
		NPC_GIVE_EXP = 1500;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 300;
		const int ELF_IS_ARCHER = 1;
		const int ELF_EXPLOSIVE_BOLTS = 1;
		const string ELF_MELEE_PUSH_VEL = /* TODO: $relvel */ $relvel(10, 400, 110);
		const int DMG_MELEE = 25;
		const int ATTACK_HITRANGE_MELEE = 64;
	}

	void elf_spawn()
	{
		SetName("Torkalath Apprentice");
		SetHealth(4000);
		SetRace("torkie");
		SetModelBody(1, 3);
		SetProp(GetOwner(), "skin", 2);
	}

}

}
