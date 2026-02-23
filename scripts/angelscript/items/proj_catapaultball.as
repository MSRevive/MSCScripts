#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjCatapaultball : CGameScript
{
	ProjCatapaultball()
	{
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 4;
		const string PROJ_ANIM_IDLE = "idle_standard";
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int PROJ_STICK_DURATION = 0;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string PROJ_DAMAGE_TYPE = "siege";
		const string PROJ_DAMAGE = RandomInt(400, 500);
		const int PROJ_AOE_RANGE = 250;
		const int PROJ_AOE_FALLOFF = 0;
		const string SMOKE_SPRITE = "bigsmoke.spr";
		Precache(SMOKE_SPRITE);
	}

	void arrow_spawn()
	{
		SetName("Catapult ball");
		SetDescription("A giant rock");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.6);
		SetGroupable(25);
	}

	void projectile_landed()
	{
		EmitSound(GetOwner(), "const.snd.body", "fire.wav", "const.snd.fullvol");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 100, 5, 3, 500);
		Effect("tempent", "trail", SMOKE_SPRITE, /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 10), 10, 2, 2, 10, 20);
		DeleteEntity(GetOwner());
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		CallExternal(param2, "hit_by_siege");
	}

}

}
