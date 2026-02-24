#pragma context client

namespace MS
{

class MagicHandTestSpell : CGameScript
{
	string CYCLE_ANGLE;
	float FX_DURATION;
	int REPULSE_RADIUS;
	string SPRITE_NAME;
	int SPRITE_VELOCITY;
	string START_POS;

	MagicHandTestSpell()
	{
		SPRITE_NAME = "3dmflaora.spr";
		Precache(SPRITE_NAME);
		FX_DURATION = 1.5;
		SPRITE_VELOCITY = 10;
		REPULSE_RADIUS = 256;
	}

	void spriteify()
	{
		for (int i = 0; i < 36; i++)
		{
			createsprite();
		}
	}

	void createsprite()
	{
		string l.pos = START_POS;
		if (CYCLE_ANGLE == "CYCLE_ANGLE")
		{
			CYCLE_ANGLE = 0;
		}
		CYCLE_ANGLE += 10;
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 10, 36));
		ClientEffect("tempent", "sprite", SPRITE_NAME, l.pos, "setup_sprite1_sparkle", "sprite_update");
	}

	void client_activate()
	{
		START_POS = /* TODO: $getcl */ $getcl(param1, "origin");
	}

	void new_cast()
	{
		START_POS = /* TODO: $getcl */ $getcl(param1, "origin");
	}

	void setup_sprite1_sparkle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(254, 254, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "update", 1);
		string OWNER_ORIGIN = /* TODO: $getcl */ $getcl(GetOwner(), "origin");
		string SPRITE_ORG = "game.tempent.origin";
		string SPRITE_ANG = (SPRITE_ORG - OWNER_ORIGIN).Normalize();
		string SPRITE_ANG_X = (SPRITE_ANG).x;
		string SPRITE_ANG_Y = (SPRITE_ANG).y;
		string SPRITE_ANG_Z = (SPRITE_ANG).z;
		SPRITE_ANG_X *= SPRITE_VELOCITY;
		SPRITE_ANG_Y *= SPRITE_VELOCITY;
		SPRITE_ANG_Z *= SPRITE_VELOCITY;
		Vector3 SPRITE_SPEED = Vector3(SPRITE_ANG_X, SPRITE_ANG_Y, SPRITE_ANG_Z);
		ClientEffect("tempent", "set_current_prop", "velocity", SPRITE_SPEED);
	}

	void sprite_update()
	{
		if ((Distance(MY_OWNER_ORIGIN, "game.tempent.origin") + "=>" + REPULSE_RADIUS))
		{
			ClientEffect("tempent", "set_current_prop", "fadeout", 0.5);
		}
	}

}

}
