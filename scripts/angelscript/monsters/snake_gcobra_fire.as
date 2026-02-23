#pragma context server

#include "monsters/snake_gcobra.as"

namespace MS
{

class SnakeGcobraFire : CGameScript
{
	SnakeGcobraFire()
	{
		const int NPC_BASE_EXP = 200;
		const string MONSTER_MODEL = "monsters/gcobra_fire.mdl";
		const string DMG_EFFECT_SCRIPT = "effects/dot_fire";
		const string BREATH_EFFECT_SCRIPT = "effects/dot_fire";
		const float POISON_DAMAGE = 30.0;
		const float POISON_DURATION = 10.0;
		const int PUSH_BREATH = 1;
		const string CL_SCRIPT = "monsters/snake_gcobra_fire_cl";
		const int FIRE_BREATH = 1;
		Precache("explode1.spr");
	}

	void OnSpawn() override
	{
		SetName("Fire Cobra");
		SetDamageResistance("fire", 0.0);
	}

}

}
