#pragma context server

namespace MS
{

class SfxViewheight : CGameScript
{
	string FX_CUR_V;
	string FX_DEST_V;
	string FX_DRIFTING;
	string FX_SPEED;
	string game.cleffect.view_ofs.z;

	void client_activate()
	{
		LogDebug("*** sfx_viewheight client_activate PARAM1 PARAM2 PARAM3");
		if (param1 != "remove")
		{
			FX_SPEED = param2;
			if (FX_SPEED != 0)
			{
				FX_DEST_V = param1;
				FX_DRIFTING = 1;
				drift_to_new_view();
			}
			else
			{
				string L_PARAM1 = param1;
				set_view(L_PARAM1);
				FX_CUR_V = param1;
			}
		}
		else
		{
			RemoveScript();
		}
	}

	void set_view()
	{
		game.cleffect.view_ofs.z = param1;
	}

	void update_view()
	{
		LogDebug("*** $currentscript update_view PARAM1 PARAM2 PARAM3");
		FX_SPEED = param2;
		if (FX_SPEED != 0)
		{
			FX_DEST_V = param1;
			if (!(FX_DRIFTING))
			{
			}
			FX_DRIFTING = 1;
			drift_to_new_view();
		}
		else
		{
			FX_CUR_V = param1;
			set_view(FX_CUR_V);
		}
	}

	void drift_to_new_view()
	{
		if (!(FX_DRIFTING)) return;
		FX_CUR_V += FX_SPEED;
		if (FX_SPEED < 0)
		{
			if (FX_CUR_V < FX_DEST_V)
			{
			}
			set_view(FX_CUR_V);
			FX_DRIFTING = 0;
		}
		else
		{
			if (FX_CUR_V > FX_DEST_V)
			{
			}
			set_view(FX_CUR_V);
			FX_DRIFTING = 0;
		}
		set_view(FX_CUR_V);
		if (!(FX_DRIFTING)) return;
		ScheduleDelayedEvent(0.01, "drift_to_new_view");
	}

}

}
