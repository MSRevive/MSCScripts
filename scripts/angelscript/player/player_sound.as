#pragma context server

namespace MS
{

class PlayerSound : CGameScript
{
	string SOUND_DEATH;

	PlayerSound()
	{
		SOUND_DEATH = GetEntityProperty(GetOwner(), "scriptvar");
	}

}

}
