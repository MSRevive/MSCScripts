#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmGaz2 : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	string ELM_AMT;
	string ELM_NAME;
	string ELM_TYPE;
	string SP_ATTRIB;
	float STUN_PROTECTION;

	ArmorHelmGaz2()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 6;
		ARMOR_TEXT = "You equip the Helm of Cold Resistance.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.6;
		STUN_PROTECTION = 0.65;
		SP_ATTRIB = "skill.spellcasting.ice.ratio";
		ELM_NAME = "coldh";
		ELM_TYPE = "cold";
	}

	void OnSpawn() override
	{
		SetName("Helm of Cold Resistance");
		SetDescription("This helm is warm to the touch.");
		SetWeight(5);
		SetSize(20);
		SetWearable(1);
		SetValue(1150);
		SetHUDSprite("trade", 82);
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
