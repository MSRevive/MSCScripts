#pragma context client

namespace MS
{

class DwarfZombieBloatLightCl : CGameScript
{
	int FLICKER_COUNT;
	string GLOW_COLOR;
	string GLOW_RAD;
	string LIGHT_RAD_RATE;
	string NEW_GLOW_RAD;
	string SKEL_ID;
	string SKEL_LIGHT_ID;
	int SND_COUNT;

	void client_activate()
	{
		SKEL_ID = param1;
		GLOW_COLOR = param2;
		GLOW_RAD = param3;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
		PARAM4("remove_light");
	}

	void game_prerender()
	{
		if (NEW_GLOW_RAD > 0)
		{
			if (GLOW_RAD < NEW_GLOW_RAD)
			{
				GLOW_RAD += LIGHT_RAD_RATE;
			}
			if (GLOW_RAD > NEW_GLOW_RAD)
			{
				GLOW_RAD -= LIGHT_RAD_RATE;
			}
		}
		if (!(/* TODO: $getcl */ $getcl(SKEL_ID, "exists"))) return;
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void remove_light()
	{
		RemoveScript();
	}

	void light_grow()
	{
		NEW_GLOW_RAD = param1;
		LIGHT_RAD_RATE = param2;
		FLICKER_COUNT -= 0;
	}

	void light_shrink()
	{
		NEW_GLOW_RAD = param1;
		LIGHT_RAD_RATE = param2;
	}

	void light_flicker()
	{
		FLICKER_COUNT = 5;
		SND_COUNT = 0;
		do_flicker();
	}

	void do_flicker()
	{
		if (!(FLICKER_COUNT > 0)) return;
		FLICKER_COUNT -= 1;
		if (GLOW_RAD != 1)
		{
			NEW_GLOW_RAD = 1;
			GLOW_RAD = 1;
		}
		else
		{
			NEW_GLOW_RAD = 128;
			GLOW_RAD = 128;
		}
		SND_COUNT += 1;
		string L_SND_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		L_SND_POS += "z";
		if (SND_COUNT == 1)
		{
			EmitSound3D("magic/energy1.wav", 10, L_SND_POS, 0.8, 3, 100);
		}
		if (SND_COUNT == 2)
		{
			EmitSound3D("magic/energy2.wav", 10, L_SND_POS, 0.8, 3, 100);
		}
		if (SND_COUNT == 3)
		{
			EmitSound3D("magic/energy3.wav", 10, L_SND_POS, 0.8, 3, 100);
		}
		if (SND_COUNT == 4)
		{
			EmitSound3D("magic/energy4.wav", 10, L_SND_POS, 0.8, 3, 100);
			SND_COUNT = 0;
		}
		Random(0_2, 0_6)("do_flicker");
	}

}

}
