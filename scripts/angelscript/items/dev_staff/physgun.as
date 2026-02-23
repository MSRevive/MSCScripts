#pragma context server

namespace MS
{

class Physgun : CGameScript
{
	string BEAM_TARGET;
	int PHYSGUN_ON;
	int PHYS_KEEP_DIST;

	Physgun()
	{
		PHYSGUN_ON = 0;
		PHYS_KEEP_DIST = 0;
	}

	void try_physgun()
	{
		if (!(PHYSGUN_ON))
		{
			find_beam_target();
			if (BEAM_TARGET != "none")
			{
				if (GetEntityOrigin(BEAM_TARGET) != "(0.00,0.00,0.00)")
				{
					PHYSGUN_ON = 1;
					PHYS_KEEP_DIST = Distance(GetEntityOrigin(GetOwner()), GetEntityOrigin(BEAM_TARGET));
					SendColoredMessage(GetOwner(), "Linked physgun to GetEntityName(BEAM_TARGET)");
					update_physgun_target();
				}
			}
		}
		else
		{
			update_physgun_target();
		}
	}

	void update_physgun_target()
	{
		if (!(IsEntityAlive(BEAM_TARGET)))
		{
			BEAM_TARGET = "none";
			PHYSGUN_ON = 0;
			return;
		}
		string L_TARG_POS = /* TODO: $relpos */ $relpos(GetEntityProperty(GetOwner(), "viewangles"), Vector3(0, PHYS_KEEP_DIST, 0));
		L_TARG_POS += GetEntityProperty(GetOwner(), "eyepos");
		SetEntityOrigin(BEAM_TARGET, L_TARG_POS);
		SetVelocity(BEAM_TARGET, Vector3(0, 0, 0));
		Effect("glow", BEAM_TARGET, Vector3(50, 50, 255), 72, 0.2, 0.2);
	}

	void target_freeze()
	{
	}

	void game__attack1()
	{
		if (!(PHYSGUN_ON)) return;
		PHYSGUN_ON = 0;
		BEAM_TARGET = "none";
	}

}

}
