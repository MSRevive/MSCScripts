#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteBlueTurret : CGameScript
{
	int ALCO_TYPE;
	float FREQ_THROW;
	int NO_STUCK_CHECKS;

	KAlcolyteBlueTurret()
	{
		const int OVERRIDE_TYPE = 1;
		ALCO_TYPE = 4;
		const string ANIM_WALK_NORM = "crouch_idle";
		const string ANIM_RUN_NORM = "crouch_idle";
		const string ANIM_IDLE_NORM = "crouch_idle";
		const string ANIM_HOP = "crouch_idle";
		const string ANIM_JUMP = "crouch_idle";
		const string ANIM_CRAWL = "crouch_idle";
		const string ANIM_IDLE_CRAWL = "crouch_idle";
		const string ANIM_ATTACK_NORM = "crouch_shoot_knife";
		const string ANIM_ATTACK_CRAWL = "crouch_shoot_knife";
		const int AM_TURRET = 1;
		const int NO_JUMPS = 1;
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
