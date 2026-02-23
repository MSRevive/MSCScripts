#pragma context client

namespace MS
{

class BoarBaseClCharge : CGameScript
{
	int IS_ACTIVE;
	string l.charging;
	int script.boneidx1;
	int script.boneidx2;
	string script.modelid;

	BoarBaseClCharge()
	{
		const string SPRITE_1 = "bigsmoke.spr";
		const int OFS_POS = 8;
		const int OFS_NEG = -8;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.15, 0.3));
		if ((IS_ACTIVE))
		{
		}
		if (script.modelid > 0)
		{
		}
		int l.charging = 0;
		if (/* TODO: $getcl */ $getcl(script.modelid, "anim") == 3)
		{
			l.charging = 1;
		}
		if (/* TODO: $getcl */ $getcl(script.modelid, "anim") == 5)
		{
			l.charging = 1;
		}
		if ((l.charging))
		{
		}
		string l.pos = /* TODO: $getcl */ $getcl(script.modelid, "bonepos", script.boneidx1);
		do_effect(l.pos);
		string l.pos = /* TODO: $getcl */ $getcl(script.modelid, "bonepos", script.boneidx2);
		do_effect(l.pos);
	}

	void client_activate()
	{
		script.modelid = param1;
		script.boneidx1 = 4;
		script.boneidx2 = 5;
		ScheduleDelayedEvent(30, "effect_die");
	}

	void do_effect()
	{
		if (!(IS_ACTIVE)) return;
		string l.pos = param1;
		l.pos += Vector3(RandomInt(OFS_NEG, OFS_POS), RandomInt(OFS_NEG, OFS_POS), 0);
		ClientEffect("tempent", "sprite", SPRITE_1, l.pos, "setup_sprite1");
	}

	void setup_sprite1()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", Random(0.5, 1.2));
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 80);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(-0.02, -0.01));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

	void effect_die()
	{
		RemoveScript();
	}

	void remove_fx()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(1.5, "effect_die");
	}

}

}
