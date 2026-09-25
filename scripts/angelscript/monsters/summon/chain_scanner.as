#pragma context server

#include "monsters/summon/base_aoe.as"

namespace MS
{

class ChainScanner : CGameScript
{
	string ACTIVE_SKILL;
	int AOE_RADIUS;
	float DAMAGE_ADJ;
	int DAMAGE_DELAY;
	int DEATH_DELAY;
	string LIGHTNING_SPRITE;
	string MY_BASE_DAMAGE;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	int SCAN_RANGE;
	string SOUND_ZAP1;
	string SOUND_ZAP2;
	string SOUND_ZAP3;
	string ZAP_SOUND_DELAY;

	ChainScanner()
	{
		SOUND_ZAP1 = "debris/beamstart14.wav";
		SOUND_ZAP2 = "debris/beamstart15.wav";
		SOUND_ZAP3 = "debris/zap1.wav";
		SCAN_RANGE = 400;
		DAMAGE_ADJ = 0.75;
		LIGHTNING_SPRITE = "lgtning.spr";
		AOE_RADIUS = 400;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		MY_BASE_DAMAGE = param2;
		MY_BASE_DAMAGE *= DAMAGE_ADJ;
		DEATH_DELAY = 0;
		ACTIVE_SKILL = "spellcasting.lightning";
		if (param3 != "PARAM3")
		{
			ACTIVE_SKILL = param3;
		}
		death_count();
	}

	void fire_bolts()
	{
		if ((DAMAGE_DELAY)) return;
		DAMAGE_DELAY = 1;
		ScheduleDelayedEvent(0.2, "reset_damage_delay");
		aoe_applyeffect_rad();
	}

	void reset_damage_delay()
	{
		DAMAGE_DELAY = 0;
	}

	void apply_aoe_effect()
	{
		string TARG_ORG = GetEntityOrigin(param1);
		string MY_ORG = GetEntityOrigin(MY_OWNER);
		string TRACE_LINE = TraceLine(MY_ORG, TARG_ORG);
		if (!(TRACE_LINE == TARG_ORG)) return;
		if (!(ZAP_SOUND_DELAY))
		{
			ZAP_SOUND_DELAY = 1;
			// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
			array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			ScheduleDelayedEvent(0.25, "zap_sound_reset");
		}
		ClientEvent("new", "all_in_sight", "monsters/summon/chain_scanner_cl", GetEntityIndex(MY_OWNER), GetEntityIndex(param1));
		string MY_FINAL_DAMAGE = MY_BASE_DAMAGE;
		MY_FINAL_DAMAGE *= DAMAGE_ADJ;
		XDoDamage(GetEntityIndex(param1), "direct", MY_BASE_DAMAGE, 100, MY_OWNER, MY_OWNER, ACTIVE_SKILL, "lightning");
	}

	void zap_sound_reset()
	{
		ZAP_SOUND_DELAY = 0;
	}

	void heart_beat()
	{
		SetEntityOrigin(GetOwner(), GetEntityOrigin(MY_OWNER));
		DEATH_DELAY = 0;
	}

	void death_count()
	{
		ScheduleDelayedEvent(1.0, "death_count");
		DEATH_DELAY += 1;
		if (!(DEATH_DELAY > 10)) return;
		DeleteEntity(GetOwner());
	}

}

}
