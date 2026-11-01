#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerLightning : CGameScript
{
	string ANIM_IDLE;
	int BEAMS_SETUP;
	string BEAM_COLOR;
	int BEAM_ROT;
	string BOTTOM_MID;
	int B_BRIGHT;
	int B_COUNT;
	string C_FX_SPRITE;
	float DEATH_DELAY;
	string EFFECTS_SPRITE;
	string FLOOR;
	string FX_SCRIPT;
	int LIGHTING_RADIUS;
	int MODEL_OFSET;
	string OWNER_IDX;
	float REMOVE_DELAY;
	string ROOF;
	int SHOW_FX;
	string SOUND_SPAWN;
	string SPAWNER_MODEL;
	int SPR_RENDER;

	SpellMakerLightning()
	{
		FX_SCRIPT = "monsters/companion/spell_maker_lightning";
		ANIM_IDLE = "";
		SPAWNER_MODEL = "none";
		MODEL_OFSET = 0;
		SOUND_SPAWN = "weather/Storm_exclamation.wav";
		REMOVE_DELAY = 10.0;
		SHOW_FX = 1;
		EFFECTS_SPRITE = "lgtning.spr";
		C_FX_SPRITE = "lgtning.spr";
		LIGHTING_RADIUS = 32;
		DEATH_DELAY = 5.0;
		BEAM_COLOR = Vector3(20, 20, 255);
	}

	void OnSpawn() override
	{
	}

	void client_activate()
	{
		OWNER_IDX = param2;
		string C_POS = /* TODO: $getcl */ $getcl(OWNER_IDX, "origin");
		string C_POS_X = (C_POS).x;
		string C_POS_Y = (C_POS).y;
		string C_POS_Z = (C_POS).z;
		string Z_END = C_POS_Z;
		Z_END += 4000;
		Vector3 TRACE_END = Vector3(C_POS_X, C_POS_Y, Z_END);
		ROOF = TraceLine(C_POS, TRACE_END);
		ROOF = (ROOF).z;
		FLOOR = /* TODO: $get_ground_height */ $get_ground_height(C_POS);
		string MID = FLOOR;
		MID += 36;
		BEAM_ROT = 0;
		B_BRIGHT = 1;
		B_COUNT = 0;
		SPR_RENDER = 200;
		BEAMS_SETUP = 1;
		cl_make_beams();
		DEATH_DELAY("remove_me");
		BOTTOM_MID = Vector3(C_POS_X, C_POS_Y, MID);
		ClientEffect("tempent", "sprite", "blueflare1.spr", BOTTOM_MID, "setup_sprite1_sparkle", "sprite_update");
	}

	void setup_sprite1_sparkle()
	{
		string SPR_DEATH = DEATH_DELAY;
		SPR_DEATH += 1.0;
		ClientEffect("tempent", "set_current_prop", "origin", BOTTOM_MID);
		ClientEffect("tempent", "set_current_prop", "death_delay", SPR_DEATH);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 1.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", SPR_RENDER);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(254, 254, 254));
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void sprite_update()
	{
		ClientEffect("tempent", "set_current_prop", "origin", BOTTOM_MID);
		if (B_COUNT > 35)
		{
			SPR_RENDER -= 1;
			ClientEffect("tempent", "set_current_prop", "rendermode", "add");
			ClientEffect("tempent", "set_current_prop", "renderamt", SPR_RENDER);
		}
	}

	void game_prerender()
	{
		sprite_update();
	}

	void cl_make_beams()
	{
		SetRepeatDelay(0.1);
		B_COUNT += 1;
		if (!(BEAMS_SETUP)) return;
		string C_POS = /* TODO: $getcl */ $getcl(OWNER_IDX, "origin");
		string C_POS_X = (C_POS).x;
		string C_POS_Y = (C_POS).y;
		string C_POS_Z = (C_POS).z;
		Vector3 TOP_CENTER = Vector3(C_POS_X, C_POS_Y, ROOF);
		BOTTOM_MID = Vector3(C_POS_X, C_POS_Y, MID);
		Vector3 BOTTOM_CENTER = Vector3(C_POS_X, C_POS_Y, FLOOR);
		if (B_COUNT < 40)
		{
			BEAM_ROT += 10;
			if (BEAM_ROT > 359)
			{
				BEAM_ROT = 0;
			}
			string BEAM_END = BOTTOM_CENTER;
			BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, BEAM_ROT, 0), Vector3(0, LIGHTING_RADIUS, 0));
			ClientEffect("beam_points", TOP_CENTER, BEAM_END, "lgtning.spr", 0.2, 3.0, 0.2, B_BRIGHT, 50, 30, BEAM_COLOR);
			ClientEffect("beam_points", BEAM_END, BOTTOM_MID, "lgtning.spr", 0.2, 3.0, 0.2, B_BRIGHT, 50, 30, BEAM_COLOR);
			string BEAM_END = BOTTOM_CENTER;
			int ANG_ADJ = 120;
			ANG_ADJ += BEAM_ROT;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, LIGHTING_RADIUS, 0));
			ClientEffect("beam_points", TOP_CENTER, BEAM_END, "lgtning.spr", 0.2, 3.0, 0.2, B_BRIGHT, 50, 30, BEAM_COLOR);
			ClientEffect("beam_points", BEAM_END, BOTTOM_MID, "lgtning.spr", 0.2, 3.0, 0.2, B_BRIGHT, 50, 30, BEAM_COLOR);
			string BEAM_END = BOTTOM_CENTER;
			int ANG_ADJ = 240;
			ANG_ADJ += BEAM_ROT;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, LIGHTING_RADIUS, 0));
			ClientEffect("beam_points", TOP_CENTER, BEAM_END, "lgtning.spr", 0.2, 3.0, 0.1, B_BRIGHT, 50, 30, BEAM_COLOR);
			ClientEffect("beam_points", BEAM_END, BOTTOM_MID, "lgtning.spr", 0.2, 3.0, 0.2, B_BRIGHT, 50, 30, BEAM_COLOR);
		}
		sprite_update();
	}

	void remove_me()
	{
		RemoveScript();
	}

	void svr_show_fx()
	{
		string BEAM_WIDTH = GetSkillLevel(MY_OWNER, "spellcasting.lightning");
		int BEAM_WIDTH = int(BEAM_WIDTH);
		int x = -64;
		int y = -64;
		string z = (/* TODO: $relpos */ $relpos(0, 0, 0)).z;
		string gnd = /* TODO: $get_ground_height */ $get_ground_height(/* TODO: $relpos */ $relpos(x, y, 250));
		gnd -= z;
		gnd *= -1;
		string temp = gnd;
		temp -= 64;
		beam_silent(x, y, gnd);
		int x = 64;
		int y = 64;
		string z = (/* TODO: $relpos */ $relpos(0, 0, 0)).z;
		string gnd = /* TODO: $get_ground_height */ $get_ground_height(/* TODO: $relpos */ $relpos(x, y, 250));
		gnd -= z;
		gnd *= -1;
		string temp = gnd;
		temp -= 64;
		beam_silent(x, y, gnd);
		int x = -64;
		int y = 64;
		string z = (/* TODO: $relpos */ $relpos(0, 0, 0)).z;
		string gnd = /* TODO: $get_ground_height */ $get_ground_height(/* TODO: $relpos */ $relpos(x, y, 250));
		gnd -= z;
		gnd *= -1;
		string temp = gnd;
		temp -= 64;
		beam_silent(x, y, gnd);
		int x = 64;
		int y = -64;
		string z = (/* TODO: $relpos */ $relpos(0, 0, 0)).z;
		string gnd = /* TODO: $get_ground_height */ $get_ground_height(/* TODO: $relpos */ $relpos(x, y, 250));
		gnd -= z;
		gnd *= -1;
		string temp = gnd;
		temp -= 64;
		beam_silent(x, y, gnd);
		int x = 0;
		int y = 0;
		string z = (/* TODO: $relpos */ $relpos(0, 0, 0)).z;
		string gnd = /* TODO: $get_ground_height */ $get_ground_height(/* TODO: $relpos */ $relpos(x, y, 250));
		gnd -= z;
		gnd *= -1;
		string temp = gnd;
		temp -= 64;
		center_beam(x, y, gnd);
	}

	void beam_silent()
	{
		string BEAM_WIDTH = GetSkillLevel(MY_OWNER, "spellcasting.lightning");
		int BEAM_WIDTH = int(BEAM_WIDTH);
		BEAM_WIDTH *= 8;
		int GROUND_LEVEL = -1000;
		int HEIGHT = 1000;
		Effect("beam", "point", EFFECTS_SPRITE, BEAM_WIDTH, /* TODO: $relpos */ $relpos(param1, param2, 1000), /* TODO: $relpos */ $relpos(param1, param2, -1000), Vector3(128, 128, 255), 64, 64, 2);
	}

	void center_beam()
	{
		int BEAM_WIDTH = 1600;
		int GROUND_LEVEL = -1000;
		int HEIGHT = 1000;
		Effect("beam", "point", C_FX_SPRITE, BEAM_WIDTH, /* TODO: $relpos */ $relpos(param1, param2, 1000), /* TODO: $relpos */ $relpos(param1, param2, -1000), Vector3(255, 255, 255), 64, 64, 2);
	}

}

}
