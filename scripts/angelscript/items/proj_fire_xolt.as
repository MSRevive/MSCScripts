#pragma context server

#include "items/proj_arrow_base.as"
#include "items/proj_guided_base.as"

namespace MS
{

class ProjFireXolt : CGameScript
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
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	string SOUND_EXPLODE1;
	string SOUND_EXPLODE2;
	string SOUND_EXPLODE3;

	ProjFireXolt()
	{
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 40;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_DAMAGE = RandomInt(60, 90);
		PROJ_STICK_DURATION = 0;
		PROJ_DAMAGE_TYPE = "siege";
		PROJ_DAMAGE = RandomInt(400, 500);
		PROJ_AOE_RANGE = 64;
		PROJ_AOE_FALLOFF = 1;
		PROJ_MOTIONBLUR = 0;
		SOUND_EXPLODE1 = "weapons/explode3.wav";
		SOUND_EXPLODE2 = "weapons/explode4.wav";
		SOUND_EXPLODE3 = "weapons/explode5.wav";
	}

	void arrow_spawn()
	{
		SetName("Fire Bolt");
		SetDescription("A bolt of fire");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0);
		SetGroupable(25);
		EmitSound(GetOwner(), 0, "weapons/rocketfire1.wav", 10);
	}

	void projectile_landed()
	{
		// PlayRandomSound from: SOUND_EXPLODE1, SOUND_EXPLODE2, SOUND_EXPLODE3
		array<string> sounds = {SOUND_EXPLODE1, SOUND_EXPLODE2, SOUND_EXPLODE3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DeleteEntity(GetOwner());
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(-50, 300, 120));
	}

}

}
