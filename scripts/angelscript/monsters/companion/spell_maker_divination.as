#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerDivination : CGameScript
{
	string ANIM_IDLE;
	string CYCLE_ANGLE;
	float DEATH_DELAY;
	string FX_SCRIPT;
	float LIGHT_DROPPED_SCALE;
	float LIGHT_PLAYER_SCALE;
	int MODEL_OFSET;
	int NO_FADE;
	int OFSZ_NEG;
	int OFSZ_POS;
	int OFS_NEG;
	int OFS_POS;
	float REMOVE_DELAY;
	int SHOW_FX;
	string SOUND_SPAWN;
	string SPAWNER_MODEL;
	string SPRITE_1;
	int TOTAL_OFS;
	string sfx.npcid;

	SpellMakerDivination()
	{
		FX_SCRIPT = "monsters/companion/spell_maker_divination";
		ANIM_IDLE = "";
		SPAWNER_MODEL = "none";
		MODEL_OFSET = 0;
		SOUND_SPAWN = "magic/heal_powerup.wav";
		REMOVE_DELAY = 10.0;
		SHOW_FX = 1;
		NO_FADE = 1;
		DEATH_DELAY = 9.0;
		OFS_POS = 16;
		OFS_NEG = -16;
		OFSZ_POS = 32;
		OFSZ_NEG = -10;
		LIGHT_PLAYER_SCALE = 0.3;
		LIGHT_DROPPED_SCALE = 0.5;
		SPRITE_1 = "blueflare1.spr";
	}

	void client_activate()
	{
		sfx.npcid = param2;
		DEATH_DELAY("remove_me");
		ScheduleDelayedEvent(0.1, "spriteify");
	}

	void spriteify()
	{
		TOTAL_OFS = 64;
		for (int i = 0; i < 18; i++)
		{
			createsprite();
		}
	}

	void createsprite()
	{
		string l.pos = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
		if (CYCLE_ANGLE == "CYCLE_ANGLE")
		{
			CYCLE_ANGLE = 0;
		}
		CYCLE_ANGLE += 20;
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, TOTAL_OFS, -36));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", l.pos, "setup_sprite1_sparkle");
		string l.pos = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, TOTAL_OFS, -72));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", l.pos, "setup_sprite1_sparkle");
		string l.pos = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, TOTAL_OFS, -104));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", l.pos, "setup_sprite1_sparkle");
	}

	void setup_sprite1_sparkle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 7.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.01);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
