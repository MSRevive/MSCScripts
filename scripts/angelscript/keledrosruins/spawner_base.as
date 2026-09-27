#pragma context server

namespace MS
{

class SpawnerBase : CGameScript
{
	int EXIST;

	SpawnerBase()
	{
		EXIST = 0;
	}

	void make_undead()
	{
		if (!(EXIST < 3)) return;
		string l.sky = "origin";
		l.sky += Vector3(0, 0, 4096);
		string origin = GetEntityOrigin(GetOwner());
		EXIST += 1;
		spawn_undead();
	}

	void undead_died()
	{
		EXIST -= 1;
	}

}

}
