#pragma context server

#include "beta_date.as"
#include "world/sv_world.as"
#include "world/server/commands.as"
#include "world/server/time.as"
#include "world/server/time_vote.as"
#include "world/server/player_vote.as"
#include "world/server/help.as"
#include "world/server/maps.as"
#include "$currentmapscript.as"
#include "world/cl_world.as"

namespace MS
{

class World : CGameScript
{
	World()
	{
		SetName("msworld");
	}

}

}
