#pragma context server

namespace MS
{

class FireReaverCl : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string MY_OWNER;
	int VOLC_SOUND_DELAY;
	string local.cl.gravity;
	string local.cl.origin;
	string local.cl.velocity;

	FireReaverCl()
	{
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const string SPRITE_BURN = "fire1_fixed.spr";
		const int LIGHT_RADIUS = 64;
		const Vector3 LIGHT_COLOR = Vector3(255, 0, 0);
		const float LIGHT_DURATION = 0.8;
		SetCallback("render", "enable");
	}

	void reset_volc_sound_delay()
	{
		VOLC_SOUND_DELAY = 0;
	}

	void game_prerender()
	{
		if ((/* TODO: $getcl */ $getcl(MY_OWNER, "exists"))) return;
		volcano_die();
	}

	void client_activate()
	{
		local.cl.origin = param1;
		MY_OWNER = param2;
		FX_DURATION = param3;
		FX_ACTIVE = 1;
		local.cl.origin += "z";
		FX_DURATION("end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "volcano_die");
	}

	void volcano_die()
	{
		RemoveScript();
	}

	void volcono_shoot_rock()
	{
		if (!(FX_ACTIVE)) return;
		local.cl.velocity = param1;
		local.cl.gravity = param2;
		string MY_ORIGIN = param3;
		ClientEffect("tempent", "model", MODEL_WORLD, MY_ORIGIN, "volcano_rock_create", "volcano_rock_update", "volcano_rock_collide");
		for (int i = 0; i < 4; i++)
		{
			makefire_loop(MY_ORIGIN);
		}
	}

	void volcano_rock_create()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10);
		ClientEffect("tempent", "set_current_prop", "velocity", local.cl.velocity);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "gravity", local.cl.gravity);
		ClientEffect("tempent", "set_current_prop", "collide", "all");
		ClientEffect("tempent", "set_current_prop", "renderfx", "glow");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("light", "new", "game.tempent.origin", LIGHT_RADIUS, LIGHT_COLOR, LIGHT_DURATION);
		ClientEffect("tempent", "set_current_prop", "iuser1", "game.script.last_light_id");
	}

	void volcano_rock_update()
	{
		ClientEffect("light", "game.tempent.iuser1", "game.tempent.origin", LIGHT_RADIUS, LIGHT_COLOR, LIGHT_DURATION);
	}

	void volcano_rock_collide()
	{
		ClientEffect("tempent", "set_current_prop", "sprite", SPRITE_BURN);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "death_delay", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "all");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
	}

	void makefire_loop()
	{
		ClientEffect("tempent", "sprite", SPRITE_BURN, param1, "volcano_fire_create");
	}

	void volcano_fire_create()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-200, 200), Random(-200, 200), Random(-200, 200)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.6, 1.0));
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
	}

}

}
