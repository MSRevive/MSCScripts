#pragma context server

#include "items/base_crystal.as"

namespace MS
{

class ItemCrystalReloc : CGameScript
{
	int BEAM_ROT;
	string OWNER_POS;

	ItemCrystalReloc()
	{
		const int SKILL_LEVEL_REQ = 0;
		const string SKILL_TYPE = "skill.spellcasting";
	}

	void crystal_spawn()
	{
		SetName("Crystal of Relocation");
		SetDescription("Once this crystal's magic is deployed it will define a new respawn point.");
		SetWeight(5);
		SetSize(5);
		SetValue(1000);
		SetHand("both");
	}

	void activate_crystal()
	{
		OWNER_POS = GetEntityOrigin(GetOwner());
		BEAM_ROT = 0;
		CallExternal(GetEntityIndex(GetOwner()), "set_spawn_point", OWNER_POS);
		for (int i = 0; i < 18; i++)
		{
			beams();
		}
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
	}

	void beams()
	{
		string BEAM_START = OWNER_POS;
		string BEAM_END = OWNER_POS;
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, BEAM_ROT, 0), Vector3(0, 32, -32));
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, BEAM_ROT, 0), Vector3(0, 32, 128));
		Effect("beam", "point", "lgtning.spr", 100, BEAM_START, BEAM_END, Vector3(255, 0, 255), 200, 16, 3);
		BEAM_ROT += 20;
	}

}

}
