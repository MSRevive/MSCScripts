#pragma context server

#include "monsters/summon/base_aoe.as"

namespace MS
{

class CircleOfIceLesser : CGameScript
{
	string ACTIVE_SKILL;
	float AOE_FREQ;
	int AOE_RADIUS;
	string APPLY_EFFECT;
	int CIRCLE_ON;
	int CIRCLE_RADIUS;
	string CIRCLE_UP;
	string DID_WINDUP;
	string FROST_DURATION;
	string FX_SPRITE;
	float LIGHT_DROPPED_SCALE;
	float LIGHT_PLAYER_SCALE;
	string MY_BASE_DAMAGE;
	string MY_DURATION;
	string MY_OWNER;
	string MY_OWNER_RACE;
	int OFSZ_NEG;
	int OFSZ_POS;
	int OFS_NEG;
	int OFS_POS;
	string OWNER_ISPLAYER;
	float PULSE_PLAYTIME;
	int RAIN_SPRITES;
	int ROT_COUNT;
	int SEAL_DROP_COUNTER;
	string SEAL_MODEL;
	int SEAL_OFS;
	string SOUND_FADE;
	string SOUND_MANIFEST;
	string SOUND_PULSE;
	string THIS_SCRIPT_CLIENT_ID;
	string sfx.duration;
	string sfx.npcid;
	string sfx.radius;

	CircleOfIceLesser()
	{
		SEAL_MODEL = "weapons/magic/seals.mdl";
		SEAL_OFS = 7;
		SOUND_MANIFEST = "magic/spawn.wav";
		SOUND_PULSE = "magic/frost_forward.wav";
		SOUND_FADE = "magic/frost_reverse.wav";
		PULSE_PLAYTIME = 1.0;
		FX_SPRITE = "teleporter_blue_sprites.mdl";
		CIRCLE_RADIUS = 110;
		APPLY_EFFECT = "effects/dot_cold";
		Precache(FX_SPRITE);
		AOE_FREQ = 1.0;
		AOE_RADIUS = 110;
		OFS_POS = 128;
		OFS_NEG = -128;
		OFSZ_POS = 256;
		OFSZ_NEG = -10;
		LIGHT_PLAYER_SCALE = 0.3;
		LIGHT_DROPPED_SCALE = 0.5;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DURATION = param2;
		FROST_DURATION = param3;
		MY_BASE_DAMAGE = param4;
		ACTIVE_SKILL = param5;
		if (ACTIVE_SKILL == "PARAM5")
		{
			ACTIVE_SKILL = "spellcasting.ice";
		}
		MY_OWNER_RACE = GetEntityRace(param1);
		OWNER_ISPLAYER = IsValidPlayer(param1);
		MY_DURATION("circle_end");
	}

	void OnSpawn() override
	{
		SetName("Lesser Circle of Ice");
		SetHealth(10000);
		SetFOV(359);
		SetInvincible(true);
		SetRace("beloved");
		SetHeight(2);
		SetWidth(2);
		SetFly(true);
		1 = float(1);
		SetDamageResistance("all", 0.0);
		SetGravity(0.0);
		SetBloodType("none");
		SetModel("none");
		SetSolid("none");
		CIRCLE_ON = 1;
		ScheduleDelayedEvent(0.1, "make_seal");
		ScheduleDelayedEvent(0.2, "circle_hum");
	}

	void make_seal()
	{
		string SEAL_POS = GetEntityOrigin(GetOwner());
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(SEAL_POS);
		SEAL_POS = "z";
		LogDebug("make_seal SEAL_POS");
		SpawnNPC("monsters/summon/seal_maker", SEAL_POS, ScriptMode::Legacy); // params: SEAL_MODEL, MY_DURATION, SEAL_OFS
	}

	void circle_hum()
	{
		if (!(CIRCLE_UP))
		{
			string CLIENT_DURATION = MY_DURATION;
			CLIENT_DURATION -= 0.2;
			if (!(NO_RAIN_FX))
			{
				ClientEvent("new", "all_in_sight", currentscript, CLIENT_DURATION, GetEntityIndex(GetOwner()), CIRCLE_RADIUS);
			}
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

	void apply_aoe_effect()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		ApplyEffect(param1, "effects/dot_cold", FROST_DURATION, MY_OWNER, MY_BASE_DAMAGE, ACTIVE_SKILL);
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
		if (ROT_COUNT >= 360)
		{
			ROT_COUNT = 0;
		}
		string SPRITE_RAD = CIRCLE_RADIUS;
		SPRITE_RAD *= 0.65;
		string A_POS = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
		string l.pos = A_POS;
		ROT_COUNT += 20;
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, ROT_COUNT, 0), Vector3(0, SPRITE_RAD, 128));
		ClientEffect("tempent", "sprite", FX_SPRITE, l.pos, "setup_flame");
		string l.pos = A_POS;
		ROT_COUNT += 20;
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, ROT_COUNT, 0), Vector3(0, SPRITE_RAD, 128));
		ClientEffect("tempent", "sprite", FX_SPRITE, l.pos, "setup_flame");
	}

	void setup_flame()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
	}

	void effect_die()
	{
		RAIN_SPRITES = 0;
		RemoveScript();
	}

}

}
