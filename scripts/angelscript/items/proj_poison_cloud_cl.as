#pragma context server

namespace MS
{

class ProjPoisonCloudCl : CGameScript
{
	int script.duration;
	string script.lightid;
	string script.modelid;

	ProjPoisonCloudCl()
	{
		const string SPRITE_1 = "poison_cloud.spr";
		const string GLOW_DURATION = "$randf(1,2)";
		Precache(SPRITE_1);
		const int OFS_POS = 15;
		const int OFS_NEG = -15;
		const int SPD_POS = 60;
		const int SPD_NEG = -60;
		const int LIGHT_RADIUS = 128;
		const Vector3 LIGHT_COLOR = Vector3(0, 255, 0);
		SetCallback("render", "enable");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.2);
		string l.pos = /* TODO: $getcl */ $getcl(script.modelid, "origin");
		make_sprite_1(l.pos);
		make_sprite_1(l.pos);
	}

	void client_activate()
	{
		script.modelid = param1;
		script.duration = 30;
		if ((/* TODO: $getcl */ $getcl(script.modelid, "exists")))
		{
			script_duration("effect_die");
			create_light(/* TODO: $getcl */ $getcl(script.modelid, "origin"));
		}
		else
		{
			effect_die();
		}
	}

	void effect_die()
	{
		RemoveScript();
		ClientEvent("remove", script.modelid, script.lightid);
	}

	void make_sprite_1()
	{
		string l.pos = param1;
		l.pos += Vector3(Random(OFS_NEG, OFS_POS), Random(OFS_NEG, OFS_POS), Random(OFS_NEG, OFS_POS));
		ClientEffect("tempent", "sprite", SPRITE_1, l.pos, "setup_sprite_1");
	}

	void setup_sprite_1()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.2);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.2, 0.1));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, Random(0, 5)));
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("tempent", "set_current_prop", "rendermodel", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", Random(128, 200));
	}

	void create_light()
	{
		if (!(param1 != "0")) return;
		ClientEffect("light", "new", param1, LIGHT_RADIUS, LIGHT_COLOR, script.duration);
		script.lightid = "game.script.last_light_id";
	}

	void game_prerender()
	{
		if (!(LIGHT_RADIUS > 0)) return;
		string l.radius = LIGHT_RADIUS;
		l.radius += Random(-8, 8);
		ClientEffect("light", script.lightid, /* TODO: $getcl */ $getcl(script.modelid, "origin"), l.radius, LIGHT_COLOR, 1);
	}

}

}
