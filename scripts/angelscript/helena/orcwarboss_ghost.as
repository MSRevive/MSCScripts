#pragma context server

#include "monsters/orc_base.as"

namespace MS
{

class OrcwarbossGhost : CGameScript
{
	string ANIM_ATTACK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int INFERNAL;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	OrcwarbossGhost()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(50, 250);
		NPC_GIVE_EXP = 200;
		ANIM_ATTACK = "battleaxe_swing1_L";
		FLINCH_CHANCE = 0.35;
		DROP_ITEM1 = "axes_greataxe";
		DROP_ITEM1_CHANCE = 1.0;
		INFERNAL = 0;
		const float ATTACK_ACCURACY = 0.8;
		const int ATTACK_DMG_LOW = 5;
		const int ATTACK_DMG_HIGH = 150;
		MOVE_RANGE = 64;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 225;
		const int ORC_SHIELD = 0;
	}

	void swing_axe()
	{
		baseorc_yell();
		string L_DMG = Random(ATTACK_DMG_LOW, ATTACK_DMG_HIGH);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, L_DMG, ATTACK_ACCURACY, "slash");
		if (INFERNAL == 1)
		{
			ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 5, GetOwner(), RandomInt(30, 60));
		}
	}

	void swing_sword()
	{
		swing_axe();
	}

	void orc_spawn()
	{
		SetHealth(1250);
		SetWidth(32);
		SetHeight(60);
		SetName("Ghost Graznux the Warboss");
		SetHearingSensitivity(8);
		SetStat("parry", 30);
		SetStat("swordsmanship", 10);
		SetDamageResistance("all", ".8");
		SetInvincible(false);
		// TODO: UNCONVERTED: rendermode	5
		// TODO: UNCONVERTED: renderamt	255
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 200);
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 5);
	}

	void warboss_godoff()
	{
		SetName("Graznux the Warboss");
		SetInvincible(false);
		SetSayTextRange(1024);
		SayText("What have you done to me!?");
	}

}

}
