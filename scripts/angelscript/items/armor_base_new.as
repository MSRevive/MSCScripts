#pragma context server

#include "items/base_item.as"
#include "items/base_effect_armor.as"

namespace MS
{

class ArmorBaseNew : CGameScript
{
	int ARMOR_PROTECTION;
	string ARMOR_PROTECTION_AREA;
	string ARMOR_REPLACE_BODYPARTS;
	string ARMOR_TYPE;
	int DMG_REDUCT;
	string L_PERC_TO_FLOAT;

	ArmorBaseNew()
	{
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 16;
		const string MODEL_VIEW = "none";
		const string NEW_ARMOR_MODEL = "armor/p_armorvest_new.mdl";
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
		SetModelBody(0, NEW_ARMOR_OFS);
		hide_body_parts();
		if (!(true)) return;
		L_PERC_TO_FLOAT = BARMOR_PROTECTION;
		L_PERC_TO_FLOAT *= 0.01;
		DMG_REDUCT = 1;
		DMG_REDUCT -= L_PERC_TO_FLOAT;
	}

	void hide_body_parts()
	{
		CallExternal(GetOwner(), "ext_setbodytype", BARMOR_TYPE);
	}

	void show_body_parts()
	{
		CallExternal(GetOwner(), "ext_setbodytype", "normal");
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
		SetModel(NEW_ARMOR_MODEL);
		SetModelBody(0, NEW_ARMOR_OFS);
		// TODO: playermessagecl ARMOR_TEXT BARMOR_PROTECTION
		if (!(true)) return;
		hide_body_parts();
		if (!(GetStat(GetOwner(), "strength") < ARMOR_STR_REQ)) return;
		ScheduleDelayedEvent(0.1, "failed_str_req_loop");
	}

	void barmor_effect_remove()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar") != "normal")) return;
		show_body_parts();
	}

	void barmor_effect_activate()
	{
		CallExternal(GetOwner(), "ext_setbodytype", BARMOR_TYPE);
	}

	void failed_str_req_loop()
	{
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if (!(GetStat(GetOwner(), "strength") < ARMOR_STR_REQ)) return;
		ScheduleDelayedEvent(10.0, "failed_str_req_loop");
		string ALRT_STR = "You are too weak to move freely in this armor. (Min Strength ";
		ALRT_STR += ARMOR_STR_REQ;
		ALRT_STR += ")";
		SendInfoMsg(GetOwner(), "Insufficient Strength for Armor ALRT_STR");
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
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			if (GetEntityRace(param1) == "spider")
			{
			}
			string DMG_RED_AMT = GetEntityProperty(GetOwner(), "scriptvar");
			string OUT_DMG = param3;
			OUT_DMG *= PLR_SPIDER_AMT;
			SetDamage("hit");
			SetDamage("dmg");
			return;
		}
		if ((param4).findFirst("poison") >= 0)
		{
			string OUT_DMG = param3;
			PARAM3 *= 0.5;
			SetDamage("hit");
			SetDamage("dmg");
			return;
		}
		else
		{
			if (!(GetEntityProperty(param1, "scriptvar")))
			{
			}
			PARAM3 *= DMG_REDUCT;
			SetDamage("hit");
			SetDamage("dmg");
			return;
		}
	}

}

}
