#pragma context client

namespace MS
{

class SkeletonLightningCl : CGameScript
{
	string CL_AUTO_LIFT;
	string CL_COLOR;
	string CL_DURATION;
	string CL_FOLLOW;
	string CL_RADIUS;
	int CYCLE_ANGLE;
	int FX_ACTIVE;
	int GO_AWAY;
	string OWNER_IDX;
	string SPRITE_SCALE;
	int TOTAL_OFS;
	int TURN_INC;

	SkeletonLightningCl()
	{
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
	}

	void client_activate()
	{
		OWNER_IDX = param1;
		CL_RADIUS = param2;
		CL_COLOR = param3;
		CL_DURATION = param4;
		CL_AUTO_LIFT = param5;
		CL_FOLLOW = param6;
		LogDebug("*** barrier_activate idx OWNER_IDX rad CL_RADIUS col CL_COLOR dur CL_DURATION alift CL_AUTO_LIFT fol CL_FOLLOW");
		CL_DURATION("end_fx");
		CYCLE_ANGLE = 0;
		ScheduleDelayedEvent(0.1, "spriteify");
	}

	void spriteify()
	{
		TOTAL_OFS = 64;
		if (CL_RADIUS <= 256)
		{
			SPRITE_SCALE = 0.75;
		}
		else
		{
			SPRITE_SCALE = 1.0;
		}
		TURN_INC = 20;
		for (int i = 0; i < 18; i++)
		{
			createsprite();
		}
	}

	void createsprite()
	{
		string l.pos = /* TODO: $getcl */ $getcl(OWNER_IDX, "origin");
		CYCLE_ANGLE += TURN_INC;
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, CL_RADIUS, 36));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", l.pos, "setup_sprite1_sparkle", "sprite_update");
	}

	void setup_sprite1_sparkle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", CL_DURATION);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendercolor", CL_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", CYCLE_ANGLE);
	}

	void sprite_update()
	{
		if (!(GO_AWAY))
		{
			if ((CL_FOLLOW))
			{
			}
			string SPRITE_ORG = /* TODO: $getcl */ $getcl(OWNER_IDX, "origin");
			string MY_ANGLE = "game.tempent.fuser1";
			string SPRITE_VOF = (SPRITE_ORG).z;
			SPRITE_VOF += 48;
			SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, MY_ANGLE, 0), Vector3(0, CL_RADIUS, SPRITE_VOF));
			ClientEffect("tempent", "set_current_prop", "origin", SPRITE_ORG);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
			ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 400));
			ClientEffect("tempent", "set_current_prop", "fadeout", 2.0);
			ClientEffect("tempent", "set_current_prop", "gravity", -4.0);
		}
	}

	void end_fx()
	{
		clear_beams();
		clear_sprites();
	}

	void clear_sprites()
	{
		GO_AWAY = 1;
		FX_ACTIVE = 0;
		sprite_update();
		ScheduleDelayedEvent(5.0, "remove_me");
	}

	void remove_me()
	{
		if ((CL_AUTO_LIFT))
		{
			CL_AUTO_LIFT = 0;
			clear_sprites();
		}
		else
		{
			RemoveScript();
		}
	}

	void clear_beams()
	{
		ClientEffect("beam_update", "removeall");
	}

	void add_beam()
	{
		ClientEffect("beam_ents", OWNER_IDX, 1, param1, 2, "lgtning.spr", 1.0, 1, 1, 255, 100, 30, Vector3(1, 1, 0));
		ClientEffect("spark", OWNER_IDX, 2);
		string L_RND_SND = RandomInt(1, 3);
		if (L_RND_SND == 1)
		{
			string L_SOUND = SOUND_SHOCK1;
		}
		if (L_RND_SND == 2)
		{
			string L_SOUND = SOUND_SHOCK2;
		}
		if (L_RND_SND == 3)
		{
			string L_SOUND = SOUND_SHOCK3;
		}
		EmitSound3D(L_SOUND, 10, /* TODO: $getcl */ $getcl(param1, "origin"), 0.8, 0, RandomInt(80, 120));
	}

}

}
