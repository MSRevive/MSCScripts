#pragma context server

namespace MS
{

class PoisonGas : CGameScript
{
	string DOT_ORG;
	int IS_ACTIVE;
	int PLAYING_DEAD;
	string TRAP_AOE;

	PoisonGas()
	{
	}

	void OnSpawn() override
	{
		SetName("Poison Gas Trap");
		SetModel("null.mdl");
		SetHealth(1);
		SetWidth(1);
		SetHeight(1);
		SetInvincible(true);
		SetGravity(0);
		SetFly(true);
		SetBloodType("none");
		SetRace("hated");
		PLAYING_DEAD = 1;
		SetNoPush(true);
		ScheduleDelayedEvent(0.1, "start_dot");
	}

	void game_postspawn()
	{
		if ((param4).findFirst("set_") == 0)
		{
			set_aoe(GetToken(param4, 1, ";"));
		}
		if (!(param2 > 1)) return;
		SetDamageMultiplier(param2);
	}

	void start_dot()
	{
		if (TRAP_AOE == "TRAP_AOE")
		{
			TRAP_AOE = 256;
		}
		DOT_ORG = GetEntityOrigin(GetOwner());
		DOT_ORG = "z";
		ClientEvent("new", "all", "effects/sfx_poison_cloud", DOT_ORG, TRAP_AOE, 20.0);
		IS_ACTIVE = 1;
		dot_loop();
		ScheduleDelayedEvent(20.0, "dot_end");
	}

	void dot_loop()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "dot_loop");
		XDoDamage(DOT_ORG, TRAP_AOE, 0, 0, GetOwner(), GetOwner(), "none", "target", "dmgevent:dot");
	}

	void dot_dodamage()
	{
		if (!(param1)) return;
		string L_DOT = GetEntityMaxHealth(param2);
		L_DOT *= 0.1;
		ApplyEffect(param2, "effects/dot_poison", 10.0, GetEntityIndex(GetOwner()), L_DOT);
	}

	void dot_end()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(11.0, "npc_suicide");
	}

	void npc_suicide()
	{
		SetEntityOrigin(GetOwner(), Vector3(20000, 10000, 30000));
		SetInvincible(false);
		DoDamage(GetOwner(), "direct", 99999, 100, GAME_MASTER);
	}

	void game_dynamically_created()
	{
		TRAP_AOE = param1;
	}

	void set_aoe()
	{
		TRAP_AOE = param1;
	}

}

}
