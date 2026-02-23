#pragma context server

#include "items/armor_base.as"
#include "items/base_elemental_resist.as"

namespace MS
{

class ArmorPaura : CGameScript
{
	int PHOENIX_ACTIVE;

	ArmorPaura()
	{
		const string ARMOR_MODEL = "armor/p_armorvest2.mdl";
		const int ARMOR_GROUP = 4;
		const int ARMOR_BODY = 7;
		const string ARMOR_TEXT = "You assemble the the acid plate armor.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.5;
		const string BARMOR_PROTECTION_AREA = "chest;arms;legs";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const string ELM_NAME = "aarmr";
		const string ELM_TYPE = "poison";
		const int ELM_AMT = 50;
		const int ARMOR_STR_REQ = 30;
		const string SOUND_GAS_ON = "ambience/steamburst1.wav";
		const int NEW_ARMOR_OFS = 17;
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
