#pragma context server

namespace MS
{

class ProjMana2 : CGameScript
{
	string CLFX_ARROW_IDX;
	string CLFX_ARROW_INIT;
	string CLFX_ARROW_IN_FLIGHT;
	string FX_DAMAGE;
	string FX_OWNER;
	string FX_SIZE;
	string FX_SKILL;
	string FX_VEL;
	string PREV_SCAN;
	string SCAN_SIZE;

	ProjMana2()
	{
		const string SOUND_SHOOT = "ambience/alienflyby1.wav";
		const string SOUND_ZAP = "debris/zap1.wav";
		const string CLFX_ARROW_SCRIPT = "items/proj_mana2_cl";
	}

	void OnSpawn() override
	{
		SetName("Manabolt");
		SetDescription("Manabolt");
		SetWidth(0);
		SetHeight(0);
		SetWeight(0);
		SetGravity(0);
		SetMonsterClip(0);
		SetInvincible(true);
		SetRace("beloved");
		SetModel("none");
		ScheduleDelayedEvent(10.0, "remove_projectile");
	}

	void game_dynamically_created()
	{
		FX_OWNER = param1;
		FX_VEL = param2;
		FX_SIZE = param3;
		FX_DAMAGE = param4;
		FX_SKILL = param5;
		SCAN_SIZE = /* TODO: $func */ $func("func_get_scan_size");
		SetVelocity(GetOwner(), FX_VEL);
		EmitSound3D(SOUND_SHOOT, 2.5, GetEntityOrigin(GetOwner()), 0, 4);
		PREV_SCAN = GetEntityOrigin(GetOwner());
		ScheduleDelayedEvent(0.3, "scan_cycle");
		create_clfx();
		SetProp(GetOwner(), "movetype", 11);
		SetProp(GetOwner(), "friction", 10000);
		SetProp(GetOwner(), "solid", 0);
	}

	void create_clfx()
	{
		if (!(CLFX_ARROW_INIT))
		{
			CLFX_ARROW_INIT = 1;
			CLFX_ARROW_IN_FLIGHT = 1;
			ClientEvent("new", "all", CLFX_ARROW_SCRIPT, GetEntityOrigin(GetOwner()), GetEntityAngles(GetOwner()), GetEntityVelocity(GetOwner()), FX_SIZE);
			CLFX_ARROW_IDX = "game.script.last_sent_id";
		}
	}

	void scan_cycle()
	{
		string L_VEL = GetEntityVelocity(GetOwner());
		if (FX_VEL == L_VEL)
		{
			XDoDamage(GetEntityOrigin(GetOwner()), SCAN_SIZE, FX_DAMAGE, 0, FX_OWNER, GetOwner(), FX_SKILL, "magic", "dmgevent:*ball");
			ScheduleDelayedEvent(0.3, "scan_cycle");
		}
		else
		{
			remove_projectile();
		}
	}

	void ball_dodamage()
	{
		if (!(param1)) return;
		if (!(param6 > 0)) return;
		FX_SIZE -= 1;
		if (FX_SIZE > 0)
		{
			SCAN_SIZE = /* TODO: $func */ $func("func_get_scan_size");
			ClientEvent("update", "all", CLFX_ARROW_IDX, "reduce_size");
		}
		else
		{
			remove_projectile();
		}
	}

	void remove_projectile()
	{
		EmitSound3D(SOUND_ZAP, 4, GetEntityOrigin(GetOwner()), 0, 4);
		ClientEvent("update", "all", CLFX_ARROW_IDX, "end_fx");
		DeleteEntity(GetOwner());
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 4 0 SOUND_ZAP
		EmitSound(4, 0, SOUND_ZAP);
	}

	void func_get_scan_size()
	{
		int L_SCAN_SIZE = 24;
		L_SCAN_SIZE *= FX_SIZE;
		// TODO: capvar L_SCAN_SIZE 55 140
		return;
		return;
	}

}

}
