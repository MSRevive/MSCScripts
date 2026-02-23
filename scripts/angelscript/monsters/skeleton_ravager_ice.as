#pragma context server

#include "monsters/skeleton_ravager.as"

namespace MS
{

class SkeletonRavagerIce : CGameScript
{
	int PASS_FREEZE_DMG;
	float PASS_FREEZE_DUR;

	SkeletonRavagerIce()
	{
		const int NPC_BASE_EXP = 600;
		const int USES_PROJECTILE = 1;
		const string PROJECTILE_SCRIPT = "proj_freezing_sphere";
		const string FREQ_PROJECTILE = Random(5.0, 10.0);
		const int DMG_PROJECTILE = 200;
		const int PROJECTILE_SPEED = 150;
		const string SOUND_PROJECTILE = "none";
		PASS_FREEZE_DMG = 50;
		PASS_FREEZE_DUR = 5.0;
		const Vector3 CLAWFX_COLOR = Vector3(128, 128, 255);
		const string DMG_CLAW_EFFECT = "effects/dot_cold";
		const float DMG_CLAW_EFFECT_DUR = 5.0;
		const int DMG_CLAW_EFFECT_DOT = 75;
		const string MONSTER_MODEL = "monsters/skeleton_ravenous_ele.mdl";
		const string SOUND_ALERT1 = "monsters/undeadz/c_skeltwar_bat1.wav";
		const string SOUND_ALERT2 = "monsters/undeadz/c_skeltwar_bat1.wav";
	}

	void skele_spawn()
	{
		SetName("Iceboned Ravager");
		SetModelBody(0, 1);
		SetModel(MONSTER_MODEL);
		SetHealth(4000);
		SetWidth(32);
		SetHeight(72);
		SetRace("undead");
		SetBloodType("none");
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("blunt", 1.5);
		SetDamageResistance("slash", 1.0);
		SetDamageResistance("pierce", 0.75);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("holy", 2.0);
		SetRoam(true);
		SetHearingSensitivity(4);
	}

}

}
