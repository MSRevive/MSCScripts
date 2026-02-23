#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class Ryza : CGameScript
{
	int ASKED_ATHOLO;
	int ATHOLO_DEAD;
	int CHAT_TEMP_NO_AUTO_FACE;
	string CL_FX;
	string DID_INTRO;
	int EMOTES_ENABLED;
	int EMOTE_COUNT;
	string EMOTE_DELAY;
	int FADE_COUNT;
	int FLICK_COUNT;
	int GAVE_CRYSTALS;
	string JUST_MENTION_LOCATION;
	int TRIGGER_RANGE;

	Ryza()
	{
		const string MONSTER_MODEL = "npc/femhuman2.mdl";
		const int NO_RUMOR = 1;
		const int NO_JOB = 1;
		const float CHAT_DELAY = 3.5;
		const float EMOTE_FREQ = 20.0;
		Precache(MONSTER_MODEL);
		const string PORTAL_FX_POS = "(175,-605,-3503)";
	}

	void OnSpawn() override
	{
		SetName("Ghost of|Ryza , Priestess of Felewyn");
		SetName("ryza");
		SetHealth(9999);
		SetInvincible(true);
		SetRoam(false);
		SetRace("beloved");
		SetModel(MONSTER_MODEL);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetHearingSensitivity(10);
		SetMoveSpeed(0.0);
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		CatchSpeech("say_atholo", "atholo");
		CatchSpeech("say_felewyn", "felewyn");
		CatchSpeech("say_ring", "ring");
		ScheduleDelayedEvent(0.1, "scan_for_players");
		EMOTE_COUNT = 0;
		FLICK_COUNT = 0;
		GAVE_CRYSTALS = 0;
		ASKED_ATHOLO = 0;
		TRIGGER_RANGE = 128;
		UseTrigger("ryza_shield");
		SetSayTextRange(1024);
		make_speech();
	}

	void make_speech()
	{
		chat_add_text("hi", "Greetings, I am the priestess Ryza...", CHAT_DELAY, "pull_needle");
		chat_add_text("hi", "My soul was bound here, for we knew one day Venevus would awaken Atholo.", CHAT_DELAY, "none", !"do_flicker");
		chat_add_text("hi", "We also knew that one day heroes, who could defeat both Venvus and Atholo, would come!");
		chat_add_text("hi", "I pray you are they, for my magic can only hold Atholo in his tomb for so long.");
		chat_add_text("hi", "Use the portals quickly, for there is not much time before the magic that holds me to this mortal plane fails!", CHAT_DELAY, "eye_wipe", !"do_flicker");
		chat_add_text("emote1", "Atholo is protected by ancient magics, but this source of his power is sealed in that tomb with him!", CHAT_DELAY, "pondering2");
		chat_add_text("emote2", "You must hurry, my magic cannot last forever!", CHAT_DELAY, "retina", !"do_flicker");
		chat_add_text("emote3", "Do not hesitate! Hurry through the portals!", CHAT_DELAY, "gluonshow");
		chat_add_text("emote4", "If that beast escapes, all of Daragoth is doomed!", CHAT_DELAY, "fear1");
		chat_add_text("emote5", "Hurry! I cannot hold on much longer!", CHAT_DELAY, "checktie", !"do_flicker");
		chat_add_text("emote6", "You CAN defeat him! It has been foretold!", CHAT_DELAY, "lean");
		chat_add_text("emote7", "You are amongst the chosen ones... you must not be defeated, or all is lost!", CHAT_DELAY, "yes");
		chat_add_text("emote8", "Continue the battle! I shall hold the beast inside for as long as I can!", CHAT_DELAY, "quicklook");
		chat_add_text("emote9", "Remember! I can use some of my magic to change your Return Crystals to Crystals of Relocation!", CHAT_DELAY, "pondering3");
		chat_add_text("emote10", "Great Felewyn, I beseech thee, watch over these heroes who fight so valiantly!", CHAT_DELAY, "kneel");
		chat_add_text("atholo", "Atholo is the one of the great lords of darkness that fought along side Lor Malgoriand, servant of the Fallen.", CHAT_DELAY, "converse2");
		chat_add_text("atholo", "Atholo was sealed here at the end of the war, but Venevus made his home here, and my order could not defeat the wizard.", CHAT_DELAY, "converse2");
		chat_add_text("atholo", "We knew what was to come, so my soul was bound here to prevent the release of Atholo. But both he, and his magic, remain within.", CHAT_DELAY, "converse2");
		chat_add_text("atholo", "Atholo's magic, like mine, is bound up in crystals and the elements.", CHAT_DELAY, "converse2");
		chat_add_text("atholo", "That is all I know of The Beast, you MUST defeat him!", CHAT_DELAY, "converse2");
		chat_add_text("crystal_got", "This will aid you in your battle, but use it wisely. I can only enchant so many.", CHAT_DELAY, "dryhands");
		chat_add_text("crystal_no", "I am sorry, the last of my magic MUST be used to maintain this barrier!", CHAT_DELAY, "no", !"do_flicker");
		chat_add_text("crystal_mention", "I can use some of my magic to convert your Crystals of Return to those of Relocation.", CHAT_DELAY, "yes");
		chat_add_text("felewyn_no", "There is not enough time to explain the grandeur of my goddess, just know that she watches over you and your valiant battle!", CHAT_DELAY, "push_button", !"do_flicker");
		chat_add_text("dying", "I salute you all for defeating the great evil, it is indeed as foretold!", CHAT_DELAY, "franticbutton");
		chat_add_text("dying", "This is but the first of the Great Evils you shall encounter in your lives.", CHAT_DELAY, "no");
		chat_add_text("dying", "But I can say no more...");
		chat_add_text("dying", "I will pray for you, great adventurers! Take heart, for Felewyn watches over you all!", CHAT_DELAY, "kneel", "do_fade");
		chat_add_text("player_has_ring", "That was the magical trinket used to bind me to your realm to ensure Atholo's defeat.", 4.7, "franticbutton");
		chat_add_text("player_has_ring", "The magics have long since dissipated as the focusing lenses have gone missing, alongside its base structure.", 6.2);
		chat_add_text("player_has_ring", "Perhaps you may find them and restore the [ring] to its former glory?", CHAT_DELAY, 4.5, !"do_flicker");
		chat_add_text("artifact_locations", "I fear Venevus has removed the focusing lenses and its original base, and scattered them across the world.", 5.5);
		chat_add_text("artifact_locations", "Give me a moment, I may be able to channel the last remaining energy in the ring to find the missing artifacts.", 7, "none", "say_locations");
		chat_add_text("artifact_locations2", "It seems one has made its way into the cursed coffers of a crystal-protected bandit's stronghold, nestled deep in a lush grove.", 9.1, "pondering");
		chat_add_text("artifact_locations2", "You may need to find yet more crystals, however.", 4, "yes", "swap_portal");
		chat_add_text("artifact_locations2", "Another was given to a powerful crystalline wizard who was so apt at the arcane, they could split their very being into elemental fragments.", 8.1, "none", "swap_portal");
		chat_add_text("artifact_locations2", "The final jewel has recessed deep under the cliffs, to the possession of a dimensional arachnid.", 8.5, "no", "swap_portal");
		chat_add_text("artifact_locations2", "Lastly, the base of the trinket was once a gift to Felewyn's devout followers to light their way during dark times.", 8, "none", "swap_portal");
		chat_add_text("artifact_locations2", "Even if you were able to retrieve all these lost ancient artifacts...", 4.5, "none", "swap_portal");
		chat_add_text("artifact_locations2", "I fear those with the knowledge of attuning such powerful relics have been lost to time.");
		chat_add_text("artifact_locations2", "If you were able to find someone so attuned to Felewyn's influence, perhaps you may be able to restore the latent energies within the leyline ring.");
		chat_add_text("artifact_locations2", "Good luck, heroes. May Felewyn's grace, and Idemark's guidance, bless you once more.");
	}

	void scan_for_players()
	{
		ScheduleDelayedEvent(0.7, "scan_for_players");
		if ((CanSee("player", TRIGGER_RANGE)))
		{
			player_spotted();
		}
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(GetEntityRange("ent_lastheard") < TRIGGER_RANGE)) return;
		if (!(IsValidPlayer("ent_lastheard"))) return;
		player_spotted();
	}

	void player_spotted()
	{
		if ((DOING_EXIT)) return;
		if (!(DID_INTRO))
		{
			if (!(ATHOLO_DEAD))
			{
				say_hi();
			}
			DID_INTRO = 1;
		}
		if ((DID_INTRO))
		{
			if (!(ATHOLO_DEAD))
			{
			}
			if (!(EMOTE_DELAY))
			{
			}
			EMOTE_DELAY = 1;
			EMOTE_FREQ("emote_reset");
			say_emote();
		}
	}

	void emote_reset()
	{
		EMOTE_DELAY = 0;
	}

	void say_hi()
	{
		chat_start_sequence("hi");
	}

	void say_emote()
	{
		string L_RAND = RandomInt(1, 10);
		if (L_RAND == 9)
		{
			if (GAVE_CRYSTALS >= 4)
			{
				int L_RAND = 10;
			}
		}
		string L_STR = "emote";
		chat_start_sequence(L_STR);
	}

	void game_menu_getoptions()
	{
		if (!(DID_INTRO)) return;
		if (!(ATHOLO_DEAD))
		{
			if (GAVE_CRYSTALS < 4)
			{
				chat_start_sequence("crystal_mention");
			}
			if ((ItemExists(param1, "item_crystal_return")))
			{
			}
			string reg.mitem.title = "Enchant my crystal";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_crystal_return";
			string reg.mitem.callback = "got_crystal";
		}
		else
		{
			string L_QUEST = GetPlayerQuestData(param1, "manaring");
			if ((ItemExists(param1, "item_ring_ryza")))
			{
			}
			if (L_QUEST == "0")
			{
			}
			if (!(JUST_MENTION_LOCATION))
			{
				string reg.mitem.title = "Show Ryza's Trinket";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_trinket";
			}
			else
			{
				string reg.mitem.title = "Ask about Ring";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_ring";
			}
		}
	}

	void say_trinket()
	{
		if ((CHAT_BUSY)) return;
		if (!(JUST_MENTION_LOCATION))
		{
			chat_start_sequence("player_has_ring");
			JUST_MENTION_LOCATION = 1;
		}
	}

	void say_ring()
	{
		if ((CHAT_BUSY)) return;
		if (!(JUST_MENTION_LOCATION)) return;
		chat_start_sequence("artifact_locations");
	}

	void say_locations()
	{
		CHAT_TEMP_NO_AUTO_FACE = 1;
		SetAngles("face_origin");
		SetAngles("face");
		PlayAnim("critical", "writeboard");
		ScheduleDelayedEvent(4, "create_portal");
		ScheduleDelayedEvent(7, "say_locations_delay");
	}

	void create_portal()
	{
		ClientEvent("new", "all", "effects/manaring_portals", PORTAL_FX_POS, 1);
		CL_FX = "game.script.last_sent_id";
	}

	void swap_portal()
	{
		ClientEvent("update", "all", CL_FX, "spawn_a_portal");
	}

	void say_locations_delay()
	{
		CHAT_TEMP_NO_AUTO_FACE = 0;
		chat_start_sequence("artifact_locations2");
	}

	void got_crystal()
	{
		string CRYSTAL_GIVER = param1;
		if ((ATHOLO_DEAD)) return;
		if (GAVE_CRYSTALS >= 4)
		{
			// TODO: offer CRYSTAL_GIVER item_crystal_return
			chat_start_sequence("crystal_no");
		}
		if (GAVE_CRYSTALS < 4)
		{
			// TODO: offer CRYSTAL_GIVER item_crystal_reloc
			chat_start_sequence("crystal_got");
			GAVE_CRYSTALS += 1;
		}
	}

	void atholo_done()
	{
		TRIGGER_RANGE = 64;
		ATHOLO_DEAD = 1;
		EMOTES_ENABLED = 0;
		UseTrigger("ryza_shield");
	}

	void do_flicker()
	{
		FLICK_COUNT += 1;
		if (FLICK_COUNT < 20)
		{
			string FLICKER_AMT = RandomInt(10, 180);
			SetProp(GetOwner(), "renderamt", FLICKER_AMT);
			ScheduleDelayedEvent(0.1, "do_flicker");
		}
		if (!(FLICK_COUNT == 20)) return;
		FLICK_COUNT = 0;
		SetProp(GetOwner(), "renderamt", 255);
	}

	void say_felewyn()
	{
		chat_start_sequence("felewyn_no");
	}

	void say_atholo()
	{
		chat_start_sequence("atholo");
	}

	void do_exit()
	{
		SetMenuAutoOpen(0);
		chat_start_sequence("dying");
	}

	void do_fade()
	{
		SetSolid("none");
		FADE_COUNT = 200;
		fade_loop();
	}

	void fade_loop()
	{
		FADE_COUNT -= 3;
		string L_FADE = FADE_COUNT;
		if (FADE_COUNT >= 0)
		{
			SetProp(GetOwner(), "renderamt", L_FADE);
		}
		if (FADE_COUNT <= 0)
		{
			ScheduleDelayedEvent(0.2, "remove_me");
		}
		if (!(FADE_COUNT > 0)) return;
		ScheduleDelayedEvent(0.1, "fade_loop");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
