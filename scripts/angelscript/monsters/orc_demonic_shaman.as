#pragma context server

#include "monsters/orc_shaman_fire.as"

namespace MS
{

class OrcDemonicShaman : CGameScript
{
	int DMG_DEATH_BURST;
	int DOT_DMG;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string FIRE_BALL_DAMAGE;
	int FIRE_BALL_DAMAGE_ALT;
	int FIRE_BALL_DAMAGE_NORM;
	int FIRE_BALL_DELAY;
	int IS_UNHOLY;
	string MY_CL_SCRIPT_IDX;
	int NPC_GIVE_EXP;
	int ORC_SHAMAN_CUSTOM_DEATH;
	int ORC_SHAMAN_CUSTOM_FIREBALL;
	string PROJECTILE_SCRIPT;
	string PROJ_ELEMENT_TARGET;
	string PROJ_ELEMENT_TYPE;
	string SOUND_DEATH;
	string SPLODIE_TARGS;

	OrcDemonicShaman()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(50, 100);
		NPC_GIVE_EXP = 300;
		FIRE_BALL_DAMAGE_NORM = "$rand(100,150)";
		FIRE_BALL_DAMAGE_ALT = "$rand(5,10)";
		DOT_DMG = 50;
		DMG_DEATH_BURST = 400;
		ORC_SHAMAN_CUSTOM_DEATH = 1;
		ORC_SHAMAN_CUSTOM_FIREBALL = 1;
		PROJECTILE_SCRIPT = "proj_elemental_guided";
		PROJ_ELEMENT_TYPE = "fire_jet";
		SOUND_DEATH = "weapons/explode3.wav";
	}

	void game_precache()
	{
		Precache("xfireball3.spr");
		Precache("fleshgibs.mdl");
		Precache("magic/sps_fogfire.wav");
		Precache("weapons/explode3.wav");
		Precache("effects/sfx_explode");
	}

	void orc_spawn()
	{
		SetHealth(420);
		SetName("Demonic Orc Fire Shaman");
		SetProp(GetOwner(), "skin", 2);
		SetWidth(32);
		SetHeight(60);
		SetHearingSensitivity(8);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("holy", 0.5);
		IS_UNHOLY = 1;
		FIRE_BALL_DAMAGE = FIRE_BALL_DAMAGE_NORM;
		ClientEvent("persist", "all", FIRE_FIST_SCRIPT, GetEntityIndex(GetOwner()), 19);
		MY_CL_SCRIPT_IDX = "game.script.last_sent_id";
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
	}

	void ext_proj_elemental_hit()
	{
		XDoDamage(param1, 128, FIRE_BALL_DAMAGE, 0, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:fireburst");
	}

	void fireburst_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = ARROW_ORG;
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 500, 110)));
	}

	void orc_shaman_death()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		ClientEvent("remove", "all", MY_CL_SCRIPT_IDX);
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 256, DMG_DEATH_BURST, 0.1, GetOwner(), GetOwner(), "none", "generic");
		ClientEvent("new", "all", "effects/sfx_explode", GetEntityOrigin(GetOwner()), 256);
		Effect("tempent", "gibs", "fleshgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1.0, 50, 50, 15, 10.0);
		SPLODIE_TARGS = FindEntitiesInSphere("enemy", 256);
		if (!(SPLODIE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(SPLODIE_TARGS, ";"); i++)
		{
			splodie_affect_targets();
		}
	}

	void splodie_affect_targets()
	{
		string CUR_TARG = GetToken(SPLODIE_TARGS, i, ";");
		if (GetRelationship(CUR_TARG) == "enemy")
		{
			ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
		}
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void throw_fireball()
	{
		FIRE_BALL_FREQ("reset_fireball");
		FIRE_BALL_DELAY = 1;
		EmitSound(GetOwner(), 0, SOUND_FIRESHOOT, 10);
		PROJ_ELEMENT_TARGET = m_hAttackTarget;
		TossProjectile(PROJECTILE_SCRIPT, /* TODO: $relpos */ $relpos(0, 48, 18), m_hAttackTarget, ATTACK_SPEED, FIRE_BALL_DAMAGE, ATTACK_CONE_OF_FIRE, "none");
	}

}

}
