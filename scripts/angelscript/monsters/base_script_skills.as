#pragma context server

namespace MS
{

class BaseScriptSkills : CGameScript
{
	string FOUND_EMPTY_SLOT;
	string NPC_ADJUSTED_DMG;
	int NPC_HITDATA_ARCHERY;
	int NPC_HITDATA_AXEHANDLING;
	string NPC_HITDATA_DMG;
	string NPC_HITDATA_IDS;
	string NPC_HITDATA_INIT_SKILLS;
	int NPC_HITDATA_MARTIALARTS;
	int NPC_HITDATA_SMALLARMS;
	int NPC_HITDATA_SPELLS_AFFLICTION;
	int NPC_HITDATA_SPELLS_DIVINATION;
	int NPC_HITDATA_SPELLS_EARTH;
	int NPC_HITDATA_SPELLS_FIRE;
	int NPC_HITDATA_SPELLS_ICE;
	int NPC_HITDATA_SPELLS_LIGHTNING;
	int NPC_HITDATA_SPELLS_SUMMON;
	int NPC_HITDATA_SWORDSMANSHIP;
	string NPC_SKILLS_LIST;
	string NPC_TOTAL_DAMAGE;
	string OUT_IDX;
	string PLAYER_HITDATA_SKILLS_0;
	string PLAYER_HITDATA_SKILLS_1;
	string PLAYER_HITDATA_SKILLS_2;
	string PLAYER_HITDATA_SKILLS_3;
	string PLAYER_HITDATA_SKILLS_4;
	string PLAYER_HITDATA_SKILLS_5;
	string PLAYER_HITDATA_SKILLS_6;
	string PLAYER_HITDATA_SKILLS_7;
	string PLAYER_HITDATA_SKILLS_8;
	string PLAYER_HITDATA_SKILLS_9;
	string TOTAL_XP_TO_GIVE;
	string T_SKILL_LIST;

	BaseScriptSkills()
	{
		NPC_HITDATA_SWORDSMANSHIP = 0;
		NPC_HITDATA_MARTIALARTS = 1;
		NPC_HITDATA_AXEHANDLING = 2;
		NPC_HITDATA_SMALLARMS = 3;
		NPC_HITDATA_ARCHERY = 4;
		NPC_HITDATA_SPELLS_FIRE = 5;
		NPC_HITDATA_SPELLS_ICE = 6;
		NPC_HITDATA_SPELLS_LIGHTNING = 7;
		NPC_HITDATA_SPELLS_EARTH = 8;
		NPC_HITDATA_SPELLS_SUMMON = 9;
		NPC_HITDATA_SPELLS_DIVINATION = 10;
		NPC_HITDATA_SPELLS_AFFLICTION = 11;
		NPC_HITDATA_INIT_SKILLS = "0;0;0;0;0;0;0;0;0;0;0;0";
		NPC_SKILLS_LIST = "swordsmanship;martialarts;axehandling;bluntarms;smallarms;archery;spellcasting.fire;spellcasting.ice;spellcasting.lightning;spellcasting.earth;spellcasting.summon;spellcasting.divination;spellcasting.affliction";
	}

	void OnSpawn() override
	{
		NPC_HITDATA_IDS = "";
		NPC_HITDATA_DMG = "";
		NPC_TOTAL_DAMAGE = "";
	}

	void OnDamage(int damage) override
	{
		string PLR_ATTACKER = param1;
		string INC_DMG = param2;
		string INC_DMG_TYPE = param3;
		string ACC_ROLL = param4;
		string SKILL_TYPE = param5;
		NPC_ADJUSTED_DMG = INC_DMG;
		npc_resist_damage(PLR_ATTACKER, INC_DMG, INC_DMG_TYPE);
		string INC_DMG = NPC_ADJUSTED_DMG;
		if (!(SKILL_TYPE != "none")) return;
		if (!(INC_DMG > 0)) return;
		if (!(IsValidPlayer(PLR_ATTACKER))) return;
		string PLAYER_HITDATA_IDX = FindToken(NPC_HITDATA_IDS, PLR_ATTACKER, ";");
		if (PLAYER_HITDATA_IDX == -1)
		{
			string PLAYER_HITDATA_IDX = GetTokenCount(NPC_HITDATA_IDS, ";");
			if (PLAYER_HITDATA_IDX > 15)
			{
				for (int i = 0; i < PLAYER_HITDATA_IDX; i++)
				{
					npcexp_drop_exp_counter();
				}
				FOUND_EMPTY_SLOT = -1;
				for (int i = 0; i < PLAYER_HITDATA_IDX; i++)
				{
					npcexp_find_empty_slot();
				}
			}
			if (PLAYER_HITDATA_IDX >= 10)
			{
				SendPlayerMessage(PLR_ATTACKER, "XP Sys Warning: " + GetEntityName(GetOwner()) + "cannot find anymore " + XP + " slots");
			}
			if (PLAYER_HITDATA_IDX < 10)
			{
			}
			if (NPC_HITDATA_IDS.length() > 0) NPC_HITDATA_IDS += ";";
			NPC_HITDATA_IDS += PLR_ATTACKER;
		}
		string SKILL_IDX = FindToken(NPC_SKILLS_LIST, SKILL_TYPE, ";");
		if (PLAYER_HITDATA_IDX == 0)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_0, SKILL_IDX, ";");
		}
		if (PLAYER_HITDATA_IDX == 1)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_1, SKILL_IDX, ";");
		}
		if (PLAYER_HITDATA_IDX == 2)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_2, SKILL_IDX, ";");
		}
		if (PLAYER_HITDATA_IDX == 3)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_3, SKILL_IDX, ";");
		}
		if (PLAYER_HITDATA_IDX == 4)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_4, SKILL_IDX, ";");
		}
		if (PLAYER_HITDATA_IDX == 5)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_5, SKILL_IDX, ";");
		}
		if (PLAYER_HITDATA_IDX == 6)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_6, SKILL_IDX, ";");
		}
		if (PLAYER_HITDATA_IDX == 7)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_7, SKILL_IDX, ";");
		}
		if (PLAYER_HITDATA_IDX == 8)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_8, SKILL_IDX, ";");
		}
		if (PLAYER_HITDATA_IDX == 9)
		{
			string GET_AMT = GetToken(PLAYER_HITDATA_SKILLS_9, SKILL_IDX, ";");
		}
		GET_AMT += INC_DMG;
		if (PLAYER_HITDATA_IDX == 0)
		{
			SetToken(PLAYER_HITDATA_SKILLS_0, SKILL_IDX, GET_AMT, ";");
		}
		if (PLAYER_HITDATA_IDX == 1)
		{
			SetToken(PLAYER_HITDATA_SKILLS_1, SKILL_IDX, GET_AMT, ";");
		}
		if (PLAYER_HITDATA_IDX == 2)
		{
			SetToken(PLAYER_HITDATA_SKILLS_2, SKILL_IDX, GET_AMT, ";");
		}
		if (PLAYER_HITDATA_IDX == 3)
		{
			SetToken(PLAYER_HITDATA_SKILLS_3, SKILL_IDX, GET_AMT, ";");
		}
		if (PLAYER_HITDATA_IDX == 4)
		{
			SetToken(PLAYER_HITDATA_SKILLS_4, SKILL_IDX, GET_AMT, ";");
		}
		if (PLAYER_HITDATA_IDX == 5)
		{
			SetToken(PLAYER_HITDATA_SKILLS_5, SKILL_IDX, GET_AMT, ";");
		}
		if (PLAYER_HITDATA_IDX == 6)
		{
			SetToken(PLAYER_HITDATA_SKILLS_6, SKILL_IDX, GET_AMT, ";");
		}
		if (PLAYER_HITDATA_IDX == 7)
		{
			SetToken(PLAYER_HITDATA_SKILLS_7, SKILL_IDX, GET_AMT, ";");
		}
		if (PLAYER_HITDATA_IDX == 8)
		{
			SetToken(PLAYER_HITDATA_SKILLS_8, SKILL_IDX, GET_AMT, ";");
		}
		if (PLAYER_HITDATA_IDX == 9)
		{
			SetToken(PLAYER_HITDATA_SKILLS_9, SKILL_IDX, GET_AMT, ";");
		}
		string GET_TOTAL_AMT = GetToken(NPC_HITDATA_DMG, PLAYER_HITDATA_IDX, ";");
		GET_TOTAL_AMT += INC_DMG;
		SetToken(NPC_HITDATA_DMG, PLAYER_HITDATA_IDX, GET_TOTAL_AMT, ";");
	}

	void npcexp_drop_exp_counter()
	{
		string CUR_EXP_PLAYER = GetToken(NPC_HITDATA_IDS, i, ";");
		int DROP_THIS_PLAYER = 0;
		if (!((CUR_EXP_PLAYER !is null)))
		{
			int DROP_THIS_PLAYER = 1;
		}
		if (!(IsValidPlayer(CUR_EXP_PLAYER)))
		{
			int DROP_THIS_PLAYER = 1;
		}
		if (!(DROP_THIS_PLAYER)) return;
		npcexp_reset_skills(CUR_EXP_PLAYER);
	}

	void npcexp_find_empty_slot()
	{
		if (!(FOUND_EMPTY_SLOT < 0)) return;
		string CUR_EXP_PLAYER = GetToken(NPC_HITDATA_IDS, i, ";");
		if (CUR_EXP_PLAYER == 0)
		{
			FOUND_EMPTY_SLOT = i;
		}
	}

	void player_left()
	{
		string PLAYER_HITDATA_IDX = FindToken(NPC_HITDATA_IDS, i, ";");
		if (!(PLAYER_HITDATA_IDX > -1)) return;
		npcexp_reset_skills(PLAYER_HITDATA_IDX);
	}

	void npcexp_reset_skills()
	{
		SetToken(NPC_HITDATA_DMG, param1, 0, ";");
		SetToken(NPC_HITDATA_IDS, param1, 0, ";");
		if (param1 == 0)
		{
			PLAYER_HITDATA_SKILLS_0 = NPC_HITDATA_INIT_SKILLS;
		}
		if (param1 == 1)
		{
			PLAYER_HITDATA_SKILLS_1 = NPC_HITDATA_INIT_SKILLS;
		}
		if (param1 == 2)
		{
			PLAYER_HITDATA_SKILLS_2 = NPC_HITDATA_INIT_SKILLS;
		}
		if (param1 == 3)
		{
			PLAYER_HITDATA_SKILLS_3 = NPC_HITDATA_INIT_SKILLS;
		}
		if (param1 == 4)
		{
			PLAYER_HITDATA_SKILLS_4 = NPC_HITDATA_INIT_SKILLS;
		}
		if (param1 == 5)
		{
			PLAYER_HITDATA_SKILLS_5 = NPC_HITDATA_INIT_SKILLS;
		}
		if (param1 == 6)
		{
			PLAYER_HITDATA_SKILLS_6 = NPC_HITDATA_INIT_SKILLS;
		}
		if (param1 == 7)
		{
			PLAYER_HITDATA_SKILLS_7 = NPC_HITDATA_INIT_SKILLS;
		}
		if (param1 == 8)
		{
			PLAYER_HITDATA_SKILLS_8 = NPC_HITDATA_INIT_SKILLS;
		}
		if (param1 == 9)
		{
			PLAYER_HITDATA_SKILLS_9 = NPC_HITDATA_INIT_SKILLS;
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(NPC_GIVE_EXP > 0)) return;
		for (int i = 0; i < GetTokenCount(NPC_HITDATA_IDS, ";"); i++)
		{
			npcexp_dish_out_exp();
		}
	}

	void npcexp_dish_out_exp()
	{
		string CUR_IDX = i;
		string CUR_PLAYER = GetToken(NPC_HITDATA_IDS, CUR_IDX, ";");
		string CUR_DMG = GetToken(NPC_HITDATA_DMG, CUR_IDX, ";");
		if (CUR_IDX == 0)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_0;
		}
		if (CUR_IDX == 1)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_1;
		}
		if (CUR_IDX == 2)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_2;
		}
		if (CUR_IDX == 3)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_3;
		}
		if (CUR_IDX == 4)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_4;
		}
		if (CUR_IDX == 5)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_5;
		}
		if (CUR_IDX == 6)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_6;
		}
		if (CUR_IDX == 7)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_7;
		}
		if (CUR_IDX == 8)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_8;
		}
		if (CUR_IDX == 9)
		{
			T_SKILL_LIST = PLAYER_HITDATA_SKILLS_9;
		}
		TOTAL_XP_TO_GIVE = NPC_GIVE_EXP;
		string MY_HP = GetMonsterMaxHP();
		if (CUR_DMG < MY_HP)
		{
			CUR_DMG /= MY_HP;
			TOTAL_XP_TO_GIVE *= CUR_DMG;
		}
		if (CUR_DMG > MY_HP)
		{
			TOTAL_XP_TO_GIVE = NPC_GIVE_EXP;
		}
		OUT_IDX = CUR_IDX;
		for (int i = 0; i < GetTokenCount(T_SKILL_LIST, ";"); i++)
		{
			npcexp_learn_skill();
		}
	}

	void npcexp_learn_skill()
	{
		string THIS_PLAYER = GetToken(NPC_HITDATA_IDS, OUT_IDX, ";");
		string TOTAL_DMG = GetToken(NPC_HITDATA_DMG, OUT_IDX, ";");
		string SKILL_IDX = i;
		string DMG_WITH_THIS_SKILL = GetToken(T_SKILL_LIST, SKILL_IDX, ";");
		string PERCENT_DMG_DONE_W_SKILL = DMG_WITH_THIS_SKILL;
		PERCENT_DMG_DONE_W_SKILL /= TOTAL_DMG;
		string SKILL_POINTS_TO_GIVE_SKILL = TOTAL_XP_TO_GIVE;
		SKILL_POINTS_TO_GIVE_SKILL *= PERCENT_DMG_DONE_W_SKILL;
		// TODO: UNCONVERTED: learnskill THIS_PLAYER $get_token(PLAYER_SKILLS_LIST,SKILL_IDX) SKILL_POINTS_TO_GIVE_SKILL
	}

}

}
