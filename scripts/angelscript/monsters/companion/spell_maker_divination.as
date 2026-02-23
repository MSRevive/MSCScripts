#pragma context server

#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerDivination : CGameScript
{
	string ANIM_IDLE;
	string CYCLE_ANGLE;
	int TOTAL_OFS;
	string sfx.npcid;

	SpellMakerDivination()
	{
		const string FX_SCRIPT = "monsters/companion/spell_maker_divination";
		ANIM_IDLE = "";
		const string SPAWNER_MODEL = "none";
		const int MODEL_OFSET = 0;
		const string SOUND_SPAWN = "magic/heal_powerup.wav";
		const float REMOVE_DELAY = 10.0;
		const int SHOW_FX = 1;
		const int NO_FADE = 1;
		const float DEATH_DELAY = 9.0;
		const int OFS_POS = 16;
		const int OFS_NEG = -16;
		const int OFSZ_POS = 32;
		const int OFSZ_NEG = -10;
		const float LIGHT_PLAYER_SCALE = 0.3;
		const float LIGHT_DROPPED_SCALE = 0.5;
		const string SPRITE_1 = "blueflare1.spr";
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
