#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjCannonBall : CGameScript
{
	ProjCannonBall()
	{
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 42;
		const string PROJ_ANIM_IDLE = "spin_horizontal_fast";
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int PROJ_STICK_DURATION = 0;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string PROJ_DAMAGE_TYPE = "siege";
		const int PROJ_AOE_RANGE = 150;
		const int PROJ_AOE_FALLOFF = 0;
		const string SMOKE_SPRITE = "bigsmoke.spr";
	}

	void arrow_spawn()
	{
		SetName("Cannon ball");
		SetDescription("A projectile used by flint cannons");
		SetWeight(0.1);
		SetWidth(1);
		SetHeight(1);
		SetValue(0);
		SetGravity(0.05);
		SetGroupable(25);
		EmitSound(GetOwner(), 0, "amb/cannon_incoming.wav", 10);
	}

	void projectile_landed()
	{
		EmitSound(GetOwner(), 2, "weapons/mortarhit.wav", 10);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 100, 5, 3, 500);
		Effect("tempent", "trail", SMOKE_SPRITE, /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 10), 10, 2, 1, 10, 20);
		DeleteEntity(GetOwner());
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		CallExternal(param2, "hit_by_siege");
	}

}

}
