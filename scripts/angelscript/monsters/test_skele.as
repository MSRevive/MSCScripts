#pragma context server

namespace MS
{

class TestSkele : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(1);
		SetModel("monsters/skeleton3.mdl");
		SetWidth(32);
		SetHeight(96);
		SetRace("hated");
	}

}

}
