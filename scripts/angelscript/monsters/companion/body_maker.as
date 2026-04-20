#pragma context server

namespace MS
{

class BodyMaker : CGameScript
{
	void game_dynamically_created()
	{
	}

	void remove_me()
	{
		RemoveScript();
		DeleteEntity(GetOwner());
	}

}

}
