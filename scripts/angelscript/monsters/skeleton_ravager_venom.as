#pragma context server

#include "monsters/skeleton_ravager.as"

namespace MS
{

class SkeletonRavagerVenom : CGameScript
{
	string BLOB_ORG;
	string CLAWFX_COLOR;
	string DMG_CLAW_EFFECT;
	int DMG_CLAW_EFFECT_DOT;
	float DMG_CLAW_EFFECT_DUR;
	int DMG_PROJECTILE;
	float FREQ_PROJECTILE;
	string GLOB_TARG;
	string MONSTER_MODEL;
	int NPC_BASE_EXP;
	int PASS_FREEZE_DMG;
	float PASS_FREEZE_DUR;
	string PROJECTILE_SCRIPT;
	int PROJECTILE_SPEED;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_PROJECTILE;
	int USES_PROJECTILE;

	SkeletonRavagerVenom()
	{
		NPC_BASE_EXP = 600;
		USES_PROJECTILE = 1;
		PROJECTILE_SCRIPT = "proj_glob_guided";
		FREQ_PROJECTILE = Random(5.0, 10.0);
		DMG_PROJECTILE = 200;
		PROJECTILE_SPEED = 200;
		SOUND_PROJECTILE = "bullchicken/bc_attack3.wav";
		PASS_FREEZE_DMG = 50;
		PASS_FREEZE_DUR = 5.0;
		CLAWFX_COLOR = Vector3(0, 255, 0);
		DMG_CLAW_EFFECT = "effects/dot_poison";
		DMG_CLAW_EFFECT_DUR = 10.0;
		DMG_CLAW_EFFECT_DOT = 50;
		MONSTER_MODEL = "monsters/skeleton_ravenous_ele.mdl";
		SOUND_ALERT1 = "monsters/undeadz/c_skeltwar_bat1.wav";
		SOUND_ALERT2 = "monsters/undeadz/c_skeltwar_bat1.wav";
	}

	void skele_spawn()
	{
		SetName("Venomboned Ravager");
		SetModelBody(0, 2);
		SetModel(MONSTER_MODEL);
		SetHealth(4000);
		SetWidth(32);
		SetHeight(72);
		SetRace("undead");
		SetBloodType("none");
		SetDamageResistance("fire", 1.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("blunt", 1.5);
		SetDamageResistance("slash", 1.0);
		SetDamageResistance("pierce", 0.75);
		SetDamageResistance("lightning", 1.5);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("holy", 2.0);
		SetRoam(true);
		SetHearingSensitivity(4);
	}

	void ext_glob_landed()
	{
		BLOB_ORG = param1;
		XDoDamage(param1, 96, DMG_GLOB, 0.2, GetOwner(), GetOwner(), "none", "acid_effect", "dmgevent:glob");
	}

	void glob_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		string TARG_ORG = GetEntityOrigin(param2);
		float BLOB_DIST = Distance(BLOB_ORG, TARG_ORG);
		BLOB_DIST /= 64;
		int BLOB_DIST_RATIO = 1;
		BLOB_DIST_RATIO -= BLOB_DIST;
		string BLIND_DURATION = /* TODO: $ratio */ $ratio(BLOB_DIST_RATIO, 2.0, 6.0);
		LogDebug("glob_dodamage BLIND_DURATION");
		ApplyEffect(param2, "effects/dot_poison_blind", BLIND_DURATION, GetEntityIndex(GetOwner()), DMG_CLAW_EFFECT_DOT);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		GLOB_TARG = m_hAttackTarget;
	}

}

}
