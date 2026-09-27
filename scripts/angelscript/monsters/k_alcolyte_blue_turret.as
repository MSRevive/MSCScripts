#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteBlueTurret : CGameScript
{
	int ALCO_TYPE;
	int AM_TURRET;
	string ANIM_ATTACK_CRAWL;
	string ANIM_ATTACK_NORM;
	string ANIM_CRAWL;
	string ANIM_HOP;
	string ANIM_IDLE_CRAWL;
	string ANIM_IDLE_NORM;
	string ANIM_JUMP;
	string ANIM_RUN_NORM;
	string ANIM_WALK_NORM;
	float FREQ_THROW;
	int NO_JUMPS;
	int NO_STUCK_CHECKS;
	int OVERRIDE_TYPE;

	KAlcolyteBlueTurret()
	{
		OVERRIDE_TYPE = 1;
		ALCO_TYPE = 4;
		ANIM_WALK_NORM = "crouch_idle";
		ANIM_RUN_NORM = "crouch_idle";
		ANIM_IDLE_NORM = "crouch_idle";
		ANIM_HOP = "crouch_idle";
		ANIM_JUMP = "crouch_idle";
		ANIM_CRAWL = "crouch_idle";
		ANIM_IDLE_CRAWL = "crouch_idle";
		ANIM_ATTACK_NORM = "crouch_shoot_knife";
		ANIM_ATTACK_CRAWL = "crouch_shoot_knife";
		AM_TURRET = 1;
		NO_JUMPS = 1;
		NO_STUCK_CHECKS = 1;
	}

	void OnSpawn() override
	{
		SetRoam(false);
		SetMoveSpeed(0.0);
	}

	void OnPostSpawn() override
	{
		ScheduleDelayedEvent(0.1, "override_freqs");
		ScheduleDelayedEvent(1.0, "crawl_mode");
	}

	void override_freqs()
	{
		FREQ_THROW = 2.0;
	}

	void run_mode()
	{
		crawl_mode();
	}

	void walk_mode()
	{
		crawl_mode();
	}

}

}
