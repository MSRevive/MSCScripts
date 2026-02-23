#pragma context server

#include "dq/quests/dq_fetch_items.as"
#include "dq/templates/bases/dq_generic_reward.as"
#include "dq/templates/bases/dq_generic_menus.as"
#include "dq/templates/bases/dq_generic_chat.as"
#include "dq/quest_dwarf.as"

namespace MS
{

class DqFetchItemsTemplate : CGameScript
{
	string INIT_IDLE_MODE;

	DqFetchItemsTemplate()
	{
		const string QUEST_TYPE = "fetch_items";
		const string QUEST_DATA1 = "qitem_place";
		const string QUEST_DATA2 = "km;Barrel of God knows what";
		const int QUEST_DATA3 = 0;
		const string QUEST_REWARD_TYPE = "gm";
		const string QUEST_REWARD_EVENT = "old_helena_warboss_died";
		const int QUEST_REWARD_ALL = 0;
		const string QUEST_COMPLETE_TEXT = "(Collect Reward)";
		const string QUEST_WAITING_TEXT = "ZOMBIE!";
		const string QUEST_ASKING_TEXT = "As long as they're not mine...";
		const string QUEST_ACTIVE_TEXT = "(In Progress)";
		const int QUEST_SHOW_PROGRESS = 1;
		const string QUEST_PROGRESS_VAR = QITEMS_FOUND;
		const string QUEST_PROGRESS_MAX = QITEM_ORIGIN_AMT;
		const string QUEST_INTRO_CHAT = "Me... Brainss... Me barrel'o'brainzz...";
		const int QUEST_INTRO_SOUND = 0;
		const int QUEST_ACTIVATE_CHAT = 0;
		const string QUEST_ACTIVATE_SOUND = "monsters/zombie1/zo_pain1.wav";
		const string QUEST_FINISHED_CHAT = "Brains...";
		const int QUEST_FINISHED_SOUND = 0;
		const int QUEST_COMPLETE_CHAT = 0;
		const string QUEST_COMPLETE_SOUND = "monsters/zombie1/orc_zo_alert10.wav";
		const string QUEST_FADE_ON_COMPLETE = "fade";
		const string QUEST_GIVER_NAME = "Zombified Dwarf";
		const string NEW_RACE = "beloved";
		const int AM_INVINCIBLE = 0;
		const int NEW_WIDTH = 32;
		const int NEW_HEIGHT = 32;
		const int MONSTER_MODEL = 0;
		const string SUBMODEL_GROUPS = "0;2";
		const int USE_SKIN = 0;
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

	void do_chat_ext_recieve_quest_item()
	{
		if (QUEST_MODE == "active")
		{
			if (!(CHAT_BUSY))
			{
				chat_now("More... Brains...");
				EmitSound(GetOwner(), 2, "none", 10);
			}
		}
	}

	void ext_receive_quest_item()
	{
		ScheduleDelayedEvent(0.1, "do_chat_ext_recieve_quest_item");
	}

}

}
