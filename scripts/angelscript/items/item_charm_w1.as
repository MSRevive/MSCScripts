#pragma context server

#include "items/base_crystal.as"

namespace MS
{

class ItemCharmW1 : CGameScript
{
	string CRYSTAL_ABORT_USE;
	string PET_FAIL_MESSAGE;
	int PET_MAXHP;
	string PET_SEARCH;
	string PET_TYPE;
	string PET_YAY_MESSAGE;
	int SKILL_LEVEL_REQ;
	string SKILL_TYPE;

	ItemCharmW1()
	{
		SKILL_LEVEL_REQ = 0;
		SKILL_TYPE = "skill.spellcasting";
		PET_TYPE = "wolf";
		PET_SEARCH = "wolf";
		PET_MAXHP = 100;
		PET_FAIL_MESSAGE = "No wolves in range.";
		PET_YAY_MESSAGE = "You now have a new pet wolf!";
	}

	void crystal_spawn()
	{
		SetName("Wolf Charm");
		SetDescription("This crystal can be used to tame one wolf");
		SetWeight(5);
		SetSize(5);
		SetValue(500);
		SetHand("both");
	}

	void check_use()
	{
		string OWNER_PETS = GetPlayerQuestData(GetOwner(), "pets");
		if ((OWNER_PETS).findFirst(PET_TYPE) >= 0)
		{
			CRYSTAL_ABORT_USE = 1;
			SendColoredMessage(GetOwner(), "You can only have one of this type of pet.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		CallExternal(GetOwner(), "ext_scan_pet", PET_SEARCH);
		string FOUND_PET = GetEntityProperty(GetOwner(), "scriptvar");
		if ((IsEntityAlive(FOUND_PET)))
		{
			if (GetEntityHealth(FOUND_PET) > PET_MAXHP)
			{
				CRYSTAL_ABORT_USE = 1;
				SendColoredMessage(GetOwner(), GetEntityName(FOUND_PET) + " is too strong to be charmed! It must be weakened first!");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			CallExternal(FOUND_PET, "ext_makepet", GetEntityIndex(GetOwner()));
		}
		else
		{
			CRYSTAL_ABORT_USE = 1;
			SendColoredMessage(GetOwner(), PET_FAIL_MESSAGE);
		}
	}

	void activate_crystal()
	{
		CallExternal(GetEntityIndex(GetOwner()), "set_spawn_point", NEW_SPAWN_POS);
		Effect("screenfade", GetOwner(), 0.5, 1, Vector3(255, 255, 255), 255, "fadein");
		SendInfoMsg(GetOwner(), PET + PET_YAY_MESSAGE);
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
	}

}

}
