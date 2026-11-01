#pragma context client

namespace MS
{

class SfxRepulseBurst : CGameScript
{
	int CYCLE_ANGLE;
	string FX_CENTER;
	string FX_DURATION;
	string FX_RADIUS;
	int GO_AWAY;
	string SPRITE_COLOR;

	void client_activate()
	{
		FX_CENTER = param1;
		FX_RADIUS = param2;
		FX_DURATION = param3;
		if (param4 == "PARAM4")
		{
			SPRITE_COLOR = Vector3(0, 0, 255);
		}
		else
		{
			SPRITE_COLOR = param4;
		}
		CYCLE_ANGLE = 0;
		spriteify();
		FX_DURATION("clear_sprites");
		EmitSound3D("magic/energy1_loud.wav", 10, FX_CENTER);
	}

	void spriteify()
	{
		for (int i = 0; i < 18; i++)
		{
			createsprite();
		}
	}

	void createsprite()
	{
		string SPRITE_POS = FX_CENTER;
		CYCLE_ANGLE += 20;
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, FX_RADIUS, 36));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_POS, "setup_sprite1_sparkle", "sprite_update");
	}

	void setup_sprite1_sparkle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 90.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
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
		ScheduleDelayedEvent(3.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
