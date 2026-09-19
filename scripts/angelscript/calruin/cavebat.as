#pragma context server

#include "monsters/bat.as"

namespace MS
{

class Cavebat : CGameScript
{
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int NPC_GIVE_EXP;

	Cavebat()
	{
		ATTACK_DAMAGE = "$randf(5,15)";
	}

	void bat_spawn()
	{
		SetName("Cave bat");
		NPC_GIVE_EXP = 25;
		ATTACK_HITCHANCE = 0.85;
		SetMoveSpeed(2);
		SetWidth(16);
		SetHeight(16);
		SetHearingSensitivity(3.5);
		SetVolume(5);
		SetModel("monsters/bat.mdl");
	}

}

}
