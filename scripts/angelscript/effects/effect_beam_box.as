#pragma context client

namespace MS
{

class EffectBeamBox : CGameScript
{
	string BEAM_TIME;
	string BOX_HALF_SIZE;
	string BOX_ORIGIN;
	string BOX_SIZE;
	string POINT_10_1;
	string POINT_10_2;
	string POINT_11_1;
	string POINT_11_2;
	string POINT_12_1;
	string POINT_12_2;
	string POINT_1_1;
	string POINT_1_2;
	string POINT_2_1;
	string POINT_2_2;
	string POINT_3_1;
	string POINT_3_2;
	string POINT_4_1;
	string POINT_4_2;
	string POINT_5_1;
	string POINT_5_2;
	string POINT_6_1;
	string POINT_6_2;
	string POINT_7_1;
	string POINT_7_2;
	string POINT_8_1;
	string POINT_8_2;
	string POINT_9_1;
	string POINT_9_2;
	string START_MOVING_TO;

	EffectBeamBox()
	{
		const string BOX_COLOR = /* TODO: $clcol */ $clcol(186, 85, 211);
		const int BOX_WIDTH = 1;
		const int BOX_AMPLITUDE = 0;
		const int BOX_FRAMRATE = 0;
		const int BOX_BRIGHTNESS = 1;
		const string BOX_SPRITE = "rain.spr";
	}

	void client_activate()
	{
		BOX_ORIGIN = param1;
		BOX_SIZE = /* TODO: $math(multiply) */ param2;
		BOX_HALF_SIZE = param2;
		if ((param3).findFirst("PARAM") == 0)
		{
			BEAM_TIME = 1.0;
		}
		else
		{
			BEAM_TIME = param3;
		}
		BEAM_TIME("effect_die");
		START_MOVING_TO = BOX_ORIGIN;
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(90, 0, 0), Vector3(0, BOX_HALF_SIZE, 0));
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, BOX_HALF_SIZE, 0));
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(0, 90, 0), Vector3(0, BOX_HALF_SIZE, 0));
		POINT_1_1 = START_MOVING_TO;
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(0, 180, 0), Vector3(0, BOX_SIZE, 0));
		POINT_1_2 = START_MOVING_TO;
		POINT_2_1 = START_MOVING_TO;
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(0, 270, 0), Vector3(0, BOX_SIZE, 0));
		POINT_2_2 = START_MOVING_TO;
		POINT_3_1 = START_MOVING_TO;
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, BOX_SIZE, 0));
		POINT_3_2 = START_MOVING_TO;
		POINT_4_1 = START_MOVING_TO;
		POINT_4_2 = POINT_1_1;
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(-90, 0, 0), Vector3(0, BOX_SIZE, 0));
		POINT_5_1 = START_MOVING_TO;
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(0, 90, 0), Vector3(0, BOX_SIZE, 0));
		POINT_5_2 = START_MOVING_TO;
		POINT_6_1 = START_MOVING_TO;
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(0, 180, 0), Vector3(0, BOX_SIZE, 0));
		POINT_6_2 = START_MOVING_TO;
		POINT_7_1 = START_MOVING_TO;
		START_MOVING_TO += /* TODO: $relpos */ $relpos(Vector3(0, 270, 0), Vector3(0, BOX_SIZE, 0));
		POINT_7_2 = START_MOVING_TO;
		POINT_8_1 = START_MOVING_TO;
		POINT_8_2 = POINT_5_1;
		POINT_9_1 = POINT_4_1;
		POINT_9_2 = POINT_5_1;
		POINT_10_1 = POINT_1_1;
		POINT_10_2 = POINT_5_2;
		POINT_11_1 = POINT_2_1;
		POINT_11_2 = POINT_6_2;
		POINT_12_1 = POINT_2_2;
		POINT_12_2 = POINT_7_2;
		do_the_beam_thing();
		BEAM_TIME("effect_die");
	}

	void do_the_beam_thing()
	{
		ClientEffect("beam_points", POINT_1_1, POINT_1_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_2_1, POINT_2_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_3_1, POINT_3_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_4_1, POINT_4_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_5_1, POINT_5_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_6_1, POINT_6_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_7_1, POINT_7_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_8_1, POINT_8_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_9_1, POINT_9_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_10_1, POINT_10_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_11_1, POINT_11_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
		ClientEffect("beam_points", POINT_12_1, POINT_12_2, BOX_SPRITE, BEAM_TIME, BOX_WIDTH, BOX_AMPLITUDE, BOX_BRIGHTNESS, BOX_FRAMRATE, BOX_FRAMRATE, BOX_COLOR);
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
