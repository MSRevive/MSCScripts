#pragma context server

#include "monsters/wolf_base.as"

namespace MS
{

class Wolf : CGameScript
{
	int NPC_GIVE_EXP;
	string NPC_PET_TYPE;

	Wolf()
	{
		NPC_GIVE_EXP = 30;
		NPC_PET_TYPE = "wolf";
		const string NPC_PET_SCRIPT = "monsters/companion/pet_wolf";
	}

}

}
