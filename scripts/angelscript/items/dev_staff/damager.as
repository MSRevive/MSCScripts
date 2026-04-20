#pragma context server

namespace MS
{

class Damager : CGameScript
{
	int DAMAGER_DMG;

	Damager()
	{
		DAMAGER_DMG = 3;
	}

	void try_damage()
	{
		find_beam_target();
		XDoDamage(BEAM_TARGET, "direct", DAMAGER_DMG, 100, GetOwner(), GetOwner(), "none", "apostle_effect");
	}

	void set_damager()
	{
		DAMAGER_DMG = param1;
	}

}

}
