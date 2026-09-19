#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class Ghorash : CGameScript
{
	string ANIM_RUN;
	float ATTACK_DAMAGE_HIGH;
	float ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	int SKEL_HP;
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;

	Ghorash()
	{
		ANIM_RUN = "run";
		SKEL_HP = 250;
		ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE_LOW = 5.5;
		ATTACK_DAMAGE_HIGH = 7.0;
		NPC_GIVE_EXP = 26;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 25;
		DROP_GOLD_MAX = 55;
		SKEL_RESPAWN_CHANCE = 0.0;
		SKEL_RESPAWN_LIVES = 0;
		Precache("monsters/skeleton_boss1.mdl");
	}

	void skeleton_spawn()
	{
		SetName("Ghor Ash");
		SetRoam(true);
		SetDamageResistance("all", ".9");
		SetModel("monsters/skeleton_boss1.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 0);
		SetHearingSensitivity(3);
		if (GetMapName() == "heras")
		{
			GiveItem(GetOwner(), "item_runicsymbol");
		}
	}

}

}
