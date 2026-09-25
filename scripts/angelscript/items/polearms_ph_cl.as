#pragma context server

namespace MS
{

class PolearmsPhCl : CGameScript
{
	string FORK_SPRITE_ORG;
	int FX_ACTIVE;
	string FX_OWNER;
	string FX_VIEW_IDX;

	void client_activate()
	{
		FX_OWNER = param1;
		LogDebug("*** polearms_ph FX_OWNER vs game.localplayer.index");
		if (!("game.localplayer.thirdperson"))
		{
			if ("game.localplayer.index" == FX_OWNER)
			{
			}
			FX_VIEW_IDX = "game.localplayer.viewmodel.active.id";
			FORK_SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_VIEW_IDX, "attachment0");
			ClientEffect("tempent", "sprite", "3dmflaora.spr", FORK_SPRITE_ORG, "setup_fork_sprite", "update_fork_sprite");
		}
		FX_ACTIVE = 1;
		ScheduleDelayedEvent(2.0, "end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void do_lightning()
	{
		string BEAM_END = param1;
		if ("game.localplayer.index" == FX_OWNER)
		{
			if (!("game.localplayer.thirdperson"))
			{
				string BEAM_START = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "attachment0");
			}
			else
			{
				string BEAM_START = /* TODO: $getcl */ $getcl(FX_OWNER, "bonepos", 38);
			}
		}
		else
		{
			string BEAM_START = /* TODO: $getcl */ $getcl(FX_OWNER, "bonepos", 38);
		}
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.5, 15.0, 0.5, 255, 50, 30, Vector3(255, 255, 0));
	}

	void update_fork_sprite()
	{
		if (!(FX_ACTIVE)) return;
		if (!("game.localplayer.thirdperson"))
		{
			ClientEffect("tempent", "set_current_prop", "origin", /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "attachment0"));
		}
	}

	void setup_fork_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
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
