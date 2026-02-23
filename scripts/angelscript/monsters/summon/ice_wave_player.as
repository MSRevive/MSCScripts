#pragma context server

#include "monsters/summon/base_aoe.as"
#include "monsters/base_noclip.as"

namespace MS
{

class IceWavePlayer : CGameScript
{
	int FADE_AMT;
	string FREEZE_DURATION;
	int IS_FADING;
	string MY_DURATION;
	string MY_OWNER;
	string NPC_NOCLIP_DEST;
	int PLAYING_DEAD;

	IceWavePlayer()
	{
		const float AOE_FREQ = 0.1;
		const int AOE_RADIUS = 128;
		const int FWD_SPEED = 20;
	}

	void OnSpawn() override
	{
		SetName("Ice Wave");
		SetHealth(1);
		SetInvincible(true);
		SetSolid("none");
		PLAYING_DEAD = 1;
		SetNoPush(true);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 52);
		DropToFloor();
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		FREEZE_DURATION = param2;
		MY_DURATION = param3;
		MY_DURATION("aoe_end");
		string FADE_START = MY_DURATION;
		FADE_START -= 2.0;
		FADE_START("begin_fade");
		ScheduleDelayedEvent(0.1, "set_angles_and_dest");
	}

	void apply_aoe_effect()
	{
		LogDebug("freezing GetEntityName(param1)");
		ApplyEffect(param1, "effects/dot_cold_freeze", FREEZE_DURATION, MY_OWNER);
	}

	void set_angles_and_dest()
	{
		string OWNER_ANG = GetEntityAngles(MY_OWNER);
		NPC_NOCLIP_DEST = /* TODO: $relpos */ $relpos(Vector3(0, /* TODO: $vec.yaw */ $vec.yaw(OWNER_ANG), 0), Vector3(0, 10000, 0));
		SetAngles("face");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void begin_fade()
	{
		IS_FADING = 1;
		FADE_AMT = 255;
	}

	void aoe_scan_loop()
	{
		if (!(IS_FADING)) return;
		FADE_AMT -= 10;
		if (!(FADE_AMT >= 0)) return;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", FADE_AMT);
	}

}

}
