#pragma context client

namespace MS
{

class KHollowOneCl : CGameScript
{
	string DRAINER_ANGS;
	string DRAINER_ANGS1;
	string DRAINER_ANGS2;
	string DRAINER_ANGS3;
	string DRAINER_ANGS4;
	string DRAINER_ANGS5;
	string DRAINER_ANGS6;
	string DRAINER_ANGS7;
	string DRAINER_ANGS8;
	int DRAINER_SPEED;
	string GLOW_SPRITE;
	string MY_OWNER;
	string SPRITE_DRAINER;
	string SPRITE_POPS;

	KHollowOneCl()
	{
		SPRITE_DRAINER = "fire1_fixed.spr";
		DRAINER_SPEED = 30;
		GLOW_SPRITE = "glow01.spr";
	}

	void client_activate()
	{
		MY_OWNER = param1;
		SPRITE_POPS = "0;0;0;0;0;0;0;0";
		LogDebug("**** client_activate");
	}

	void end_effect()
	{
		RemoveScript();
	}

	void spawn_drain_sprite_cl()
	{
		string SPAWN_LOC = param1;
		string DRAINER_INDEX = param2;
		DRAINER_ANGS = param3;
		LogDebug("**** spawn_drain_sprite_cl pos: PARAM1 idx: PARAM2 angs: PARAM3");
		if (DRAINER_INDEX == 1)
		{
			ClientEffect("tempent", "sprite", SPRITE_DRAINER, SPAWN_LOC, "setup_drainer", "update_drainer1");
		}
		if (DRAINER_INDEX == 2)
		{
			ClientEffect("tempent", "sprite", SPRITE_DRAINER, SPAWN_LOC, "setup_drainer", "update_drainer2");
		}
		if (DRAINER_INDEX == 3)
		{
			ClientEffect("tempent", "sprite", SPRITE_DRAINER, SPAWN_LOC, "setup_drainer", "update_drainer3");
		}
		if (DRAINER_INDEX == 4)
		{
			ClientEffect("tempent", "sprite", SPRITE_DRAINER, SPAWN_LOC, "setup_drainer", "update_drainer4");
		}
		if (DRAINER_INDEX == 5)
		{
			ClientEffect("tempent", "sprite", SPRITE_DRAINER, SPAWN_LOC, "setup_drainer", "update_drainer5");
		}
		if (DRAINER_INDEX == 6)
		{
			ClientEffect("tempent", "sprite", SPRITE_DRAINER, SPAWN_LOC, "setup_drainer", "update_drainer6");
		}
		if (DRAINER_INDEX == 7)
		{
			ClientEffect("tempent", "sprite", SPRITE_DRAINER, SPAWN_LOC, "setup_drainer", "update_drainer7");
		}
		if (DRAINER_INDEX == 8)
		{
			ClientEffect("tempent", "sprite", SPRITE_DRAINER, SPAWN_LOC, "setup_drainer", "update_drainer8");
		}
	}

	void update_drainer()
	{
		string DRAINER_INDEX = param1;
		if (DRAINER_INDEX == 1)
		{
			DRAINER_ANGS1 = param2;
			LogDebug("**** update_drainer 1 DRAINER_ANGS1");
		}
		if (DRAINER_INDEX == 2)
		{
			DRAINER_ANGS2 = param2;
		}
		if (DRAINER_INDEX == 3)
		{
			DRAINER_ANGS3 = param2;
		}
		if (DRAINER_INDEX == 4)
		{
			DRAINER_ANGS4 = param2;
		}
		if (DRAINER_INDEX == 5)
		{
			DRAINER_ANGS5 = param2;
		}
		if (DRAINER_INDEX == 6)
		{
			DRAINER_ANGS6 = param2;
		}
		if (DRAINER_INDEX == 7)
		{
			DRAINER_ANGS7 = param2;
		}
		if (DRAINER_INDEX == 8)
		{
			DRAINER_ANGS8 = param2;
		}
	}

	void update_drainer1()
	{
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(DRAINER_ANGS1, Vector3(0, DRAINER_SPEED, 0)));
		int MY_IDX = 1;
		MY_IDX -= 1;
		if (GetToken(SPRITE_POPS, MY_IDX, ";") == 1)
		{
			SetToken(SPRITE_POPS, MY_IDX, "0", ";");
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			string SPRITE_ORG = "game.tempent.origin";
			sprite_splode(SPRITE_ORG);
		}
	}

	void update_drainer2()
	{
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(DRAINER_ANGS2, Vector3(0, DRAINER_SPEED, 0)));
		int MY_IDX = 2;
		MY_IDX -= 1;
		if (GetToken(SPRITE_POPS, MY_IDX, ";") == 1)
		{
			SetToken(SPRITE_POPS, MY_IDX, "0", ";");
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			string SPRITE_ORG = "game.tempent.origin";
			sprite_splode(SPRITE_ORG);
		}
	}

	void update_drainer3()
	{
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(DRAINER_ANGS3, Vector3(0, DRAINER_SPEED, 0)));
		int MY_IDX = 3;
		MY_IDX -= 1;
		if (GetToken(SPRITE_POPS, MY_IDX, ";") == 1)
		{
			SetToken(SPRITE_POPS, MY_IDX, "0", ";");
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			string SPRITE_ORG = "game.tempent.origin";
			sprite_splode(SPRITE_ORG);
		}
	}

	void update_drainer4()
	{
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(DRAINER_ANGS4, Vector3(0, DRAINER_SPEED, 0)));
		int MY_IDX = 4;
		MY_IDX -= 1;
		if (GetToken(SPRITE_POPS, MY_IDX, ";") == 1)
		{
			SetToken(SPRITE_POPS, MY_IDX, "0", ";");
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			string SPRITE_ORG = "game.tempent.origin";
			sprite_splode(SPRITE_ORG);
		}
	}

	void update_drainer5()
	{
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(DRAINER_ANGS5, Vector3(0, DRAINER_SPEED, 0)));
		int MY_IDX = 5;
		MY_IDX -= 1;
		if (GetToken(SPRITE_POPS, MY_IDX, ";") == 1)
		{
			SetToken(SPRITE_POPS, MY_IDX, "0", ";");
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			string SPRITE_ORG = "game.tempent.origin";
			sprite_splode(SPRITE_ORG);
		}
	}

	void update_drainer6()
	{
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(DRAINER_ANGS6, Vector3(0, DRAINER_SPEED, 0)));
		int MY_IDX = 6;
		MY_IDX -= 1;
		if (GetToken(SPRITE_POPS, MY_IDX, ";") == 1)
		{
			SetToken(SPRITE_POPS, MY_IDX, "0", ";");
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			string SPRITE_ORG = "game.tempent.origin";
			sprite_splode(SPRITE_ORG);
		}
	}

	void update_drainer7()
	{
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(DRAINER_ANGS7, Vector3(0, DRAINER_SPEED, 0)));
		int MY_IDX = 7;
		MY_IDX -= 1;
		if (GetToken(SPRITE_POPS, MY_IDX, ";") == 1)
		{
			SetToken(SPRITE_POPS, MY_IDX, "0", ";");
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			string SPRITE_ORG = "game.tempent.origin";
			sprite_splode(SPRITE_ORG);
		}
	}

	void update_drainer8()
	{
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(DRAINER_ANGS8, Vector3(0, DRAINER_SPEED, 0)));
		int MY_IDX = 8;
		MY_IDX -= 1;
		if (GetToken(SPRITE_POPS, MY_IDX, ";") == 1)
		{
			SetToken(SPRITE_POPS, MY_IDX, "0", ";");
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			string SPRITE_ORG = "game.tempent.origin";
			sprite_splode(SPRITE_ORG);
		}
	}

	void sprite_popped()
	{
		SetToken(SPRITE_POPS, param1, "1", ";");
	}

	void sprite_splode()
	{
		string SPARK_ORG = param1;
		ClientEffect("tempent", "sprite", GLOW_SPRITE, SPARK_ORG, "setup_spark");
		ClientEffect("tempent", "sprite", GLOW_SPRITE, SPARK_ORG, "setup_spark");
		ClientEffect("tempent", "sprite", GLOW_SPRITE, SPARK_ORG, "setup_spark");
		ClientEffect("tempent", "sprite", GLOW_SPRITE, SPARK_ORG, "setup_spark");
		EmitSound3D("turret/tu_die2.wav", 10, SPARK_ORG);
	}

	void setup_drainer()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 60.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", DRAINER_ANGS);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(DRAINER_ANGS, Vector3(0, DRAINER_SPEED, 0)));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void setup_spark()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, Random(0, 359), 0), Vector3(0, 20, 40)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", 1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

}

}
