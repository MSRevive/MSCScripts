#pragma context server

#include "dq/quest_dwarf.as"
#include "dq/quests/dq_fetch_items.as"
#include "dq/dq_base_menus.as"

namespace MS
{

class DqUndercryptsTnt : CGameScript
{
	int DID_TNT_COMMENT;
	string INIT_IDLE_MODE;

	DqUndercryptsTnt()
	{
		const string QUEST_TYPE = "fetch_items";
		const string QUEST_DATA1 = "qst_tnt_";
		const string QUEST_DATA2 = "tnt;Blasted Blasting Sticks";
		const int QUEST_DATA3 = 0;
		const string QUEST_REWARD_TYPE = "script";
		const string QUEST_REWARD_EVENT = "quest_tnt_complete";
		const int QUEST_REWARD_ALL = 0;
		const string QUEST_WAITING_TEXT = "Hail.";
		const string QUEST_ASKING_TEXT = "I will find those explosives.";
		const string QUEST_ACTIVE_TEXT = "(Explosives found: %n/%r)";
		const string QUEST_COMPLETE_TEXT = "(Collect Reward)";
		const string QUEST_FADE_ON_COMPLETE = "fade";
		const string QUEST_GIVER_NAME = "Halsof";
		const string NEW_RACE = "beloved";
		const int AM_INVINCIBLE = 1;
		const int NEW_WIDTH = 32;
		const int NEW_HEIGHT = 32;
		const int MONSTER_MODEL = 0;
		const string SUBMODEL_GROUPS = "0;0;1";
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
		const int CHAT_AUTO_FACE = 0;
		const int CHAT_FACE_ON_USE = 0;
		const int CHAT_NEVER_INTERRUPT = 1;
		const string CHAT_CONV_ANIMS = "anim_sit_convo;anim_sit_idle_lantern";
		const int CHAT_USE_CONV_ANIMS = 1;
		const int QUEST_REWARD_ALL = 1;
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
