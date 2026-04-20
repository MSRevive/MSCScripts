#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjTeleFx : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string TRAIL_SPRITE;

	ProjTeleFx()
	{
		MODEL_WORLD = "none";
		ARROW_BODY_OFS = 5;
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
		TRAIL_SPRITE = "char_breath.spr";
		Precache("rockgibs.mdl");
	}

	void arrow_spawn()
	{
		SetName("Fx");
		SetDescription("A giant rock");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0);
		SetGroupable(25);
		SetSolid("none");
		ScheduleDelayedEvent(0.1, "spark_fx");
	}

	void spark_fx()
	{
		Effect("tempent", "spray", TRAIL_SPRITE, /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relvel */ $relvel(0, -30, 0), 10, 0.5, 50);
		ScheduleDelayedEvent(0.25, "spark_fx");
	}

	void projectile_landed()
	{
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
