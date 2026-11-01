#pragma context client

namespace MS
{

class ManaringPortals : CGameScript
{
	int CUR_PORTAL;
	string NPC_SWAPS_PORTAL;
	string PORTAL_POS;
	int SND_CHANNEL;
	string SPRITE_1;
	string SPRITE_2;
	string SPRITE_3;
	string SPRITE_4;

	ManaringPortals()
	{
		SPRITE_1 = "quests/manaring/vision1.spr";
		SPRITE_2 = "quests/manaring/vision2.spr";
		SPRITE_3 = "quests/manaring/vision3.spr";
		SPRITE_4 = "quests/manaring/vision4.spr";
		CUR_PORTAL = -1;
	}

	void game_precache()
	{
		Precache("quests/manaring/vision1.spr");
		Precache("quests/manaring/vision2.spr");
		Precache("quests/manaring/vision3.spr");
		Precache("quests/manaring/vision4.spr");
	}

	void client_activate()
	{
		PORTAL_POS = param1;
		NPC_SWAPS_PORTAL = param2;
		SND_CHANNEL = RandomInt(5, 255);
		EmitSound3D("magic/elecidlepop.wav", 10, PORTAL_POS);
		EmitSound3D("magic/chant_loop.wav", 10, PORTAL_POS, 0.8, SND_CHANNEL);
		spawn_a_portal();
	}

	void spawn_a_portal()
	{
		CUR_PORTAL += 1;
		if (CUR_PORTAL == 0)
		{
			ClientEffect("tempent", "sprite", SPRITE_1, PORTAL_POS, "setup_portal_sprite", "update_portal_sprite");
		}
		if (CUR_PORTAL == 1)
		{
			ClientEffect("tempent", "sprite", SPRITE_2, PORTAL_POS, "setup_portal_sprite", "update_portal_sprite");
		}
		if (CUR_PORTAL == 2)
		{
			ClientEffect("tempent", "sprite", SPRITE_3, PORTAL_POS, "setup_portal_sprite", "update_portal_sprite");
		}
		if (CUR_PORTAL == 3)
		{
			ClientEffect("tempent", "sprite", SPRITE_4, PORTAL_POS, "setup_portal_sprite", "update_portal_sprite");
		}
		if (CUR_PORTAL > 3)
		{
			kill_script();
		}
		else
		{
			if (!(NPC_SWAPS_PORTAL))
			{
				ScheduleDelayedEvent(5, "spawn_a_portal");
			}
		}
	}

	void setup_portal_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 30);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 30);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.2);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "iuser1", CUR_PORTAL);
	}

	void update_portal_sprite()
	{
		if ("game.tempent.iuser1" != CUR_PORTAL)
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(10000, 10000, 10000));
		}
	}

	void kill_script()
	{
		EmitSound3D("null.wav", 10, PORTAL_POS, 0.8, SND_CHANNEL);
		RemoveScript();
	}

}

}
