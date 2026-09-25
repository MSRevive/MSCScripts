#pragma context server

#include "monsters/summon/base_aoe.as"

namespace MS
{

class IceBurst : CGameScript
{
	string ACTIVE_SKILL;
	string BURST_SCRIPT_IDX;
	string GAME_PVP;
	string MY_BASE_DAMAGE;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	int SCAN_RANGE;

	IceBurst()
	{
		SCAN_RANGE = 256;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		OWNER_ISPLAYER = IsValidPlayer(param1);
		GAME_PVP = "game.pvp";
		MY_BASE_DAMAGE = param2;
		ACTIVE_SKILL = param3;
		if (ACTIVE_SKILL == "PARAM3")
		{
			ACTIVE_SKILL = "spellcasting.ice";
		}
		ClientEvent("new", "all_in_sight", "monsters/summon/ice_burst_cl", GetEntityIndex(MY_OWNER));
		BURST_SCRIPT_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.25, "big_boom");
		ScheduleDelayedEvent(3.0, "effect_die");
	}

	void effect_die()
	{
		ClientEffect("remove", "all", BURST_SCRIPT_IDX);
		DeleteEntity(GetOwner());
	}

	void big_boom()
	{
		EmitSound(GetOwner(), 0, "ambience/steamburst1.wav", 10);
		aoe_applyeffect_rad();
	}

	void apply_aoe_effect()
	{
		int FREEZE_ON_CHANCE = RandomInt(1, 2);
		if (FREEZE_ON_CHANCE == 1)
		{
			ApplyEffect(param1, "effects/dot_cold", 10, MY_OWNER, RandomInt(10, MY_BASE_DAMAGE), ACTIVE_SKILL);
		}
		if (FREEZE_ON_CHANCE == 2)
		{
			if (GetEntityHealth(param1) > 1500)
			{
				ApplyEffect(param1, "effects/dot_cold", 10, MY_OWNER, RandomInt(10, MY_BASE_DAMAGE), ACTIVE_SKILL);
			}
			if (GetEntityHealth(param1) <= 1500)
			{
				ApplyEffect(param1, "effects/dot_cold_freeze", 5, MY_OWNER, RandomInt(10, 20));
			}
		}
	}

}

}
