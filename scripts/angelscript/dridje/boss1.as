#pragma context server

#include "monsters/rabid_skele_base.as"

namespace MS
{

class Boss1 : CGameScript
{
	int AM_CLOAKED;
	int BEAMS_INITED;
	string BEAM_ID1;
	string BEAM_ID2;
	string BEAM_TARG;
	string BEAM_TARGET;
	float DUR_CLOAK;
	int FREQ_CLOAK;
	float FREQ_PROJECTILE;
	int NPC_GIVE_EXP;

	Boss1()
	{
		FREQ_PROJECTILE = 5.0;
		FREQ_CLOAK = RandomInt(15, 30);
		DUR_CLOAK = 10.0;
	}

	void rabid_skele_spawn()
	{
		SetName("Etherial Bone");
		SetModel("monsters/rabid_skelly.mdl");
		SetRace("undead");
		SetBloodType("none");
		SetHearingSensitivity(4);
		NPC_GIVE_EXP = 60;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetWidth(32);
		SetHeight(64);
		SetProp(GetOwner(), "skin", 5);
		SetHealth(2000);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("lightning", 0.0);
		AM_CLOAKED = 0;
		BEAM_ID1 = "unset";
		BEAM_ID2 = "unset";
		BEAMS_INITED = 0;
	}

	void cycle_up()
	{
		start_cycles();
	}

	void cycle_npc()
	{
		start_cycles();
	}

	void start_cycles()
	{
		FREQ_CLOAK("do_cloak");
		FREQ_PROJECTILE("check_projectile");
	}

	void check_projectile()
	{
		if ((AM_CLOAKED)) return;
		GetAllPlayers(PLAYER_LIST);
		ScrambleTokens(PLAYER_LIST, ";");
		if (!(BEAMS_INITED))
		{
			init_beams();
		}
		BEAM_TARGET = "unset";
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			pick_beam_target();
		}
		if (!(BEAM_TARGET != "unset")) return;
		do_beam();
	}

	void do_beam()
	{
		EmitSound(GetOwner(), 0, SOUND_BEAM_WARMUP, 10);
		PlayAnim("critical", ANIM_PROJECTILE);
	}

	void mdl_projectile()
	{
		EmitSound(GetOwner(), 0, SOUND_BEAM_FIRE, 10);
		Effect("beam", "update", BEAM_ID1, "end_target", BEAM_TARGET, 0);
		Effect("beam", "update", BEAM_ID2, "end_target", BEAM_TARGET, 0);
		Effect("beam", "update", BEAM_ID1, "brightness", 200);
		Effect("beam", "update", BEAM_ID2, "brightness", 200);
		DoDamage(BEAM_TARGET, "direct", DMG_BEAM, 1.0, GetOwner());
		AddVelocity(BEAM_TARGET, /* TODO: $relvel */ $relvel(0, 800, 1000));
	}

	void pick_beam_target()
	{
		if ((IsEntityAlive(BEAM_TARG))) return;
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		if (!(GetEntityRange(CUR_PLAYER) < 1024)) return;
		string TARG_ORG = GetEntityOrigin(CUR_PLAYER);
		string START_TRACE = GetEntityProperty(GetOwner(), "attachpos");
		string TRACE_ORG = TraceLine(START_TRACE, TARG_ORG);
		if (!(START_TRACE == TARG_ORG)) return;
		BEAM_TARG = CUR_PLAYER;
	}

	void init_beams()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 0, GetOwner(), 1, Vector3(200, 255, 50), 0, 30, -1);
		BEAM_ID1 = GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.5, "init_beams2");
	}

	void init_beams2()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 0, GetOwner(), 1, Vector3(200, 255, 50), 0, 30, -1);
		BEAM_ID2 = GetEntityIndex(m_hLastCreated);
	}

	void do_cloak()
	{
		EmitSound(GetOwner(), 0, SOUND_CLOAK, 10);
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 256, 2, 2);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SetAnimMoveSpeed(5.0);
		npcatk_flee(GetEntityIndex(m_hLastStruck), 2048, DUR_CLOAK);
		AM_CLOAKED = 1;
		SetCallback("touch", "enable");
		DUR_CLOAK("end_cloak");
	}

	void end_cloak()
	{
		EmitSound(GetOwner(), 0, SOUND_CLOAK, 10);
		SetCallback("touch", "disabled");
		AM_CLOAKED = 0;
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 256, 2, 2);
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
		SetAnimMoveSpeed(2.0);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(AM_CLOAKED)) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		AddVelocity(param1, /* TODO: $relvel */ $relvel(0, 800, 400));
	}

	void OnDamage(int damage) override
	{
		if (!(AM_CLOAKED))
		{
			string T_BOX = /* TODO: $get_tbox */ $get_tbox("players", 256);
			if (T_BOX != "none")
			{
			}
			if (GetTokenCount(T_BOX, ";") > 2)
			{
			}
			do_cloak();
		}
		if (!(AM_CLOAKED)) return;
		int CAN_HIT = 0;
		if (param3 != "magic")
		{
			int CAN_HIT = 1;
		}
		if (param3 != "holy")
		{
			int CAN_HIT = 1;
		}
		if (param3 != "dark")
		{
			int CAN_HIT = 1;
		}
		if ((CAN_HIT)) return;
		SetDamage("hit");
		SetDamage("dmg");
		return;
	}

}

}
