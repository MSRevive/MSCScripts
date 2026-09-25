#pragma context server

#include "monsters/beetle_base.as"

namespace MS
{

class BeetleFire : CGameScript
{
	string ANIM_SPECIAL;
	string AS_ATTACKING;
	int BBET_CAN_FLY;
	int BBET_CAN_LEAP;
	int BBET_CAN_SLAM;
	int BBET_FAKE_DEATH;
	int BBET_GORE_PUSH_STR;
	int BBET_SIZE;
	int DMG_BURST;
	int DMG_GORE;
	int DMG_LEAP;
	int DMG_SLASH;
	float DOT_POISON;
	int FLAME_JET_DMG;
	int FLAME_JET_DOT;
	float FREQ_SPIT;
	string NEXT_SPIT;
	int NPC_GIVE_EXP;
	string POISON_TARGS;
	string SOUND_POISON_BURST;

	BeetleFire()
	{
		NPC_GIVE_EXP = 1200;
		BBET_SIZE = 1;
		BBET_CAN_FLY = 1;
		BBET_CAN_LEAP = 1;
		BBET_CAN_SLAM = 0;
		BBET_GORE_PUSH_STR = 300;
		BBET_FAKE_DEATH = 1;
		DMG_SLASH = 80;
		DMG_GORE = 120;
		DMG_LEAP = 150;
		DOT_POISON = 100.0;
		DMG_BURST = 400;
		ANIM_SPECIAL = "bug_conjure";
		FREQ_SPIT = Random(5.0, 10.0);
		SOUND_POISON_BURST = "weapons/explode3.wav";
		FLAME_JET_DMG = 100;
		FLAME_JET_DOT = 100;
	}

	void game_precache()
	{
		Precache("monsters/beetles.mdl");
		Precache("cactusgibs.mdl");
		Precache("ambience/steamburst1.wav");
		Precache("explode1.spr");
		Precache("xfireball3.spr");
	}

	void beetle_spawn()
	{
		SetName("Fire Beetle");
		SetHealth(3500);
		SetDamageResistance("fire", 0.0);
		SetModelBody(0, 2);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		EmitSound(GetOwner(), 0, SOUND_POISON_BURST, 10);
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 256, DMG_BURST, 0, GetOwner(), GetOwner(), "none", "blunt");
		ClientEvent("new", "all", "effects/sfx_explode", GetEntityOrigin(GetOwner()), 256);
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
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_POISON);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) > 200)) return;
		if (!(false)) return;
		if (!(GetGameTime() > NEXT_SPIT)) return;
		NEXT_SPIT = GetGameTime();
		NEXT_SPIT += FREQ_SPIT;
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_SPECIAL);
	}

	void frame_spell()
	{
		TossProjectile("proj_flame_jet", /* TODO: $relpos */ $relpos(0, 64, 44), m_hAttackTarget, 300, DMG_SPIT, 2, "none");
	}

}

}
