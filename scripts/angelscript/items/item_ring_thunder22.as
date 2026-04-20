#pragma context server

#include "items/base_elemental_resist.as"
#include "items/base_miscitem.as"

namespace MS
{

class ItemRingThunder22 : CGameScript
{
	string ANIM_PREFIX;
	string ELM_AMT;
	string ELM_NAME;
	string ELM_TYPE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string SP_ATTRIB;

	ItemRingThunder22()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 27;
		ANIM_PREFIX = "ring";
		SP_ATTRIB = "skill.spellcasting.lightning.ratio";
		ELM_NAME = "ringl";
		ELM_TYPE = "lightning";
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
