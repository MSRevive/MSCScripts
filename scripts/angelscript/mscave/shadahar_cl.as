#pragma context client

namespace MS
{

class ShadaharCl : CGameScript
{
	string WAND_COLOR;

	void client_activate()
	{
		int DO_NADDA = 1;
	}

	void eye_beam_prep_cl()
	{
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_eye_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param2, "setup_eye_sprite");
	}

	void wand_prep_cl()
	{
		WAND_COLOR = param2;
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_wand_sprite");
	}

	void setup_eye_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.2, 0.1));
		ClientEffect("tempent", "set_current_prop", "collide", "world|die");
	}

	void setup_wand_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "rendercolor", WAND_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.2, 0.1));
		ClientEffect("tempent", "set_current_prop", "collide", "world|die");
	}

}

}
