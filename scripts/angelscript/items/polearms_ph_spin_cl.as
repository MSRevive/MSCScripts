#pragma context server

namespace MS
{

class PolearmsPhSpinCl : CGameScript
{
	string FORK_SPRITE_ORG;
	int FX_ACTIVE;
	string FX_OWNER;
	string FX_VIEW_IDX;

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.25, 0.5));
		if ((FX_ACTIVE))
		{
		}
		string BEAM_START = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string OWNER_VANG = /* TODO: $getcl */ $getcl(FX_OWNER, "viewangles");
		BEAM_START += /* TODO: $relpos */ $relpos(OWNER_VANG, Vector3(0, 32, 0));
		string BEAM_END = BEAM_START;
		float RND_ANG = Random(0.0, 359.99);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(RND_ANG, 0, 0), Vector3(0, 64, 0));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", Random(0.25, 0.5), 2.0, 3.0, 255, 50, 30, Vector3(255, 255, 0));
		string BEAM_END = BEAM_START;
		float RND_ANG = Random(0.0, 359.99);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(RND_ANG, 0, 0), Vector3(0, 64, 0));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", Random(0.25, 0.5), 2.0, 3.0, 255, 50, 30, Vector3(255, 255, 0));
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_ACTIVE = 1;
		if (!("game.localplayer.thirdperson"))
		{
			if ("game.localplayer.index" == FX_OWNER)
			{
			}
			FX_VIEW_IDX = "game.localplayer.viewmodel.active.id";
			FORK_SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_VIEW_IDX, "bonepos", 48);
			ClientEffect("tempent", "sprite", "3dmflaora.spr", FORK_SPRITE_ORG, "setup_fork_sprite", "update_fork_sprite");
		}
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

	void update_fork_sprite()
	{
		if (!(FX_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
		if (!(FX_ACTIVE)) return;
		if (!("game.localplayer.thirdperson"))
		{
			ClientEffect("tempent", "set_current_prop", "origin", /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 48));
		}
	}

	void setup_fork_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 30.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(254, 254, 1));
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

}

}
