#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummySlave : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float FLINCH_HEALTH_RATIO;
	int NPC_GIVE_EXP;

	MummySlave()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk2";
		ANIM_IDLE = "idle1";
		NPC_GIVE_EXP = 300;
		ANIM_ATTACK = "stab1";
		FLINCH_HEALTH_RATIO = 0.5;
		const float AS_STUCK_FREQ = 0.5;
		const string ATTACK_TYPE = "unarmed";
		const int ATTACK_HITCHANCE = 80;
		const int DMG_SLASH = 100;
		const string MUMMY_STARTING_LIVES = RandomInt(1, 4);
		const int MUMMY_MUNCHES = 1;
	}

	void mummy_spawn()
	{
		SetName("Mummified Slave");
		SetHealth(1000);
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
		SetModelBody(3, 0);
		SetDamageResistance("holy", 1.5);
	}

}

}
