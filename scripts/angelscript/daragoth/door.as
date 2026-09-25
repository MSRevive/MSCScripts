#pragma context server

namespace MS
{

class Door : CGameScript
{
	void alarm()
	{
		LogDebug("Door opened");
		// svplaysound: emitsound ent_me (0,0,0) 10 5 combat
		EmitSound(GetOwner(), Vector3(0, 0, 0), 10, 5, "combat");
	}

}

}
