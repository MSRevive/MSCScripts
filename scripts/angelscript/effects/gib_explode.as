#pragma context server

namespace MS
{

class GibExplode : CGameScript
{
	int EXPLODE_RADIUS;
	string FX_BLOOD_COLOR;
	string FX_DAMAGE;
	string FX_OWNER;
	string FX_SKILL;
	string GIB_INFLICTER;

	GibExplode()
	{
		GIB_INFLICTER = GetEntityIndex(GetOwner());
		EXPLODE_RADIUS = 200;
	}

	void OnSpawn() override
	{
		SetInvincible(true);
		SetRace("beloved");
		SetGravity(0.75);
		SetHeight(10);
		SetWidth(10);
		SetProp(GetOwner(), "movetype", 10);
		SetProp(GetOwner(), "friction", 0.4);
		SetProp(GetOwner(), "solid", 0);
		SetAngles("face");
	}

	void game_dynamically_created()
	{
		FX_OWNER = param1;
		SetVelocity(GetOwner(), param2);
		FX_DAMAGE = param3;
		FX_SKILL = param4;
		FX_BLOOD_COLOR = param5;
		if (FX_BLOOD_COLOR == "green")
		{
			SetModel("agibs.mdl");
			SetModelBody(0, RandomInt(0, 3));
		}
		else
		{
			SetModel(GetRandomToken("gib_b_bone.mdl;gib_b_gib.mdl;gib_lung.mdl;gib_legbone.mdl", ";"));
		}
		Random(1_0, 2_4)("stop_bounce");
		Random(2_5, 3_5)("explode");
	}

	void explode()
	{
		string L_SOUND = "leech/leech_bite";
		EmitSound(GetOwner(), 0, L_SOUND, 10);
		XDoDamage(GetEntityOrigin(GetOwner()), EXPLODE_RADIUS, FX_DAMAGE, 0, FX_OWNER, GIB_INFLICTER, FX_SKILL, "dark", "dmgevent:*gib");
		ClientEvent("new", "all", "effects/swords_gb/sfx_gib_explode", GetEntityOrigin(GetOwner()), FX_BLOOD_COLOR);
		SetModel("null.mdl");
		ScheduleDelayedEvent(0.1, "remove_fx");
	}

	void remove_fx()
	{
		DeleteEntity(GetOwner());
	}

	void stop_bounce()
	{
		SetProp(GetOwner(), "movetype", 13);
	}

}

}
