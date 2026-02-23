#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmGaz2 : CGameScript
{
	string ELM_AMT;

	ArmorHelmGaz2()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 6;
		const string ARMOR_TEXT = "You equip the Helm of Cold Resistance.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.6;
		const float STUN_PROTECTION = 0.65;
		const string SP_ATTRIB = "skill.spellcasting.ice.ratio";
		const string ELM_NAME = "coldh";
		const string ELM_TYPE = "cold";
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
