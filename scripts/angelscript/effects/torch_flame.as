#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class TorchFlame : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string LIGHT_COLOR;
	int LIGHT_RADIUS;
	int OFSZ_NEG;
	string OFSZ_POS;
	int OFS_NEG;
	int OFS_POS;
	string SPRITE_1;
	string effect.clientscript;
	string sfx.npcid;

	TorchFlame()
	{
		OFS_POS = 16;
		OFS_NEG = -16;
		OFSZ_NEG = 0;
		LIGHT_COLOR = Vector3(255, 255, 128);
		LIGHT_RADIUS = 128;
		SPRITE_1 = "fire1_fixed.spr";
		Precache(SPRITE_1);
		EFFECT_ID = "effect_flames";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
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
