#pragma context server

#include "items/armor_base.as"
#include "items/base_elemental_resist.as"
#include "items/base_loopsnd.as"

namespace MS
{

class ArmorFaura : CGameScript
{
	int PHOENIX_ACTIVE;

	ArmorFaura()
	{
		const string ARMOR_MODEL = "armor/p_armorvest2.mdl";
		const int ARMOR_GROUP = 4;
		const int ARMOR_BODY = 6;
		const string ARMOR_TEXT = "You assemble the Aura of Fire.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.55;
		const string BARMOR_PROTECTION_AREA = "chest;arms;legs";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const string ELM_NAME = "farmr";
		const string ELM_TYPE = "fire";
		const int ELM_AMT = 30;
		const int ARMOR_STR_REQ = 30;
		const string LOOPSND_NAME = "items/torch1.wav";
		const int LOOPSND_LENGTH = 6;
		const float LOOPSND_VOLUME = 2.5;
		const int NEW_ARMOR_OFS = 16;
	}

	void OnSpawn() override
	{
		SetName("Aura of Fire");
		SetDescription("Enchanted mail that protects the user with a ring of fire.");
		SetWeight(180);
		SetSize(60);
		SetWearable(1);
		SetValue(750);
		SetHUDSprite("trade", 153);
	}

	void elm_activate_effect()
	{
		string OWNER_SKILL = GetSkillLevel(GetOwner(), "spellcasting.fire");
		if (OWNER_SKILL < 20)
		{
			SendColoredMessage(GetOwner(), "You lack the fire skill to activate this armor's magic.");
		}
		if (!(OWNER_SKILL >= 20)) return;
		PHOENIX_ACTIVE = 1;
		CallExternal(GetOwner(), "ext_register_element", ELM_NAME, ELM_TYPE, ELM_AMT);
		ScheduleDelayedEvent(0.1, "secondary_element_activate");
	}

	void secondary_element_activate()
	{
		CallExternal(GetOwner(), "ext_register_element", "carmr", "cold", "25");
		ScheduleDelayedEvent(0.1, "activate_aura");
	}

	void activate_aura()
	{
		string AURA_DOT = GetSkillLevel(GetOwner(), "spellcasting.fire");
		AURA_DOT *= 0.25;
		CallExternal(GetOwner(), "ext_fire_aura_activate", AURA_DOT, 48);
		// svplaysound: svplaysound LOOPSND_CHANNEL LOOPSND_VOLUME LOOPSND_NAME
		EmitSound(LOOPSND_CHANNEL, LOOPSND_VOLUME, LOOPSND_NAME);
	}

	void elm_remove_effect()
	{
		if (!(PHOENIX_ACTIVE)) return;
		PHOENIX_ACTIVE = 0;
		if (!(GetSkillLevel(GetOwner(), "spellcasting.fire") >= 20)) return;
		CallExternal(GetOwner(), "ext_register_element", ELM_NAME, "remove");
		ScheduleDelayedEvent(0.1, "secondary_element_remove");
	}

	void secondary_element_remove()
	{
		CallExternal(GetOwner(), "ext_register_element", "carmr", "remove");
		ScheduleDelayedEvent(0.1, "remove_aura");
	}

	void remove_aura()
	{
		CallExternal(GetOwner(), "ext_fire_aura_remove");
		loopsnd_end();
	}

}

}
