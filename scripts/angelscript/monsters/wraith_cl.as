#pragma context client

namespace MS
{

class WraithCl : CGameScript
{
	int FX_ACTIVE;
	string MAX_RANGE;
	string MY_OWNER;
	string MY_TARGET;

	void client_activate()
	{
		MY_OWNER = param1;
		MY_TARGET = param2;
		MAX_RANGE = param3;
		FX_ACTIVE = 1;
		beam_loop();
		ScheduleDelayedEvent(2.0, "end_fx");
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		string MY_ORG = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		string TARG_ORG = /* TODO: $getcl */ $getcl(MY_TARGET, "origin");
		if (!(Distance(MY_ORG, TARG_ORG) < MAX_RANGE)) return;
		string RND_BONE = RandomInt(1, 15);
		string BEAM1_END = /* TODO: $getcl */ $getcl(MY_TARGET, "bonepos", RND_BONE);
		string RND_BONE = RandomInt(1, 15);
		string BEAM2_END = /* TODO: $getcl */ $getcl(MY_TARGET, "bonepos", RND_BONE);
		if ((BEAM1_END).x == 0)
		{
			string BEAM1_END = TARG_ORG;
		}
		if ((BEAM2_END).x == 0)
		{
			string BEAM2_END = TARG_ORG;
		}
		ClientEffect("beam_end", MY_OWNER, 1, BEAM1_END, "lgtning.spr", 0.001, 5.0, 0.5, 255, 50, 30, Vector3(60, 60, 255));
		ClientEffect("beam_end", MY_OWNER, 2, BEAM2_END, "lgtning.spr", 0.001, 5.0, 0.5, 255, 50, 30, Vector3(60, 60, 255));
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(0.5, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
