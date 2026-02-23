#pragma context server

namespace MS
{

class LrodCl : CGameScript
{
	string handmagic.anim;
	string handmagic.event;
	string handmagic.handid;
	string magichand.attachment;
	string magichand.on;
	string script.duration;
	int script.islocal;
	string script.modelid;
	int script.prepdone;
	string script.prepduration;

	LrodCl()
	{
		const string SPRITE_LIGHTNING = "lgtning.spr";
		const string SPRITE_GLOW = "3dmflaora.spr";
		const int GLOW_DURATION = 3;
		const float OFS_POS = 0.2;
		const float OFS_NEG = -0.2;
		const int LIGHT_RADIUS = 128;
		const Vector3 LIGHT_COLOR = Vector3(100, 33, 253);
		const int SKYLTNG_OFS = 256;
		Precache(SPRITE_GLOW);
		Precache(SPRITE_LIGHTNING);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.15, 0.25));
		if (!(script.prepdone))
		{
		}
		if ((script.islocal))
		{
			if (!("game.localplayer.thirdperson"))
			{
			}
			int script.isfirstperson = 1;
		}
		if (!(script.isfirstperson))
		{
			make_sprite_1(/* TODO: $getcl */ $getcl(script.modelid, "bonepos", 21));
			make_sprite_1(/* TODO: $getcl */ $getcl(script.modelid, "bonepos", 38));
		}
		else
		{
			string handid = "game.localplayer.viewmodel.active.id";
		}
	}

	void client_activate()
	{
		script.modelid = param1;
		script.prepduration = param2;
		script.duration = param3;
		script.islocal = 0;
		if (script.modelid == "game.localplayer.index")
		{
			script.islocal = 1;
			SetCallback("render", "enable");
		}
		if ((/* TODO: $getcl */ $getcl(script.modelid, "exists")))
		{
			script_prepdone("prep_done");
			create_light(/* TODO: $getcl */ $getcl(script.modelid, "origin"));
			cl_handmagic_beam("righthand");
		}
		else
		{
			effect_die();
		}
	}

	void effect_die()
	{
		RemoveScript();
	}

	void prep_done()
	{
		script.prepdone = 1;
	}

	void make_sprite_1()
	{
		if (!(param1 != "0")) return;
		string l.pos = param1;
		l.pos += Vector3(RandomInt(OFS_NEG, OFS_POS), RandomInt(OFS_NEG, OFS_POS), RandomInt(OFS_NEG, OFS_POS));
		ClientEffect("tempent", "sprite", SPRITE_GLOW, l.pos, "setup_sprite_1");
	}

	void setup_sprite_1()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", GLOW_DURATION);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.2, 0.1));
		ClientEffect("tempent", "set_current_prop", "collide", "world|die");
	}

	void create_light()
	{
		if (!(param1 != "0")) return;
		ClientEffect("light", "new", param1, LIGHT_RADIUS, LIGHT_COLOR, script.duration);
	}

	void cl_handmagic_beam()
	{
		if (param1 == "hands")
		{
			magichand.on = 1;
			handmagic.handid = "game.localplayer.viewmodel.active.id";
			handmagic.anim = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "anim");
			handmagic.event = "handmagic_connecthands";
		}
		else
		{
			if (param1 == "righthand")
			{
				magichand.on = 1;
				handmagic.handid = "game.localplayer.viewmodel.active.id";
				handmagic.anim = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "anim");
				handmagic.event = "handmagic_righthand";
			}
			else
			{
				magichand.on = 0;
			}
		}
	}

	void handmagic_connecthands()
	{
		if (!(param1))
		{
			handmagic_createbeam(16, 35);
			handmagic_createbeam(19, 38);
			handmagic_createbeam(22, 41);
			handmagic_createbeam(25, 44);
			handmagic_createbeam(28, 47);
		}
		else
		{
			create_sprite_2(1);
			create_sprite_2(2);
		}
	}

	void handmagic_righthand()
	{
		if (!(param1))
		{
			handmagic_createbeam_to_sky(35);
			handmagic_createbeam_to_sky(38);
			handmagic_createbeam_to_sky(41);
			handmagic_createbeam_to_sky(44);
			handmagic_createbeam_to_sky(47);
		}
		else
		{
			create_sprite_2(1);
		}
	}

	void game_render_transparent()
	{
		if (!(magichand.on == 1)) return;
		int l.continue = 1;
		if ("game.localplayer.viewmodel.active.id" != handmagic.handid)
		{
			int l.continue = 0;
		}
		if (handmagic.anim != /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "anim"))
		{
			int l.continue = 0;
		}
		if (!(l.continue))
		{
			cl_handmagic_beam("stop");
		}
		if (!(l.continue)) return;
		handmagic_event();
		string l.lightpos = /* TODO: $getcl */ $getcl("game.localplayer.index", "origin");
		l.lightpos += Vector3(0, 0, 12);
		ClientEffect("light", "new", l.lightpos, LIGHT_RADIUS, LIGHT_COLOR, 0.01);
	}

	void handmagic_createbeam()
	{
		string l.pos.left = /* TODO: $getcl */ $getcl(handmagic.handid, "bonepos", param1);
		string l.pos.right = /* TODO: $getcl */ $getcl(handmagic.handid, "bonepos", param2);
		ClientEffect("beam_points", l.pos.left, l.pos.right, SPRITE_LIGHTNING, 0.001, 0.1, 0.1, 0.3, 0.1, 30, Vector3(1, 0.5, 2));
	}

	void handmagic_createbeam_to_sky()
	{
		if (!(RandomInt(0, 100) < 10)) return;
		string l.pos.finger = /* TODO: $getcl */ $getcl(handmagic.handid, "bonepos", param1);
		string l.pos.sky = l.pos.finger;
		string l.ofs.x = Random(/* TODO: $neg */ $neg(SKYLTNG_OFS), SKYLTNG_OFS);
		string l.ofs.y = Random(/* TODO: $neg */ $neg(SKYLTNG_OFS), SKYLTNG_OFS);
		l.pos.sky += Vector3(l.ofs.x, l.ofs.y, 1024);
		ClientEffect("beam_points", l.pos.finger, l.pos.sky, SPRITE_LIGHTNING, 0.1, 1, 0.1, 0.3, 0.1, 30, Vector3(1, 0.5, 2));
	}

	void game_prerender()
	{
		if (!(magichand.on == 1)) return;
		handmagic_event(1);
	}

	void create_sprite_2()
	{
		magichand.attachment = param1;
		ClientEffect("frameent", "sprite", SPRITE_GLOW, Vector3(0, 0, 0), "setup_sprite_2");
	}

	void setup_sprite_2()
	{
		ClientEffect("frameent", "set_current_prop", "scale", 0.25);
		ClientEffect("frameent", "set_current_prop", "rendermode", "add");
		ClientEffect("frameent", "set_current_prop", "renderamt", 128);
		ClientEffect("frameent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("frameent", "set_current_prop", "follow", handmagic.handid);
		ClientEffect("frameent", "set_current_prop", "body", magichand.attachment);
	}

}

}
