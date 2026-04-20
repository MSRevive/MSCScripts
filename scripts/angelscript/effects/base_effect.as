#pragma context server

namespace MS
{

class BaseEffect : CGameScript
{
	string EFFECT_DURATION;
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string EFFECT_STARTED;
	string EFFECT_TIMELEFT;
	string game.effect.flags;
	string game.effect.id;
	int game.effect.removeondeath;

	BaseEffect()
	{
		EFFECT_ID = "base_effect";
		EFFECT_FLAGS = "EFFECT_FLAGS";
		EFFECT_SCRIPT = currentscript;
		game.effect.removeondeath = 1;
		game.effect.id = EFFECT_ID;
		game.effect.flags = EFFECT_FLAGS;
	}

	void game_precache()
	{
		string reg.effect.script = EFFECT_SCRIPT;
		string reg.effect.name = EFFECT_ID;
		string reg.effect.flags = EFFECT_FLAGS;
		// TODO: registereffect
	}

	void game_activate()
	{
		EFFECT_STARTED = GetGameTime();
		EFFECT_DURATION = param1;
		if (!(EFFECT_DURATION)) return;
		if (!(EFFECT_DURATION != "PARAM1")) return;
		EFFECT_DURATION("effect_duration_ended");
	}

	void effect_duration_ended()
	{
		string L_END_TIME = (EFFECT_STARTED + EFFECT_DURATION);
		if (GetGameTime() >= L_END_TIME)
		{
			RemoveScript();
		}
		else
		{
			string L_TIME_REMAINING = (L_END_TIME - GetGameTime());
			L_TIME_REMAINING("effect_duration_ended");
		}
	}

	void effect_increase_duration()
	{
		EFFECT_DURATION += param1;
	}

	void effect_set_duration()
	{
		EFFECT_STARTED = GetGameTime();
		effect_get_timeleft();
		if (param1 < EFFECT_TIMELEFT)
		{
			PARAM1("effect_duration_ended");
		}
		EFFECT_DURATION = param1;
	}

	void effect_get_timeleft()
	{
		EFFECT_TIMELEFT = (GetGameTime() - EFFECT_STARTED);
		EFFECT_TIMELEFT = (EFFECT_DURATION - EFFECT_TIMELEFT);
	}

	void effect_die()
	{
	}

	void game_duplicated()
	{
	}

}

}
