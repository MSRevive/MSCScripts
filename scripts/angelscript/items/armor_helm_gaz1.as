#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmGaz1 : CGameScript
{
	string ELM_AMT;

	ArmorHelmGaz1()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 7;
		const string ARMOR_TEXT = "You equip the Helm of Fire Reistance.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.6;
		const float STUN_PROTECTION = 0.6;
		const int REG_SPECIAL_EFFECT = 1;
		const string SP_ATTRIB = "skill.spellcasting.fire.ratio";
		const string ELM_NAME = "fireh";
		const string ELM_TYPE = "fire";
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
