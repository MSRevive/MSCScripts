#pragma context server

#include "monsters/beetle_base.as"

namespace MS
{

class BeetleVenomGiant : CGameScript
{
	string APOISON_TARGS;
	int DOING_SLIME;
	string NEXT_SLIME;
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	string POISON_TARGS;
	string SLAM_POS;
	string SLIME_TARGETS;
	string SPIN_ANG;
	string STUN_TARGS;

	BeetleVenomGiant()
	{
		NPC_GIVE_EXP = 3000;
		const int BBET_SIZE = 2;
		const int BBET_CAN_FLY = 0;
		const int BBET_CAN_LEAP = 0;
		const int BBET_CAN_SLAM = 1;
		const int BBET_GORE_PUSH_STR = 800;
		const int BBET_FAKE_DEATH = 0;
		const int DMG_SLASH = 160;
		const int DMG_GORE = 150;
		const int DMG_SLAM = 600;
		const int DOT_APOISON = 50;
		const int DOT_POISON = 100;
		const int DOT_SLIME = 50;
		const int DMG_BURST = 800;
		const string SOUND_SLIME = "monsters/gonome/gonome_eat.wav";
		const string SOUND_SLIME_LOOP = "ambience/steamjet1.wav";
		const string ANIM_SPECIAL = "bug_conjure";
		const string FREQ_SLIME = Random(20.0, 30.0);
		const float SLIME_ATTACK_DURATION = 4.0;
		NPC_MUST_SEE_TARGET = 0;
		const string SOUND_ATTACK1 = "monsters/beetle/attack_double1.wav";
		const string SOUND_ATTACK2 = "monsters/beetle/attack_double2.wav";
		const string SOUND_ATTACK3 = "monsters/beetle/attack_double3.wav";
		const string SOUND_POISON_BURST = "weapons/explode3.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		APOISON_TARGS = FindEntitiesInSphere("enemy", 256);
		if (APOISON_TARGS != "none")
		{
		}
		for (int i = 0; i < GetTokenCount(APOISON_TARGS, ";"); i++)
		{
			apoison_affect_targets();
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(10.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_poison_aura", GetEntityIndex(GetOwner()), 256, 10.0);
	}

	void game_precache()
	{
		Precache("monsters/beetles_giant.mdl");
		Precache("magic/boom.wav");
		Precache("cactusgibs.mdl");
		Precache("ambience/steamburst1.wav");
		Precache("poison_cloud.spr");
	}

	void beetle_spawn()
	{
		SetName("Giant Venomsack");
		SetHealth(4000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("poison", 0.1);
		SetModelBody(0, 1);
		ClientEvent("new", "all", "effects/sfx_poison_aura", GetEntityIndex(GetOwner()), 256, 10.0);
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

	void apoison_affect_targets()
	{
		string CUR_TARG = GetToken(APOISON_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_APOISON);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		EmitSound(GetOwner(), 0, SOUND_POISON_BURST, 10);
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 512, DMG_BURST, 0, GetOwner(), GetOwner(), "none", "poison_effect");
		ClientEvent("new", "all", "effects/sfx_poison_explode", GetEntityOrigin(GetOwner()), 512);
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
		ApplyEffect(CUR_TARG, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_POISON);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 200)));
	}

	void cycle_up()
	{
		NEXT_SLIME = GetGameTime();
		NEXT_SLIME += FREQ_SLIME;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if ((DOING_SLIME)) return;
		if (!(GetGameTime() > NEXT_SLIME)) return;
		do_slime();
	}

	void do_slime()
	{
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_SPECIAL);
		PlayAnim("critical", ANIM_SPECIAL);
		ClientEvent("new", "all", "monsters/beetle_venom_giant_cl", GetEntityIndex(GetOwner()), SLIME_ATTACK_DURATION);
		// svplaysound: svplaysound 2 10 SOUND_SLIME_LOOP
		EmitSound(2, 10, SOUND_SLIME_LOOP);
		EmitSound(GetOwner(), 0, SOUND_SLIME, 10);
		SPIN_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		DOING_SLIME = 1;
		slime_scan();
		SLIME_ATTACK_DURATION("end_slime");
	}

	void end_slime()
	{
		DOING_SLIME = 0;
		npcatk_resume_ai();
		npcatk_resume_movement();
		PlayAnim("once", "break");
		NEXT_SLIME = GetGameTime();
		NEXT_SLIME += FREQ_SLIME;
		// svplaysound: svplaysound 2 0 SOUND_SLIME_LOOP
		EmitSound(2, 0, SOUND_SLIME_LOOP);
	}

	void slime_scan()
	{
		if (!(DOING_SLIME)) return;
		ScheduleDelayedEvent(0.5, "slime_scan");
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, SPIN_ANG, 0), Vector3(0, 100, 0));
		SPIN_ANG += 10;
		if (SPIN_ANG > 359)
		{
			SPIN_ANG -= 359;
		}
		string SLIME_CENTER = GetEntityProperty(GetOwner(), "attachpos");
		SLIME_CENTER += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 128, 0));
		SLIME_CENTER = "z";
		SLIME_TARGETS = FindEntitiesInSphere("enemy", 96);
		if (!(SLIME_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(SLIME_TARGETS, ";"); i++)
		{
			slime_affect_targets();
		}
	}

	void slime_affect_targets()
	{
		string CUR_TARG = GetToken(SLIME_TARGETS, i, ";");
		if (!(GetEntityRange(CUR_TARG) < 256)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
		string TRACE_END = TARG_ORG;
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		ApplyEffect(CUR_TARG, "effects/dot_poison_blind", 5.0, GetEntityIndex(GetOwner()), DOT_SLIME);
	}

}

}
