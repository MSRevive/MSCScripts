#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmGaz1 : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	string ELM_AMT;
	string ELM_NAME;
	string ELM_TYPE;
	int REG_SPECIAL_EFFECT;
	string SP_ATTRIB;
	float STUN_PROTECTION;

	ArmorHelmGaz1()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 7;
		ARMOR_TEXT = "You equip the Helm of Fire Reistance.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.6;
		STUN_PROTECTION = 0.6;
		REG_SPECIAL_EFFECT = 1;
		SP_ATTRIB = "skill.spellcasting.fire.ratio";
		ELM_NAME = "fireh";
		ELM_TYPE = "fire";
	}

	void OnSpawn() override
	{
		SetName("Helm of Fire Resistance");
		SetDescription("This helm causes a shiver to go down your spine.");
		SetWeight(5);
		SetSize(20);
		SetWearable(1);
		SetValue(1150);
		SetHUDSprite("trade", 83);
	}

	void elm_get_resist()
	{
		ELM_AMT = GetEntityProperty(GetOwner(), "sp_attrib");
		ELM_AMT *= 2;
		ELM_AMT *= 100;
		if (ELM_AMT > 50)
		{
			ELM_AMT = 50;
		}
	}

}

}
