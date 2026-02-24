#pragma context server

#include "monsters/summon/base_aoe.as"

namespace MS
{

class VolcanoTroll : CGameScript
{
	string ANIM_DEATH;
	int AOE_FREQ;
	int AOE_RADIUS;
	string CAST_BY_PLAYER;
	string CLIENT_DURATION;
	int EFFECT_DURATION;
	int ERUPTING;
	int FX_ACTIVE;
	string FX_ORIGIN;
	string LIGHT_COLOR;
	float LIGHT_DURATION;
	int LIGHT_RADIUS;
	int LOOP_DELAY;
	string MODEL_WORLD;
	string MY_OWNER;
	int PLAYING_DEAD;
	int ROCK_START_HEIGHT;
	string SOUND_LOOP;
	string SOUND_START;
	string SPRITE_BURN;
	string local.cl.gravity;
	string local.cl.origin;
	string local.cl.velocity;

	VolcanoTroll()
	{
		ANIM_DEATH = "down";
		SOUND_START = "magic/volcano_start.wav";
		SOUND_LOOP = "magic/volcano_loop.wav";
		MODEL_WORLD = "misc/volcano.mdl";
		LOOP_DELAY = 0;
		Precache("misc/volcano.mdl");
		Precache(SOUND_START);
		Precache(SOUND_LOOP);
		AOE_FREQ = 2;
		AOE_RADIUS = 32;
		ROCK_START_HEIGHT = 66;
		// TODO: UNCONVERTED: [client] repeatdelay 6
		EmitSound(GetOwner(), CHAN_BODY, SOUND_LOOP, 7);
		MODEL_WORLD = "weapons/projectiles.mdl";
		SPRITE_BURN = "fire1_fixed.spr";
		LIGHT_RADIUS = 64;
		LIGHT_COLOR = Vector3(255, 0, 0);
		LIGHT_DURATION = 0.8;
	}

	void OnSpawn() override
	{
		SetHealth(1500);
		SetInvincible(true);
		SetSolid("none");
		SetWidth(32);
		SetHeight(64);
		SetName("Trollcano!");
		SetRoam(false);
		SetSkillLevel(0);
		SetHearingSensitivity(0);
		SetModel(MODEL_WORLD);
		SetBloodType("none");
		PlayAnim("hold", "up");
		PLAYING_DEAD = 1;
		ScheduleDelayedEvent(2, "volcano_start");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 50, 10, 6, 512);
		EmitSound(GetOwner(), 0, SOUND_START, 7);
	}

	void game_dynamically_created()
	{
		CAST_BY_PLAYER = IsValidPlayer(param1);
		MY_OWNER = param1;
		EFFECT_DURATION = 25;
		CLIENT_DURATION = EFFECT_DURATION;
		CLIENT_DURATION -= 1;
		EFFECT_DURATION("volcano_death");
		ClientEvent("persist", "all", currentscript, GetEntityOrigin(GetOwner()), CLIENT_DURATION, GetEntityIndex(MY_OWNER));
	}

	void volcano_start()
	{
		ERUPTING = 1;
	}

	void volcano_death()
	{
		ERUPTING = 0;
		PlayAnim("hold", "down");
		ScheduleDelayedEvent(3, "volcano_fadeout");
	}

	void volcano_fadeout()
	{
		EmitSound(GetOwner(), CHAN_BODY, SOUND_LOOP, "game.sound.silentvol");
		DeleteEntity(GetOwner(), true); // fade out
	}

	void client_activate()
	{
		local.cl.origin = param1;
		local.cl.origin += "z";
		string DIE_TIME = param2;
		DIE_TIME("volcano_done");
		DIE_TIME += 10;
		DIE_TIME("volcano_die");
		FX_ACTIVE = 1;
		FX_ORIGIN = local.cl.origin;
		volcano_shoot_loop();
	}

	void volcano_shoot_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "volcano_shoot_loop");
		float xangle = Random(-50, -90);
		float yangle = Random(-180, 180);
		Vector3 ROCK_ANGS = Vector3(xangle, yangle, 0);
		string ROCK_VEL = /* TODO: $relvel */ $relvel(ROCK_ANGS, Vector3(0, 500, 0));
		volcono_shoot_rock(ROCK_VEL, Random(0.5, 0.8));
	}

	void volcano_done()
	{
		FX_ACTIVE = 0;
	}

	void volcano_die()
	{
		FX_ACTIVE = 0;
		EmitSound(GetOwner(), CHAN_BODY, SOUND_LOOP, "game.sound.silentvol");
		RemoveScript();
	}

	void volcono_shoot_rock()
	{
		local.cl.velocity = param1;
		local.cl.gravity = param2;
		ClientEffect("tempent", "model", MODEL_WORLD, local.cl.origin, "volcano_rock_create", "volcano_rock_update", "volcano_rock_collide");
		for (int i = 0; i < 4; i++)
		{
			makefire_loop(local.cl.origin);
		}
	}

	void volcano_rock_create()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10);
		ClientEffect("tempent", "set_current_prop", "body", 69);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "velocity", local.cl.velocity);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.4);
		ClientEffect("tempent", "set_current_prop", "gravity", local.cl.gravity);
		ClientEffect("tempent", "set_current_prop", "collide", "all");
		Vector3 L_ANG = Vector3(Random(0, 359), Random(0, 359), 180);
		ClientEffect("tempent", "set_current_prop", "angles", L_ANG);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.6);
		ClientEffect("tempent", "set_current_prop", "frames", 16);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
	}

	void volcano_rock_collide()
	{
		ClientEffect("tempent", "set_current_prop", "framerate", 0);
	}

	void makefire_loop()
	{
		ClientEffect("tempent", "sprite", SPRITE_BURN, param1, "volcano_fire_create");
	}

	void volcano_fire_create()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-200, 200), Random(-200, 200), Random(-200, 200)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.6, 1.0));
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
	}

}

}
