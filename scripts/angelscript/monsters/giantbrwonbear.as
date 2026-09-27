#pragma context server

namespace MS
{

class Giantbrwonbear : CGameScript
{
	void OnSpawn() override
	{
		SetInvincible(true);
		SetHealth(1);
		SetEntityOrigin(GetOwner(), Vector3(10000, 10000, 10000));
		SetName("sky_verify");
	}

}

}
