#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class MorcIcewarrior : CGameScript
{
	string ANIM_ATTACK;
	float ATTACK_ACCURACY;
	int ATTACK_DMG_HIGH;
	int ATTACK_DMG_LOW;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int FX_ATK;
	int NPC_GIVE_EXP;
	string SOUND_ICEATK;

	MorcIcewarrior()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 30);
		NPC_GIVE_EXP = 120;
		DROP_ITEM1 = "swords_liceblade";
		DROP_ITEM1_CHANCE = 0.05;
		ANIM_ATTACK = "battleaxe_swing1_L";
		ATTACK_ACCURACY = 0.75;
		ATTACK_DMG_LOW = 30;
		ATTACK_DMG_HIGH = 120;
		SOUND_ICEATK = "debris/beamstart14.wav";
		Precache("monsters/morc.mdl");
	}

	void orc_spawn()
	{
		SetHealth(500);
		SetName("Marogar Ice Warrior");
		SetHearingSensitivity(5);
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("cold", 0.1);
		FX_ATK = 1;
		Precache("monsters/morc.mdl");
		SetModel("monsters/morc.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 4);
	}

	void swing_dodamage()
	{
		FX_ATK += 1;
		if (FX_ATK > 3)
		{
			FX_ATK = 1;
		}
		if (!(param1)) return;
		if (!(GetEntityRange(param2) <= ATTACK_HITRANGE)) return;
		if (!(FX_ATK == 3)) return;
		EmitSound(GetOwner(), CHAN_BODY, SOUND_ICEATK, 8);
		ApplyEffect(GetEntityIndex(param2), "effects/dot_cold", RandomInt(3, 5), GetOwner(), RandomInt(5, 10));
	}

}

}
