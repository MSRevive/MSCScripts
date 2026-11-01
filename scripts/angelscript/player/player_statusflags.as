#pragma context server

namespace MS
{

class PlayerStatusflags : CGameScript
{
	int game.effect.canattack;
	int game.effect.canduck;
	int game.effect.canjump;
	int game.effect.canmove;
	int game.effect.canrun;

	PlayerStatusflags()
	{
		game.effect.canmove = 1;
		game.effect.canrun = 1;
		game.effect.canjump = 1;
		game.effect.canduck = 1;
		game.effect.canattack = 1;
	}

	void set_status_flags()
	{
		game.effect.canmove = param1;
		game.effect.canrun = param2;
		game.effect.canjump = param3;
		game.effect.canduck = param4;
		game.effect.canattack = param5;
	}

	void set_status_canmove()
	{
		game.effect.canmove = param1;
	}

	void set_status_canrun()
	{
		game.effect.canrun = param1;
	}

	void set_status_canjump()
	{
		game.effect.canjump = param1;
	}

	void set_status_canduck()
	{
		game.effect.canduck = param1;
	}

	void set_status_canattack()
	{
		game.effect.canattack = param1;
	}

}

}
