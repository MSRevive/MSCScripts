#pragma context client

namespace MS
{

class KChildreBossCl : CGameScript
{
	string CYCLE_ANGLE;
	int NOVA_RADIUS;
	string SPRITE_NAME;
	int SPRITE_VELOCITY;
	string START_POS;

	KChildreBossCl()
	{
		SPRITE_NAME = "3dmflaora.spr";
		Precache(SPRITE_NAME);
		SPRITE_VELOCITY = 2000;
		NOVA_RADIUS = 80;
	}

	void spriteify()
	{
		for (int i = 0; i < 36; i++)
		{
			createsprite();
		}
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
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
		spriteify();
	}

	void new_cast()
	{
		START_POS = /* TODO: $getcl */ $getcl(param1, "origin");
		spriteify();
	}

	void setup_sprite1_sparkle()
	{
		string SPRITE_ORG = "game.tempent.origin";
		string SPRITE_ANG = (SPRITE_ORG - START_POS).Normalize();
		string SPRITE_ANG_X = (SPRITE_ANG).x;
		string SPRITE_ANG_Y = (SPRITE_ANG).y;
		string SPRITE_ANG_Z = (SPRITE_ANG).z;
		SPRITE_ANG_X *= SPRITE_VELOCITY;
		SPRITE_ANG_Y *= SPRITE_VELOCITY;
		Vector3 SPRITE_SPEED = Vector3(SPRITE_ANG_X, SPRITE_ANG_Y, SPRITE_ANG_Z);
		ClientEffect("tempent", "set_current_prop", "velocity", SPRITE_SPEED);
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 254, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

}

}
