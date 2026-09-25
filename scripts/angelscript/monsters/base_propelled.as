#pragma context server

namespace MS
{

class BasePropelled : CGameScript
{
	string NPC_HACKED_MOVE_SPEED;
	int NPC_PROPELLED;

	BasePropelled()
	{
		NPC_PROPELLED = 1;
	}

	void OnPostSpawn() override
	{
		if (NPC_HACKED_MOVE_SPEED == "NPC_HACKED_MOVE_SPEED")
		{
			NPC_HACKED_MOVE_SPEED = 250;
		}
	}

	void game_movingto_dest()
	{
		if ((NPC_PROPELL_SUSPEND)) return;
		if ((I_R_FROZEN)) return;
		SetAnimMoveSpeed(NPC_HACKED_MOVE_SPEED);
	}

	void game_stopmoving()
	{
		if ((NPC_PROPELL_SUSPEND)) return;
		SetAnimMoveSpeed(0);
	}

}

}
