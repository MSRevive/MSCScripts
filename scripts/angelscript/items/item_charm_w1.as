#pragma context server

#include "items/base_crystal.as"

namespace MS
{

class ItemCharmW1 : CGameScript
{
	string CRYSTAL_ABORT_USE;

	ItemCharmW1()
	{
		const int SKILL_LEVEL_REQ = 0;
		const string SKILL_TYPE = "skill.spellcasting";
		const string PET_TYPE = "wolf";
		const string PET_SEARCH = "wolf";
		const int PET_MAXHP = 100;
		const string PET_FAIL_MESSAGE = "No wolves in range.";
		const string PET_YAY_MESSAGE = "You now have a new pet wolf!";
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
				SendColoredMessage(GetOwner(), "GetEntityName(FOUND_PET) is too strong to be charmed! It must be weakened first!");
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
			SendColoredMessage(GetOwner(), "PET_FAIL_MESSAGE");
		}
	}

	void activate_crystal()
	{
		CallExternal(GetEntityIndex(GetOwner()), "set_spawn_point", NEW_SPAWN_POS);
		Effect("screenfade", GetOwner(), 0.5, 1, Vector3(255, 255, 255), 255, "fadein");
		SendInfoMsg(GetOwner(), "PET PET_YAY_MESSAGE");
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
	}

}

}
