#pragma context client

namespace MS
{

class SfxDrunk : CGameScript
{
	string DRUNK_SIDEMOVE;
	string game.cleffect.move_ofs.forward;
	string game.cleffect.move_ofs.right;
	int game.cleffect.move_scale.forward;
	int game.cleffect.move_scale.right;
	string game.cleffect.screenfade.alpha;
	int game.cleffect.screenfade.alphalimit;
	string game.cleffect.screenfade.blendduration;
	string game.cleffect.screenfade.color;
	string game.cleffect.screenfade.duration;
	int game.cleffect.screenfade.newfade;
	string game.cleffect.screenfade.type;
	string game.cleffect.view_ofs.pitch;
	string game.cleffect.view_ofs.roll;

	SfxDrunk()
	{
		const int MIN_STUMBLEAMT = -10;
		const int MAX_STUMBLEAMT = 10;
		const int STUMBLE_RIGHT_MAX = 80;
		const int STUMBLE_LEFT_MAX = -80;
		const int STUMBLE_RIGHT_TRESHHOLD = 30;
		const int STUMBLE_LEFT_TRESHHOLD = -30;
		const int STUMBLE_FORWARD_MAX = 40;
		const int STUMBLE_BACK_MAX = -50;
		const int STUMBLE_FORWARD_T = 20;
		const int STUMBLE_BACK_T = -20;
		const int MAX_SWAY = 10;
		const int MIN_SWAY = -10;
		const int MAX_SWAY_T = 8;
		const int MIN_SWAY_T = -8;
		const int MAX_SWAY_RATE = 1;
		const int MIN_SWAY_RATE = -1;
		const float MAX_SWAY_AMT = 0.1;
		const float MIN_SWAY_AMT = -0.1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(2.0);
		game.cleffect.screenfade.newfade = 1;
		game.cleffect.screenfade.alphalimit = 200;
		game.cleffect.screenfade.color = Vector3(10, 10, 10);
		game.cleffect.screenfade.alpha = RandomInt(100, 200);
		game.cleffect.screenfade.duration = Random(1, 3);
		game.cleffect.screenfade.blendduration = Random(1, 3);
		game.cleffect.screenfade.type = "fadein";
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.3);
		drunk_stumble();
		drunk_sway();
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(0.01);
		DRUNK_SWAY_FORWARD++;
		DRUNK_SWAY_FORWARD = max(MIN_SWAY, min(MAX_SWAY, DRUNK_SWAY_FORWARD));
		game.cleffect.view_ofs.pitch = DRUNK_SWAY_FORWARD;
		DRUNK_SWAY_SIDE++;
		DRUNK_SWAY_SIDE = max(MIN_SWAY, min(MAX_SWAY, DRUNK_SWAY_SIDE));
		game.cleffect.view_ofs.roll = DRUNK_SWAY_SIDE;
		game.cleffect.move_ofs.forward = DRUNK_FORWARDMOVE;
		game.cleffect.move_ofs.right = DRUNK_SIDEMOVE;
	}

	void client_activate()
	{
		PARAM1("effect_die");
	}

	void drunk_sway()
	{
		DRUNK_SWAY_RATE++;
		DRUNK_SWAY_RATE = max(MIN_SWAY_RATE, min(MAX_SWAY_RATE, DRUNK_SWAY_RATE));
		if (DRUNK_SWAY_SIDE >= MAX_SWAY_T)
		{
			DRUNK_SWAY_RATE--;
		}
		if (DRUNK_SWAY_SIDE <= MIN_SWAY_T)
		{
			DRUNK_SWAY_RATE++;
		}
		DRUNK_SWAY_RATE_F++;
		DRUNK_SWAY_RATE_F = max(MIN_SWAY_RATE, min(MAX_SWAY_RATE, DRUNK_SWAY_RATE_F));
		if (DRUNK_SWAY_FORWARD >= MAX_SWAY_T)
		{
			DRUNK_SWAY_RATE_F--;
		}
		if (DRUNK_SWAY_FORWARD <= MIN_SWAY_T)
		{
			DRUNK_SWAY_RATE_F++;
		}
	}

	void drunk_stumble()
	{
		DRUNK_FORWARDMOVE++;
		DRUNK_FORWARDMOVE = max(STUMBLE_BACK_MAX, min(STUMBLE_FORWARD_MAX, DRUNK_FORWARDMOVE));
		if (DRUNK_FORWARDMOVE >= STUMBLE_FORWARD_T)
		{
			DRUNK_FORWARDMOVE--;
		}
		if (DRUNK_FORWARDMOVE <= STUMBLE_BACK_T)
		{
			DRUNK_FORWARDMOVE++;
		}
		DRUNK_SIDEMOVE = DRUNK_SWAY_SIDE;
		DRUNK_SIDEMOVE *= RandomInt(0, 20);
		DRUNK_SIDEMOVE = max(STUMBLE_LEFT_MAX, min(STUMBLE_RIGHT_MAX, DRUNK_SIDEMOVE));
		if (DRUNK_SIDEMOVE >= STUMBLE_RIGHT_TRESHHOLD)
		{
			DRUNK_SIDEMOVE--;
		}
		if (DRUNK_SIDEMOVE <= STUMBLE_LEFT_TRESHHOLD)
		{
			DRUNK_SIDEMOVE++;
		}
		drunk_randomize_keys();
	}

	void drunk_randomize_keys()
	{
		game.cleffect.move_scale.forward = -1;
		game.cleffect.move_scale.right = -1;
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
