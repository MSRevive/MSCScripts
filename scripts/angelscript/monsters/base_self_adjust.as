#pragma context server

namespace MS
{

class BaseSelfAdjust : CGameScript
{
	string BASE_FRAMERATE;
	string BASE_MOVESPEED;
	string NEW_NAME;
	int NPC_ADJ_LEVEL;
	int NPC_ALL_XP_ADJ;
	string NPC_CUSTOM_NAME;
	string NPC_CUSTOM_NAME_STRING;
	string NPC_DMG_MULTI;
	string NPC_DO_EVENTS;
	int NPC_EVENT_COUNTER;
	string NPC_EXP_FINAL;
	string NPC_GIVE_EXP;
	int NPC_HP_MULTI;
	string NPC_MAXHP;

	BaseSelfAdjust()
	{
		const string NPC_ADJ_TIERS = "0;500;1000;2000;3000;5000";
		const string NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;2.0;3.0;3.5;4.0;5.0;";
		const string NPC_ADJ_HP_MUTLI_TOKENS = "1.0;2.0;3.0;3.5;4.0;5.0;";
	}

	void game_postspawn()
	{
		string L_IN_DMGMULTI = param2;
		string L_IN_HPMULTI = param3;
		LogDebug("game_postspawn got name PARAM1 dmg PARAM2 hp PARAM3 PARAMS: PARAM4");
		NEW_NAME = param1;
		if (NEW_NAME != "default")
		{
			SetName(NEW_NAME);
			NPC_CUSTOM_NAME = 1;
			NPC_CUSTOM_NAME_STRING = NEW_NAME;
		}
		if (NPC_DMG_MULTI == "NPC_DMG_MULTI")
		{
			NPC_DMG_MULTI = 1;
		}
		if (L_IN_DMGMULTI > 1)
		{
			NPC_DMG_MULTI = L_IN_DMGMULTI;
			if (NPC_DMG_MULTI_ADD > 0)
			{
				NPC_DMG_MULTI += NPC_DMG_MULTI_ADD;
			}
			SetDamageMultiplier(NPC_DMG_MULTI);
			int CREAT_ADJ = 1;
		}
		NPC_HP_MULTI = 1;
		if (L_IN_HPMULTI > 1)
		{
			NPC_HP_MULTI = L_IN_HPMULTI;
			if (NPC_HP_MULTI_ADD > 0)
			{
				NPC_HP_MULTI += NPC_HP_MULTI_ADD;
			}
			int CREAT_ADJ = 1;
		}
		if (param4 != "none")
		{
			NPC_DO_EVENTS = param4;
			ScheduleDelayedEvent(0.01, "npcatk_setup_addparams");
		}
	}

	void game_dynamically_created()
	{
		if (G_MAP_ADDPARAMS != 0)
		{
			npcatk_setup_addparams();
		}
	}

	void npcatk_setup_addparams()
	{
		LogDebug("npcatk_setup_addparams [ NPC_DO_EVENTS ]");
		if (G_MAP_ADDPARAMS != 0)
		{
			if ((NPC_DO_EVENTS).findFirst("no_global") >= 0)
			{
			}
			if (!(I_R_PET))
			{
			}
			string L_NPC_DO_EVENTS = G_MAP_ADDPARAMS;
			L_NPC_DO_EVENTS += NPC_DO_EVENTS;
			NPC_DO_EVENTS = L_NPC_DO_EVENTS;
			LogDebug("npcatk_setup_addparams gaddparamsout NPC_DO_EVENTS");
		}
		NPC_EVENT_COUNTER = 0;
		npcatk_do_events();
	}

	void npcatk_do_events()
	{
		string L_N_EVENTS = GetTokenCount(NPC_DO_EVENTS, ";");
		L_N_EVENTS -= 1;
		LogDebug("npcatk_do_events checking int(/* TODO: $math(add) */ NPC_EVENT_COUNTER) / int(/* TODO: $math(add) */ L_N_EVENTS)");
		string L_EVENT_NAME = GetToken(NPC_DO_EVENTS, NPC_EVENT_COUNTER, ";");
		string L_NEXT_EVENT_IDX = /* TODO: $math(add) */ NPC_EVENT_COUNTER;
		if (L_NEXT_EVENT_IDX <= L_N_EVENTS)
		{
			string L_NEXT_EVENT = GetToken(NPC_DO_EVENTS, L_NEXT_EVENT_IDX, ";");
			if (!(/* TODO: $func */ $func("npcatk_do_events_isnum", L_EVENT_NAME)))
			{
			}
			LogDebug("npcatk_do_events int(/* TODO: $math(add) */ NPC_EVENT_COUNTER) / int(/* TODO: $math(add) */ L_N_EVENTS) = L_EVENT_NAME L_NEXT_EVENT");
			L_EVENT_NAME(L_NEXT_EVENT);
		}
		else
		{
			if (!(/* TODO: $func */ $func("npcatk_do_events_isnum", L_EVENT_NAME)))
			{
			}
			LogDebug("npcatk_do_events int(/* TODO: $math(add) */ NPC_EVENT_COUNTER) / int(/* TODO: $math(add) */ L_N_EVENTS) = L_EVENT_NAME");
			L_EVENT_NAME();
		}
		if (NPC_EVENT_COUNTER < L_N_EVENTS)
		{
			NPC_EVENT_COUNTER += 1;
			ScheduleDelayedEvent(0.01, "npcatk_do_events");
		}
		else
		{
			if ((NPC_USES_HANDLE_EVENTS))
			{
				npcatk_handle_postevents();
			}
		}
	}

	void npcatk_do_events_isnum()
	{
		string L_FIRST_CHAR = (param1).substr(0, 1);
		int L_IS_NUM = 0;
		string L_NUMCHARS = "0123456789.,)($";
		if ((L_NUMCHARS).findFirst(L_FIRST_CHAR) > -1)
		{
			LogDebug("npcatk_do_events_isnum PARAM1 seems to be a parameter , skipping");
			int L_IS_NUM = 1;
		}
		return;
	}

	void OnPostSpawn() override
	{
		if ((I_R_PET)) return;
		if ((NPC_SELF_ADJUST))
		{
			npcatk_self_adjust();
		}
		npcatk_set_skill();
		LogDebug("npc_post_spawn Final Adjustments - mdmg NPC_DMG_MULTI mhp NPC_HP_MULTI xp NPC_GIVE_EXP");
		NPC_MAXHP = GetMonsterMaxHP();
		if (NPC_HP_MULTI > 0)
		{
			NPC_MAXHP *= NPC_HP_MULTI;
			SetHealth(NPC_MAXHP);
		}
		if (BASE_FRAMERATE == "BASE_FRAMERATE")
		{
			BASE_FRAMERATE = 1.0;
		}
		if (BASE_MOVESPEED == "BASE_MOVESPEED")
		{
			BASE_MOVESPEED = 1.0;
		}
		if ((NPC_CUSTOM_NAME))
		{
			if ((GetEntityName(GetOwner())).findFirst(NPC_CUSTOM_NAME_STRING) >= 0)
			{
				int GOT_NAME = 1;
			}
			if (!(GOT_NAME))
			{
				SetName(NPC_CUSTOM_NAME_STRING);
				LogDebug("npc_post_spawn NPC_CUSTOM_NAME_STRING");
			}
		}
		if (NPC_ADJ_LEVEL > 0)
		{
			if (NPC_ADJ_LEVEL == 1)
			{
				string ADD_STR = " II";
			}
			if (NPC_ADJ_LEVEL == 2)
			{
				string ADD_STR = " III";
			}
			if (NPC_ADJ_LEVEL == 3)
			{
				string ADD_STR = " IV";
			}
			if (NPC_ADJ_LEVEL == 4)
			{
				string ADD_STR = " V";
			}
			if (NPC_ADJ_LEVEL == 5)
			{
				string ADD_STR = " VI";
			}
			string L_NEW_NAME = GetEntityProperty(GetOwner(), "name.prefix");
			L_NEW_NAME += "|";
			L_NEW_NAME += GetEntityName(GetOwner());
			L_NEW_NAME += ADD_STR;
			SetName(L_NEW_NAME);
		}
	}

	void npcatk_self_adjust()
	{
		string L_TOTAL_HP = "game.players.totalhp";
		NPC_ADJ_LEVEL = 0;
		if (L_TOTAL_HP > GetToken(NPC_ADJ_TIERS, 1, ";"))
		{
			NPC_ADJ_LEVEL = 1;
		}
		if (L_TOTAL_HP > GetToken(NPC_ADJ_TIERS, 2, ";"))
		{
			NPC_ADJ_LEVEL = 2;
		}
		if (L_TOTAL_HP > GetToken(NPC_ADJ_TIERS, 3, ";"))
		{
			NPC_ADJ_LEVEL = 3;
		}
		if (L_TOTAL_HP > GetToken(NPC_ADJ_TIERS, 4, ";"))
		{
			NPC_ADJ_LEVEL = 4;
		}
		if (L_TOTAL_HP > GetToken(NPC_ADJ_TIERS, 5, ";"))
		{
			NPC_ADJ_LEVEL = 5;
		}
		if (NPC_ADJ_DOWN > 0)
		{
			NPC_ADJ_LEVEL -= NPC_ADJ_DOWN;
			if (NPC_ADJ_LEVEL < 0)
			{
				NPC_ADJ_LEVEL = 0;
			}
		}
		string ADD_NPC_HP_MULTI = GetToken(NPC_ADJ_HP_MUTLI_TOKENS, NPC_ADJ_LEVEL, ";");
		if (NPC_HP_MULTI == 1)
		{
			ADD_NPC_HP_MULTI -= 1;
		}
		NPC_HP_MULTI += ADD_NPC_HP_MULTI;
		string ADD_NPC_DMG_MULTI = GetToken(NPC_ADJ_DMG_MUTLI_TOKENS, NPC_ADJ_LEVEL, ";");
		if (NPC_DMG_MULTI == 1)
		{
			ADD_NPC_DMG_MULTI -= 1;
		}
		NPC_DMG_MULTI += ADD_NPC_DMG_MULTI;
		SetDamageMultiplier(NPC_DMG_MULTI);
		string ORG_EXP = NPC_GIVE_EXP;
		if (NPC_ADJ_EXPS != "NPC_ADJ_EXPS")
		{
			NPC_GIVE_EXP = GetToken(NPC_ADJ_EXPS, NPC_ADJ_LEVEL, ";");
		}
		if (NPC_GIVE_EXP == 0)
		{
			if (ORG_EXP > 0)
			{
				NPC_GIVE_EXP = ORG_EXP;
			}
		}
		LogDebug("npcatk_self_adjust NPC_ADJ_LEVEL");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((NPC_SELF_ADJUST))
		{
			if (!(NPC_NO_COUNT))
			{
			}
			if (!(NPC_SELF_ADJUST_NOAVG))
			{
			}
			G_SADJ_DEATHS += 1;
			string F_NPC_ADJ_LEVEL = NPC_ADJ_LEVEL;
			F_NPC_ADJ_LEVEL += 1;
			if (NPC_ADJ_DOWN > 0)
			{
				F_NPC_ADJ_LEVEL += 1;
				F_NPC_ADJ_LEVEL += NPC_ADJ_DOWN;
			}
			G_SADJ_LEVELS += F_NPC_ADJ_LEVEL;
			LogDebug("SelfAdj_Count: kills G_SADJ_DEATHS levels G_SADJ_LEVELS");
			if ((G_DEVELOPER_MODE))
			{
				string TOTAL_KILLS = G_SADJ_DEATHS;
				string TOTAL_LEVELS = G_SADJ_LEVELS;
				string AVG_LEVELS = TOTAL_LEVELS;
				AVG_LEVELS /= TOTAL_KILLS;
				string OUT_TITLE = "+";
				OUT_TITLE += F_NPC_ADJ_LEVEL;
				string OUT_MSG = "Average=";
				OUT_MSG += AVG_LEVELS;
				SendInfoMsg("all", "OUT_TITLE OUT_MSG");
			}
		}
		if (G_TRACK_HP > 0)
		{
			if (!(NPC_SELF_ADJUST_NOAVG))
			{
			}
			if (!(I_R_PET))
			{
			}
			G_TRACK_HP += "game.players.totalhp";
			G_TRACK_KILLS += 1;
		}
		if (!(G_TRACK_DEATHS > 0)) return;
		if ((AM_SUMMONED)) return;
		if ((I_R_PET)) return;
		if ((NPC_NO_COUNT)) return;
		if ((GetScriptName(GetOwner())).findFirst("summon") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((GetScriptName(GetOwner())).findFirst("companion") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		G_TRACK_DEATHS += 1;
		if (G_TRACK_DEATHS >= G_TRACK_DEATHS_TRIGGER)
		{
			if (G_TRACK_DEATHS_EVENT != "none")
			{
			}
			CallExternal(GAME_MASTER, "G_TRACK_DEATHS_EVENT");
			SetGlobalVar("G_TRACK_DEATHS_EVENT", "none");
		}
	}

	void npcatk_set_skill()
	{
		if (!(true)) return;
		if (NPC_BASE_EXP != "NPC_BASE_EXP")
		{
			NPC_GIVE_EXP = NPC_BASE_EXP;
		}
		if (NPC_GIVE_EXP == "NPC_GIVE_EXP")
		{
			NPC_GIVE_EXP = GetXP(GetOwner());
		}
		if (NPC_EXP_MULTI != "NPC_EXP_MULTI")
		{
			NPC_GIVE_EXP *= NPC_EXP_MULTI;
		}
		if (GetXP(GetOwner()) == 0)
		{
			LogDebug("npcatk_set_skill xp wasn't set, using NPC_GIVE_EXP");
			SetSkillLevel(NPC_GIVE_EXP);
		}
		else
		{
			LogDebug("npcatk_set_skill NPC_GIVE_EXP was not set , using GetXP(GetOwner())");
			NPC_GIVE_EXP = GetXP(GetOwner());
		}
		if (!(NPC_GIVE_EXP > 0)) return;
		NPC_ALL_XP_ADJ = 1;
		if (NPC_DMG_MULTI >= NPC_HP_MULTI)
		{
			string L_ADJ_RATIO = NPC_HP_MULTI;
			L_ADJ_RATIO /= NPC_DMG_MULTI;
		}
		else
		{
			string L_ADJ_RATIO = NPC_DMG_MULTI;
			ADJ_RATIO /= NPC_HP_MULTI;
		}
		if (L_ADJ_RATIO < 0.25)
		{
			int L_OVER_ADJUST = 1;
		}
		if (StringToLower(GetMapName()) == "undercliffs")
		{
			int L_OVER_ADJUST = 0;
		}
		if ((L_OVER_ADJUST))
		{
			string MSG_TITLE = "MAP ERROR: ";
			MSG_TITLE += GetEntityName(GetOwner());
			SendInfoMsg("all", "MSG_TITLE HP/DMG multipliers cannot be more than 4x one another, or XP will not be adjusted");
		}
		if (!(L_OVER_ADJUST))
		{
			if (NPC_DMG_MULTI > 1)
			{
				string L_ADJ = NPC_DMG_MULTI;
				if (L_ADJ > 5)
				{
					int L_ADJ = 5;
				}
				L_ADJ -= 1;
				L_ADJ *= 0.5;
				L_ADJ += 1;
				string L_DEBUG = "dmgmulti:";
				L_DEBUG += NPC_DMG_MULTI;
				LogDebug("expadj L_ADJ noscale L_DEBUG");
				NPC_ALL_XP_ADJ += L_ADJ;
			}
			if (NPC_HP_MULTI > 1)
			{
				string L_ADJ = NPC_HP_MULTI;
				if (L_ADJ > 5)
				{
					int L_ADJ = 5;
				}
				L_ADJ -= 1;
				L_ADJ *= 0.5;
				L_ADJ += 1;
				string L_DEBUG = "hpmulti:";
				L_DEBUG += NPC_HP_MULTI;
				LogDebug("expadj L_ADJ noscale L_DEBUG");
				NPC_ALL_XP_ADJ += L_ADJ;
			}
		}
		if (NPC_ADJ_FLAGS != "NPC_ADJ_FLAGS")
		{
			if ((NPC_ADJ_FLAGS).findFirst("telehunt") >= 0)
			{
				int L_ADJ = 0;
				if (NPC_TELEHUNT_FREQ > 30)
				{
					L_ADJ += 1.5;
				}
				else
				{
					if (NPC_TELEHUNT_FREQ >= 20)
					{
						L_ADJ += 2.0;
					}
					else
					{
						if (EXT_DEMON_BLOOD_RATIO >= 10)
						{
							L_ADJ += 2.25;
						}
						else
						{
							if (NPC_TELEHUNT_FREQ >= 6)
							{
								L_ADJ += 2.5;
							}
							else
							{
								if (NPC_TELEHUNT_FREQ >= 0)
								{
									L_ADJ += 3.0;
								}
							}
						}
					}
				}
				LogDebug("expadj L_ADJ noscale telehunt");
				NPC_ALL_XP_ADJ += L_ADJ;
			}
			int L_ADJ = 0;
			if ((NPC_ADJ_FLAGS).findFirst("speed_x2") >= 0)
			{
				L_ADJ += 1.5;
			}
			if ((NPC_ADJ_FLAGS).findFirst("speed_x3") >= 0)
			{
				L_ADJ += 1.75;
			}
			if ((NPC_ADJ_FLAGS).findFirst("speed_x4") >= 0)
			{
				L_ADJ += 2.0;
			}
			if (L_ADJ > 0)
			{
				LogDebug("expadj 2.0 noscale speed_xX");
			}
			NPC_ALL_XP_ADJ += L_ADJ;
			if ((NPC_ADJ_FLAGS).findFirst("demon_blood") >= 0)
			{
				int L_ADJ = 0;
				if (EXT_DEMON_BLOOD_RATIO > 1)
				{
				}
				int L_MAX_SCALE = 5;
				string L_IN_SCALE = EXT_DEMON_BLOOD_RATIO;
				if (L_IN_SCALE > 5)
				{
					int L_IN_SCALE = 5;
				}
				L_IN_SCALE /= L_MAX_SCALE;
				string L_DEBUG = "demon_blood:";
				L_DEBUG += EXT_DEMON_BLOOD_RATIO;
				LogDebug("expadj /* TODO: $ratio */ $ratio(L_IN_SCALE, 1.1, 2.0) noscale L_DEBUG");
				L_ADJ += /* TODO: $ratio */ $ratio(L_IN_SCALE, 1.1, 2.0);
				NPC_ALL_XP_ADJ += L_ADJ;
			}
			if ((NPC_ADJ_FLAGS).findFirst("mspeed") >= 0)
			{
				if (NPC_MOVE_SPEED_ADJ > 1)
				{
					int L_ADJ = 0;
					float L_TO_ADD = 0.25;
					string L_TIMES_TO_ADD = NPC_MOVE_SPEED_ADJ;
					L_TO_ADD *= L_TIMES_TO_ADD;
					L_TO_ADD = max(0.25, min(2, L_TO_ADD));
					L_TO_ADD += 1;
					LogDebug("expadj L_TO_ADD noscale mspeed+");
					L_ADJ += L_TO_ADD;
					NPC_ALL_XP_ADJ += L_ADJ;
				}
				if (NPC_MOVE_SPEED_ADJ < 1)
				{
					int L_ADJ = 0;
					if (NPC_MOVE_SPEED_ADJ >= 0.75)
					{
						L_ADJ -= 0.25;
					}
					else
					{
						if (NPC_MOVE_SPEED_ADJ >= 0.5)
						{
							L_ADJ -= 0.5;
						}
						else
						{
							if (NPC_MOVE_SPEED_ADJ >= 0.25)
							{
								L_ADJ -= 0.75;
							}
							else
							{
								if (NPC_MOVE_SPEED_ADJ < 0.25)
								{
									L_ADJ -= 0.9;
								}
							}
						}
					}
					LogDebug("expadj L_ADJ noscale mspeed-");
					NPC_ALL_XP_ADJ += L_ADJ;
				}
			}
		}
		if ((NPC_DOT_POISON))
		{
			float L_TOTAL_MULTI_TO_ADD = 0.25;
			L_TOTAL_MULTI_TO_ADD *= NPC_DOT_POISON_RATIO;
			L_TOTAL_MULTI_TO_ADD += 1;
			LogDebug("expadj L_TOTAL_MULTI_TO_ADD noscale NPC_DOT_POISON");
			NPC_ALL_XP_ADJ += L_TOTAL_MULTI_TO_ADD;
		}
		if ((NPC_DOT_FIRE))
		{
			float L_TOTAL_MULTI_TO_ADD = 0.25;
			L_TOTAL_MULTI_TO_ADD *= NPC_DOT_FIRE_RATIO;
			L_TOTAL_MULTI_TO_ADD += 1;
			LogDebug("expadj L_TOTAL_MULTI_TO_ADD noscale NPC_DOT_FIRE");
			NPC_ALL_XP_ADJ += L_TOTAL_MULTI_TO_ADD;
		}
		if ((NPC_DOT_COLD))
		{
			float L_TOTAL_MULTI_TO_ADD = 0.25;
			L_TOTAL_MULTI_TO_ADD *= NPC_DOT_COLD_RATIO;
			L_TOTAL_MULTI_TO_ADD += 1;
			LogDebug("expadj L_TOTAL_MULTI_TO_ADD noscale NPC_DOT_COLD");
			NPC_ALL_XP_ADJ += L_TOTAL_MULTI_TO_ADD;
		}
		if ((NPC_DOT_LIGHTNING))
		{
			float L_TOTAL_MULTI_TO_ADD = 0.25;
			L_TOTAL_MULTI_TO_ADD *= NPC_DOT_LIGHTNING_RATIO;
			L_TOTAL_MULTI_TO_ADD += 1;
			LogDebug("expadj L_TOTAL_MULTI_TO_ADD noscale NPC_DOT_LIGHTNING");
			NPC_ALL_XP_ADJ += L_TOTAL_MULTI_TO_ADD;
		}
		if (NPC_BONUS_XP_RATIO != "NPC_BONUS_XP_RATIO")
		{
			NPC_ALL_XP_ADJ += NPC_BONUS_XP_RATO;
		}
		if (!(NO_EXP_MULTI))
		{
			AdjustExp(NPC_ALL_XP_ADJ);
		}
		if (NPC_EXP_REDUCT != "NPC_EXP_REDUCT")
		{
			AdjustExp(NPC_EXP_REDUCT);
		}
		if (G_EXP_MULTI != "G_EXP_MULTI")
		{
			if (G_EXP_MULTI != 1)
			{
			}
			AdjustExp(G_EXP_MULTI);
		}
		if ((NO_EXP_MULTI))
		{
			LogDebug("expadj No XP Multi Allowed , resetting.");
			SetSkillLevel(NPC_ORIG_EXP);
			if (NPC_EXP_REDUCT != "NPC_EXP_REDUCT")
			{
				AdjustExp(NPC_EXP_REDUCT);
			}
		}
		LogDebug("expadj [PRE-FN] GetXP(GetOwner())");
		if (("game.central"))
		{
			AdjustExp(2.0);
			string L_N_PLAYER_ADJ = "game.playersnb.noafk";
			string L_DEBUG = "FN+Players>1:";
			L_DEBUG += L_N_PLAYER_ADJ;
			if ((NPC_IS_BOSS))
			{
				AdjustExp(4.0);
			}
			if (L_N_PLAYER_ADJ > 1)
			{
			}
			L_N_PLAYER_ADJ -= 1;
			L_N_PLAYER_ADJ *= 0.5;
			L_N_PLAYER_ADJ += 1;
			AdjustExp(L_N_PLAYER_ADJ);
		}
		NPC_GIVE_EXP = GetXP(GetOwner());
		NPC_EXP_FINAL = NPC_GIVE_EXP;
		if (("game.central"))
		{
			if (NPC_GIVE_EXP != 0)
			{
			}
			if (NPC_ORIG_EXP != "NPC_ORIG_EXP")
			{
			}
			string L_TOTAL_XP_ADJ = NPC_GIVE_EXP;
			L_TOTAL_XP_ADJ /= NPC_ORIG_EXP;
			if (DROP_GOLD_AMT != "DROP_GOLD_AMT")
			{
				DROP_GOLD_AMT *= L_TOTAL_XP_ADJ;
			}
		}
	}

	void game_dynamically_created()
	{
		if (!(param1 == "events")) return;
		NPC_DO_EVENTS = param2;
		ScheduleDelayedEvent(0.01, "npcatk_setup_addparams");
	}

}

}
