#pragma context server

#include "monsters/eagle_giant_base.as"

namespace MS
{

class EagleGiantThunder : CGameScript
{
	int BEAMS_ON;
	string BEAM_LIST;
	string BEAM_TARGETS;
	int DOT_SHOCK;
	float FREQ_STORM;
	float FREQ_ZAP;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	string SOUND_STORM;
	string SOUND_ZAP;
	string SOUND_ZAP_WARMUP;

	EagleGiantThunder()
	{
		NPC_GIVE_EXP = 400;
		FREQ_ZAP = 10.0;
		DOT_SHOCK = 25;
		FREQ_STORM = Random(30, 40);
		SOUND_ZAP_WARMUP = "debris/beamstart2.wav";
		SOUND_ZAP = "debris/beamstart9.wav";
		SOUND_STORM = "weather/Storm_exclamation.wav";
	}

	void game_precache()
	{
		Precache("monsters/summon/tornado");
	}

	void OnSpawn() override
	{
		SetName("Thunderbird");
		SetRace("demon");
		SetHealth(2000);
		SetWidth(64);
		SetHeight(64);
		SetModel("monsters/eagle_large.mdl");
		SetIdleAnim("flapping");
		SetMoveAnim("flapping");
		SetHearingSensitivity(8);
		SetRoam(true);
		SetDamageResistance("poison", 2.0);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("lightning", 0.0);
		SetProp(GetOwner(), "skin", 6);
		FREQ_ZAP("do_zap");
		FREQ_STORM("do_storm");
		BEAM_LIST = "";
		ScheduleDelayedEvent(0.1, "init_beam1");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!((param5).findFirst("effect_") == 0)) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(20, 200, 10));
	}

	void do_zap()
	{
		FREQ_ZAP("do_zap");
		BEAM_TARGETS = /* TODO: $get_tbox */ $get_tbox("enemy", 1024, GetMonsterProperty("origin"));
		if (!(BEAM_TARGETS != "none")) return;
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 128, 3, 3);
		EmitSound(GetOwner(), 0, SOUND_ZAP_WARMUP, 10);
		ScheduleDelayedEvent(1.0, "do_zap2");
	}

	void do_zap2()
	{
		BEAMS_ON = 0;
		for (int i = 0; i < GetTokenCount(BEAM_TARGETS, ";"); i++)
		{
			zap_targets();
		}
		EmitSound(GetOwner(), 0, SOUND_ZAP, 10);
		ScheduleDelayedEvent(2.0, "turn_beams_off");
	}

	void zap_targets()
	{
		string CUR_IDX = i;
		if (!(BEAMS_ON < 4)) return;
		string CUR_TARGET = GetToken(BEAM_TARGETS, CUR_IDX, ";");
		string CUR_TARG_ORG = GetEntityOrigin(CUR_TARGET);
		string CUR_BEAM = GetToken(BEAM_LIST, CUR_IDX, ";");
		string TRACE_TARGET = TraceLine(GetMonsterProperty("origin"), CUR_TARG_ORG);
		if (!(TRACE_TARGET == CUR_TARG_ORG)) return;
		BEAMS_ON += 1;
		Effect("beam", "update", CUR_BEAM, "end_target", CUR_TARGET, 0);
		Effect("beam", "update", CUR_BEAM, "brightness", 200);
		ApplyEffect(CUR_TARGET, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), DOT_SHOCK);
		AddVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(-100, 1000, 250));
	}

	void turn_beams_off()
	{
		for (int i = 0; i < GetTokenCount(BEAM_LIST, ";"); i++)
		{
			beams_off_loop();
		}
	}

	void beams_off_loop()
	{
		Effect("beam", "update", GetToken(BEAM_LIST, i, ";"), "brightness", 0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		for (int i = 0; i < GetTokenCount(BEAM_LIST, ";"); i++)
		{
			beams_remove();
		}
	}

	void beams_remove()
	{
		Effect("beam", "update", GetToken(BEAM_LIST, i, ";"), "remove", 0.1);
	}

	void init_beam1()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.1, "init_beam2");
	}

	void init_beam2()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.1, "init_beam3");
	}

	void init_beam3()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.1, "init_beam4");
	}

	void init_beam4()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
	}

	void do_storm()
	{
		FREQ_STORM("do_storm");
		if (!(m_hAttackTarget != "unset")) return;
		EmitSound(GetOwner(), 0, SOUND_STORM, 10);
		PlayAnim("critical", ANIM_ATTACK);
		SpawnNPC("monsters/summon/tornado", /* TODO: $relpos */ $relpos(0, 64, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 50, 20.0
		npcatk_suspend_ai(3.0);
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(NPC_HOME_LOC);
	}

}

}
