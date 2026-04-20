#pragma context server

#include "monsters/orc_base.as"
#include "monsters/orc_base_melee.as"

namespace MS
{

class OrcChief : CGameScript
{
	string ANIM_ATTACK;
	float ATTACK_ACCURACY;
	int ATTACK_DMG_HIGH;
	int ATTACK_DMG_LOW;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int ATTAKC_MOVERANGE;
	string DROP_ITEM1;
	string DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int INFERNAL;
	int MOVE_RANGE;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int OVERRIDE_NODROP;
	string WARBOSS_VALID_MAP;

	OrcChief()
	{
		OVERRIDE_NODROP = 1;
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_RESTORATION = 0.5;
		ANIM_ATTACK = "battleaxe_swing1_L";
		FLINCH_CHANCE = 0.35;
		INFERNAL = 0;
		ATTACK_ACCURACY = 0.8;
		ATTACK_DMG_LOW = 75;
		ATTACK_DMG_HIGH = 650;
		MOVE_RANGE = 64;
		ATTAKC_MOVERANGE = 64;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 225;
	}

	void orc_spawn()
	{
		SetHealth(3000);
		SetWidth(38);
		SetHeight(72);
		NPC_GIVE_EXP = 750;
		SetName("Orc Warlord");
		string L_MAP_NAME = StringToLower(GetMapName());
		if (StringToLower(GetMapName()) == "ara")
		{
			NPC_GIVE_EXP = 1000;
			WARBOSS_VALID_MAP = 1;
			DROP_ITEM1 = "axes_greataxe";
			DROP_ITEM1_CHANCE = 50;
		}
		else
		{
			if (L_MAP_NAME == "foutpost")
			{
				DROP_ITEM2 = "item_warbosshead";
				DROP_ITEM2_CHANCE = 1.0;
				WARBOSS_VALID_MAP = 1;
				DROP_ITEM1 = "axes_greataxe";
				DROP_ITEM1_CHANCE = 50;
			}
			else
			{
				if (L_MAP_NAME == "orcplace2_beta")
				{
					WARBOSS_VALID_MAP = 1;
					DROP_ITEM1 = "axes_greataxe";
					DROP_ITEM1_CHANCE = 50;
				}
				else
				{
					if (L_MAP_NAME == "old_helena")
					{
						WARBOSS_VALID_MAP = 1;
						IS_OLD_HELENA = 1;
						NPC_GIVE_EXP = 10000;
					}
				}
			}
		}
		if ((WARBOSS_VALID_MAP))
		{
			SetName("Graznux the Warboss");
			NPC_IS_BOSS = 1;
		}
		SetHearingSensitivity(8);
		SetStat("parry", 90);
		SetDamageResistance("all", ".8");
		SetInvincible(false);
		SetModel("monsters/orc_big.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 5);
	}

	void swing_axe()
	{
		if (INFERNAL == 1)
		{
			ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 5, GetOwner(), RandomInt(30, 60));
		}
	}

	void godon_warboss()
	{
		SetName("Graznux the Invincible!");
		PlayAnim("critical", "warcry");
		SetInvincible(true);
		SetSayTextRange(1024);
		SayText("You fools! Now nothing can stop me!");
	}

	void offgod_warboss()
	{
		SetName("Graznux the Warboss");
		SetInvincible(false);
		SetSayTextRange(1024);
		SayText("Noooo! My power!");
	}

	void infernal_warboss()
	{
		SetName("Graznux the Infernal");
		PlayAnim("critical", "warcry");
		SetRace("demon");
		INFERNAL = 1;
		SetSayTextRange(1024);
		SayText("Feel the fire of my rage! Muahahahaaa!");
		ApplyEffect(GetOwner(), "effects/dot_fire", 60, GetOwner(), 0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("holy", 4.0);
	}

	void normal_warboss()
	{
		SetName("Graznux the Warboss");
		SetRace("orc");
		INFERNAL = 0;
		SetSayTextRange(1024);
		SayText("What? No! The hellfire has abandoned me!");
		SetDamageResistance("fire", 1.0);
		SetDamageResistance("holy", 0.0);
	}

	void turn_undead()
	{
		if (!(INFERNAL)) return;
		string INC_HOLY_DMG = param1;
		string THE_EXCORCIST = param2;
		string ME_ME = GetEntityIndex(GetOwner());
		npcatk_dodamage(ME_ME, "direct", INC_HOLY_DMG, 100, THE_EXCORCIST);
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 512, 1, 1);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetGlobalVar("WARBOSS_DEAD", 1);
		if ((WARBOSS_VALID_MAP))
		{
			if (!(IS_OLD_HELENA))
			{
			}
			bm_gold_spew(25, 2, 64, 8, 24);
		}
		if (!(WARBOSS_VALID_MAP))
		{
			bm_gold_spew(10, 3, 64, 4, 16);
		}
		if ((IS_OLD_HELENA))
		{
			SetGlobalVar("G_WARBOSS_ORIGIN", GetEntityOrigin(GetOwner()));
			CallExternal("all", "old_helena_warboss_died");
		}
	}

}

}
