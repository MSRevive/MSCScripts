#pragma context server

#include "monsters/k_larva.as"

namespace MS
{

class KLarvaBlack : CGameScript
{
	int AM_BARFING;
	int AM_EATING;
	string AS_ATTACKING;
	string BARF_TARGETS;
	int DID_WARCRY;
	int STARTED_CYCLES;

	KLarvaBlack()
	{
		const int NPC_BASE_EXP = 400;
		const string DMG_LICK = RandomInt(40, 80);
		const string DMG_CLAW1 = RandomInt(60, 120);
		const string DMG_CLAW2 = RandomInt(60, 120);
		const string FREQ_BARF = Random(10, 20);
		const int BARF_BONE = 25;
		const int BARF_DUR = 10;
		const int DOT_BARF = 50;
		const string ANIM_BARF = "idle2";
		const string SOUND_BARF = "monsters/gonome/gonome_eat.wav";
		const string CL_SCRIPT = "monsters/k_larva_black_cl";
	}

	void game_precache()
	{
		Precache(CL_SCRIPT);
	}

	void larva_spawn()
	{
		SetName("Black Kharaztorant Larva");
		SetModel("monsters/k_larva_black.mdl");
		SetHealth(1600);
		SetRace("demon");
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetHearingSensitivity(6);
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("poison", 0.5);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("fire", 1.0);
		SetDamageResistance("lightning", 2.0);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
	}

	void npc_targetsighted()
	{
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		AM_EATING = 0;
		if ((DID_WARCRY)) return;
		DID_WARCRY = 1;
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		PlayAnim("critical", ANIM_IDLE2);
		AS_ATTACKING = GetGameTime();
		if ((STARTED_CYCLES)) return;
		STARTED_CYCLES = 1;
		FREQ_BARF("do_barf");
	}

	void do_barf()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		FREQ_BARF("do_barf");
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		npcatk_suspend_ai();
		SetRoam(false);
		SetIdleAnim(ANIM_BARF);
		SetMoveAnim(ANIM_BARF);
		EmitSound(GetOwner(), 0, SOUND_BARF, 10);
		ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()), BARF_BONE);
		AM_BARFING = 1;
		barf_scan();
		ScheduleDelayedEvent(4.0, "stop_barfing");
	}

	void stop_barfing()
	{
		AM_BARFING = 0;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetRoam(true);
		npcatk_resume_ai();
	}

	void barf_scan()
	{
		if (!(AM_BARFING)) return;
		ScheduleDelayedEvent(0.5, "barf_scan");
		string BARF_CENTER = GetEntityProperty(GetOwner(), "svbonepos");
		BARF_CENTER += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 64, 0));
		BARF_TARGETS = FindEntitiesInSphere("enemy", 96);
		if (!(BARF_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(BARF_TARGETS, ";"); i++)
		{
			zap_targs();
		}
	}

	void zap_targs()
	{
		string CUR_TARG = GetToken(BARF_TARGETS, i, ";");
		if (!(GetEntityRange(CUR_TARG) < 96)) return;
		ApplyEffect(CUR_TARG, "effects/dot_poison_blind", BARF_DUR, GetEntityIndex(GetOwner()), DOT_BARF);
	}

}

}
