#pragma context server

namespace MS
{

class MagicHandBaseCl : CGameScript
{
	string FX_DURATION;
	int FX_FIRSTPERSON;
	string FX_OWNER;

	MagicHandBaseCl()
	{
		const int GLOW_DURATION = 1;
		const int OFS_POS = 5;
		const int OFS_NEG = -5;
		const int LIGHT_RADIUS = 128;
		const Vector3 LIGHT_COLOR = Vector3(255, 255, 128);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.10, 0.25));
		FX_FIRSTPERSON = 0;
		if (FX_OWNER == "game.localplayer.index")
		{
			if (!("game.localplayer.thirdperson"))
			{
			}
			FX_FIRSTPERSON = 1;
		}
		if (!(FX_FIRSTPERSON))
		{
			make_sprite_1(/* TODO: $getcl */ $getcl(FX_OWNER, "bonepos", 21));
			make_sprite_1(/* TODO: $getcl */ $getcl(FX_OWNER, "bonepos", 38));
		}
		else
		{
			string handid = "game.localplayer.viewmodel.active.id";
			make_sprite_1(/* TODO: $getcl */ $getcl(handid, "bonepos", 13));
			make_sprite_1(/* TODO: $getcl */ $getcl(handid, "bonepos", 32));
		}
	}

	void game_precache()
	{
		Precache("3dmflaora.spr");
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = /* TODO: $math(add) */ param2;
		SetCallback("render", "enable");
		FX_DURATION("effect_die");
		create_light(/* TODO: $getcl */ $getcl(FX_OWNER, "origin"));
	}

	void make_sprite_1()
	{
		string SPRITE_1 = "3dmflaora.spr";
		string L_POS = param1;
		L_POS += Vector3(0, Random(OFS_NEG, OFS_POS), Random(OFS_NEG, OFS_POS));
		ClientEffect("tempent", "sprite", SPRITE_1, L_POS, "setup_sprite_1");
	}

	void setup_sprite_1()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", GLOW_DURATION);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.2, 0.1));
		ClientEffect("tempent", "set_current_prop", "collide", "world");
	}

	void create_light()
	{
		ClientEffect("light", "new", param1, LIGHT_RADIUS, LIGHT_COLOR, FX_DURATION);
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
