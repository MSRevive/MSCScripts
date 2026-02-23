#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class WizardIshmeea : CGameScript
{
	string CHAT_MENU_ON;
	int COLLECTED_ITEMS;
	string IDEMARK_ID;
	int MET_LEOFING;
	int SAID_HI;
	int SAID_LEOFING;

	WizardIshmeea()
	{
		const int CHAT_NEVER_INTERRUPT = 1;
		const int CHAT_AUTO_HAIL = 1;
		COLLECTED_ITEMS = 0;
	}

	void game_precache()
	{
		Precache("c-tele1.spr");
	}

	void OnSpawn() override
	{
		SetName("The Wizard|Ishme'Ea");
		SetName("ishmeea");
		SetInvincible(true);
		SetRace("beloved");
		SetModel("npc/elf_f_warrior.mdl");
		SetWidth(32);
		SetHeight(72);
		SetNoPush(true);
		SetModelBody(1, 7);
		SetProp(GetOwner(), "skin", 1);
		PlayAnim("hold", 3);
		SetMenuAutoOpen(1);
		SetSayTextRange(1000);
		create_conversations();
	}

	void create_conversations()
	{
		CatchSpeech("say_met_leofing", "leofing");
		CatchSpeech("say_gave_items", "give");
		chat_add_text("say_hi", "WHAT was that? I heard you crashing down here like a bag of hammers. Do you not understand the situation here?", 7.0, "none", "flag_said_hi");
		chat_add_text("say_hi", "*sigh* Pardon me, it's been so long since I had proper visitors that I forget myself down here, sometimes.", 7, "none", "none");
		chat_add_text("say_hi", "Something at the tower emits a powerful aura, it speaks to me in my dreams. In nightmares that I wouldn't wish on Lor Malgoriand himself.", 9, "none", "none");
		chat_add_text("say_hi", "Do try and keep the noise down, darling.", 2, "none", "none");
		chat_add_text("say_hi_alt", "It's been so long since I had proper visitors that I forget myself down here, sometimes.", 6, "none", "none");
		chat_add_text("say_hi_alt", "Something at the tower emits a powerful aura, it speaks to me in my dreams. In nightmares that I wouldn't wish on Lor Malgoriand himself.", 9, "none", "none");
		chat_add_text("say_hi_alt", "Do try and keep the noise down, darling.", 2, "none", "none");
		chat_add_text("say_met_leofing", "Leofing? Alive? Well, in a manner of speaking. Good to know he has not changed in a few hundred years.", 8, "none", "none");
		chat_add_text("say_met_leofing", "You see, I am studying the phenomenon here at Idemark's Tower. It is highly unusual, to say the least, that the lands themselves fight the Lost.", 10, "none", "none");
		chat_add_text("say_met_leofing", "These purple crystals are the most reactive samples that I have found in all of Daragoth, by far!", 6, "none", "none");
		chat_add_text("say_met_leofing", "The crystal rods are remnants of the great ballistae bolts that rained down here at the start of the Age of War.", 6, "none", "none");
		chat_add_text("say_met_leofing", "The megalithic ammunition must have been cursed by The Lost to spread their influence upon strategic locations.", 6, "none", "none");
		chat_add_text("say_met_leofing", "I have been busy in the years since, traveling to different Elvish enclaves to further my arcane knowledge.", 6, "none", "none");
		chat_add_text("say_met_leofing", "Arcane scholars I studied with at our capital city, Kray Eldorad, claim that this energy can be re-cast.", 7, "none", "none");
		chat_add_text("say_met_leofing", "It could be used as a conduit to purge The Lost from this area, allowing me to enter the Tower proper.", 7, "none", "none");
		chat_add_text("say_met_leofing", "A few ingredients are required for this. We will need the remains from a powerful leader of The Lost to counteract its influence.", 7, "none", "none");
		chat_add_text("say_met_leofing", "The remains of Leofing himself are needed, his unwavering devotion will power the connection.", 6, "none", "none");
		chat_add_text("say_met_leofing", "And finally a sample of the purple crystal itself, the physical connection needed to bridge my mind to the ether.", 7, "none", "flag_said_leofing");
		chat_add_text("say_met_leofing_alt", "I can use the energy here to purge The Lost from this area, allowing me to enter the Tower.", 6, "none", "none");
		chat_add_text("say_met_leofing_alt", "A few ingredients are required for this.", 3, "none", "none");
		chat_add_text("say_met_leofing_alt", "We will need the remains from a powerful leader of The Lost to counteract its influence.", 5, "none", "none");
		chat_add_text("say_met_leofing_alt", "The remains of Leofing himself are needed, his unwavering devotion will power the connection.", 6, "none", "none");
		chat_add_text("say_met_leofing_alt", "And finally a sample of the purple crystal itself, the physical connection needed to bridge my mind to the ether.", 7, "none", "none");
		chat_add_text("say_gave_items", "Incredible. To play a part in the fates, however minor, is beyond our wildest dreams. Thank you, Leofing, for this last gift.", 8, "none", !"flag_gave_items");
		chat_add_text("say_gave_items", "You know not the depths of your power, I would not be surprised if your path is guided by Pathos themself.", 6, "none", "none");
		chat_add_text("say_gave_items", "Meet me in the chapel. It can be found high up on the mighty stone walls, near the front gate.", 5, "none", "tele_out");
		chat_add_text("say_boss_died", "All of Daragoth should be cheering your name right now, hero.", 3, "none", "none");
		chat_add_text("say_boss_died", "A victory of this scale against The Lost has not happened in a long, long time.", 5, "none", "none");
		chat_add_text("say_boss_died", "The Idemark you met in this chapel is a fragment of herself, a pool of magic that could only react to certain stimuli.", 7, "none", "none");
		chat_add_text("say_boss_died", "Being in her study for so long, I can tell you that Idemark has left many more surprises for us inside that Tower.", 7, "none", "none");
		chat_add_text("say_boss_died", "Rest your muscles and mind for now, adventurer, you will need your strength for what lies ahead.", 5, "none", "none");
	}

	void game_menu_getoptions()
	{
		if (!(SAID_HI)) return;
		if ((MET_LEOFING))
		{
			string reg.mitem.title = "Met Leofing";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_met_leofing";
		}
		if (COLLECTED_ITEMS == 3)
		{
			string reg.mitem.title = "Give items";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_gave_items";
		}
	}

	void say_hi()
	{
		if ((CHAT_BUSY)) return;
		if (!(CHAT_MENU_ON)) return;
		if (!(SAID_HI))
		{
			chat_start_sequence("say_hi");
		}
		else
		{
			chat_start_sequence("say_hi_alt");
		}
	}

	void flag_said_hi()
	{
		SAID_HI = 1;
		if ((MET_LEOFING))
		{
			CHAT_MENU_ON = 0;
		}
	}

	void say_met_leofing()
	{
		if (!(SAID_LEOFING))
		{
			chat_start_sequence("say_met_leofing");
		}
		else
		{
			chat_start_sequence("say_met_leofing_alt");
		}
	}

	void flag_said_leofing()
	{
		UseTrigger("cv_met");
		SAID_LEOFING = 1;
	}

	void say_gave_items()
	{
		if (!(COLLECTED_ITEMS == 3)) return;
		chat_start_sequence("say_gave_items");
	}

	void flag_gave_items()
	{
		MET_LEOFING = 0;
		COLLECTED_ITEMS = 0;
		IDEMARK_ID = FindEntityByName("idemark");
	}

	void ext_chapel_start()
	{
		SetSayTextRange(2000);
		if (!(CHAPEL_CHAT_STEP))
		{
			chat_now("Idemark... all this time, it was you? Of course, there was no other explanation for all of this.", 7, "none", "ext_chapel_start");
		}
		else
		{
			if (CHAPEL_CHAT_STEP == 1)
			{
				chat_now("The years that passed, the thousands of allies slain by the hordes of The Lost, the chosen Apostles now fallen.", 7, "none", "ext_chapel_start");
			}
			else
			{
				if (CHAPEL_CHAT_STEP == 2)
				{
					chat_now("And your inner sanctum was the only one standing intact?", 4, "none", "do_idemark_line");
				}
				else
				{
					if (CHAPEL_CHAT_STEP == 3)
					{
						chat_now("I am beyond impressed, in all my travels this type of magic has never been proven successful.", 6, "none", "ext_chapel_start");
					}
					else
					{
						if (CHAPEL_CHAT_STEP == 4)
						{
							chat_now("The power of ritual. A type of magic that can be practiced by the young, the old; the sick, the healthy; the stupid, and gifted alike.", 9, "none", "ext_chapel_start");
						}
						else
						{
							if (CHAPEL_CHAT_STEP == 5)
							{
								chat_now("To ritualize a mass sacrifice like this is unprecedented, even Leofing was unaware, I believe he was just acting in devotion to you.", 8, "none", "ext_chapel_start");
							}
							else
							{
								if (CHAPEL_CHAT_STEP == 6)
								{
									chat_now("One last powerful ritual is what's needed to drain the pus from this festering wound that The Lost occupy.", 7, "none", "ext_chapel_start");
								}
								else
								{
									if (CHAPEL_CHAT_STEP == 7)
									{
										chat_now("Warrior of Fate, be ready, the evil is about to manifest itself!", 6, "none", "do_idemark_line");
									}
									else
									{
										if (CHAPEL_CHAT_STEP == 8)
										{
											chat_now("Oh, Idemark. Even in your diminished form you make time for pleasantries. I carry your spirit with me everywhere I go.", 8, "none", "ext_chapel_start");
										}
										else
										{
											if (CHAPEL_CHAT_STEP == 9)
											{
												chat_now("Goodbye, dear friend and mentor.", 3, "none", "none");
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		CHAPEL_CHAT_STEP += 1;
	}

	void do_idemark_line()
	{
		CallExternal(IDEMARK_ID, "ext_chapel_speech");
	}

	void ext_boss_died()
	{
		chat_start_sequence("say_boss_died");
	}

	void tele_out()
	{
		string L_HEIGHT = GetEntityHeight(GetOwner());
		string L_ORIGIN = GetEntityOrigin(GetOwner());
		L_ORIGIN += "z";
		ClientEvent("new", "all", "effects/sfx_sprite_in", L_ORIGIN, "c-tele1.spr", 24, 2);
		string L_TARGET = FindEntityByName("chapel_target1");
		SetEntityOrigin(GetOwner(), GetEntityOrigin(L_TARGET));
		SetAngles("face");
	}

	void ext_met_leofing()
	{
		MET_LEOFING = 1;
		if ((SAID_HI))
		{
			CHAT_MENU_ON = 0;
		}
	}

	void ext_collected()
	{
		COLLECTED_ITEMS += 1;
	}

}

}
