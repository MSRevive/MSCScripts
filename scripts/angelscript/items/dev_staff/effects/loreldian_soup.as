#pragma context server

namespace MS
{

class LoreldianSoup : CGameScript
{
	string game.effect.id;
	int game.effect.removeondeath;

	LoreldianSoup()
	{
		string reg.effect.name = "lsoup";
		game.effect.id = "lsoup";
		string reg.effect.flags = "nostack";
		string reg.effect.script = currentscript;
		game.effect.removeondeath = 1;
		// TODO: registereffect
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1);
		HealEntity(GetOwner(), 10000);
		GiveMP(10000);
	}

	void OnDamage(int damage) override
	{
		return;
	}

	void ext_remove_lsoup()
	{
		RemoveScript();
	}

}

}
