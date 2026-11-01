#pragma context server

namespace MS
{

class ProjSprite : CGameScript
{
	string CL_ID;

	void OnSpawn() override
	{
		SetName("Projectile");
		SetModel("weapons/projectiles.mdl");
		SetDescription("Yeah , that s a projectile");
		SetWeight(0.01);
		SetSize(1);
		SetValue(0);
		SetGravity(0.01);
		SetGroupable(25);
		SetUseable(0);
		// TODO: movetype projectile
		int reg.proj.dmg = 0;
		int reg.proj.dmgtype = 0;
		int reg.proj.aoe.range = 0;
		int reg.proj.aoe.falloff = 0;
		int reg.proj.stick.duration = 0;
		int reg.proj.collidehitbox = 0;
		int reg.proj.ignorenpc = 0;
		SetMonsterClip(0);
		RegisterProjectile();
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
	}

	void game_tossprojectile()
	{
		ClientEvent("new", "all", "items/proj_sprite_cl", GetEntityIndex(GetOwner()), GetEntityProperty("ent_expowner", "scriptvar"));
		CL_ID = "game.script.last_sent_id";
	}

	void game_projectile_landed()
	{
		proj_landed();
	}

	void hitwall()
	{
		proj_landed();
	}

	void game_dodamage()
	{
		SetEntityOrigin(GetOwner(), param4);
		string OUT_PARAM1 = param1;
		string OUT_PARAM2 = param2;
		string OUT_PARAM3 = param3;
		string OUT_PARAM4 = param4;
		CallExternal("ent_expowner", "ext_proj_land", OUT_PARAM1, OUT_PARAM2, OUT_PARAM3, OUT_PARAM4);
	}

	void proj_landed()
	{
		ClientEvent("update", "all", CL_ID, "proj_landed");
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
