#pragma context server

namespace MS
{

class ItemSorcvCl : CGameScript
{
	string FX_DURATION;
	string FX_FRAME;
	string FX_POS;
	string FX_YAW;

	ItemSorcvCl()
	{
	}

	void client_activate()
	{
		FX_POS = param1;
		FX_FRAME = param2;
		FX_YAW = param3;
		FX_DURATION = param4;
		SetCallback("render", "enable");
		EmitSound3D("ambience/goal_1.wav", 10, FX_POS);
		ClientEffect("tempent", "sprite", "medals.spr", FX_POS, "setup_sprite", "update_sprite");
		ClientEffect("tempent", "sprite", "medals.spr", FX_POS, "setup_flip_sprite", "update_flip_sprite");
		string L_DUR = FX_DURATION;
		L_DUR += 1.0;
		L_DUR("remove_me");
	}

	void update_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "frame", FX_FRAME);
	}

	void update_flip_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "frame", FX_FRAME);
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "framerate", 1);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "frame", FX_FRAME);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, FX_YAW, 0));
	}

	void setup_flip_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "framerate", 1);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "frame", FX_FRAME);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		string NEG_YAW = FX_YAW;
		NEG_YAW += 180;
		if (NEG_YAW > 359.99)
		{
			NEG_YAW -= 359.99;
		}
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, NEG_YAW, 0));
	}

}

}
