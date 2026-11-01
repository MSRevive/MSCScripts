#pragma context server

#include "items/base_miscitem.as"
#include "items/base_effect_armor.as"

namespace MS
{

class ArmorBase : CGameScript
{
	int ARMOR_HUMAN_FEMALE_OFS_ADJ;
	int ARMOR_PROTECTION;
	string ARMOR_PROTECTION_AREA;
	string ARMOR_REPLACE_BODYPARTS;
	string ARMOR_TYPE;
	int DMG_REDUCT;
	string L_PERC_TO_FLOAT;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	string NEW_ARMOR_MODEL;

	ArmorBase()
	{
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "none";
		ARMOR_HUMAN_FEMALE_OFS_ADJ = 20;
		NEW_ARMOR_MODEL = "armor/p_armorvest_new.mdl";
	}

	void OnSpawn() override
	{
		SetWorldModel(MODEL_WORLD);
		SetHUDSprite("hand", "armor");
		SetHUDSprite("trade", "leather");
		SetHand("any");
		ARMOR_TYPE = BARMOR_TYPE;
		ARMOR_PROTECTION = 0;
		ARMOR_PROTECTION_AREA = BARMOR_PROTECTION_AREA;
		ARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		// TODO: registerarmor
		hide_body_parts();
		if (!(true)) return;
		L_PERC_TO_FLOAT = BARMOR_PROTECTION;
		L_PERC_TO_FLOAT *= 0.01;
		DMG_REDUCT = 1;
		DMG_REDUCT -= L_PERC_TO_FLOAT;
	}

	void hide_body_parts()
	{
		CallExternal(GetOwner(), "ext_setbodytype", BARMOR_TYPE, GetEntityIndex(GetOwner()));
	}

	void barmor_effect_activate()
	{
		CallExternal(GetOwner(), "ext_register_armor", GetEntityIndex(GetOwner()));
		CallExternal(GetOwner(), "ext_setbodytype", BARMOR_TYPE, GetEntityIndex(GetOwner()));
	}

	void show_body_parts()
	{
		if (GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))
		{
			CallExternal(GetOwner(), "ext_setbodytype", "normal", "remove");
		}
		CallExternal(GetOwner(), "ext_register_armor", "none", "remove");
	}

	void OnDeploy() override
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_HANDS);
		int L_SUBMODEL = 16;
		L_SUBMODEL += "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
	}

	void game_wear()
	{
		string L_RACE = param1;
		string L_GENDER = param2;
		string L_DEBUG = param3;
		barmor_update_vest(L_RACE, L_GENDER, L_DEBUG);
		string L_ARMOR_TEXT = ARMOR_TEXT;
		L_ARMOR_TEXT += " (";
		L_ARMOR_TEXT += BARMOR_PROTECTION;
		L_ARMOR_TEXT += ")";
		// TODO: playermessagecl L_ARMOR_TEXT
		if (!(true)) return;
		hide_body_parts();
		if (!(GetStat(GetOwner(), "strength") < ARMOR_STR_REQ)) return;
		ScheduleDelayedEvent(0.1, "failed_str_req_loop");
	}

	void game_show()
	{
		string L_RACE = param1;
		string L_GENDER = param2;
		string L_DEBUG = param3;
		barmor_update_vest(L_RACE, L_GENDER, L_DEBUG);
	}

	void barmor_update_vest()
	{
		SetModel(NEW_ARMOR_MODEL);
		SetModelBody(0, NEW_ARMOR_OFS);
		if ((false))
		{
			string OWNER_RACE = /* TODO: $get_local_prop */ $get_local_prop("race");
			string OWNER_GENDER = /* TODO: $get_local_prop */ $get_local_prop("gender");
		}
		else
		{
			if ((true))
			{
			}
			string OWNER_RACE = GetEntityRace(GetOwner());
			string OWNER_GENDER = GetGender(GetOwner());
		}
		string OWNER_RACE = StringToLower(OWNER_RACE);
		string OWNER_GENDER = StringToLower(OWNER_GENDER);
		if (OWNER_RACE == 0)
		{
			string OWNER_RACE = param1;
		}
		if (OWNER_GENDER == 0)
		{
			string OWNER_GENDER = param2;
		}
		LogDebug("barmor_update_vest race OWNER_RACE gend OWNER_GENDER dbg PARAM3");
		if (OWNER_GENDER == "female")
		{
			if (OWNER_RACE == "human")
			{
				LogDebug("*** Adjusted for Fembot");
				int ARMOR_GROUP = 0;
				if (ARMOR_BODY_HUMAN_FEMALE != "ARMOR_BODY_HUMAN_FEMALE")
				{
					SetModelBody(ARMOR_GROUP, ARMOR_BODY_HUMAN_FEMALE);
				}
				else
				{
					string FEM_BODY = NEW_ARMOR_OFS;
					FEM_BODY += ARMOR_HUMAN_FEMALE_OFS_ADJ;
					SetModelBody(ARMOR_GROUP, FEM_BODY);
				}
			}
		}
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			SetModelBody(ARMOR_GROUP, 0);
		}
	}

	void ext_set_armor()
	{
		SetModelBody(param1, param2);
	}

	void barmor_effect_remove()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar") != "normal")) return;
		show_body_parts();
	}

	void failed_str_req_loop()
	{
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if (!(GetStat(GetOwner(), "strength") < ARMOR_STR_REQ)) return;
		ScheduleDelayedEvent(10.0, "failed_str_req_loop");
		string ALRT_STR = "You are too weak to move freely in this armor. (Min Strength ";
		ALRT_STR += ARMOR_STR_REQ;
		ALRT_STR += ")";
		SendInfoMsg(GetOwner(), "Insufficient Strength for Armor " + ALRT_STR);
		ApplyEffect(GetOwner(), "effects/effect_slow", 10.0, 0.5, GetEntityIndex(GetOwner()));
	}

	void ext_activate_items()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if (!(GetStat(GetOwner(), "strength") < ARMOR_STR_REQ)) return;
		ScheduleDelayedEvent(0.1, "failed_str_req_loop");
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		string DMG_AMT = param3;
		if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "spider_resist", "type_exists")))
		{
			if (GetEntityRace(param1) == "spider")
			{
				int IS_SPIDER = 1;
			}
			if (GetEntityRace(param2) == "spider")
			{
				int IS_SPIDER = 1;
			}
			string L_NAME = GetEntityName(param1);
			string L_NAME = StringToLower(L_NAME);
			if ((L_NAME).findFirst("spider") >= 0)
			{
				int IS_SPIDER = 1;
			}
			if ((GetEntityProperty(param1, "itemname")).findFirst("spid") >= 0)
			{
				int IS_SPIDER = 1;
			}
			if ((IS_SPIDER))
			{
			}
			string DMG_RED_AMT = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "spider_resist", "type_first");
			DMG_AMT *= DMG_RED_AMT;
			SetDamage("hit");
			SetDamage("dmg");
			LogDebug("spider_adjusted_damage PARAM3 to OUT_DMG via DMG_RED_AMT");
		}
		if ((param4).findFirst("poison") >= 0)
		{
			string OUT_DMG = param3;
			DMG_AMT *= 0.5;
			SetDamage("hit");
			SetDamage("dmg");
			return;
		}
		else
		{
			if (!(GetEntityProperty(param1, "scriptvar")))
			{
			}
			DMG_AMT *= DMG_REDUCT;
			SetDamage("hit");
			SetDamage("dmg");
			return;
		}
	}

	void ext_hide_armor()
	{
		SetModelBody(0, 0);
	}

	void ext_hide_armor_cl()
	{
		SetModelBody(0, 0);
	}

}

}
