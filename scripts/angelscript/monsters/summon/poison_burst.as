#pragma context server

namespace MS
{

class PoisonBurst : CGameScript
{
	string BURST_SCRIPT_IDX;
	string MY_BASE_DAMAGE;
	string MY_DOT;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string SCAN_RANGE;
	string TARG_LIST;
	string THROW_TARGETS;

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		OWNER_ISPLAYER = IsValidPlayer(param1);
		SCAN_RANGE = param2;
		if (param3 != "PARAM3")
		{
			THROW_TARGETS = param3;
		}
		MY_BASE_DAMAGE = param4;
		MY_DOT = param5;
		SetAngles("face");
		SetRace(GetEntityRace(MY_OWNER));
		ClientEvent("new", "all_in_sight", "monsters/summon/poison_burst_cl", GetEntityOrigin(GetOwner()), SCAN_RANGE);
		BURST_SCRIPT_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.1, "do_aoe");
		ScheduleDelayedEvent(0.25, "set_targets");
		ScheduleDelayedEvent(3.0, "effect_die");
	}

	void do_aoe()
	{
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), SCAN_RANGE, MY_BASE_DAMAGE, 0, MY_OWNER, MY_OWNER, "spellcasting.affliction", "poison");
	}

	void OnSpawn() override
	{
		SetFly(true);
		SetGravity(0);
		SetNoPush(true);
		SetInvincible(true);
		PLAYING_DEAD = 1;
	}

	void effect_die()
	{
		ClientEvent("remove", "all", BURST_SCRIPT_IDX);
		DeleteEntity(GetOwner());
	}

	void set_targets()
	{
		EmitSound(GetOwner(), 0, "ambience/steamburst1.wav", 10);
		TARG_LIST = FindEntitiesInSphere("enemy", SCAN_RANGE);
		if (!(TARG_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(TARG_LIST, ";"); i++)
		{
			affect_targets();
		}
	}

	void affect_targets()
	{
		string CHECK_ENT = GetToken(TARG_LIST, i, ";");
		if ((OWNER_ISPLAYER))
		{
			if ("game.pvp" == 0)
			{
			}
			if ((IsValidPlayer(CHECK_ENT)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityProperty(CHECK_ENT, "haseffect")))
		{
			ApplyEffect(CHECK_ENT, "effects/dot_poison", 5.0, MY_OWNER, MY_DOT);
		}
		if (!(THROW_TARGETS)) return;
		string TARGET_ORG = GetEntityOrigin(CHECK_ENT);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(CHECK_ENT, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

}

}
