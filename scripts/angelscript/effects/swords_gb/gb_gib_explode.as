#pragma context server

#include "effects/gib_explode.as"

namespace MS
{

class GbGibExplode : CGameScript
{
	string FX_DAMAGE;
	string GIB_INFLICTER;
	string SWORD_ID;

	GbGibExplode()
	{
		GIB_INFLICTER = SWORD_ID;
	}

	void game_dynamically_created()
	{
		SWORD_ID = param6;
		FX_DAMAGE = GetEntityProperty(SWORD_ID, "scriptvar");
	}

}

}
