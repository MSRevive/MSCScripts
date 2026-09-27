#pragma context server

namespace MS
{

class DynamicBeamCl : CGameScript
{
	string DBEAM_COLOR;
	int DBEAM_ON;
	string DBEAM_OWNER;
	string DBEAM_TARGET;
	string DBEAM_TARGET_LIST;
	string DBEAM_WIDTH;
	int MULTI_BEAM;
	string USE_BONES;
	string USE_BONE_IDX;

	void client_activate()
	{
		SetCallback("render", "enable");
		DBEAM_OWNER = param1;
		DBEAM_COLOR = param2;
		DBEAM_WIDTH = param3;
		if (param4 != "PARAM4")
		{
			USE_BONES = 1;
			USE_BONE_IDX = param4;
		}
	}

	void dbeam_color()
	{
		DBEAM_COLOR = param1;
		DBEAM_WIDTH = param2;
	}

	void dbeam_off()
	{
		DBEAM_ON = 0;
		MULTI_BEAM = 0;
	}

	void dbeam_on()
	{
		DBEAM_ON = 1;
	}

	void dbeam_target()
	{
		DBEAM_ON = 1;
		MULTI_BEAM = 0;
		DBEAM_TARGET = param1;
	}

	void dbeam_target_multi()
	{
		DBEAM_ON = 0;
		DBEAM_TARGET_LIST = param1;
		for (int i = 0; i < GetTokenCount(DBEAM_TARGET_LIST, ";"); i++)
		{
			multi_beam();
		}
	}

	void game_prerender()
	{
		if (!(DBEAM_ON)) return;
		if (!(USE_BONES))
		{
			ClientEffect("beam_points", /* TODO: $getcl */ $getcl(DBEAM_OWNER, "origin"), /* TODO: $getcl */ $getcl(DBEAM_TARGET, "origin"), "lgtning.spr", 0.1, DBEAM_WIDTH, 0.1, 255, 50, 30, DBEAM_COLOR);
		}
		if ((USE_BONES))
		{
			string CL_BEAM_START = /* TODO: $getcl */ $getcl(DBEAM_OWNER, "bonepos", USE_BONE_IDX);
			ClientEffect("beam_points", CL_BEAM_START, /* TODO: $getcl */ $getcl(DBEAM_TARGET, "origin"), "lgtning.spr", 0.001, DBEAM_WIDTH, 0.1, 255, 50, 30, DBEAM_COLOR);
		}
	}

	void multi_beam()
	{
		string CUR_TARGET = GetToken(DBEAM_TARGET_LIST, i, ";");
		string CUR_TARGET_ORG = /* TODO: $getcl */ $getcl(CUR_TARGET, "origin");
		ClientEffect("beam_points", /* TODO: $getcl */ $getcl(DBEAM_OWNER, "origin"), CUR_TARGET_ORG, "lgtning.spr", 0.01, DBEAM_WIDTH, 0.1, 255, 50, 30, DBEAM_COLOR);
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
