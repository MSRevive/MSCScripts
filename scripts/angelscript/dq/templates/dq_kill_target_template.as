#pragma context server

#include "dq/quests/dq_kill_target.as"
#include "dq/templates/bases/dq_generic_reward.as"
#include "dq/templates/bases/dq_generic_menus.as"
#include "dq/templates/bases/dq_generic_chat.as"
#include "dq/quest_dwarf.as"

namespace MS
{

class DqKillTargetTemplate : CGameScript
{
	string INIT_IDLE_MODE;

	DqKillTargetTemplate()
	{
		const string QUEST_TYPE = "kill_target";
		const string QUEST_DATA1 = "monsters/orc_warrior;Badass Phycho";
		const string QUEST_DATA2 = "killtarget_place";
		const int QUEST_DATA3 = 1;
		const int QUEST_DATA4 = 0;
		const string QUEST_REWARD_TYPE = "gm";
		const string QUEST_REWARD_EVENT = "old_helena_warboss_died";
		const int QUEST_REWARD_ALL = 0;
		const string QUEST_COMPLETE_TEXT = "(Collect Reward)";
		const string QUEST_WAITING_TEXT = "Hail";
		const string QUEST_ASKING_TEXT = "Blood? From Borderlands?";
		const string QUEST_ACTIVE_TEXT = "(In Progress)";
		const string QUEST_INTRO_CHAT = "Hey. Me and blood here are taking on a bounty. If you help us, I'll cut you in on the reward.";
		const string QUEST_INTRO_SOUND = "amb\squawk1.wav";
		const string QUEST_ACTIVATE_CHAT = "Borderlands? Look, whether or not you wanna do this, he's around here. Be careful.";
		const int QUEST_ACTIVATE_SOUND = 0;
		const string QUEST_FINISHED_CHAT = "Feel it!";
		const int QUEST_FINISHED_SOUND = 0;
		const string QUEST_COMPLETE_CHAT = "Well, I suppose it's only fair I cut you in. Thanks.";
		const int QUEST_COMPLETE_SOUND = 0;
		const string QUEST_FADE_ON_COMPLETE = "fade";
		const string QUEST_GIVER_NAME = "Mordecai";
		const string NEW_RACE = "human";
		const int AM_INVINCIBLE = 0;
		const int NEW_WIDTH = 32;
		const int NEW_HEIGHT = 32;
		const int MONSTER_MODEL = 0;
		const string SUBMODEL_GROUPS = "0;0";
		const int USE_SKIN = 4;
		const int SET_SIEGE_MODE = 0;
		const int QUEST_COMBATANT = 1;
		const int QUEST_ACTIVE_COMBATANT = 0;
		const int QUEST_FOLLOWER = 0;
		const int IS_LEADER = 0;
		const int USE_LANTERN = 1;
		const string LANTERN_COLOR = "(128,64,0)";
		INIT_IDLE_MODE = "sitting";
		const int QUEST_EXPERT_COMBATANT = 0;
	}

}

}
