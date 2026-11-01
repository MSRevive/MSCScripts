#pragma context server

#include "items/base_crystal.as"

namespace MS
{

class ItemCrystalReturn : CGameScript
{
	int SKILL_LEVEL_REQ;
	string SKILL_TYPE;

	ItemCrystalReturn()
	{
		SKILL_LEVEL_REQ = 0;
		SKILL_TYPE = "skill.spellcasting";
	}

	void crystal_spawn()
	{
		SetName("Crystal of Return");
		SetDescription("This crystal will return you to the last spawn point.");
		SetWeight(5);
		SetSize(5);
		SetValue(50);
		SetHand("both");
	}

	void activate_crystal()
	{
		Effect("screenfade", GetOwner(), 2, 0.5, Vector3(0, 0, 0), 255, "fadein");
		string L_RESPAWN_POINT = GetEntityProperty(GetOwner(), "scriptvar");
		if (L_RESPAWN_POINT != "NEW_SPAWN_POS")
		{
			SetEntityOrigin(GetOwner(), L_RESPAWN_POINT);
		}
		else
		{
			Respawn();
		}
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
	}

}

}
