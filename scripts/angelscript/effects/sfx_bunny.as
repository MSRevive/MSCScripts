#pragma context server

namespace MS
{

class SfxBunny : CGameScript
{
	void client_activate()
	{
		SetCallback("render", "enable");
		string EYE_POS = "game.localplayer.eyepos";
		string EYE_ANGS = "game.localplayer.viewangles";
		EYE_POS += /* TODO: $relpos */ $relpos(EYE_ANGS, Vector3(0, 20, 28));
		LogDebug("*** client_activate EYE_POS EYE_ANGS");
		ClientEffect("tempent", "sprite", "bunny.spr", EYE_POS, "setup_bunny", "update_bunny");
		ScheduleDelayedEvent(20.0, "remove_script");
		EmitSound3D("ambience/the_horror1.wav", 10, EYE_POS);
	}

	void game_prerender()
	{
	}

	void remove_script()
	{
		RemoveScript();
	}

	void update_bunny()
	{
		string EYE_POS = "game.localplayer.eyepos";
		string EYE_ANGS = "game.localplayer.viewangles";
		EYE_POS += /* TODO: $relpos */ $relpos(EYE_ANGS, Vector3(0, 20, 28));
		ClientEffect("tempent", "set_current_prop", "origin", EYE_POS);
		string CUR_ALPHA = "game.tempent.fuser1";
		CUR_ALPHA += 1;
		if (CUR_ALPHA > 255)
		{
			int CUR_ALPHA = 200;
		}
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_ALPHA);
		ClientEffect("tempent", "set_current_prop", "renderamt", CUR_ALPHA);
	}

	void setup_bunny()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 19.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 200);
	}

}

}
