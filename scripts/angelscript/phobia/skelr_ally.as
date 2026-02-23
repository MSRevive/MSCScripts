#pragma context server

#include "monsters/base_battle_ally.as"
#include "monsters/bandit_elite_dagger.as"

namespace MS
{

class SkelrAlly : CGameScript
{
	int ALLY_FOLLOW_ON;
	string ANIM_ATTACK;
	string ATTACK1_DAMAGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	string BANDIT_TYPE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int HOSTILE_MODE;
	int MADE_DEAL;
	int MOVE_RANGE;
	string NO_STUCK_CHECKS;
	int NPC_BATTLE_ALLY;
	int NPC_NO_PLAYER_DMG;
	string ORIG_ATTACK;
	int REWARD_MODE;
	int TC_AVG_DMG_PTS;
	string TC_HALF_AVG_DMG_PTS;
	int TC_QUAL_PLAYERS;
	int USER_QUALIFIES;

	SkelrAlly()
	{
		const string MY_SKILL = "smallarms";
		const int WEAPON = 1;
		const int OVERRIDE_BANDIT_SPAWN = 1;
		const string AI_NO_TARGET_STRING = �NONE�;
		const string ANIM_ALLY_JUMP = "long_jump";
		const string SOUND_ALLY_JUMP = "player/shout1.wav";
		const int ALLY_JUMP_THRESHOLD = 150;
	}

	void game_precache()
	{
		Precache("monsters/bandit_elite");
	}

	void OnSpawn() override
	{
		BANDIT_TYPE = "dagger";
		SetName("|Skelr the Swift");
		SetName("bandit_skelr");
		SetMonsterClip(0);
		SetModel("npc/rogue_1337.mdl");
		SetGold(RandomInt(30, 40));
		SetWidth(32);
		SetHeight(92);
		SetRace("human");
		SetDamageResistance("all", 0.6);
		SetHearingSensitivity(10);
		SetRoam(false);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(0.1, "custom_bandit");
	}

	void custom_bandit()
	{
		SetHealth(800);
		MOVE_RANGE = 30;
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = DMG_DAGGER;
		ATTACK_PERCENTAGE = 0.8;
		ANIM_ATTACK = "swordjab1_R";
		ORIG_ATTACK = ANIM_ATTACK;
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 1);
		DROP_ITEM1 = "smallarms_fangstooth";
		DROP_ITEM1_CHANCE = 0.05;
		BANDIT_TYPE = "dagger";
	}

	void bandit_ally_start_follow()
	{
		PlayAnim("once", "break");
		ALLY_FOLLOW_ON = 1;
		MADE_DEAL = 1;
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
			SayText("Sorry , the deal was you could train once from one of us. Thanks for the assist though. We should be fine from here.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string RALION_ID = FindEntityByName("bandit_ralion");
		if (!(IsEntityAlive(RALION_ID)))
		{
			PlayAnim("critical", "look_idle");
			SayText("Ralion maybe dead , but I ll stick to his deal... I ll show you what I know.");
		}
		else
		{
			PlayAnim("critical", "look_idle");
			SayText("Alright... I ll show you what I know.");
		}
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

	void game_menu_getoptions()
	{
		if ((HOSTILE_MODE)) return;
		if (!(MADE_DEAL)) return;
		if ((REWARD_MODE))
		{
			SendInfoMsg(param1, "Training with bandits You may only train with one bandit, so choose wisely.");
			string reg.mitem.title = "Smallarms Training...";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_reward";
		}
	}

	void bandits_remove()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void bandit_ally_lights()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(10.0, "bandit_ally_lights");
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 64, 0), 64, 9.9);
	}

}

}
