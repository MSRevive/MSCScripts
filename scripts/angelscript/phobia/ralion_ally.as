#pragma context server

#include "monsters/base_battle_ally.as"
#include "monsters/bandit_elite_archer.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class RalionAlly : CGameScript
{
	int ALLY_FOLLOW_ON;
	string ANIM_ATTACK;
	string ANIM_IDLE;
	int ATTACK_COF;
	string ATTACK_RANGE;
	int ATTACK_SPEED;
	string BANDIT_TYPE;
	string CHAT_CURRENT_SPEAKER;
	int CHAT_TEMP_NO_AUTO_FACE;
	int DROPS_CONTAINER;
	int HOSTILE_MODE;
	int MADE_DEAL;
	string MOVE_RANGE;
	int NO_STUCK_CHECKS;
	int NPC_BATTLE_ALLY;
	string NPC_HBAR_ADJ;
	int NPC_NO_PLAYER_DMG;
	int REWARD_MODE;
	int TC_AVG_DMG_PTS;
	string TC_HALF_AVG_DMG_PTS;
	int TC_QUAL_PLAYERS;
	int TOO_CLOSE;
	int USER_QUALIFIES;

	RalionAlly()
	{
		const string MY_SKILL = "archery";
		NPC_HBAR_ADJ = Vector3(0, 0, 32);
		const int WEAPON = 0;
		const int OVERRIDE_BANDIT_SPAWN = 1;
		const string AI_NO_TARGET_STRING = �NONE�;
		const string ANIM_ALLY_JUMP = "long_jump";
		const string SOUND_ALLY_JUMP = "player/shout1.wav";
		const int ALLY_JUMP_THRESHOLD = 150;
		const int NPC_PROX_ACTIVATE = 1;
		const int NPC_PROXACT_RANGE = 512;
		const string NPC_PROXACT_EVENT = "do_intro";
		const int NPC_PROXACT_DELAY = 0;
		const int NPC_PROXACT_IFSEEN = 0;
		const int NPC_PROXACT_FOV = 0;
		const int CHAT_MOVE_MOUTH = 0;
	}

	void game_precache()
	{
		Precache("monsters/bandit_elite");
	}

	void OnSpawn() override
	{
		BANDIT_TYPE = "bow";
		SetName("|Ralion");
		SetName("bandit_ralion");
		SetMonsterClip(0);
		SetModel("npc/rogue_1337.mdl");
		SetProp(GetOwner(), "scale", 1.5);
		SetGold(RandomInt(30, 40));
		SetWidth(32);
		SetHeight(92);
		SetRace("human");
		SetDamageResistance("all", 0.6);
		SetHearingSensitivity(10);
		SetRoam(false);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetMenuAutoOpen(1);
		ScheduleDelayedEvent(0.1, "custom_bowey");
	}

	void custom_bowey()
	{
		SetHealth(800);
		ATTACK_SPEED = 1200;
		MOVE_RANGE = ATTACK_SPEED;
		ATTACK_RANGE = ATTACK_SPEED;
		ATTACK_COF = 0;
		ANIM_ATTACK = "shootbow";
		SetModelBody(1, 5);
		TOO_CLOSE = 0;
		DROPS_CONTAINER = 1;
		NO_STUCK_CHECKS = 1;
		BANDIT_TYPE = "bow";
		ScheduleDelayedEvent(300.0, "bandit_remove_delay");
	}

	void bandit_remove_delay()
	{
		if ((HOSTILE_MODE)) return;
		if ((MADE_DEAL)) return;
		CallExternal("all", "bandits_remove");
	}

	void bandits_remove()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void game_menu_getoptions()
	{
		if ((HOSTILE_MODE)) return;
		if ((REWARD_MODE))
		{
			if ((MADE_DEAL))
			{
			}
			SendInfoMsg(param1, "Training with bandits You may only train with one bandit, so choose wisely.");
			string reg.mitem.title = "Bow Training...";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_reward";
		}
		if (!(MADE_DEAL))
		{
			SetGlobalVar("G_REWARD_LIST", "");
			string reg.mitem.title = "Deal.";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_deal";
			string reg.mitem.title = "No Deal.";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_no_deal";
		}
		if (!(G_DEVELOPER_MODE)) return;
		if (!(ALLY_FOLLOW_ON))
		{
			string reg.mitem.title = "Dev:Follow.";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "bandit_ally_start_follow";
		}
		else
		{
			string reg.mitem.title = "Dev:Stay here.";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "stop_follow";
		}
		string reg.mitem.title = "Dev:Go hostile.";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "bandit_ally_go_hostile";
	}

	void bandit_ally_start_follow()
	{
		PlayAnim("once", "break");
		ALLY_FOLLOW_ON = 1;
	}

	void stop_follow()
	{
		SayText("Stopping...");
		PlayAnim("once", "break");
		ALLY_FOLLOW_ON = 0;
	}

	void bandit_ally_go_hostile()
	{
		HOSTILE_MODE = 1;
		NPC_NO_PLAYER_DMG = 0;
		NPC_BATTLE_ALLY = 0;
		ALLY_FOLLOW_ON = 0;
		SetRace("rogue");
		SetRoam(true);
		if (BANDIT_TYPE != "bow")
		{
			NO_STUCK_CHECKS = 0;
		}
		SetMenuAutoOpen(0);
	}

	void do_intro()
	{
		SetMoveDest(NPC_PROXACT_PLAYERID);
		CHAT_CURRENT_SPEAKER = NPC_PROXACT_PLAYERID;
		EmitSound(GetOwner(), 0, "voices\phobia\ralion01.wav", 10);
		npcatk_resume_ai();
		CHAT_TEMP_NO_AUTO_FACE = 1;
		chat_now("Woah there! Hold a sec! Truce! Truce!", 2.0, "none", "do_intro2", "add_to_que");
	}

	void do_intro2()
	{
		CHAT_TEMP_NO_AUTO_FACE = 0;
		chat_now("I saw you tear through those orcs, and our would-be rescuers, like so much butter, and have no desire to put your steel to the test further.", 4.0, "look_idle", "play_line2", "add_to_que");
		chat_now("Not that it matters. Even without that display, the fort we escaped belongs to Graznux's horde, and the only way out, without going through it, is through this forest.", 6.0, "deep_idle", "play_line3", "add_to_que");
		chat_now("But there's angry spirits in this forest, and I'd rather not tangle with such a beasts alone, or with just my two men here.", 5.0, "deep_idle", "play_line4", "add_to_que");
		chat_now("I'd offer you gold for your help, but I'm sure you'd just as soon take it off our corpses. So let me offer you something that you can't acquire so easily...", 6.0, "look_idle", "play_line5", "add_to_que");
		chat_now("We three know our stuff. We can teach you a few tricks. I know my bows... Betor there knows his hammers. ...And Skelr sleeps with that damned dagger like it was a teddy.", 7.0, "aim_fireball_R", "play_line6", "add_to_que");
		chat_now("Help us escape this mess, and we'll teach you what we know... One lesson for each of you. Whaddaya say, deal?", 3.0, "look_idle", "set_deal_idle", "add_to_que");
	}

	void set_deal_idle()
	{
		OpenMenu(NPC_PROXACT_PLAYERID);
		ANIM_IDLE = "aim_fireball_R";
		SetIdleAnim(ANIM_IDLE);
	}

	void play_line2()
	{
		EmitSound(GetOwner(), 0, "voices\phobia\ralion02.wav", 10);
	}

	void play_line3()
	{
		EmitSound(GetOwner(), 0, "voices\phobia\ralion03.wav", 10);
	}

	void play_line4()
	{
		EmitSound(GetOwner(), 0, "voices\phobia\ralion04.wav", 10);
	}

	void play_line5()
	{
		EmitSound(GetOwner(), 0, "voices\phobia\ralion05.wav", 10);
	}

	void play_line6()
	{
		EmitSound(GetOwner(), 0, "voices\phobia\ralion06.wav", 10);
	}

	void say_deal()
	{
		chat_clear_que();
		MADE_DEAL = 1;
		SetMenuAutoOpen(0);
		ANIM_IDLE = "deep_idle";
		SetIdleAnim(ANIM_IDLE);
		EmitSound(GetOwner(), 0, "voices\phobia\ralion_deal.wav", 10);
		chat_now("Alright, we may make it out of this alive yet. Lead on, we'll follow.", 2.0, "aim_fireball_R", "none", "clear_que");
		CallExternal("all", "bandit_ally_start_follow");
	}

	void say_no_deal()
	{
		chat_clear_que();
		ANIM_IDLE = "deep_idle";
		MADE_DEAL = 1;
		SetMenuAutoOpen(0);
		SetIdleAnim(ANIM_IDLE);
		EmitSound(GetOwner(), 0, "voices\phobia\ralion_no_deal.wav", 10);
		chat_now("Well, I suppose we can always train you in the more direct way then.", 2.0, "none", "none", "clear_que");
		ScheduleDelayedEvent(1.0, "say_no_deal2");
	}

	void say_no_deal2()
	{
		CallExternal("all", "bandit_ally_go_hostile");
	}

	void OnSuspendAI()
	{
		LogDebug("npcatk_suspend_ai PARAM1 PARAM2");
	}

	void bandit_ally_fire_spawn()
	{
		ScheduleDelayedEvent(5.0, "bandit_ally_fire_spawn2");
	}

	void bandit_ally_fire_spawn()
	{
		chat_now("Oh, I was afraid Cethin would show her ugly self after we killed that damned bear of hers...", 3.0, "none", "aim_punch1", "clear_que");
		chat_now("You know the plan men, drink up!", 2.0, "none", "none", "clear_que");
		ScheduleDelayedEvent(5.0, "bandit_ally_fire_spawn3");
	}

	void bandit_ally_fire_spawn3()
	{
		CallExternal("all", "bandit_ally_drinkup");
	}

	void bandit_ally_drinkup()
	{
		PlayAnim("critical", "aim_punch1");
		string MY_HP = GetEntityHealth(GetOwner());
		string MY_MAXHP = GetEntityMaxHealth(GetOwner());
		if (MY_HP < MY_MAXHP)
		{
			string HEAL_AMT = MY_MAXHP;
			HEAL_AMT -= MY_HP;
			HealEntity(GetOwner(), HEAL_AMT);
		}
		string OUT_TITLE = GetEntityName(GetOwner());
		OUT_TITLE += " has quaffed a potion of fire resistance.";
		SendInfoMsg("all", "OUT_TITLE  ");
		SetDamageResistance("fire", 0.25);
		SetDamageResistance("all", 0.4);
		EmitSound(GetOwner(), 0, "items/drink.wav", 10);
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 64, 2, 2);
	}

	void bandit_ally_boss_dead()
	{
		npcatk_suspend_ai();
		npcatk_suspend_movement("deep_idle");
		SetMoveDest("none");
		check_qualify();
		ALLY_FOLLOW_ON = 0;
		REWARD_MODE = 1;
		SetMenuAutoOpen(1);
	}

	void check_qualify()
	{
		TC_QUAL_PLAYERS = 0;
		GetAllPlayers(TC_QUAL_PLAYERS);
		TC_AVG_DMG_PTS = 0;
		for (int i = 0; i < GetTokenCount(TC_QUAL_PLAYERS, ";"); i++)
		{
			tc_get_averages();
		}
		TC_AVG_DMG_PTS /= GetPlayerCount();
		TC_HALF_AVG_DMG_PTS = TC_AVG_DMG_PTS;
		TC_HALF_AVG_DMG_PTS *= 0.5;
	}

	void tc_get_averages()
	{
		string CUR_PLAYER = GetToken(TC_QUAL_PLAYERS, i, ";");
		TC_AVG_DMG_PTS += GetEntityProperty(CUR_PLAYER, "scriptvar");
	}

	void say_reward()
	{
		string USER_PTS = GetEntityProperty(param1, "scriptvar");
		USER_QUALIFIES = 0;
		if (USER_PTS >= TC_HALF_AVG_DMG_PTS)
		{
			USER_QUALIFIES = 1;
		}
		if (!(USER_QUALIFIES))
		{
			PlayAnim("critical", "look_idle");
			SayText("Judging by your performance out there , or rather the lack there of , I don t think you re ready for what I could teach you.");
		}
		if (!(USER_QUALIFIES)) return;
		string USER_STEAM = GetPlayerAuthId(param1);
		USER_STEAM += GetEntityProperty(param1, "slot");
		if ((G_REWARD_LIST).findFirst(USER_STEAM) >= 0)
		{
			PlayAnim("critical", "look_idle");
			SayText("Sorry , only one training session per customer. Thanks for helping us out of this mess though.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		PlayAnim("critical", "look_idle");
		SayText("Alright , here s a few tricks that ll let you show your enemies what-for.");
		int XP_GAIN = 20000;
		string PLR_ADJ = GetPlayerCount();
		PLR_ADJ -= 1;
		PLR_ADJ *= 0.25;
		PLR_ADJ += 1;
		XP_GAIN *= PLR_ADJ;
		GiveExp(param1, MY_SKILL, int(XP_GAIN));
		SendColoredMessage(param1, "* int(XP_GAIN) XP Awarded MY_SKILL");
		if (G_REWARD_LIST.length() > 0) G_REWARD_LIST += ";";
		G_REWARD_LIST += USER_STEAM;
		string OUT_MSG = "You recieve ";
		OUT_MSG += MY_SKILL;
		OUT_MSG += " from ";
		OUT_MSG += GetEntityName(GetOwner());
		SendInfoMsg(param1, "Training Recieved OUT_MSG");
	}

	void bandit_ally_lights()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(10.0, "bandit_ally_lights");
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 64, 0), 64, 9.9);
	}

}

}
