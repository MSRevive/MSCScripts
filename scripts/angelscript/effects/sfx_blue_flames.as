#pragma context client

namespace MS
{

class SfxBlueFlames : CGameScript
{
	string FX_IDX;

	SfxBlueFlames()
	{
		const int OFS_POS = 16;
		const int OFS_NEG = -16;
		const int OFSZ_NEG = 0;
		const string SPRITE_1 = "xsmoke3.spr";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.1, 0.3));
		createsprite();
	}

	void game_precache()
	{
		Precache(SPRITE_1);
	}

	void client_activate()
	{
		FX_IDX = param2;
		PARAM1("effect_die");
	}

	void createsprite()
	{
		string l.pos = /* TODO: $getcl */ $getcl(FX_IDX, "origin");
		l.pos += Vector3(Random(OFS_NEG, OFS_POS), Random(OFS_NEG, OFS_POS), Random(0, 32));
		ClientEffect("tempent", "sprite", SPRITE_1, l.pos, "setup_sprite1_flame");
	}

	void setup_sprite1_flame()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", Random(0.4, 0.6));
		ClientEffect("tempent", "set_current_prop", "framerate", 25);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(64, 64, 255));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-4, 4), Random(-4, 4), 0));
		ClientEffect("tempent", "set_current_prop", "frames", 20);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
