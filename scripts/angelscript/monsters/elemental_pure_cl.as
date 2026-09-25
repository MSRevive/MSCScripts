#pragma context server

namespace MS
{

class ElementalPureCl : CGameScript
{
	string BONE_IDX;
	int FX_ACTIVE;
	string FX_COLOR;
	string FX_DURATION;
	string FX_LIGHT;
	string FX_OWNER;
	string FX_TYPE;
	int MAX_BONE;
	int OWNER_DIED;

	ElementalPureCl()
	{
		MAX_BONE = 17;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_COLOR = param2;
		FX_TYPE = param3;
		FX_DURATION = param4;
		FX_ACTIVE = 1;
		LogDebug("$currentscript client_activate own FX_OWNER col FX_COLOR typ FX_TYPE dur FX_DURATION");
		SetCallback("render", "enable");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), 64, FX_COLOR, 0.1);
		FX_LIGHT = "game.script.last_light_id";
		skeleton_sprite();
		FX_DURATION("end_fx");
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

	void owner_death()
	{
		OWNER_DIED = 1;
		ScheduleDelayedEvent(3.0, "end_fx");
	}

	void game_prerender()
	{
		if (!(FX_LIGHT > 0)) return;
		ClientEffect("light", FX_LIGHT, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), 64, AU_COLOR, 0.1);
	}

	void skeleton_sprite()
	{
		if (FX_TYPE == "fire")
		{
			array<string> ARRAY_BONEPOS;
			for (int i = 0; i < MAX_BONE; i++)
			{
				light_bones_fire();
			}
		}
	}

	void light_bones_fire()
	{
		LogDebug("light_bones_fire");
		BONE_IDX = i;
		string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "bonepos", BONE_IDX);
		ClientEffect("tempent", "sprite", "3dmflaora.spr", L_POS, "setup_bone_sprite", "update_bone_sprite");
	}

	void setup_bone_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "renderamt", 150);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "iuser1", BONE_IDX);
		float L_CREATE_TIME = GetGameTime();
		ClientEffect("tempent", "set_current_prop", "fuser1", (L_CREATE_TIME + 0.1));
	}

	void update_bone_sprite()
	{
		if ((FX_ACTIVE))
		{
			if (!(OWNER_DIED))
			{
				string L_IDX = "game.tempent.iuser1";
				string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "bonepos", L_IDX);
				ClientEffect("tempent", "set_current_prop", "origin", L_POS);
				string L_NEXT_UPDATE = "game.tempent.fuser1";
				float L_TIME = GetGameTime();
				if (L_TIME > L_NEXT_UPDATE)
				{
				}
				ClientEffect("tempent", "set_current_prop", "fuser1", (L_TIME + 0.1));
				ClientEffect("tempent", "sprite", "3dmflaora.spr", L_POS, "setup_drip_sprite");
			}
			else
			{
				ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, -100));
				ClientEffect("tempent", "set_current_prop", "gravity", 1);
				ClientEffect("tempent", "set_current_prop", "collide", "world");
				ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
			}
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
	}

	void setup_drip_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.25);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "renderamt", 150);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
