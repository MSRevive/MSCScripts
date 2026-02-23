#pragma context server

#include "player/valid_spawn_new.as"
#include "player/server/dmgpoints.as"
#include "player/server/element_resist.as"

namespace MS
{

class PlayerMain : CGameScript
{
	int AFK_DID_FIRST_PULSE;
	string AFK_OLD_POS;
	string AFK_TIME;
	string BAR_STRING;
	int BUILD_BAR_COUNT;
	string CVAR_HP_LIMIT;
	string DEMON_BLOOD_END_TIME;
	int DISPLAY_HBAR_DELAY;
	int DISPLAY_PBAR_DELAY;
	int DISPLAY_PLAYER_HP;
	int DISPLAY_TARG_HP;
	int ELM_REGISTER_SILENT;
	string FIRST_PARTY_MSG;
	float FREQ_AFK_CHECK;
	string GAVE_MAP_INTRO;
	string HAD_FIRST_SPAWN;
	string HBAR_TARGET;
	int IR_GLOWING;
	string IS_AFK;
	string LAST_STRUCK_FOR;
	string LEVEL_UP_SCRIPT;
	string MOTD_TXT1;
	string MOTD_TXT2;
	string MOTD_TXT3;
	string MOTD_TXT4;
	string MOTD_TXT5;
	string MOTD_TXT6;
	string MOTD_TXT7;
	int MSC_PUSH_RESIST;
	string MY_SPAWN_TIME;
	float NEXT_DODGE;
	string NEXT_LEAPBACK;
	string NEXT_LEAPLEFT;
	string NEXT_LEAPRIGHT;
	string OWNER_POS;
	int PLAYING_DEAD;
	int PLR_2H_REDUCT;
	int PLR_ADD_FIRE_DOT;
	string PLR_ARROW_ID;
	string PLR_ARROW_MENU;
	int PLR_BRAVERY;
	int PLR_CORRODE_DURATION;
	string PLR_DARK_LEVEL;
	int PLR_DID_MOTD;
	string PLR_DMG;
	int PLR_DMG_ADJUST_FIRE;
	string PLR_GENDER;
	string PLR_IN_WORLD;
	string PLR_LAST_ATK_TIME;
	string PLR_LAST_HBAR_SHOW;
	int PLR_LESSER_LEADFOOT;
	string PLR_LIGHTS_SYNCED;
	int PLR_MANA_FONT;
	int PLR_SPEED;
	string PLR_STARTED_AFK_CHECKS;
	int PLR_SWIFT_BLADE;
	int PL_BEEN_ATTACKED;
	int SCARABS_ATTACHED;
	int SEND_DMG_DELAY;
	string SHOW_HEALTH;
	int SIZE_IDX;

	PlayerMain()
	{
		FREQ_AFK_CHECK = 60.0;
		PLR_2H_REDUCT = 1;
		const int LEAP_SIDE_DRAIN = 30;
		const int LEAP_BACK_DRAIN = 60;
		const int HBAR_FRAMES = 12;
		DISPLAY_TARG_HP = 1;
		DISPLAY_PLAYER_HP = 1;
		const string SOUND_LEVELUP1 = "magic/converted_EnchP01.wav";
		const string LEVELUP_SCRIPT = "player/player_cl_effects_levelup";
		const int PLR_DARK_LEVEL_LOSS_RATE = 50;
		const int PLR_MAX_DARK_LEVEL = 50000;
		SetGlobalVar("PLR_DARK_UNHOLY_LEVEL", 20000);
		Precache("health_bar.spr");
		Precache("human/reference.mdl");
		Precache("magic/converted_magic13.wav");
		const string SOUND_BEAR_STRUCK1 = "monsters/bear/c_bear_hit1.wav";
		const string SOUND_BEAR_STRUCK2 = "monsters/bear/c_bear_hit2.wav";
		const string SOUND_BEAR_STRUCK3 = "monsters/bear/c_bear_no.wav";
		Precache("dwarf/reference.mdl");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_AFK_CHECK);
		if ((PLR_STARTED_AFK_CHECKS))
		{
		}
		string CUR_POS = GetEntityOrigin(GetOwner());
		if (Distance(AFK_OLD_POS, CUR_POS) <= 128)
		{
			if ((AFK_DID_FIRST_PULSE))
			{
			}
			string L_LAST_ATK_TIME = PLR_LAST_ATK_TIME;
			L_LAST_ATK_TIME += 60.0;
			if (GetGameTime() > L_LAST_ATK_TIME)
			{
			}
			if ((G_DEVELOPER_MODE))
			{
				if (!(IS_AFK))
				{
				}
				SendColoredMessage(GetOwner(), "====== FLAGGED AFK!");
			}
			IS_AFK = 1;
			FREQ_AFK_CHECK = 5.0;
		}
		else
		{
			if ((G_DEVELOPER_MODE))
			{
				if ((IS_AFK))
				{
				}
				SendColoredMessage(GetOwner(), "====== No longer afk");
			}
			FREQ_AFK_CHECK = 60.0;
			IS_AFK = 0;
		}
		if ((IS_AFK))
		{
			AFK_TIME += 1;
		}
		if ((PLR_IN_WORLD))
		{
			PL_TIME += 1;
			if (PLR_DARK_LEVEL > 0)
			{
				if (!(IS_AFK))
				{
				}
				PLR_DARK_LEVEL -= PLR_DARK_LEVEL_LOSS_RATE;
				if (PLR_DARK_LEVEL < 0)
				{
					PLR_DARK_LEVEL = 0;
				}
				SetPlayerQuestData(GetOwner(), "dl");
				player_calc_holy_resistance();
			}
		}
		AFK_OLD_POS = GetMonsterProperty("origin");
		AFK_DID_FIRST_PULSE = 1;
	}

	void OnSpawn() override
	{
		LogDebug("game_spawn GetEntityHealth(GetOwner())");
		if (!(PLR_STARTED_AFK_CHECKS))
		{
			PLR_STARTED_AFK_CHECKS = 1;
		}
		// TODO: hud.killicons ent_me
		if ((DEMON_BLOOD))
		{
			end_demon_blood();
		}
		PLR_SPEED = 100;
		PLAYING_DEAD = 0;
		if (GetPlayerQuestData(GetOwner(), "h") == 1)
		{
			console_health_toggle(1);
		}
		SetRace("human");
		if (!(HAD_FIRST_SPAWN))
		{
			SetGlobalVar("global.mstime.updateall", 0);
			if ((true))
			{
			}
			PLR_DMG = 0;
			if ((GetCvar("ms_chatlog")))
			{
				// TODO: chatlog GetTimestamp() PLAYER_JOIN: GetEntityName(GetOwner()) [ GetPlayerAuthId(GetOwner()) ] ip: GetPlayerClientAddress(GetOwner())
			}
			HAD_FIRST_SPAWN = 1;
			IS_AFK = 0;
			AFK_TIME = 0;
			MY_SPAWN_TIME = GetGameTime();
			FIRST_PARTY_MSG = GetGameTime();
			CVAR_HP_LIMIT = GetCvar("ms_hp_limit");
			FIRST_PARTY_MSG += 60.0;
		}
		SetVolume(10);
	}

	void random_spawn()
	{
		CallExternal(GAME_MASTER, "find_spawn_point", GetEntityIndex(GetOwner()));
	}

	void activate_stuff()
	{
		if (!(PLR_LIGHTS_SYNCED))
		{
			CallExternal("all", "player_joined", GetEntityIndex(GetOwner()));
			UseTrigger("player_joined");
			PLR_LIGHTS_SYNCED = 1;
		}
		if (GetEntityProperty(GetOwner(), "companions") > 0)
		{
			// TODO: UNCONVERTED: if ( $get(ent_me,companions) > 0 ) summonpets ent_me
		}
		DrainStamina(GetOwner());
		ClientCommand(GetOwner(), "room_type 0;wait;switchhand 1;wait;switchhand 1");
		LogDebug("activate_stuff");
		if (CVAR_HP_LIMIT > 0)
		{
			if (GetEntityMaxHealth(GetOwner()) >= CVAR_HP_LIMIT)
			{
			}
			ScheduleDelayedEvent(1.0, "hp_max_warn");
		}
		CallExternal("all", "ext_activate_items", GetEntityIndex(GetOwner()));
	}

	void tele_spawn()
	{
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
		SetEntityOrigin(GetOwner(), NEW_SPAWN_POS);
		OWNER_POS = NEW_SPAWN_POS;
		for (int i = 0; i < 18; i++)
		{
			beam_fx();
		}
	}

	void beam_fx()
	{
		string BEAM_START = OWNER_POS;
		string BEAM_END = OWNER_POS;
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, BEAM_ROT, 0), Vector3(0, 32, -32));
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, BEAM_ROT, 0), Vector3(0, 32, 128));
		Effect("beam", "point", "lgtning.spr", 100, BEAM_START, BEAM_END, Vector3(255, 0, 255), 200, 16, 3);
		BEAM_ROT += 20;
	}

	void game_think()
	{
	}

	void game_jump()
	{
		PlayAnim("once", ANIM_JUMP);
	}

	void game_jump_land()
	{
		PlayAnim("once", "break");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClearFX();
		PLR_CORRODE_DURATION = 0;
		PLR_SWIFT_BLADE = 0;
		MSC_PUSH_RESIST = 0;
		PLR_LESSER_LEADFOOT = 0;
		// TODO: hud.killicons ent_me
		PLR_BRAVERY = 0;
		PLR_DMG_ADJUST_FIRE = 0;
		PLR_ADD_FIRE_DOT = 0;
		if ((DEMON_BLOOD))
		{
			DEMON_BLOOD_END_TIME = GetGameTime();
		}
		ext_setbodytype("normal");
		if ((PLR_FAURA))
		{
			CallExternal(GetOwner(), "ext_fire_aura_remove");
		}
		if ((PLR_PAURA))
		{
			CallExternal(GetOwner(), "ext_poison_aura_remove");
		}
		PLR_MANA_FONT = 0;
		CallExternal("all", "bs_global_command", GetEntityIndex(GetOwner()), "vanish", "death");
		IR_GLOWING = 0;
		if ((REGEN_ON))
		{
			CallExternal(GetOwner(), "regen_end");
		}
		if ((VAMPIRE_ON))
		{
			CallExternal(GetOwner(), "vampire_off");
		}
		if ((DEMON_BLOOD))
		{
			CallExternal(GetOwner(), "end_demon_blood");
		}
		if ((PLR_FAURA))
		{
			CallExternal(GetOwner(), "ext_fire_aura_remove");
		}
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			CallExternal(GetOwner(), "ext_shield_up", 0);
		}
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			CallExternal(GetOwner(), "ext_sfaura_end");
		}
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			CallExternal(GetOwner(), "ext_end_holy_aura");
		}
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			CallExternal(GetOwner(), "ext_end_repel_shield");
		}
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			CallExternal(GetOwner(), "ext_pole_lshield_end");
		}
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			LogDebug("player died in bear mode PLR_BEAR_IMAGE_ID");
			CallExternal(PLR_BEAR_IMAGE_ID, "ext_bear_die", "from_player_main");
			CallExternal(GetOwner(), "ext_bear_mode_end");
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_DEATH, 10);
		}
		if (((PLR_BEAR_IMAGE_ID !is null)))
		{
			DeleteEntity(PLR_BEAR_IMAGE_ID, true); // fade out
		}
		SetScriptFlags(GetOwner(), "cleartype", "nopush");
		SetScriptFlags(GetOwner(), "cleartype", "mana_regen");
		SetScriptFlags(GetOwner(), "cleartype", "combat");
		SetScriptFlags(GetOwner(), "cleartype", "speed");
		SetScriptFlags(GetOwner(), "cleartype", "atkspeed");
		SetScriptFlags(GetOwner(), "cleartype", "spider_resist");
		spider_protect_end();
		CallExternal(GetOwner(), "plr_change_speed", "normal");
		animate_death();
		UseTrigger("player_died");
		ScheduleDelayedEvent(0.1, "warp_out");
	}

	void warp_out()
	{
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, -20000));
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		string PARRY_ROLL = int(param4);
		string ACCU_ROLL = int(param5);
		LogDebug("game_parry PARAM6");
		SendPlayerMessage(GetOwner(), "You parry the attack! PARRY_ROLL vs. ACCU_ROLL");
	}

	void OnDamage(int damage) override
	{
		PL_BEEN_ATTACKED = 1;
		LAST_STRUCK_FOR = param2;
		if ((PLR_BEAR_MODE))
		{
			if (RandomInt(1, 3) == 1)
			{
				// PlayRandomSound from: SOUND_BEAR_STRUCK1, SOUND_BEAR_STRUCK2, SOUND_BEAR_STRUCK3
				array<string> sounds = {SOUND_BEAR_STRUCK1, SOUND_BEAR_STRUCK2, SOUND_BEAR_STRUCK3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
		if (!(param2 > 0)) return;
		display_health();
	}

	void display_health()
	{
		CallExternal("players", "show_hbar_player", GetEntityIndex(GetOwner()));
		if (!(SHOW_HEALTH)) return;
		string MY_HP = GetEntityHealth(GetOwner());
		string MY_MAXHP = GetEntityMaxHealth(GetOwner());
		string MY_HP = int(MY_HP);
		string MY_MAXHP = int(MY_MAXHP);
		string PERCENT = MY_HP;
		PERCENT /= MY_MAXHP;
		PERCENT *= 100;
		string PERCENT = int(PERCENT);
		string FILL_POS = PERCENT;
		FILL_POS /= 10;
		string FILL_POS = int(FILL_POS);
		BUILD_BAR_COUNT = 0;
		BAR_STRING = "{";
		for (int i = 0; i < 10; i++)
		{
			build_bar(FILL_POS);
		}
		BAR_STRING += "}";
		PERCENT += "%";
		SendColoredMessage(GetOwner(), "HP: BAR_STRING PERCENT MY_HP / MY_MAXHP");
	}

	void console_health_toggle()
	{
		if (param1 == "toggle")
		{
			if ((SHOW_HEALTH))
			{
				SHOW_HEALTH = 0;
			}
			else
			{
				SHOW_HEALTH = 1;
			}
		}
		if (param1 != "toggle")
		{
			SHOW_HEALTH = param1;
		}
		if ((SHOW_HEALTH))
		{
			SetPlayerQuestData(GetOwner(), "h");
			SendPlayerMessage(GetOwner(), "Your health will now be displayed in the combat hud when you are struck");
			LogMessage("ent_me Your health will now be displayed in the combat hud when you are struck");
		}
		if (!(SHOW_HEALTH))
		{
			SetPlayerQuestData(GetOwner(), "h");
			SendPlayerMessage(GetOwner(), "Your health will no longer be displayed in the combat hud");
			LogMessage("ent_me Your health will no longer be displayed in the combat hud");
		}
	}

	void healthbar_toggle()
	{
		if (param1 == "toggle")
		{
			if ((DISPLAY_PLAYER_HP))
			{
				DISPLAY_PLAYER_HP = 0;
			}
			else
			{
				DISPLAY_PLAYER_HP = 1;
			}
		}
		if (param1 != "toggle")
		{
			DISPLAY_PLAYER_HP = param1;
		}
		if ((DISPLAY_PLAYER_HP))
		{
			SetPlayerQuestData(GetOwner(), "p");
			SendPlayerMessage(GetOwner(), "Player health bars are enabled.");
			LogMessage("ent_me Player health bars are enabled.");
		}
		if (!(DISPLAY_PLAYER_HP))
		{
			SetPlayerQuestData(GetOwner(), "p");
			SendPlayerMessage(GetOwner(), "Player health bars are disabled.");
			LogMessage("ent_me Player health bars are disabled.");
		}
	}

	void mana_drain()
	{
		if (!(SHOW_HEALTH)) return;
		string MY_MP = GetEntityMP(GetOwner());
		string MY_MAXMP = GetEntityProperty(GetOwner(), "maxmp");
		string MY_MP = int(MY_MP);
		string MY_MAXMP = int(MY_MAXMP);
		string PERCENT = MY_MP;
		PERCENT /= MY_MAXMP;
		PERCENT *= 100;
		string PERCENT = int(PERCENT);
		string FILL_POS = PERCENT;
		FILL_POS /= 10;
		string FILL_POS = int(FILL_POS);
		BUILD_BAR_COUNT = 0;
		BAR_STRING = "{";
		for (int i = 0; i < 10; i++)
		{
			build_bar(FILL_POS);
		}
		BAR_STRING += "}";
		PERCENT += "%";
		SendColoredMessage(GetOwner(), "MANA: BAR_STRING PERCENT MY_MP / MY_MAXMP");
	}

	void build_bar()
	{
		BUILD_BAR_COUNT += 1;
		if (BUILD_BAR_COUNT <= param1)
		{
			BAR_STRING += "|";
		}
		if (BUILD_BAR_COUNT > param1)
		{
			BAR_STRING += " ";
		}
	}

	void game_learnskill()
	{
		SendColoredMessage(GetOwner(), "Level awarded to PARAM1 PARAM2");
		if ((GetEntityProperty(GetOwner(), "isbot"))) return;
		string TITLE_STRING = GetEntityName(GetOwner());
		TITLE_STRING += " has gained a level!";
		string MESSAGE_STRING = "has gained experience in ";
		MESSAGE_STRING += param1;
		if ((param1).findFirst("Spell") == 0)
		{
			MESSAGE_STRING += " ";
			MESSAGE_STRING += param2;
		}
		SendInfoMsg("all", "TITLE_STRING MESSAGE_STRING");
		EmitSound(GetOwner(), 0, SOUND_LEVELUP1, 10);
		ClientEvent("new", "all", "player/player_conartist", "levelup", GetEntityIndex(GetOwner()));
		LEVEL_UP_SCRIPT = "game.script.last_sent_id";
	}

	void reset_send_dmg_delay()
	{
		SEND_DMG_DELAY = 0;
	}

	void game_transition_entered()
	{
	}

	void game_xpgain()
	{
		string XP_GAIN = int(param1);
		SendColoredMessage(GetOwner(), "* XP_GAIN XP Awarded");
	}

	void give_map_intro()
	{
		SendInfoMsg(GetOwner(), "G_MAP_NAME G_MAP_DESC");
		string L_PET_LIST = GetPlayerQuestData(GetOwner(), "pets");
		if (L_PET_LIST != 0)
		{
			ScheduleDelayedEvent(0.1, "pet_notice");
		}
		ScheduleDelayedEvent(3.0, "give_map_diff");
	}

	void pet_notice()
	{
		string L_PET_LIST = GetPlayerQuestData(GetOwner(), "pets");
		if (L_PET_LIST != 0)
		{
			if (GetTokenCount(L_PET_LIST, ";") > 1)
			{
				ShowHelpTip(GetOwner(), "generic", "You have Pets!", "You can summon your pets via the Player Menu (defaultkey: F)");
			}
			else
			{
				ShowHelpTip(GetOwner(), "generic", "You have a Pet!", "You can summon your pet via the Player Menu (defaultkey: F)");
			}
		}
	}

	void give_map_diff()
	{
		if (G_MAP_DIFF != "G_MAP_DIFF")
		{
			SendInfoMsg(GetOwner(), "Intended Difficulty G_MAP_DIFF");
		}
		if (!(GetMonsterMaxHP() >= 5)) return;
		if (GetMonsterMaxHP() < G_WARN_HP)
		{
			SendInfoMsg(GetOwner(), "WARNING This area maybe too difficult at your level!");
		}
	}

	void help_toggle()
	{
		if (!(G_HELP_ON))
		{
			SetGlobalVar("G_HELP_ON", 1);
			LogMessage("ent_me Be sure to get more info at: www.msremake.com/forums");
			UseTrigger("help_spr");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((G_HELP_ON))
		{
			SetGlobalVar("G_HELP_ON", 0);
			LogMessage("ent_me Be sure to get more info at: www.msremake.com/forums");
			SendColoredMessage(GetOwner(), "You can type help again to restore the help panels");
			UseTrigger("help_spr");
			int EXIT_SUB = 1;
		}
	}

	void game_dodamage()
	{
		if (param5 == "dark")
		{
			plr_add_dark(int(param6));
		}
	}

	void plr_add_dark()
	{
		string OLD_PLR_DARK_LEVEL = PLR_DARK_LEVEL;
		PLR_DARK_LEVEL += param1;
		if (PLR_DARK_LEVEL > PLR_MAX_DARK_LEVEL)
		{
			PLR_DARK_LEVEL = PLR_MAX_DARK_LEVEL;
		}
		if (OLD_PLR_DARK_LEVEL < PLR_DARK_UNHOLY_LEVEL)
		{
			if (PLR_DARK_LEVEL > PLR_DARK_UNHOLY_LEVEL)
			{
			}
			player_calc_holy_resistance();
		}
	}

	void game_helptip()
	{
		EmitSound(GetOwner(), 0, "magic/converted_magic13.wav", 10);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		IS_AFK = 0;
		PLR_LAST_ATK_TIME = GetGameTime();
		if (PLR_2H_REDUCT < 1)
		{
			if ((param3).findFirst("effect") >= 0)
			{
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			string IN_DMG = param2;
			IN_DMG *= PLR_2H_REDUCT;
			// TODO: UNCONVERTED: set dmg IN_DMG
			LogDebug("2hreduct PARAM2 to IN_DMG");
			return;
		}
		if (GetEntityProperty(GetOwner(), "scriptvar") > 0)
		{
			if ((param3).findFirst("fire") >= 0)
			{
			}
			string ADJ_RATIO = GetEntityProperty(GetOwner(), "scriptvar");
			return;
			string IN_DMG = param2;
			IN_DMG *= ADJ_RATIO;
			// TODO: UNCONVERTED: set dmg IN_DMG
			LogDebug("Adjusted fire dmg PARAM2 to IN_DMG");
		}
		if (GetEntityProperty(GetOwner(), "scriptvar") > 0)
		{
			string DOT_RATIO = GetEntityProperty(GetOwner(), "scriptvar");
			string OWNER_SKILL = GetSkillLevel(GetOwner(), "spellcasting.fire");
			OWNER_SKILL *= DOT_RATIO;
			string L_DOT_FLAG_NAME = "fire_effect;";
			string L_VALUE = /* TODO: $get_scriptflag */ $get_scriptflag(param1, L_DOT_FLAG_NAME, "name_value");
			if (L_VALUE == "none")
			{
				ApplyEffect(param1, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), OWNER_SKILL, "spellcasting.fire");
			}
		}
		if (!(DISPLAY_TARG_HP)) return;
		HBAR_TARGET = param1;
		ScheduleDelayedEvent(0.1, "ext_show_hbar_monster", GetEntityIndex(param1));
	}

	void ext_show_hbar_monster()
	{
		if (!(param2))
		{
			if (!(DISPLAY_TARG_HP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((param1).findFirst(PARAM) == 0)
		{
			HBAR_TARGET = param1;
		}
		if (!(GetGameTime() > PLR_LAST_HBAR_SHOW)) return;
		DISPLAY_HBAR_DELAY = 1;
		PLR_LAST_HBAR_SHOW = GetGameTime();
		PLR_LAST_HBAR_SHOW += 0.5;
		string TARG_HIT = HBAR_TARGET;
		string TARG_HP = GetEntityHealth(TARG_HIT);
		string TARG_MAXHP = GetEntityMaxHealth(TARG_HIT);
		string PERC_HP = TARG_HP;
		PERC_HP /= TARG_MAXHP;
		string HBAR_FRAME = HBAR_FRAMES;
		HBAR_FRAME *= PERC_HP;
		string HBAR_FRAME = int(HBAR_FRAME);
		string HBAR_HEIGHT = GetEntityHeight(TARG_HIT);
		HBAR_HEIGHT = max(32, min(512, HBAR_HEIGHT));
		string HBAR_POS = GetEntityOrigin(TARG_HIT);
		HBAR_POS += "z";
		string HBAR_SCALE = TARG_MAXHP;
		HBAR_SCALE /= 4000;
		HBAR_SCALE = max(0.05, min(0.75, HBAR_SCALE));
		if (!(IsEntityAlive(TARG_HIT)))
		{
			int HBAR_FRAME = 0;
		}
		string HBAR_ADJ_POS = GetEntityProperty(TARG_HIT, "scriptvar");
		if (HBAR_ADJ_POS != "NPC_HBAR_ADJ")
		{
			string TARG_YAW = GetEntityProperty(TARG_HIT, "angles.yaw");
			HBAR_POS += /* TODO: $relpos */ $relpos(Vector3(0, TARG_YAW, 0), HBAR_ADJ_POS);
		}
		string WAGARO_WTF = HBAR_FRAME;
		LogDebug("ext_show_hbar_monster HBAR_FRAME WAGARO_WTF");
		WAGARO_WTF += 22;
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "show_hbar", HBAR_POS, WAGARO_WTF, HBAR_SCALE, GetEntityIndex(TARG_HIT));
	}

	void show_hbar_player()
	{
		if (!(DISPLAY_PLAYER_HP)) return;
		if ((DISPLAY_PBAR_DELAY)) return;
		DISPLAY_PBAR_DELAY = 1;
		ScheduleDelayedEvent(0.5, "reset_display_pbar_delay");
		string TARG_HIT = GetEntityIndex(GetOwner());
		string TARG_HP = GetEntityHealth(TARG_HIT);
		string TARG_MAXHP = GetEntityMaxHealth(TARG_HIT);
		string PERC_HP = TARG_HP;
		PERC_HP /= TARG_MAXHP;
		string HBAR_FRAME = HBAR_FRAMES;
		HBAR_FRAME *= PERC_HP;
		string HBAR_FRAME = int(HBAR_FRAME);
		string HBAR_HEIGHT = GetEntityHeight(TARG_HIT);
		HBAR_HEIGHT -= 20;
		string HBAR_POS = GetEntityOrigin(TARG_HIT);
		HBAR_POS += "z";
		string HBAR_SCALE = TARG_MAXHP;
		if (!(IsEntityAlive(TARG_HIT)))
		{
			int HBAR_FRAME = 0;
		}
		string WAGARO_WTF = HBAR_FRAME;
		WAGARO_WTF += 22;
		if (param1 == GetEntityIndex(GetOwner()))
		{
			ClientEvent("update", "all", "const.localplayer.scriptID", "show_hbar", HBAR_POS, WAGARO_WTF, 0.125, GetEntityIndex(GetOwner()));
		}
		if (param1 != GetEntityIndex(GetOwner()))
		{
			ClientEvent("update", param1, "const.localplayer.scriptID", "show_hbar", HBAR_POS, WAGARO_WTF, 0.125, GetEntityIndex(GetOwner()));
		}
	}

	void reset_display_pbar_delay()
	{
		DISPLAY_PBAR_DELAY = 0;
	}

	void game_targeted_by_player()
	{
		string VIEWER = param1;
		show_hbar_player(VIEWER);
	}

	void reset_hbar_delay()
	{
		DISPLAY_HBAR_DELAY = 0;
	}

	void game_party_join()
	{
		if (!(FIRST_PARTY_MSG > 0)) return;
		if (!(GetGameTime() > FIRST_PARTY_MSG)) return;
		string TITLE_STR = GetEntityName(GetOwner());
		TITLE_STR += " has joined ";
		TITLE_STR += param1;
		string OUT_STR = GetEntityName(GetOwner());
		OUT_STR += " has joined the party of ";
		OUT_STR += param1;
		SendInfoMessageToAll("green OUT_STR");
	}

	void game_party_leave()
	{
	}

	void christmas_mode()
	{
		CallExternal(GetOwner(), "ext_weather_manual_change", "snow");
		// TODO: playmp3 all system xmass.mp3
		SetGlobalVar("global.map.weather", "snow;snow;snow");
	}

	void game_player_got_from_store()
	{
		LogDebug("game_player_got_from_store PARAM1 PARAM2");
		if ((GetEntityProperty(param1, "itemname")).findFirst("gold_pouch_") == 0)
		{
			CallExternal(GetOwner(), "ext_addgold", GetEntityProperty(param1, "scriptvar"));
			RemoveItem(param1);
			DeleteEntity(param1);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((GetEntityProperty(param2, "scriptvar")))
		{
			CallExternal(param2, "ext_player_got_item", GetEntityIndex(param1), GetEntityIndex(GetOwner()));
		}
		if (GetEntityProperty(param1, "value") > 500)
		{
			if (!(GetEntityProperty(param2, "scriptvar")))
			{
			}
			string VENDOR_NAME = GetEntityName(param2);
			if ((StringToLower(VENDOR_NAME)).findFirst("chest") >= 0)
			{
				int REPORT_ITEM = 1;
			}
			if ((GetEntityProperty(param2, "scriptvar")))
			{
				int REPORT_ITEM = 1;
			}
			if ((GetEntityProperty(param2, "scriptvar")))
			{
				int REPORT_ITEM = 0;
			}
			if ((G_DEVELOPER_MODE))
			{
				SendColoredMessage(GetOwner(), "report_item: REPORT_ITEM [ StringToLower(VENDOR_NAME) ] GetEntityProperty(param2, "scriptvar")");
			}
			if ((REPORT_ITEM))
			{
			}
			string OUT_MSG = "";
			OUT_MSG = GetEntityName(GetOwner()) + "recieved" + GetEntityName(param1) + "from" + VENDOR_NAME;
			SendInfoMsg("all", "OUT_MSG  ");
		}
		if (!(G_DEVELOPER_MODE)) return;
		SendInfoMessageToAll("green fromstore: GetEntityName(param1) GetEntityProperty(param1, "value")");
	}

	void hp_max_warn()
	{
		string MSG_TITLE = "HP LIMIT is ";
		MSG_TITLE = int(CVAR_HP_LIMIT) + "hp";
		SendInfoMsg(GetOwner(), "MSG_TITLE Your current character is too powerful for this server.");
		ScheduleDelayedEvent(2.0, "hp_max_warn2");
	}

	void hp_max_warn2()
	{
		string MSG_TITLE = "HP LIMIT is ";
		MSG_TITLE = int(CVAR_HP_LIMIT) + "hp";
		SendInfoMsg(GetOwner(), "MSG_TITLE You will be disconnected in 10 seconds.");
		ScheduleDelayedEvent(5.0, "hp_max_warn3");
	}

	void hp_max_warn3()
	{
		string MSG_TITLE = "HP LIMIT is ";
		MSG_TITLE = int(CVAR_HP_LIMIT) + "hp";
		SendInfoMsg(GetOwner(), "MSG_TITLE Your current character is too powerful for this server.");
		ScheduleDelayedEvent(1.0, "hp_max_warn4");
	}

	void hp_max_warn4()
	{
		string MSG_TITLE = "HP LIMIT is ";
		MSG_TITLE = int(CVAR_HP_LIMIT) + "hp";
		SendInfoMsg(GetOwner(), "MSG_TITLE You will be disconnected in 5 seconds.");
		ScheduleDelayedEvent(4.0, "hp_max_warn5");
	}

	void hp_max_warn5()
	{
		string CL_CMD = "toggleconsole;clear;echo This server does not allow characters with more than ";
		CL_CMD = int(CVAR_HP_LIMIT) + "hp;echo ===;disconnect";
		ClientCommand(GetOwner(), CL_CMD);
	}

	void game_respawn()
	{
		LogDebug("game_respawn");
	}

	void game_player_putinworld()
	{
		if ((G_CHRISTMAS_MODE))
		{
			string L_MAP_NAME = StringToLower(GetMapName());
			if (L_MAP_NAME == "edana")
			{
				ScheduleDelayedEvent(1.0, "christmas_mode");
			}
			if (L_MAP_NAME == "deralia")
			{
				ScheduleDelayedEvent(1.0, "christmas_mode");
			}
			if (L_MAP_NAME == "helena")
			{
				ScheduleDelayedEvent(1.0, "christmas_mode");
			}
		}
		// TODO: UNCONVERTED: noxploss ent_me 0
		if (!(true)) return;
		if (!(PLR_IN_WORLD))
		{
			CallExternal("players", "ext_reset_model");
			PLR_IN_WORLD = 1;
		}
		if (!(GetEntityProperty(GetOwner(), "haseffect")))
		{
			ApplyEffect(GetOwner(), "player/emote_sit&stand");
		}
		validate_spawn(LAST_SPAWN, /* TODO: $get_map_legit */ $get_map_legit(GetOwner()));
		PLR_DARK_LEVEL = GetPlayerQuestData(GetOwner(), "dl");
		PLR_GENDER = GetGender(GetOwner());
		CallExternal(GetOwner(), "ext_set_gender");
		string MAX_VIEW_DIST = "game.map.maxviewdistance";
		LogDebug("map_maxviewdistance MAX_VIEW_DIST");
		if (MAX_VIEW_DIST > 512)
		{
			ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "set_view_dist", MAX_VIEW_DIST);
		}
		else
		{
			ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "set_view_dist", 16384);
		}
		if (!(GAVE_MAP_INTRO))
		{
			if (G_MAP_NAME != "G_MAP_NAME")
			{
			}
			GAVE_MAP_INTRO = 1;
			ScheduleDelayedEvent(10.0, "give_map_intro");
		}
		if (G_FORCE_SPAWN_WEATHER != "G_FORCE_SPAWN_WEATHER")
		{
			CallExternal(GetOwner(), "ext_weather_change", G_FORCE_SPAWN_WEATHER);
		}
		player_calc_holy_resistance();
		SCARABS_ATTACHED = 0;
		ScheduleDelayedEvent(1.0, "activate_stuff");
		if (GetMonsterMaxHP() < 100)
		{
			if (GetMonsterHP() > 0)
			{
			}
			if (!(G_HELP_ON))
			{
			}
			help_toggle();
		}
		if ((G_RANDOM_SPAWN))
		{
			ScheduleDelayedEvent(0.1, "random_spawn");
		}
		if (NEW_SPAWN_POS != "NEW_SPAWN_POS")
		{
			ScheduleDelayedEvent(0.1, "tele_spawn");
		}
	}

	void setup_weather()
	{
		if (!(G_CURRENT_WEATHER != 0)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar") != G_CURRENT_WEATHER)) return;
		CallExternal(GetOwner(), "ext_weather_change", G_CURRENT_WEATHER);
	}

	void do_motd()
	{
		MOTD_TXT1 = "";
		MOTD_TXT2 = "";
		MOTD_TXT3 = "";
		MOTD_TXT4 = "";
		MOTD_TXT5 = "";
		MOTD_TXT6 = "";
		MOTD_TXT7 = "";
		SIZE_IDX = 0;
		LogMessage("ent_me game.cvar.hostname MESSAGE OF THE DAY == == == == == =");
		do_motd_loop();
	}

	void force_motd()
	{
		PLR_DID_MOTD = 0;
		do_motd();
	}

	void do_motd_loop()
	{
		if ((PLR_DID_MOTD)) return;
		string MOTD_LINE = /* TODO: $get_fileline */ $get_fileline("motd.txt");
		if (MOTD_LINE == "[eof]")
		{
			PLR_DID_MOTD = 1;
			ShowHelpTip(GetOwner(), "generic", "MESSAGE OF THE DAY", MOTD_TXT1, MOTD_TXT2, MOTD_TXT3);
		}
		if (!(MOTD_LINE != "[eof]")) return;
		LogMessage("ent_me SIZE_IDX - MOTD_LINE");
		string NEW_LEN = (MOTD_LINE).length();
		if (SIZE_IDX == 0)
		{
			NEW_LEN += (MOTD_TXT1).length();
		}
		if (SIZE_IDX == 1)
		{
			NEW_LEN += (MOTD_TXT2).length();
		}
		if (SIZE_IDX == 2)
		{
			NEW_LEN += (MOTD_TXT3).length();
		}
		if (SIZE_IDX == 3)
		{
			NEW_LEN += (MOTD_TXT4).length();
		}
		if (SIZE_IDX == 4)
		{
			NEW_LEN += (MOTD_TXT5).length();
		}
		if (SIZE_IDX == 5)
		{
			NEW_LEN += (MOTD_TXT6).length();
		}
		if (SIZE_IDX == 6)
		{
			NEW_LEN += (MOTD_TXT7).length();
		}
		if (NEW_LEN > 180)
		{
			SIZE_IDX += 1;
		}
		if (SIZE_IDX == 0)
		{
			MOTD_TXT1 = (MOTD_LINE).substr(0, 180) + "|";
		}
		if (SIZE_IDX == 1)
		{
			MOTD_TXT2 = (MOTD_LINE).substr(0, 180) + "|";
		}
		if (SIZE_IDX == 2)
		{
			MOTD_TXT3 = (MOTD_LINE).substr(0, 180) + "|";
		}
		if (SIZE_IDX == 3)
		{
			MOTD_TXT4 = (MOTD_LINE).substr(0, 180) + "|";
		}
		if (SIZE_IDX == 4)
		{
			MOTD_TXT5 = (MOTD_LINE).substr(0, 180) + "|";
		}
		if (SIZE_IDX == 5)
		{
			MOTD_TXT6 = (MOTD_LINE).substr(0, 180) + "|";
		}
		if (SIZE_IDX == 6)
		{
			MOTD_TXT7 = (MOTD_LINE).substr(0, 180) + "|";
		}
		ScheduleDelayedEvent(0.01, "do_motd_loop");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(PLR_SPECIAL_WEAPON)) return;
		if (GetEntityProperty(PLR_ACTIVE_WEAPON, "scriptvar") == "wolf")
		{
			string TARG_NAME = GetEntityName(param1);
			string TARG_NAME = StringToLower(TARG_NAME);
			if ((TARG_NAME).findFirst("wolf") >= 0)
			{
			}
			return;
			LogDebug("multi x2");
		}
	}

	void delay_to_ms_player_spawn()
	{
		// TODO: torandomspawn ent_me
	}

	void find_ms_player_spawn()
	{
		// TODO: torandomspawn ent_me
	}

	void player_calc_holy_resistance()
	{
		int NORM_LEVEL = 100;
		string DARK_RATIO = PLR_DARK_LEVEL;
		DARK_RATIO /= PLR_DARK_UNHOLY_LEVEL;
		NORM_LEVEL *= /* TODO: $ratio */ $ratio(DARK_RATIO, 1.0, 0);
		if (PLR_DARK_LEVEL > PLR_DARK_UNHOLY_LEVEL)
		{
			int NORM_LEVEL = 0;
			SetProp(GetOwner(), "skin", 2);
		}
		else
		{
			SetProp(GetOwner(), "skin", 1);
		}
		if ((PLR_UNHOLY))
		{
			int NORM_LEVEL = 0;
		}
		ELM_REGISTER_SILENT = 1;
		CallExternal(GetOwner(), "ext_register_element", "playr", "holy", NORM_LEVEL, "player_main");
	}

	void game_arrowmenu()
	{
		LogDebug("game_arrowmenu PARAM1 PARAM2");
		PLR_ARROW_MENU = param1;
		if ((param2))
		{
			PLR_ARROW_ID = param2;
		}
		else
		{
			if ((G_DEVELOPER_MODE))
			{
			}
			SendPlayerMessage(GetOwner(), "Selecting ammo...");
		}
	}

	void game_leapback()
	{
		if (!(GetGameTime() > NEXT_DODGE)) return;
		if ((IsKeyDown(GetOwner(), "forward"))) return;
		if (!(GetGameTime() > NEXT_LEAPBACK)) return;
		if ((GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if (!(GetSkillLevel(GetOwner(), "martialarts") > 15)) return;
		if (param1 <= LEAP_BACK_DRAIN)
		{
			SendColoredMessage(GetOwner(), "Not enough stamina remaing to dodge.");
		}
		if (!(param1 > LEAP_BACK_DRAIN)) return;
		if (!(IsOnGround(GetOwner())))
		{
			SendColoredMessage(GetOwner(), "Can't dodge in mid-air...");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityProperty(GetOwner(), "canrun")))
		{
			int NOT_NOW = 1;
		}
		if (!(CanAttack(GetOwner())))
		{
			int NOT_NOW = 1;
		}
		if (!(GetEntityProperty(GetOwner(), "canjump")))
		{
			int NOT_NOW = 1;
		}
		if (!(GetEntityProperty(GetOwner(), "canmove")))
		{
			int NOT_NOW = 1;
		}
		if ((NOT_NOW))
		{
			SendColoredMessage(GetOwner(), "Can't dodge now...");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((IsDucking(GetOwner()))) return;
		ShowHelpTip(GetOwner(), "firstleapback", "Congratulations! You can dodge!", "From Martialarts 15+, you can make short backwards dodges by holding shift and the back key.");
		NEXT_DODGE = 0.25;
		NEXT_DODGE += GetGameTime();
		NEXT_LEAPBACK = GetGameTime();
		NEXT_LEAPBACK += 3.0;
		DrainStamina(GetOwner());
		string VIEW_YAW = GetEntityProperty(GetOwner(), "viewangles");
		string VIEW_YAW = /* TODO: $vec.yaw */ $vec.yaw(VIEW_YAW);
		AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(Vector3(0, VIEW_YAW, 0), Vector3(0, -600, 150)));
		// svplaysound: svplaysound 4 10 PLR_SOUND_JAB1
		EmitSound(4, 10, PLR_SOUND_JAB1);
	}

	void game_leapleft()
	{
		if (!(GetGameTime() > NEXT_DODGE)) return;
		if ((IsKeyDown(GetOwner(), "forward"))) return;
		if (!(GetGameTime() > NEXT_LEAPLEFT)) return;
		if ((GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if (!(GetSkillLevel(GetOwner(), "martialarts") > 10)) return;
		if (param1 <= LEAP_SIDE_DRAIN)
		{
			SendColoredMessage(GetOwner(), "Not enough stamina remaing to dodge.");
		}
		if (!(param1 > LEAP_SIDE_DRAIN)) return;
		if (!(IsOnGround(GetOwner())))
		{
			SendColoredMessage(GetOwner(), "Can't dodge in mid-air...");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityProperty(GetOwner(), "canrun")))
		{
			int NOT_NOW = 1;
		}
		if (!(CanAttack(GetOwner())))
		{
			int NOT_NOW = 1;
		}
		if (!(GetEntityProperty(GetOwner(), "canjump")))
		{
			int NOT_NOW = 1;
		}
		if (!(GetEntityProperty(GetOwner(), "canmove")))
		{
			int NOT_NOW = 1;
		}
		if ((NOT_NOW))
		{
			SendColoredMessage(GetOwner(), "ent_me Can't dodge now...");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((IsDucking(GetOwner()))) return;
		ShowHelpTip(GetOwner(), "firstleap", "Congratulations! You can dodge!", "From Martialarts 10+, you can make short dodges to the left or right by holding shift with a strafe key.|At 15, you'll be able to leap backwards.");
		NEXT_DODGE = 0.25;
		NEXT_DODGE += GetGameTime();
		NEXT_LEAPLEFT = GetGameTime();
		NEXT_LEAPLEFT += 3.0;
		DrainStamina(GetOwner());
		string VIEW_YAW = GetEntityProperty(GetOwner(), "viewangles");
		string VIEW_YAW = /* TODO: $vec.yaw */ $vec.yaw(VIEW_YAW);
		AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(Vector3(0, VIEW_YAW, 0), Vector3(-600, 0, 180)));
		// svplaysound: svplaysound 4 10 player/hitground1.wav
		EmitSound(4, 10, "player/hitground1.wav");
	}

	void game_leapright()
	{
		if (!(GetGameTime() > NEXT_DODGE)) return;
		if ((IsKeyDown(GetOwner(), "forward"))) return;
		if (!(GetGameTime() > NEXT_LEAPRIGHT)) return;
		if ((GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if (!(GetSkillLevel(GetOwner(), "martialarts") > 10)) return;
		if (param1 <= LEAP_SIDE_DRAIN)
		{
			SendColoredMessage(GetOwner(), "Not enough stamina remaing to dodge.");
		}
		if (!(param1 > LEAP_SIDE_DRAIN)) return;
		if (!(IsOnGround(GetOwner())))
		{
			SendColoredMessage(GetOwner(), "Can't dodge in mid-air...");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityProperty(GetOwner(), "canrun")))
		{
			int NOT_NOW = 1;
		}
		if (!(CanAttack(GetOwner())))
		{
			int NOT_NOW = 1;
		}
		if (!(GetEntityProperty(GetOwner(), "canjump")))
		{
			int NOT_NOW = 1;
		}
		if (!(GetEntityProperty(GetOwner(), "canmove")))
		{
			int NOT_NOW = 1;
		}
		if ((NOT_NOW))
		{
			SendColoredMessage(GetOwner(), "Can't dodge now...");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((IsDucking(GetOwner()))) return;
		ShowHelpTip(GetOwner(), "firstleap", "Congratulations! You can dodge!", "From Martialarts 10+, you can make short dodges to the left or right by holding shift with a strafe key.|At 15, you'll be able to leap backwards.");
		NEXT_DODGE = 0.25;
		NEXT_DODGE += GetGameTime();
		NEXT_LEAPRIGHT = GetGameTime();
		NEXT_LEAPRIGHT += 3.0;
		DrainStamina(GetOwner());
		string VIEW_YAW = GetEntityProperty(GetOwner(), "viewangles");
		string VIEW_YAW = /* TODO: $vec.yaw */ $vec.yaw(VIEW_YAW);
		AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(Vector3(0, VIEW_YAW, 0), Vector3(600, 0, 180)));
		// svplaysound: svplaysound 4 10 player/hitground1.wav
		EmitSound(4, 10, "player/hitground1.wav");
	}

	void game_applyeffect()
	{
		if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "spider_resist", "type_exists")))
		{
			if ((GetEntityProperty(param5, "itemname")).findFirst("spid") >= 0)
			{
				int L_ABORT = 1;
			}
			if ((GetEntityProperty(param2, "itemname")).findFirst("spid") >= 0)
			{
				int L_ABORT = 1;
			}
			if ((L_ABORT))
			{
			}
			return;
			int L_DID_ABORT = 1;
		}
	}

}

}
