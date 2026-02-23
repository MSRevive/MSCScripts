#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class TorchFlame : CGameScript
{
	string OFSZ_POS;
	string effect.clientscript;
	string sfx.npcid;

	TorchFlame()
	{
		const int OFS_POS = 16;
		const int OFS_NEG = -16;
		const int OFSZ_NEG = 0;
		const Vector3 LIGHT_COLOR = Vector3(255, 255, 128);
		const int LIGHT_RADIUS = 128;
		const string SPRITE_1 = "fire1_fixed.spr";
		Precache(SPRITE_1);
		const string EFFECT_ID = "effect_flames";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.25);
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(sfx.npcid, "origin"), LIGHT_RADIUS, LIGHT_COLOR, 0.35);
		createsprite();
	}

	void game_activate()
	{
		ClientEvent("new", "all", currentscript, EFFECT_DURATION, GetEntityIndex(GetOwner()), GetEntityHeight(GetOwner()));
		effect.clientscript = "game.script.last_sent_id";
	}

	void client_activate()
	{
		PARAM1("effect_die");
		sfx.npcid = param2;
		OFSZ_POS = param3;
	}

	void createsprite()
	{
		string l.pos = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
		ClientEffect("tempent", "sprite", SPRITE_1, l.pos, "setup_sprite1_flame");
	}

	void setup_sprite1_flame()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.25);
		ClientEffect("tempent", "set_current_prop", "framerate", 25);
		ClientEffect("tempent", "set_current_prop", "velocity", 0);
		ClientEffect("tempent", "set_current_prop", "frames", 20);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
