#pragma context server

#include "items/armor_base.as"
#include "items/base_elemental_resist.as"

namespace MS
{

class ArmorPaura : CGameScript
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
	string SOUND_GAS_ON;

	ArmorPaura()
	{
		ARMOR_MODEL = "armor/p_armorvest2.mdl";
		ARMOR_GROUP = 4;
		ARMOR_BODY = 7;
		ARMOR_TEXT = "You assemble the the acid plate armor.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.5;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		ELM_NAME = "aarmr";
		ELM_TYPE = "poison";
		ELM_AMT = 50;
		ARMOR_STR_REQ = 30;
		SOUND_GAS_ON = "ambience/steamburst1.wav";
		NEW_ARMOR_OFS = 17;
		Precache("poison_cloud.spr");
	}

	void OnSpawn() override
	{
		SetName("Acid Plate");
		SetDescription("Enchanted plate mail scorched by acid.");
		SetWeight(180);
		SetSize(60);
		SetWearable(1);
		SetValue(1000);
		SetHUDSprite("trade", 154);
	}

	void elm_activate_effect()
	{
		string OWNER_SKILL = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		if (OWNER_SKILL < 20)
		{
			SendColoredMessage(GetOwner(), "You lack the affliction skill to activate this armor's magic.");
		}
		if (!(OWNER_SKILL >= 20)) return;
		PHOENIX_ACTIVE = 1;
		CallExternal(GetOwner(), "ext_register_element", ELM_NAME, ELM_TYPE, ELM_AMT);
		ScheduleDelayedEvent(0.1, "secondary_element_activate");
	}

	void secondary_element_activate()
	{
		CallExternal(GetOwner(), "ext_register_element", "aarmb", "acid", "80");
		ScheduleDelayedEvent(0.1, "activate_aura");
	}

	void activate_aura()
	{
		string AURA_DOT = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		AURA_DOT *= 0.3;
		CallExternal(GetOwner(), "ext_poison_aura_activate", AURA_DOT, 64);
		EmitSound(GetOwner(), 3, SOUND_GAS_ON, 10);
	}

	void elm_remove_effect()
	{
		if (!(PHOENIX_ACTIVE)) return;
		PHOENIX_ACTIVE = 0;
		if (!(GetSkillLevel(GetOwner(), "spellcasting.affliction") >= 20)) return;
		CallExternal(GetOwner(), "ext_register_element", ELM_NAME, "remove");
		ScheduleDelayedEvent(0.1, "secondary_element_remove");
	}

	void secondary_element_remove()
	{
		CallExternal(GetOwner(), "ext_register_element", "aarmb", "remove");
		ScheduleDelayedEvent(0.1, "remove_aura");
	}

	void remove_aura()
	{
		CallExternal(GetOwner(), "ext_poison_aura_remove");
	}

}

}
