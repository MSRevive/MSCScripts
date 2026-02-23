#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class CircleOfIceGreater : CGameScript
{
	int CIRCLE_ON;
	string CIRCLE_UP;
	string DID_WINDUP;
	string FREEZE_DURATION;
	string MAIN_SEAL;
	string MY_DURATION;
	string MY_OWNER;
	string MY_OWNER_RACE;
	int RAIN_SPRITES;
	int ROT_COUNT;
	string SEAL_DOWN;
	int SEAL_DROP_COUNTER;
	string THIS_SCRIPT_CLIENT_ID;
	string sfx.duration;
	string sfx.npcid;
	string sfx.radius;

	CircleOfIceGreater()
	{
		const string SEAL_MODEL = "weapons/magic/seals.mdl";
		const int SEAL_OFS = 8;
		const string SOUND_MANIFEST = "magic/spawn_loud.wav";
		const string SOUND_PULSE = "magic/frost_forward.wav";
		const string SOUND_FADE = "magic/frost_reverse.wav";
		const float PULSE_PLAYTIME = 1.0;
		const string FX_SPRITE = "firemagic.spr";
		const int CIRCLE_RADIUS = 172;
		const string APPLY_EFFECT = "effects/dot_cold_freeze";
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
		FREEZE_DURATION = param3;
		MY_OWNER_RACE = GetEntityRace(param1);
		MY_DURATION("circle_end");
	}

	void OnSpawn() override
	{
		SetName("Greater Circle of Ice");
		SetHealth(1);
		SetFOV(359);
		SetInvincible(true);
		SetRace("beloved");
		SetHeight(2);
		SetWidth(2);
		SetFly(true);
		1 = float(1);
		SetGravity(0.0);
		SetBloodType("none");
		SetModel("none");
		SetSolid("none");
		CIRCLE_ON = 1;
		ScheduleDelayedEvent(0.1, "make_seal");
		ScheduleDelayedEvent(1.0, "circle_go");
		ScheduleDelayedEvent(0.1, "circle_hum");
	}

	void make_seal()
	{
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
		ScheduleDelayedEvent(0.25, "circle_go");
		if (GetEntityIndex(m_hLastSeen) == MY_OWNER)
		{
			LookAt(1024);
		}
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), CIRCLE_RADIUS, 0, 1.0, 0);
		if (!(false)) return;
		if (!(GetEntityRange(m_hLastSeen) <= CIRCLE_RADIUS)) return;
		if (!(GetRelationship(m_hLastSeen) == "enemy")) return;
		string DMG_SOURCE = MY_OWNER;
		if ((GetEntityProperty(m_hLastSeen, "haseffect"))) return;
		ApplyEffect(m_hLastSeen, APPLY_EFFECT, FREEZE_DURATION, DMG_SOURCE);
	}

	void game_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		string DMG_SOURCE = MY_OWNER;
		ApplyEffect(m_hLastSeen, APPLY_EFFECT, FREEZE_DURATION, DMG_SOURCE);
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
		ScheduleDelayedEvent(0.1, "rain_go");
	}

	void createsprite()
	{
		string l.pos = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
		if (!(MAIN_SEAL))
		{
			string g.pos = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
			ClientEffect("tempent", "model", SEAL_MODEL, g.pos, "setup_floatup_model");
			MAIN_SEAL = 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SEAL_DOWN))
		{
			string g.pos = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
			ClientEffect("tempent", "model", SEAL_MODEL, g.pos, "setup_floatdown_model");
			SEAL_DOWN = 1;
		}
		if (ROT_COUNT >= 360)
		{
			ROT_COUNT = 0;
		}
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, ROT_COUNT, 0), Vector3(0, CIRCLE_RADIUS, 256));
		ROT_COUNT += 40;
		ClientEffect("tempent", "sprite", FX_SPRITE, l.pos, "setup_flame");
	}

	void setup_flame()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
	}

	void setup_floatup_model()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", sfx.duration);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.01);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, -0.1));
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
	}

	void setup_floatdown_model()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", sfx.duration);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.01);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0.1));
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
	}

	void effect_die()
	{
		RAIN_SPRITES = 0;
		RemoveScript();
	}

}

}
