#pragma context client

namespace MS
{

class Halos : CGameScript
{
	string SFX_DUMMIES_FOR_DUMB_PEOPLE;
	int SFX_HALO_FRAME;
	string SFX_HALO_LIST;
	int SFX_TRACKING_HALOS;

	Halos()
	{
		SFX_HALO_LIST = "";
		SFX_DUMMIES_FOR_DUMB_PEOPLE = "";
		SFX_HALO_FRAME = 0;
		SFX_TRACKING_HALOS = 0;
	}

	void game_prerender()
	{
		if ((SFX_TRACKING_HALOS))
		{
			if (SFX_HALO_FRAME > 1000)
			{
				SFX_HALO_FRAME = 0;
			}
			for (int i = 0; i < GetTokenCount(SFX_HALO_LIST, ";"); i++)
			{
				cl_track_halos();
			}
			SFX_HALO_FRAME += 1;
		}
	}

	void cl_set_halo()
	{
		if (param1 == 2)
		{
			SFX_TRACKING_HALOS = 1;
			if (FindToken(SFX_DUMMIES_FOR_DUMB_PEOPLE, param2, ";") > -1)
			{
				return;
			}
			if (SFX_DUMMIES_FOR_DUMB_PEOPLE.length() > 0) SFX_DUMMIES_FOR_DUMB_PEOPLE += ";";
			SFX_DUMMIES_FOR_DUMB_PEOPLE += param2;
			if (FindToken(SFX_HALO_LIST, param2, ";") > -1)
			{
				return;
			}
			if (SFX_HALO_LIST.length() > 0) SFX_HALO_LIST += ";";
			SFX_HALO_LIST += param2;
		}
		if (param1 == 1)
		{
			SFX_TRACKING_HALOS = 1;
			if (FindToken(SFX_HALO_LIST, param2, ";") > -1)
			{
				return;
			}
			if (SFX_HALO_LIST.length() > 0) SFX_HALO_LIST += ";";
			SFX_HALO_LIST += param2;
			if (FindToken(SFX_DUMMIES_FOR_DUMB_PEOPLE, param2, ";") > -1)
			{
				RemoveToken(SFX_DUMMIES_FOR_DUMB_PEOPLE, FindToken(SFX_DUMMIES_FOR_DUMB_PEOPLE, param2, ";"), ";");
			}
		}
		if (param1 == 0)
		{
			string L_HALO_TO_REMOVE = FindToken(SFX_HALO_LIST, param2, ";");
			if (L_HALO_TO_REMOVE > -1)
			{
				RemoveToken(SFX_HALO_LIST, L_HALO_TO_REMOVE, ";");
				if (GetTokenCount(SFX_HALO_LIST, ";") == 0)
				{
				}
				SFX_TRACKING_HALOS = 0;
			}
			string L_HALO_TO_REMOVE = FindToken(SFX_DUMMIES_FOR_DUMB_PEOPLE, param2, ";");
			if (L_HALO_TO_REMOVE > -1)
			{
				RemoveToken(SFX_DUMMIES_FOR_DUMB_PEOPLE, L_HALO_TO_REMOVE, ";");
			}
		}
		if (GetTokenCount(SFX_HALO_LIST, ";") > 0)
		{
			SFX_TRACKING_HALOS = 1;
		}
	}

	void cl_track_halos()
	{
		string CUR_HALO = GetToken(SFX_HALO_LIST, i, ";");
		if (CUR_HALO == "game.localplayer.index")
		{
			if (!("game.localplayer.thirdperson"))
			{
			}
			return;
		}
		string L_HALO_ORG = /* TODO: $getcl */ $getcl(CUR_HALO, "bonepos", 14);
		L_HALO_ORG += "z";
		if (FindToken(SFX_DUMMIES_FOR_DUMB_PEOPLE, CUR_HALO, ";") > -1)
		{
			ClientEffect("frameent", "sprite", "weapons/magic/seals.mdl", L_HALO_ORG, "setup_cool");
		}
		else
		{
			ClientEffect("frameent", "sprite", "weapons/magic/seals.mdl", L_HALO_ORG, "setup_halo");
		}
	}

	void setup_cool()
	{
		ClientEffect("frameent", "set_current_prop", "frame", SFX_HALO_FRAME);
		ClientEffect("frameent", "set_current_prop", "body", 37);
		ClientEffect("frameent", "set_current_prop", "scale", 2.0);
		ClientEffect("frameent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
	}

	void setup_halo()
	{
		ClientEffect("frameent", "set_current_prop", "frame", SFX_HALO_FRAME);
		ClientEffect("frameent", "set_current_prop", "body", 31);
		ClientEffect("frameent", "set_current_prop", "scale", 2.0);
	}

}

}
