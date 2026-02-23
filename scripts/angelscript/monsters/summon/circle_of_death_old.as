#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class CircleOfDeathOld : CGameScript
{
	int CIRCLE_ON;
	string CIRCLE_TARGETS;
	string CIRCLE_UP;
	string DID_WINDUP;
	string GAME_PVP;
	string LAST_LIGHT;
	string MY_BASE_DAMAGE;
	string MY_DURATION;
	string MY_OWNER;
	string MY_OWNER_RACE;
	string MY_SKILL;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	int RAIN_SPRITES;
	int ROT_COUNT;
	int SEAL_DROP_COUNTER;
	string THIS_SCRIPT_CLIENT_ID;
	string sfx.duration;
	string sfx.npcid;
	string sfx.radius;

	CircleOfDeathOld()
	{
		const string SEAL_MODEL = "weapons/magic/seals.mdl";
		const int SEAL_OFS = 4;
		const string SOUND_MANIFEST = "magic/temple.wav";
		const string SOUND_PULSE = "magic/pulsemachine_noloop.wav";
		const string SOUND_FADE = "magic/frost_reverse.wav";
		const string FX_SPRITE = "skull.spr";
		const float PULSE_PLAYTIME = 1.7;
		const int CIRCLE_RADIUS = 180;
		const float LIGHT_DIE = 1.6;
		Precache(FX_SPRITE);
		const int OFS_POS = 128;
		const int OFS_NEG = -128;
		const int OFSZ_POS = 256;
		const int OFSZ_NEG = -10;
		const float LIGHT_PLAYER_SCALE = 0.3;
		const float LIGHT_DROPPED_SCALE = 0.5;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DURATION = param2;
		MY_BASE_DAMAGE = param3;
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		if (!(OWNER_ISPLAYER))
		{
			MY_SKILL = param4;
		}
		else
		{
			MY_SKILL = "none";
		}
		GAME_PVP = "game.pvp";
		MY_OWNER_RACE = GetEntityRace(param1);
		SetRace(MY_OWNER_RACE);
		MY_DURATION("circle_end");
	}

	void OnSpawn() override
	{
		SetName("Circle of Death");
		SetHealth(10000);
		SetFOV(359);
		SetInvincible(true);
		SetHeight(2);
		SetWidth(2);
		SetFly(true);
		1 = float(1);
		SetDamageResistance("all", 0.0);
		SetGravity(0.0);
		SetBloodType("none");
		SetModel("none");
		SetSolid("none");
		SetNoPush(true);
		PLAYING_DEAD = 1;
		CIRCLE_ON = 1;
		ScheduleDelayedEvent(0.1, "make_seal");
		ScheduleDelayedEvent(1.0, "circle_go");
		ScheduleDelayedEvent(0.1, "circle_hum");
	}

	void make_seal()
	{
		SetRace(MY_OWNER_RACE);
		string SEAL_POS = GetEntityOrigin(GetOwner());
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(SEAL_POS);
		string SEAL_Z = (SEAL_POS).z;
		string GROUND_DIST = GROUND_Z;
		GROUND_DIST -= SEAL_Z;
		// TODO: UNCONVERTED: subract GROUND_DIST 2
		SEAL_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, GROUND_DIST));
		SpawnNPC("monsters/summon/seal_maker", SEAL_POS, ScriptMode::Legacy); // params: SEAL_MODEL, MY_DURATION, SEAL_OFS
	}

	void circle_hum()
	{
		if (!(CIRCLE_UP))
		{
			string CLIENT_DURATION = MY_DURATION;
			CLIENT_DURATION -= 0.2;
			ClientEvent("new", "all_in_sight", currentscript, CLIENT_DURATION, GetEntityIndex(GetOwner()), CIRCLE_RADIUS);
			string MY_ORIGIN = GetEntityOrigin(GetOwner());
			ClientEffect("light", "new", MY_ORIGIN, CIRCLE_RADIUS, Vector3(128, 128, 255), MY_DURATION);
			THIS_SCRIPT_CLIENT_ID = "game.script.last_sent_id";
			CIRCLE_UP = 1;
		}
		if ((DID_WINDUP))
		{
			EmitSound(GetOwner(), 0, SOUND_PULSE, 10);
		}
		if (!(DID_WINDUP))
		{
			EmitSound(GetOwner(), 0, SOUND_MANIFEST, 10);
			DID_WINDUP = 1;
		}
		if (!(CIRCLE_ON)) return;
		PULSE_PLAYTIME("circle_hum");
	}

	void circle_go()
	{
		if (!(CIRCLE_ON)) return;
		ScheduleDelayedEvent(0.5, "circle_go");
		CIRCLE_TARGETS = FindEntitiesInSphere("enemy", CIRCLE_RADIUS);
		if (!(CIRCLE_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(CIRCLE_TARGETS, ";"); i++)
		{
			damage_targets();
		}
	}

	void damage_targets()
	{
		string CUR_TARG = GetToken(CIRCLE_TARGETS, i, ";");
		if ((OWNER_ISPLAYER))
		{
			if (!(GAME_PVP))
			{
			}
			if ((IsValidPlayer(CUR_TARG)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		XDoDamage(CUR_TARG, "direct", MY_BASE_DAMAGE, 1.0, MY_OWNER, MY_OWNER, MY_SKILL, "magic");
	}

	void circle_end()
	{
		ClientEvent("remove", "all", THIS_SCRIPT_CLIENT_ID);
		CIRCLE_ON = 0;
		ClientEvent("remove", "all", currentscript);
		EmitSound(GetOwner(), 0, SOUND_FADE, 10);
		ScheduleDelayedEvent(0.5, "circle_remove");
	}

	void circle_remove()
	{
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		sfx.duration = param1;
		sfx.npcid = param2;
		sfx.radius = param3;
		SetCallback("render", "enable");
		RAIN_SPRITES = 1;
		SEAL_DROP_COUNTER = 0;
		ROT_COUNT = 0;
		ScheduleDelayedEvent(0.1, "rain_go");
		PARAM1("effect_die");
	}

	void rain_go()
	{
		if (!(RAIN_SPRITES)) return;
		createsprite();
		ScheduleDelayedEvent(1.0, "rain_go");
	}

	void createsprite()
	{
		string g.pos = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
		string SEAL_POS = g.pos;
		SEAL_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, -64));
		ClientEffect("remove", LAST_LIGHT);
		ClientEffect("light", "new", g.pos, 196, Vector3(255, 0, 0), 0.9);
		LAST_LIGHT = "game.script.last_light_id";
		ClientEffect("tempent", "model", SEAL_MODEL, SEAL_POS, "setup_seal");
		ClientEffect("tempent", "model", FX_SPRITE, g.pos, "setup_flame");
	}

	void setup_seal()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", sfx.duration);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 3);
		ClientEffect("tempent", "set_current_prop", "frames", 15);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", -1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, -2));
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
	}

	void setup_flame()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", sfx.duration);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 15);
		ClientEffect("tempent", "set_current_prop", "frames", 15);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, -1));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
	}

	void effect_die()
	{
		ClientEffect("remove", LAST_LIGHT);
		RAIN_SPRITES = 0;
		RemoveScript();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetAlive(1);
	}

}

}
