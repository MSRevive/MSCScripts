#pragma context server

#include "monsters/summon/base_aoe2.as"

namespace MS
{

class CircleOfDeath : CGameScript
{
	string ACTIVE_SKILL;
	int AOE_AFFECTS_WARY;
	string AOE_DURATION;
	string AOE_OWNER;
	string AOE_RADIUS;
	int AOE_SCAN_FREQ;
	string AOE_SCAN_TYPE;
	string DMG_BASE;
	string SOUND_PULSE;

	CircleOfDeath()
	{
		SOUND_PULSE = "ambience/pulsemachine.wav";
		AOE_SCAN_TYPE = "rsphere";
		AOE_SCAN_FREQ = 1;
	}

	void game_precache()
	{
		Precache("skull.spr");
		Precache("weapons/magic/seals.mdl");
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
		EmitSound(GetOwner(), 1, SOUND_PULSE, 10);
		string L_GROUND = GetEntityOrigin(GetOwner());
		L_GROUND = "z";
		SetEntityOrigin(GetOwner(), L_GROUND);
		ClientEvent("new", "all", "monsters/summon/circle_of_death_cl", L_GROUND, AOE_DURATION);
	}

	void aoe_affect_target()
	{
		string CUR_TARG = param1;
		XDoDamage(CUR_TARG, "direct", DMG_BASE, 1.0, AOE_OWNER, GetOwner(), ACTIVE_SKILL, "magic_effect");
	}

	void aoe_end()
	{
		EmitSound(GetOwner(), 1, SOUND_PULSE, 0);
		DeleteEntity(GetOwner());
	}

}

}
