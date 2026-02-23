#pragma context server

#include "monsters/beetle_base.as"

namespace MS
{

class BeetleVenom : CGameScript
{
	string FART_CL_IDX;
	int NPC_GIVE_EXP;
	string POISON_TARGS;

	BeetleVenom()
	{
		NPC_GIVE_EXP = 600;
		const int BBET_SIZE = 1;
		const int BBET_CAN_FLY = 1;
		const int BBET_CAN_LEAP = 1;
		const int BBET_CAN_SLAM = 0;
		const int BBET_GORE_PUSH_STR = 300;
		const int BBET_FAKE_DEATH = 1;
		const int DMG_SLASH = 40;
		const int DMG_GORE = 60;
		const int DMG_LEAP = 100;
		const float DOT_POISON = 50.0;
		const int DMG_BURST = 200;
		const string SOUND_POISON_BURST = "weapons/explode3.wav";
	}

	void game_precache()
	{
		Precache("monsters/beetles.mdl");
		Precache("cactusgibs.mdl");
		Precache("ambience/steamburst1.wav");
		Precache("poison_cloud.spr");
	}

	void beetle_spawn()
	{
		SetName("Venomsack Beetle");
		SetHealth(1000);
		SetModelBody(0, 1);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		EmitSound(GetOwner(), 0, SOUND_POISON_BURST, 10);
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 256, DMG_BURST, 0, GetOwner(), GetOwner(), "none", "poison");
		ClientEvent("new", "all", "effects/sfx_poison_explode", GetEntityOrigin(GetOwner()), 256);
		Effect("tempent", "gibs", "cactusgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1.0, 50, 50, 15, 2.0);
		POISON_TARGS = FindEntitiesInSphere("enemy", 256);
		EmitSound(GetOwner(), 0, SOUND_POISON_BURST, 10);
		if (!(POISON_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(POISON_TARGS, ";"); i++)
		{
			poison_affect_targets();
		}
	}

	void poison_affect_targets()
	{
		string CUR_TARG = GetToken(POISON_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_POISON);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void bbet_fly_start()
	{
		ClientEvent("new", "all", "monsters/beetle_venom_cl", GetEntityIndex(GetOwner()), 10.0);
		FART_CL_IDX = "game.script.last_sent_id";
	}

	void bbet_end_flight()
	{
		if (!(BBET_FLYING)) return;
		ClientEvent("update", "all", FART_CL_IDX, "remove_fx");
	}

}

}
