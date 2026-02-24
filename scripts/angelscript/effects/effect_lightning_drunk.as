#pragma context client

namespace MS
{

class EffectLightningDrunk : CGameScript
{
	string EFFECT_DURATION;
	int MAX_SWAY;
	float MAX_SWAY_AMT;
	int MAX_SWAY_RATE;
	int MAX_SWAY_T;
	int MIN_SWAY;
	float MIN_SWAY_AMT;
	int MIN_SWAY_RATE;
	int MIN_SWAY_T;
	string game.cleffect.move_ofs.forward;
	string game.cleffect.move_ofs.right;
	string game.cleffect.view_ofs.pitch;
	string game.cleffect.view_ofs.roll;

	EffectLightningDrunk()
	{
		MAX_SWAY = 10;
		MIN_SWAY = -10;
		MAX_SWAY_T = 5;
		MIN_SWAY_T = -5;
		MAX_SWAY_RATE = 5;
		MIN_SWAY_RATE = -5;
		MAX_SWAY_AMT = 0.2;
		MIN_SWAY_AMT = -0.2;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.3);
		drunk_sway();
	}

	void OnRepeatTimer_1()
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
		EFFECT_DURATION = param1;
		PARAM1("effect_die");
	}

	void effect_die()
	{
		RemoveScript();
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

}

}
