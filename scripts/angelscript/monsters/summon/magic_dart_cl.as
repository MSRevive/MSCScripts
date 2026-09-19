#pragma context client

namespace MS
{

class MagicDartCl : CGameScript
{
	string CALLED_REMOVE;
	string CL_PROJ_SIZE;
	string FADE_OUT;
	float F_DEATH;
	string GLUE_IDX;
	int REND_AMT;

	void client_activate()
	{
		GLUE_IDX = param1;
		CL_PROJ_SIZE = param2;
		REND_AMT = 200;
		SetCallback("render", "enable");
		F_DEATH = 90.0;
		ClientEffect("tempent", "sprite", "nhth1.spr", "l.pos", "n_sprite", "n_sprite_update");
	}

	void game_prerender()
	{
		n_sprite_update();
	}

	void n_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 10);
		ClientEffect("tempent", "set_current_prop", "scale", CL_PROJ_SIZE);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", REND_AMT);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void n_sprite_update()
	{
		string GLUE_ORG = /* TODO: $getcl */ $getcl(GLUE_IDX, "origin");
		ClientEffect("tempent", "set_current_prop", "origin", GLUE_ORG);
		ClientEffect("tempent", "set_current_prop", "scale", CL_PROJ_SIZE);
		ClientEffect("tempent", "set_current_prop", "renderamt", REND_AMT);
		if (!(/* TODO: $getcl */ $getcl(GLUE_IDX, "exists")))
		{
			FADE_OUT = 1;
		}
		if ((FADE_OUT))
		{
			CL_PROJ_SIZE -= 0.5;
			ClientEffect("tempent", "set_current_prop", "fadeout", 1);
			if (!(CALLED_REMOVE))
			{
			}
			CALLED_REMOVE = 1;
			ScheduleDelayedEvent(2.0, "remove_me");
		}
	}

	void shrink_out()
	{
		FADE_OUT = 1;
	}

	void remove_me()
	{
		RemoveScript();
		DeleteEntity(GetOwner());
	}

}

}
