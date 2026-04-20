#pragma context server

#include "dridje/gloam_slayer.as"

namespace MS
{

class GloamSlayerJm : CGameScript
{
	string REWARD_LIST;
	string REWARD_NAMES;

	GloamSlayerJm()
	{
		REWARD_LIST = "armor_helm_gaz1;armor_helm_gaz2;smallarms_flamelick;mana_leadfoot;smallarms_frozentongueonflagpole;item_charm_w3";
		REWARD_NAMES = "A helm of Fire Resistance;A helm of Cold Resistance;A Flame Lick;A Potion of Stability;A Litchtongue;A Shadowwolf Charm";
	}

}

}
