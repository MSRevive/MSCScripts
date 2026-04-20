#pragma context server

#include "monsters/skeleton_ice_enraged.as"

namespace MS
{

class SkeletonIceEnragedOnce : CGameScript
{
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;

	SkeletonIceEnragedOnce()
	{
		SKEL_RESPAWN_CHANCE = 0.0;
		SKEL_RESPAWN_LIVES = 0;
	}

}

}
