#pragma context server

namespace MS
{

class PlayerClEffectsWater : CGameScript
{
	string water.snd;
	float water.splashscale;

	PlayerClEffectsWater()
	{
		const string SPRITE_1 = "wsplash3.spr";
		Precache(SPRITE_1);
		const int OFS_POS = 5;
		const int OFS_NEG = -5;
		const int OFS_POS2 = 15;
		const int OFS_NEG2 = -15;
		const int BIG_SPLASH_SPEED = 300;
		const string BIG_SPLASH_SND = "body/splash1.wav";
		Precache(BIG_SPLASH_SND);
	}

	void game_playermove()
	{
		if ("game.pmove.oldwaterlevel" == 0)
		{
			if (("game.pmove.waterlevel"))
			{
			}
			if ("game.pmove.fallvelocity" < BIG_SPLASH_SPEED)
			{
				water_getsnd_wade();
			}
			else
			{
				water.snd = BIG_SPLASH_SND;
			}
			EmitSound3D(water.snd, "game.sound.maxvol", "const.snd.voice");
		}
	}

	void water_createsplash()
	{
		PARAM1 += Vector3(RandomInt(OFS_NEG, OFS_POS), RandomInt(OFS_NEG, OFS_POS), RandomInt(0, 1.5));
		water.splashscale = 0.2;
		ClientEffect("tempent", "sprite", SPRITE_1, param1, "setup_sprite1_splash");
	}

	void water_createsplash_big()
	{
		PARAM1 += Vector3(RandomInt(OFS_NEG2, OFS_POS2), RandomInt(OFS_NEG2, OFS_POS2), RandomInt(-3, 0));
		water.splashscale = 1;
		ClientEffect("tempent", "sprite", SPRITE_1, param1, "setup_sprite1_splash");
	}

	void water_getsnd_wade()
	{
		water.snd = "player/pl_wade";
		water.snd += RandomInt(1, 4);
		water.snd += ".wav";
	}

	void setup_sprite1_splash()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "framerate", 20);
		ClientEffect("tempent", "set_current_prop", "frames", 14);
		ClientEffect("tempent", "set_current_prop", "scale", water.splashscale);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
