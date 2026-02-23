#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class FragmentIdemark : CGameScript
{
	string CHAPEL_WALK_POINT;
	int CHAT_MENU_ON;
	string ISHMEEA_ID;
	string MANARING_TARGET;
	int RING_STEP;

	FragmentIdemark()
	{
		const int CHAT_AUTO_HAIL = 1;
		const int CHAT_USE_CONV_ANIMS = 0;
		const int CHAT_FACE_ON_USE = 0;
		const int CHAT_AUTO_FACE = 0;
		RING_STEP = 0;
	}

	void OnSpawn() override
	{
		SetName("a fragment of|Idemark");
		SetName("idemark");
		SetHealth(100);
		SetNoPush(true);
		SetSayTextRange(1000);
		SetInvincible(true);
		SetRace("beloved");
		SetModel("npc/femhuman2.mdl");
		SetWidth(32);
		SetHeight(72);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderfx", 3);
		SetProp(GetOwner(), "renderamt", 225);
		SetIdleAnim("sitting2");
		SetMoveAnim("walk");
		CatchSpeech("say_gems", "gem");
		CatchSpeech("say_ring", "ring");
		SetMenuAutoOpen(1);
		CHAPEL_WALK_POINT = FindEntityByName("chapel_target2");
	}

	void game_menu_getoptions()
	{
		if (!(CHAT_MENU_ON)) return;
		string L_QUEST = GetPlayerQuestData(param1, "manaring");
		string L_ITEM = ItemExists(param1, "item_ring_ryza");
		if (!(L_QUEST == "0")) return;
		if (!(L_ITEM)) return;
		int L_GEM_COUNT = 0;
		L_GEM_COUNT += ItemExists(param1, "item_ring_ryza_gem1");
		L_GEM_COUNT += ItemExists(param1, "item_ring_ryza_gem2");
		L_GEM_COUNT += ItemExists(param1, "item_ring_ryza_gem3");
		L_GEM_COUNT += ItemExists(param1, "ring_light2");
		if (L_GEM_COUNT == 0)
		{
			string reg.mitem.title = "Show Ryza's Trinket";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_ring_nogems";
		}
		else
		{
			if (L_GEM_COUNT < 4)
			{
				string reg.mitem.title = "Show Ryza's Artifacts";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_not_enough_gem";
			}
			else
			{
				string reg.mitem.title = "Give Ryza's Artifacts";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "fix_ring_and_return";
			}
		}
	}

	void say_hi()
	{
		if ((CHAT_BUSY)) return;
		if (!(CHAT_MENU_ON)) return;
		chat_now("Who goes there? Are you of the Lost?", 3);
		chat_now("I have retreated to the confines of this chapel, where I have just enough power to keep their leader sealed in another plane of reality.", 7);
		chat_now("You must seek out one of my guard, should they still exist among us. They have each sworn an oath to me, serving me even in death. They can help you.", 9);
	}

	void say_ring_nogems()
	{
		if ((CHAT_BUSY)) return;
		if (!(CHAT_MENU_ON)) return;
		chat_now("Is that?... no. Not here. It wouldn't make sense.");
		chat_now("Please tell me the magical bindings of Atholo have not failed! Unless...");
		chat_now("You've defeated him? It has been centuries since I devised the ensorcelled device.");
		chat_now("To allow a great power to remain on your plane whose sole purpose was to bind Atholo.");
		chat_now("Ryza was a devoted supporter and believed in the strength of humanity. Her sacrifice will echo in eternity. I am forever grateful of her divine act to preserve this plane.");
		chat_now("The device, however, seems to be missing its three focusing [lenses], as well as the empowering body to which it is attuned.");
		chat_now("If you are able to find such and return them to me, I may be able to scrounge up the arcane power of this tower to restore this artifact to its former glory.");
	}

	void say_not_enough_gem()
	{
		if ((CHAT_BUSY)) return;
		if (!(CHAT_MENU_ON)) return;
		chat_now("It seems you are on the right track, seeker. However, the device, the ring, and its focusing gems are useless without each other.");
		chat_now("Return to me with the [ring] and all three [gems] and I will attempt to restore its power for you.");
	}

	void say_gems()
	{
		if ((CHAT_BUSY)) return;
		if (!(CHAT_MENU_ON)) return;
		chat_now("It seems one has made its way into the cursed coffers of a crystal-protected bandit's stronghold, nestled deep in a lush grove.");
		chat_now("You may need to find yet more crystals, however.");
		chat_now("Another was given to a powerful crystalline wizard who was so apt at the arcane, they could split their very being into elemental fragments.");
		chat_now("The final jewel has recessed deep under the cliffs, to the possession of a dimensional arachnid.");
		chat_now("The base of the trinket was once a gift to Felewyn's devout followers to light their way during dark times.");
	}

	void say_ring()
	{
		say_gems();
	}

	void fix_ring_and_return()
	{
		if ((CHAT_BUSY)) return;
		if (!(CHAT_MENU_ON)) return;
		int L_GEM_COUNT = 0;
		L_GEM_COUNT += ItemExists(param1, "item_ring_ryza");
		L_GEM_COUNT += ItemExists(param1, "item_ring_ryza_gem1");
		L_GEM_COUNT += ItemExists(param1, "item_ring_ryza_gem2");
		L_GEM_COUNT += ItemExists(param1, "item_ring_ryza_gem3");
		L_GEM_COUNT += ItemExists(param1, "ring_light2");
		if (L_GEM_COUNT == 5)
		{
			L_GEM_COUNT += ItemExists(param1, "item_ring_ryza");
			L_GEM_COUNT += ItemExists(param1, "item_ring_ryza_gem1");
			L_GEM_COUNT += ItemExists(param1, "item_ring_ryza_gem2");
			L_GEM_COUNT += ItemExists(param1, "item_ring_ryza_gem3");
			L_GEM_COUNT += ItemExists(param1, "ring_light2");
			MANARING_TARGET = param1;
			chat_now("By Felewyn's Light. You've done it! The awe-inspiring power of this magical construct shall resonate once again.", 6.5);
			chat_now("Give me a moment, as I attempt to restore the ring to its former glory.", 4.5);
			chat_now("Just need to recall the ancient incantations...", 3, "none", "make_ring");
		}
	}

	void give_manaring()
	{
		SetPlayerQuestData(MANARING_TARGET, "manaring");
		// TODO: offer MANARING_TARGET item_ring_mana
		MANARING_TARGET = "MANARING_TARGET";
	}

	void make_ring()
	{
		EmitSound(GetOwner(), 0, "magic/energy1_loud.wav", 10);
		if (!(RING_STEP))
		{
			PlayAnim("critical", "sitting3");
			EmitSound(GetOwner(), 0, "magic/shock_noloop.wav", 10);
			ClientEvent("new", "all", "effects/sfx_light_fade", GetEntityProperty(GetOwner(), "svbonepos"), "(255,0,0)", 200, 0);
		}
		else
		{
			if (RING_STEP == 1)
			{
				ClientEvent("new", "all", "effects/sfx_light_fade", GetEntityProperty(GetOwner(), "svbonepos"), "(255,0,255)", 200, 0);
			}
			else
			{
				if (RING_STEP == 2)
				{
					ClientEvent("new", "all", "effects/sfx_light_fade", GetEntityProperty(GetOwner(), "svbonepos"), "(0,255,0)", 200, 0);
				}
				else
				{
					if (RING_STEP == 3)
					{
						ClientEvent("new", "all", "effects/sfx_light_fade", GetEntityProperty(GetOwner(), "svbonepos"), "(255,255,255)", 200, 0);
						RING_STEP = 0;
						done_ring();
						return;
					}
				}
			}
		}
		RING_STEP += 1;
		ScheduleDelayedEvent(2.4, "make_ring");
	}

	void done_ring()
	{
		if (!((MANARING_TARGET !is null))) return;
		chat_now("...there it is. A wonder to behold. An ancient artifact born anew. Its latent energies manifest once more! The arcane shall now flow through you readily.", "none", "none", !"give_manaring");
		chat_now("Thank you, adventurer, for restoring this great power. For being a champion of its rebirth. Its mana stones shall restore your magical powers, just as you have done for it.");
		chat_now("May Felewyn forever be by your side.");
	}

	void ext_chapel_start()
	{
		chat_clear_que();
		if (((MANARING_TARGET !is null)))
		{
			give_manaring();
		}
		SetSayTextRange(2000);
		SetIdleAnim("idle1");
		SetMoveDest(CHAPEL_WALK_POINT);
		PlayAnim("critical", "sitstand");
		ISHMEEA_ID = FindEntityByName("ishmeea");
		CHAT_MENU_ON = 0;
	}

	void game_reached_dest()
	{
		string L_ORIGIN = GetEntityOrigin(CHAPEL_WALK_POINT);
		L_ORIGIN = "z";
		SetEntityOrigin(GetOwner(), L_ORIGIN);
		SetAngles("face");
	}

	void ext_chapel_speech()
	{
		if (!(CHAPEL_CHAT_STEP))
		{
			chat_now("Ishme'Ea. No, I played a small part in all this. I am just as much a prisoner in this chapel as the monstrosity that I restrain.", 8, "none", "ext_chapel_speech");
		}
		if (CHAPEL_CHAT_STEP == 1)
		{
			chat_now("Yourself and Leofing were essential parts of the series of protective rituals that I have cast in and around the tower.", 6, "none", "ext_chapel_speech");
		}
		if (CHAPEL_CHAT_STEP == 2)
		{
			chat_now("I also counted on your curiosity and eagerness to help the world. In hopes that you would return with the knowledge to aid us.", 7, "none", "do_ishmeea_line");
		}
		if (CHAPEL_CHAT_STEP == 3)
		{
			chat_now("Goodbye, Ishme'Ea. I will not survive the ritual. It was an honor to serve as Apostle to Pathos.", 6, "none", "ext_chapel_speech");
		}
		if (CHAPEL_CHAT_STEP == 4)
		{
			chat_now("And an honor to be your first teacher. Benevolent visitor, may your steel strike true, and your magic flow freely.", 7, "none", "do_ishmeea_line");
			ScheduleDelayedEvent(10, "ded");
		}
		CHAPEL_CHAT_STEP += 1;
	}

	void do_ishmeea_line()
	{
		CallExternal(ISHMEEA_ID, "ext_chapel_start");
	}

	void ded()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
