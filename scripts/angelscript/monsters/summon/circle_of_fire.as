#pragma context server

namespace MS
{

class CircleOfFire : CGameScript
{
	string APPLY_EFFECT;
	int CIRCLE_ON;
	int CIRCLE_RADIUS;
	string CIRCLE_UP;
	string DID_WINDUP;
	string FX_SPRITE;
	string GAME_PVP;
	float LIGHT_DROPPED_SCALE;
	float LIGHT_PLAYER_SCALE;
	string MAIN_SEAL;
	string MY_BASE_DAMAGE;
	string MY_DURATION;
	string MY_OWNER;
	int OFSZ_NEG;
	int OFSZ_POS;
	int OFS_NEG;
	int OFS_POS;
	string OWNER_ISPLAYER;
	float PULSE_PLAYTIME;
	int RAIN_SPRITES;
	int ROT_COUNT;
	string SCAN_TARGS;
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

	CircleOfFire()
	{
		SOUND_MANIFEST = "weapons/egon_windup2.wav";
		SOUND_PULSE = "magic/egon_run3_noloop.wav";
		PULSE_PLAYTIME = 2.1;
		SOUND_FADE = "weapons/egon_off1.wav";
		SEAL_MODEL = "weapons/magic/seals.mdl";
		SEAL_OFS = 1;
		FX_SPRITE = "Fire2.spr";
		CIRCLE_RADIUS = 128;
		APPLY_EFFECT = "effects/dot_fire";
		OFS_POS = 72;
		OFS_NEG = -72;
		OFSZ_POS = 256;
		OFSZ_NEG = -10;
		LIGHT_PLAYER_SCALE = 0.3;
		LIGHT_DROPPED_SCALE = 0.5;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DURATION = param2;
		MY_BASE_DAMAGE = param3;
		OWNER_ISPLAYER = IsValidPlayer(param1);
		GAME_PVP = "game.pvp";
		MY_DURATION("circle_end");
	}

	void OnSpawn() override
	{
		SetName("Circle of Fire");
		SetHealth(1);
		SetFOV(359);
		SetInvincible(true);
		SetRace("beloved");
		SetHeight(2);
		SetWidth(2);
		SetFly(true);
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
		GROUND_DIST -= 2;
		SEAL_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, GROUND_DIST));
		SpawnNPC("monsters/summon/seal_maker", SEAL_POS, ScriptMode::Legacy); // params: SEAL_MODEL, MY_DURATION, SEAL_OFS
	}

	void circle_hum()
	{
		if (!(CIRCLE_UP))
		{
			string CLIENT_DURATION = MY_DURATION;
			CLIENT_DURATION -= 0.2;
			ClientEvent("new", "all_in_sight", currentscript, CLIENT_DURATION, GetEntityIndex(GetOwner()), 128);
			THIS_SCRIPT_CLIENT_ID = "game.script.last_sent_id";
			CIRCLE_UP = 1;
		}
		if ((DID_WINDUP))
		{
			EmitSound(GetOwner(), 0, SOUND_PULSE, 5);
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
		SCAN_TARGS = FindEntitiesInSphere("any", CIRCLE_RADIUS);
		if (!(SCAN_TARGS != "none")) return;
		string N_TARGS = GetTokenCount(SCAN_TARGS, ";");
		if (!(N_TARGS > 0)) return;
		for (int i = 0; i < N_TARGS; i++)
		{
			zap_targets();
		}
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), CIRCLE_RADIUS, 0, 1.0, 0);
		if (!(false)) return;
		if (!(GetEntityRange(m_hLastSeen) <= CIRCLE_RADIUS)) return;
		if (!(GetRelationship(m_hLastSeen) == "enemy")) return;
		string DMG_SOURCE = MY_OWNER;
		if ((GetEntityProperty(m_hLastSeen, "haseffect"))) return;
		ApplyEffect(m_hLastSeen, APPLY_EFFECT, 1, DMG_SOURCE, MY_BASE_DAMAGE);
	}

	void zap_targs()
	{
		string CUR_TARG = GetToken(SCAN_TARGS, i, ";");
		if (!(IsEntityAlive(CUR_TARG))) return;
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		string DMG_SOURCE = MY_OWNER;
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
		if ((GetEntityProperty(CUR_TARG, "haseffect"))) return;
		ApplyEffect(CUR_TARG, APPLY_EFFECT, 1, DMG_SOURCE, MY_BASE_DAMAGE);
	}

	void circle_end()
	{
		CIRCLE_ON = 0;
		ClientEvent("remove", "all", THIS_SCRIPT_CLIENT_ID);
		EmitSound(GetOwner(), 0, SOUND_FADE, 10);
		ScheduleDelayedEvent(0.5, "circle_remove");
	}

	void circle_remove()
	{
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		sfx.npcid = param2;
		sfx.radius = param3;
		sfx.duration = param1;
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
			string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(g.pos);
			string THIS_Z = (g.pos).z;
			string GROUND_DIST = GROUND_Z;
			GROUND_DIST -= THIS_Z;
			g.pos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, GROUND_DIST));
			ClientEffect("tempent", "model", SEAL_MODEL, g.pos, "setup_main_model");
			g.pos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 100));
			ClientEffect("tempent", "model", SEAL_MODEL, g.pos, "setup_main_model");
			MAIN_SEAL = 1;
		}
		if (!(ROT_COUNT <= 360)) return;
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(l.pos);
		string THIS_Z = (l.pos).z;
		string GROUND_DIST = GROUND_Z;
		GROUND_DIST -= THIS_Z;
		GROUND_DIST /= 2;
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, ROT_COUNT, 0), Vector3(0, 72, GROUND_DIST));
		ROT_COUNT += 40;
		ClientEffect("tempent", "sprite", FX_SPRITE, l.pos, "setup_flame");
		if ((MAIN_MODEL)) return;
	}

	void setup_flame()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", sfx.duration);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 8);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
	}

	void setup_main_model()
	{
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
	}

	void effect_die()
	{
		RAIN_SPRITES = 0;
		RemoveScript();
	}

}

}
