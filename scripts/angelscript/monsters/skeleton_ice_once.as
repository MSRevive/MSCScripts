#pragma context server

#include "monsters/skeleton_ice.as"

namespace MS
{

class SkeletonIceOnce : CGameScript
{
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;

	SkeletonIceOnce()
	{
		SKEL_RESPAWN_CHANCE = 0.0;
		SKEL_RESPAWN_LIVES = 0;
	}

}

}
