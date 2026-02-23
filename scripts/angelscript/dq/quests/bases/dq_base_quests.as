#pragma context server

namespace MS
{

class DqBaseQuests : CGameScript
{
	int ALLY_FOLLOW_ON;
	string NO_STUCK_CHECKS;
	string NPCATK_TARGET;
	string OFFER_MENU_ID;
	string PLAYING_DEAD;
	int QUEST_CURRENTLY_COMBATING;
	string QUEST_MODE;
	string QUEST_TAKER;
	string QUEST_TAKER_MAXHP;
	int USING_BASE_QUEST;

	DqBaseQuests()
	{
		USING_BASE_QUEST = 1;
		const string QUEST_WAITING = "waiting";
		const string QUEST_ASKING = "asking";
		const string QUEST_ACTIVE = "active";
		const string QUEST_COMPLETE = "complete";
		const string QUEST_FAILED = "failed";
		QUEST_MODE = QUEST_WAITING;
		ALLY_FOLLOW_ON = 0;
		QUEST_CURRENTLY_COMBATING = 0;
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(1.1, "init_basic_npc_vars");
	}

	void quest_intro_check()
	{
		if (QUEST_MODE == QUEST_WAITING)
		{
			quest_intro();
			OFFER_MENU_ID = param1;
			ScheduleDelayedEvent(0.1, "offer_menu");
		}
	}

	void quest_intro()
	{
		QUEST_MODE = QUEST_ASKING;
	}

	void quest_activate_check()
	{
		if (QUEST_MODE == QUEST_ASKING)
		{
			quest_activate(param1);
		}
	}

	void quest_activate()
	{
		string L_PLAYER = param1;
		QUEST_TAKER = L_PLAYER;
		quest_taker_updated();
		activate_vars();
		QUEST_MODE = QUEST_ACTIVE;
	}

	void quest_finished_check()
	{
		if (QUEST_MODE == QUEST_ACTIVE)
		{
			quest_finished();
		}
	}

	void quest_finished()
	{
		init_post_spawn_vars();
		disable_vars();
		QUEST_MODE = QUEST_COMPLETE;
		inform_quest_finished();
	}

	void inform_quest_finished()
	{
		string L_STRING = "Please return to ";
		L_STRING += GetEntityProperty(GetOwner(), "name.full");
		SendInfoMsg("all", "Quest Complete L_STRING");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		QUEST_MODE = QUEST_FAILED;
	}

	void game_menu_getoptions()
	{
		if (QUEST_MODE != QUEST_WAITING)
		{
			if (QUEST_MODE != QUEST_ASKING)
			{
				if (!((QUEST_TAKER !is null)))
				{
					QUEST_TAKER = param1;
					quest_taker_updated();
				}
			}
		}
	}

	void quest_taker_updated()
	{
		QUEST_TAKER_MAXHP = GetEntityMaxHealth(QUEST_TAKER);
		quest_taker_maxhp_updated();
		if (QUEST_MODE != QUEST_COMPLETE)
		{
			if ((QUEST_FOLLOWER))
			{
				ALLY_FOLLOW_PLR_ID = QUEST_TAKER;
			}
		}
	}

	void init_basic_npc_vars()
	{
		SetName(QUEST_GIVER_NAME);
		SetWidth(NEW_WIDTH);
		SetHeight(NEW_HEIGHT);
		SetSolid("box");
		if (MONSTER_MODEL != "0")
		{
			SetModel(MONSTER_MODEL);
		}
		SetModelBody(0, GetToken(SUBMODEL_GROUPS, 0, ";"));
		if (GetTokenCount(SUBMODEL_GROUPS, ";") >= 2)
		{
			SetModelBody(1, GetToken(SUBMODEL_GROUPS, 1, ";"));
		}
		if (GetTokenCount(SUBMODEL_GROUPS, ";") >= 3)
		{
			SetModelBody(2, GetToken(SUBMODEL_GROUPS, 2, ";"));
		}
		if (GetTokenCount(SUBMODEL_GROUPS, ";") >= 4)
		{
			SetModelBody(3, GetToken(SUBMODEL_GROUPS, 3, ";"));
		}
		SetProp(GetOwner(), "skin", USE_SKIN);
		init_post_spawn_vars();
	}

	void init_post_spawn_vars()
	{
		SetRace(NEW_RACE);
		SetInvincible(AM_INVINCIBLE);
		if ((AM_INVINCIBLE))
		{
			do_target_me(0);
		}
		QUEST_CURRENTLY_COMBATING = QUEST_ACTIVE_COMBATANT;
		if ((QUEST_CURRENTLY_COMBATING))
		{
			do_roam(1);
		}
		else
		{
			do_roam(0);
		}
	}

	void activate_vars()
	{
		if (SET_SIEGE_MODE == 1)
		{
			critical_npc();
			do_target_me(1);
		}
		if (QUEST_COMBATANT == 1)
		{
			QUEST_CURRENTLY_COMBATING = 1;
			do_roam(1);
			do_target_me(1);
		}
		if (QUEST_FOLLOWER == 1)
		{
			set_follower(1);
			do_roam(1);
		}
		if (IS_LEADER == 1)
		{
			set_leader(1);
			do_roam(1);
		}
	}

	void disable_vars()
	{
		int L_STOP_ROAM = 0;
		if (IS_LEADER == 1)
		{
			set_leader(0);
			int L_STOP_ROAM = 1;
		}
		if (QUEST_FOLLOWER == 1)
		{
			ALLY_FOLLOW_ON = 0;
			int L_STOP_ROAM = 1;
		}
		if (QUEST_COMBATANT == 1)
		{
			if (QUEST_ACTIVE_COMBATANT == 0)
			{
				QUEST_CURRENTLY_COMBATING = 0;
				int L_STOP_ROAM = 1;
			}
		}
		if (L_STOP_ROAM == 1)
		{
			npcatk_clear_targets();
			do_roam(0);
			PlayAnim("critical", ANIM_IDLE);
		}
	}

	void npc_targetvalidate()
	{
		if (!(QUEST_CURRENTLY_COMBATING))
		{
			NPCATK_TARGET = "unset";
		}
	}

	void delete_fade_me()
	{
		if (QUEST_FADE_ON_COMPLETE == "fade")
		{
			do_delete_fade_bit();
		}
		else
		{
			if (QUEST_FADE_ON_COMPLETE == "walk_fade")
			{
				SetMoveDest(GetOwner());
				do_roam(1);
				ScheduleDelayedEvent(5.0, "do_delete_fade_bit");
			}
		}
	}

	void do_delete_fade_bit()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void do_roam()
	{
		if (param1 == 1)
		{
			SetRoam(true);
			NO_STUCK_CHECKS = 0;
		}
		else
		{
			SetRoam(false);
			NO_STUCK_CHECKS = 1;
		}
	}

	void do_target_me()
	{
		if (param1 == 0)
		{
			SetRace("beloved");
			PLAYING_DEAD = 1;
		}
		else
		{
			SetRace(NEW_RACE);
			PLAYING_DEAD = 0;
		}
	}

	void game_dynamically_created()
	{
		SetAngles("face");
	}

	void offer_menu()
	{
		OpenMenu(OFFER_MENU_ID);
	}

}

}
