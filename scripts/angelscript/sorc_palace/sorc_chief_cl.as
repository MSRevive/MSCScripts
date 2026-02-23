#pragma context client

namespace MS
{

class SorcChiefCl : CGameScript
{
	string CL_AUTO_LIFT;
	string CL_COLOR;
	string CL_DURATION;
	string CL_RADIUS;
	string CYCLE_ANGLE;
	int GO_AWAY;
	string OWNER_IDX;
	int TOTAL_OFS;

	void client_activate()
	{
		OWNER_IDX = param1;
		CL_RADIUS = param2;
		CL_COLOR = param3;
		CL_DURATION = param4;
		CL_AUTO_LIFT = param5;
		CL_DURATION("remove_me");
		ScheduleDelayedEvent(0.1, "spriteify");
	}

	void spriteify()
	{
		TOTAL_OFS = 64;
		for (int i = 0; i < 18; i++)
		{
			createsprite();
		}
	}

	void createsprite()
	{
		string l.pos = /* TODO: $getcl */ $getcl(OWNER_IDX, "origin");
		if (CYCLE_ANGLE == "CYCLE_ANGLE")
		{
			CYCLE_ANGLE = 0;
		}
		CYCLE_ANGLE += 20;
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, CL_RADIUS, 36));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", l.pos, "setup_sprite1_sparkle", "sprite_update");
	}

	void setup_sprite1_sparkle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", CL_DURATION);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendercolor", CL_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void sprite_update()
	{
		if (!(GO_AWAY)) return;
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 400));
		ClientEffect("tempent", "set_current_prop", "fadeout", 2.0);
		ClientEffect("tempent", "set_current_prop", "gravity", -4.0);
	}

	void clear_sprites()
	{
		GO_AWAY = 1;
		sprite_update();
		ScheduleDelayedEvent(5.0, "remove_me");
	}

	void remove_me()
	{
		if ((CL_AUTO_LIFT))
		{
			CL_AUTO_LIFT = 0;
			clear_sprites();
		}
		else
		{
			RemoveScript();
		}
	}

}

}
