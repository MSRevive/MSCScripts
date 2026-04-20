#pragma context server

#include "items/armor_base.as"
#include "items/base_elemental_resist.as"

namespace MS
{

class ArmorVenom : CGameScript
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

	ArmorVenom()
	{
		ARMOR_MODEL = "armor/p_armorvest2.mdl";
		ARMOR_GROUP = 4;
		ARMOR_BODY = 5;
		ARMOR_TEXT = "You assemble the envenomed plate mail.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.5;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		ELM_NAME = "varmr";
		ELM_TYPE = "poison";
		ELM_AMT = 50;
		ARMOR_STR_REQ = 25;
		NEW_ARMOR_OFS = 15;
	}

	void OnSpawn() override
	{
		SetName("Envenomed Plate");
		SetDescription("Hefty Plate mail enchanted with poison.");
		SetWeight(180);
		SetSize(60);
		SetWearable(1);
		SetValue(600);
		SetHUDSprite("trade", 152);
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if (!(RandomInt(1, 4) == 1)) return;
		string OWNER_POS = GetEntityOrigin(GetOwner());
		string ATKR_POS = GetEntityOrigin(param1);
		string MIN_DIST = GetEntityProperty(param1, "moveprox");
		MIN_DIST += 32;
		if (!(Distance(OWNER_POS, ATKR_POS) <= MIN_DIST)) return;
		string POISON_DMG = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		POISON_DMG *= 0.5;
		ApplyEffect(param1, "effects/dot_poison", 10.0, GetEntityIndex(GetOwner()), POISON_DMG, "spellcasting.poison");
		EmitSound(GetOwner(), 0, "bullchicken/bc_bite2.wav", 10);
		SendPlayerMessage("Your", "Venom Plate poisons " + GetEntityProperty(param1, "name.full"));
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
	}

	void elm_remove_effect()
	{
		if (!(PHOENIX_ACTIVE)) return;
		PHOENIX_ACTIVE = 0;
		if (!(GetSkillLevel(GetOwner(), "spellcasting.affliction") >= 20)) return;
		PHOENIX_ACTIVE = 0;
		CallExternal(GetOwner(), "ext_register_element", ELM_NAME, "remove");
	}

}

}
