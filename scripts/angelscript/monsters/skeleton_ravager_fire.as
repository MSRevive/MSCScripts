#pragma context server

#include "monsters/skeleton_ravager.as"

namespace MS
{

class SkeletonRavagerFire : CGameScript
{
	SkeletonRavagerFire()
	{
		const int NPC_BASE_EXP = 600;
		const int USES_PROJECTILE = 1;
		const string PROJECTILE_SCRIPT = "proj_fire_ball";
		const string FREQ_PROJECTILE = Random(5.0, 10.0);
		const int DMG_PROJECTILE = 400;
		const int PROJECTILE_SPEED = 400;
		const string SOUND_PROJECTILE = "magic/fireball_strike.wav";
		const string DMG_CLAW_EFFECT = "effects/dot_fire";
		const float DMG_CLAW_EFFECT_DUR = 5.0;
		const int DMG_CLAW_EFFECT_DOT = 100;
		const Vector3 CLAWFX_COLOR = Vector3(255, 64, 0);
		const string MONSTER_MODEL = "monsters/skeleton_ravenous_ele.mdl";
		const string SOUND_ALERT1 = "monsters/undeadz/c_skeltwar_bat1.wav";
		const string SOUND_ALERT2 = "monsters/undeadz/c_skeltwar_bat1.wav";
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
