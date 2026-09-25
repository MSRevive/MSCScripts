#pragma context server

#include "monsters/orc_flayer.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class OrcChatter1 : CGameScript
{
	int CHAT_AUTO_FACE;
	int CHAT_NO_CLOSE_MOUTH;
	int CHAT_USE_CONV_ANIMS;
	int IN_COMBAT;
	int NEXT_RESPONSE_INDEX;
	string ORC_BUDDY_ID;
	int TURNED_MCLIP_ON;

	OrcChatter1()
	{
		CHAT_USE_CONV_ANIMS = 0;
		CHAT_NO_CLOSE_MOUTH = 1;
		CHAT_AUTO_FACE = 0;
	}

	void orc_spawn()
	{
		SetName("Blackhand Flayer");
		SetSayTextRange(1024);
		SetName("orc_chatter1");
		SetRoam(false);
		npcatk_suspend_ai();
		ScheduleDelayedEvent(1.0, "start_chat");
	}

	void start_chat()
	{
		if ((IN_COMBAT)) return;
		NEXT_RESPONSE_INDEX = 1;
		chat_now("This is insane... Rummaging through ruins so far inside Shadahar territory... What is Furux thinking!?", 5.0, "neigh", "request_response", "clear_que", "add_to_que");
	}

	void request_response()
	{
		if ((IN_COMBAT)) return;
		if (ORC_BUDDY_ID == "ORC_BUDDY_ID")
		{
			ORC_BUDDY_ID = FindEntityByName("orc_chatter2");
		}
		CallExternal(ORC_BUDDY_ID, "ext_do_chat_step");
	}

	void ext_do_chat_step()
	{
		if ((IN_COMBAT)) return;
		RESPONSE_INDEX += 1;
		if (RESPONSE_INDEX == 1)
		{
			chat_now("I still don't like it... Have you seen those guys he brought with him?", 4.5, "nod_yes", "request_response", "add_to_que");
		}
		if (RESPONSE_INDEX == 2)
		{
			chat_now("Yeah... I'm sure this all has something to do with them.", 4.5, "nod_yes", "none", "add_to_que");
			chat_now("All this damn magic stuff creeps me out...", 3.0, "neigh", "request_response", "add_to_que");
		}
		if (RESPONSE_INDEX == 3)
		{
			chat_now("By Torkalath, you are an idiot!", 3.0, "flinch", "request_response", "add_to_que");
		}
		if (RESPONSE_INDEX == 4)
		{
			chat_now("*sigh* Alright... My back's getting sore just standing here like this anyways.", 3.0, "nod_yes", "start_wander", "add_to_que");
		}
	}

	void start_wander()
	{
		if ((IN_COMBAT)) return;
		PlayAnim("once", "break");
		SetRoam(true);
		npcatk_resume_ai();
		SetHearingSensitivity(2);
		npcatk_setmovedest(Vector3(2320, -688, -528), 32);
		turn_mclip_on();
	}

	void do_chat3()
	{
		CallExternal(ORC_BUDDY_ID, "ext_start_chat");
	}

	void OnDamage(int damage) override
	{
		if ((IN_COMBAT)) return;
		start_combat("game_damaged");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((IN_COMBAT)) return;
		if (!(false)) return;
		start_combat();
		if (ORC_BUDDY_ID == "ORC_BUDDY_ID")
		{
			ORC_BUDDY_ID = FindEntityByName("orc_chatter2");
		}
	}

	void start_combat()
	{
		if ((IN_COMBAT)) return;
		IN_COMBAT = 1;
		chat_clear_que();
		string L_SAYTEXT_STR = "";
		ScheduleDelayedEvent(6.0, "start_combat2");
		ScheduleDelayedEvent(2.0, "turn_mclip_on");
		npcatk_resume_ai();
		SetHearingSensitivity(4);
		if (param1 == "game_damaged")
		{
			npcatk_settarget(GetEntityIndex(m_hLastStruck));
			string L_SAYTEXT_STR = "Ow...! ";
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
		if (GetPlayerCount() > 1)
		{
			L_SAYTEXT_STR += "What the... Where'd these guys come from!?";
		}
		else
		{
			L_SAYTEXT_STR += "What the... Where'd this guy come from!?";
		}
		SayText(L_SAYTEXT_STR);
		if (!(GetEntityProperty(ORC_BUDDY_ID, "scriptvar")))
		{
			CallExternal(ORC_BUDDY_ID, "start_combat", m_hAttackTarget);
		}
	}

	void start_combat2()
	{
		if (!(GetPlayerCount() == 1)) return;
		if (!(GetGender(m_hAttackTarget) == "female")) return;
		SayText(I + " think *he* might be a *she*...");
		ScheduleDelayedEvent(2.0, "gender_gag");
		ScheduleDelayedEvent(4.0, "gender_gag2");
		ScheduleDelayedEvent(6.0, "gender_gag3");
		ScheduleDelayedEvent(8.0, "gender_gag4");
		ScheduleDelayedEvent(10.0, "gender_gag5");
	}

	void gender_gag()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		CallExternal(ORC_BUDDY_ID, "ext_gender_gag1");
	}

	void gender_gag2()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		SayText("The human women have bumps on their chests...");
	}

	void gender_gag3()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		CallExternal(ORC_BUDDY_ID, "ext_gender_gag2");
	}

	void gender_gag4()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		SayText(I + " m just saying...");
	}

	void gender_gag5()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		CallExternal(ORC_BUDDY_ID, "ext_gender_gag3");
	}

	void turn_mclip_on()
	{
		if ((TURNED_MCLIP_ON)) return;
		TURNED_MCLIP_ON = 1;
		UseTrigger("mclip_toggle");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		turn_mclip_on();
	}

}

}
