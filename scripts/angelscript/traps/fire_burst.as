#pragma context server

namespace MS
{

class FireBurst : CGameScript
{
	int PLAYING_DEAD;
	string TRAP_AOE;

	void OnSpawn() override
	{
		SetName("Exploding Fire Trap");
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
		ScheduleDelayedEvent(0.1, "do_explode");
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

	void do_explode()
	{
		if (TRAP_AOE == "TRAP_AOE")
		{
			TRAP_AOE = 256;
		}
		string L_BURST_POS = GetEntityOrigin(GetOwner());
		L_BURST_POS = "z";
		XDoDamage(L_BURST_POS, TRAP_AOE, "game.players.avghp", 0, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:explode");
		ClientEvent("new", "all", "effects/sfx_fire_burst", L_BURST_POS, TRAP_AOE, 1, Vector3(255, 64, 0));
		ScheduleDelayedEvent(6.0, "npc_suicide");
	}

	void explode_dodamage()
	{
		if (!(param1)) return;
		string L_TARG_MAXHP = GetEntityMaxHealth(param2);
		string L_BLAST_DMG = L_TARG_HP;
		if (L_TARG_HP >= 100)
		{
			string L_BLAST_RATIO = /* TODO: $math(divide) */ 100;
		}
		else
		{
			string L_BLAST_RATIO = /* TODO: $math(divide) */ L_TARG_HP;
		}
		return;
		string L_DOT = GetEntityMaxHealth(param2);
		L_DOT *= 0.05;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), L_DOT);
		repel_target(GetEntityIndex(param2), 1000, GetEntityOrigin(GetOwner()));
	}

	void repel_target()
	{
		string L_TARG_ORG = GetEntityOrigin(param1);
		string L_MY_ORG = param3;
		string L_TARG_ANG = /* TODO: $angles */ $angles(L_MY_ORG, L_TARG_ORG);
		string L_NEW_YAW = L_TARG_ANG;
		SetVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, L_NEW_YAW, 0), Vector3(0, param2, 0)));
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
