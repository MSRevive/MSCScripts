#pragma context server

#include "monsters/skeleton_ravager.as"

namespace MS
{

class SkeletonRavagerFire : CGameScript
{
	string CLAWFX_COLOR;
	string DMG_CLAW_EFFECT;
	int DMG_CLAW_EFFECT_DOT;
	float DMG_CLAW_EFFECT_DUR;
	int DMG_PROJECTILE;
	float FREQ_PROJECTILE;
	string MONSTER_MODEL;
	int NPC_BASE_EXP;
	string PROJECTILE_SCRIPT;
	int PROJECTILE_SPEED;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_PROJECTILE;
	int USES_PROJECTILE;

	SkeletonRavagerFire()
	{
		NPC_BASE_EXP = 600;
		USES_PROJECTILE = 1;
		PROJECTILE_SCRIPT = "proj_fire_ball";
		FREQ_PROJECTILE = Random(5.0, 10.0);
		DMG_PROJECTILE = 400;
		PROJECTILE_SPEED = 400;
		SOUND_PROJECTILE = "magic/fireball_strike.wav";
		DMG_CLAW_EFFECT = "effects/dot_fire";
		DMG_CLAW_EFFECT_DUR = 5.0;
		DMG_CLAW_EFFECT_DOT = 100;
		CLAWFX_COLOR = Vector3(255, 64, 0);
		MONSTER_MODEL = "monsters/skeleton_ravenous_ele.mdl";
		SOUND_ALERT1 = "monsters/undeadz/c_skeltwar_bat1.wav";
		SOUND_ALERT2 = "monsters/undeadz/c_skeltwar_bat1.wav";
	}

	void skele_spawn()
	{
		SetName("Redboned Ravager");
		SetModelBody(0, 0);
		SetModel(MONSTER_MODEL);
		SetHealth(4000);
		SetWidth(32);
		SetHeight(72);
		SetRace("undead");
		SetBloodType("none");
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("blunt", 1.5);
		SetDamageResistance("slash", 1.0);
		SetDamageResistance("pierce", 0.75);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("cold", 1.0);
		SetDamageResistance("holy", 2.0);
		SetRoam(true);
		SetHearingSensitivity(4);
	}

	void npc_adjust_projectile()
	{
		CallExternal("ent_lastprojectile", "lighten", DMG_CLAW_EFFECT_DOT, 0.0);
	}

}

}
