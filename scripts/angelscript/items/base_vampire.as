#pragma context server

namespace MS
{

class BaseVampire : CGameScript
{
	int CAN_VAMPIRE_TARGET;

	void try_vampire_target()
	{
		CAN_VAMPIRE_TARGET = 0;
		check_can_vampire(param1, param2);
		if (!(CAN_VAMPIRE_TARGET)) return;
		HealEntity(param1, param3);
		EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 5);
	}

	void check_can_vampire()
	{
		string L_VAMPIRE = param1;
		string L_DAMSEL = param2;
		string L_RELATIONSHIP = GetRelationship(L_VAMPIRE);
		if (!(GetEntityRace(L_DAMSEL) != "undead")) return;
		if ((GetEntityProperty(L_DAMSEL, "scriptvar"))) return;
		if (!(L_RELATIONSHIP != "ally")) return;
		if (!(L_RELATIONSHIP != "neutral")) return;
		if (!(L_RELATIONSHIP != "none")) return;
		CAN_VAMPIRE_TARGET = 1;
	}

}

}
