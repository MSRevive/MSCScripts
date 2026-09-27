#pragma context server

namespace MS
{

class ArmorBody : CGameScript
{
	ArmorBody()
	{
		DeleteEntity(GetOwner());
	}

}

}
