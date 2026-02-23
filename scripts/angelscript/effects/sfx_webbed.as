#pragma context client

namespace MS
{

class SfxWebbed : CGameScript
{
	string FX_COCOONED;
	int FX_CUR_WEBS;
	string FX_DECAY;
	int FX_DIE;
	string FX_NEXT_DECAY;
	string FX_WEBS_TILL_COCOON;
	string FX_WEB_TARGET;

	SfxWebbed()
	{
		const string WEB_RATIO = /* TODO: $math(divide) */ FX_CUR_WEBS;
	}

	void client_activate()
	{
		FX_DECAY = param1;
		FX_NEXT_DECAY = /* TODO: $math(add) */ FX_DECAY;
		FX_WEB_TARGET = param2;
		FX_CUR_WEBS = 1;
		FX_WEBS_TILL_COCOON = param3;
		ClientEffect("tempent", "model", "misc/treasure.mdl", /* TODO: $func */ $func("func_get_new_pos"), "web_setup", "web_update");
		FX_DECAY("web_decay");
	}

	void ext_webbed()
	{
		if ((FX_COCOONED)) return;
		FX_CUR_WEBS += 1;
		if (FX_CUR_WEBS < FX_WEBS_TILL_COCOON)
		{
			FX_DECAY = param1;
			FX_NEXT_DECAY = /* TODO: $math(add) */ FX_DECAY;
			FX_DECAY("web_decay");
		}
		else
		{
			FX_COCOONED = 1;
			ScheduleDelayedEvent(15, "fx_die");
		}
	}

	void web_decay()
	{
		if ((FX_COCOONED)) return;
		if (GetGameTime() >= FX_NEXT_DECAY)
		{
			FX_CUR_WEBS -= 1;
			if (FX_CUR_WEBS < 1)
			{
				fx_die();
			}
			else
			{
				FX_DECAY("web_decay");
			}
		}
	}

	void web_setup()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DECAY);
		ClientEffect("tempent", "set_current_prop", "body", 6);
		ClientEffect("tempent", "set_current_prop", "framerate", 0);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", /* TODO: $ratio */ $ratio(WEB_RATIO, 50, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 999);
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		string L_MAXS = /* TODO: $getcl */ $getcl(FX_WEB_TARGET, "maxs");
		if ((/* TODO: $getcl */ $getcl(FX_WEB_TARGET, "isplayer")))
		{
			L_MAXS *= 2;
		}
		string L_SIZE = (L_MAXS).x;
		L_SIZE += (L_MAXS).y;
		L_SIZE += (L_MAXS).z;
		L_SIZE /= 104;
		ClientEffect("tempent", "set_current_prop", "scale", L_SIZE);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
	}

	void web_update()
	{
		if (FX_CUR_WEBS > 0)
		{
			ClientEffect("tempent", "set_current_prop", "origin", /* TODO: $func */ $func("func_get_new_pos"));
			string L_WEB_RATIO = FX_CUR_WEBS;
			L_WEB_RATIO *= 0.1;
			ClientEffect("tempent", "set_current_prop", "renderamt", /* TODO: $ratio */ $ratio(WEB_RATIO, 50, 255));
			ClientEffect("tempent", "set_current_prop", "death_delay", FX_DECAY);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.01);
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
		}
		if ((FX_COCOONED))
		{
			ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		}
		if ((FX_DIE))
		{
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.01);
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
			FX_CUR_WEBS = 0;
			FX_COCOONED = 0;
			effect_die();
		}
	}

	void fx_die()
	{
		FX_DIE = 1;
		ScheduleDelayedEvent(1.0, "effect_die");
	}

	void effect_die()
	{
		RemoveScript();
	}

	void func_get_new_pos()
	{
		if ((/* TODO: $getcl */ $getcl(FX_WEB_TARGET, "isplayer")))
		{
			string L_WEB_POS = /* TODO: $getcl */ $getcl(FX_WEB_TARGET, "origin");
			L_WEB_POS += "z";
		}
		else
		{
			string L_WEB_POS = /* TODO: $getcl */ $getcl(FX_WEB_TARGET, "bonepos", 0);
			L_WEB_POS = "z";
		}
		L_WEB_POS += "z";
		return;
		return;
	}

}

}
