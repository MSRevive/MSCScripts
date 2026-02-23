#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class SorcAlchemist : CGameScript
{
	int CHAT_TEMP_NO_AUTO_FACE;
	int CHIEF_GONE;
	int DID_INTRO;
	int PLAYING_DEAD;
	string PLR_INTRO;
	string SORC_CHIEF_ID;
	string STORE_NAME;

	SorcAlchemist()
	{
		const int CHAT_USE_CONV_ANIMS = 0;
		const int CHAT_NO_CLOSE_MOUTH = 1;
		const int CHAT_NEVER_INTERRUPT = 1;
		STORE_NAME = "sorc_pots";
		const int VEND_INDIVIDUAL = 1;
		const string BUSY_COMMENT = "Stupid impatient humans... One at a time!";
	}

	void OnSpawn() override
	{
		SetName("Easkhar");
		SetName("sorc_alchie");
		SetModel("monsters/sorc.mdl");
		SetHealth(5000);
		SetRace("beloved");
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetNoPush(true);
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		SetWidth(32);
		SetHeight(96);
		SetHearingSensitivity(11);
		SetModelBody(0, 0);
		SetModelBody(1, 2);
		SetModelBody(2, 0);
		SetSayTextRange(1024);
		ScheduleDelayedEvent(0.1, "crystal_complain");
		npcatk_suspend_ai();
		ScheduleDelayedEvent(0.1, "scan_for_players");
	}

	void crystal_complain()
	{
		SayText("*sigh* Just because I make the glue, they want *me* to fix the damned crystals when *they* break them...");
	}

	void OnPostSpawn() override
	{
		SetMenuAutoOpen(0);
	}

	void scan_for_players()
	{
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(0.5, "scan_for_players");
		if (!(false)) return;
		DID_INTRO = 1;
		PLR_INTRO = GetEntityIndex(m_hLastSeen);
		do_intro();
	}

	void do_intro()
	{
		chat_add_text("intro_chat", "Humans!? I care not what Chief Runeghar says, I am NOT selling to humans!", 5.0, "neigh");
		chat_add_text("intro_chat", "Go! Be gone with thee!", 2.0, "swordswing1_L");
		chat_start_sequence("intro_chat", "add_to_que");
		ScheduleDelayedEvent(7.0, "do_intro2");
	}

	void do_intro2()
	{
		SpawnNPC("sorc_villa/sorc_chief_image", Vector3(-1952, -3120, 48), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		SORC_CHIEF_ID = GetEntityIndex(m_hLastCreated);
	}

	void ext_face_chief()
	{
		SetMoveDest(SORC_CHIEF_ID);
		PlayAnim("critical", "flinch");
		ScheduleDelayedEvent(1.0, "ext_face_chief2");
	}

	void ext_face_chief2()
	{
		SetMoveDest(SORC_CHIEF_ID);
		PlayAnim("critical", "kneeling");
		ScheduleDelayedEvent(0.5, "ext_face_chief3");
	}

	void ext_face_chief3()
	{
		SetMoveDest(SORC_CHIEF_ID);
		PlayAnim("once", "break");
		PlayAnim("hold", "kneel");
		SetIdleAnim("kneel");
		SetMoveAnim("kneel");
	}

	void ext_chief_done_berating()
	{
		if ((CHAT_BUSY))
		{
			ScheduleDelayedEvent(0.1, "ext_chief_done_berating");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		CHAT_TEMP_NO_AUTO_FACE = 1;
		chat_add_text("sry_chief", "I... I am sorry, warchief! I... I understand.", 3.0);
		chat_add_text("sry_chief", "I will do as you say.", 3.0);
		chat_start_sequence("sry_chief", "add_to_que");
	}

	void ext_chief_gone()
	{
		CHAT_TEMP_NO_AUTO_FACE = 0;
		UseTrigger("twal_pot_block");
		CHIEF_GONE = 1;
		chat_add_text("chief_gone", "Bah, I still don't like it.", 3.0, "neigh");
		chat_add_text("chief_gone", "But fine, I will do business with you.", 3.0);
		chat_add_text("chief_gone", "I warn you, however, it won't be cheap.", 3.0, "nod_yes");
		chat_start_sequence("chief_gone", "add_to_que");
		string NEAR_PLAYER = FindEntitiesInSphere("players", 128);
		string NEAR_PLAYER = GetToken(NEAR_PLAYER, 0, ";");
		if (GetEntityRange(NEAR_PLAYER) < GetEntityRange(PLR_INTRO))
		{
			PLR_INTRO = NEAR_PLAYER;
		}
		SetMoveDest(PLR_INTRO);
		SetMoveAnim("idle1");
		SetIdleAnim("idle1");
		SetMenuAutoOpen(1);
	}

	void vendor_addstoreitems()
	{
		LogDebug("vendor_addstoreitems");
		AddStoreItem(STORE_NAME, "health_mpotion", 30, 400, 0.0);
		AddStoreItem(STORE_NAME, "health_lpotion", 30, 400, 0.0);
		AddStoreItem(STORE_NAME, "mana_speed", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_gprotection", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_protection", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_resist_cold", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_immune_cold", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_resist_fire", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_immune_fire", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_immune_poison", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_vampire", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_forget", 5, 300, 0.0);
		AddStoreItem(STORE_NAME, "mana_demon_blood", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_bravery", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_fbrand", 1, 500, 0.0);
		AddStoreItem(STORE_NAME, "mana_faura", 1, 300, 0.0);
		AddStoreItem(STORE_NAME, "mana_paura", 1, 300, 0.0);
		AddStoreItem(STORE_NAME, "mana_font", 1, 500, 0.0);
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(CHIEF_GONE)) return;
		if ((VENDOR_STORE_ACTIVE)) return;
		string LAST_HEARD = GetEntityIndex("ent_lastheard");
		if (!(IsValidPlayer(LAST_HEARD))) return;
		if (!(GetEntityRange(LAST_HEARD) < 256)) return;
		SetMoveDest(LAST_HEARD);
	}

	void ext_player_on_shelf()
	{
		if ((CHAT_BUSY)) return;
		PlayAnim("once", "warcry");
		chat_now("By the mighty Torkalath, you humans are like monkeys! GET OFF MY SHELVES!", 6.0, "add_to_que");
	}

	void ext_player_on_table()
	{
		if (!(CHIEF_GONE)) return;
		if ((CHAT_BUSY))
		{
			chat_now("...and could you, please, *try* not standing on my table...", 4.0, "add_to_que");
		}
		else
		{
			chat_now("Could you, please, try *not* standing on my table...", 4.0, "add_to_que");
		}
	}

}

}
