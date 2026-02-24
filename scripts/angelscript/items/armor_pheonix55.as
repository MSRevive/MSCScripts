#pragma context server

#include "items/armor_base.as"
#include "items/base_elemental_resist.as"

namespace MS
{

class ArmorPheonix55 : CGameScript
{
	int ARMOR_BODY;
	int ARMOR_GROUP;
	string ARMOR_MODEL;
	int ARMOR_STR_REQ;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int ELM_AMT;
	string ELM_NAME;
	string ELM_TYPE;
	int NEW_ARMOR_OFS;
	int PHOENIX_ACTIVE;

	ArmorPheonix55()
	{
		ARMOR_MODEL = "armor/p_armorvest2.mdl";
		ARMOR_GROUP = 4;
		ARMOR_BODY = 1;
		ARMOR_TEXT = "You assemble the phoenix armor.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.55;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		ELM_NAME = "phonx";
		ELM_TYPE = "fire";
		ELM_AMT = 75;
		ARMOR_STR_REQ = 40;
		NEW_ARMOR_OFS = 11;
	}

	void OnSpawn() override
	{
		SetName("Armor of the Phoenix");
		SetDescription("Forged with the blood of an efreet and the feathers of a phoenix.");
		SetWeight(120);
		SetSize(60);
		SetWearable(1);
		SetValue(590);
		SetHUDSprite("trade", 151);
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if (!((param4).findFirst("fire") == 0)) return;
		string L_BURN_ID = GetEntityProperty(GetOwner(), "scriptvar");
		if (param2 == L_BURN_ID)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetSkillLevel(GetOwner(), "spellcasting.fire") < 15)
		{
			SendColoredMessage(GetOwner(), "Your magic is not strong enough to activate this armor's special ability.");
		}
		if (!(GetSkillLevel(GetOwner(), "spellcasting.fire") >= 15)) return;
		string MP_TO_GIVE = param3;
		string DMG_TO_TAKE = param3;
		DMG_TO_TAKE *= /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "fire");
		LogDebug("game_takedamage DMG_TO_TAKE");
		string OWNER_HP = GetEntityHealth(GetOwner());
		OWNER_HP -= DMG_TO_TAKE;
		LogDebug("regen OWNER_HP");
		if (OWNER_HP <= 0)
		{
			SendInfoMsg(GetOwner(), "The Phoenix Armor Has restored your health to 100%");
			HealEntity(GetOwner(), GetEntityMaxHealth(GetOwner()));
			SetDamage("dmg");
			SetDamage("hit");
			EmitSound(GetOwner(), 0, "magic/cast.wav", 10);
			ScheduleDelayedEvent(0.2, "phoenix_sound");
		}
		if (GetEntityMP(GetOwner()) != GetEntityProperty(GetOwner(), "maxmp"))
		{
			GiveMP(MP_TO_GIVE);
			CallExternal(GetOwner(), "mana_drain");
			int MP_TO_GIVE = int(MP_TO_GIVE);
			MP_TO_GIVE += "mp";
			SendColoredMessage(GetOwner(), "The phoenix armor regenerates your mana " + MP_TO_GIVE);
			Effect("glow", GetOwner(), Vector3(0, 255, 0), 64, 1, 1);
			EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
		}
	}

	void phoenix_sound()
	{
		EmitSound(GetOwner(), 0, "monsters/birds/hawkcaw.wav", 10);
	}

	void elm_activate_effect()
	{
		string OWNER_SKILL = GetSkillLevel(GetOwner(), "spellcasting.fire");
		if (OWNER_SKILL < 20)
		{
			SendColoredMessage(GetOwner(), "You lack the fire skill to activate this armor's magic.");
		}
		if (!(OWNER_SKILL > 20)) return;
		PHOENIX_ACTIVE = 1;
		CallExternal(GetOwner(), "ext_register_element", ELM_NAME, ELM_TYPE, ELM_AMT);
	}

	void elm_remove_effect()
	{
		if (!(PHOENIX_ACTIVE)) return;
		if (!(GetSkillLevel(GetOwner(), "spellcasting.fire") > 20)) return;
		PHOENIX_ACTIVE = 0;
		CallExternal(GetOwner(), "ext_register_element", ELM_NAME, "remove");
	}

}

}
