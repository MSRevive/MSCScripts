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
	int AM_INVINCIBLE;
	string INIT_IDLE_MODE;
	int IS_LEADER;
	string LANTERN_COLOR;
	int MONSTER_MODEL;
	int NEW_HEIGHT;
	string NEW_RACE;
	int NEW_WIDTH;
	string QUEST_ACTIVATE_CHAT;
	int QUEST_ACTIVATE_SOUND;
	int QUEST_ACTIVE_COMBATANT;
	string QUEST_ACTIVE_TEXT;
	string QUEST_ASKING_TEXT;
	int QUEST_COMBATANT;
	string QUEST_COMPLETE_CHAT;
	int QUEST_COMPLETE_SOUND;
	string QUEST_COMPLETE_TEXT;
	string QUEST_DATA1;
	string QUEST_DATA2;
	int QUEST_DATA3;
	int QUEST_DATA4;
	int QUEST_EXPERT_COMBATANT;
	string QUEST_FADE_ON_COMPLETE;
	string QUEST_FINISHED_CHAT;
	int QUEST_FINISHED_SOUND;
	int QUEST_FOLLOWER;
	string QUEST_GIVER_NAME;
	string QUEST_INTRO_CHAT;
	string QUEST_INTRO_SOUND;
	int QUEST_REWARD_ALL;
	string QUEST_REWARD_EVENT;
	string QUEST_REWARD_TYPE;
	string QUEST_TYPE;
	string QUEST_WAITING_TEXT;
	int SET_SIEGE_MODE;
	string SUBMODEL_GROUPS;
	int USE_LANTERN;
	int USE_SKIN;

	DqKillTargetTemplate()
	{
		QUEST_TYPE = "kill_target";
		QUEST_DATA1 = "monsters/orc_warrior;Badass Phycho";
		QUEST_DATA2 = "killtarget_place";
		QUEST_DATA3 = 1;
		QUEST_DATA4 = 0;
		QUEST_REWARD_TYPE = "gm";
		QUEST_REWARD_EVENT = "old_helena_warboss_died";
		QUEST_REWARD_ALL = 0;
		QUEST_COMPLETE_TEXT = "(Collect Reward)";
		QUEST_WAITING_TEXT = "Hail";
		QUEST_ASKING_TEXT = "Blood? From Borderlands?";
		QUEST_ACTIVE_TEXT = "(In Progress)";
		QUEST_INTRO_CHAT = "Hey. Me and blood here are taking on a bounty. If you help us, I'll cut you in on the reward.";
		QUEST_INTRO_SOUND = "amb\squawk1.wav";
		QUEST_ACTIVATE_CHAT = "Borderlands? Look, whether or not you wanna do this, he's around here. Be careful.";
		QUEST_ACTIVATE_SOUND = 0;
		QUEST_FINISHED_CHAT = "Feel it!";
		QUEST_FINISHED_SOUND = 0;
		QUEST_COMPLETE_CHAT = "Well, I suppose it's only fair I cut you in. Thanks.";
		QUEST_COMPLETE_SOUND = 0;
		QUEST_FADE_ON_COMPLETE = "fade";
		QUEST_GIVER_NAME = "Mordecai";
		NEW_RACE = "human";
		AM_INVINCIBLE = 0;
		NEW_WIDTH = 32;
		NEW_HEIGHT = 32;
		MONSTER_MODEL = 0;
		SUBMODEL_GROUPS = "0;0";
		USE_SKIN = 4;
		SET_SIEGE_MODE = 0;
		QUEST_COMBATANT = 1;
		QUEST_ACTIVE_COMBATANT = 0;
		QUEST_FOLLOWER = 0;
		IS_LEADER = 0;
		USE_LANTERN = 1;
		LANTERN_COLOR = "(128,64,0)";
		INIT_IDLE_MODE = "sitting";
		QUEST_EXPERT_COMBATANT = 0;
	}

}

}
