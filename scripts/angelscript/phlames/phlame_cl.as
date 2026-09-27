#pragma context client

namespace MS
{

class PhlameCl : CGameScript
{
	string ATTACH_EYE;
	string ATTACH_HAND;
	string ATTACH_STAFF;
	string CLOUD_YAW;
	string CONTACT_SPRITE;
	string EYEBEAM_ON;
	string EYE_POS;
	string EYE_SPRITE;
	string FIREBREATH_ON;
	int FUNNEL_ON;
	int FUNNEL_SPRITE_START_DIST;
	int FX_ACTIVE;
	string FX_DELAY_REMOVE;
	string FX_OWNER;
	int LIGHT_B;
	int LIGHT_G;
	int LIGHT_R;
	int ROT_POINT;
	string SKEL_LIGHT_ID;
	string STAFF_POS;
	string STAFF_SPRITE;
	string TRANSFORM_CENTER;

	PhlameCl()
	{
		ATTACH_HAND = "attachment0";
		ATTACH_STAFF = "attachment1";
		ATTACH_EYE = "attachment2";
		EYE_SPRITE = "red_aura_8bit.spr";
		STAFF_SPRITE = "firemagic_8bit.spr";
		CONTACT_SPRITE = "3dmflaora.spr";
		FUNNEL_SPRITE_START_DIST = 250;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		STAFF_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1");
		EYE_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment2");
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(10.0);
		if ((FX_ACTIVE))
		{
		}
		ClientEffect("tempent", "sprite", STAFF_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1"), "setup_staff_sprite", "update_staff_sprite");
	}

	void client_activate()
	{
		SetCallback("render", "enable");
		FX_OWNER = param1;
		EYEBEAM_ON = param2;
		FIREBREATH_ON = param3;
		if ((EYEBEAM_ON))
		{
			eye_beam_on();
		}
		if ((FIREBREATH_ON))
		{
			fire_breath_on();
		}
		LIGHT_R = 128;
		LIGHT_G = 16;
		LIGHT_B = 0;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), 128, Vector3(LIGHT_R, LIGHT_G, LIGHT_B), 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		FX_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "start_staff_sprite");
		ScheduleDelayedEvent(30.0, "end_fx");
	}

	void start_staff_sprite()
	{
		ClientEffect("tempent", "sprite", STAFF_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1"), "setup_staff_sprite", "update_staff_sprite");
	}

	void end_fx()
	{
		if ((FX_DELAY_REMOVE))
		{
			FX_DELAY_REMOVE = 0;
			ScheduleDelayedEvent(10.0, "end_fx");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		int INT_LIGHT_B = int(LIGHT_B);
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, 128, Vector3(LIGHT_R, LIGHT_G, INT_LIGHT_B), 1.0);
		LIGHT_R += 1;
		LIGHT_G += 1;
		LIGHT_B += 0.25;
		if (LIGHT_R > 255)
		{
			LIGHT_R = 255;
		}
		if (LIGHT_G > 128)
		{
			LIGHT_R = 128;
			LIGHT_G = 16;
			LIGHT_B = 0;
		}
	}

	void eye_beam_on()
	{
		if (!(FX_ACTIVE)) return;
		EYEBEAM_ON = 1;
		string ATTACH_EYE_ORG = EYE_POS;
		ClientEffect("tempent", "sprite", EYE_SPRITE, ATTACH_EYE_ORG, "setup_eye_sprite", "update_eye_sprite");
	}

	void eye_beam_off()
	{
		EYEBEAM_ON = 0;
	}

	void update_eye_sprite()
	{
		string ATTACH_EYE_ORG = EYE_POS;
		ClientEffect("tempent", "set_current_prop", "origin", ATTACH_EYE_ORG);
		if ((EYEBEAM_ON))
		{
			string CUR_SIZE = "game.tempent.fuser1";
			CUR_SIZE += 0.01;
			if (CUR_SIZE < 0.20)
			{
			}
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
		}
		if (!(EYEBEAM_ON))
		{
			string CUR_SIZE = "game.tempent.fuser1";
			CUR_SIZE -= 0.01;
			if (CUR_SIZE > 0.01)
			{
				ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
				ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
			}
		}
	}

	void eye_beam_contact()
	{
		string SPAWN_POS = param1;
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPAWN_POS, "setup_beam_contact");
	}

	void fire_breath_on()
	{
		if (!(FX_ACTIVE)) return;
		FIREBREATH_ON = 1;
		fire_breath_loop();
	}

	void fire_breath_off()
	{
		FIREBREATH_ON = 0;
	}

	void fire_breath_loop()
	{
		if (!(FIREBREATH_ON)) return;
		ScheduleDelayedEvent(0.2, "fire_breath_loop");
		CLOUD_YAW = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw");
		ClientEffect("tempent", "sprite", "explode1.spr", STAFF_POS, "setup_fire_cloud", "update_fire_cloud");
		ClientEffect("tempent", "sprite", "explode1.spr", STAFF_POS, "setup_fire_cloud", "update_fire_cloud");
		ClientEffect("tempent", "sprite", "explode1.spr", STAFF_POS, "setup_fire_cloud", "update_fire_cloud");
	}

	void repulse_attack()
	{
		string FX_CENTER = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		ClientEffect("light", "new", FX_CENTER, 768, Vector3(255, 128, 64), 1.0);
		ClientEffect("tempent", "sprite", "weapons/projectiles.mdl", FX_CENTER, "setup_repulse_burst", "update_repulse_burst");
		EmitSound3D("magic/boom.wav", 10, FX_CENTER);
	}

	void do_transform()
	{
		FX_DELAY_REMOVE = 1;
		TRANSFORM_CENTER = param1;
		FUNNEL_ON = 1;
		transform_funnel_loop();
	}

	void transform_funnel_loop()
	{
		if (!(FUNNEL_ON)) return;
		ScheduleDelayedEvent(0.2, "transform_funnel_loop");
		ROT_POINT = 0;
		for (int i = 0; i < 12; i++)
		{
			transform_funnel_make_sprite();
		}
	}

	void transform_funnel_make_sprite()
	{
		string SPR_POS = TRANSFORM_CENTER;
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, ROT_POINT, 0), Vector3(0, FUNNEL_SPRITE_START_DIST, 0));
		ClientEffect("tempent", "sprite", "calflame.spr", SPR_POS, "setup_funnel_sprite", "update_funnel_sprite");
		ROT_POINT += 30;
	}

	void transform_finalize()
	{
		FX_DELAY_REMOVE = 0;
		FUNNEL_ON = 0;
		string BIRD_POS = param1;
		ClientEffect("tempent", "sprite", "c-tele1.spr", BIRD_POS, "setup_bird_sprite");
		EmitSound3D("monsters/demonwing/demonwing_huge.wav", 10, BIRD_POS);
	}

	void transform_return()
	{
		FX_DELAY_REMOVE = 0;
		FUNNEL_ON = 0;
		string SPRITE_POS1 = param1;
		string SPRITE_POS2 = param2;
		ClientEffect("tempent", "sprite", "c-tele1.spr", SPRITE_POS1, "setup_bird_sprite");
		ClientEffect("tempent", "sprite", "c-tele1.spr", SPRITE_POS2, "setup_bird_sprite");
		EmitSound3D("magic/spawn_loud.wav", 10, SPRITE_POS2);
	}

	void setup_bird_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(200, 0, 0));
		ClientEffect("tempent", "set_current_prop", "framerate", 20);
		ClientEffect("tempent", "set_current_prop", "frames", 25);
		ClientEffect("tempent", "set_current_prop", "scale", 6.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

	void update_funnel_sprite()
	{
		string CUR_ROT = "game.tempent.fuser1";
		string CUR_DIST = "game.tempent.fuser2";
		CUR_ROT += 1;
		CUR_DIST -= 2;
		if (CUR_ROT > 359.99)
		{
			int CUR_ROT = 0;
		}
		if (CUR_DIST <= 5)
		{
			int CUR_DIST = 5;
		}
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_ROT);
		ClientEffect("tempent", "set_current_prop", "fuser2", CUR_DIST);
		string CUR_ORG = "game.tempent.origin";
		string CUR_Z = (CUR_ORG).z;
		string NEW_ORG = TRANSFORM_CENTER;
		NEW_ORG = "z";
		NEW_ORG += /* TODO: $relpos */ $relpos(Vector3(0, CUR_ROT, 0), Vector3(0, CUR_DIST, 0));
		ClientEffect("tempent", "set_current_prop", "origin", NEW_ORG);
	}

	void setup_funnel_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 16);
		ClientEffect("tempent", "set_current_prop", "scale", 1.5);
		ClientEffect("tempent", "set_current_prop", "gravity", -2.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", ROT_POINT);
		ClientEffect("tempent", "set_current_prop", "fuser2", FUNNEL_SPRITE_START_DIST);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void update_repulse_burst()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		if (!(CUR_SCALE < 30)) return;
		CUR_SCALE += 0.5;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
	}

	void setup_repulse_burst()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.5);
		ClientEffect("tempent", "set_current_prop", "body", 51);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
	}

	void update_staff_sprite()
	{
		string ATTACH_STAFF_ORG = STAFF_POS;
		ClientEffect("tempent", "set_current_prop", "origin", ATTACH_STAFF_ORG);
	}

	void setup_staff_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 8);
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void setup_eye_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 20);
		ClientEffect("tempent", "set_current_prop", "frames", 8);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		ClientEffect("tempent", "set_current_prop", "fuser2", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void setup_beam_contact()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 0, 255));
		ClientEffect("tempent", "set_current_prop", "scale", Random(1.0, 3.0));
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		float RND_ROT = Random(0, 359.99);
		float RND_FWD = Random(0, 100.0);
		float RND_UD = Random(0, 600);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, RND_ROT, 0), Vector3(0, RND_FWD, RND_UD)));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

	void update_fire_cloud()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		if (!(CUR_SCALE < 2)) return;
		CUR_SCALE += 0.05;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
	}

	void setup_fire_cloud()
	{
		float START_SCALE = Random(0.25, 0.5);
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 9);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", START_SCALE);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		if (RandomInt(1, 3) == 1)
		{
			ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 0));
		}
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", START_SCALE);
		float RND_RL = Random(-20, 20);
		float RND_UD = Random(-50, -100);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(20, CLOUD_YAW, 0), Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
