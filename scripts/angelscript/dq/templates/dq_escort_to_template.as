#pragma context server

#include "dq/quests/dq_escort_to.as"
#include "dq/templates/bases/dq_generic_reward.as"
#include "dq/templates/bases/dq_generic_menus.as"
#include "dq/templates/bases/dq_generic_chat.as"
#include "dq/quest_dwarf.as"

namespace MS
{

class DqEscortToTemplate : CGameScript
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
	int QUEST_REWARD_ALL;
	string QUEST_REWARD_EVENT;
	string QUEST_REWARD_TYPE;
	string QUEST_TYPE;
	string QUEST_WAITING_TEXT;
	int SET_SIEGE_MODE;
	string SUBMODEL_GROUPS;
	int USE_LANTERN;
	int USE_SKIN;

	DqEscortToTemplate()
	{
		QUEST_TYPE = "escort_to";
		QUEST_DATA1 = "escort_to_here";
		QUEST_REWARD_TYPE = "gm";
		QUEST_REWARD_EVENT = "old_helena_warboss_died";
		QUEST_REWARD_ALL = 0;
		QUEST_COMPLETE_TEXT = "(Collect Reward)";
		QUEST_WAITING_TEXT = "S-s-spiders...";
		QUEST_ASKING_TEXT = "S-S-SPIDERS!";
		QUEST_ACTIVE_TEXT = "(NPC currently in the throws of arachnophobia)";
		QUEST_INTRO_CHAT = "S-s-spiders... Spiders... Everywhere...";
		QUEST_INTRO_SOUND = 0;
		QUEST_ACTIVATE_CHAT = "SPAWN IS SAFE FROM THE S-SPIDERS!";
		QUEST_ACTIVATE_SOUND = "voices/dwarf/vs_ndwarfm1_hit1.wav";
		QUEST_FINISHED_CHAT = "T-thanks...";
		QUEST_FINISHED_SOUND = 0;
		QUEST_COMPLETE_CHAT = "P-probably, s-shoulda, g-given you this s-sooner...";
		QUEST_COMPLETE_SOUND = 0;
		QUEST_FADE_ON_COMPLETE = "fade";
		QUEST_GIVER_NAME = "Frightened Dwarf";
		NEW_RACE = "human";
		AM_INVINCIBLE = 0;
		NEW_WIDTH = 32;
		NEW_HEIGHT = 32;
		MONSTER_MODEL = 0;
		SUBMODEL_GROUPS = "0;0";
		USE_SKIN = 4;
		SET_SIEGE_MODE = 0;
		QUEST_COMBATANT = 0;
		QUEST_ACTIVE_COMBATANT = 0;
		QUEST_FOLLOWER = 1;
		IS_LEADER = 1;
		USE_LANTERN = 1;
		LANTERN_COLOR = "(128,64,0)";
		INIT_IDLE_MODE = "sitting";
		QUEST_EXPERT_COMBATANT = 0;
	}

}

}
