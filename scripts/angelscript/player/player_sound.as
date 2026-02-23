#pragma context server

namespace MS
{

class PlayerSound : CGameScript
{
	PlayerSound()
	{
		const string SOUND_DEATH = GetEntityProperty(GetOwner(), "scriptvar");
	}

}

}
