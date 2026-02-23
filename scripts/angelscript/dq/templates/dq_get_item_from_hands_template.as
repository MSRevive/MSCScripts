#pragma context server

#include "dq/quests/dq_get_item_from_hands.as"
#include "dq/templates/bases/dq_generic_reward.as"
#include "dq/templates/bases/dq_generic_menus.as"
#include "dq/templates/bases/dq_generic_chat.as"
#include "dq/quest_dwarf.as"

namespace MS
{

class DqGetItemFromHandsTemplate : CGameScript
{
	string INIT_IDLE_MODE;

	DqGetItemFromHandsTemplate()
	{
		const string QUEST_TYPE = "get_item_from_hands";
		const string QUEST_DATA1 = "items/mana_bravery;Potion of Not Scared";
		const int QUEST_DATA2 = 2;
		const int QUEST_DATA3 = 5;
		const string QUEST_REWARD_TYPE = "gm";
		const string QUEST_REWARD_EVENT = "old_helena_warboss_died";
		const int QUEST_REWARD_ALL = 0;
		const string QUEST_COMPLETE_TEXT = "(Collect Reward)";
		const string QUEST_WAITING_TEXT = "Dude, help me fight?";
		const string QUEST_ASKING_TEXT = "Didn't wanna run Loda anyways";
		const int QUEST_ACTIVE_TEXT = 0;
		const int QUEST_SHOW_PROGRESS = 0;
		const string QUEST_PROGRESS_VAR = DQ_AMMO_CUR;
		const string QUEST_PROGRESS_MAX = DQ_AMMO_REQUIREMENT;
		const string QUEST_INTRO_CHAT = "But I don't wanna lose XP! Bring me a potion for that, and not that garbage armor!";
		const int QUEST_INTRO_SOUND = 0;
		const string QUEST_ACTIVATE_CHAT = "Yeah, neither do I.";
		const string QUEST_ACTIVATE_SOUND = "voices/dwarf/vs_ndwarfm1_hit1.wav";
		const string QUEST_FINISHED_CHAT = "WHEW! Now I can die without repurcussions. Thanks.";
		const int QUEST_FINISHED_SOUND = 0;
		const string QUEST_COMPLETE_CHAT = "I've used an arbitrary event within the GM to spawn gold at the origin of the map. Hope it's not stuck in some wall somewhere.";
		const int QUEST_COMPLETE_SOUND = 0;
		const string QUEST_FADE_ON_COMPLETE = "fade";
		const string QUEST_GIVER_NAME = "Scared Little Man";
		const string NEW_RACE = "human";
		const int AM_INVINCIBLE = 1;
		const int NEW_WIDTH = 32;
		const int NEW_HEIGHT = 32;
		const int MONSTER_MODEL = 0;
		const string SUBMODEL_GROUPS = "0;0";
		const int USE_SKIN = 4;
		const int SET_SIEGE_MODE = 0;
		const int QUEST_COMBATANT = 0;
		const int QUEST_ACTIVE_COMBATANT = 0;
		const int QUEST_FOLLOWER = 0;
		const int IS_LEADER = 0;
		const int USE_LANTERN = 1;
		const string LANTERN_COLOR = "(128,64,0)";
		INIT_IDLE_MODE = "sitting";
		const int QUEST_EXPERT_COMBATANT = 0;
	}

	void failed_scriptname()
	{
		if (!(CHAT_BUSY))
		{
			chat_now("Remember, I need a potion that makes me not lose XP.", 1.0);
		}
	}

	void failed_quality()
	{
		if (!(CHAT_BUSY))
		{
			chat_now("Ew gross, someone drank out of this. I want a new one.", 1.0);
		}
	}

	void give_item()
	{
		if (QUEST_MODE == QUEST_ACTIVE)
		{
			if (!(CHAT_BUSY))
			{
				chat_now("Thanks, but I still need more.", 1.0);
			}
		}
	}

}

}
