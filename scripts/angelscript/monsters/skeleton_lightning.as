#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonLightning : CGameScript
{
	string ANIM_CAST;
	string ANIM_RUN;
	int ATTACH_WAND;
	float ATTACK_DAMAGE_HIGH;
	float ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	string BARRIER_ID;
	int BARRIER_RAD;
	string DID_WARCRY;
	float DMG_BARRIER;
	float DMG_ZAP;
	float DOT_ZAP;
	float DUR_ZAP;
	float FREQ_ZAP;
	int GOLD_BAGS;
	int GOLD_BAGS_PPLAYER;
	int GOLD_MAX_BAGS;
	int GOLD_PER_BAG;
	int GOLD_RADIUS;
	int NPC_GIVE_EXP;
	string SET_GREEK;
	int SKEL_HP;
	string SOUND_BARRIER_REPELL;
	string SOUND_BARRIER_SPAWN;
	string SOUND_LAUGH;
	string SOUND_WARCRY;
	int ZAP_ACTIVE;
	float ZAP_FREQ;
	string ZAP_LIST;
	int ZAP_RANGE;

	SkeletonLightning()
	{
		ANIM_RUN = "run";
		ANIM_CAST = "castspell";
		GOLD_BAGS = 1;
		GOLD_BAGS_PPLAYER = 1;
		GOLD_PER_BAG = 50;
		GOLD_RADIUS = 64;
		GOLD_MAX_BAGS = 4;
		SOUND_LAUGH = "monsters/skeleton/cal_laugh.wav";
		SOUND_WARCRY = "monsters/skeleton/calrain3.wav";
		SKEL_HP = 1000;
		ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE_LOW = 15.5;
		ATTACK_DAMAGE_HIGH = 25.5;
		NPC_GIVE_EXP = 400;
		DMG_ZAP = Random(40, 60);
		DOT_ZAP = 10.0;
		DUR_ZAP = 5.0;
		DMG_BARRIER = 10.0;
		BARRIER_RAD = 96;
		ZAP_FREQ = Random(10, 15);
		ZAP_RANGE = 1024;
		ATTACH_WAND = 0;
		FREQ_ZAP = 30.0;
		SOUND_BARRIER_REPELL = "doors/aliendoor3.wav";
		SOUND_BARRIER_SPAWN = "magic/spawn.wav";
	}

	void skeleton_spawn()
	{
		SetName("Lightning Forged Skeleton");
		SetRace("undead");
		SetRoam(true);
		SetDamageResistance("all", ".7");
		SetModel("monsters/skeleton_enraged.mdl");
		SetHearingSensitivity(8);
		SetModelBody(0, 6);
		SetModelBody(1, 8);
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SET_GREEK = 1;
		}
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
		SetMoveAnim("sitstand");
		SetIdleAnim("sitstand");
		SetDamageResistance("lightning", 0.0);
		string MY_SKY = GetMonsterProperty("origin");
		MY_SKY += Vector3(0, 0, 4096);
		string MY_CENTER = GetEntityOrigin(GetOwner());
		MY_CENTER += Vector3(0, 0, -48);
		EmitSound(GetOwner(), 0, "weather/lightning.wav", 10);
		Effect("beam", "point", "lgtning.spr", 120, MY_CENTER, MY_SKY, Vector3(128, 64, 255), 200, 3.0, 1.0);
		ZAP_FREQ("zap_check");
		ScheduleDelayedEvent(2.0, "stand_complete");
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
		}
	}

	void stand_complete()
	{
		SetIdleAnim("idle1");
		if ((CYCLED_UP)) return;
		SetMoveAnim(ANIM_WALK);
	}

	void zap_check()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(m_hAttackTarget != "unset")) return;
		ZAP_LIST = FindEntitiesInSphere("enemy", ZAP_RANGE);
		if (!(ZAP_LIST != "none")) return;
		EmitSound(GetOwner(), 3, SOUND_WARCRY, 10);
		EmitSound(GetOwner(), 1, SOUND_BARRIER_SPAWN, 10);
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_CAST);
		ClientEvent("new", "all", "monsters/skeleton_lightning_cl", GetEntityIndex(GetOwner()), BARRIER_RAD, Vector3(255, 0, 0), DUR_ZAP, 1, 1);
		BARRIER_ID = "game.script.last_sent_id";
		ZAP_ACTIVE = 1;
		DUR_ZAP("stop_zapping");
		ScheduleDelayedEvent(1.0, "zap_scan_loop");
		ZAP_FREQ("zap_check");
	}

	void zap_scan_loop()
	{
		if (!(ZAP_ACTIVE)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(1.0, "zap_scan_loop");
		string L_ZAP_ORG = GetEntityOrigin(GetOwner());
		L_ZAP_ORG += "z";
		ClientEvent("update", "all", BARRIER_ID, "clear_beams");
		XDoDamage(L_ZAP_ORG, ZAP_RANGE, DMG_ZAP, 0, GetOwner(), GetOwner(), "none", "lightning_effect", "dmgevent:zap");
	}

	void zap_dodamage()
	{
		if (!(param1)) return;
		string CUR_TARG = param2;
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		ApplyEffect(CUR_TARG, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_ZAP);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		ClientEvent("update", "all", BARRIER_ID, "add_beam", GetEntityIndex(CUR_TARG));
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		if (GetEntityRange(CUR_TARG) > BARRIER_RAD)
		{
			AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(0, 500, 0)));
		}
		else
		{
			SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 110)));
			EmitSound(GetOwner(), 1, SOUND_BARRIER_REPELL, 10);
		}
	}

	void stop_zapping()
	{
		ZAP_ACTIVE = 0;
		ClientEvent("update", "all", BARRIER_ID, "end_fx");
		npcatk_resume_ai();
		npcatk_resume_movement();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(ZAP_ACTIVE)) return;
		ClientEvent("update", "all", BARRIER_ID, "end_fx");
	}

}

}
