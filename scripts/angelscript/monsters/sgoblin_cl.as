#pragma context client

namespace MS
{

class SgoblinCl : CGameScript
{
	int ANG_COUNT;
	string SPRITE_CENTER;

	void client_activate()
	{
	}

	void poof_fx()
	{
		SPRITE_CENTER = param1;
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "poof_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "poof_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "poof_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "poof_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "poof_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "poof_sprite");
	}

	void unpoof_fx()
	{
		SPRITE_CENTER = param1;
		ANG_COUNT = 0;
		for (int i = 0; i < 6; i++)
		{
			unpoof_fx_loop();
		}
	}

	void unpoof_fx_loop()
	{
		string START_LOC = SPRITE_CENTER;
		START_LOC += /* TODO: $relpos */ $relpos(Vector3(0, ANG_COUNT, 0), Vector3(0, 128, 96));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", START_LOC, "unpoof_sprite");
		ANG_COUNT += 60;
	}

	void poof_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 5.0);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(-90, Random(-125, 125), Random(-125, 125)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 2);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(-1.5, -1.1));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
	}

	void unpoof_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 5.0);
		ClientEffect("tempent", "set_current_prop", "velocity", (SPRITE_CENTER - START_LOC).Normalize());
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 2);
		ClientEffect("tempent", "set_current_prop", "gravity", 1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
	}

}

}
