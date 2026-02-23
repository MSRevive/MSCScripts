#pragma context server

#include "NPCs/human_guard_sword.as"
#include "helena/helena_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Blacksmith : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	int CANCHAT;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	int CHAT_STEPS;
	int COUNT;
	float DELAY;
	int HELENA_SAVED;
	int MADE_IT_HOME;
	string NEXT_DAGGER_CHAT;
	float OVERCHARGE;
	int REST;
	string SELL_RATIO;
	int SELL_WEAPON_LEVEL;
	int STORE_CLOSED;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;

	Blacksmith()
	{
		const int CUSTOM_GUARD = 1;
		ANIM_DEATH = "dieforward";
		ANIM_ATTACK = "beatdoor";
		const int BG_MAX_HEAR_CIV = 400;
		MADE_IT_HOME = 1;
		COUNT = 0;
		REST = 10;
		DELAY = 1.05;
		Precache("amb/fx_anvil.wav");
		const int NO_CHAT = 1;
		STORE_NAME = "helena_bs";
		STORE_SELLMENU = 1;
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_NAME = "helena_general_store";
		CANCHAT = 1;
		OVERCHARGE = 1.5;
		ANIM_DEATH = "dieforward";
		const int NO_CHAT = 1;
		SELL_WEAPON_LEVEL = 6;
		const int VEND_ARMORER = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(DELAY);
		if ((MADE_IT_HOME))
		{
		}
		if (COUNT < 8)
		{
			PlayAnim("critical", "smith_hammer_time");
			COUNT += 1;
		}
		if (COUNT == 8)
		{
			if (REST > 0)
			{
				if (DELAY == 8.36)
				{
					PlayAnim("critical", "smith_hammer_look");
					COUNT = 0;
					DELAY = 1.05;
					REST--;
				}
				else
				{
					DELAY = 8.36;
				}
			}
		}
		if (REST == 0)
		{
			if (DELAY == 10.86)
			{
				PlayAnim("critical", "smith_hammer_idle");
				REST = 10;
				COUNT = 0;
				DELAY = 1.05;
			}
			else
			{
				DELAY = 10.86;
			}
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(1.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if ((IsEntityAlive(m_hAttackTarget)))
		{
		}
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
		}
		PlayAnim("once", ANIM_ATTACK);
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, 20.0, 0.8, "blunt");
		if ((false))
		{
		}
		npcatk_setmovedest(m_hLastSeen, 32, "internal");
	}

	void OnSpawn() override
	{
		SetHealth(550);
		SetName("Dorfgan");
		SetWidth(20);
		SetHeight(72);
		SetRoam(false);
		SetRace("hguard");
		SetModel("npc/blacksmith.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 2);
		SetIdleAnim("smith_hammer_time");
		SetAngles("face");
	}

	void hammer_sound()
	{
		EmitSound(GetOwner(), 0, "amb/fx_anvil.wav", 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(0, 0);
		SetModelBody(1, 0);
	}

	void helena_flee()
	{
	}

	void helena_raid_end()
	{
		HELENA_SAVED = 1;
	}

	void going_home()
	{
		ScheduleDelayedEvent(30, "check_at_home");
	}

	void check_at_home()
	{
		if ((MADE_IT_HOME)) return;
		SetEntityOrigin(GetOwner(), MY_GUARD_POST);
		SetAngles("face");
	}

	void baseguard_made_it_home()
	{
		SetModelBody(0, 1);
		SetModelBody(1, 2);
		SetIdleAnim("smith_hammer_time");
		if ((HELENA_SAVED))
		{
			NpcStoreRemove(STORE_NAME, "allitems");
			OVERCHARGE = 0.75;
			SELL_RATIO = 1.0;
			vendor_addstoreitems();
		}
		SetMenuAutoOpen(1);
		STORE_CLOSED = 0;
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "skin_ratpelt", 0, 100, 1.0);
		AddStoreItem(STORE_NAME, "skin_boar", 0, 100, 1.0);
		AddStoreItem(STORE_NAME, "skin_boar_heavy", 0, 100, 1.0);
		AddStoreItem(STORE_NAME, "skin_bear", 0, 100, 1.0);
		AddStoreItem(STORE_NAME, "armor_leather_torn", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_leather", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_leather_studded", RandomInt(0, 1), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_plate", RandomInt(0, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_plate", RandomInt(0, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "shields_ironshield", RandomInt(0, 3), OVERCHARGE, 0.25);
		AddStoreItem(STORE_NAME, "shields_buckler", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_golden", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_golden", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_dark", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_dark", 0, 100, SELL_RATIO);
	}

	void basevendor_offerstore()
	{
		if ((HELENA_SAVED)) return;
		SayText("I'll buy any good animal skins you have as well.");
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		Say("goods[.56] [.4] [.58] [.66]");
		CANCHAT = 0;
	}

	void helena_raid_go()
	{
		baseguard_tobattle();
	}

	void baseguard_tobattle()
	{
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetIdleAnim("idle1");
		SetMenuAutoOpen(0);
		STORE_CLOSED = 1;
	}

	void npcatk_ally_alert()
	{
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if (!(ItemExists(param1, "smallarms_rd"))) return;
		if (!(GetGameTime() > NEXT_DAGGER_CHAT)) return;
		NEXT_DAGGER_CHAT = GetGameTime();
		NEXT_DAGGER_CHAT += 60.0;
		dagger_chat();
	}

	void dagger_chat()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "dagger_chat");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Oh wow, I think that rusted dagger you have there might be one of those ancient ether daggers.";
		CHAT_STEP2 = "Back in the Age of Blood, some of the elvish armies used those. The blade passes through armor as if it weren't even there.";
		CHAT_STEP3 = "I wish I could fix it up for you, but alas, my elbow joints can't take that kind of stress anymore.";
		CHAT_STEP4 = "If only I was young again...";
		CHAT_STEPS = 4;
		chat_loop();
	}

	void game_menu_getoptions()
	{
		if (!(ItemExists(param1, "smallarms_rd"))) return;
		string reg.mitem.title = "About Rusted Dagger";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "dagger_chat";
	}

}

}
