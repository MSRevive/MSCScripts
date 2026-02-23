#pragma context server

#include "monsters/summon/base_aoe2.as"

namespace MS
{

class CircleOfLolth : CGameScript
{
	int AOE_AFFECTS_WARY;
	string AOE_DURATION;
	int AOE_RADIUS;
	string MY_CL_IDX;
	string MY_OWNER;
	string MY_SKILL;
	int PLAYING_DEAD;

	CircleOfLolth()
	{
		const string SOUND_PULSE = "bullchicken/bc_acid2.wav";
		const string AOE_SCAN_TYPE = "dodamage";
		const float AOE_SCAN_FREQ = 1.0;
	}

	void game_precache()
	{
		Precache("weapons/magic/seals.mdl");
	}

	void OnSpawn() override
	{
		SetNoPush(true);
		SetInvincible(true);
		PLAYING_DEAD = 1;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		AOE_DURATION = param2;
		AOE_RADIUS = 180;
		AOE_AFFECTS_WARY = 1;
		string MY_GROUND = GetEntityOrigin(GetOwner());
		string CUR_GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(MY_GROUND);
		MY_GROUND = "z";
		SetEntityOrigin(GetOwner(), MY_GROUND);
		if (!(IsValidPlayer(GetOwner())))
		{
			MY_SKILL = "none";
		}
		ClientEvent("new", "all", "effects/sfx_seal", GetEntityOrigin(GetOwner()), AOE_RADIUS, 36, AOE_DURATION, "spider");
		MY_CL_IDX = "game.script.last_sent_id";
	}

	void aoe_scan_loop()
	{
		ClientEvent("update", "all", MY_CL_IDX, "ext_spider_pulse");
	}

	void aoe_affect_target()
	{
		XDoDamage(param1, "direct", Random(5, 10), 100, MY_OWNER, MY_OWNER, "axehandling", "magic_effect");
		ApplyEffect(param1, "effects/webbed", 3, MY_OWNER);
	}

	void aoe_end()
	{
		DeleteEntity(GetOwner());
	}

}

}
