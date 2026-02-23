#pragma context server

namespace MS
{

class BaseNpcVendorConfirm : CGameScript
{
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEPS;
	int HAS_INCLUDE_VENDOR_CONFIRM;
	string NEXT_HINT_TEXT;
	int NPC_CHECK_LEVEL;
	string VEND_CHAT_MODE;
	string VEND_USER;

	BaseNpcVendorConfirm()
	{
		HAS_INCLUDE_VENDOR_CONFIRM = 1;
		NPC_CHECK_LEVEL = 1;
		string L_MAP_NAME = StringToLower(GetMapName());
		if (VEND_NEWBIE == "VEND_NEWBIE")
		{
			if (L_MAP_NAME == "edana")
			{
				VEND_NEWBIE = 1;
			}
			if (L_MAP_NAME == "deralia")
			{
				VEND_NEWBIE = 1;
			}
			if (L_MAP_NAME == "gatecity")
			{
				VEND_NEWBIE = 1;
			}
			if (L_MAP_NAME == "helena")
			{
				VEND_NEWBIE = 1;
			}
		}
		const float FREQ_HINT_TEXT = 120.0;
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(1.0, "player_scan");
		ScheduleDelayedEvent(2.0, "vend_post_spawn");
	}

	void vend_post_spawn()
	{
		if ((VEND_WEAPONS))
		{
			CatchSpeech("say_weapons", "weapon");
		}
		if ((VEND_CONTAINERS))
		{
			CatchSpeech("say_containers", "sheath");
		}
		VEND_CHAT_MODE = "none";
	}

	void player_scan()
	{
		if ((NPC_REACTS)) return;
		ScheduleDelayedEvent(1.0, "player_scan");
		if (!(CanSee("player", 128))) return;
		if (!(GetEntityMaxHealth(m_hLastSeen) < 100)) return;
		vendor_offer_help();
	}

	void vendor_offerstore()
	{
		if (!(true)) return;
		vendor_offer_help(GetEntityIndex(param1));
	}

	void vendor_offer_help()
	{
		if (!(true)) return;
		if ((BUSY_CHATTING)) return;
		if (!(GetGameTime() > NEXT_HINT_TEXT)) return;
		NEXT_HINT_TEXT = GetGameTime();
		NEXT_HINT_TEXT += FREQ_HINT_TEXT;
		if (!(GetEntityMaxHealth(param1) < 200)) return;
		if ((VEND_WEAPONS))
		{
			CatchSpeech("say_weapons", "weapon");
			if (!(VEND_CONTAINERS))
			{
			}
			SayText("I can tell you about the [weapons] I have for sale.");
			bchat_mouth_move();
		}
		if ((VEND_CONTAINERS))
		{
			CatchSpeech("say_containers", "sheath");
			bchat_mouth_move();
			if (!(VEND_WEAPONS))
			{
				SayText("I can tell you about the [containers] I have for sale.");
			}
			if ((VEND_WEAPONS))
			{
			}
			SayText("I can tell you about the types [weapons] and [containers] I have for sale , if you like.");
		}
		if ((VEND_ARMORER))
		{
			if (GetEntityProperty(param1, "strength") < 10)
			{
				SayText("You might want to bulk up a bit before you try wearing any of my armors.");
				bchat_mouth_move();
			}
			else
			{
				if (GetEntityProperty(param1, "strength") < 20)
				{
				}
				SayText("You look like you have enough muscle on you to handle my leather armors.");
				SayText("Still, I'd bulk up a bit more before trying the platemail, if I were you.");
				bchat_mouth_move();
			}
		}
	}

	void game_menu_getoptions()
	{
		if (!(VEND_NEWBIE)) return;
		if (VEND_CHAT_MODE == "none")
		{
			if ((VEND_WEAPONS))
			{
				string reg.mitem.title = "About Weapons";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_weapons";
				int OFFER_HELP = 1;
			}
			if ((VEND_CONTAINERS))
			{
				string reg.mitem.title = "About Containers";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_containers";
				int OFFER_HELP = 1;
			}
			if ((OFFER_HELP))
			{
				vendor_offer_help(GetEntityIndex(param1));
			}
		}
		if (VEND_CHAT_MODE == "weapons")
		{
			SayText("Which sort of weapon would you like to know about?");
			string reg.mitem.title = "Bows";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "archery";
			string reg.mitem.callback = "say_weapon_desc";
			string reg.mitem.title = "Axes";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "axehandling";
			string reg.mitem.callback = "say_weapon_desc";
			string reg.mitem.title = "Blunt Arms";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "bluntarms";
			string reg.mitem.callback = "say_weapon_desc";
			string reg.mitem.title = "Gauntlets";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "martialarts";
			string reg.mitem.callback = "say_weapon_desc";
			string reg.mitem.title = "Smallarms";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "smallarms";
			string reg.mitem.callback = "say_weapon_desc";
			string reg.mitem.title = "Swords";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "swordsmanship";
			string reg.mitem.callback = "say_weapon_desc";
			string reg.mitem.title = "Polearms";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "polearms";
			string reg.mitem.callback = "say_weapon_desc";
			string reg.mitem.title = "Scrolls and Tomes";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "spellcasting";
			string reg.mitem.callback = "say_weapon_desc";
		}
		bchat_mouth_move();
	}

	void game_menu_cancel()
	{
		VEND_CHAT_MODE = "none";
	}

	void say_weapons()
	{
		VEND_CHAT_MODE = "weapons";
		VEND_USER = param1;
		if (!(IsEntityAlive(VEND_USER)))
		{
			VEND_USER = GetEntityIndex("ent_lastspoke");
		}
		ScheduleDelayedEvent(0.1, "send_chat_menu");
	}

	void send_chat_menu()
	{
		OpenMenu(VEND_USER);
	}

	void say_weapon_desc()
	{
		VEND_CHAT_MODE = "none";
		if ((BUSY_CHATTING)) return;
		if (param2 == "archery")
		{
			CHAT_STEPS = 4;
			CHAT_STEP1 = "Bows are excellent for wearing down opponents from a distance, before they can reach you.";
			CHAT_STEP2 = "Basic arrows are always available, but for that extra kick, you'll want to purchase more specialized arrows.";
			CHAT_STEP3 = "Training with bows doesn't bulk one up much, but aids in awareness and concentration, honing the mind for other tasks.";
			CHAT_STEP4 = "Such mental discipline can also aid in the working of magic. But one does not live by bow and spell alone.";
		}
		if (param2 == "axehandling")
		{
			CHAT_STEPS = 3;
			CHAT_STEP1 = "Smaller axes offer quick and steady damage. The large ones are slow and difficult to strike with, but can inflict massive wounds.";
			CHAT_STEP2 = "Either way, axe training offers rapid gains in both strength and endurance.";
			CHAT_STEP3 = "Nonetheless, the wise adventure always trains in as wide a range of weaponry as possible.";
		}
		if (param2 == "bluntarms")
		{
			CHAT_STEPS = 2;
			CHAT_STEP1 = "Maces and hammers can be used to stun opponents, in addition to offering formidable strength.";
			CHAT_STEP2 = "It's a good idea, however, to balance the brute strength they offer with the other weapon disciplines as well.";
		}
		if (param2 == "martialarts")
		{
			CHAT_STEPS = 3;
			CHAT_STEP1 = "Gauntlets are for aiding in brawling and martial arts training.";
			CHAT_STEP2 = "Virtually unarmed combat of this sort can get you out of a pinch!";
			CHAT_STEP3 = "But you'll have to learn all the combat skills you can, or risk always being in one!";
		}
		if (param2 == "smallarms")
		{
			CHAT_STEPS = 3;
			CHAT_STEP1 = "Knives and daggers require that you get in close with your opponent.";
			CHAT_STEP2 = "But they offer swift attack speeds and thus are not to be underestimated.";
			CHAT_STEP3 = "Training in smallarms offers little endurance, but great speed and agility.";
		}
		if (param2 == "swordsmanship")
		{
			CHAT_STEPS = 3;
			CHAT_STEP1 = "Swordsmanship training is a balanced art, offering moderate gains in most all physical abilities.";
			CHAT_STEP2 = "While it is good to be a well rounded warrior, however, it is wise to learn all one can of all the weapons.";
			CHAT_STEP3 = "This ensures one doesn't fall behind the extremists by taking the moderate approach!";
		}
		if (param2 == "spellcasting")
		{
			CHAT_STEPS = 3;
			CHAT_STEP1 = "Memorizing tomes, or invoking scrolls, allows access to a wide range of magical abilities.";
			CHAT_STEP2 = "It's an entirely mental activity though, and does nothing for the physique.";
			CHAT_STEP3 = "So while magical ability is cruicial for the adventurer, to be sure, man cannot live by magic alone.";
		}
		if (param2 == "polearms")
		{
			CHAT_STEPS = 4;
			CHAT_STEP1 = "Polearms are tricky to employ effectively in one on one combat, but deadly in the hands of an agile warrior.";
			CHAT_STEP2 = "They are very dynamic weapons, but you need to keep you enemy at a fair distance to optimize the damage.";
			CHAT_STEP3 = "While they aren't very effective at close range, the careful warrior can hold his opponent at bay, for a solid strike.";
			CHAT_STEP4 = "They do little to train robustness, but the footwork involved favors speed, concentration, and the like.";
		}
		chat_loop();
	}

	void say_containers()
	{
		CHAT_STEPS = 3;
		CHAT_STEP1 = "Weapon straps hold any type of weapon. Quivers hold amunition. Big sacks hold nearly everything else.";
		CHAT_STEP2 = "Backpacks can hold nearly anything, useful for more a more generalized inventory.";
		CHAT_STEP3 = "Spellbooks hold magic scrolls. The small sack can hold most items, but has very little room, so it can't hold very many.";
		if ((VEND_SPEC_SHEATHS))
		{
			CHAT_STEP4 = "I also offer more specialized sheaths, that can only hold specific weapon types.";
			CHAT_STEPS = 4;
		}
		chat_loop();
	}

}

}
