#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyWarrior1 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float BASE_MOVESPEED;
	int MUMMY_DMG_STEELPIPE;
	string MUMMY_MELEE_DMG_TYPE_FINAL;
	float MUMMY_STUN_CHANCE;
	int NPC_GIVE_EXP;

	MummyWarrior1()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk2";
		ANIM_IDLE = "idle1";
		ANIM_DEATH = "dieforward";
		ANIM_ATTACK = "steelpipe";
		const string ATTACK_TYPE = "melee";
		const int ATTACK_HITCHANCE = 80;
		const int DMG_SLASH = 100;
		const int MUMMY_STARTING_LIVES = 1;
	}

	void mummy_spawn()
	{
		SetName("Mummified Slave Driver");
		SetDamageResistance("all", 0.75);
		if (!(MUMMY_WEAPON_OVERRIDE))
		{
			string RND_WEAPON = RandomInt(1, 3);
		}
		else
		{
			string RND_WEAPON = MUMMY_WEAPON_OVERRIDE;
		}
		SetModelBody(0, 0);
		SetModelBody(1, 3);
		SetModelBody(2, RND_WEAPON);
		SetModelBody(3, 0);
		if (RND_WEAPON == 1)
		{
			setup_mummy_mace();
		}
		if (RND_WEAPON == 2)
		{
			setup_mummy_axe();
		}
		if (RND_WEAPON == 3)
		{
			setup_mummy_sword();
		}
		SetMoveSpeed(2.0);
		BASE_MOVESPEED = 2.0;
	}

	void setup_mummy_mace()
	{
		ANIM_ATTACK = "steelpipe";
		MUMMY_MELEE_DMG_TYPE_FINAL = "blunt";
		MUMMY_DMG_STEELPIPE = 200;
		MUMMY_STUN_CHANCE = 0.2;
		SetHealth(3000);
		NPC_GIVE_EXP = 1000;
		SetModelBody(2, 1);
	}

	void setup_mummy_axe()
	{
		ANIM_ATTACK = "steelpipe";
		MUMMY_MELEE_DMG_TYPE_FINAL = "slash";
		MUMMY_DMG_STEELPIPE = 300;
		SetHealth(3500);
		NPC_GIVE_EXP = 1000;
		SetModelBody(2, 2);
	}

	void setup_mummy_sword()
	{
		ANIM_ATTACK = "steelpipe";
		MUMMY_MELEE_DMG_TYPE_FINAL = "slash";
		MUMMY_DMG_STEELPIPE = 400;
		SetHealth(2500);
		NPC_GIVE_EXP = 1000;
		SetModelBody(2, 3);
	}

	void game_dynamically_created()
	{
		if (param1 == 1)
		{
			setup_mummy_mace();
		}
		if (param1 == 2)
		{
			setup_mummy_axe();
		}
		if (param1 == 3)
		{
			setup_mummy_sword();
		}
	}

}

}
