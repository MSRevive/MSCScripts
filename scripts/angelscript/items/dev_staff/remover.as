#pragma context server

namespace MS
{

class Remover : CGameScript
{
	string BEAM_TARGET;
	string LAST_REMOVE;
	float REMOVE_DELAY;

	Remover()
	{
		REMOVE_DELAY = 0.15;
	}

	void try_remove()
	{
		if (!(LAST_REMOVE < GetGameTime())) return;
		find_beam_target();
		if (!(BEAM_TARGET != "none")) return;
		if ((IsValidPlayer(BEAM_TARGET))) return;
		if (GetEntityOrigin(BEAM_TARGET) == "(0.00,0.00,0.00)")
		{
			SendColoredMessage(GetOwner(), "Removed map ent.");
			DeleteEntity(BEAM_TARGET);
		}
		else
		{
			SendColoredMessage(GetOwner(), "Removed " + GetEntityProperty(BEAM_TARGET, "name.full"));
			DeleteEntity(BEAM_TARGET);
		}
		LAST_REMOVE = (GetGameTime() + REMOVE_DELAY);
		BEAM_TARGET = "none";
	}

}

}
