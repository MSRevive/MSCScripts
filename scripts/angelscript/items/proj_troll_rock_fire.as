#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjTrollRockFire : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int MODEL_BODY_OFS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjTrollRockFire()
	{
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 67;
		MODEL_BODY_OFS = 67;
		PROJ_ANIM_IDLE = "idle_standard";
		PROJ_DAMAGE = RandomInt(60, 90);
		PROJ_STICK_DURATION = 0;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		SOUND_HITWALL1 = "fire.wav";
		SOUND_HITWALL2 = "fire.wav";
		PROJ_DAMAGE_TYPE = "siege";
		PROJ_DAMAGE = RandomInt(200, 300);
		PROJ_AOE_RANGE = 200;
		PROJ_AOE_FALLOFF = 1;
		Precache("rockgibs.mdl");
	}

	void arrow_spawn()
	{
		SetName("Flaming Boulder");
		SetDescription("A giant flaming rock");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.4);
		SetGroupable(25);
		if (!(true)) return;
		SetProp(GetOwner(), "scale", 0.5);
	}

	void projectile_landed()
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 100, 5, 3, 500);
		CallExternal("ent_expowner", "ext_proj_landed", GetEntityOrigin(GetOwner()));
		ScheduleDelayedEvent(0.1, "vanish");
	}

	void vanish()
	{
		DeleteEntity(GetOwner());
	}

	void hitwall()
	{
		EmitSound(GetOwner(), "const.snd.body", "fire.wav", "const.snd.fullvol");
	}

	void game_dodamage()
	{
		EmitSound(GetOwner(), "const.snd.body", "fire.wav", "const.snd.fullvol");
		if (!(param1)) return;
		CallExternal(param2, "hit_by_siege");
	}

}

}
