#pragma context client

namespace MS
{

class MakeLight : CGameScript
{
	void client_activate()
	{
		string L_POS = param1;
		string L_RAD = param2;
		string L_COL = param3;
		string L_DUR = param4;
		ClientEffect("light", "new", L_POS, L_RAD, L_COL, L_DUR);
		L_DUR += 0.1;
		L_DUR("remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
