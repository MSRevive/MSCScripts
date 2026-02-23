#pragma context server

#include "monsters/boar.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class Snowboar2 : CGameScript
{
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_HEAR;
	int HUNT_AGRO;
	int MOVE_RANGE;

	Snowboar2()
	{
		const int NPC_BASE_EXP = 150;
		const string ANIM_FORWARD = "gore_forward2";
		const int GORE_FORWARD_DAMAGE = 16;
		const string GORE_SIDE_DAMAGE = "$rand(10,15)";
		const int BOAR_CAN_CHARGE = 1;
		const string BOAR_CHARGE_DMG = "$rand(60,150)";
		HUNT_AGRO = 1;
		CAN_HEAR = 1;
		const float FLEE_CHANCE = 0.1;
	}

	void OnSpawn() override
	{
		SetHealth(800);
		SetHeight(72);
		SetWidth(72);
		SetName("Ferocious Snow Boar");
		SetHearingSensitivity(2);
		SetModel("monsters/boar2.mdl");
		SetProp(GetOwner(), "skin", 3);
	}

	void OnPostSpawn() override
	{
		MOVE_RANGE = 64;
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 120;
	}

}

}
