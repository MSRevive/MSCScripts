#pragma context server

#include "monsters/beetle_base.as"

namespace MS
{

class BeetleFireGiant : CGameScript
{
	string ANIM_SPECIAL;
	string AS_ATTACKING;
	int BBET_CAN_FLY;
	int BBET_CAN_LEAP;
	int BBET_CAN_SLAM;
	int BBET_FAKE_DEATH;
	int BBET_GORE_PUSH_STR;
	int BBET_HORN;
	int BBET_SIZE;
	int DMG_BURST;
	int DMG_GORE;
	int DMG_SLAM;
	int DMG_SLASH;
	float DOT_POISON;
	int FLAME_JET_DMG;
	int FLAME_JET_DOT;
	float FREQ_SPIT;
	string NEXT_SPIT;
	int NPC_GIVE_EXP;
	string POISON_TARGS;
	string SLAM_POS;
	string SOUND_POISON_BURST;
	string SPIT_LIST;
	int SPIT_TARG_IDX;
	string STUN_TARGS;

	BeetleFireGiant()
	{
		NPC_GIVE_EXP = 5000;
		BBET_SIZE = 2;
		BBET_CAN_FLY = 0;
		BBET_CAN_LEAP = 0;
		BBET_CAN_SLAM = 1;
		BBET_GORE_PUSH_STR = 300;
		BBET_FAKE_DEATH = 0;
		DMG_SLASH = 160;
		DMG_GORE = 240;
		DOT_POISON = 100.0;
		DMG_BURST = 2000;
		DMG_SLAM = 1000;
		BBET_HORN = 1;
		ANIM_SPECIAL = "bug_conjure";
		FREQ_SPIT = Random(10.0, 20.0);
		SOUND_POISON_BURST = "weapons/explode3.wav";
		FLAME_JET_DMG = 200;
		FLAME_JET_DOT = 200;
	}

	void game_precache()
	{
		Precache("monsters/beetles_giant.mdl");
		Precache("cactusgibs.mdl");
		Precache("explode1.spr");
		Precache("xfireball3.spr");
	}

	void beetle_spawn()
	{
		SetName("Giant Fire Beetle");
		SetHealth(10000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetModelBody(0, 2);
	}

	void beetle_slam()
	{
		SLAM_POS = GetEntityProperty(GetOwner(), "attachpos");
		SLAM_POS = "z";
		DoDamage(SLAM_POS, BBET_SLAM_RADIUS, DMG_SLAM, 1.0, 0);
		ClientEvent("new", "all", "effects/sfx_stun_burst", SLAM_POS, 256, 0);
		STUN_TARGS = FindEntitiesInSphere("enemy", 256);
		if (!(STUN_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(STUN_TARGS, ";"); i++)
		{
			affect_targets();
		}
	}

	void affect_targets()
	{
		string CUR_TARG = GetToken(STUN_TARGS, i, ";");
		if (!(IsOnGround(CUR_TARG))) return;
		ApplyEffect(CUR_TARG, "effects/debuff_stun", 8.0, GetEntityIndex(GetOwner()));
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(SLAM_POS, TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		EmitSound(GetOwner(), 0, SOUND_POISON_BURST, 10);
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 256, DMG_BURST, 0, GetOwner(), GetOwner(), "none", "generic");
		ClientEvent("new", "all", "effects/sfx_explode", GetEntityOrigin(GetOwner()), 512);
		Effect("tempent", "gibs", "cactusgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1.0, 50, 50, 15, 2.0);
		POISON_TARGS = FindEntitiesInSphere("enemy", 512);
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
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_POISON);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetGameTime() > NEXT_SPIT)) return;
		NEXT_SPIT = GetGameTime();
		NEXT_SPIT += FREQ_SPIT;
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_SPECIAL);
	}

	void frame_spell()
	{
		SPIT_LIST = FindEntitiesInSphere("enemy", 1024);
		if (!(SPIT_LIST != "none")) return;
		SPIT_TARG_IDX = 0;
		spit_targets();
	}

	void spit_targets()
	{
		string CUR_SPIT_TARG = GetToken(SPIT_LIST, SPIT_TARG_IDX, ";");
		TossProjectile("proj_flame_jet", /* TODO: $relpos */ $relpos(0, 64, 28), CUR_SPIT_TARG, 300, DMG_SPIT, 2, "none");
		SPIT_TARG_IDX += 1;
		string N_SPIT_TARGS = GetTokenCount(SPIT_LIST, ";");
		N_SPIT_TARGS -= 1;
		if (!(SPIT_TARG_IDX < N_SPIT_TARGS)) return;
		SPIT_TARG_IDX += 1;
		ScheduleDelayedEvent(0.1, "spit_targets");
	}

}

}
