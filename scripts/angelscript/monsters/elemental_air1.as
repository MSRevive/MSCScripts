#pragma context server

#include "monsters/elemental_air0.as"

namespace MS
{

class ElementalAir1 : CGameScript
{
	int AS_SUMMON_TELE_CHECK;
	int BALL_SIZE;
	string BALL_TARGETS;
	int DMG_BALL;
	string FIRE_BALL_AMMO;
	int I_JUST_SPAWNED;
	string MY_HURT_STAGE;
	int NEXT_LIGHTNING_BALL;
	int NPC_GIVE_EXP;

	ElementalAir1()
	{
		AS_SUMMON_TELE_CHECK = 1;
		BALL_SIZE = 3;
		DMG_BALL = 60;
		const float FREQ_CIRCLE = 60.0;
		const int DMG_CIRCLE = 100;
		const string FREQ_LIGHTING_BALLS = Random(20, 45);
	}

	void OnSpawn() override
	{
		SetName("Air Elemental");
		SetHealth(500);
		SetWidth(64);
		SetHeight(64);
		SetRace("demon");
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("poison", 1.5);
		SetDamageResistance("lightning", 0.0);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(5);
		SetModel("monsters/elementals_lesser_fly.mdl");
		SetModelBody(0, 1);
		NPC_GIVE_EXP = 150;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		FIRE_BALL_AMMO = FULL_FIRE_BALL_AMMO;
		I_JUST_SPAWNED = 1;
		SetFly(true);
		SetBloodType("none");
		MY_HURT_STAGE = GetEntityMaxHealth(GetOwner());
		MY_HURT_STAGE *= HURT_THRESHOLD;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RandomInt(200, 255));
		ScheduleDelayedEvent(0.1, "init_beam");
		NEXT_LIGHTNING_BALL = 0;
	}

	void npc_targetsighted()
	{
		if (!(GetGameTime() > NEXT_LIGHTNING_BALL)) return;
		NEXT_LIGHTNING_BALL = GetGameTime();
		NEXT_LIGHTNING_BALL += FREQ_LIGHTING_BALLS;
		npcatk_suspend_ai(1.5);
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		BALL_TARGETS = FindEntitiesInSphere("enemy", 1024);
		ScrambleTokens(BALL_TARGETS, ";");
		SetMoveDest(GetToken(BALL_TARGETS, 0, ";"));
		TossProjectile("proj_lightning_ball_simple", "view", GetToken(BALL_TARGETS, 0, ";"), 200, DMG_BALL, 0.5, "none");
		if (!(GetTokenCount(BALL_TARGETS, ";") > 1)) return;
		ScheduleDelayedEvent(0.5, "toss_ball_2");
	}

	void toss_ball_2()
	{
		SetMoveDest(GetToken(BALL_TARGETS, 1, ";"));
		TossProjectile("proj_lightning_ball_simple", "view", GetToken(BALL_TARGETS, 1, ";"), 200, DMG_BALL, 0.5, "none");
	}

}

}
