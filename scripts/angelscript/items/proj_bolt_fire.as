#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltFire : CGameScript
{
	string BOLT_DAMAGE;
	int DID_SPLODIE;
	string DIRECT_HIT;
	string MY_OWNER;
	string MY_START_ANG;
	string MY_XBOW;
	string START_TRACE;
	string TRACE_END;

	ProjBoltFire()
	{
		const int HITSCAN_BOLT = 1;
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const string SOUND_HITWALL1 = "weapons/bow/arrowhit1.wav";
		const string SOUND_HITWALL2 = "weapons/bow/arrowhit1.wav";
		const int MODEL_BODY_OFS = 49;
		const int ARROW_BODY_OFS = 49;
		const int PROJ_DAMAGE_AOE_RANGE = 250;
		const string PROJ_DAMAGE_TYPE = "fire";
		const string PROJ_ANIM_IDLE = "none";
		const int PROJ_IGNORENPC = 1;
		const string PROJ_DAMAGE = RandomInt(400, 500);
		const int PROJ_STICK_DURATION = 1;
		const int ARROW_SOLIDIFY_ON_WALL = 1;
		const float ARROW_BREAK_CHANCE = 1.0;
	}

	void arrow_spawn()
	{
		SetName("Dwarven Bolt");
		SetDescription("An awkward bolt made by the dwarves. "Handle with care"");
		SetWeight(0.2);
		SetSize(1);
		SetValue(500);
		SetGravity(0);
		SetGroupable(25);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", "expbolt");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
	}

	void hitscan_bolt()
	{
		MY_OWNER = GetEntityIndex("ent_expowner");
		MY_XBOW = GetActiveItem(MY_OWNER);
		BOLT_DAMAGE = GetSkillLevel(MY_OWNER, "archery");
		BOLT_DAMAGE *= 0.01;
		BOLT_DAMAGE *= PROJ_DAMAGE;
		string DMG_MULTI = GetEntityProperty(MY_XBOW, "scriptvar");
		if (DMG_MULTI > 0)
		{
			BOLT_DAMAGE *= DMG_MULTI;
		}
		START_TRACE = GetEntityOrigin(GetOwner());
		string V_MY_DEST = /* TODO: $relpos */ $relpos(Vector3(/* TODO: $neg */ $neg(GetMonsterProperty("angles.pitch")), GetMonsterProperty("angles.yaw"), GetMonsterProperty("angles.roll")), Vector3(0, 8000, 0));
		string MY_DEST = START_TRACE;
		MY_DEST += V_MY_DEST;
		MY_START_ANG = GetEntityAngles(GetOwner());
		SetProp(GetOwner(), "avelocity", 0);
		SetProp(GetOwner(), "velocity", 0);
		SetProp(GetOwner(), "movetype", 0);
		if ((G_DEVELOPER_MODE))
		{
			Effect("beam", "point", "lgtning.spr", 20, START_TRACE, MY_DEST, Vector3(255, 0, 255), 200, 0, 1.0);
		}
		XDoDamage(START_TRACE, MY_DEST, 0, 1.0, MY_OWNER, GetOwner(), "none", "target", "dmgevent:*boltscan");
	}

	void go_splodie()
	{
		if ((DID_SPLODIE)) return;
		// TODO: movetype none
		SetEntityOrigin(GetOwner(), TRACE_END);
		DID_SPLODIE = 1;
		// PlayRandomSound from: "weapons/explode3.wav"
		array<string> sounds = {"weapons/explode3.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		// TODO: UNCONVERTED: attachlight torch
		// TODO: UNCONVERTED: attachsprite explode1.spr trans 12 1.5
		SetExpireTime(1);
	}

	void boltscan_dodamage()
	{
		if ((IsEntityAlive(param2)))
		{
			TRACE_END = GetEntityOrigin(param2);
			DIRECT_HIT = 1;
		}
		else
		{
			string L_END = param4;
			string L_TRACE = TraceLine(START_TRACE, L_END);
			TRACE_END = L_TRACE;
		}
		LogDebug("boltscan_dodamage TRACE_END GetEntityName(param2)");
		if ((G_DEVELOPER_MODE))
		{
			string L_TRACE_END = TRACE_END;
			L_TRACE_END += "z";
			Effect("beam", "point", "lgtning.spr", 20, TRACE_END, L_TRACE_END, Vector3(255, 0, 0), 200, 0, 5.0);
			string L_END = param4;
			L_END += "z";
			Effect("beam", "point", "lgtning.spr", 20, param4, L_END, Vector3(0, 0, 255), 200, 0, 5.0);
		}
		ScheduleDelayedEvent(0.1, "splode_dmg");
	}

	void splode_dmg()
	{
		XDoDamage(TRACE_END, 128, BOLT_DAMAGE, 0.5, MY_OWNER, GetOwner(), "archery", PROJ_DAMAGE_TYPE, "dmgevent:*bolt");
		SetEntityOrigin(GetOwner(), TRACE_END);
		ScheduleDelayedEvent(0.1, "go_splodie");
	}

	void bolt_dodamage()
	{
		if ((IsEntityAlive(param2)))
		{
			LogDebug("bolt_dodamage_npc GetEntityOrigin(param2)");
			if ((param1))
			{
			}
			string HIT_TARG = param2;
			if (GetEntityMaxHealth(HIT_TARG) < 1000)
			{
			}
			if (GetEntityRace(HIT_TARG) != "human")
			{
			}
			if (GetEntityRace(HIT_TARG) != "hguard")
			{
			}
			string TARG_ORG = GetEntityOrigin(HIT_TARG);
			string NEW_YAW = /* TODO: $angles */ $angles(TRACE_END, TARG_ORG);
			if (!(DIRECT_HIT))
			{
				AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(10, 400, 600)));
			}
			else
			{
				AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(10, -400, 600)));
			}
		}
	}

	void game_fall()
	{
		LogDebug("game_fall MODEL_BODY_OFS MODEL_WORLD");
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void game_tossprojectile()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
	}

}

}
