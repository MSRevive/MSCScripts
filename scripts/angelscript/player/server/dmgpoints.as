#pragma context server

namespace MS
{

class Dmgpoints : CGameScript
{
	string EXT_DMGPOINTS;
	int INIT_DMGPOINTS;
	string PLR_DMG;
	int PLR_TOTAL_DMG;

	Dmgpoints()
	{
		PLR_TOTAL_DMG = 0;
	}

	void activate_stuff()
	{
		if ((INIT_DMGPOINTS))
		{
			return;
		}
		INIT_DMGPOINTS = 1;
		if (G_DM_CODE == GetPlayerQuestData(GetOwner(), "dm"))
		{
			restore_dmg_points();
		}
		else
		{
			SetPlayerQuestData(GetOwner(), "dm");
			store_dmg_points();
			string L_MAP_NAME = StringToLower(GetMapName());
			if (FindToken(MAPS_GAUNTLET_START, L_MAP_NAME, ";") == -1)
			{
				return;
			}
			if (GetGameTime() < 180)
			{
				PLR_TOTAL_DMG = 10;
				SendColoredMessage(GetOwner(), "Bonus 10 , 000 damage points for starting gauntlet.");
				store_dmg_points();
			}
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (PLR_TOTAL_DMG > 1)
		{
			PLR_TOTAL_DMG -= 1;
			PLR_DMG = 0;
			store_dmg_points();
		}
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (GetRelationship(param1) == "enemy")
		{
			int L_IS_ENEMY = 1;
		}
		if (GetRelationship(param1) == "wary")
		{
			int L_IS_ENEMY = 1;
		}
		string L_DAMAGE_TYPE = param3;
		if ((L_DAMAGE_TYPE).findFirst("_effect") >= 0)
		{
			string L_DAMAGE_TYPE = /* TODO: $string_upto */ $string_upto(L_DAMAGE_TYPE, "_effect");
		}
		if (L_DAMAGE_TYPE == "holy")
		{
			if (GetEntityRace(param1) == "undead")
			{
				int L_CAN_DAMAGE = 1;
			}
			if (GetEntityRace(param1) == "demon")
			{
				int L_CAN_DAMAGE = 1;
			}
			if (!(L_CAN_DAMAGE))
			{
				return;
			}
		}
		if ((L_IS_ENEMY))
		{
			if (!(GetEntityProperty(param1, "scriptvar")))
			{
			}
			if (!(IsValidPlayer(param1)))
			{
			}
			string L_DMG_DONE = param2;
			string L_NME_HP = GetEntityHealth(param1);
			string L_NME_ARMOR = GetEntityProperty(param1, "scriptvar");
			L_DMG_DONE *= /* TODO: $get_takedmg */ $get_takedmg(param1, L_DAMAGE_TYPE);
			if (L_NME_ARMOR > 0)
			{
				L_DMG_DONE *= L_NME_ARMOR;
			}
			if (L_NME_HP < L_DMG_DONE)
			{
				string L_DMG_DONE = L_NME_HP;
			}
			add_dmg_points(L_DMG_DONE);
		}
	}

	void restore_dmg_points()
	{
		PLR_TOTAL_DMG = GetPlayerQuestData(GetOwner(), "dp");
		if (!(PLR_TOTAL_DMG > 0)) return;
		string L_OUT_MSG = int(PLR_TOTAL_DMG);
		SendColoredMessage(GetOwner(), "Restored L_OUT_MSG damage points.");
	}

	void store_dmg_points()
	{
		SetPlayerQuestData(GetOwner(), "dp");
	}

	void add_dmg_points()
	{
		PLR_DMG += param1;
		if (PLR_DMG >= 1000)
		{
			PLR_TOTAL_DMG += int(/* TODO: $math(divide) */ PLR_DMG);
			PLR_DMG %= 1000;
			store_dmg_points();
		}
	}

	void ext_dmgpoint_bonus()
	{
		add_dmg_points(int(param1));
		string OUT_MSG = "+";
		OUT_MSG += int(param1);
		OUT_MSG += " damage points ";
		OUT_MSG += param2;
		SendColoredMessage(GetOwner(), "OUT_MSG");
	}

	void ext_get_dmgpoints()
	{
		EXT_DMGPOINTS = PLR_TOTAL_DMG;
		EXT_DMGPOINTS += /* TODO: $math(multiply) */ PLR_DMG;
	}

}

}
