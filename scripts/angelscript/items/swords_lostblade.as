#pragma context server

namespace MS
{

class SwordsLostblade : CGameScript
{
	SwordsLostblade()
	{
		DeleteEntity(GetOwner());
	}

}

}
