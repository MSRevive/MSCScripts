#pragma context server

#include "monsters/elf_warrior_base.as"
#include "monsters/base_chat.as"

namespace MS
{

class ElfWarriorGuard1 : CGameScript
{
	string ANIM_ATTACK;
	string CHAT_STEP1;
	string CHAT_STEPS;
	int NPC_GIVE_EXP;
	int NPC_NO_PLAYER_DMG;
	int NPC_RETURN_HOME;

	ElfWarriorGuard1()
	{
		NPC_GIVE_EXP = 0;
		const string DMG_TYPE = "pierce";
		const int DMG_MELEE = 800;
		NPC_NO_PLAYER_DMG = 1;
		NPC_RETURN_HOME = 1;
		const int NO_CHAT = 1;
		const int NPC_BATTLE_ALLY = 1;
		const string SOUND_HELLO = "npc/elvenfemale/vs_nnwnobf1_hi.wav";
		const string SOUND_VELEND = "npc/elvenfemale/vs_nnwnobf1_warn.wav";
	}

	void elf_spawn()
	{
		SetName("Elven Warrior");
		SetHealth(2000);
		SetDamageResistance("all", 0.5);
		SetRace("human");
		SetRoam(false);
		SetProp(GetOwner(), "skin", 1);
		SetModelBody(1, 4);
		SetModelBody(2, 3);
		SetMenuAutoOpen(1);
	}

	void OnPostSpawn() override
	{
		ANIM_ATTACK = "swordjab1_R";
	}

	void game_menu_getoptions()
	{
		if (m_hAttackTarget != "unset")
		{
			string reg.mitem.title = "(In combat...)";
			string reg.mitem.type = "disabled";
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SetMoveDest(param1);
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, SOUND_HELLO, 10);
		Say("[0.1] [0.3]");
		ScheduleDelayedEvent(0.6, "bchat_close_mouth");
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_hi";
	}

	void say_hi()
	{
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, SOUND_VELEND, 10);
		string LEADER_ID = FindEntityByName("elf_leader");
		if ((IsEntityAlive(LEADER_ID)))
		{
			CHAT_STEP1 = "Velend Varon speaks for us.";
			if (GetEntityRace(param1) == "human")
			{
				CHAT_STEP2 = "Address any questions you have to him, child of Torkaloth.";
			}
			else
			{
				CHAT_STEP2 = "Address any questions you have to him.";
			}
			CHAT_STEPS = 2;
			chat_loop();
		}
		else
		{
			SayText("Seeker Varon maybe dead , but I must still stand guard , as I await our reinforcements.");
		}
	}

}

}
