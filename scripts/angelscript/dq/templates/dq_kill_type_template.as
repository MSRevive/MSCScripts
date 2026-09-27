#pragma context server

#include "dq/quests/dq_kill_type.as"
#include "dq/templates/bases/dq_generic_reward.as"
#include "dq/templates/bases/dq_generic_menus.as"
#include "dq/templates/bases/dq_generic_chat.as"
#include "dq/quest_dwarf.as"

namespace MS
{

class DqKillTypeTemplate : CGameScript
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

	DqKillTypeTemplate()
	{
		QUEST_TYPE = "kill_type";
		QUEST_DATA1 = "1;orc";
		QUEST_REWARD_TYPE = "gm";
		QUEST_REWARD_EVENT = "old_helena_warboss_died";
		QUEST_REWARD_ALL = 0;
		QUEST_COMPLETE_TEXT = "(Collect Reward)";
		QUEST_WAITING_TEXT = "Hey";
		QUEST_ASKING_TEXT = "I'm more just curious";
		QUEST_ACTIVE_TEXT = "(In Progress)";
		QUEST_SHOW_PROGRESS = 1;
		QUEST_PROGRESS_VAR = DQ_KILLED;
		QUEST_PROGRESS_MAX = DQ_FIND_NUM;
		QUEST_INTRO_CHAT = "ORC HEAD ON A STICK JUST 10 GOLD! Wait... I need the orc head first. Help?";
		QUEST_INTRO_SOUND = 0;
		QUEST_ACTIVATE_CHAT = "GOOD! I also expect the 10 gold when you're back.";
		QUEST_ACTIVATE_SOUND = 0;
		QUEST_FINISHED_CHAT = "OK THAT'S GOOD I NEED YOU BACK NOW!";
		QUEST_FINISHED_SOUND = 0;
		QUEST_COMPLETE_CHAT = "I lied. Byebye.";
		QUEST_COMPLETE_SOUND = 0;
		QUEST_FADE_ON_COMPLETE = "fade";
		QUEST_GIVER_NAME = "Weird Dwarf";
		NEW_RACE = "beloved";
		AM_INVINCIBLE = 1;
		NEW_WIDTH = 32;
		NEW_HEIGHT = 32;
		MONSTER_MODEL = 0;
		SUBMODEL_GROUPS = "0;0";
		USE_SKIN = 2;
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

}

}
