#pragma context server

namespace MS
{

class FlameSkull : CGameScript
{
	string ACTIVE_SKILL;
	string DMG_BASE;
	int FLY_COUNT;
	float FREQ_SOUND;
	string GAME_PVP;
	int IS_FLYING;
	string LAST_BURNED;
	string MY_OWNER;
	string MY_RADIUS;
	string MY_SCRIPT_ID;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	int ROT_COUNT;
	string SKEL_LIGHT_ID;
	string SKULL_IDX;
	int SOUND_DELAY;
	string SOUND_FIRE;
	string SOUND_LOOP;
	string SOUND_SCREAM;
	string SOUND_START;
	string START_POS;

	FlameSkull()
	{
		SetCallback("touch", "enable");
		SOUND_SCREAM = "magic/spookie1.wav";
		SOUND_FIRE = "magic/fireball_strike.wav";
		SOUND_START = "magic/volcano_start.wav";
		SOUND_LOOP = "magic/volcano_loop.wav";
		FREQ_SOUND = 3.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(4.4);
		if ((IS_FLYING))
		{
		}
		EmitSound(GetOwner(), 1, SOUND_SCREAM, 10);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		DMG_BASE = param2;
		MY_RADIUS = param3;
		ACTIVE_SKILL = param4;
		if (ACTIVE_SKILL == "PARAM4")
		{
			ACTIVE_SKILL = "spellcasting.fire";
		}
		GAME_PVP = "game.pvp";
		START_POS = GetEntityOrigin(MY_OWNER);
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		if (!(OWNER_ISPLAYER))
		{
			string OWNER_HEIGHT = GetEntityHeight(MY_OWNER);
			OWNER_HEIGHT /= 2;
			START_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, OWNER_HEIGHT));
		}
		StoreEntity("ent_expowner");
		FLY_COUNT = 0;
		ROT_COUNT = 0;
		IS_FLYING = 1;
		ClientEvent("new", "all", currentscript, GetEntityIndex(GetOwner()));
		MY_SCRIPT_ID = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.1, "skull_fly");
	}

	void OnSpawn() override
	{
		SetName("Flaming Skull");
		SetHealth(1);
		SetRace("beloved");
		PLAYING_DEAD = 1;
		SetInvincible(true);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 12);
		SetSolid("trigger");
		SetWidth(32);
		SetHeight(32);
		SetGravity(0);
		SetFly(true);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		// svplaysound: svplaysound 2 10 SOUND_LOOP
		EmitSound(2, 10, SOUND_LOOP);
		LogDebug("Spawned Flaming Skull");
	}

	void skull_fly()
	{
		if (!(IS_FLYING)) return;
		ScheduleDelayedEvent(0.1, "skull_fly");
		FLY_COUNT += 1;
		ROT_COUNT += 10;
		if (FLY_COUNT >= MY_RADIUS)
		{
			end_flight();
		}
		if (ROT_COUNT > 359)
		{
			ROT_COUNT -= 359;
		}
		string NEW_POS = START_POS;
		NEW_POS += /* TODO: $relpos */ $relpos(Vector3(0, ROT_COUNT, 0), /* TODO: $vece */ $vece(0, FLY_COUNT, 0));
		SetEntityOrigin(GetOwner(), NEW_POS);
		SetAngles("face");
		if ((SOUND_DELAY)) return;
		SOUND_DELAY = 1;
		FREQ_SOUND("sound_delay_reset");
		EmitSound(GetOwner(), 0, SOUND_START, 10);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 200, 200, 2, 128);
	}

	void end_flight()
	{
		IS_FLYING = 0;
		SetProp(GetOwner(), "renderamt", 0);
		// svplaysound: svplaysound 2 0 SOUND_LOOP
		EmitSound(2, 0, SOUND_LOOP);
		ClientEvent("remove", "all", MY_SCRIPT_ID);
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void sound_delay_reset()
	{
		SOUND_DELAY = 1;
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		if (!(param1 != LAST_BURNED)) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		ApplyEffect(param1, "effects/dot_fire", 5.0, MY_OWNER, DMG_BASE, ACTIVE_SKILL);
		LAST_BURNED = param1;
	}

	void client_activate()
	{
		SKULL_IDX = param1;
		SetCallback("render", "enable");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKULL_IDX, "origin"), 128, Vector3(255, 72, 0), 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		spit_fire();
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKULL_IDX, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, 128, Vector3(255, 72, 0), 1.0);
	}

	void spit_fire()
	{
		SetRepeatDelay(0.25);
		int RAND_ANG = RandomInt(0, 359);
		string SKULL_POS = /* TODO: $getcl */ $getcl(SKULL_IDX, "origin");
		SKULL_POS += /* TODO: $relpos */ $relpos(Vector3(0, RAND_ANG, 0), Vector3(0, 30, 0));
		ClientEffect("tempent", "sprite", "rjet1.spr", SKULL_POS, "spit_fire_sprites");
		string SKULL_POS = /* TODO: $getcl */ $getcl(SKULL_IDX, "origin");
		SKULL_POS += /* TODO: $relpos */ $relpos(Vector3(0, RAND_ANG, 0), Vector3(0, 30, 0));
		ClientEffect("tempent", "sprite", "rjet1.spr", SKULL_POS, "spit_fire_sprites");
		string SKULL_POS = /* TODO: $getcl */ $getcl(SKULL_IDX, "origin");
		SKULL_POS += /* TODO: $relpos */ $relpos(Vector3(0, RAND_ANG, 0), Vector3(0, 30, 0));
		ClientEffect("tempent", "sprite", "rjet1.spr", SKULL_POS, "spit_fire_sprites");
	}

	void spit_fire_sprite()
	{
		Vector3 RAND_VEC = Vector3(0, 0, Random(0, 5));
		ClientEffect("tempent", "set_current_prop", "death_delay", 1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 60);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "velocity", RAND_VEC);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "frames", 4);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
	}

}

}
