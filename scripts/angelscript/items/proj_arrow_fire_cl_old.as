#pragma context server

namespace MS
{

class ProjArrowFireClOld : CGameScript
{
	string EFFECT_SET_TO_DIE;
	string LIGHT_COLOR;
	int LIGHT_RADIUS;
	int OFS_NEG;
	int OFS_POS;
	float SMOKE_DURATION;
	int SPD_NEG;
	int SPD_POS;
	string SPR_FIRE;
	string SPR_SMOKE1;
	string p.scale;
	int sfx.duration;
	string sfx.lightid;
	string sfx.modelid;

	ProjArrowFireClOld()
	{
		SPR_FIRE = "fire1_fixed.spr";
		SPR_SMOKE1 = "xsmoke3.spr";
		SMOKE_DURATION = "$randf(1,2)";
		OFS_POS = 5;
		OFS_NEG = -5;
		SPD_POS = 60;
		SPD_NEG = -60;
		LIGHT_RADIUS = 256;
		LIGHT_COLOR = Vector3(255, 200, 64);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		string l.pos = /* TODO: $getcl */ $getcl(sfx.modelid, "attachment0");
		smoke_spr_create(l.pos, SPR_SMOKE1, 0.5);
	}

	void client_activate()
	{
		sfx.modelid = param1;
		sfx.duration = -1;
		if ((/* TODO: $getcl */ $getcl(sfx.modelid, "exists")))
		{
			create_light(/* TODO: $getcl */ $getcl(sfx.modelid, "origin"));
			fire_spr_create();
		}
		else
		{
			EFFECT_SET_TO_DIE = 1;
			ScheduleDelayedEvent(20.0, "effect_die");
		}
		SetCallback("render", "enable");
	}

	void effect_die()
	{
		RemoveScript();
	}

	void game_think()
	{
		if ((/* TODO: $getcl */ $getcl(sfx.modelid, "exists"))) return;
		if ((EFFECT_SET_TO_DIE)) return;
		EFFECT_SET_TO_DIE = 1;
		ScheduleDelayedEvent(20.0, "effect_die");
	}

	void smoke_spr_create()
	{
		string l.pos = param1;
		l.pos += Vector3(Random(OFS_NEG, OFS_POS), Random(OFS_NEG, OFS_POS), Random(OFS_NEG, OFS_POS));
		p.scale = param3;
		ClientEffect("tempent", "sprite", param2, l.pos, "smoke_spr_steup");
	}

	void smoke_spr_steup()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", Random(100, 200));
		ClientEffect("tempent", "set_current_prop", "scale", p.scale);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(-0.1, -0.01));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(32, 32, 32));
		ClientEffect("tempent", "set_current_prop", "rendermodel", "alpha");
		ClientEffect("tempent", "set_current_prop", "frames", 14);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
	}

	void create_light()
	{
		if (!(param1 != "0")) return;
		ClientEffect("light", "new", param1, LIGHT_RADIUS, LIGHT_COLOR, 3);
		sfx.lightid = "game.script.last_light_id";
	}

	void game_prerender()
	{
		if (!(LIGHT_RADIUS > 0)) return;
		string l.radius = LIGHT_RADIUS;
		l.radius += Random(-8, 8);
		ClientEffect("light", sfx.lightid, /* TODO: $getcl */ $getcl(sfx.modelid, "origin"), l.radius, LIGHT_COLOR, 1);
	}

	void fire_spr_create()
	{
		ClientEffect("tempent", "sprite", SPR_FIRE, Vector3(0, 0, 0), "fire_spr_steup");
	}

	void fire_spr_steup()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "die_with_ent", sfx.modelid);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 128);
		ClientEffect("tempent", "set_current_prop", "scale", 0.3);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 128));
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "follow", sfx.modelid, 0);
	}

}

}
