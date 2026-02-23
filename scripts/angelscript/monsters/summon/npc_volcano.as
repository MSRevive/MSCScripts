#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class NpcVolcano : CGameScript
{
	string ANIM_DEATH;
	string DMG_HIGH;
	int ERUPTING;
	int I_DO_FIRE_DAMAGE;
	int LOOP_DELAY;
	string TIME_LIVE;
	string VOLCANO_ID;
	string local.cl.gravity;
	string local.cl.origin;
	string local.cl.velocity;
	string xangle;
	string yangle;

	NpcVolcano()
	{
		const string SOUND_START = "magic/volcano_start.wav";
		const string SOUND_LOOP = "magic/volcano_loop.wav";
		const string MODEL_WORLD = "misc/volcano.mdl";
		ANIM_DEATH = "down";
		I_DO_FIRE_DAMAGE = 1;
		Precache("misc/volcano.mdl");
		Precache(SOUND_START);
		Precache(SOUND_LOOP);
		const int ROCK_START_HEIGHT = 66;
		// TODO: UNCONVERTED: [client] repeatdelay 6
		EmitSound(GetOwner(), CHAN_BODY, SOUND_LOOP, 7);
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const string SPRITE_BURN = "fire1_fixed.spr";
		const int LIGHT_RADIUS = 64;
		const Vector3 LIGHT_COLOR = Vector3(255, 0, 0);
		const float LIGHT_DURATION = 0.8;
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
		SetInvincible(true);
		SetSolid("none");
		SetFOV(90);
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
		SetStat("spellcasting", 15);
		PlayAnim("hold", "up");
		ScheduleDelayedEvent(2, "volcano_start");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 50, 10, 6, 512);
		EmitSound(GetOwner(), 0, SOUND_START, 7);
	}

	void game_dynamically_created()
	{
		DMG_HIGH = param2;
		TIME_LIVE = param3;
		LOOP_DELAY = 0;
		TIME_LIVE("volcano_death");
		ClientEvent("persist", "all", currentscript, GetEntityOrigin(GetOwner()), TIME_LIVE);
		VOLCANO_ID = "game.script.last_sent_id";
		StoreEntity("ent_expowner");
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
		string ATTACK_DAMAGE = Random(DMG_LOW, DMG_HIGH);
		TossProjectile("proj_volcano", /* TODO: $relpos */ $relpos(0, 0, ROCK_START_HEIGHT), 500, ATTACK_DAMAGE, 0, "none");
		ClientEvent("update", "all_in_sight", VOLCANO_ID, "volcono_shoot_rock", GetEntityVelocity("ent_lastprojectile"), GetEntityProperty("ent_lastprojectile", "gravity"));
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
