#pragma context client

namespace MS
{

class BurningOneCl : CGameScript
{
	int CUR_BONE;
	float DEATH_FLAME_SCALE;
	string FX_DURATION;
	string FX_ORIGIN;
	string FX_RADIUS;
	string FX_TYPE;
	string HAND_SPRITES_ON;
	string ICE_BREATH_ON;
	string MODEL_IDX;
	string PALPATINE_ON;
	string REMOVE_DELAY;
	string SPR_COLOR;

	BurningOneCl()
	{
		const string GLOW_SPRITE = "3dmflaora.spr";
		const string ICE_BREATH_SPRITE = "explode1.spr";
		const Vector3 ICE_BREATH_COLOR = Vector3(255, 128, 0);
		const int TOTAL_OFS = 10;
	}

	void client_activate()
	{
		FX_TYPE = param1;
		LogDebug("*** cold_one_cl: PARAM1 PARAM2 PARAM3 PARAM4");
		if (FX_TYPE == "hand_sprites")
		{
			MODEL_IDX = param2;
			FX_DURATION = param3;
			SPR_COLOR = param4;
			HAND_SPRITES_ON = 1;
			REMOVE_DELAY = 2.1;
			FX_DURATION("end_fx");
			hand_sprite_loop();
		}
		if (FX_TYPE == "ice_breath")
		{
			MODEL_IDX = param2;
			FX_DURATION = param3;
			REMOVE_DELAY = 2.0;
			ICE_BREATH_ON = 1;
			ice_breath_loop();
			FX_DURATION("end_fx");
		}
		if (FX_TYPE == "palpatine")
		{
			MODEL_IDX = param2;
			FX_DURATION = param3;
			PALPATINE_ON = 1;
			REMOVE_DELAY = 1.0;
			palpatine_loop();
			FX_DURATION("end_fx");
		}
		if (FX_TYPE == "repulse")
		{
			FX_ORIGIN = param2;
			FX_RADIUS = param3;
			REMOVE_DELAY = 2.0;
			string POS_GROUND = /* TODO: $get_ground_height */ $get_ground_height(FX_ORIGIN);
			FX_ORIGIN = "z";
			for (int i = 0; i < 17; i++)
			{
				stun_burst_fx();
			}
			FX_DURATION("end_fx");
		}
	}

	void end_fx()
	{
		HAND_SPRITES_ON = 0;
		ICE_BREATH_ON = 0;
		PALPATINE_ON = 0;
		REMOVE_DELAY("remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void hand_sprite_loop()
	{
		if (!(HAND_SPRITES_ON)) return;
		ScheduleDelayedEvent(0.1, "hand_sprite_loop");
		string SPAWN_POS = /* TODO: $getcl */ $getcl(MODEL_IDX, "bonepos", 20);
		ClientEffect("tempent", "sprite", GLOW_SPRITE, SPAWN_POS, "setup_hand_sprite");
		string SPAWN_POS = /* TODO: $getcl */ $getcl(MODEL_IDX, "bonepos", 16);
		ClientEffect("tempent", "sprite", GLOW_SPRITE, SPAWN_POS, "setup_hand_sprite");
	}

	void setup_hand_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(Random(-20, 20), 0, 0)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPR_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void ice_breath_loop()
	{
		if (!(ICE_BREATH_ON)) return;
		ScheduleDelayedEvent(0.01, "ice_breath_loop");
		string CLOUD_ORG = /* TODO: $getcl */ $getcl(MODEL_IDX, "attachment2");
		ClientEffect("tempent", "sprite", ICE_BREATH_SPRITE, CLOUD_ORG, "setup_ice_breath_sprite");
		ClientEffect("tempent", "sprite", ICE_BREATH_SPRITE, CLOUD_ORG, "setup_ice_breath_sprite");
	}

	void ice_breath_off()
	{
		end_fx();
	}

	void setup_ice_breath_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 9);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", ICE_BREATH_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		string RND_RL = Random(-20, 20);
		string RND_UD = Random(-20, 20);
		string MY_ANG = /* TODO: $getcl */ $getcl(MODEL_IDX, "angles");
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(MY_ANG, Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void palpatine_loop()
	{
		if (!(PALPATINE_ON)) return;
		ScheduleDelayedEvent(0.1, "palpatine_loop");
		string OWNER_YAW = /* TODO: $getcl */ $getcl(MODEL_IDX, "angles.yaw");
		string BEAM_START = /* TODO: $getcl */ $getcl(MODEL_IDX, "bonepos", 20);
		string BEAM_END = BEAM_START;
		string RND_LR = Random(-128, 128);
		string RND_UD = Random(-10, 10);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(RND_LR, 256, RND_UD));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.25, 2.5, 0.5, 255, 50, 30, Vector3(1.5, 0.5, 0));
		string BEAM_START = /* TODO: $getcl */ $getcl(MODEL_IDX, "bonepos", 16);
		string BEAM_END = BEAM_START;
		string RND_LR = Random(-128, 128);
		string RND_UD = Random(-10, 10);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(RND_LR, 256, RND_UD));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.25, 2.5, 0.5, 255, 50, 30, Vector3(1.5, 0.5, 0));
	}

	void stun_burst_fx()
	{
		string FLAME_POS = FX_ORIGIN;
		FLAME_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, TOTAL_OFS, 0));
		ClientEffect("tempent", "sprite", "fire1_fixed.spr", FLAME_POS, "stunburst_flame");
		CYCLE_ANGLE += 20;
	}

	void stunburst_flame()
	{
		float FADE_DEL = 1.0;
		if (FX_RADIUS > 128)
		{
			float FADE_DEL = 2.0;
		}
		int SPRITE_SPEED = 100;
		if (FX_RADIUS > 128)
		{
			int SPRITE_SPEED = 400;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", FADE_DEL);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string FLAME_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, SPRITE_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", FLAME_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

	void head_flame()
	{
		DEATH_FLAME_SCALE = 1.0;
		string FLAME_POS = /* TODO: $getcl */ $getcl(MODEL_IDX, "bonepos", 29);
		CUR_BONE = 29;
		ClientEffect("tempent", "sprite", "fire1_fixed.spr", FLAME_POS, "death_flame", "death_flame_update");
	}

	void body_flame()
	{
		DEATH_FLAME_SCALE = 0.5;
		for (int i = 0; i < 28; i++)
		{
			setup_body_flames();
		}
	}

	void setup_body_flames()
	{
		string FLAME_POS = /* TODO: $getcl */ $getcl(MODEL_IDX, "bonepos", i);
		CUR_BONE = i;
		ClientEffect("tempent", "sprite", "fire1_fixed.spr", FLAME_POS, "death_flame", "death_flame_update");
	}

	void death_flame()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(64, 64, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "scale", DEATH_FLAME_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "update", 1);
		ClientEffect("tempent", "set_current_prop", "fuser2", CUR_BONE);
	}

	void death_flame_update()
	{
		string MY_BONE = "game.tempent.fuser2";
		ClientEffect("tempent", "set_current_prop", "origin", /* TODO: $getcl */ $getcl(MODEL_IDX, "bonepos", MY_BONE));
	}

}

}
