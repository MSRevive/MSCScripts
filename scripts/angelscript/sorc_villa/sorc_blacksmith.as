#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_chat.as"

namespace MS
{

class SorcBlacksmith : CGameScript
{
	int AM_HAMMERING;
	string ANIM_HAMMER;
	string ANIM_IDLE;
	string ANIM_STEP3;
	string ANIM_STEP4;
	string ANIM_YES;
	string BLACKSMITH_FX_ID;
	string BUSY_COMMENT;
	string CHAT_EVENT_STEP2;
	string CHAT_EVENT_STEP4;
	string CHAT_EVENT_STEP5;
	string CHAT_EVENT_STEP6;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	string CHAT_STEPS;
	int CHAT_USE_CONV_ANIMS;
	string DID_INTRO;
	string FINAL_GOLD_REQ;
	string FORGE_MENU_TARGET;
	string HAMMER_YAW;
	string LAST_PLAYER_FORGE_ID;
	string MENU_TYPE;
	int NO_CLOSE_MOUTH;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	int PLAYING_DEAD;
	string RESUME_HAMMERING;
	string SMITH_CL_TYPE;
	string SMITH_CUSTOMER;
	int SMITH_GOLD_REQ;
	string SMITH_REQ;
	string SMITH_TYPE;
	string STORE_NAME;
	int VENDOR_MENU_OFF;
	int VENDOR_NOT_ON_USE;

	SorcBlacksmith()
	{
		ANIM_HAMMER = "hammering";
		ANIM_YES = "nod_yes";
		ANIM_IDLE = "idle1";
		SMITH_GOLD_REQ = 50000;
		VENDOR_MENU_OFF = 1;
		VENDOR_NOT_ON_USE = 1;
		NO_JOB = 1;
		NO_HAIL = 1;
		NO_RUMOR = 1;
		STORE_NAME = "sorc_blacksmith";
		CHAT_USE_CONV_ANIMS = 0;
		NO_CLOSE_MOUTH = 1;
		BUSY_COMMENT = "Patients little pink one... Busy with this other wee one right now.";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10.0);
		if (GetGameTime() > RESUME_HAMMERING)
		{
		}
		SetAngles("face");
		if (!(AM_HAMMERING))
		{
		}
		start_hammering();
	}

	void OnSpawn() override
	{
		SetName("Irunthar");
		SetModel("monsters/sorc.mdl");
		SetHealth(8000);
		SetDamageResistance("all", 0.5);
		SetStat("parry", 110);
		SetRace("beloved");
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetNoPush(true);
		SetWidth(32);
		SetHeight(96);
		SetModelBody(0, 4);
		SetModelBody(1, 0);
		SetModelBody(2, 10);
		CatchSpeech("say_forge", "forg");
		CatchSpeech("say_shop", "shop");
		AM_HAMMERING = 1;
		MENU_TYPE = "normal";
		SetIdleAnim(ANIM_HAMMER);
		SetMoveAnim(ANIM_HAMMER);
		SetMenuAutoOpen(1);
		ScheduleDelayedEvent(0.1, "get_yaw");
		npcatk_suspend_ai();
	}

	void get_yaw()
	{
		HAMMER_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
	}

	void say_shop()
	{
		if (!(MENU_TYPE == "normal")) return;
		vendor_offerstore(GetEntityIndex("ent_lastspoke"));
	}

	void game_menu_getoptions()
	{
		if ((G_SORCS_HOSTILE)) return;
		if (MENU_TYPE == "normal")
		{
			string reg.mitem.title = "Hail";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hi";
			string reg.mitem.title = "Browse Wares";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "vendor_offerstore";
			string reg.mitem.title = "Forge Item";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_forge";
			string reg.mitem.title = "Ask about Rumors";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_rumor";
			if ((ItemExists(param1, "smallarms_rd")))
			{
			}
			string reg.mitem.title = "Ask about rusty dagger";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_rdagger_excuse";
		}
		if (MENU_TYPE == "forge_type")
		{
			string reg.mitem.title = "Weapons";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_forge_weapons";
		}
		if (MENU_TYPE == "forge_weapon")
		{
			string reg.mitem.title = "Shadowfire Blade";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_swords_sf";
			string reg.mitem.title = "Winter Cleaver";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_axes_df";
			string reg.mitem.title = "Unholy Blade";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_swords_ub";
			string reg.mitem.title = "Skull Scythe";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_axes_ss";
			string reg.mitem.title = "Vorpal Tongue";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_smallarms_vt";
			string reg.mitem.title = "Demon Bludgeon Hammer";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_blunt_db";
			string reg.mitem.title = "Infernal Claws";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_blunt_gauntlet_ic";
		}
		if (MENU_TYPE == "smith_confirm")
		{
			string reg.mitem.title = "Yes";
			string reg.mitem.type = "payment";
			string reg.mitem.data = SMITH_REQ;
			string reg.mitem.callback = "do_smithing";
			string reg.mitem.cb_failed = "smithing_fail_payment";
			string reg.mitem.title = "No";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "smithing_cancel";
		}
	}

	void smithing_cancel()
	{
		MENU_TYPE = "normal";
		SetMenuAutoOpen(1);
		SayText("Very well then, perhaps meez can interest you in something else?");
		ScheduleDelayedEvent(1.0, "start_hammering");
	}

	void smithing_fail_payment()
	{
		MENU_TYPE = "normal";
		SetMenuAutoOpen(1);
		SayText("Bah, come back when yoos has the gold and ingredients I need.");
		ScheduleDelayedEvent(1.0, "start_hammering");
	}

	void game_menu_cancel()
	{
		MENU_TYPE = "normal";
		SetMenuAutoOpen(1);
	}

	void say_hi()
	{
		if ((BUSY_CHATTING)) return;
		stop_hammering();
		if ((IsValidPlayer(param1)))
		{
			string CURRENT_SPEAKER = GetEntityIndex(param1);
		}
		else
		{
			string CURRENT_SPEAKER = GetEntityIndex("ent_lastspoke");
		}
		face_speaker(CURRENT_SPEAKER);
		if (!(DID_INTRO))
		{
			DID_INTRO = 1;
			CHAT_STEP1 = "Hail! If it isn't our honored guests!";
			CHAT_STEP2 = "And what pretty shinies they bring!";
			CHAT_STEP3 = "We don't often see humans with pretty shinies in the villa - not breathing humans, anyways.";
			CHAT_STEP4 = "And meez must say, not often with so many pretty shinies either!";
			ANIM_STEP4 = ANIM_YES;
			CHAT_STEP5 = "Come, take a look at my wares. Maybe we can also work out a deal for use of the services of meez [forge]!";
			CHAT_STEPS = 5;
			chat_loop();
		}
		else
		{
			SayText("Back again? Perhaps yoos want more of my wares, or perhaps meez [forging] something new for yas.");
			PlayAnim("critical", ANIM_YES);
		}
	}

	void stop_hammering()
	{
		AM_HAMMERING = 0;
		RESUME_HAMMERING = GetGameTime();
		RESUME_HAMMERING += 50.0;
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_IDLE);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
	}

	void start_hammering()
	{
		AM_HAMMERING = 1;
		SetAngles("face");
		SetIdleAnim(ANIM_HAMMER);
		SetMoveAnim(ANIM_HAMMER);
		PlayAnim("critical", ANIM_HAMMER);
	}

	void say_forge()
	{
		if ((BUSY_CHATTING)) return;
		if ((AM_HAMMERING))
		{
			stop_hammering();
		}
		if ((IsValidPlayer(param1)))
		{
			string CURRENT_SPEAKER = GetEntityIndex(param1);
		}
		else
		{
			string CURRENT_SPEAKER = GetEntityIndex("ent_lastspoke");
		}
		face_speaker(CURRENT_SPEAKER);
		FORGE_MENU_TARGET = CURRENT_SPEAKER;
		CHAT_STEP1 = "Well, well, well... My forging services are not for the faint of heart, nor the faint of coin...";
		if (LAST_PLAYER_FORGE_ID != CURRENT_SPEAKER)
		{
			CHAT_STEP2 = "But fear not, I'll not beez chargein yas anymores than I charges anyones elses.";
			CHAT_STEP3 = "Unlike some of my brothers, I care not of the color of my customer's skin - only of that of their coin! Hahaha!";
			ANIM_STEP3 = ANIM_YES;
			CHAT_STEP4 = "What mighty smithing feat doos yous wants to sees meez performs?";
			CHAT_EVENT_STEP4 = "give_forge_menu";
			MENU_TYPE = "forge_type";
			CHAT_STEPS = 4;
			chat_loop();
		}
		else
		{
			CHAT_STEP2 = "What mighty smithing feat doos yous wants to sees meez performs?";
			CHAT_EVENT_STEP2 = "give_forge_menu";
			MENU_TYPE = "forge_type";
			CHAT_STEPS = 2;
			chat_loop();
		}
		LAST_PLAYER_FORGE_ID = CURRENT_SPEAKER;
	}

	void give_forge_menu()
	{
		OpenMenu(FORGE_MENU_TARGET);
	}

	void say_forge_weapons()
	{
		SayText("And which of my mighty shinies might yeez beez wanting to knows of?");
		FORGE_MENU_TARGET = param1;
		MENU_TYPE = "forge_weapon";
		ScheduleDelayedEvent(0.1, "give_forge_menu");
	}

	void smith_confirm()
	{
		MENU_TYPE = "smith_confirm";
		OpenMenu(SMITH_CUSTOMER);
	}

	void do_smithing()
	{
		MENU_TYPE = "suspend";
		start_hammering();
		CHAT_STEP1 = "Alright then! Just a moment while I put da magic hammer to works...";
		CHAT_STEP2 = "Here we go...";
		CHAT_STEP3 = "There, alls done.";
		CHAT_STEPS = 3;
		chat_loop();
		// TODO: UNCONVERTED: savenow SMITH_CUSTOMER
		ScheduleDelayedEvent(2.0, "smithing_cl_effects");
		ScheduleDelayedEvent(8.0, "smith_finalize");
	}

	void smith_finalize()
	{
		MENU_TYPE = "normal";
		face_speaker(SMITH_CUSTOMER);
		// TODO: offer SMITH_CUSTOMER SMITH_TYPE
		if (SMITH_TYPE == "swords_ub")
		{
			string QUEST_IDX = FindToken(QUEST_CAT_DATA, "sym1", ";");
			if (QUEST_IDX > -1)
			{
				RemoveToken(QUEST_CAT_DATA, QUEST_IDX, ";");
			}
			string QUEST_IDX = FindToken(QUEST_CAT_DATA, "sym2", ";");
			if (QUEST_IDX > -1)
			{
				RemoveToken(QUEST_CAT_DATA, QUEST_IDX, ";");
			}
			string QUEST_IDX = FindToken(QUEST_CAT_DATA, "sym3", ";");
			if (QUEST_IDX > -1)
			{
				RemoveToken(QUEST_CAT_DATA, QUEST_IDX, ";");
			}
			string QUEST_IDX = FindToken(QUEST_CAT_DATA, "sym4", ";");
			if (QUEST_IDX > -1)
			{
				RemoveToken(QUEST_CAT_DATA, QUEST_IDX, ";");
			}
			string QUEST_IDX = FindToken(QUEST_CAT_DATA, "sym5", ";");
			if (QUEST_IDX > -1)
			{
				RemoveToken(QUEST_CAT_DATA, QUEST_IDX, ";");
			}
			SetPlayerQuestData(SMITH_CUSTOMER, "f");
		}
		SetMenuAutoOpen(1);
	}

	void say_swords_sf()
	{
		FINAL_GOLD_REQ = SMITH_GOLD_REQ;
		float SMITH_RATIO = 1.0;
		FINAL_GOLD_REQ *= SMITH_RATIO;
		FINAL_GOLD_REQ = int(FINAL_GOLD_REQ);
		CHAT_STEP1 = "The Shadowfire Blade has the dark energy of the Blood Drinker, and new enhanced fire storms and stuffs.";
		CHAT_STEP2 = "To forge it, I needs a Blood Drinker, a Nova Blade, and three Fire Tomahawks.";
		CHAT_STEP3 = "I also charge a workmanship fee of ";
		CHAT_STEP3 += FINAL_GOLD_REQ;
		CHAT_STEP3 += " gold.";
		CHAT_STEP4 = "Do you wish meez to attempt this smithing feat for yoos?";
		CHAT_EVENT_STEP4 = "say_smith_confirm";
		CHAT_STEPS = 4;
		SetMenuAutoOpen(0);
		SMITH_CUSTOMER = param1;
		SMITH_TYPE = "swords_sf";
		SMITH_CL_TYPE = "dark;fire";
		SMITH_REQ = "swords_blood_drinker;swords_novablade12;axes_tf:3;gold:";
		SMITH_REQ += FINAL_GOLD_REQ;
		chat_loop();
		string MENU_DELAY = CHAT_STEPS;
		MENU_DELAY *= CHAT_DELAY;
		MENU_DELAY("smith_confirm");
	}

	void say_axes_df()
	{
		FINAL_GOLD_REQ = SMITH_GOLD_REQ;
		float SMITH_RATIO = 1.0;
		FINAL_GOLD_REQ *= SMITH_RATIO;
		FINAL_GOLD_REQ = int(FINAL_GOLD_REQ);
		CHAT_STEP1 = "For the Wintercleaver axe, we take the ice-metal of the Tomahawks and balance the beast with the Torkalath steel.";
		CHAT_STEP2 = "This makes for a beast of an axe that can create icy storms, yet is still light enough for humans to easily land blows with.";
		CHAT_STEP3 = "So, I needs two ice Tomahawks and two Torkalath Shortswords to slam one together.";
		CHAT_STEP4 = "I also charge a workmanship fee of ";
		CHAT_STEP4 += FINAL_GOLD_REQ;
		CHAT_STEP4 += " gold.";
		CHAT_STEP5 = "Do you wish meez to attempt this smithing feat for yoos?";
		CHAT_EVENT_STEP5 = "say_smith_confirm";
		CHAT_STEPS = 5;
		SetMenuAutoOpen(0);
		SMITH_CUSTOMER = param1;
		SMITH_TYPE = "axes_df";
		SMITH_CL_TYPE = "ice";
		SMITH_REQ = "swords_katana4:2;axes_ti:2;gold:";
		SMITH_REQ += FINAL_GOLD_REQ;
		chat_loop();
		string MENU_DELAY = CHAT_STEPS;
		MENU_DELAY *= CHAT_DELAY;
		MENU_DELAY("smith_confirm");
	}

	void say_swords_ub()
	{
		FINAL_GOLD_REQ = SMITH_GOLD_REQ;
		float SMITH_RATIO = 2.0;
		FINAL_GOLD_REQ *= SMITH_RATIO;
		FINAL_GOLD_REQ = int(FINAL_GOLD_REQ);
		CHAT_STEP1 = "Ah, the Unholy Blade... I've been wanting to make one of these for a long time now!";
		CHAT_STEP2 = "Sadly, no one seems to be able to bring me the materials I need. Namely, five seperate shards of the legendary Felewyn Blade.";
		CHAT_STEP3 = "On top of that, I'll need two Blood Drinkers. Oh, but what a beast this sword will be...";
		CHAT_STEP4 = "I also charge a workmanship fee of ";
		CHAT_STEP4 += FINAL_GOLD_REQ;
		CHAT_STEP4 += " gold.";
		CHAT_STEP5 = "Do you wish meez to attempt this smithing feat for yoos?";
		CHAT_EVENT_STEP5 = "say_smith_confirm";
		CHAT_STEPS = 5;
		SetMenuAutoOpen(0);
		SMITH_CUSTOMER = param1;
		SMITH_TYPE = "swords_ub";
		SMITH_CL_TYPE = "dark";
		SMITH_REQ = "swords_fshard1;swords_fshard2;swords_fshard3;swords_fshard4;swords_fshard5;swords_blood_drinker:2;gold:";
		SMITH_REQ += FINAL_GOLD_REQ;
		chat_loop();
		string MENU_DELAY = CHAT_STEPS;
		MENU_DELAY *= CHAT_DELAY;
		MENU_DELAY("smith_confirm");
	}

	void say_blunt_db()
	{
		FINAL_GOLD_REQ = SMITH_GOLD_REQ;
		float SMITH_RATIO = 0.5;
		FINAL_GOLD_REQ *= SMITH_RATIO;
		FINAL_GOLD_REQ = int(FINAL_GOLD_REQ);
		CHAT_STEP1 = "Ah, now this be pretty simple: we take the fire magic from two Tomahawks, two dark Tomahawks,";
		CHAT_STEP2 = "and two shortswords worth of Torkalath steel to hold it all together with. We work this all into your Bludgeon Hammer.";
		CHAT_STEP3 = "Only sticky bit is keeping the Bludgeon soul locked in there during the whole process.";
		CHAT_STEP4 = "I also charge a workmanship fee of ";
		CHAT_STEP4 += FINAL_GOLD_REQ;
		CHAT_STEP4 += " gold.";
		CHAT_STEP5 = "Do you wish meez to attempt this smithing feat for yoos?";
		CHAT_EVENT_STEP5 = "say_smith_confirm";
		CHAT_STEPS = 5;
		SetMenuAutoOpen(0);
		SMITH_CUSTOMER = param1;
		SMITH_TYPE = "blunt_db";
		SMITH_CL_TYPE = "fire";
		SMITH_REQ = "axes_tf:2;axes_td:2;swords_katana4:2;blunt_mithral;gold:";
		SMITH_REQ += FINAL_GOLD_REQ;
		chat_loop();
		string MENU_DELAY = CHAT_STEPS;
		MENU_DELAY *= CHAT_DELAY;
		MENU_DELAY("smith_confirm");
	}

	void say_axes_ss()
	{
		FINAL_GOLD_REQ = SMITH_GOLD_REQ;
		float SMITH_RATIO = 2.0;
		FINAL_GOLD_REQ *= SMITH_RATIO;
		FINAL_GOLD_REQ = int(FINAL_GOLD_REQ);
		CHAT_STEP1 = "The Skull Scythe. Inspired by the Torkalath Scythe. It may even make a worthy sacrifice to the Father of Chaos himself!";
		CHAT_STEP2 = "This sweeping axe blade can lop off heads at a fair distance, drink the blood of your enemies, yet is light enough to throw.";
		CHAT_STEP3 = "To forge one, I need two dark tomahawks, two balanced axes, and two Torkalath short swords.... And one petrified human head.";
		CHAT_STEP4 = "Eh... Don't worry about the head... I got one... or three... I'll throw one in free of charge.";
		CHAT_STEP5 = "The workmanship fee comes to ";
		CHAT_STEP5 += FINAL_GOLD_REQ;
		CHAT_STEP5 += " gold.";
		CHAT_STEP6 = "Do you wish meez to attempt this smithing feat for yoos?";
		CHAT_EVENT_STEP6 = "say_smith_confirm";
		CHAT_STEPS = 6;
		SetMenuAutoOpen(0);
		SMITH_CUSTOMER = param1;
		SMITH_TYPE = "axes_ss";
		SMITH_CL_TYPE = "dark";
		SMITH_REQ = "axes_b:2;swords_katana4:2;axes_td:2;gold:";
		SMITH_REQ += FINAL_GOLD_REQ;
		chat_loop();
		string MENU_DELAY = CHAT_STEPS;
		MENU_DELAY *= CHAT_DELAY;
		MENU_DELAY("smith_confirm");
	}

	void say_smallarms_vt()
	{
		FINAL_GOLD_REQ = SMITH_GOLD_REQ;
		float SMITH_RATIO = 2.0;
		FINAL_GOLD_REQ *= SMITH_RATIO;
		FINAL_GOLD_REQ = int(FINAL_GOLD_REQ);
		CHAT_STEP1 = "Ah, the Vorpal Tongue, not had a chance to make one of these in a long time.";
		CHAT_STEP2 = "I'd need an ethereal dagger, two actually, and really no one knows how to properly forge those anymore.";
		CHAT_STEP3 = "Then two Efreeti hearts, and Efreeti are very rare, for there aren't many wizards left who know how to make those either.";
		CHAT_STEP4 = "Combine all that with a pair of litchtounges, and we have a rare weapon indeed.";
		CHAT_STEP5 = "One capable of holding the magic of two elements: fire and ice, in one blade, thanks to the ethereal metal.";
		CHAT_STEP6 = "Price comes to ";
		CHAT_STEP6 += FINAL_GOLD_REQ;
		CHAT_STEP6 += " gold. I'll I have a go at it, should you have the ingredients.";
		CHAT_EVENT_STEP6 = "say_smith_confirm";
		CHAT_STEPS = 6;
		SetMenuAutoOpen(0);
		SMITH_CUSTOMER = param1;
		SMITH_TYPE = "smallarms_vt";
		SMITH_CL_TYPE = "fire;ice";
		SMITH_REQ = "item_eh:2;smallarms_eth:2;smallarms_frozentongueonflagpole:2;gold:";
		SMITH_REQ += FINAL_GOLD_REQ;
		chat_loop();
		string MENU_DELAY = CHAT_STEPS;
		MENU_DELAY *= CHAT_DELAY;
		MENU_DELAY("smith_confirm");
	}

	void say_blunt_gauntlet_ic()
	{
		FINAL_GOLD_REQ = SMITH_GOLD_REQ;
		float SMITH_RATIO = 1.0;
		FINAL_GOLD_REQ *= SMITH_RATIO;
		FINAL_GOLD_REQ = int(FINAL_GOLD_REQ);
		CHAT_STEP1 = "Infernal claws. Vicious little things. A bit delicate for orc hands, but fine for the likes of yoos.";
		CHAT_STEP2 = "Pretty simple formula. Three fire Tomahawks, and two pair demon claws.";
		CHAT_STEP3 = "Final result is a set of claws coupled with various fire enchantments.";
		CHAT_STEP4 = "Price comes to ";
		CHAT_STEP4 += FINAL_GOLD_REQ;
		CHAT_STEP4 += " gold. I'll I have a go at it, should you have the ingredients.";
		CHAT_EVENT_STEP6 = "say_smith_confirm";
		CHAT_STEPS = 4;
		SetMenuAutoOpen(0);
		SMITH_CUSTOMER = param1;
		SMITH_TYPE = "blunt_gauntlets_ic";
		SMITH_CL_TYPE = "fire";
		SMITH_REQ = "blunt_gauntlets_demon:2;axes_tf:3;gold:";
		SMITH_REQ += FINAL_GOLD_REQ;
		chat_loop();
		string MENU_DELAY = CHAT_STEPS;
		MENU_DELAY *= CHAT_DELAY;
		MENU_DELAY("smith_confirm");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "armor_dark", RandomInt(0, 2), 400, 0);
		AddStoreItem(STORE_NAME, "armor_helm_dark", RandomInt(0, 2), 400, 0);
		AddStoreItem(STORE_NAME, "armor_helm_golden", RandomInt(0, 2), 400, 0);
		AddStoreItem(STORE_NAME, "axes_thunder11", 5, 600, 0);
		AddStoreItem(STORE_NAME, "smallarms_k_fire", 1, 400, 0);
		AddStoreItem(STORE_NAME, "blunt_gauntlets_fire", 1, 600, 0);
		AddStoreItem(STORE_NAME, "blunt_darkmaul", 5, 600, 0);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife4", 5, 200, 0);
		AddStoreItem(STORE_NAME, "smallarms_fangstooth", 5, 200, 0);
		AddStoreItem(STORE_NAME, "blunt_granitemace", 5, 200, 0);
		AddStoreItem(STORE_NAME, "blunt_granitemaul", 5, 200, 0);
		AddStoreItem(STORE_NAME, "shields_lironshield", 5, 100, 0);
		AddStoreItem(STORE_NAME, "axes_gthunder11", 1, 30.0, 0);
		AddStoreItem(STORE_NAME, "axes_greataxe", 1, 3.0, 0);
		AddStoreItem(STORE_NAME, "axes_scythe", 1, 3.0, 0);
		AddStoreItem(STORE_NAME, "armor_helm_dark", 1, 3.0, 0);
		if (RandomInt(1, 40) <= "game.playersnb")
		{
			AddStoreItem(STORE_NAME, "shields_rf", 1, 500, 0);
			AddStoreItem(STORE_NAME, "shields_rl", 1, 500, 0);
		}
	}

	void say_rdagger_excuse()
	{
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Oh wow... I knows what this is! That's an ethereal blade under all that rust!";
		CHAT_STEP2 = "Ones this old tend to get rusties - hides the blade, but restoring it is... Very delicate work.";
		CHAT_STEP3 = "I'm afraid meez hands are just too rough for that kind of jeweler's task.";
		CHAT_STEP4 = "Probably needs a human or elf smith. I know not where you'd find one who could handle that these days though.";
		CHAT_STEPS = 4;
		chat_loop();
	}

	void say_rumor()
	{
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "I hear that Runegahr and Thuldahr have been going at it again...";
		CHAT_STEP2 = "Thuldahr doesn't likes Runegahr's plans, being nice to the humans and all. Letting em keeps a village so close.";
		CHAT_STEP3 = "I tries not to thinks about politics much though. Too much smithings to doos.";
		CHAT_STEPS = 3;
		chat_loop();
	}

	void frame_hammer()
	{
		if (!(IsEntityAlive(BLACKSMITH_FX_ID)))
		{
			get_blacksmith_fx_id();
		}
		else
		{
			CallExternal(BLACKSMITH_FX_ID, "do_spark");
		}
	}

	void get_blacksmith_fx_id()
	{
		BLACKSMITH_FX_ID = FindEntityByName("sfx_blacksmith");
	}

	void smithing_cl_effects()
	{
		if (!(IsEntityAlive(BLACKSMITH_FX_ID)))
		{
			get_blacksmith_fx_id();
		}
		CallExternal(BLACKSMITH_FX_ID, "do_forge_fx", SMITH_CL_TYPE, SMITH_TYPE);
	}

}

}
