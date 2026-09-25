#pragma context server

namespace MS
{

class MagicHandLightningChainCl : CGameScript
{
	string CASTER_INDEX;
	string CL_HAND1;
	string CL_HAND2;
	string IDX_LIST;

	void client_activate()
	{
		CASTER_INDEX = param1;
	}

	void draw_beams()
	{
		IDX_LIST = param1;
		string FIRST_TARGET = GetToken(IDX_LIST, 0, ";");
		string FIRST_TARGET_ORG = /* TODO: $getcl */ $getcl(FIRST_TARGET, "origin");
		FIRST_TARGET_ORG += "z";
		if ("game.localplayer.index" == CASTER_INDEX)
		{
			if (!("game.localplayer.thirdperson"))
			{
			}
			int USE_VIEWMODEL = 1;
		}
		if ((USE_VIEWMODEL))
		{
			CL_HAND1 = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 16);
			CL_HAND2 = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 35);
		}
		else
		{
			string CL_HAND1 = /* TODO: $getcl */ $getcl(CASTER_INDEX, "bonepos", 21);
			string CL_HAND2 = /* TODO: $getcl */ $getcl(CASTER_INDEX, "bonepos", 38);
		}
		ClientEffect("beam_points", CL_HAND1, FIRST_TARGET_ORG, "lgtning.spr", 0.5, 5.0, 0.5, 255, 50, 30, Vector3(60, 60, 255));
		ClientEffect("beam_points", CL_HAND2, FIRST_TARGET_ORG, "lgtning.spr", 0.5, 5.0, 0.5, 255, 50, 30, Vector3(60, 60, 255));
		for (int i = 0; i < GetTokenCount(IDX_LIST, ";"); i++)
		{
			draw_beams_loop();
		}
	}

	void draw_beams_loop()
	{
		string CUR_LOOP = i;
		string NEXT_LOOP = CUR_LOOP;
		NEXT_LOOP += 1;
		if (!(NEXT_LOOP < GetTokenCount(IDX_LIST, ";"))) return;
		string CUR_IDX = GetToken(IDX_LIST, CUR_LOOP, ";");
		string CUR_IDX_ORG = /* TODO: $getcl */ $getcl(CUR_IDX, "origin");
		CUR_IDX_ORG += "z";
		string NEXT_IDX = GetToken(IDX_LIST, NEXT_IDX, ";");
		string NEXT_IDX_ORG = /* TODO: $getcl */ $getcl(NEXT_IDX, "origin");
		NEXT_IDX_ORG += "z";
		ClientEffect("beam_points", CUR_IDX_ORG, NEXT_IDX_ORG, "lgtning.spr", 0.5, 5.0, 0.5, 255, 50, 30, Vector3(60, 60, 255));
	}

}

}
