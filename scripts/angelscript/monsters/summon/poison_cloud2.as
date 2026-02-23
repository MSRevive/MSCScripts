#pragma context server

#include "monsters/summon/base_aoe2.as"

namespace MS
{

class PoisonCloud2 : CGameScript
{
	string ACTIVE_SKILL;
	int AOE_AFFECTS_WARY;
	string AOE_DURATION;
	string AOE_OWNER;
	string AOE_RADIUS;
	string DMG_BASE;

	PoisonCloud2()
	{
		const string AOE_SCAN_TYPE = "rsphere";
		const string SOUND_SPAWN = "ambience/steamburst1.wav";
	}

	void game_precache()
	{
		Precache("poison_cloud.spr");
		Precache(SOUND_SPAWN);
	}

	void game_dynamically_created()
	{
		AOE_OWNER = param1;
		AOE_RADIUS = param2;
		DMG_BASE = param3;
		AOE_DURATION = param4;
		ACTIVE_SKILL = param5;
		AOE_AFFECTS_WARY = 1;
		if ((ACTIVE_SKILL).findFirst(PARAM) == 0)
		{
			ACTIVE_SKILL = "spellcasting.affliction";
		}
		ClientEvent("new", "all", "effects/sfx_cloud", GetEntityOrigin(GetOwner()), AOE_DURATION, AOE_RADIUS, Vector3(0, 255, 0), "poison_cloud.spr");
	}

	void aoe_end()
	{
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void aoe_affect_target()
	{
		ApplyEffect(param1, "effects/dot_poison", 15.0, AOE_OWNER, DMG_BASE, ACTIVE_SKILL);
	}

}

}
