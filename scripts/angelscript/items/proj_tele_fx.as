#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjTeleFx : CGameScript
{
	ProjTeleFx()
	{
		const string MODEL_WORLD = "none";
		const int ARROW_BODY_OFS = 5;
		const string PROJ_ANIM_IDLE = "idle_standard";
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int PROJ_STICK_DURATION = 0;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string SOUND_HITWALL1 = "fire.wav";
		const string SOUND_HITWALL2 = "fire.wav";
		const string PROJ_DAMAGE_TYPE = "siege";
		const string PROJ_DAMAGE = RandomInt(200, 300);
		const int PROJ_AOE_RANGE = 200;
		const int PROJ_AOE_FALLOFF = 1;
		const string TRAIL_SPRITE = "char_breath.spr";
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
