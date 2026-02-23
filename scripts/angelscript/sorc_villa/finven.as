#pragma context server

#include "monsters/base_npc_vendor.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class Finven : CGameScript
{
	string ARCHER_ID;
	int DID_INTRO;
	int NPC_CHECK_LEVEL;
	string PLAYER_ID;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;
	int VENDOR_MENU_OFF;
	int VENDOR_NOT_ON_USE;

	Finven()
	{
		STORE_NAME = "finven";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		const int CHAT_AUTO_HAIL = 1;
		NPC_CHECK_LEVEL = 1;
		const int CHAT_NEVER_INTERRUPT = 1;
	}

	void OnSpawn() override
	{
		SetName("Finven");
		SetName("human_vendor");
		SetHealth(1);
		SetInvincible(true);
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetModel("npc/human1.mdl");
		SetModelBody(0, 3);
		SetNoPush(true);
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		SetSayTextRange(768);
		VENDOR_MENU_OFF = 1;
		VENDOR_NOT_ON_USE = 1;
		if (!(true)) return;
		scan_for_players();
		chat_add_text("the_elf", "Oh, the elf, just outside the villa, his name's Varondo... He's with Galat.", 6.2, "none", !"voice_galat1");
		chat_add_text("the_elf", "They won't let him in, but seem fine with setting up shop there. They haven't killed him yet, at least.", 6.4, "talkleft", !"voice_galat2");
		chat_add_text("the_elf", "Leave it to Galat to have a representative, even way out here in this gods foresaken place, eh?", 5.2, "none", !"voice_galat3");
		chat_add_text("say_hi", "Hi there, I'm the merchant. The only one in town - or at least, the only one without tusks.", 5.9, "none", !"voice_hail1");
		chat_add_text("say_hi", "The orcs used to raid our village all the time, but then Chief Runegahr got it into his head we'd be more useful alive than dead.", 7.5, "none", !"voice_hail2");
		chat_add_text("say_hi", "So here I am, selling stuff in a town... Full of orcs... Heh... It's a funny thing, really...", 7.1, "panic", !"voice_hail3");
		chat_add_text("intro_talk", "*cough* Sorry... We don't get many humans in these parts...", 4.3, "none", !"voice_intro1");
		chat_add_text("intro_talk", "Especially not ones carrying swords... It's just, me, really.", 3.8, "none", !"voice_intro2");
		chat_add_text("intro_talk", "I'm Finven, the merchant. The orcs they, umm... Let me sell my wares here, at a discount...", 7.1, "none", !"voice_intro3");
		chat_add_text("intro_talk", "Our village, Sunden-dal, lies deep in the desert. We produce several, commodities, there, that the orcs cannot.", 6.9, "none", !"voice_intro4");
		chat_add_text("intro_talk", "So, in exchange for my services, they allow the village to survive. They even help us out from time to time.", 6.5, "none", !"voice_intro5");
		chat_add_text("intro_talk", "It's hard, maintaining such a small community in such a dangerous place, you see...", 4.4, "none", !"voice_intro6");
		chat_add_text("intro_talk", "Now, let's see what I can do for you.", 1.8, "none", !"voice_intro7");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_elf", "elf");
	}

	void game_menu_getoptions()
	{
		if (!(G_GAVE_DIRECTIONS))
		{
			string reg.mitem.title = "Rumors";
		}
		else
		{
			string reg.mitem.title = "About the Elf";
		}
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_elf";
	}

	void say_hi()
	{
		if (!(DID_INTRO)) return;
		chat_start_sequence("say_hi");
	}

	void say_elf()
	{
		if (!(DID_INTRO)) return;
		chat_start_sequence("the_elf");
	}

	void scan_for_players()
	{
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(1.0, "scan_for_players");
		if (!(CanSee("player", 128))) return;
		DID_INTRO = 1;
		PLAYER_ID = GetEntityIndex(m_hLastSeen);
		do_intro();
	}

	void do_intro()
	{
		PlayAnim("critical", "fear1");
		SetIdleAnim("crouch_idle");
		chat_now("By the gods, HUMANS! WE'RE UNDER ATTACK!!!", 3.0, "fear1", "clear_que");
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_startle1.wav", 10);
		ScheduleDelayedEvent(3.3, "do_intro2");
	}

	void do_intro2()
	{
		ARCHER_ID = FindEntityByName("roof_archer");
		CallExternal(ARCHER_ID, "ext_under_attack1", GetEntityIndex(GetOwner()));
		ScheduleDelayedEvent(4.0, "do_intro3");
	}

	void do_intro3()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_startle2.wav", 10);
		chat_now("Oh... Yes... Silly me... Eh, greetings, great travelers.", "add_to_que");
		SetIdleAnim("idle1");
		PlayAnim("critical", "crouch_idle2");
		ScheduleDelayedEvent(4.3, "do_intro4");
	}

	void do_intro4()
	{
		CallExternal(ARCHER_ID, "ext_under_attack2");
		ScheduleDelayedEvent(2.0, "do_intro5");
	}

	void do_intro5()
	{
		open_store();
		chat_start_sequence("intro_talk", "prioritize", "add_to_que");
	}

	void open_store()
	{
		VENDOR_MENU_OFF = 0;
		VENDOR_NOT_ON_USE = 0;
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_apple", 15, 0.5);
		AddStoreItem(STORE_NAME, "health_mpotion", 4, 0.5);
		AddStoreItem(STORE_NAME, "health_spotion", 4, 0.5);
		AddStoreItem(STORE_NAME, "mana_mpotion", 4, 0.5);
		AddStoreItem(STORE_NAME, "drink_mead", 20, 0.5);
		AddStoreItem(STORE_NAME, "drink_ale", 20, 0.5);
		AddStoreItem(STORE_NAME, "scroll2_summon_rat", 2, 0.5);
		AddStoreItem(STORE_NAME, "scroll2_rejuvenate", 2, 0.5);
		AddStoreItem(STORE_NAME, "scroll2_glow", 5, 0.5);
		AddStoreItem(STORE_NAME, "scroll2_fire_ball", 1, 0.5);
		AddStoreItem(STORE_NAME, "scroll2_poison", 1, 0.5);
		AddStoreItem(STORE_NAME, "armor_mongol", 1, 0.5);
		AddStoreItem(STORE_NAME, "armor_helm_golden", 1, 3.0);
		AddStoreItem(STORE_NAME, "armor_salamander", 1, 30.0);
		AddStoreItem(STORE_NAME, "shields_lironshield", 3, 0.5);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", 5, 0.5);
		AddStoreItem(STORE_NAME, "pack_archersquiver", 5, 1.0);
		AddStoreItem(STORE_NAME, "sheath_back_holster", 1, 0.5);
		AddStoreItem(STORE_NAME, "sheath_spellbook", 3, 0.5);
		AddStoreItem(STORE_NAME, "swords_iceblade", 1, 0.5);
		AddStoreItem(STORE_NAME, "axes_poison1", 1, 1.0);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger4", 1, 0.5);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife4", 1, 0.5);
		AddStoreItem(STORE_NAME, "blunt_granitemace", 1, 1.0);
		AddStoreItem(STORE_NAME, "blunt_granitemaul", 1, 1.0);
		AddStoreItem(STORE_NAME, "bows_swiftbow", 1, 0.5);
		AddStoreItem(STORE_NAME, "item_light_crystal", 10, 1.0);
		AddStoreItem(STORE_NAME, "item_charm_w1", 1, 3.0);
		AddStoreItem(STORE_NAME, "polearms_qs", 5, 1.0);
		AddStoreItem(STORE_NAME, "polearms_sp", 2, 1.0);
		AddStoreItem(STORE_NAME, "polearms_tri", 1, 1.0);
		if (RandomInt(1, 16) == 16)
		{
			AddStoreItem(STORE_NAME, "polearms_nag", 1, 5.0);
		}
	}

	void ext_player_got_item()
	{
		string L_INAME = GetEntityName(param1);
		string L_INAME = StringToLower(L_INAME);
		if (!((L_INAME).findFirst("ice") >= 0)) return;
		chat_now("Those are good for keeping you cool, if you are, ummm, very, careful with them.", 4.0, "add_to_que");
	}

	void voice_galat1()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_galat1.wav", 10);
	}

	void voice_galat2()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_galat2.wav", 10);
	}

	void voice_galat3()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_galat3.wav", 10);
	}

	void voice_hail1()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_hail1.wav", 10);
	}

	void voice_hail2()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_hail2.wav", 10);
	}

	void voice_hail3()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_hail3.wav", 10);
	}

	void voice_intro1()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_intro1.wav", 10);
	}

	void voice_intro2()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_intro2.wav", 10);
	}

	void voice_intro3()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_intro3.wav", 10);
	}

	void voice_intro4()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_intro4.wav", 10);
	}

	void voice_intro5()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_intro5.wav", 10);
	}

	void voice_intro6()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_intro6.wav", 10);
	}

	void voice_intro7()
	{
		EmitSound(GetOwner(), 0, "voices/sorc_villa/finven_intro7.wav", 10);
	}

}

}
