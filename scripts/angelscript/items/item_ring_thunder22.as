#pragma context server

#include "items/base_elemental_resist.as"
#include "items/base_miscitem.as"

namespace MS
{

class ItemRingThunder22 : CGameScript
{
	string ELM_AMT;

	ItemRingThunder22()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 27;
		const string ANIM_PREFIX = "ring";
		const string SP_ATTRIB = "skill.spellcasting.lightning.ratio";
		const string ELM_NAME = "ringl";
		const string ELM_TYPE = "lightning";
	}

	void miscitem_spawn()
	{
		SetName("Ring of Grounding");
		SetDescription("This ring provides the owner some protection against lightning magics");
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetValue(1000);
		SetWearable(1);
		SetHUDSprite("trade", "ring");
	}

	void game_wear()
	{
		SetModel("none");
	}

	void game_removefromowner()
	{
		SetModel(MODEL_HANDS);
	}

	void elm_get_resist()
	{
		ELM_AMT = GetEntityProperty(GetOwner(), "sp_attrib");
		ELM_AMT *= 200;
		if (ELM_AMT > 75)
		{
			ELM_AMT = 75;
		}
	}

}

}
