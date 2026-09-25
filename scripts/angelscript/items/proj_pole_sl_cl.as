#pragma context server

namespace MS
{

class ProjPoleSlCl : CGameScript
{
	string FX_ANGS;
	string FX_OWNER;
	int SPRITES_COUNT;
	string SPRITES_DEST;
	string SPRITES_DIR;
	string SPRITES_ORG;

	void client_activate()
	{
		FX_OWNER = param1;
		FX_ANGS = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
		FX_ANGS = "x";
		SPRITES_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SPRITES_DEST = SPRITES_ORG;
		SPRITES_DEST += /* TODO: $relpos */ $relpos(FX_ANGS, Vector3(0, -128, 0));
		SPRITES_DIR = (SPRITES_DEST - SPRITES_ORG).Normalize();
		SPRITES_COUNT = 0;
		for (int i = 0; i < 8; i++)
		{
			do_sprites();
		}
		ScheduleDelayedEvent(1.0, "end_fx");
	}

	void end_fx()
	{
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void do_sprites()
	{
		string L_SPR_POS = SPRITES_ORG;
		string L_SPR_ADD = SPRITES_DIR;
		L_SPR_ADD *= SPRITES_COUNT;
		L_SPR_POS += L_SPR_ADD;
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_SPR_POS, "setup_poof", "update_poof");
		SPRITES_COUNT += 16;
	}

	void update_poof()
	{
		string L_CUR_SCALE = "game.tempent.fuser1";
		if (!(L_CUR_SCALE > 0)) return;
		L_CUR_SCALE -= 0.01;
		ClientEffect("tempent", "set_current_prop", "scale", L_CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "fuser1", L_CUR_SCALE);
	}

	void setup_poof()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(32, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "scale", 0.75);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.75);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.25);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
