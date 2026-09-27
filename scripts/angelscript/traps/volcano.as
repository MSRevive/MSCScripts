#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Volcano : CGameScript
{
	string ANIM_DEATH;
	int DMG_HIGH;
	int DMG_LOW;
	int ERUPTING;
	string LIGHT_COLOR;
	float LIGHT_DURATION;
	int LIGHT_RADIUS;
	int LOOP_DELAY;
	string MODEL_WORLD;
	int ROCK_START_HEIGHT;
	string SOUND_LOOP;
	string SOUND_START;
	string SPRITE_BURN;
	int TIME_LIVE;
	string VOLCANO_ID;
	string local.cl.gravity;
	string local.cl.origin;
	string local.cl.velocity;
	int xangle;
	int yangle;

	Volcano()
	{
		DMG_HIGH = 100;
		DMG_LOW = 50;
		ANIM_DEATH = "down";
		TIME_LIVE = 30;
		SOUND_START = "magic/volcano_start.wav";
		SOUND_LOOP = "magic/volcano_loop.wav";
		MODEL_WORLD = "misc/volcano.mdl";
		LOOP_DELAY = 0;
		Precache("misc/volcano.mdl");
		Precache(SOUND_START);
		Precache(SOUND_LOOP);
		ROCK_START_HEIGHT = 66;
		// TODO: UNCONVERTED: [client] repeatdelay 7
		EmitSound(GetOwner(), CHAN_BODY, SOUND_LOOP, 7);
		MODEL_WORLD = "weapons/projectiles.mdl";
		SPRITE_BURN = "fire1.spr";
		LIGHT_RADIUS = 64;
		LIGHT_COLOR = Vector3(255, 0, 0);
		LIGHT_DURATION = 0.8;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.0, 0.5));
		if ((ERUPTING))
		{
		}
		volcano_shoot();
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(Random(0.0, 0.5));
		if ((ERUPTING))
		{
		}
		volcano_shoot();
	}

	void OnSpawn() override
	{
		SetHealth(1500);
		SetRace("hated");
		SetInvincible(true);
		SetSolid("none");
		SetWidth(32);
		SetHeight(64);
		SetName("A Volcano");
		SetRoam(false);
		SetDamageResistance("cold", 2.0);
		SetDamageResistance("fire", 0.0);
		SetSkillLevel(0);
		SetHearingSensitivity(0);
		SetModel(MODEL_WORLD);
		SetBloodType("none");
		SetStat("spellcasting", 40);
		PlayAnim("hold", "up");
		ScheduleDelayedEvent(2, "volcano_start");
		TIME_LIVE("volcano_death");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 50, 10, 6, 512);
		// svplaysound: emitsound ent_me $get(ent_me,origin) 512 TIME_LIVE danger 512
		EmitSound(GetOwner(), GetEntityOrigin(GetOwner()), 512, TIME_LIVE, "danger", 512);
		EmitSound(GetOwner(), 0, SOUND_START, 7);
		ClientEvent("persist", "all", currentscript, GetEntityOrigin(GetOwner()), TIME_LIVE);
		VOLCANO_ID = "game.script.last_sent_id";
	}

	void volcano_start()
	{
		ERUPTING = 1;
	}

	void volcano_shoot()
	{
		xangle = RandomInt(50, 90);
		yangle = RandomInt(-180, 180);
		SetAngles("view");
		float ATTACK_DAMAGE = Random(DMG_LOW, DMG_HIGH);
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 128, ATTACK_DAMAGE, 1.0, 0);
		TossProjectile("proj_volcano", /* TODO: $relpos */ $relpos(0, 0, ROCK_START_HEIGHT), "none", 500, ATTACK_DAMAGE, 0, "none");
		ClientEvent("update", "all_in_sight", VOLCANO_ID, "volcono_shoot_rock", GetEntityVelocity("ent_lastprojectile"), GetEntityProperty("ent_lastprojectile", "gravity"));
	}

	void volcano_death()
	{
		ERUPTING = 0;
		ScheduleDelayedEvent(3, "volcano_fadeout");
	}

	void volcano_fadeout()
	{
		EmitSound(GetOwner(), CHAN_BODY, SOUND_LOOP, "game.sound.silentvol");
		SetInvincible(false);
		DoDamage(GetOwner(), "direct", 6000, 100, GetOwner());
	}

	void client_activate()
	{
		local.cl.origin = param1;
		local.cl.origin += "z";
		string DIE_TIME = param2;
		DIE_TIME += 10;
		DIE_TIME("volcano_die");
	}

	void volcano_die()
	{
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
		ClientEffect("tempent", "set_current_prop", "velocity", local.cl.velocity);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "gravity", local.cl.gravity);
		ClientEffect("tempent", "set_current_prop", "collide", "all");
		ClientEffect("tempent", "set_current_prop", "renderfx", "glow");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("light", "new", "game.tempent.origin", LIGHT_RADIUS, LIGHT_COLOR, LIGHT_DURATION);
		ClientEffect("tempent", "set_current_prop", "iuser1", "game.script.last_light_id");
	}

	void volcano_rock_update()
	{
		ClientEffect("light", "game.tempent.iuser1", "game.tempent.origin", LIGHT_RADIUS, LIGHT_COLOR, LIGHT_DURATION);
	}

	void volcano_rock_collide()
	{
		ClientEffect("tempent", "set_current_prop", "sprite", SPRITE_BURN);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "death_delay", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "all");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
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
