#pragma context server

#include "developer/devcmds.as"

namespace MS
{

class Commands : CGameScript
{
	int CAN_VOTE;
	string CREST_SELECTION;
	float FREQ_WEATHER;
	int HIGH_IDX;
	int HIGH_SCORE;
	int LEADING_GUILDS;
	string LTNG_SND;
	string POINTS_NLIST;
	string POINTS_PLIST;
	string POINTS_TNLIST;
	string POINTS_TPLIST;
	string RESIST_NAMES;
	string RESIST_VALUES;
	string SCRIPT_SFX1;
	string SOUND_RAIN;
	string SPRITE_MIST;
	string SPRITE_RIPPLE;
	string SPRITE_SPLASH;
	string TEST_PLR;
	int TIMESET_DELAY;
	string TIP_TEXT;
	int WEATHERSET_DELAY;
	string WEATHER_SPRITE;
	int l.daystart.secs;

	Commands()
	{
		TIMESET_DELAY = 0;
		WEATHERSET_DELAY = 0;
		FREQ_WEATHER = 10.0;
		WEATHER_SPRITE = "rain.spr";
		SPRITE_SPLASH = "rain_splash.spr";
		SPRITE_MIST = "rain_mist.spr";
		SPRITE_RIPPLE = "rain_ripple.spr";
		SOUND_RAIN = "weather/rain.wav";
		SCRIPT_SFX1 = "effects/sfx_lightning";
		LTNG_SND = "weather/Storm_exclamation.wav";
		Precache(SCRIPT_SFX1);
		Precache(LTNG_SND);
		Precache(WEATHER_SPRITE);
		Precache(SPRITE_SPLASH);
		Precache(SPRITE_MIST);
		Precache(SPRITE_RIPPLE);
		Precache(SOUND_RAIN);
		Precache("snow1.spr");
		Precache("amb/wind.wav");
		Precache("char_breath.spr");
	}

	void game_precache()
	{
		if (!(SCRIPT_TOKENS != "SCRIPT_TOKENS")) return;
		for (int i = 0; i < GetTokenCount(SCRIPT_TOKENS, ";"); i++)
		{
			dev_precache();
		}
	}

	void dev_precache()
	{
		string SCRIPT_FILE = GetToken(SCRIPT_TOKENS, i, ";");
		Precache(SCRIPT_FILE);
	}

	void game_playercmd()
	{
		if ((G_SPECIAL_COMMANDS))
		{
			if (StringToLower(GetMapName()) == "ms_soccer")
			{
				if ((param3).findFirst("score") == 0)
				{
					CallExternal(FindEntityByName("soccer_ball"), "ext_say_scores");
					return;
				}
				if ((param3).findFirst("ball") == 0)
				{
					CallExternal(FindEntityByName("soccer_ball"), "ext_send_menu", GetEntityIndex("ent_currentplayer"));
					return;
				}
			}
		}
		if ((param1).findFirst("/") == 0)
		{
			int IS_SLASH = 1;
			string SLASH_COMMAND = StringToLower(param1);
		}
		if ((IS_SLASH))
		{
			if (SLASH_COMMAND == "/stuck")
			{
				string SPAWN_POINT = GetEntityProperty("ent_currentplayer", "scriptvar");
				string CUR_LOC = GetEntityOrigin("ent_currentplayer");
				if (Distance(CUR_LOC, SPAWN_POINT) > 256)
				{
					SendColoredMessage("ent_currentplayer", "[/STUCK]: You are too far from your spawn point to use /stuck.");
					LogMessage("ent_currentplayer [/STUCK]: You are too far from your spawn point to use /stuck.");
					CallExternal("ent_currentplayer", "ext_stuck_adj");
				}
				else
				{
					string SPAWN_NAME = GetPlayerQuestData("ent_currentplayer", "d");
					// TODO: tospawn ent_currentplayer SPAWN_NAME
					SendPlayerMessage("ent_currentplayer", "Moving you to another spawn point...");
					LogMessage("ent_currentplayer Moving you to another spawn point...");
					CallExternal("ent_currentplayer", "delay_to_ms_player_spawn");
				}
			}
			if (SLASH_COMMAND == "/halo")
			{
				CallExternal("ent_currentplayer", "toggle_halo");
			}
			if (SLASH_COMMAND == "/devlo")
			{
				CallExternal("ent_currentplayer", "toggle_dev_halo");
			}
			return;
		}
		if (StringToLower(param1) == "motd")
		{
			CallExternal("ent_currentplayer", "force_motd");
		}
		else
		{
			if (param1 == "resetbank")
			{
				LogMessage("ent_currentplayer Reset bank command recieved...");
				CallExternal("ent_currentplayer", "ext_reset_bank");
			}
			else
			{
				if (param1 == "petname")
				{
					string PET_TYPES = GetPlayerQuestData("ent_currentplayer", "pets");
					if (PET_TYPES == 0)
					{
						LogMessage("ent_currentplayer " + PETNAME: + " You have no pets.");
						int EXIT_SUB = 1;
					}
					if (!(EXIT_SUB))
					{
					}
					if ((param2).findFirst("PARAM") == 0)
					{
						LogMessage("ent_currentplayer " + PETNAME: + " Usage1: petname < name>");
						LogMessage("ent_currentplayer " + PETNAME: + " Usage2: petname < pet_type> < name>");
						LogMessage("ent_currentplayer " + PETNAME: + "Available Pet Types: " + PET_TYPES);
						LogMessage("ent_currentplayer " + PETNAME: + " - Use alphanumerics only!");
						LogMessage("ent_currentplayer " + PETNAME: + "- If desired name requires spaces , use " + /* TODO: $quote */ $quote("quotes"));
						int EXIT_SUB = 1;
					}
					if (!(EXIT_SUB))
					{
					}
					if ((param3).findFirst("PARAM") == 0)
					{
						string L_NEW_NAME = param2;
						string PET_TYPE_TO_NAME = GetToken(PET_TYPES, 0, ";");
					}
					else
					{
						string PET_TYPE_TO_NAME = param2;
						string L_NEW_NAME = param3;
					}
					if ((PET_TYPES).findFirst(PET_TYPE_TO_NAME) >= 0)
					{
						int L_TYPE_VALID = 1;
					}
					if (!(L_TYPE_VALID))
					{
						LogMessage("ent_currentplayer " + PETNAME: + "You have no pets of this type. " + PET_TYPE_TO_NAME);
						LogMessage("ent_currentplayer " + PETNAME: + "Available Pet Types: " + PET_TYPES);
						int EXIT_SUB = 1;
					}
					if (!(EXIT_SUB))
					{
					}
					if ((L_NEW_NAME).findFirst("%") >= 0)
					{
						int L_INVALID_NAME = 1;
					}
					if ((L_NEW_NAME).findFirst("/") >= 0)
					{
						int L_INVALID_NAME = 1;
					}
					if ((L_NEW_NAME).findFirst("\") >= 0)
					{
						int L_INVALID_NAME = 1;
					}
					if ((L_INVALID_NAME))
					{
						LogMessage("ent_currentplayer " + PETNAME: + " Inavalid name - alphanumerics and spaces only , please");
					}
					if (!(L_INVALID_NAME))
					{
					}
					string Q_NAME = PET_TYPE_TO_NAME;
					Q_NAME += "_name";
					SetPlayerQuestData("ent_currentplayer", Q_NAME);
					LogMessage("ent_currentplayer " + PETNAME: + PET_TYPE_TO_NAME + "new name is: " + L_NEW_NAME);
					CallExternal("all", "ext_companion_update_name");
				}
				else
				{
					if (param1 == "listpoints")
					{
						CALLING_PLAYER = GetEntityIndex("ent_currentplayer");
						do_list_points();
					}
					else
					{
						if (param1 == "listresist")
						{
							CALLING_PLAYER = GetEntityIndex("ent_currentplayer");
							do_list_resists();
						}
						else
						{
							if (param1 == "flip")
							{
								string MY_NAME = GetEntityName("ent_currentplayer");
								MY_NAME += " Flips a Gold Piece";
								int DIE_ROLL = RandomInt(1, 2);
								if (DIE_ROLL == 1)
								{
									SendInfoMsg("all", MY_NAME + " It comes up HEADS");
									LogMessage("ent_currentplayer Your coin comes up " + HEADS);
								}
								if (DIE_ROLL == 2)
								{
									SendInfoMsg("all", MY_NAME + " It comes up TAILS");
									LogMessage("ent_currentplayer Your coin comes up " + TAILS);
								}
							}
							else
							{
								if (param1 == "roll")
								{
									string D_SIDES = param2;
									if (D_SIDES == "PARAM2")
									{
										int D_SIDES = 20;
									}
									roll_die(D_SIDES);
								}
								else
								{
									if (param1 == "day")
									{
										CallExternal("ent_currentplayer", "ext_tod_lock", "day");
										LogMessage("ent_currentplayer Shifting your time of day effects to day.");
										LogMessage("ent_currentplayer This does not affect world time nor other players.");
										ClientEvent("update", "ent_currentplayer", "const.localplayer.scriptID", "environment_change", "day");
									}
									else
									{
										if (param1 == "help")
										{
											if (param2 == "PARAM2")
											{
											}
											CallExternal("ent_currentplayer", "help_toggle");
										}
										else
										{
											if (param1 == "dusk")
											{
												CallExternal("ent_currentplayer", "ext_tod_lock", "aft");
												LogMessage("ent_currentplayer Shifting your time of day effects to dusk.");
												LogMessage("ent_currentplayer This does not affect world time nor other players.");
												ClientEvent("update", "ent_currentplayer", "const.localplayer.scriptID", "environment_change", "aft");
											}
											else
											{
												if (param1 == "night")
												{
													CallExternal("ent_currentplayer", "ext_tod_lock", "night");
													LogMessage("ent_currentplayer Shifting your time of day effects to night.");
													LogMessage("ent_currentplayer This does not affect world time nor other players.");
													ClientEvent("update", "ent_currentplayer", "const.localplayer.scriptID", "environment_change", "night");
												}
												else
												{
													if (param1 == "clearsky")
													{
														if (G_WEATHER_LOCK != 0)
														{
															LogMessage("ent_currentplayer Weather is currently locked.");
														}
														if (G_WEATHER_LOCK == 0)
														{
														}
														CallExternal("ent_currentplayer", "ext_weather_set_clear");
													}
													else
													{
														if (param1 == "setweather")
														{
															if (G_WEATHER_LOCK != 0)
															{
																LogMessage("ent_currentplayer Weather is currently locked.");
															}
															if (G_WEATHER_LOCK == 0)
															{
															}
															CallExternal("ent_currentplayer", "ext_weather_manual_change", param2);
														}
														else
														{
															if (param1 == "time")
															{
																LogMessage("ent_currentplayer == " + TIME: + CURRENT_TIME + " ==");
																SendPlayerMessage("ent_currentplayer", "== " + TIME: + CURRENT_TIME + " ==");
																if ((G_DEVELOPER_MODE))
																{
																	int L_DO_FN_TIME = 1;
																}
																if (("game.central"))
																{
																	int L_DO_FN_TIME = 1;
																}
																if ((L_DO_FN_TIME))
																{
																}
																string L_MONTH = "game.time.month";
																string L_DAY = "game.time.day";
																string L_YEAR = "game.time.year";
																string L_HOUR = "game.time.hour";
																string L_MIN = "game.time.minute";
																string L_OUT_MSG = "(FN Time: ";
																L_OUT_MSG += GetToken("???;JAN;FEB;MAR;APR;MAY;JUN;JUL;AUG;SEP;OCT;NOV;DEC", L_MONTH, ";");
																L_OUT_MSG += L_YEAR;
																L_OUT_MSG += _;
																L_OUT_MSG += L_DAY;
																L_OUT_MSG += " ";
																L_OUT_MSG += L_HOUR;
																L_OUT_MSG += ":";
																L_OUT_MSG += L_MIN;
																L_OUT_MSG += ")";
																LogMessage("ent_currentplayer " + L_OUT_MSG);
															}
															else
															{
																if (param1 == "xyz")
																{
																	string P_LOC = GetEntityOrigin("ent_currentplayer");
																	string P_X = (P_LOC).x;
																	string P_Y = (P_LOC).y;
																	string P_TZ = (P_LOC).z;
																	int P_TZ = int(P_TZ);
																	string P_Z = /* TODO: $get_ground_height */ $get_ground_height(P_LOC);
																	string P_ANG = GetEntityAngles("ent_currentplayer");
																	string P_PITCH = /* TODO: $vec.pitch */ $vec.pitch(P_ANG);
																	string P_YAW = /* TODO: $vec.yaw */ $vec.yaw(P_ANG);
																	string P_ROLL = /* TODO: $vec.roll */ $vec.roll(P_ANG);
																	int P_X = int(P_X);
																	int P_Y = int(P_Y);
																	int P_Z = int(P_Z);
																	int P_PITCH = int(P_PITCH);
																	int P_YAW = int(P_YAW);
																	int P_ROLL = int(P_ROLL);
																	LogMessage("ent_currentplayer Floor: P_X P_Y P_Z Center: P_X P_Y P_TZ angles: P_PITCH P_YAW P_ROLL");
																	SendPlayerMessage("ent_currentplayer", "Floor: P_X P_Y P_Z Center: P_X P_Y P_TZ angles: P_PITCH P_YAW P_ROLL");
																}
																else
																{
																	if (param1 == "betadate")
																	{
																		give_timestamp();
																	}
																	else
																	{
																		if (param1 == "settime")
																		{
																			if ((G_DEVELOPER_MODE))
																			{
																				TIMESET_DELAY = 0;
																			}
																			if ((TIMESET_DELAY))
																			{
																				LogMessage("ent_currentplayer You must wait a bit before changing the time again.");
																			}
																			if (!(TIMESET_DELAY))
																			{
																			}
																			TIMESET_DELAY = 1;
																			FREQ_WEATHER("reset_timeset_delay");
																			set_time(param2, param3);
																			CallExternal("ent_currentplayer", "ext_tod_lock", "none");
																		}
																		else
																		{
																			if (param1 == "show_health")
																			{
																				string TOGGLE_MODE = param2;
																				if (TOGGLE_MODE != "0")
																				{
																					if (TOGGLE_MODE != "1")
																					{
																						string TOGGLE_MODE = "toggle";
																					}
																				}
																				CallExternal(GetEntityIndex("ent_currentplayer"), "console_health_toggle", TOGGLE_MODE);
																			}
																			else
																			{
																				if (param1 == "wallpapercrest")
																				{
																					if (GetPlayerAuthId("ent_currentplayer") == "STEAM_0:0:15435276")
																					{
																						string CREST_NAME = "crest_w_1";
																						if ((ItemExists("ent_currentplayer", CREST_NAME)))
																						{
																							LogMessage("ent_currentplayer You already have your wallpaper crest.");
																							int EXIT_SUB = 1;
																						}
																						if (!(EXIT_SUB))
																						{
																						}
																						LogMessage("ent_currentplayer Granting Avocado's wallpaper crest");
																						CallExternal(GAME_MASTER, "give_item", GetEntityIndex("ent_currentplayer"), CREST_NAME);
																					}
																					if (GetPlayerAuthId("ent_currentplayer") == "STEAM_0:1:7087443")
																					{
																						string CREST_NAME = "crest_w_2";
																						if ((ItemExists("ent_currentplayer", CREST_NAME)))
																						{
																							LogMessage("ent_currentplayer You already have your wallpaper crest.");
																							int EXIT_SUB = 1;
																						}
																						if (!(EXIT_SUB))
																						{
																						}
																						LogMessage("ent_currentplayer Granting Lockdown's wallpaper crest");
																						CallExternal(GAME_MASTER, "give_item", GetEntityIndex("ent_currentplayer"), CREST_NAME);
																					}
																				}
																				else
																				{
																					if (param1 == "health_bars")
																					{
																						string TOGGLE_MODE = param2;
																						if (TOGGLE_MODE != "0")
																						{
																							if (TOGGLE_MODE != "1")
																							{
																								string TOGGLE_MODE = "toggle";
																							}
																						}
																						CallExternal(GetEntityIndex("ent_currentplayer"), "healthbar_toggle", TOGGLE_MODE);
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
		if (param1 == "dridje_sphere")
		{
			if (GetPlayerAuthId("ent_currentplayer") == "STEAM_0:1:4985228")
			{
			}
			string L_SPHERE = FindEntityByName("dridje_sphere");
			if (((L_SPHERE !is null)))
			{
				if (!(WARNED_DRIDJE))
				{
					WARNED_DRIDJE = 1;
					LogMessage("ent_currentplayer One sphere at a time , please. ; )");
					return;
				}
				else
				{
					WARNED_DRIDJE = 0;
					LogMessage("ent_currentplayer " + I + "said... " + ONE + "at a " + TIME.);
					XDoDamage("ent_currentplayer", "direct", 42069, 100, GAME_MASTER, GAME_MASTER, "none", "apostle_effect");
					return;
				}
			}
			string SPAWN_POINT = GetEntityOrigin("ent_currentplayer");
			string MY_ANGLES = GetEntityAngles("ent_currentplayer");
			string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
			SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 64, 0));
			SpawnNPC("monsters/companion/dridje", SPAWN_POINT, ScriptMode::Legacy); // params: GetEntityIndex("ent_currentplayer")
		}
		else
		{
			if (param1 == "msversion")
			{
				LogMessage("ent_currentplayer " + MS.DLL + " reports version game.revision central game.central");
			}
		}
		if (param1 == "gimmecrest")
		{
			do_crest(GetEntityIndex("ent_currentplayer"));
		}
		else
		{
			if (param1 == "gimmestaff")
			{
				if (("game.central"))
				{
					string L_ME = GetPlayerAuthId("ent_currentplayer");
					if ((G_DEVSTAFF_OWNERS).findFirst(L_ME) >= 0)
					{
						return;
					}
				}
				CallExternal(GAME_MASTER, "give_item", GetEntityIndex("ent_currentplayer"), "dev_staff");
			}
		}
		if (param1 == ".")
		{
			string OUT_PAR1 = param2;
			string OUT_PAR2 = param3;
			string OUT_PAR3 = param4;
			string OUT_PAR4 = param5;
			string OUT_PAR5 = param6;
			string OUT_PAR6 = param7;
			string OUT_PAR7 = param8;
			string OUT_PAR8 = param9;
			dev_command(OUT_PAR1, OUT_PAR2, OUT_PAR3, OUT_PAR4, OUT_PAR5, OUT_PAR6, OUT_PAR7, OUT_PAR8, OUT_PAR9);
		}
	}

	void reset_timeset_delay()
	{
		TIMESET_DELAY = 0;
	}

	void reset_weatherset_delay()
	{
		WEATHERSET_DELAY = 0;
	}

	void give_timestamp()
	{
		LogMessage("ent_currentplayer " + SC.DLL + "date " + BETA_TIMESTAMP + MS.DLL + " version game.revision");
		SendPlayerMessage("ent_currentplayer", SC.DLL + "timestamp is " + BETA_TIMESTAMP + MS.DLL + " version game.revision");
	}

	void set_time()
	{
		if (!("game.event.params" >= 2)) return;
		PARAM1 %= 24;
		PARAM2 %= 60;
		time_getseconds();
		string local.mstime.secs = "global.mstime.secs";
		int l.secs = int(param1);
		l.secs *= 3600;
		int l.mins_to_secs = int(param2);
		l.mins_to_secs *= 60;
		l.secs += l.mins_to_secs;
		string l.daystart.secs = "global.mstime.secs";
		l.daystart.secs /= 86400;
		l.daystart.secs = int(l.daystart.secs);
		l.daystart.secs *= 86400;
		string l.timefromdaystart = "global.mstime.secs";
		l.timefromdaystart -= l.daystart.secs;
		if (l.secs < l.timefromdaystart)
		{
			l.secs += 86400;
		}
		string l.newtime = l.daystart.secs;
		l.newtime += l.secs;
		SetGlobalVar("global.mstime.secs", l.newtime);
		SetGlobalVar("global.mstime.updateall", 0);
	}

	void roll_die()
	{
		string MY_NAME = GetEntityName("ent_currentplayer");
		string N_SIDES = /* TODO: $alphanum */ $alphanum(param1);
		MY_NAME += " Rolls a ";
		MY_NAME += N_SIDES;
		MY_NAME += " Sided Die!";
		int DIE_ROLL = RandomInt(1, N_SIDES);
		string MSG_STRING = "It comes up ";
		MSG_STRING += DIE_ROLL;
		SendInfoMsg("all", MY_NAME + MSG_STRING);
		LogMessage("ent_currentplayer You rolled " + DIE_ROLL + "on your " + N_SIDES + " sided die.");
	}

	void check_can_vote()
	{
		string VOTE_DELAY = GetEntityProperty(param1, "scriptvar");
		if ((VOTE_DELAY))
		{
			SendColoredMessage(param1, VOTE + SYSTEM: + " You cannot start another vote so soon.");
			LogMessage(param1 + " You cannot start another vote so soon.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		CAN_VOTE = 1;
	}

	void loop_get_points()
	{
		string CUR_IDX = i;
		string CUR_PLAYER = GetToken(PLAYER_LIST, CUR_IDX, ";");
		string PLAYER_STAT = GetEntityProperty(CUR_PLAYER, "scriptvar");
		string PLAYER_SUB_STAT = GetEntityProperty(CUR_PLAYER, "scriptvar");
		PLAYER_SUB_STAT *= 0.001;
		PLAYER_STAT += PLAYER_SUB_STAT;
		if (POINTS_TNLIST.length() > 0) POINTS_TNLIST += ";";
		POINTS_TNLIST += GetEntityName(CUR_PLAYER);
		if (POINTS_TPLIST.length() > 0) POINTS_TPLIST += ";";
		POINTS_TPLIST += PLAYER_STAT;
	}

	void loop_sort_points()
	{
		string CUR_IDX = i;
		TEST_PLR = CUR_IDX;
		HIGH_IDX = 0;
		HIGH_SCORE = 0;
		for (int i = 0; i < GetTokenCount(POINTS_TPLIST, ";"); i++)
		{
			loop_find_highest();
		}
		if (POINTS_PLIST.length() > 0) POINTS_PLIST += ";";
		POINTS_PLIST += GetToken(POINTS_TPLIST, HIGH_IDX, ";");
		if (POINTS_NLIST.length() > 0) POINTS_NLIST += ";";
		POINTS_NLIST += GetToken(POINTS_TNLIST, HIGH_IDX, ";");
		RemoveToken(POINTS_TPLIST, HIGH_IDX, ";");
		RemoveToken(POINTS_TNLIST, HIGH_IDX, ";");
	}

	void loop_find_highest()
	{
		string CUR_IDX = i;
		string CUR_SCORE = GetToken(POINTS_TPLIST, CUR_IDX, ";");
		if (CUR_SCORE > HIGH_SCORE)
		{
			HIGH_SCORE = CUR_SCORE;
			HIGH_IDX = CUR_IDX;
		}
	}

	void loop_show_points()
	{
		string CUR_IDX = i;
		string CUR_N = GetToken(POINTS_NLIST, CUR_IDX, ";");
		string CUR_P = GetToken(POINTS_PLIST, CUR_IDX, ";");
		CUR_P *= 1000;
		string OUT_MSG = CUR_N;
		OUT_MSG = " has" + int(CUR_P) + "damage" + "points";
		LogMessage(CALLING_PLAYER + OUT_MSG);
		SendColoredMessage(CALLING_PLAYER, OUT_MSG);
		TIP_TEXT = OUT_MSG + "|";
	}

	void do_list_points()
	{
		GetAllPlayers(PLAYER_LIST);
		POINTS_TNLIST = "";
		POINTS_TPLIST = "";
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			loop_get_points();
		}
		POINTS_NLIST = "";
		POINTS_PLIST = "";
		for (int i = 0; i < GetTokenCount(POINTS_TPLIST, ";"); i++)
		{
			loop_sort_points();
		}
		LogMessage(CALLING_PLAYER + " Damage Point Listings:");
		SendColoredMessage(CALLING_PLAYER, "Damage Point Listings:");
		TIP_TEXT = "";
		for (int i = 0; i < GetTokenCount(POINTS_NLIST, ";"); i++)
		{
			loop_show_points();
		}
		LogMessage(CALLING_PLAYER + " Damage points are acquire by harming monsters and aiding allies");
		LogMessage(CALLING_PLAYER + " The player with the highest dmg point score has contributed the most to your victory");
		ShowHelpTip(CALLING_PLAYER, "generic", "Damage Point Listings", TIP_TEXT);
	}

	void do_list_resists()
	{
		RESIST_NAMES = GetEntityProperty(CALLING_PLAYER, "scriptvar");
		RESIST_VALUES = GetEntityProperty(CALLING_PLAYER, "scriptvar");
		LogMessage(CALLING_PLAYER + " Resistance ratios (lower = more resistant, 1.0 = normal, 0.0 = immune)");
		TIP_TEXT = "";
		for (int i = 0; i < GetTokenCount(RESIST_NAMES, ";"); i++)
		{
			list_resist_loop();
		}
		string STUN_VALUE = /* TODO: $get_takedmg */ $get_takedmg(CALLING_PLAYER, "stun");
		STUN_VALUE *= 100;
		int STUN_VALUE = int((100 - STUN_VALUE));
		STUN_VALUE += "%";
		TIP_TEXT = "Stun" + "=" + STUN_VALUE + "||";
		string DARK_LEVEL = GetEntityProperty(CALLING_PLAYER, "scriptvar");
		TIP_TEXT = "Darkness" + "Level" + "=" + int(DARK_LEVEL) + "|";
		ShowHelpTip(CALLING_PLAYER, "generic", "Resistance Listings", TIP_TEXT);
	}

	void list_resist_loop()
	{
		string CUR_IDX = i;
		LogMessage(CALLING_PLAYER + GetToken(RESIST_NAMES, CUR_IDX, ";") + "= " + GetToken(RESIST_VALUES, CUR_IDX, ";"));
		string RESIST_VAL = GetToken(RESIST_VALUES, CUR_IDX, ";");
		RESIST_VAL *= 100;
		int OUT_VAL = 100;
		OUT_VAL -= RESIST_VAL;
		int OUT_VAL = int(OUT_VAL);
		OUT_VAL += "%";
		TIP_TEXT = GetToken(RESIST_NAMES, CUR_IDX, ";") + "=" + OUT_VAL + "|";
	}

	void do_crest()
	{
		CREST_SELECTION = "func_guilds_leading"(GetEntityIndex(param1));
		if (CREST_SELECTION != "0")
		{
			SpawnNPC("crest_dealer", Vector3(10000, 10000, 10000), ScriptMode::Legacy); // params: GetEntityIndex(param1), CREST_SELECTION
		}
	}

	void func_guilds_leading()
	{
		LEADING_GUILDS = 0;
		string L_STEAM_ID = GetPlayerAuthId(param1);
		for (int i = 0; i < GetGlobalArrayLength(ARRAY_CRESTS); i++)
		{
			loop_guilds_leading(L_STEAM_ID);
		}
		return;
		return;
	}

	void loop_guilds_leading()
	{
		string L_LEADERS = GetGlobalArray(ARRAY_CREST_OWNERS, int(i));
		if ((L_LEADERS).findFirst(param1) >= 0)
		{
			if (LEADING_GUILDS == "0")
			{
				LEADING_GUILDS = GetGlobalArray(ARRAY_CRESTS, int(i));
			}
			else
			{
				if (LEADING_GUILDS.length() > 0) LEADING_GUILDS += ";";
				LEADING_GUILDS += GetGlobalArray(ARRAY_CRESTS, int(i));
			}
		}
	}

}

}
