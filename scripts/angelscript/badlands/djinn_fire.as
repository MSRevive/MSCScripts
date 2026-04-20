#pragma context server

#include "monsters/djinn_fire.as"

namespace MS
{

class DjinnFire : CGameScript
{
	int AIM_RATIO;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_CONE_OF_FIRE;
	int ATTACK_SPEED;
	int BURN_DAMAGE;
	int CANT_FLEE;
	int CAN_FLEE;
	int DO_NADDA;
	int FIRE_BALL_DAMAGE;
	int FIRE_BALL_DELAY;
	float FIRE_BALL_FREQ;
	int FIRE_BALL_RANGE;
	int IS_FLEEING;
	int NO_STUCK_CHECKS;
	int PURE_FLEE;
	int PUSH_CHANCE;
	string SOUND_FIRESHOOT;
	string SOUND_WARCRY;
	float WARCRY_FREQ;

	DjinnFire()
	{
		SOUND_FIRESHOOT = "magic/fireball_strike.wav";
		FIRE_BALL_FREQ = 2.5;
		AIM_RATIO = 50;
		ATTACK_SPEED = 500;
		ATTACK_CONE_OF_FIRE = 2;
		FIRE_BALL_DAMAGE = 400;
		FIRE_BALL_RANGE = 4000;
		SOUND_WARCRY = "monsters/troll/trollidle2.wav";
		WARCRY_FREQ = 60.0;
		PUSH_CHANCE = 5;
		BURN_DAMAGE = "$rand(20,50)";
		CAN_FLEE = 0;
		CANT_FLEE = 1;
		ANIM_WALK = "idle0";
		ANIM_RUN = "idle1";
		NO_STUCK_CHECKS = 1;
		Precache("monsters/djinn_fire");
	}

	void OnSpawn() override
	{
		SetName("Fire Djinn Val-sul");
		SetMoveSpeed(0.0);
		// TODO: UNCONVERTED: moveanim idle1
		SetRoam(false);
		SetHealth(4500);
		SetDamageResistance("all", 0.6);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("stun", 0);
		SetGravity(100);
		WARCRY_FREQ("do_warcry");
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((FIRE_BALL_DELAY)) return;
		if (!(false)) return;
		if (!(GetEntityRange(m_hLastSeen) > ATTACK_RANGE)) return;
		PlayAnim("once", "idle2");
		throw_fire_ball_start();
		FIRE_BALL_FREQ("reset_fire_ball_delay");
	}

	void reset_fire_ball_delay()
	{
		FIRE_BALL_DELAY = 0;
	}

	void throw_fire_ball_start()
	{
		if ((IS_FLEEING)) return;
		FIRE_BALL_DELAY = 1;
		npcatk_faceattacker(GetEntityIndex(m_hLastSeen));
		PlayAnim("critical", "throw_rock");
	}

	void rock_throw()
	{
		EmitSound(GetOwner(), 0, SOUND_FIRESHOOT, 10);
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.x");
		TossProjectile("proj_fire_ball", /* TODO: $relpos */ $relpos(0, 0, 46), GetEntityIndex(m_hLastSeen), ATTACK_SPEED, FIRE_BALL_DAMAGE, ATTACK_CONE_OF_FIRE, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "lighten", BURN_DAMAGE);
	}

	void summon_firetroll()
	{
		DO_NADDA = 1;
	}

	void do_warcry()
	{
		IS_FLEEING = 1;
		PURE_FLEE = 1;
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		PlayAnim("critical", "idle2");
		WARCRY_FREQ("do_warcry");
		ScheduleDelayedEvent(2.0, "restore_attacks");
	}

	void restore_attacks()
	{
		IS_FLEEING = 0;
		PURE_FLEE = 0;
	}

	void warcry()
	{
		UseTrigger("djinn_push");
	}

}

}
