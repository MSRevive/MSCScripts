#pragma context server

namespace MS
{

class SfxFissure : CGameScript
{
	string BEAM_DIR;
	string BEAM_END;
	string BEAM_START;
	int FISSURE_ACTIVE;
	int FISSURE_COUNT;
	string FISSURE_END;
	string FISSURE_LENGTH;
	string FISSURE_START;
	string FISSURE_YAW;
	int FLIP_SPRITE;
	int FX_ACTIVE;
	string NO_FIRE;
	string NO_ROCKS;
	string ORG_FISSURE_START;
	string ROCK_BODY;
	string ROCK_SCALE;
	string ROCK_VELOCITY;

	SfxFissure()
	{
		const string SCALE_ROCK_LARGE = Random(5.5, 7.5);
		const string RIGHT_ADJ_LARGE = Random(20, 22);
		const string LEFT_ADJ_LARGE = Random(-20, -22);
		const string SCALE_ROCK_SMALL = Random(5.5, 7.5);
		const string RIGHT_ADJ_SMALL = Random(35, 50);
		const string LEFT_ADJ_SMALL = Random(-35, -50);
	}

	void client_activate()
	{
		FISSURE_START = param1;
		ORG_FISSURE_START = FISSURE_START;
		FISSURE_YAW = param2;
		FISSURE_END = param3;
		FISSURE_LENGTH = param4;
		NO_ROCKS = param5;
		NO_FIRE = param6;
		FISSURE_COUNT = 0;
		FISSURE_ACTIVE = 1;
		FX_ACTIVE = 1;
		fissure_loop();
		ScheduleDelayedEvent(4.0, "end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void fissure_loop()
	{
		if (!(FISSURE_ACTIVE)) return;
		ScheduleDelayedEvent(0.135, "fissure_loop");
		fissure_debri();
		DRAWN_FISSURE_LENGTH += 64;
		if (DRAWN_FISSURE_LENGTH >= FISSURE_LENGTH)
		{
			LogDebug("fissure_stopped FISSURE_COUNT");
			FISSURE_ACTIVE = 0;
		}
		FISSURE_COUNT += 1;
		if (FISSURE_COUNT == 16)
		{
			FISSURE_ACTIVE = 0;
		}
	}

	void fissure_debri()
	{
		if (!(Distance(FISSURE_START, ORG_FISSURE_START) < FISSURE_LENGTH)) return;
		BEAM_START = FISSURE_START;
		BEAM_DIR = (FISSURE_END - BEAM_START).Normalize();
		BEAM_END = FISSURE_START;
		BEAM_END += "z";
		BEAM_DIR *= 48;
		BEAM_END += BEAM_DIR;
		FISSURE_START = BEAM_END;
		FISSURE_START = "z";
		string DEF_LINE_CENTER = BEAM_END;
		DEF_LINE_CENTER = "z";
		if (!(NO_ROCKS))
		{
			string LINE_CENTER = DEF_LINE_CENTER;
			string RND_LR = RIGHT_ADJ_LARGE;
			string RND_FB = Random(-8.0, 8.0);
			ROCK_SCALE = SCALE_ROCK_LARGE;
			ROCK_BODY = 0;
			ROCK_VELOCITY = Vector3(0, 0, 0);
			LINE_CENTER += /* TODO: $relpos */ $relpos(Vector3(0, FISSURE_YAW, 0), Vector3(RND_LR, RND_FB, 0));
			LINE_CENTER = "z";
			ClientEffect("tempent", "model", "rockgibs.mdl", LINE_CENTER, "setup_rock", "update_rock");
			string LINE_CENTER = DEF_LINE_CENTER;
			string RND_LR = LEFT_ADJ_LARGE;
			string RND_FB = Random(-8.0, 8.0);
			ROCK_SCALE = SCALE_ROCK_LARGE;
			ROCK_BODY = 0;
			ROCK_VELOCITY = Vector3(0, 0, 0);
			LINE_CENTER += /* TODO: $relpos */ $relpos(Vector3(0, FISSURE_YAW, 0), Vector3(RND_LR, RND_FB, 0));
			LINE_CENTER = "z";
			ClientEffect("tempent", "model", "rockgibs.mdl", LINE_CENTER, "setup_rock", "update_rock");
			string LINE_CENTER = DEF_LINE_CENTER;
			string RND_LR = RIGHT_ADJ_SMALL;
			string RND_FB = Random(-16.0, 16.0);
			ROCK_SCALE = SCALE_ROCK_SMALL;
			ROCK_BODY = RandomInt(1, 2);
			ROCK_VELOCITY = /* TODO: $relvel */ $relvel(Vector3(0, FISSURE_YAW, 0), RND_LR, ",", RND_FB, ",", 120);
			LINE_CENTER += /* TODO: $relpos */ $relpos(Vector3(0, FISSURE_YAW, 0), Vector3(RND_LR, RND_FB, 0));
			LINE_CENTER = "z";
			ClientEffect("tempent", "model", "rockgibs.mdl", LINE_CENTER, "setup_rock", "update_rock");
			string LINE_CENTER = DEF_LINE_CENTER;
			string RND_LR = LEFT_ADJ_SMALL;
			string RND_FB = Random(-16.0, 16.0);
			ROCK_SCALE = SCALE_ROCK_SMALL;
			ROCK_BODY = RandomInt(1, 2);
			ROCK_VELOCITY = /* TODO: $relvel */ $relvel(Vector3(0, FISSURE_YAW, 0), RND_LR, ",", RND_FB, ",", 120);
			LINE_CENTER += /* TODO: $relpos */ $relpos(Vector3(0, FISSURE_YAW, 0), Vector3(RND_LR, RND_FB, 0));
			LINE_CENTER = "z";
			ClientEffect("tempent", "model", "rockgibs.mdl", LINE_CENTER, "setup_rock", "update_rock");
			string LINE_CENTER = DEF_LINE_CENTER;
			string RND_LR = RIGHT_ADJ_SMALL;
			string RND_FB = Random(-16.0, 16.0);
			ROCK_SCALE = SCALE_ROCK_SMALL;
			ROCK_BODY = RandomInt(1, 2);
			ROCK_VELOCITY = /* TODO: $relvel */ $relvel(Vector3(0, FISSURE_YAW, 0), RND_LR, ",", RND_FB, ",", 120);
			LINE_CENTER += /* TODO: $relpos */ $relpos(Vector3(0, FISSURE_YAW, 0), Vector3(RND_LR, RND_FB, 0));
			LINE_CENTER = "z";
			ClientEffect("tempent", "model", "rockgibs.mdl", LINE_CENTER, "setup_rock", "update_rock");
			string LINE_CENTER = DEF_LINE_CENTER;
			string RND_LR = LEFT_ADJ_SMALL;
			string RND_FB = Random(-16.0, 16.0);
			ROCK_SCALE = SCALE_ROCK_SMALL;
			ROCK_BODY = RandomInt(1, 2);
			ROCK_VELOCITY = /* TODO: $relvel */ $relvel(Vector3(0, FISSURE_YAW, 0), RND_LR, ",", RND_FB, ",", 120);
			LINE_CENTER += /* TODO: $relpos */ $relpos(Vector3(0, FISSURE_YAW, 0), Vector3(RND_LR, RND_FB, 0));
			LINE_CENTER = "z";
			ClientEffect("tempent", "model", "rockgibs.mdl", LINE_CENTER, "setup_rock", "update_rock");
		}
		if ((NO_FIRE)) return;
		FLIP_SPRITE = 0;
		string L_FIRE_POS = DEF_LINE_CENTER;
		L_FIRE_POS = "z";
		ClientEffect("tempent", "sprite", "fire1_fixed2.spr", L_FIRE_POS, "setup_fire", "update_fire");
		FLIP_SPRITE = 1;
		ClientEffect("tempent", "sprite", "fire1_fixed2.spr", L_FIRE_POS, "setup_fire", "update_fire");
	}

	void update_rock()
	{
		string CUR_REND = "game.tempent.fuser1";
		string FADE_TIME = "game.tempent.fuser2";
		if (!(CUR_REND > 0)) return;
		if (!(GetGameTime() >= FADE_TIME)) return;
		CUR_REND -= 5;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_REND);
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", CUR_REND);
	}

	void setup_rock()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 4.0);
		ClientEffect("tempent", "set_current_prop", "scale", ROCK_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 2);
		ClientEffect("tempent", "set_current_prop", "velocity", ROCK_VELOCITY);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 50);
		ClientEffect("tempent", "set_current_prop", "body", ROCK_BODY);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		string RND_YAW = Random(0.0, 359.99);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, RND_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "fuser1", 255);
		string FADE_START = GetGameTime();
		FADE_START += 3.0;
		ClientEffect("tempent", "set_current_prop", "fuser2", FADE_START);
	}

	void update_fire()
	{
		string CUR_SIZE = "game.tempent.fuser1";
		CUR_SIZE -= 0.01;
		if (!(CUR_SIZE > 0)) return;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
	}

	void setup_fire()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		string L_YAW = FISSURE_YAW;
		L_YAW += 90;
		if (L_YAW > 359.99)
		{
			L_YAW -= 359.99;
		}
		if ((FLIP_SPRITE))
		{
			L_YAW += 180;
			if (L_YAW > 359.99)
			{
				L_YAW -= 359.99;
			}
		}
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, L_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "scale", 4.0);
		ClientEffect("tempent", "set_current_prop", "fuser1", 4.0);
	}

}

}
