#pragma context server

#include "monsters/skeleton_ice_warrior.as"

namespace MS
{

class SkeletonIceWarriorOnce : CGameScript
{
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;

	SkeletonIceWarriorOnce()
	{
		SKEL_RESPAWN_CHANCE = 0.0;
		SKEL_RESPAWN_LIVES = 0;
	}

}

}
