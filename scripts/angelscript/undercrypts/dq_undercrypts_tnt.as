#pragma context server

#include "dq/quest_dwarf.as"
#include "dq/quests/dq_fetch_items.as"
#include "dq/dq_base_menus.as"

namespace MS
{

class DqUndercryptsTnt : CGameScript
{
	int AM_INVINCIBLE;
	int CHAT_AUTO_FACE;
	string CHAT_CONV_ANIMS;
	int CHAT_FACE_ON_USE;
	int CHAT_NEVER_INTERRUPT;
	int CHAT_USE_CONV_ANIMS;
	int DID_TNT_COMMENT;
	string INIT_IDLE_MODE;
	int IS_LEADER;
	string LANTERN_COLOR;
	int MONSTER_MODEL;
	int NEW_HEIGHT;
	string NEW_RACE;
	int NEW_WIDTH;
	int QUEST_ACTIVE_COMBATANT;
	string QUEST_ACTIVE_TEXT;
	string QUEST_ASKING_TEXT;
	int QUEST_COMBATANT;
	string QUEST_COMPLETE_TEXT;
	string QUEST_DATA1;
	string QUEST_DATA2;
	int QUEST_DATA3;
	int QUEST_EXPERT_COMBATANT;
	string QUEST_FADE_ON_COMPLETE;
	int QUEST_FOLLOWER;
	string QUEST_GIVER_NAME;
	int QUEST_REWARD_ALL;
	string QUEST_REWARD_EVENT;
	string QUEST_REWARD_TYPE;
	string QUEST_TYPE;
	string QUEST_WAITING_TEXT;
	int SET_SIEGE_MODE;
	string SUBMODEL_GROUPS;
	int USE_LANTERN;
	int USE_SKIN;

	DqUndercryptsTnt()
	{
		QUEST_TYPE = "fetch_items";
		QUEST_DATA1 = "qst_tnt_";
		QUEST_DATA2 = "tnt;Blasted Blasting Sticks";
		QUEST_DATA3 = 0;
		QUEST_REWARD_TYPE = "script";
		QUEST_REWARD_EVENT = "quest_tnt_complete";
		QUEST_REWARD_ALL = 0;
		QUEST_WAITING_TEXT = "Hail.";
		QUEST_ASKING_TEXT = "I will find those explosives.";
		QUEST_ACTIVE_TEXT = "(Explosives found: %n/%r)";
		QUEST_COMPLETE_TEXT = "(Collect Reward)";
		QUEST_FADE_ON_COMPLETE = "fade";
		QUEST_GIVER_NAME = "Halsof";
		NEW_RACE = "beloved";
		AM_INVINCIBLE = 1;
		NEW_WIDTH = 32;
		NEW_HEIGHT = 32;
		MONSTER_MODEL = 0;
		SUBMODEL_GROUPS = "0;0;1";
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
		CHAT_AUTO_FACE = 0;
		CHAT_FACE_ON_USE = 0;
		CHAT_NEVER_INTERRUPT = 1;
		CHAT_CONV_ANIMS = "anim_sit_convo;anim_sit_idle_lantern";
		CHAT_USE_CONV_ANIMS = 1;
		QUEST_REWARD_ALL = 1;
	}

	void OnSpawn() override
	{
		SetNoPush(true);
		SetInvincible(true);
		SetRace("beloved");
		SetMonsterClip(0);
		SetName("halsof");
		SetModelBody(2, 1);
	}

	void quest_intro()
	{
		chat_now("Ooohh... Hail there yourself. Finally, something that isn't bleedin' mad or undead.");
		chat_now("The three of us apparently dug a wrong path, fell, and got outselves stuck down here.");
		chat_now("Well, the two of us now... We woulda blown our way out through that old cart tunnel and been half way back to Gate City by now, but...");
		chat_now("...our 'explosives expert' Brynkahd, bloody blast powder sniffer that he is, just came apart after seeing all the horrors lurking around here.");
		chat_now("Thought he was workin on setting the bombs up, but apparently he was just sniffing powder until he finally blew his brains out!");
		chat_now("He attacked me, and Gesoth over there, and then ran off with all the blasted blasting sticks.");
		chat_now("Tried to chase him, but the beasts got between him and us, and... We had to run back here for cover.");
		chat_now("If ya find his corpse, or our explosives out there, maybe ya could bring em back to us?");
		chat_now("I mean just the boom sticks - Brynkahd can rot out there for all I care.", 3.0, "anim_sit_convo", "resend_menu");
		EmitSound(GetOwner(), 2, "voices/dwarf/vs_nx0drogm_hi.wav", 10);
	}

	void resend_menu()
	{
		OpenMenu(OFFER_MENU_ID);
	}

	void quest_activate()
	{
		chat_now("Thanks. Think we'll be fine waitin here for awhile, got this place borded up pretty good.");
		EmitSound(GetOwner(), 2, "voices/dwarf/vs_nx0drogm_yes.wav", 10);
	}

	void quest_complete()
	{
		chat_now("Thank ye! That'll do us just fine. Take this for yer troubles...");
		EmitSound(GetOwner(), 2, "voices/dwarf/vs_nx0drogm_vict.wav", 10);
		custom_quest_complete();
	}

	void do_chat_ext_recieve_quest_item()
	{
		if (QUEST_MODE == "active")
		{
			if (!(CHAT_BUSY))
			{
				chat_now("Yup, that's what we're lookin for. Keep em coming! We'll need at least a dozen bundles.");
				EmitSound(GetOwner(), 2, "none", 10);
			}
		}
	}

	void ext_receive_quest_item()
	{
		ScheduleDelayedEvent(0.1, "do_chat_ext_recieve_quest_item");
	}

	void custom_quest_complete()
	{
		UseTrigger("mm_qminers_done");
		CallExternal(FindEntityByName("gesoth"), "ext_remove");
	}

	void ext_found_nearby_tnt()
	{
		if ((DID_TNT_COMMENT)) return;
		DID_TNT_COMMENT = 1;
		EmitSound(GetOwner(), 2, "voices/dwarf/vs_nx0drogm_haha.wav", 10);
		chat_now("By Urdual's left nostril! How'd we miss that one!?");
		ScheduleDelayedEvent(3.0, "found_nearby_tnt2");
	}

	void found_nearby_tnt2()
	{
		CallExternal(FindEntityByName("gesoth"), "ext_found_tnt");
		ScheduleDelayedEvent(3.0, "found_nearby_tnt3");
	}

	void found_nearby_tnt3()
	{
		chat_now("Bloody... Bah. Bring it down and I'll add it to the collection.");
	}

}

}
