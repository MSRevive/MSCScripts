#pragma context server

#include "monsters/sorc_shaman_elder.as"
#include "monsters/sorc_base.as"
#include "bloodshrine/base_sorc_friendly.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class SorcShamanFriendly : CGameScript
{
	string BALL_TYPE;
	int DID_SHADOWFORM;
	int DOING_SWITCH_PAGE;
	int FOLLOW_PLR_DIST;
	string FOLLOW_PLR_ID;
	string LEADER_ID;
	string PLAYERS_TO_REWARD;
	int REWARDS_LEFT;
	string SECOND_ID;
	string SETUP_QUALIFICATIONS;
	string SFORC_MENU_TARGET;
	int SKILL_PAGE;
	string T_LEADER_ID;
	string T_SECOND_ID;

	SorcShamanFriendly()
	{
		const int CHAT_USE_CONV_ANIMS = 0;
		const int CHAT_NO_CLOSE_MOUTH = 1;
		const int CHAT_NEVER_INTERRUPT = 1;
		const int NO_SUMMON = 1;
		const string SWIPE_DAMAGE = "$rand(50,120)";
		const string FROST_BOLT_DAMAGE = "$rand(80,175)";
		const string FROST_STRIKE_DAMAGE = "$rand(60,120)";
		FOLLOW_PLR_DIST = 256;
		const Vector3 SFS_ENTRANCE_POINT = Vector3(1584, -1152, -128);
		SKILL_PAGE = 1;
	}

	void orc_spawn()
	{
		SetName("Meshkhar , the Elder");
		SetName("fsorc_shaman");
		SetHealth(8000);
		SetHearingSensitivity(8);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("poison", 2.0);
		SetRace("human");
		SetRoam(false);
		SetWidth(32);
		SetHeight(96);
		SetModel("monsters/sorc.mdl");
		SetModelBody(1, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
	}

	void ext_shaman_lines()
	{
		LEADER_ID = FindEntityByName("fsorc_leader");
		FOLLOW_PLR_ID = GetEntityProperty(LEADER_ID, "scriptvar");
		bfsorc_follow_close();
		chat_now("Yes... And then some of us, began to change, and were taken away.", 5.0, "nod_yes", "release_zorc", "add_to_que");
		chat_now("We were once a force of nine, but now, we are but four...", 5.0, "neigh", "add_to_que");
	}

	void release_zorc()
	{
		bfsorc_follow_normal();
		UseTrigger("sorc_door2");
		ScheduleDelayedEvent(5.0, "release_zorc2");
	}

	void release_zorc2()
	{
		SECOND_ID = FindEntityByName("fsorc_second");
		CallExternal(SECOND_ID, "ext_zombie_react");
	}

	void alert_shadowforms()
	{
		if ((DID_SHADOWFORM)) return;
		T_LEADER_ID = FindEntityByName("fsorc_leader");
		T_SECOND_ID = FindEntityByName("fsorc_second");
		DID_SHADOWFORM = 1;
		chat_now("Wait... This scent...", 5.0, "add_to_que");
		chat_now("One of the old dark ones lairs here...", 4.0, "warcry", "add_to_que");
		if ((IsEntityAlive(T_LEADER_ID)))
		{
			int LEADER_ALIVE = 1;
		}
		if ((IsEntityAlive(T_SECOND_ID)))
		{
			int SECOND_ALIVE = 1;
		}
		if ((LEADER_ALIVE))
		{
			if (!(SECOND_ALIVE))
			{
				chat_now("Brindahr, wait here. Your weapon will be useless against it.", 4.0, "add_to_que");
			}
			if ((SECOND_ALIVE))
			{
				chat_now("You two wait here. Your weapons will be useless against it.", 4.0, "add_to_que");
			}
		}
		if (!(LEADER_ALIVE))
		{
			if ((SECOND_ALIVE))
			{
				chat_now("Vurinahr, wait here. Your weapon will be useless against it.", 4.0, "add_to_que");
			}
		}
		if ((LEADER_ALIVE))
		{
			int DO_READY_COMMENT = 1;
		}
		if ((SECOND_ALIVE))
		{
			int DO_READY_COMMENT = 1;
		}
		if ((DO_READY_COMMENT))
		{
			chat_now("I, on the other hand, have a trick or two for just such creatures.", 4.0, "none", "set_warrior_wait", "add_to_que");
		}
		else
		{
			chat_now("I have a trick or two for just such creatures...", 4.0, "none", "set_warrior_wait", "add_to_que");
		}
	}

	void set_warrior_wait()
	{
		LEADER_ID = FindEntityByName("fsorc_leader");
		SECOND_ID = FindEntityByName("fsorc_second");
		CallExternal(LEADER_ID, "fsorc_wait", Vector3(1616, -1348, -128));
		CallExternal(SECOND_ID, "fsorc_wait", Vector3(1616, -1428, -128));
	}

	void ext_shadowform_boss()
	{
		BALL_DMG /= 3;
		ScheduleDelayedEvent(10.0, "ext_shadowform_boss2");
	}

	void ext_shadowform_boss2()
	{
		T_LEADER_ID = FindEntityByName("fsorc_leader");
		T_SECOND_ID = FindEntityByName("fsorc_second");
		chat_now("This creature is immune to our weaponry - you must use holy weapons and banishing magics!", 5.0, "add_to_que");
		chat_now("It's only vulnerable when the eye looks upon us! BEWARE THE EYE!", 5.0, "add_to_que");
		if ((IsEntityAlive(T_LEADER_ID)))
		{
			int LEADER_ALIVE = 1;
		}
		if ((IsEntityAlive(T_SECOND_ID)))
		{
			int SECOND_ALIVE = 1;
		}
		if ((LEADER_ALIVE))
		{
			if (!(SECOND_ALIVE))
			{
				chat_now("Brindahr - concentrate on the undead! The humans and I will strike at the eye of the beast!", 5.0, "add_to_que");
			}
			if ((SECOND_ALIVE))
			{
				chat_now("Shadahar warriors - concentrate on the undead! The humans and I will strike at the eye of the beast!", 5.0, "add_to_que");
			}
		}
		if (!(LEADER_ALIVE))
		{
			if ((SECOND_ALIVE))
			{
				chat_now("Vurinahr - concentrate on the undead! The humans and I will strike at the eye of the beast!", 5.0, "add_to_que");
			}
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		BALL_TYPE = "lightning";
		if (/* TODO: $get_takedmg */ $get_takedmg(m_hAttackTarget, "lightning") == 0)
		{
			BALL_TYPE = "holy";
		}
	}

	void ext_return_comment()
	{
		chat_now("If we can find the source of evil in this place, and destroy it, we should be able to return home through the ways.", 5.0, "nod_yes", "add_to_que");
	}

	void ext_wait_sfs_loop()
	{
		if ((DID_SHADOWFORM)) return;
		string MY_ORG = GetEntityOrigin(GetOwner());
		if (Distance(SFS_ENTRANCE_POINT, MY_ORG) < 256)
		{
			alert_shadowforms();
		}
		if ((DID_SHADOWFORM)) return;
		ScheduleDelayedEvent(0.1, "ext_wait_sfs_loop");
	}

	void give_reward_options()
	{
		LogDebug("give_reward_options REWARDS_LEFT vs REWARDS_TOTAL list PLAYERS_TO_REWARD vs PARAM1");
		if (!(REWARDS_LEFT > 0)) return;
		if (!((PLAYERS_TO_REWARD).findFirst(param1) >= 0)) return;
		if (!(DOING_SWITCH_PAGE))
		{
			chat_now("I can use my magics to enhance one of your skills, please select which one.", 3.0, "neigh", "add_to_que");
		}
		DOING_SWITCH_PAGE = 0;
		if (SKILL_PAGE == 1)
		{
			string reg.mitem.title = "Archery";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "archery";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Axe Handling";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "axehandling";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Bluntarms";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "bluntarms";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Martial Arts";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "martialarts";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Polearms";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "polearms";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Smallarms";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "smallarms";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Swordsmanship";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "swordsmanship";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Spellcasting...";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "switch_page2";
		}
		if (SKILL_PAGE == 2)
		{
			string reg.mitem.title = "Fire";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "spellcasting.fire";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Ice";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "spellcasting.ice";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Lightning";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "spellcasting.lightning";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Affliction";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "spellcasting.affliction";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "Divination";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "spellcasting.divination";
			string reg.mitem.callback = "enhance_skill";
			string reg.mitem.title = "(previous)";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "switch_page1";
		}
	}

	void switch_page2()
	{
		DOING_SWITCH_PAGE = 1;
		SKILL_PAGE = 2;
		SFORC_MENU_TARGET = param1;
		ScheduleDelayedEvent(0.5, "sforc_offer_menu");
	}

	void switch_page1()
	{
		DOING_SWITCH_PAGE = 1;
		SKILL_PAGE = 1;
		SFORC_MENU_TARGET = param1;
		ScheduleDelayedEvent(0.5, "sforc_offer_menu");
	}

	void enhance_skill()
	{
		chat_now("So be it. It is done.", 3.0, "warcry", "add_to_que");
		string FIND_INDX = FindToken(PLAYERS_TO_REWARD, param1, ";");
		RemoveToken(PLAYERS_TO_REWARD, FIND_INDX, ";");
		REWARDS_LEFT -= 1;
		Effect("glow", GetOwner(), "glow", Vector3(255, 255, 0), 64, 1, 1);
		if (param2 != "spellcasting.lightning")
		{
			int XP_GAIN = 5000;
			string PLR_ADJ = "game.playersnb";
			PLR_ADJ -= 1;
			PLR_ADJ *= 0.25;
			PLR_ADJ += 1;
			XP_GAIN *= PLR_ADJ;
			GiveExp(param1, param2, int(XP_GAIN));
			SendColoredMessage(param1, "* int(XP_GAIN) XP Awarded PARAM2");
		}
		else
		{
			int XP_GAIN = 10000;
			string PLR_ADJ = "game.playersnb";
			PLR_ADJ -= 1;
			PLR_ADJ *= 0.25;
			PLR_ADJ += 1;
			XP_GAIN *= PLR_ADJ;
			GiveExp(param1, param2, int(XP_GAIN));
			SendColoredMessage(param1, "* int(XP_GAIN) XP Awarded PARAM2");
		}
		if (!(REWARDS_LEFT == 0)) return;
		ScheduleDelayedEvent(6.0, "ready_to_go");
	}

	void sforc_offer_menu()
	{
		OpenMenu(SFORC_MENU_TARGET);
	}

	void ext_boss_dead()
	{
		REWARDS_LEFT = 0;
		PLAYERS_TO_REWARD = "";
		GetAllPlayers(REWARD_PLAYER_LIST);
		if (!(SETUP_QUALIFICATIONS))
		{
			SETUP_QUALIFICATIONS = 1;
			check_qualify();
		}
		for (int i = 0; i < GetTokenCount(REWARD_PLAYER_LIST, ";"); i++)
		{
			gather_reward_players();
		}
	}

	void gather_reward_players()
	{
		string CUR_PLAYER = GetToken(REWARD_PLAYER_LIST, i, ";");
		string DMG_PTS = GetEntityProperty(CUR_PLAYER, "scriptvar");
		if (DMG_PTS >= TC_HALF_AVG_DMG_PTS)
		{
			int PLR_QUALIFIED = 1;
		}
		if (!(PLR_QUALIFIED)) return;
		if (PLAYERS_TO_REWARD.length() > 0) PLAYERS_TO_REWARD += ";";
		PLAYERS_TO_REWARD += CUR_PLAYER;
		REWARDS_LEFT += 1;
	}

}

}
