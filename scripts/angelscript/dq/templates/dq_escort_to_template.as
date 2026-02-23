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
	string INIT_IDLE_MODE;

	DqEscortToTemplate()
	{
		const string QUEST_TYPE = "escort_to";
		const string QUEST_DATA1 = "escort_to_here";
		const string QUEST_REWARD_TYPE = "gm";
		const string QUEST_REWARD_EVENT = "old_helena_warboss_died";
		const int QUEST_REWARD_ALL = 0;
		const string QUEST_COMPLETE_TEXT = "(Collect Reward)";
		const string QUEST_WAITING_TEXT = "S-s-spiders...";
		const string QUEST_ASKING_TEXT = "S-S-SPIDERS!";
		const string QUEST_ACTIVE_TEXT = "(NPC currently in the throws of arachnophobia)";
		const string QUEST_INTRO_CHAT = "S-s-spiders... Spiders... Everywhere...";
		const int QUEST_INTRO_SOUND = 0;
		const string QUEST_ACTIVATE_CHAT = "SPAWN IS SAFE FROM THE S-SPIDERS!";
		const string QUEST_ACTIVATE_SOUND = "voices/dwarf/vs_ndwarfm1_hit1.wav";
		const string QUEST_FINISHED_CHAT = "T-thanks...";
		const int QUEST_FINISHED_SOUND = 0;
		const string QUEST_COMPLETE_CHAT = "P-probably, s-shoulda, g-given you this s-sooner...";
		const int QUEST_COMPLETE_SOUND = 0;
		const string QUEST_FADE_ON_COMPLETE = "fade";
		const string QUEST_GIVER_NAME = "Frightened Dwarf";
		const string NEW_RACE = "human";
		const int AM_INVINCIBLE = 0;
		const int NEW_WIDTH = 32;
		const int NEW_HEIGHT = 32;
		const int MONSTER_MODEL = 0;
		const string SUBMODEL_GROUPS = "0;0";
		const int USE_SKIN = 4;
		const int SET_SIEGE_MODE = 0;
		const int QUEST_COMBATANT = 0;
		const int QUEST_ACTIVE_COMBATANT = 0;
		const int QUEST_FOLLOWER = 1;
		const int IS_LEADER = 1;
		const int USE_LANTERN = 1;
		const string LANTERN_COLOR = "(128,64,0)";
		INIT_IDLE_MODE = "sitting";
		const int QUEST_EXPERT_COMBATANT = 0;
	}

}

}
