#pragma context server

#include "monsters/base_chat_array.as"
#include "monsters/base_npc.as"

namespace MS
{

class TelfQuest : CGameScript
{
	string CHAT_CURRENT_SPEAKER;
	int DID_INTRO;
	string HALF_HP;
	string HBAR_ADJ_POS;
	int MISSION_COMPLETE;
	string NEXT_WARN;
	int NPC_BATTLE_ALLY;
	int NPC_NO_PLAYER_DMG;
	string PLAYER_LIST;

	TelfQuest()
	{
		HBAR_ADJ_POS = Vector3(0, 0, -32);
		NPC_NO_PLAYER_DMG = 1;
		NPC_BATTLE_ALLY = 1;
		const int CHAT_USE_CONV_ANIMS = 0;
		const string SOUND_PAIN1 = "scientist/getoutalive.wav";
		const string SOUND_PAIN2 = "scientist/iwoundedbad.wav";
	}

	void OnSpawn() override
	{
		SetName("Fedrosh the Rammata");
		SetModel("npc/elf_m_wizard.mdl");
		SetWidth(32);
		SetHeight(96);
		SetIdleAnim("deep_idle");
		SetMoveAnim("deep_idle");
		SetRace("human");
		SetHealth(5000);
		SetDamageResistance("all", 0.5);
		SetNoPush(true);
		if (!(true)) return;
		SetName("telf_quest");
		ScheduleDelayedEvent(0.1, "scan_for_players");
		ScheduleDelayedEvent(2.0, "finalize_npc");
	}

	void finalize_npc()
	{
		HALF_HP = GetEntityMaxHealth(GetOwner());
		HALF_HP *= 0.5;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((MISSION_COMPLETE)) return;
		CallExternal("all", "ext_shender_fail");
		UseTrigger("sound_nightmare_fail");
		PLAYER_LIST = "";
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			respawn_players();
		}
		SendInfoMsg("all", "A CRITIAL NPC HAS DIED! Fedrosh the Rammata is dead.");
		ClientCommand("all", "cd fadeout");
	}

	void respawn_players()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		string SPAWN_NAME = GetPlayerQuestData(CUR_TARG, "d");
		// TODO: tospawn CUR_TARG SPAWN_NAME
	}

	void scan_for_players()
	{
		if ((DID_INTRO)) return;
		PLAYER_LIST = "";
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			check_players();
		}
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(1.0, "scan_for_players");
	}

	void check_players()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if ((DID_INTRO)) return;
		if (!(GetEntityRange(CUR_TARG) < 256)) return;
		DID_INTRO = 1;
		CHAT_CURRENT_SPEAKER = CUR_TARG;
		ScheduleDelayedEvent(2.0, "do_intro");
	}

	void do_intro()
	{
		if (GetEntityRace(CHAT_CURRENT_SPEAKER) == "human")
		{
			if (GetPlayerCount() > 1)
			{
				chat_now("Children of Torkalath!?", 1.0, "convo_unarmed_norm", "none", "add_to_que");
			}
			else
			{
				chat_now("A child of Torkalath!?", 1.0, "convo_unarmed_norm", "none", "add_to_que");
			}
		}
		chat_now("Surely the Lord of Might has sent you to save me!", 2.0, "none", "none", "add_to_que");
		chat_now("I am Fedrosh, a Ramatta refugee. I was attacked by Seekers after the location of our stronghold.", 5.0, "none", "none", "add_to_que");
		chat_now("I drove them off, but not before one muttered a curse against me.", 4.0, "none", "none", "add_to_que");
		chat_now("Nothing happened, so I thought it was a bluff. But when I slept that eve, I awoke here.", 5.0, "none", "none", "add_to_que");
		chat_now("Now, each day, nightmarish servants of Felewyn appear and tear me apart!", 5.0, "convo_unarmed_norm", "none", "add_to_que");
		chat_now("My magic does not work here, so I cannot defend myself... But maybe yours will!", 5.0, "none", "nightmare_start", "add_to_que");
		chat_now("By Torkalath! They are coming! Prepare yourselves!", 3.0, "convo_unarmed_panic", "none", "add_to_que");
	}

	void nightmare_start()
	{
		ScheduleDelayedEvent(1.0, "nightmare_start2");
	}

	void nightmare_start2()
	{
		SetIdleAnim("cower_idle");
		SetMoveAnim("cower_idle");
		UseTrigger("mm_nightmare_begin");
	}

	void game_targeted_by_player()
	{
		CallExternal(param1, "ext_show_hbar_monster", GetEntityIndex(GetOwner()), 1);
	}

	void OnDamage(int damage) override
	{
		if ((IsValidPlayer(param1)))
		{
			SetDamage("dmg");
			SetDamage("hit");
			return;
		}
		else
		{
			if (GetGameTime() > NEXT_WARN)
			{
			}
			NEXT_WARN = GetGameTime();
			NEXT_WARN += 30.0;
			SendInfoMsg("all", "CRITICAL NPC UNDER ATTACK Fedrosh is under attack!");
			if (GetEntityHealth(GetOwner()) < HALF_HP)
			{
			}
			// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2
			array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void ext_quest_win()
	{
		MISSION_COMPLETE = 1;
		SetInvincible(true);
		DeleteEntity(GetOwner());
	}

}

}
