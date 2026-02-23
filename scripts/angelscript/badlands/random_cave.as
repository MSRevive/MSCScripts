#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class RandomCave : CGameScript
{
	void OnSpawn() override
	{
		string RND_TRIG = RandomInt(1, 3);
		string TRIG_STRING = "caveent";
		TRIG_STRING += RND_TRIG;
		UseTrigger(TRIG_STRING);
	}

}

}
