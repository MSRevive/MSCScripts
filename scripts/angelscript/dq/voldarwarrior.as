#pragma context server

#include "monsters/orc_base.as"

namespace MS
{

class Voldarwarrior : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK2;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	Voldarwarrior()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 35);
		NPC_GIVE_EXP = 80;
		DROP_ITEM1 = "swords_poison1";
		DROP_ITEM1_CHANCE = 0.1;
		ANIM_ATTACK = "battleaxe_swing1_L";
		ANIM_ATTACK2 = "swordswing1_L";
		FLINCH_CHANCE = 0.55;
		const string NPC_DEATH_MSG = "You have slain one of Voldar's henchmen";
		const float ATTACK_ACCURACY = 0.8;
		const int ATTACK_DMG_LOW = 10;
		const int ATTACK_DMG_HIGH = 20;
		MOVE_RANGE = 64;
		ATTACK_RANGE = 72;
		ATTACK_HITRANGE = 128;
		const int ORC_SHIELD = 0;
	}

	void orc_spawn()
	{
		SetWidth(40);
		SetHeight(90);
	}

	void swing_axe()
	{
		baseorc_yell();
		string L_DMG = Random(ATTACK_DMG_LOW, ATTACK_DMG_HIGH);
		XDoDamage(m_hLastSeen, ATTACK_HITRANGE, L_DMG, ATTACK_ACCURACY, GetOwner(), GetOwner(), "none", "slash", "dmgevent:swing");
	}

	void swing_sword()
	{
		swing_axe();
	}

	void orc_spawn()
	{
		SetProp(GetOwner(), "skin", 3);
		SetHealth(250);
		SetWidth(32);
		SetHeight(60);
		SetName("one of|Voldar's Henchman");
		SetHearingSensitivity(8);
		SetStat("parry", 15);
		SetStat("swordsmanship", 10);
		SetDamageResistance("all", ".8");
		SetRoam(false);
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 4);
	}

	void swing_dodamage()
	{
		if (!(param1)) return;
		ApplyEffect(param2, "effects/dot_poison", 5, GetEntityIndex(GetOwner()), RandomInt(5, 10));
	}

}

}
