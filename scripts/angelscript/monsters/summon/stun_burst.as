#pragma context server

namespace MS
{

class StunBurst : CGameScript
{
	string BURST_SCRIPT_IDX;
	int MY_BASE_DAMAGE;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	string SCAN_RANGE;
	string SKILL_TYPE;
	string TARG_LIST;
	string THROW_TARGETS;

	void game_dynamically_created()
	{
		StoreEntity("ent_expowner");
		MY_OWNER = param1;
		OWNER_ISPLAYER = IsValidPlayer(param1);
		SCAN_RANGE = param2;
		MY_BASE_DAMAGE = 0;
		SKILL_TYPE = "none";
		if (param5 != "PARAM5")
		{
			SKILL_TYPE = param5;
		}
		SetRace(GetEntityRace(MY_OWNER));
		if (SCAN_RANGE == 0)
		{
			SCAN_RANGE = 96;
		}
		string TRACE_ORG = GetMonsterProperty("origin");
		string TRACE_END = TRACE_ORG;
		TRACE_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, -1000));
		string TRACE_LINE = TraceLine(TRACE_ORG, TRACE_END);
		if (param3 != "PARAM3")
		{
			THROW_TARGETS = param3;
		}
		if (param4 != "PARAM4")
		{
			MY_BASE_DAMAGE = param4;
		}
		SetEntityOrigin(GetOwner(), TRACE_LINE);
		SetAngles("face");
		ClientEvent("new", "all_in_sight", "monsters/summon/stun_burst_cl", TRACE_LINE, SCAN_RANGE);
		BURST_SCRIPT_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.25, "big_boom");
		ScheduleDelayedEvent(3.0, "effect_die");
	}

	void effect_die()
	{
		ClientEvent("remove", "all", BURST_SCRIPT_IDX);
		DeleteEntity(GetOwner());
	}

	void big_boom()
	{
		EmitSound(GetOwner(), 0, "magic/boom.wav", 10);
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
		if (!(IsOnGround(CHECK_ENT))) return;
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
		ApplyEffect(CHECK_ENT, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		if (MY_BASE_DAMAGE > 0)
		{
			XDoDamage(CHECK_ENT, "direct", MY_BASE_DAMAGE, 0, MY_OWNER, MY_OWNER, SKILL_TYPE, "magic");
		}
		if (!(THROW_TARGETS)) return;
		string TARGET_ORG = GetEntityOrigin(CHECK_ENT);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(CHECK_ENT, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

}

}
