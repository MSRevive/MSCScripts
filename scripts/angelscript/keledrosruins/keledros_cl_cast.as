#pragma context client

namespace MS
{

class KeledrosClCast : CGameScript
{
	string script.boneidx;
	string script.duration;
	string script.modelid;

	KeledrosClCast()
	{
		const string SPRITE_1 = "3dmflaora.spr";
		Precache(SPRITE_1);
		const float OFS_POS = 0.2;
		const float OFS_NEG = -0.2;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(RandomInt(0.15, 0.25));
		string l.pos = /* TODO: $getcl */ $getcl(script.modelid, "bonepos", script.boneidx);
		l.pos += Vector3(RandomInt(OFS_NEG, OFS_POS), RandomInt(OFS_NEG, OFS_POS), RandomInt(OFS_NEG, OFS_POS));
		ClientEffect("tempent", "sprite", SPRITE_1, l.pos, "setup_flames");
	}

	void client_activate()
	{
		script.modelid = param1;
		script.boneidx = param2;
		script.duration = param3;
		if (!(/* TODO: $getcl */ $getcl("local.modelid", "exists")))
		{
			effect_die();
		}
		script_duration("effect_die");
	}

	void setup_flames()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.3);
		ClientEffect("tempent", "set_current_prop", "scale", 0.05);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.1, 0.15));
		ClientEffect("tempent", "set_current_prop", "collide", "world");
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
