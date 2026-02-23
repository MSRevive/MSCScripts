#pragma context server

#include "helena/orcwarrior_hard.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class OrcChatter2 : CGameScript
{
	int IN_COMBAT;
	string ORC_BUDDY_ID;

	OrcChatter2()
	{
		const int CHAT_USE_CONV_ANIMS = 0;
		const int CHAT_NO_CLOSE_MOUTH = 1;
		const int CHAT_AUTO_FACE = 0;
	}

	void orc_spawn()
	{
		SetName("Blackhand Warrior");
		SetSayTextRange(1024);
		SetName("orc_chatter2");
		SetRoam(false);
		SetHearingSensitivity(0);
		npcatk_suspend_ai();
	}

	void start_combat()
	{
	}

	void ext_do_chat_step()
	{
		if ((IN_COMBAT)) return;
		RESPONSE_INDEX += 1;
		if (RESPONSE_INDEX == 1)
		{
			chat_now("Relax! We don't have to fight them - we just have to warn the others and get out through the tunnels.", 5.5, "neigh", "none", "add_to_que", "clear_que");
			chat_now("It's a maze down there, they'll never catch us!", 2.5, "neigh", "request_response", "add_to_que");
		}
		if (RESPONSE_INDEX == 2)
		{
			chat_now("You mean those big guys with the red scales and fire in their eyes?", 4.5, "nod_yes", "request_response", "add_to_que");
		}
		if (RESPONSE_INDEX == 3)
		{
			chat_now("I don't know... I think I'd look good in red!", 4.0, "nod_yes", "request_response", "add_to_que");
		}
		if (RESPONSE_INDEX == 4)
		{
			chat_now("You worry too much my friend!", 2.5, "neigh", "none", "add_to_que");
			chat_now("But we should go check on the other side - there's way too many ways into this place.", 4.5, "none", "request_response", "add_to_que");
		}
	}

	void request_response()
	{
		if ((IN_COMBAT)) return;
		if (ORC_BUDDY_ID == "ORC_BUDDY_ID")
		{
			ORC_BUDDY_ID = FindEntityByName("orc_chatter1");
		}
		CallExternal(ORC_BUDDY_ID, "ext_do_chat_step");
		if (RESPONSE_INDEX == 4)
		{
			start_wander();
		}
	}

	void start_wander()
	{
		if ((IN_COMBAT)) return;
		CallExternal(ORC_BUDDY_ID, "turn_mclip_on");
		SetRoam(true);
		PlayAnim("once", "break");
		npcatk_resume_ai();
		SetHearingSensitivity(2);
		npcatk_setmovedest(Vector3(2320, -688, -528), 32);
	}

	void OnDamage(int damage) override
	{
		if ((IN_COMBAT)) return;
		start_combat();
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((IN_COMBAT)) return;
		if (!(false)) return;
		start_combat();
	}

	void start_combat()
	{
		if ((IN_COMBAT)) return;
		IN_COMBAT = 1;
		chat_clear_que();
		ScheduleDelayedEvent(3.0, "start_combat2");
		npcatk_resume_ai();
		SetHearingSensitivity(4);
		if (param1 == "game_damaged")
		{
			npcatk_settarget(GetEntityIndex(m_hLastStruck));
		}
		else
		{
			if ((IsEntityAlive(param1)))
			{
				npcatk_settarget(GetEntityIndex(param1));
			}
			else
			{
				npcatk_settarget(GetEntityIndex(m_hLastSeen));
			}
		}
		if (!(GetEntityProperty(ORC_BUDDY_ID, "scriptvar")))
		{
			CallExternal(ORC_BUDDY_ID, "start_combat", m_hAttackTarget);
		}
	}

	void start_combat2()
	{
		CallExternal(ORC_BUDDY_ID, "turn_mclip_on");
		if (GetPlayerCount() > 1)
		{
			SayText("I don t know, but we better make short work of them and warn the others!");
		}
		else
		{
			SayText("I don t know, but we better make short work of him and warn the others!");
		}
		EmitSound(GetOwner(), 0, "voices/orc/help.wav", 10);
	}

	void ext_gender_gag1()
	{
		SayText("How can you tell!?");
	}

	void ext_gender_gag2()
	{
		SayText("That s... Nice... But maybe we ask her for a date AFTER we kill her!");
	}

	void ext_gender_gag3()
	{
		SayText("Just shut up and fight!");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (ORC_BUDDY_ID == "ORC_BUDDY_ID")
		{
			ORC_BUDDY_ID = FindEntityByName("orc_chatter1");
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(ORC_BUDDY_ID, "turn_mclip_on");
	}

}

}
