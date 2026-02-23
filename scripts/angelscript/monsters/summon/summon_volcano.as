#pragma context server

namespace MS
{

class SummonVolcano : CGameScript
{
	string ANIM_DEATH;
	string AOE_DMG;
	string CAST_BY_PLAYER;
	string EFFECT_DURATION;
	int ERUPTING;
	string FIREBALL_DMG;
	string FUNC_ROCKSPAWN_ORIGIN;
	int FX_ACTIVE;
	float FX_DELAY;
	string FX_DURATION;
	string FX_IDX;
	string MODEL_IDX;
	string MY_OWNER;

	SummonVolcano()
	{
		const string MODEL_WORLD = "misc/volcano.mdl";
		ANIM_DEATH = "down";
		const string SOUND_SHOOT = "magic/flamelick_cast.wav";
		const float FIREBALL_FREQ = 0.27;
		const int AOE_FREQ = 1;
		const int AOE_RADIUS = 32;
		const int ANGLE_OFFSET = 60;
		const int FORCE_OFFSET = 70;
		const int ROCK_START_HEIGHT = 40;
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const string SPRITE_BURN = "fire1_fixed.spr";
		const string SPRITE_SMOKE = "rain_mist.spr";
		const int FLAME_CIRCLE_BODY = 51;
		const int CHAN_VOLCANO = 7;
		const string SOUND_START = "magic/volcano_start.wav";
		const string SOUND_LOOP = "magic/volcano_loop.wav";
		const int LIGHT_RADIUS = 250;
		const string LIGHT_COLOR = "(255,100,100)";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FX_DELAY);
		if ((FX_ACTIVE))
		{
			func_rockspawn();
			ClientEffect("tempent", "sprite", SPRITE_BURN, FUNC_ROCKSPAWN_ORIGIN, "volcano_fire_create");
		}
		else
		{
			func_rockspawn();
			ClientEffect("tempent", "sprite", SPRITE_SMOKE, FUNC_ROCKSPAWN_ORIGIN, "setup_smoke", "update_smoke");
		}
	}

	void game_precache()
	{
		Precache("misc/volcano.mdl");
	}

	void OnSpawn() override
	{
		SetName("volcano");
		SetHealth(1500);
		SetInvincible(true);
		SetRace("beloved");
		SetWidth(32);
		SetHeight(64);
		SetSolid("none");
		SetRoam(false);
		SetHearingSensitivity(0);
		SetModel(MODEL_WORLD);
		PlayAnim("hold", "up");
		ScheduleDelayedEvent(2, "volcano_start");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 50, 10, 6, 512);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		FIREBALL_DMG = param2;
		AOE_DMG = /* TODO: $math(multiply) */ FIREBALL_DMG;
		EFFECT_DURATION = param3;
		CAST_BY_PLAYER = IsValidPlayer(MY_OWNER);
		ClientEvent("new", "all", currentscript, GetEntityIndex(GetOwner()), EFFECT_DURATION);
		FX_IDX = "game.script.last_sent_id";
		EFFECT_DURATION("volcano_off");
	}

	void volcano_start()
	{
		ERUPTING = 1;
		ClientEvent("update", "all", FX_IDX, "fx_start");
		aoe_loop();
		fireball_loop();
	}

	void aoe_loop()
	{
		if (!(ERUPTING)) return;
		func_rockspawn();
		XDoDamage(FUNC_ROCKSPAWN_ORIGIN, 128, AOE_DMG, 0.01, MY_OWNER, GetEntityIndex(GetOwner()), "spellcasting.fire", "fire", "dmgevent:*volcano");
		AOE_FREQ("aoe_loop");
	}

	void fireball_loop()
	{
		if (!(ERUPTING)) return;
		func_rockspawn();
		string L_ORIGIN = FUNC_ROCKSPAWN_ORIGIN;
		string L_DIR = L_ORIGIN;
		L_DIR += "z";
		L_DIR += "x";
		L_DIR += "y";
		int L_FORCE = 500;
		L_FORCE += /* TODO: $math(multiply) */ FORCE_OFFSET;
		CallExternal(MY_OWNER, "ext_tossprojectile", "proj_volcano", L_ORIGIN, L_DIR, L_FORCE, FIREBALL_DMG, 0, "spellcasting.fire");
		EmitSound(GetOwner(), CHAN_WEAPON, SOUND_SHOOT, 4);
		FIREBALL_FREQ("fireball_loop");
	}

	void volcano_dodamage()
	{
		string L_TARGET = param2;
		string L_DMG = param6;
		if (!(param1)) return;
		if (!(IsEntityAlive(L_TARGET))) return;
		if (!(L_DMG > 0)) return;
		string L_DMG_FIRE = GetSkillLevel(MY_OWNER, "spellcasting.fire");
		L_DMG_FIRE *= 0.5;
		ApplyEffect(L_TARGET, "effects/dot_fire", 5, MY_OWNER, L_DMG_FIRE, "spellcasting.fire");
	}

	void volcano_off()
	{
		ERUPTING = 0;
		PlayAnim("hold", "down");
		ScheduleDelayedEvent(4, "volcano_die");
	}

	void volcano_die()
	{
		ClientEvent("update", "all", FX_IDX, "fx_die");
		DeleteEntity(GetOwner(), true); // fade out
	}

	void client_activate()
	{
		MODEL_IDX = param1;
		FX_DURATION = param2;
		FX_DELAY = 0.5;
		FX_DURATION("fx_end");
		FX_ACTIVE = 0;
		func_rockspawn();
		EmitSound3D(SOUND_START, 7, FUNC_ROCKSPAWN_ORIGIN, 0.8, CHAN_VOLCANO);
	}

	void fx_start()
	{
		FX_ACTIVE = 1;
		FX_DELAY = 0.2;
		ClientEffect("tempent", "model", MODEL_WORLD, /* TODO: $getcl */ $getcl(MODEL_IDX, "origin"), "setup_flame_circle", "update_flame_circle");
		func_rockspawn();
		ClientEffect("light", "new", FUNC_ROCKSPAWN_ORIGIN, LIGHT_RADIUS, LIGHT_COLOR, FX_DURATION);
		ScheduleDelayedEvent(6, "loop_sfx");
	}

	void loop_sfx()
	{
		if (!(FX_ACTIVE)) return;
		func_rockspawn();
		EmitSound3D(SOUND_LOOP, 7, FUNC_ROCKSPAWN_ORIGIN, 0.8, CHAN_VOLCANO);
		ScheduleDelayedEvent(6, "loop_sfx");
	}

	void volcano_fire_create()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.7);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-40, 40), Random(-40, 40), Random(230, 270)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
	}

	void setup_flame_circle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", FLAME_CIRCLE_BODY);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "scale", 7);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
	}

	void update_flame_circle()
	{
		if ((FX_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "origin", /* TODO: $getcl */ $getcl(MODEL_IDX, "origin"));
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(10000, 10000, 10000));
		}
	}

	void setup_smoke()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 4);
		ClientEffect("tempent", "set_current_prop", "framerate", RandomInt(1, 2));
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 240);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 170, 170));
		ClientEffect("tempent", "set_current_prop", "gravity", -0.055);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
	}

	void update_smoke()
	{
		if (/* TODO: $math(subtract) */ GetGameTime() >= 0.1)
		{
			string L_SCALE = /* TODO: $math(add) */ "game.tempent.scale";
			string L_VEL = "game.tempent.velocity";
			L_VEL += "y";
			L_VEL += "x";
			ClientEffect("tempent", "set_current_prop", "scale", L_SCALE);
			ClientEffect("tempent", "set_current_prop", "velocity", L_VEL);
			ClientEffect("tempent", "set_current_prop", "fuser1", GetGameTime());
		}
	}

	void fx_end()
	{
		FX_ACTIVE = 0;
		FX_DELAY = 0.5;
		func_rockspawn();
		EmitSound3D(SOUND_LOOP, 0, FUNC_ROCKSPAWN_ORIGIN, 0.8, CHAN_VOLCANO);
		ScheduleDelayedEvent(6.0, "fx_die");
	}

	void fx_die()
	{
		RemoveScript();
	}

	void func_rockspawn()
	{
		if ((true))
		{
			string L_ORIGIN = GetEntityOrigin(GetOwner());
		}
		else
		{
			string L_ORIGIN = /* TODO: $getcl */ $getcl(MODEL_IDX, "origin");
		}
		L_ORIGIN += "z";
		FUNC_ROCKSPAWN_ORIGIN = L_ORIGIN;
	}

}

}
