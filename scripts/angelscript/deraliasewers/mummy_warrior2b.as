#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyWarrior2b : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int NPC_GIVE_EXP;

	MummyWarrior2b()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk2";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "steelpipe";
		const string ATTACK_TYPE = "melee";
		const int DMG_STEELPIPE = 200;
		const int MUMMY_STARTING_LIVES = 1;
		const int ATTACK_HITCHANCE = 90;
		const int DMG_FIRE_DOT = 50;
		NPC_GIVE_EXP = 3500;
	}

	void mummy_spawn()
	{
		SetName("Mummified Flameguard");
		SetHealth(9000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("fire", 0.25);
		SetDamageResistance("cold", 1.25);
		SetModelBody(0, 1);
		SetModelBody(1, 3);
		SetModelBody(2, 5);
		SetModelBody(3, 0);
		SetMoveSpeed(2.0);
		BASE_MOVESPEED = 2.0;
		SetAnimFrameRate(1.5);
		BASE_FRAMERATE = 1.5;
	}

	void steelpipe_dodamage()
	{
		if (!(param1)) return;
		ApplyEffect(param2, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DMG_FIRE_DOT);
	}

}

}
