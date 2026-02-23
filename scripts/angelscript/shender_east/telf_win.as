#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class TelfWin : CGameScript
{
	int MENTIONED_SEEKERS;

	TelfWin()
	{
		const int CHAT_USE_CONV_ANIMS = 0;
		const int ATTACH_LHAND = 3;
		const int ATTACH_RHAND = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10.0);
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 128, 255), 32, 9.9);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(90.0);
		CallExternal(FindEntityByName("telf_chest"), "chest_glow");
	}

	void OnSpawn() override
	{
		SetName("Fedrosh the Rammata");
		SetRace("human");
		SetHealth(2000);
		SetWidth(32);
		SetHeight(96);
		SetModel("npc/elf_m_wizard.mdl");
		SetIdleAnim("deep_idle");
		SetMoveAnim("deep_idle");
		SetNoPush(true);
		SetInvincible(true);
		SetMenuAutoOpen(1);
		SetSayTextRange(640);
		if (!(true)) return;
		SetName("telf_win");
		ScheduleDelayedEvent(2.0, "win_speech");
		ScheduleDelayedEvent(0.1, "pre_glow");
	}

	void pre_glow()
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 128, 255), 32, 9.9);
	}

	void win_speech()
	{
		CallExternal(FindEntityByName("telf_chest"), "ext_unlock");
		chat_now("By Torkalath! You did it! You broke the curse!", 3.0, "convo_unarmed_norm", "none", "add_to_que");
		chat_now("Please, take anything from my lock box over there, it's all yours.", 5.0, "none", "none", "add_to_que");
		chat_now("Be sure to take the amulet. With that, you can enter our Melanion enclave.", 5.0, "convo_unarmed_norm", "none", "add_to_que");
		chat_now("I can't promise how hospitable the refugees there will be, to anyone without one.", 5.0, "none", "none", "add_to_que");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Who are you, exactly?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_hi";
		string reg.mitem.title = "What do you know of this place?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_detail";
		string reg.mitem.title = "Where is the enclave?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_stronghold";
		if ((MENTIONED_SEEKERS))
		{
			string reg.mitem.title = "Seekers?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_seeker";
		}
	}

	void say_hi()
	{
		MENTIONED_SEEKERS = 1;
		chat_now("Sorry, my introduction in the dream was a bit rushed, I suppose...", 4.0, "convo_unarmed_norm", "clear_que", "add_to_que");
		chat_now("I am Fedrosh, a follower of Torkalath. I watch over this particular Melenion entrance to the enclave, to keep it safe.", 5.0, "none", "none", "add_to_que");
		chat_now("A few moons ago, I caught a group of Seekers, searching for the entrance.", 3.0, "convo_unarmed_norm", "none", "add_to_que");
		chat_now("I drove them off, but not before one of them placed that nightmare curse on me.", 4.0, "none", "none", "add_to_que");
		chat_now("It seems your efforts broke that curse. My magic is restored, so I should be fine now.", 4.0, "none", "do_spell_trick", "add_to_que");
	}

	void do_spell_trick()
	{
		PlayAnim("critical", "ref_aim_trip");
		ClientEvent("new", "all", "effects/sfx_beam_sparks", GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner()), ATTACH_LHAND, Vector3(255, 255, 0), 1.0);
		EmitSound(GetOwner(), 0, "debris/zap1.wav", 5);
	}

	void say_seeker()
	{
		chat_now("I suppose we elves have been isolated for quite some time, so you may not aware of our... Political situation.", 4.0, "convo_unarmed_norm", "clear_que", "add_to_que");
		chat_now("The elven empire, or rather, what remains of it, is essentially divided into three factions:", 4.0, "none", "none", "add_to_que");
		chat_now("The Felewyn elves, who maintain the old traditions, and retain exclusive control over the capital city and the military...", 5.0, "none", "none", "add_to_que");
		chat_now("Those that follow Urdual, also known as the Eshu, who are still somewhat tollerated, and live in the surrounding forests...", 5.0, "none", "none", "add_to_que");
		chat_now("And those such as myself, who follow the God of Strength, Torkalath, also known as the Ramatta.", 4.0, "convo_unarmed_norm", "none", "add_to_que");
		chat_now("Elves from the capital revile Ramatta. They send murderous squads of Seekers: wizards, warriors, and priests, trained to hunt us down.", 5.0, "none", "none", "add_to_que");
		chat_now("They've been seeking our enclave for quite some time. But thus far, I've kept this entrance secure.", 5.0, "none", "none", "add_to_que");
		chat_now("We've children and elderly housed there, but the Seekers are relentless, and would murder them, one and all.", 5.0, "convo_unarmed_panic", "none", "add_to_que");
	}

	void say_stronghold()
	{
		chat_now("Grateful as I am for your assistance, I'm afraid I'm under an oath, and cannot be very specific about that.", 5.0, "convo_unarmed_norm", "clear_que", "add_to_que");
		chat_now("I can only go so far as to say that one entrance is nearby, and no, it is not inside this house.", 4.0, "none", "none", "add_to_que");
	}

	void say_detail()
	{
		chat_now("We're fairly close to the south side of The Wall...", 3.0, "convo_unarmed_norm", "clear_que", "add_to_que");
		chat_now("I'm afraid you can't pass beyond it, without going through it - which is quite dangerous, of course.", 5.0, "none", "none", "add_to_que");
		chat_now("Additionally, there are tribes of ice orcs, Marogar, wandering about, no doubt attempting to probe the fortresses for a safe path.", 5.0, "convo_unarmed_norm", "none", "add_to_que");
		chat_now("Oh! And there's also a giant ice construct, of some sort, wandering about the western lake!", 5.0, "convo_unarmed_panic", "none", "add_to_que");
		chat_now("However, it seems it will not accost you, provided you don't wander too close.", 5.0, "none", "none", "add_to_que");
		chat_now("No doubt, it's some ancient creation of a previous age, set to guard something that has long since sunk beneath the ice.", 5.0, "convo_unarmed_norm", "none", "add_to_que");
		chat_now("If you are unfortunate enough to accidentally gain the thing's attention, just keep running. It will tire of chasing you, eventually.", 5.0, "none", "none", "add_to_que");
	}

	void ext_bunny_comment()
	{
		chat_now("Now... Where has my bunny Hazel run off to?", 5.0, "convo_unarmed_norm", "none", "add_to_que");
		EmitSound(GetOwner(), 0, "scientist/cough.wav", 10);
	}

}

}
