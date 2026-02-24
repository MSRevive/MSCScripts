#pragma context server

namespace MS
{

class ElementalEarthCl : CGameScript
{
	string FX_ACTIVE;
	string FX_OWNER;
	string FX_POS;
	string FX_SHIELD_COLOR;
	float FX_SHIELD_DURATION;
	float FX_SHIELD_SCALE;
	string FX_SHIELD_SPRITE;
	int FX_SHIELD_SPRITE_FRAMES;
	string FX_SHIELD_YAW;
	string ROCK_FALLING;
	string ROCK_START;
	string SOUND_SPAWN;

	ElementalEarthCl()
	{
		SOUND_SPAWN = "magic/energy1_loud.wav";
		FX_SHIELD_SPRITE = "rain_ripple.spr";
		FX_SHIELD_SPRITE_FRAMES = 15;
		FX_SHIELD_COLOR = Vector3(255, 255, 255);
		FX_SHIELD_SCALE = 2.5;
		FX_SHIELD_DURATION = 1.0;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		if (param2 == "spawn_rock")
		{
			FX_POS = param3;
			FX_ACTIVE = 1;
			ROCK_START = GetGameTime();
			ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_POS, "setup_rock", "update_rock", "collide_rock");
			ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_POS, "setup_burst", "update_burst");
			EmitSound3D(SOUND_SPAWN, 10, FX_POS);
			ScheduleDelayedEvent(10.0, "end_fx");
		}
		if (param2 == "do_shield")
		{
			FX_ACTIVE = 1;
			shield_hit();
			PARAM3("end_fx");
		}
	}

	void setup_burst()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.01);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "velocity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 50);
		ClientEffect("tempent", "set_current_prop", "body", 54);
		ClientEffect("tempent", "set_current_prop", "sequence", 6);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "color", Vector3(0, 64, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(180, 0, 0));
		string L_ROCK_START = (ROCK_START + 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", L_ROCK_START);
	}

	void update_burst()
	{
		if (!(FX_ACTIVE)) return;
		float CUR_STEP = GetGameTime();
		CUR_STEP -= "game.tempent.fuser1";
		if (CUR_STEP < 0.5)
		{
			string CUR_SCALE = /* TODO: $ratio */ $ratio(CUR_STEP, 0.01, 1.0);
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
		}
		else
		{
			if (CUR_STEP < 1.0)
			{
				string L_REND = /* TODO: $ratio */ $ratio(CUR_STEP, 512, 0);
				ClientEffect("tempent", "set_current_prop", "renderamt", L_REND);
			}
		}
	}

	void setup_rock()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "velocity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 50);
		ClientEffect("tempent", "set_current_prop", "body", 5);
		ClientEffect("tempent", "set_current_prop", "sequence", 6);
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 0);
		ClientEffect("tempent", "set_current_prop", "bounce", 0);
		string L_ROCK_START = (ROCK_START + 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", L_ROCK_START);
	}

	void update_rock()
	{
		if (!(FX_ACTIVE)) return;
		if ((ROCK_FALLING)) return;
		float CUR_STEP = GetGameTime();
		CUR_STEP -= "game.tempent.fuser1";
		if (CUR_STEP < 1.0)
		{
			string CUR_REND = /* TODO: $ratio */ $ratio(CUR_STEP, 0, 255);
			int CUR_REND = int(CUR_REND);
			ClientEffect("tempent", "set_current_prop", "renderamt", CUR_REND);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "renderamt", 255);
			ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, -600));
			ROCK_FALLING = 1;
		}
	}

	void collide_rock()
	{
		EmitSound3D("fire.wav", 10, "game.tempent.origin");
		ScheduleDelayedEvent(1.0, "end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void shield_hit()
	{
		string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string L_OWNER_ANGS = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
		FX_SHIELD_YAW = /* TODO: $vec.yaw */ $vec.yaw(L_OWNER_ANGS);
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, FX_SHIELD_YAW, 0), Vector3(0, 32, 64));
		ClientEffect("tempent", "sprite", FX_SHIELD_SPRITE, L_POS, "setup_shield");
		ClientEffect("tempent", "sprite", FX_SHIELD_SPRITE, L_POS, "setup_shield_negyaw");
	}

	void setup_shield()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_SHIELD_DURATION);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_SHIELD_COLOR);
		ClientEffect("tempent", "set_current_prop", "scale", FX_SHIELD_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, FX_SHIELD_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", FX_SHIELD_SPRITE_FRAMES);
	}

	void setup_shield_negyaw()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_SHIELD_DURATION);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_SHIELD_COLOR);
		ClientEffect("tempent", "set_current_prop", "scale", FX_SHIELD_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string NEG_YAW = FX_SHIELD_YAW;
		NEG_YAW += 180;
		if (NEG_YAW > 359.99)
		{
			NEG_YAW -= 359.99;
		}
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, NEG_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", FX_SHIELD_SPRITE_FRAMES);
	}

}

}
