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
	int AM_INVINCIBLE;
	string INIT_IDLE_MODE;
	int IS_LEADER;
	string LANTERN_COLOR;
	int MONSTER_MODEL;
	int NEW_HEIGHT;
	string NEW_RACE;
	int NEW_WIDTH;
	string QUEST_ACTIVATE_CHAT;
	string QUEST_ACTIVATE_SOUND;
	int QUEST_ACTIVE_COMBATANT;
	int QUEST_ACTIVE_TEXT;
	string QUEST_ASKING_TEXT;
	int QUEST_COMBATANT;
	string QUEST_COMPLETE_CHAT;
	int QUEST_COMPLETE_SOUND;
	string QUEST_COMPLETE_TEXT;
	string QUEST_DATA1;
	int QUEST_DATA2;
	int QUEST_DATA3;
	int QUEST_EXPERT_COMBATANT;
	string QUEST_FADE_ON_COMPLETE;
	string QUEST_FINISHED_CHAT;
	int QUEST_FINISHED_SOUND;
	int QUEST_FOLLOWER;
	string QUEST_GIVER_NAME;
	string QUEST_INTRO_CHAT;
	int QUEST_INTRO_SOUND;
	string QUEST_PROGRESS_MAX;
	string QUEST_PROGRESS_VAR;
	int QUEST_REWARD_ALL;
	string QUEST_REWARD_EVENT;
	string QUEST_REWARD_TYPE;
	int QUEST_SHOW_PROGRESS;
	string QUEST_TYPE;
	string QUEST_WAITING_TEXT;
	int SET_SIEGE_MODE;
	string SUBMODEL_GROUPS;
	int USE_LANTERN;
	int USE_SKIN;

	DqGetItemFromHandsTemplate()
	{
		QUEST_TYPE = "get_item_from_hands";
		QUEST_DATA1 = "items/mana_bravery;Potion of Not Scared";
		QUEST_DATA2 = 2;
		QUEST_DATA3 = 5;
		QUEST_REWARD_TYPE = "gm";
		QUEST_REWARD_EVENT = "old_helena_warboss_died";
		QUEST_REWARD_ALL = 0;
		QUEST_COMPLETE_TEXT = "(Collect Reward)";
		QUEST_WAITING_TEXT = "Dude, help me fight?";
		QUEST_ASKING_TEXT = "Didn't wanna run Loda anyways";
		QUEST_ACTIVE_TEXT = 0;
		QUEST_SHOW_PROGRESS = 0;
		QUEST_PROGRESS_VAR = DQ_AMMO_CUR;
		QUEST_PROGRESS_MAX = DQ_AMMO_REQUIREMENT;
		QUEST_INTRO_CHAT = "But I don't wanna lose XP! Bring me a potion for that, and not that garbage armor!";
		QUEST_INTRO_SOUND = 0;
		QUEST_ACTIVATE_CHAT = "Yeah, neither do I.";
		QUEST_ACTIVATE_SOUND = "voices/dwarf/vs_ndwarfm1_hit1.wav";
		QUEST_FINISHED_CHAT = "WHEW! Now I can die without repurcussions. Thanks.";
		QUEST_FINISHED_SOUND = 0;
		QUEST_COMPLETE_CHAT = "I've used an arbitrary event within the GM to spawn gold at the origin of the map. Hope it's not stuck in some wall somewhere.";
		QUEST_COMPLETE_SOUND = 0;
		QUEST_FADE_ON_COMPLETE = "fade";
		QUEST_GIVER_NAME = "Scared Little Man";
		NEW_RACE = "human";
		AM_INVINCIBLE = 1;
		NEW_WIDTH = 32;
		NEW_HEIGHT = 32;
		MONSTER_MODEL = 0;
		SUBMODEL_GROUPS = "0;0";
		USE_SKIN = 4;
		SET_SIEGE_MODE = 0;
		QUEST_COMBATANT = 0;
		QUEST_ACTIVE_COMBATANT = 0;
		QUEST_FOLLOWER = 0;
		IS_LEADER = 0;
		USE_LANTERN = 1;
		LANTERN_COLOR = "(128,64,0)";
		INIT_IDLE_MODE = "sitting";
		QUEST_EXPERT_COMBATANT = 0;
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
