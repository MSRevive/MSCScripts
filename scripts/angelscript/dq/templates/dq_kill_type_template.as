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
	string INIT_IDLE_MODE;

	DqKillTypeTemplate()
	{
		const string QUEST_TYPE = "kill_type";
		const string QUEST_DATA1 = "1;orc";
		const string QUEST_REWARD_TYPE = "gm";
		const string QUEST_REWARD_EVENT = "old_helena_warboss_died";
		const int QUEST_REWARD_ALL = 0;
		const string QUEST_COMPLETE_TEXT = "(Collect Reward)";
		const string QUEST_WAITING_TEXT = "Hey";
		const string QUEST_ASKING_TEXT = "I'm more just curious";
		const string QUEST_ACTIVE_TEXT = "(In Progress)";
		const int QUEST_SHOW_PROGRESS = 1;
		const string QUEST_PROGRESS_VAR = DQ_KILLED;
		const string QUEST_PROGRESS_MAX = DQ_FIND_NUM;
		const string QUEST_INTRO_CHAT = "ORC HEAD ON A STICK JUST 10 GOLD! Wait... I need the orc head first. Help?";
		const int QUEST_INTRO_SOUND = 0;
		const string QUEST_ACTIVATE_CHAT = "GOOD! I also expect the 10 gold when you're back.";
		const int QUEST_ACTIVATE_SOUND = 0;
		const string QUEST_FINISHED_CHAT = "OK THAT'S GOOD I NEED YOU BACK NOW!";
		const int QUEST_FINISHED_SOUND = 0;
		const string QUEST_COMPLETE_CHAT = "I lied. Byebye.";
		const int QUEST_COMPLETE_SOUND = 0;
		const string QUEST_FADE_ON_COMPLETE = "fade";
		const string QUEST_GIVER_NAME = "Weird Dwarf";
		const string NEW_RACE = "beloved";
		const int AM_INVINCIBLE = 1;
		const int NEW_WIDTH = 32;
		const int NEW_HEIGHT = 32;
		const int MONSTER_MODEL = 0;
		const string SUBMODEL_GROUPS = "0;0";
		const int USE_SKIN = 2;
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

}

}
