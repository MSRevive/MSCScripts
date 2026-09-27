#pragma context server

#include "monsters/snake_gcobra.as"

namespace MS
{

class SnakeGcobraFire : CGameScript
{
	string BREATH_EFFECT_SCRIPT;
	string CL_SCRIPT;
	string DMG_EFFECT_SCRIPT;
	int FIRE_BREATH;
	string MONSTER_MODEL;
	int NPC_BASE_EXP;
	float POISON_DAMAGE;
	float POISON_DURATION;
	int PUSH_BREATH;

	SnakeGcobraFire()
	{
		NPC_BASE_EXP = 200;
		MONSTER_MODEL = "monsters/gcobra_fire.mdl";
		DMG_EFFECT_SCRIPT = "effects/dot_fire";
		BREATH_EFFECT_SCRIPT = "effects/dot_fire";
		POISON_DAMAGE = 30.0;
		POISON_DURATION = 10.0;
		PUSH_BREATH = 1;
		CL_SCRIPT = "monsters/snake_gcobra_fire_cl";
		FIRE_BREATH = 1;
		Precache("explode1.spr");
	}

	void OnSpawn() override
	{
		SetName("Fire Cobra");
		SetDamageResistance("fire", 0.0);
	}

}

}
