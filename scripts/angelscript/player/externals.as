#pragma context server

#include "test_scripts/player_externals.as"
#include "developer/player/externals.as"
#include "$currentmap_player_externals.as"
#include "items/base_vampire.as"

namespace MS
{

class Externals : CGameScript
{
	string AFL_BURST_DOT;
	string ALCO_SPAWN_ITEM;
	string ALCO_TYPE;
	string ARMOR_EQUIPED;
	string ARMOR_OFS;
	string ARMOR_TYPE;
	string EXTPLAY_SOUND;
	int EXT_EFFECT_LIST;
	string EXT_REMOVE_EFFECT;
	int FISSURE_ACTIVE;
	int FISSURE_COUNT;
	string FISSURE_DIR;
	string FISSURE_DMG;
	string FISSURE_END;
	string FISSURE_LENGTH;
	string FISSURE_MAX_COUNT;
	string FISSURE_ORG;
	string FISSURE_START;
	string FISSURE_YAW;
	string FLOAT_RETURN;
	string GAME_PVP;
	int HIDE_ARMS;
	int HIDE_CHEST;
	int HIDE_HEAD;
	int HIDE_LEGS;
	int IAM_PLAYER;
	int IMMUNE_VAMPIRE;
	string IR_GLOWING;
	int IS_AFK;
	int I_R_FROZEN;
	string MY_BODY;
	string MY_CL_BODY;
	string MY_GLOW_ID;
	string NEW_SPAWN_POS;
	string NEXT_HAURA_SOUND;
	string NEXT_PLSHIELD_SOUND;
	string NEXT_REPEL_SHIELD_SOUND;
	string OWNER_POS;
	string OWNER_YAW;
	string PLAYING_DEAD;
	string PLR_2H_REDUCT;
	string PLR_ACTIVE_PETS;
	string PLR_ACTIVE_PET_TYPES;
	string PLR_ACTIVE_VIEWMODEL;
	string PLR_ACTIVE_WEAPON;
	string PLR_ADD_FIRE_DOT;
	string PLR_ARMOR_ID;
	string PLR_BEAR_IMAGE_ID;
	int PLR_BEAR_MODE;
	string PLR_BODY_TYPE;
	int PLR_BRAVERY;
	string PLR_CORRODE_DURATION;
	string PLR_CRE_HAND;
	string PLR_CRE_TYPE;
	string PLR_CUR_TRANS;
	string PLR_DARK_LEVEL;
	string PLR_DAURA_CL_IDX;
	string PLR_DBURST_AOE;
	string PLR_DBURST_DMG;
	string PLR_DBURST_DOT;
	string PLR_DBURST_MAXPUSH;
	string PLR_DBURST_ORG;
	string PLR_DBURST_PUSH;
	string PLR_DBURST_SKILL;
	int PLR_DEBUG_ARRAY_ACTIVE;
	string PLR_DEL_PLAYSOUND_CHAN;
	string PLR_DEL_PLAYSOUND_VOL;
	string PLR_DEL_PLAYSOUND_WAV;
	string PLR_DID_SHENDER_EVENT;
	string PLR_DMG_ADJUST_FIRE;
	int PLR_EPILEPSY_ACTIVE;
	int PLR_EPILEPSY_COUNT;
	float PLR_EPILEPSY_DELAY;
	int PLR_FAURA;
	string PLR_FAURA_AOE;
	string PLR_FAURA_CLIDX;
	string PLR_FAURA_DOT;
	string PLR_FAURA_NEXT_CL;
	string PLR_FAURA_SCAN;
	int PLR_FEAURA;
	string PLR_FEAURA_AOE;
	string PLR_FEAURA_CLIDX;
	string PLR_FEAURA_DOT;
	string PLR_FEAURA_NEXT_CL;
	string PLR_FEAURA_SCAN;
	string PLR_FISTS_ID;
	string PLR_FOUND_PET;
	int PLR_GCOD_ACTIVE;
	string PLR_GCOD_DMG;
	string PLR_GCOD_DUR;
	string PLR_GCOD_POS;
	string PLR_GENDER;
	string PLR_GLOW_BLOCK;
	string PLR_GOT_REWARD;
	int PLR_HAND_SET;
	string PLR_HAS_GLOW;
	int PLR_HAS_MATCHED_SET;
	int PLR_HAURA_ACTIVE;
	string PLR_HAURA_CL_ID;
	string PLR_HAURA_POWER;
	string PLR_HAURA_RADIUS;
	string PLR_HAURA_TARGETS;
	string PLR_HELM_ID;
	int PLR_IN_COMBAT;
	string PLR_LAST_ATK_TIME;
	string PLR_LAST_PROJECTILE;
	string PLR_LAST_WORN_ARMOR;
	int PLR_LCOD_ACTIVE;
	string PLR_LCOD_DMG;
	string PLR_LCOD_DUR;
	string PLR_LCOD_POS;
	string PLR_LEFT_HAND;
	int PLR_LESSER_LEADFOOT;
	string PLR_LESSER_LEADFOOT_STUN;
	string PLR_LOCAL_TRANS;
	int PLR_LOCK_CLEAR;
	string PLR_LTRAN_MAXS;
	string PLR_LTRAN_MINS;
	string PLR_LTRAN_ORG;
	string PLR_NEXT_FSAURA_SOUND;
	string PLR_NEXT_GCOD_SOUND;
	string PLR_NEXT_HASTE;
	string PLR_NEXT_LCOD_SOUND;
	string PLR_NEXT_SCROLL;
	string PLR_NEXT_STUCK_ADJ;
	string PLR_NEXT_TRANS;
	string PLR_N_ACTIVE_PETS;
	string PLR_OLOF_STATUS;
	string PLR_ORCFOR_MUSIC;
	int PLR_PAURA;
	string PLR_PAURA_AOE;
	string PLR_PAURA_CLIDX;
	string PLR_PAURA_DOT;
	string PLR_PAURA_NEXT_CL;
	string PLR_PAURA_SCAN;
	int PLR_PBOLT_ACTIVE;
	int PLR_PBOLT_AOE;
	string PLR_PBOLT_ARRAY;
	int PLR_PBOLT_COUNTER;
	string PLR_PBOLT_DOT;
	string PLR_PBOLT_ORG;
	string PLR_PBOLT_TARGS;
	string PLR_PET_IDS;
	string PLR_PET_TYPES;
	int PLR_PLSHIELD_ACTIVE;
	string PLR_PLSHIELD_CL_IDX;
	string PLR_PLSHIELD_DOT;
	int PLR_PLSHIELD_PUSH;
	string PLR_PLSHIELD_TARGETS;
	string PLR_PREV_BODY_TYPE;
	string PLR_REPEL_MAX_HP;
	string PLR_REPEL_ORG;
	string PLR_REPEL_PUSH_STR;
	int PLR_REPEL_SHIELD_ACTIVE;
	string PLR_REPEL_SHIELD_RADIUS;
	string PLR_REPEL_SHIELD_SPECIAL;
	string PLR_REPEL_SHIELD_TARGETS;
	string PLR_RESET_BANK;
	string PLR_SCAN_TOKEN;
	string PLR_SCAN_TOKEN_SORTED;
	int PLR_SFAURA_ACTIVE;
	string PLR_SFAURA_CL_IDX;
	string PLR_SFAURA_DOT;
	string PLR_SFAURA_ITEM;
	string PLR_SFAURA_MAXPUSH;
	int PLR_SFAURA_SIZE;
	string PLR_SFAURA_TARGS;
	string PLR_SHIELD_UP;
	string PLR_SOUND_ARMHIT1;
	string PLR_SOUND_BREATHFAST1;
	string PLR_SOUND_BREATHFAST2;
	string PLR_SOUND_BREATHFAST3;
	string PLR_SOUND_CHESTHIT1;
	string PLR_SOUND_DEATH;
	string PLR_SOUND_FALLPAIN1;
	string PLR_SOUND_FALLPAIN2;
	string PLR_SOUND_FALLPAIN3;
	string PLR_SOUND_FALLPAIN4;
	string PLR_SOUND_JAB1;
	string PLR_SOUND_JAB2;
	string PLR_SOUND_LEGHIT1;
	string PLR_SOUND_SHOUT1;
	string PLR_SOUND_STOMACHHIT1;
	string PLR_SOUND_SWORDREADY;
	string PLR_SPEAR_CHARGE_LEVEL;
	string PLR_SPECIAL_WEAPON;
	string PLR_SPIDER_AMT;
	int PLR_SPIDER_PROT;
	string PLR_SUMMON_MENU_DISABLE;
	string PLR_SWIFT_BLADE;
	string PLR_TOD_LOCK;
	string PLR_UNIQUE_SUMMONS;
	string PLR_URDUAL_RELEASE_TIME;
	string PLR_WEATHER;
	string PLR_WEATHER_BLOCK;
	string PLR_WRAITH_ACTIVE;
	int PL_I_R_FROZEN;
	string PL_PARRY;
	int REGEN_ON;
	int REGEN_RATE;
	int SCROLL_WARNING_LEVEL;
	string SPIRAL_DMG;
	string SPIRAL_DMG_TYPE;
	string SPIRAL_GLOW_COLOR;
	string SPIRAL_SKILL;
	string SPIRAL_SPIRTE_FILE;
	string SPIRAL_SPRITE_COLOR;
	string SPIRAL_SPRITE_FRAMES;
	string SPIRAL_SPRITE_SCALE;
	string TARGET_PET_TYPE;
	string T_SPHERE;
	int VAMPIRE_ON;
	int VOTE_DISABLED;

	Externals()
	{
		const string PLR_COMBAT_ICON = "hud/status/alpha_poison_immune";
		PLR_HAND_SET = 0;
		PLR_UNIQUE_SUMMONS = "";
		const int PLR_LCOD_AOE = 90;
		const int PLR_GCOD_AOE = 180;
		const float PLR_2HPEN_LIGHT = 0.7;
		const float PLR_2HPEN_LIGHT_REPORT = 0.3;
		const float PLR_2HPEN_HEAVY = 0.6;
		const float PLR_2HPEN_HEAVY_REPORT = 0.4;
		SCROLL_WARNING_LEVEL = 0;
		PLR_PET_TYPES = "";
		PLR_PET_IDS = "";
		EXT_EFFECT_LIST = 0;
		const float VAMPIRE_MULTI = 0.35;
		const float PLR_FAURA_CL_RATE = 10.0;
		const float PLR_PAURA_CL_RATE = 30.0;
		const int PLR_SFAURA_MP_COST = 2;
		const int PLR_SFAURA_MAXSIZE = 175;
		const int PLR_SFAURA_GROWTH_RATE = 2;
		IAM_PLAYER = 1;
		array<string> ARRAY_JUMP_BEAM_IDS;
		array<string> ARRAY_JUMP_BEAM_TARGS;
		const string SOUNDSET_HM_SWORDREADY = "player/swordready.wav";
		const string SOUNDSET_HM_SHOUT1 = "player/shout1.wav";
		const string SOUNDSET_HM_JAB1 = "player/jab1.wav";
		const string SOUNDSET_HM_JAB2 = "player/jab2.wav";
		const string SOUNDSET_HM_BREATHFAST1 = "player/breathe_fast1.wav";
		const string SOUNDSET_HM_BREATHFAST2 = "player/breathe_fast2.wav";
		const string SOUNDSET_HM_BREATHFAST3 = "player/breathe_fast3.wav";
		const string SOUNDSET_HM_DEATH = "player/death.wav";
		const string SOUNDSET_HM_CHESTHIT1 = "player/chesthit1.wav";
		const string SOUNDSET_HM_STOMACHHIT1 = "player/stomachhit1.wav";
		const string SOUNDSET_HM_ARMHIT1 = "player/armhit1.wav";
		const string SOUNDSET_HM_LEGHIT1 = "player/leghit1.wav";
		const string SOUNDSET_HM_FALLPAIN1 = "player/fallpain1.wav";
		const string SOUNDSET_HM_FALLPAIN2 = "player/fallpain2.wav";
		const string SOUNDSET_HM_FALLPAIN3 = "player/fallpain3.wav";
		const string SOUNDSET_HM_FALLPAIN4 = "player/fallpain4.wav";
		const string SOUNDSET_HF_SWORDREADY = "player/Femaleswordready.wav";
		const string SOUNDSET_HF_SHOUT1 = "player/Femaleshout1.wav";
		const string SOUNDSET_HF_JAB1 = "player/Femalejab1.wav";
		const string SOUNDSET_HF_JAB2 = "player/Femalejab2.wav";
		const string SOUNDSET_HF_BREATHFAST1 = "player/Femalebreathe_fast1.wav";
		const string SOUNDSET_HF_BREATHFAST2 = "player/Femalebreathe_fast2.wav";
		const string SOUNDSET_HF_BREATHFAST3 = "player/Femalebreathe_fast3.wav";
		const string SOUNDSET_HF_DEATH = "player/FemaleDeath.wav";
		const string SOUNDSET_HF_CHESTHIT1 = "player/Femalechesthit1.wav";
		const string SOUNDSET_HF_STOMACHHIT1 = "player/Femalestomachhit1.wav";
		const string SOUNDSET_HF_ARMHIT1 = "player/Femalearmhit1.wav";
		const string SOUNDSET_HF_LEGHIT1 = "player/Femaleleghit1.wav";
		const string SOUNDSET_HF_FALLPAIN1 = "player/Femalefallpain1.wav";
		const string SOUNDSET_HF_FALLPAIN2 = "player/Femalefallpain2.wav";
		const string SOUNDSET_HF_FALLPAIN3 = "player/Femalefallpain3.wav";
		const string SOUNDSET_HF_FALLPAIN4 = "player/Femalefallpain4.wav";
		Precache(SOUNDSET_HM_SWORDREADY);
		Precache(SOUNDSET_HM_SHOUT1);
		Precache(SOUNDSET_HM_JAB1);
		Precache(SOUNDSET_HM_JAB2);
		Precache(SOUNDSET_HM_BREATHFAST1);
		Precache(SOUNDSET_HM_BREATHFAST2);
		Precache(SOUNDSET_HM_BREATHFAST3);
		Precache(SOUNDSET_HM_DEATH);
		Precache(SOUNDSET_HM_CHESTHIT1);
		Precache(SOUNDSET_HM_STOMACHHIT1);
		Precache(SOUNDSET_HM_ARMHIT1);
		Precache(SOUNDSET_HM_LEGHIT1);
		Precache(SOUNDSET_HM_FALLPAIN1);
		Precache(SOUNDSET_HM_FALLPAIN2);
		Precache(SOUNDSET_HM_FALLPAIN3);
		Precache(SOUNDSET_HM_FALLPAIN4);
		Precache(SOUNDSET_HF_SWORDREADY);
		Precache(SOUNDSET_HF_SHOUT1);
		Precache(SOUNDSET_HF_JAB1);
		Precache(SOUNDSET_HF_JAB2);
		Precache(SOUNDSET_HF_BREATHFAST1);
		Precache(SOUNDSET_HF_BREATHFAST2);
		Precache(SOUNDSET_HF_BREATHFAST3);
		Precache(SOUNDSET_HF_DEATH);
		Precache(SOUNDSET_HF_CHESTHIT1);
		Precache(SOUNDSET_HF_STOMACHHIT1);
		Precache(SOUNDSET_HF_ARMHIT1);
		Precache(SOUNDSET_HF_LEGHIT1);
		Precache(SOUNDSET_HF_FALLPAIN1);
		Precache(SOUNDSET_HF_FALLPAIN2);
		Precache(SOUNDSET_HF_FALLPAIN3);
		Precache(SOUNDSET_HF_FALLPAIN4);
	}

	void fake_sound_precache()
	{
		// svplaysound: svplaysound 1 0 magic/volcano_loop.wav
		EmitSound(1, 0, "magic/volcano_loop.wav");
		// svplaysound: svplaysound 1 0 weapons/polearm_spin.wav
		EmitSound(1, 0, "weapons/polearm_spin.wav");
		// svplaysound: svplaysound 1 0 ambience/pulsemachine.wav
		EmitSound(1, 0, "ambience/pulsemachine.wav");
		// svplaysound: svplaysound 1 0 ambience/dronemachine1.wav
		EmitSound(1, 0, "ambience/dronemachine1.wav");
		// svplaysound: svplaysound 1 0 monsters/bear/c_beardire_bat1.wav
		EmitSound(1, 0, "monsters/bear/c_beardire_bat1.wav");
		// svplaysound: svplaysound 1 0 monsters/goblin/sps_fogfire.wav
		EmitSound(1, 0, "monsters/goblin/sps_fogfire.wav");
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_SWORDREADY
		EmitSound(1, 0, SOUNDSET_HM_SWORDREADY);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_SHOUT1
		EmitSound(1, 0, SOUNDSET_HM_SHOUT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_JAB1
		EmitSound(1, 0, SOUNDSET_HM_JAB1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_JAB2
		EmitSound(1, 0, SOUNDSET_HM_JAB2);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_BREATHFAST1
		EmitSound(1, 0, SOUNDSET_HM_BREATHFAST1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_BREATHFAST2
		EmitSound(1, 0, SOUNDSET_HM_BREATHFAST2);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_BREATHFAST3
		EmitSound(1, 0, SOUNDSET_HM_BREATHFAST3);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_DEATH
		EmitSound(1, 0, SOUNDSET_HM_DEATH);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_CHESTHIT1
		EmitSound(1, 0, SOUNDSET_HM_CHESTHIT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_STOMACHHIT1
		EmitSound(1, 0, SOUNDSET_HM_STOMACHHIT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_ARMHIT1
		EmitSound(1, 0, SOUNDSET_HM_ARMHIT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_LEGHIT1
		EmitSound(1, 0, SOUNDSET_HM_LEGHIT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_FALLPAIN1
		EmitSound(1, 0, SOUNDSET_HM_FALLPAIN1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_FALLPAIN2
		EmitSound(1, 0, SOUNDSET_HM_FALLPAIN2);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_FALLPAIN3
		EmitSound(1, 0, SOUNDSET_HM_FALLPAIN3);
		// svplaysound: svplaysound 1 0 SOUNDSET_HM_FALLPAIN4
		EmitSound(1, 0, SOUNDSET_HM_FALLPAIN4);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_SWORDREADY
		EmitSound(1, 0, SOUNDSET_HF_SWORDREADY);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_SHOUT1
		EmitSound(1, 0, SOUNDSET_HF_SHOUT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_JAB1
		EmitSound(1, 0, SOUNDSET_HF_JAB1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_JAB2
		EmitSound(1, 0, SOUNDSET_HF_JAB2);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_BREATHFAST1
		EmitSound(1, 0, SOUNDSET_HF_BREATHFAST1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_BREATHFAST2
		EmitSound(1, 0, SOUNDSET_HF_BREATHFAST2);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_BREATHFAST3
		EmitSound(1, 0, SOUNDSET_HF_BREATHFAST3);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_DEATH
		EmitSound(1, 0, SOUNDSET_HF_DEATH);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_CHESTHIT1
		EmitSound(1, 0, SOUNDSET_HF_CHESTHIT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_STOMACHHIT1
		EmitSound(1, 0, SOUNDSET_HF_STOMACHHIT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_ARMHIT1
		EmitSound(1, 0, SOUNDSET_HF_ARMHIT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_LEGHIT1
		EmitSound(1, 0, SOUNDSET_HF_LEGHIT1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_FALLPAIN1
		EmitSound(1, 0, SOUNDSET_HF_FALLPAIN1);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_FALLPAIN2
		EmitSound(1, 0, SOUNDSET_HF_FALLPAIN2);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_FALLPAIN3
		EmitSound(1, 0, SOUNDSET_HF_FALLPAIN3);
		// svplaysound: svplaysound 1 0 SOUNDSET_HF_FALLPAIN4
		EmitSound(1, 0, SOUNDSET_HF_FALLPAIN4);
	}

	void game_scriptflag_update()
	{
		LogDebug("game_scriptflag_update PARAM1 PARAM2 PARAM3 PARAM4 PARAM5");
		if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "nopush", "type_exists")))
		{
			SetNoPush(true);
		}
		else
		{
			SetNoPush(false);
		}
		if (param1 == "add")
		{
			int L_CHECK_EXPIRE = 1;
		}
		if (param1 == "edit")
		{
			int L_CHECK_EXPIRE = 1;
		}
		if (!(L_CHECK_EXPIRE)) return;
		string L_CHECK_EXPTIME = param5;
		if (L_CHECK_EXPTIME > -1)
		{
			L_CHECK_EXPTIME += 0.1;
			L_CHECK_EXPTIME("check_flags_expired");
		}
	}

	void ext_set_status_flag()
	{
		SetScriptFlags(GetOwner(), "add", param1, param2, param3, param4, param5);
		check_flags();
	}

	void check_flags()
	{
		if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "mana_regen", "type_exists")))
		{
			ext_mana_regen_loop();
		}
	}

	void check_flags_expired()
	{
		LogDebug("check_flags_expired");
		SetScriptFlags(GetOwner(), "remove_expired");
		CallExternal(GetOwner(), "ext_scriptflag_expired");
	}

	void ext_remove_status_flag()
	{
		SetScriptFlags(GetOwner(), "remove", param1);
	}

	void ext_remove_status_flags_type()
	{
		LogDebug("ext_remove_status_flags_type PARAM1");
		SetScriptFlags(GetOwner(), "cleartype", param1);
	}

	void game_hitbodypart()
	{
		LogDebug("game_hitbodypart PARAM1");
		if (!(RandomInt(1, 5) == 1)) return;
		if (param1 == "chest")
		{
			// svplaysound: if ( PARAM1 equals chest ) svplaysound 2 10 PLR_SOUND_CHESTHIT1
			EmitSound(2, 10, PLR_SOUND_CHESTHIT1);
		}
		if (param1 == "stomach")
		{
			// svplaysound: if ( PARAM1 equals stomach ) svplaysound 2 10 PLR_SOUND_STOMACHHIT1
			EmitSound(2, 10, PLR_SOUND_STOMACHHIT1);
		}
		if (param1 == "larm")
		{
			// svplaysound: if ( PARAM1 equals larm ) svplaysound 2 10 PLR_SOUND_ARMHIT1
			EmitSound(2, 10, PLR_SOUND_ARMHIT1);
		}
		if (param1 == "rarm")
		{
			// svplaysound: if ( PARAM1 equals rarm ) svplaysound 2 10 PLR_SOUND_ARMHIT1
			EmitSound(2, 10, PLR_SOUND_ARMHIT1);
		}
		if (param1 == "rleg")
		{
			// svplaysound: if ( PARAM1 equals rleg ) svplaysound 2 10 PLR_SOUND_LEGHIT1
			EmitSound(2, 10, PLR_SOUND_LEGHIT1);
		}
		if (param1 == "lleg")
		{
			// svplaysound: if ( PARAM1 equals lleg ) svplaysound 2 10 PLR_SOUND_LEGHIT1
			EmitSound(2, 10, PLR_SOUND_LEGHIT1);
		}
	}

	void game_fall()
	{
		// PlayRandomSound from: PLR_SOUND_FALLPAIN1, PLR_SOUND_FALLPAIN2, PLR_SOUND_FALLPAIN3, PLR_SOUND_FALLPAIN4
		array<string> sounds = {PLR_SOUND_FALLPAIN1, PLR_SOUND_FALLPAIN2, PLR_SOUND_FALLPAIN3, PLR_SOUND_FALLPAIN4};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void set_glow_id()
	{
		MY_GLOW_ID = param1;
	}

	void set_stun_prot()
	{
		SetDamageResistance("stun", param1);
	}

	void set_spawn_point()
	{
		NEW_SPAWN_POS = param1;
	}

	void register_body()
	{
		MY_BODY = param1;
		MY_CL_BODY = param2;
	}

	void hide_body_parts()
	{
		HIDE_LEGS = 0;
		HIDE_HEAD = 0;
		HIDE_CHEST = 0;
		HIDE_ARMS = 0;
		if (GetToken(param1, 0, ";") == "legs")
		{
			HIDE_LEGS = 1;
		}
		if (GetToken(param1, 0, ";") == "head")
		{
			HIDE_HEAD = 1;
		}
		if (GetToken(param1, 0, ";") == "chest")
		{
			HIDE_CHEST = 1;
		}
		if (GetToken(param1, 0, ";") == "arms")
		{
			HIDE_ARMS = 1;
		}
		if (GetToken(param1, 1, ";") == "legs")
		{
			HIDE_LEGS = 1;
		}
		if (GetToken(param1, 1, ";") == "head")
		{
			HIDE_HEAD = 1;
		}
		if (GetToken(param1, 1, ";") == "chest")
		{
			HIDE_CHEST = 1;
		}
		if (GetToken(param1, 1, ";") == "arms")
		{
			HIDE_ARMS = 1;
		}
		if (GetToken(param1, 2, ";") == "legs")
		{
			HIDE_LEGS = 1;
		}
		if (GetToken(param1, 2, ";") == "head")
		{
			HIDE_HEAD = 1;
		}
		if (GetToken(param1, 2, ";") == "chest")
		{
			HIDE_CHEST = 1;
		}
		if (GetToken(param1, 2, ";") == "arms")
		{
			HIDE_ARMS = 1;
		}
		if (GetToken(param1, 3, ";") == "legs")
		{
			HIDE_LEGS = 1;
		}
		if (GetToken(param1, 3, ";") == "head")
		{
			HIDE_HEAD = 1;
		}
		if (GetToken(param1, 3, ";") == "chest")
		{
			HIDE_CHEST = 1;
		}
		if (GetToken(param1, 3, ";") == "arms")
		{
			HIDE_ARMS = 1;
		}
		if (GetToken(param1, 4, ";") == "legs")
		{
			HIDE_LEGS = 1;
		}
		if (GetToken(param1, 4, ";") == "head")
		{
			HIDE_HEAD = 1;
		}
		if (GetToken(param1, 4, ";") == "chest")
		{
			HIDE_CHEST = 1;
		}
		if (GetToken(param1, 4, ";") == "arms")
		{
			HIDE_ARMS = 1;
		}
		CallExternal(MY_BODY, "hide_parts", HIDE_LEGS, HIDE_HEAD, HIDE_CHEST, HIDE_ARMS);
	}

	void wearing_armor()
	{
		ARMOR_EQUIPED = param1;
		if (param1 == 0)
		{
			ARMOR_TYPE = "none";
			ARMOR_OFS = 0;
		}
		else
		{
			ARMOR_TYPE = param2;
			string INC_OFS = param3;
			INC_OFS += 1;
			ARMOR_OFS = param3;
		}
	}

	void potion_regen()
	{
		if ((REGEN_ON)) return;
		if ((VAMPIRE_ON))
		{
			SendColoredMessage(GetOwner(), "Vampire blood and regeneration potions do not mix.");
			KillEntity(GetOwner());
		}
		REGEN_ON = 1;
		REGEN_RATE = 5;
		PARAM1("regen_end");
		regen_start();
	}

	void regen_start()
	{
		if (!(REGEN_ON)) return;
		string MY_MAX_HEALTH = GetEntityMaxHealth(GetOwner());
		string MY_CUR_HEALTH = GetEntityHealth(GetOwner());
		EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
		if (MY_CUR_HEALTH < MY_MAX_HEALTH)
		{
			HealEntity(GetOwner(), REGEN_RATE);
		}
		ScheduleDelayedEvent(1.0, "regen_start");
	}

	void regen_end()
	{
		if (!(REGEN_ON)) return;
		SendPlayerMessage(GetOwner(), "The regenerative magic fades.");
		REGEN_ON = 0;
	}

	void potion_vampire()
	{
		if ((VAMPIRE_ON)) return;
		VAMPIRE_ON = 1;
		IMMUNE_VAMPIRE = 1;
		vampire_suncheck();
		PARAM1("vampire_off");
	}

	void vampire_suncheck()
	{
		if (!(VAMPIRE_ON)) return;
		if (CURRENT_TIME_HOUR < 19)
		{
			if (CURRENT_TIME_HOUR > 5)
			{
			}
			string MY_POS = GetEntityOrigin(GetOwner());
			if ((/* TODO: $get_under_sky */ $get_under_sky(MY_POS)))
			{
			}
			if (GetMapName() != "sfor")
			{
			}
			int SUN_DAMAGE = 100;
			if (CURRENT_TIME_HOUR > 16)
			{
				int SUN_DAMAGE = 50;
			}
			CallExternal(GAME_MASTER, "gm_setname", "The light of the sun");
			XDoDamage(GetOwner(), "direct", SUN_DAMAGE, 1.0, GAME_MASTER, GAME_MASTER, "none", "magic_effect");
		}
		ScheduleDelayedEvent(5.1, "vampire_suncheck");
	}

	void vampire_off()
	{
		IMMUNE_VAMPIRE = 0;
		VAMPIRE_ON = 0;
		SendPlayerMessage(GetOwner(), "The effects of the vampire blood fade.");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if ((VAMPIRE_ON))
		{
			string DMG_INFLICTED = param2;
			DMG_INFLICTED *= VAMPIRE_MULTI;
			HealEntity(GetOwner(), DMG_INFLICTED);
			try_vampire_target(GetEntityIndex(GetOwner()), GetEntityIndex(param1), DMG_INFLICTED);
		}
	}

	void ext_playsound_kiss()
	{
		EmitSound(GetOwner(), param1, param3, param2);
	}

	void ext_playsound()
	{
		if (param3 != "PARAM3")
		{
			string SOURCE_ORG = param2;
			if (Distance(GetMonsterProperty("origin"), SOURCE_ORG) > param3)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		EXTPLAY_SOUND = param1;
		ScheduleDelayedEvent(0.1, "ext_playsound2");
	}

	void ext_playsound2()
	{
		EmitSound(GetOwner(), 0, EXTPLAY_SOUND, 10);
	}

	void ext_rename_me()
	{
		SetName(param1);
	}

	void ext_play_music()
	{
		// TODO: playmp3 ent_me combat PARAM1
	}

	void ext_play_music_me()
	{
		// TODO: playmp3 ent_me combat PARAM1
	}

	void ext_setangle()
	{
		SetAngles(param1);
	}

	void ext_quest()
	{
		SetPlayerQuestData(GetOwner(), param1);
	}

	void ext_addgold()
	{
		// TODO: UNCONVERTED: addgold PARAM1
	}

	void ext_setgold()
	{
		SetGold(param1);
	}

	void send_damage()
	{
		DoDamage(param1, param2, param3, param4, param5);
	}

	void give_hp()
	{
		HealEntity(GetOwner(), param1);
	}

	void give_mp()
	{
		GiveMP(param1);
	}

	void ext_invalidate()
	{
		PLAYING_DEAD = param1;
	}

	void ext_dodamage()
	{
		DoDamage(param1, param2, param3, param4, param5);
	}

	void freeze_solid_start()
	{
		I_R_FROZEN = 1;
		PL_I_R_FROZEN = 1;
		PARAM1("freeze_solid_end");
	}

	void freeze_solid_end()
	{
		I_R_FROZEN = 0;
		PL_I_R_FROZEN = 0;
	}

	void ext_removed_effects()
	{
		EXT_REMOVE_EFFECT = "unset";
	}

	void ext_spider_protect()
	{
		string L_DUR = param1;
		string L_AMT = param2;
		string L_TAG = param3;
		PLR_SPIDER_PROT = 1;
		PLR_SPIDER_AMT = L_AMT;
		L_DUR("spider_protect_end");
		float_to_percent(PLR_SPIDER_AMT);
		SendColoredMessage(GetOwner(), "You are now protected from spiders FLOAT_RETURN");
		SetScriptFlags(GetOwner(), "add", L_TAG, "spider_resist", L_AMT, L_DUR);
	}

	void spider_protect_end()
	{
		if (!(PLR_SPIDER_PROT)) return;
		PLR_SPIDER_PROT = 0;
		SendPlayerMessage(GetOwner(), "The protection from spider magic fades.");
	}

	void float_to_percent()
	{
		if (param1 == 0)
		{
			FLOAT_RETURN = "100%";
		}
		if (param1 == 1)
		{
			FLOAT_RETURN = "100%";
		}
		if (!(param1 != 0)) return;
		FLOAT_RETURN = 100;
		string INC_FLOAT = param1;
		INC_FLOAT *= 100;
		FLOAT_RETURN -= INC_FLOAT;
		string FLOAT_RETURN = int(FLOAT_RETURN);
		FLOAT_RETURN += "%";
	}

	void ext_set_alco_type()
	{
		ALCO_TYPE = param1;
		ALCO_SPAWN_ITEM = param2;
	}

	void ext_flash_bang()
	{
		if (!(Distance(GetMonsterProperty("origin"), param1) < param2)) return;
		Effect("screenfade", GetOwner(), 3, 1, Vector3(255, 255, 255), 255, "fadein");
	}

	void ext_set_swift_blade()
	{
		PLR_SWIFT_BLADE = param1;
	}

	void game_equipped()
	{
		ext_set_hand_id(GetEntityProperty(param1, "hand_index"), GetEntityIndex(param1));
	}

	void ext_set_hand_id()
	{
		string L_HAND_DEST = param1;
		string L_ITEM_ID = param2;
		string L_HANDPREF = GetEntityProperty(L_ITEM_ID, "handpref");
		if (L_HAND_DEST == 0)
		{
			PLR_LEFT_HAND = L_ITEM_ID;
		}
		else
		{
			if (L_HAND_DEST == 1)
			{
				PLR_RIGHT_HAND = L_ITEM_ID;
				if (L_HANDPREF == 4)
				{
					PLR_LEFT_HAND = 0;
				}
			}
			else
			{
				if (L_HAND_DEST == 2)
				{
					PLR_LEFT_HAND = L_ITEM_ID;
					PLR_RIGHT_HAND = L_ITEM_ID;
				}
			}
		}
		PLR_ACTIVE_WEAPON = L_ITEM_ID;
		if ((GetEntityProperty(PLR_ACTIVE_WEAPON, "scriptvar")))
		{
			PLR_SPECIAL_WEAPON = 1;
		}
		else
		{
			PLR_SPECIAL_WEAPON = 0;
		}
		update_parry();
		set_two_hand();
		ScheduleDelayedEvent(0.25, "set_swift_blade");
	}

	void update_parry()
	{
		float PARRY_MULTI = 1.0;
		string LEFT_PARRY_SKILL = "skill.";
		LEFT_PARRY_SKILL += GetEntityProperty(PLR_LEFT_HAND, "scriptvar");
		string LEFT_PARRY = GetEntityProperty(GetOwner(), "left_parry_skill");
		if (GetEntityProperty(PLR_LEFT_HAND, "handpref") == 2)
		{
			int LEFT_PARRY = 0;
		}
		if (GetEntityProperty(PLR_LEFT_HAND, "handpref") == 4)
		{
			if (LEFT_PARRY_SKILL != "skill.martialarts")
			{
			}
			LEFT_PARRY *= 1.5;
		}
		if ((GetEntityProperty(PLR_LEFT_HAND, "scriptvar")))
		{
			int LEFT_PARRY = 0;
			string LEFT_PARRY_MULTI = GetEntityProperty(PLR_LEFT_HAND, "scriptvar");
			if (LEFT_PARRY_MULTI != "not_equipped")
			{
				PARRY_MULTI += LEFT_PARRY_MULTI;
			}
		}
		string RIGHT_PARRY_SKILL = "skill.";
		RIGHT_PARRY_SKILL += GetEntityProperty(PLR_RIGHT_HAND, "scriptvar");
		string RIGHT_PARRY = GetEntityProperty(GetOwner(), "right_parry_skill");
		if (GetEntityProperty(PLR_RIGHT_HAND, "handpref") == 2)
		{
			int RIGHT_PARRY = 0;
		}
		if (GetEntityProperty(PLR_RIGHT_HAND, "handpref") == 4)
		{
			if (RIGHT_PARRY_SKILL != "skill.martialarts")
			{
			}
			RIGHT_PARRY *= 1.5;
		}
		if ((GetEntityProperty(PLR_RIGHT_HAND, "scriptvar")))
		{
			int RIGHT_PARRY = 0;
			string RIGHT_PARRY_MULTI = GetEntityProperty(PLR_RIGHT_HAND, "scriptvar");
			if (RIGHT_PARRY_MULTI != "not_equipped")
			{
				PARRY_MULTI += RIGHT_PARRY_MULTI;
			}
		}
		string TOTAL_PARRY = RIGHT_PARRY;
		TOTAL_PARRY += LEFT_PARRY;
		if (PARRY_MULTI > 1.0)
		{
			PARRY_MULTI -= 1.0;
		}
		if (TOTAL_PARRY == 0)
		{
			if (PARRY_MULTI > 1.0)
			{
			}
			string TOTAL_PARRY = GetSkillLevel(GetOwner(), "martialarts");
		}
		TOTAL_PARRY *= PARRY_MULTI;
		string TOTAL_PARRY = int(TOTAL_PARRY);
		string OLD_PARRY = PL_PARRY;
		PL_PARRY = TOTAL_PARRY;
		if (OLD_PARRY != PL_PARRY)
		{
			SendColoredMessage(GetOwner(), "Your Parry value is now TOTAL_PARRY");
		}
		SetStat("parry", TOTAL_PARRY);
	}

	void set_two_hand()
	{
		string PLR_LEFT_HAND_TYPE = GetEntityProperty(PLR_LEFT_HAND, "itemname");
		string PLR_RIGHT_HAND_TYPE = GetEntityProperty(PLR_RIGHT_HAND, "itemname");
		string L_NO_REDUCT = /* TODO: $func */ $func("func_get_dualwield_reduct", PLR_LEFT_HAND_TYPE);
		if (!(L_NO_REDUCT))
		{
			string L_NO_REDUCT = /* TODO: $func */ $func("func_get_dualwield_reduct", PLR_RIGHT_HAND_TYPE);
		}
		PLR_HAS_MATCHED_SET = 0;
		if ((GetEntityProperty(PLR_RIGHT_HAND, "scriptvar")))
		{
			string L_MATCHED_SET_TYPE = GetEntityProperty(PLR_RIGHT_HAND, "scriptvar");
			if (GetEntityProperty(PLR_LEFT_HAND, "scriptvar") == L_MATCHED_SET_TYPE)
			{
				int L_NO_REDUCT = 1;
				PLR_HAS_MATCHED_SET = 1;
			}
		}
		if (!(L_NO_REDUCT))
		{
			string OLD_REDUCT = PLR_2H_REDUCT;
			if ((PLR_LEFT_HAND_TYPE).findFirst("smallarms_") >= 0)
			{
				int SA_REDUCT = 1;
			}
			if ((PLR_RIGHT_HAND_TYPE).findFirst("smallarms_") >= 0)
			{
				int SA_REDUCT = 1;
			}
			if (PLR_LEFT_HAND_TYPE == PLR_RIGHT_HAND_TYPE)
			{
				int SA_REDUCT = 1;
			}
			if ((SA_REDUCT))
			{
				PLR_2H_REDUCT = PLR_2HPEN_LIGHT;
				if (OLD_REDUCT != PLR_2H_REDUCT)
				{
					SendColoredMessage(GetOwner(), "Dual-wield penalty: PLR_2HPEN_LIGHT_REPORT off-hand is light or matches");
				}
			}
			else
			{
				PLR_2H_REDUCT = PLR_2HPEN_HEAVY;
				if (OLD_REDUCT != PLR_2H_REDUCT)
				{
					SendColoredMessage(GetOwner(), "Dual-wield penalty: PLR_2HPEN_HEAVY_REPORT");
				}
			}
		}
		else
		{
			string OLD_REDUCT = PLR_2H_REDUCT;
			PLR_2H_REDUCT = 1.0;
			if (OLD_REDUCT != PLR_2H_REDUCT)
			{
				if (!(PLR_HAS_MATCHED_SET))
				{
					SendColoredMessage(GetOwner(), "No dual-wield penalty.");
				}
			}
			if ((PLR_HAS_MATCHED_SET))
			{
				if (!(PLR_HAD_MATCHED_SET))
				{
				}
				SendColoredMessage(GetOwner(), "No dual-wield penalty due to matched set!");
				PLR_HAD_MATCHED_SET = 1;
			}
			else
			{
				PLR_HAD_MATCHED_SET = 0;
			}
		}
	}

	void func_get_dualwield_reduct()
	{
		string L_ITEM = param1;
		int L_NO_REDUCT = 0;
		if ((L_ITEM).findFirst("bows_") == 0)
		{
			int L_NO_REDUCT = 1;
		}
		else
		{
			if ((L_ITEM).findFirst("shield") == 0)
			{
				int L_NO_REDUCT = 1;
			}
			else
			{
				if ((L_ITEM).findFirst("armor_") == 0)
				{
					int L_NO_REDUCT = 1;
				}
				else
				{
					if ((L_ITEM).findFirst("magic_hand_") == 0)
					{
						int L_NO_REDUCT = 1;
					}
					else
					{
						if ((L_ITEM).findFirst("fist_") == 0)
						{
							int L_NO_REDUCT = 1;
						}
						else
						{
							if ((L_ITEM).findFirst("gauntlet") >= 0)
							{
								int L_NO_REDUCT = 1;
							}
							else
							{
								if (L_ITEM == "0")
								{
									int L_NO_REDUCT = 1;
								}
								else
								{
									if ((L_ITEM).findFirst("item") == 0)
									{
										int L_NO_REDUCT = 1;
									}
									else
									{
										if ((L_ITEM).findFirst("mana") == 0)
										{
											int L_NO_REDUCT = 1;
										}
										else
										{
											if ((L_ITEM).findFirst("health") == 0)
											{
												int L_NO_REDUCT = 1;
											}
											else
											{
												if ((L_ITEM).findFirst("skin") == 0)
												{
													int L_NO_REDUCT = 1;
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
		return;
		return;
	}

	void set_swift_blade()
	{
		string ACTIVE_WEAPON = GetActiveItem(GetOwner());
		string ACTIVE_SCRIPT = GetEntityProperty(ACTIVE_WEAPON, "itemname");
		if ((ACTIVE_SCRIPT).findFirst("bows_") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((ACTIVE_SCRIPT).findFirst("magic_hand_") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (PLR_SWIFT_BLADE == 0)
		{
			if ((GetEntityProperty(ACTIVE_WEAPON, "scriptvar")))
			{
				CallExternal(ACTIVE_WEAPON, "ext_item_swift_blade", "remove");
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityProperty(ACTIVE_WEAPON, "scriptvar")))
		{
			string CUR_SPEED = /* TODO: $get_attackprop */ $get_attackprop(ACTIVE_WEAPON, 0, "delay.end");
			string CUR_STRIKE = /* TODO: $get_attackprop */ $get_attackprop(ACTIVE_WEAPON, 0, "delay.strike");
		}
		else
		{
			string CUR_SPEED = GetEntityProperty(ACTIVE_WEAPON, "scriptvar");
			string CUR_STRIKE = GetEntityProperty(ACTIVE_WEAPON, "scriptvar");
		}
		CallExternal(ACTIVE_WEAPON, "ext_item_swift_blade", CUR_SPEED, CUR_STRIKE);
		CUR_SPEED *= PLR_SWIFT_BLADE;
		CUR_STRIKE *= PLR_SWIFT_BLADE;
		CUR_STRIKE *= 0.75;
		string VIEWANIM_SPEED = GetEntityProperty(ACTIVE_WEAPON, "scriptvar");
		if (CUR_SPEED > 0)
		{
			VIEWANIM_SPEED /= CUR_SPEED;
		}
		// TODO: setviewmodelprop ACTIVE_WEAPON animspeed VIEWANIM_SPEED
		SetAttackProp("ACTIVE_WEAPON", 0);
		SetAttackProp("ACTIVE_WEAPON", 0);
	}

	void ext_sphere_token_x()
	{
		PLR_SCAN_TOKEN = FindEntitiesInSphere(param1, param2);
	}

	void ext_sphere_token()
	{
		PLR_SCAN_TOKEN = FindEntitiesInSphere(param1, param2);
	}

	void ext_sphere_token_byrange()
	{
		PLR_SCAN_TOKEN = FindEntitiesInSphere(param1, param2);
		if (!(PLR_SCAN_TOKEN != "none")) return;
		PLR_SCAN_TOKEN = /* TODO: $sort_entlist */ $sort_entlist(PLR_SCAN_TOKEN, "range");
	}

	void ext_box_token()
	{
		PLR_SCAN_TOKEN = /* TODO: $get_tbox */ $get_tbox(param1, param2, param3);
	}

	void ext_set_vote_delay()
	{
		VOTE_DISABLED = 1;
		ScheduleDelayedEvent(20.0, "reset_vote_delay");
	}

	void reset_vote_delay()
	{
		VOTE_DISABLED = 0;
	}

	void ext_reset_names()
	{
		SetPlayerQuestData(GetOwner(), "n");
	}

	void ext_send_tele_point()
	{
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
		SetEntityOrigin(GetEntityIndex(GetOwner()), param1);
		if ((G_DEVELOPER_MODE))
		{
			SendColoredMessage(GetOwner(), "ext_send_tele_point PARAM1");
		}
		OWNER_POS = param1;
		for (int i = 0; i < 18; i++)
		{
			beam_fx2();
		}
	}

	void beam_fx2()
	{
		string BEAM_START = OWNER_POS;
		string BEAM_END = OWNER_POS;
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, BEAM_ROT, 0), Vector3(0, 32, -32));
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, BEAM_ROT, 0), Vector3(0, 32, 128));
		Effect("beam", "point", "lgtning.spr", 100, BEAM_START, BEAM_END, Vector3(255, 0, 255), 200, 16, 3);
		BEAM_ROT += 20;
	}

	void ext_set_next_scroll()
	{
		PLR_NEXT_SCROLL = GetGameTime();
		PLR_NEXT_SCROLL += 5.0;
	}

	void ext_set_reward()
	{
		PLR_GOT_REWARD = param1;
	}

	void game_drain_death()
	{
		DoDamage(GetOwner(), "direct", 100, 1.0, param1);
	}

	void ext_set_map()
	{
		SetPlayerQuestData(GetOwner(), "m");
		SetPlayerQuestData(GetOwner(), "d");
		SetTransition(GetOwner(), param2);
		PLR_CUR_TRANS = param2;
		PLR_NEXT_TRANS = param3;
		ScheduleDelayedEvent(0.1, "ext_set_transitions");
	}

	void ext_setspawn()
	{
		LogDebug("ext_setspawn PARAM1");
		SetTransition(GetOwner(), param1);
		SetPlayerQuestData(GetOwner(), "d");
	}

	void ext_set_transitions()
	{
		if (!(PLR_IN_WORLD)) return;
		SetTransition(GetOwner(), PLR_CUR_TRANS);
	}

	void ext_scan_pet()
	{
		T_SPHERE = FindEntitiesInSphere("enemy", 512);
		TARGET_PET_TYPE = param1;
		if (!(T_SPHERE != "none")) return;
		for (int i = 0; i < GetTokenCount(T_SPHERE, ";"); i++)
		{
			ext_scan_pet_loop();
		}
	}

	void ext_scan_pet_loop()
	{
		string CUR_TARGET = GetToken(T_SPHERE, i, ";");
		string PET_TYPE = GetEntityProperty(CUR_TARGET, "scriptvar");
		if (!(PET_TYPE == TARGET_PET_TYPE)) return;
		PLR_FOUND_PET = CUR_TARGET;
	}

	void ext_set_frozen()
	{
		I_R_FROZEN = 1;
		SetScriptFlags(GetOwner(), "add", "ext_set_frozen", "nopush", 1, param1, "none");
		PARAM1("ext_set_unfrozen");
	}

	void ext_set_unfrozen()
	{
		I_R_FROZEN = 0;
	}

	void ext_glow_block()
	{
		PLR_GLOW_BLOCK = param1;
		if ((PLR_GLOW_BLOCK))
		{
			if ((PLR_HAS_GLOW))
			{
			}
			EmitSound(GetOwner(), 2, "magic/elecidlepop.wav", 10);
			SendPlayerMessage(GetOwner(), "Your light is snuffed out!");
			CallExternal(GAME_MASTER, "gm_light_update", "remove", GetEntityIndex(GetOwner()), Vector3(COLOR_RATIO_R, COLOR_RATIO_G, COLOR_RATIO_B), RAD_RATIO);
			ext_set_glow(0);
		}
		else
		{
			SendPlayerMessage(GetOwner(), "You have left the influence of the dark force.");
		}
	}

	void ext_ent_list_sort()
	{
		string SCAN_TYPE = param1;
		string SCAN_RANGE = param2;
		string SCAN_ORIGIN = param3;
		string SORT_TYPE = param4;
		ext_sphere_token(SCAN_TYPE, SCAN_RANGE, SCAN_ORIGIN);
		PLR_SCAN_TOKEN_SORTED = /* TODO: $sort_entlist */ $sort_entlist(PLR_SCAN_TOKEN, SORT_TYPE);
	}

	void ext_fire_aura_activate()
	{
		if ((PLR_FAURA)) return;
		PLR_FAURA = 1;
		PLR_FAURA_DOT = param1;
		PLR_FAURA_AOE = param2;
		GAME_PVP = "game.pvp";
		ClientEvent("new", "all", "items/armor_faura_cl", GetEntityIndex(GetOwner()), PLR_FAURA_AOE, PLR_FAURA_CL_RATE);
		PLR_FAURA_CLIDX = "game.script.last_sent_id";
		PLR_FAURA_NEXT_CL = GetGameTime();
		PLR_FAURA_NEXT_CL += PLR_FAURA_CL_RATE;
		fire_aura_loop();
	}

	void fire_aura_loop()
	{
		if (!(PLR_FAURA)) return;
		ScheduleDelayedEvent(1.0, "fire_aura_loop");
		string GAME_TIME = GetGameTime();
		if (GAME_TIME > PLR_FAURA_NEXT_CL)
		{
			ClientEvent("new", "all", "items/armor_faura_cl", GetEntityIndex(GetOwner()), PLR_FAURA_AOE, PLR_FAURA_CL_RATE);
			PLR_FAURA_CLIDX = "game.script.last_sent_id";
			PLR_FAURA_NEXT_CL = GAME_TIME;
			PLR_FAURA_NEXT_CL += PLR_FAURA_CL_RATE;
		}
		if (!(IsEntityAlive(GetOwner()))) return;
		string SCAN_AOE = PLR_FAURA_AOE;
		SCAN_AOE *= 3;
		PLR_FAURA_SCAN = FindEntitiesInSphere("enemy", SCAN_AOE);
		if (!(PLR_FAURA_SCAN != "none")) return;
		for (int i = 0; i < GetTokenCount(PLR_FAURA_SCAN, ";"); i++)
		{
			fire_aura_burn();
		}
	}

	void fire_aura_burn()
	{
		string CUR_TARG = GetToken(PLR_FAURA_SCAN, i, ";");
		if (!(GetEntityRange(CUR_TARG) < PLR_FAURA_AOE)) return;
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(CUR_TARG)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IS_AFK))
		{
			ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), PLR_FAURA_DOT, "spellcasting.fire");
		}
	}

	void ext_fire_aura_remove()
	{
		PLR_FAURA = 0;
		ClientEvent("update", "all", PLR_FAURA_CLIDX, "remove_me");
	}

	void ext_poison_aura_activate()
	{
		if ((PLR_PAURA)) return;
		PLR_PAURA = 1;
		PLR_PAURA_DOT = param1;
		PLR_PAURA_AOE = param2;
		GAME_PVP = "game.pvp";
		ClientEvent("new", "all", "effects/sfx_poison_aura", GetEntityIndex(GetOwner()), PLR_PAURA_AOE, PLR_PAURA_CL_RATE);
		PLR_PAURA_CLIDX = "game.script.last_sent_id";
		PLR_PAURA_NEXT_CL = GetGameTime();
		PLR_PAURA_NEXT_CL += PLR_PAURA_CL_RATE;
		poison_aura_loop();
	}

	void poison_aura_loop()
	{
		if (!(PLR_PAURA)) return;
		ScheduleDelayedEvent(1.0, "poison_aura_loop");
		string GAME_TIME = GetGameTime();
		if (GAME_TIME > PLR_PAURA_NEXT_CL)
		{
			ClientEvent("new", "all", "effects/sfx_poison_aura", GetEntityIndex(GetOwner()), PLR_PAURA_AOE, PLR_PAURA_CL_RATE);
			PLR_PAURA_CLIDX = "game.script.last_sent_id";
			PLR_PAURA_NEXT_CL = GAME_TIME;
			PLR_PAURA_NEXT_CL += PLR_PAURA_CL_RATE;
		}
		if (!(IsEntityAlive(GetOwner()))) return;
		PLR_PAURA_SCAN = FindEntitiesInSphere("enemy", PLR_PAURA_AOE);
		if (!(PLR_PAURA_SCAN != "none")) return;
		for (int i = 0; i < GetTokenCount(PLR_PAURA_SCAN, ";"); i++)
		{
			poison_aura_burn();
		}
	}

	void poison_aura_burn()
	{
		string CUR_TARG = GetToken(PLR_PAURA_SCAN, i, ";");
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(CUR_TARG)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IS_AFK))
		{
			ApplyEffect(CUR_TARG, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), PLR_PAURA_DOT, 1, "spellcasting.affliction");
		}
	}

	void ext_poison_aura_remove()
	{
		PLR_PAURA = 0;
		ClientEvent("update", "all", PLR_PAURA_CLIDX, "remove_me");
	}

	void ext_setmodelbody()
	{
		SetModelBody(param1, param2);
	}

	void ext_setbodytype()
	{
		PLR_PREV_BODY_TYPE = PLR_BODY_TYPE;
		PLR_BODY_TYPE = param1;
		if (param2 != "remove")
		{
			PLR_LAST_WORN_ARMOR = param2;
		}
		int GENDER_ADJ = 1;
		if (PLR_GENDER == "female")
		{
			if (GetEntityRace(GetOwner()) == "human")
			{
				GENDER_ADJ += 1;
			}
			if ((G_DEVELOPER_MODE))
			{
				SendInfoMessageToAll("green ext_setbodytype is_female");
			}
			LogDebug("ext_setbodytype Set female bodytype");
		}
		if ((param1).findFirst("PARAM") == 0)
		{
			PLR_BODY_TYPE = PLR_PREV_BODY_TYPE;
		}
		else
		{
			PLR_PREV_BODY_TYPE = PLR_BODY_TYPE;
		}
		if (PLR_BODY_TYPE == "normal")
		{
			SetModelBody(0, GENDER_ADJ);
			SetModelBody(1, GENDER_ADJ);
			SetModelBody(2, GENDER_ADJ);
			SetModelBody(3, GENDER_ADJ);
		}
		if (PLR_BODY_TYPE == "leather")
		{
			SetModelBody(0, GENDER_ADJ);
			SetModelBody(1, GENDER_ADJ);
			SetModelBody(2, 0);
			SetModelBody(3, GENDER_ADJ);
		}
		if (PLR_BODY_TYPE == "platemail")
		{
			SetModelBody(0, 0);
			SetModelBody(1, GENDER_ADJ);
			SetModelBody(2, 0);
			SetModelBody(3, 0);
		}
	}

	void ext_register_helm()
	{
		PLR_HELM_ID = param1;
		if (!(PLR_HELM_ID != "none")) return;
		CallClientItemEvent(PLR_HELM_ID, "game_show", GetEntityRace(GetOwner()), GetGender(GetOwner()), "ext_register_helm");
	}

	void ext_register_armor()
	{
		PLR_ARMOR_ID = param1;
		if (!(PLR_ARMOR_ID != "none")) return;
		CallClientItemEvent(PLR_ARMOR_ID, "barmor_update_vest", GetEntityRace(GetOwner()), GetGender(GetOwner()), "ext_register_armor");
	}

	void ext_dwarf_test()
	{
		SetModelBody(0, 1);
		SetModelBody(1, 2);
		SetModelBody(2, 1);
		ext_hide_armor();
	}

	void ext_hide_armor()
	{
		CallExternal(PLR_HELM_ID, "ext_hide");
	}

	void ext_setheadtype()
	{
		int GENDER_ADJ = 0;
		if (PLR_GENDER == "female")
		{
			if (GetEntityRace(GetOwner()) == "human")
			{
				GENDER_ADJ += 2;
			}
		}
		PARAM1 += GENDER_ADJ;
		SetModelBody(0, param1);
	}

	void ext_setmodel()
	{
		SetModel("dwarf/reference.mdl");
	}

	void ext_setrender()
	{
		// TODO: UNCONVERTED: setrender PARAM1
	}

	void ext_tod_lock()
	{
		PLR_TOD_LOCK = param1;
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "lock_tod", PLR_TOD_LOCK);
	}

	void ext_viewdist()
	{
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "set_view_dist", param1);
	}

	void ext_urdual_slow()
	{
		PLR_URDUAL_RELEASE_TIME = param1;
	}

	void ext_set_gender()
	{
		PLR_GENDER = GetGender(GetOwner());
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "set_cl_gender_race", GetGender(GetOwner()), GetEntityRace(GetOwner()));
		if (PLR_GENDER == "female")
		{
			ClientCommand(GetOwner(), "ms_clgender 1");
			SetModelBody(0, 2);
			SetModelBody(1, 2);
			SetModelBody(2, 2);
			SetModelBody(3, 2);
			PLR_SOUND_SWORDREADY = SOUNDSET_HF_SWORDREADY;
			PLR_SOUND_SHOUT1 = SOUNDSET_HF_SHOUT1;
			PLR_SOUND_JAB1 = SOUNDSET_HF_JAB1;
			PLR_SOUND_JAB2 = SOUNDSET_HF_JAB2;
			PLR_SOUND_BREATHFAST1 = SOUNDSET_HF_BREATHFAST1;
			PLR_SOUND_BREATHFAST2 = SOUNDSET_HF_BREATHFAST2;
			PLR_SOUND_BREATHFAST3 = SOUNDSET_HF_BREATHFAST3;
			PLR_SOUND_DEATH = SOUNDSET_HF_DEATH;
			PLR_SOUND_CHESTHIT1 = SOUNDSET_HF_CHESTHIT1;
			PLR_SOUND_STOMACHHIT1 = SOUNDSET_HF_STOMACHHIT1;
			PLR_SOUND_ARMHIT1 = SOUNDSET_HF_ARMHIT1;
			PLR_SOUND_LEGHIT1 = SOUNDSET_HF_LEGHIT1;
			PLR_SOUND_FALLPAIN1 = SOUNDSET_HF_FALLPAIN1;
			PLR_SOUND_FALLPAIN2 = SOUNDSET_HF_FALLPAIN2;
			PLR_SOUND_FALLPAIN3 = SOUNDSET_HF_FALLPAIN3;
			PLR_SOUND_FALLPAIN4 = SOUNDSET_HF_FALLPAIN4;
		}
		else
		{
			ClientCommand(GetOwner(), "ms_clgender 0");
			SetModelBody(0, 1);
			SetModelBody(1, 1);
			SetModelBody(2, 1);
			SetModelBody(3, 1);
			PLR_SOUND_SWORDREADY = SOUNDSET_HM_SWORDREADY;
			PLR_SOUND_SHOUT1 = SOUNDSET_HM_SHOUT1;
			PLR_SOUND_JAB1 = SOUNDSET_HM_JAB1;
			PLR_SOUND_JAB2 = SOUNDSET_HM_JAB2;
			PLR_SOUND_BREATHFAST1 = SOUNDSET_HM_BREATHFAST1;
			PLR_SOUND_BREATHFAST2 = SOUNDSET_HM_BREATHFAST2;
			PLR_SOUND_BREATHFAST3 = SOUNDSET_HM_BREATHFAST3;
			PLR_SOUND_DEATH = SOUNDSET_HM_DEATH;
			PLR_SOUND_CHESTHIT1 = SOUNDSET_HM_CHESTHIT1;
			PLR_SOUND_STOMACHHIT1 = SOUNDSET_HM_STOMACHHIT1;
			PLR_SOUND_ARMHIT1 = SOUNDSET_HM_ARMHIT1;
			PLR_SOUND_LEGHIT1 = SOUNDSET_HM_LEGHIT1;
			PLR_SOUND_FALLPAIN1 = SOUNDSET_HM_FALLPAIN1;
			PLR_SOUND_FALLPAIN2 = SOUNDSET_HM_FALLPAIN2;
			PLR_SOUND_FALLPAIN3 = SOUNDSET_HM_FALLPAIN3;
			PLR_SOUND_FALLPAIN4 = SOUNDSET_HM_FALLPAIN4;
		}
	}

	void ext_helm_expar()
	{
		ClientEvent("update", GetOwner(), GetEntityIndex(PLR_HELM_ID), "game_show", GetEntityRace(GetOwner()), GetGender(GetOwner()), "ext_helm_expar");
	}

	void ext_set_spiral()
	{
		string SPIRAL_TYPE = param1;
		SPIRAL_DMG = param2;
		SPIRAL_SKILL = "archery";
		if (SPIRAL_TYPE == "fire")
		{
			SPIRAL_DMG_TYPE = "fire_effect";
			SPIRAL_SPIRTE_FILE = "rjet1.spr";
			SPIRAL_SPRITE_FRAMES = 5;
			SPIRAL_SPRITE_SCALE = 0.75;
			SPIRAL_SPRITE_COLOR = Vector3(255, 255, 255);
			SPIRAL_GLOW_COLOR = Vector3(255, 0, 0);
		}
		if (SPIRAL_TYPE == "cold")
		{
			SPIRAL_DMG_TYPE = "cold_effect";
			SPIRAL_SPIRTE_FILE = "char_breath.spr";
			SPIRAL_SPRITE_FRAMES = 1;
			SPIRAL_SPRITE_SCALE = 2.5;
			SPIRAL_SPRITE_COLOR = Vector3(255, 255, 255);
			SPIRAL_GLOW_COLOR = Vector3(128, 128, 255);
		}
		if (SPIRAL_TYPE == "lightning")
		{
			SPIRAL_DMG_TYPE = "lightning_effect";
			SPIRAL_SPIRTE_FILE = "3dmflaora.spr";
			SPIRAL_SPRITE_FRAMES = 1;
			SPIRAL_SPRITE_SCALE = 0.5;
			SPIRAL_SPRITE_COLOR = Vector3(255, 255, 0);
			SPIRAL_GLOW_COLOR = Vector3(255, 255, 0);
		}
	}

	void ext_bear_mode()
	{
		if ((PLR_BEAR_MODE)) return;
		PLR_BEAR_IMAGE_ID = param1;
		PLR_BEAR_MODE = 1;
		ext_invis();
		SetScriptFlags(GetOwner(), "add", "bear", "nopush", 1, -1, "none");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 256, 10, 1, 256);
	}

	void ext_bear_mode_end()
	{
		if (!(PLR_BEAR_MODE)) return;
		PLR_BEAR_MODE = 0;
		ext_visible();
		SetScriptFlags(GetOwner(), "remove", "bear");
	}

	void ext_test()
	{
		LogDebug("test vent PARAM1 PARAM2 PARAM3 PARAM4");
	}

	void ext_block_weather()
	{
		PLR_WEATHER_BLOCK = param1;
	}

	void ext_stam()
	{
		DrainStamina(GetOwner());
	}

	void ext_stuck_adj()
	{
		if (!(GetGameTime() > PLR_NEXT_STUCK_ADJ)) return;
		PLR_NEXT_STUCK_ADJ = GetGameTime();
		PLR_NEXT_STUCK_ADJ += 5.0;
		string ADJ_ORG = GetEntityOrigin(GetOwner());
		ADJ_ORG += "z";
		string TRACE_START = ADJ_ORG;
		string TRACE_END = ADJ_ORG;
		TRACE_END += "z";
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (TRACE_LINE != TRACE_END)
		{
			SendColoredMessage(GetOwner(), "[/STUCK]: Not enough head room to adjust up.");
		}
		else
		{
			SetEntityOrigin(GetOwner(), ADJ_ORG);
		}
	}

	void ext_olof_setstatus()
	{
		PLR_OLOF_STATUS = param1;
		if (param1 == "reset")
		{
			PLR_OLOF_STATUS = "PLR_OLOF_STATUS";
		}
	}

	void ext_reset_model()
	{
		ext_set_gender();
		ScheduleDelayedEvent(0.1, "ext_setbodytype");
	}

	void ext_invis()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 1);
		CallExternal("all", "ext_render_items", GetEntityIndex(GetOwner()), 5, 0);
	}

	void ext_visible()
	{
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
		CallExternal("all", "ext_render_items", GetEntityIndex(GetOwner()), 0, 255);
	}

	void ext_acid_feaura_activate()
	{
		if ((PLR_FEAURA)) return;
		PLR_FEAURA = 1;
		PLR_FEAURA_DOT = param1;
		PLR_FEAURA_AOE = param2;
		GAME_PVP = "game.pvp";
		ClientEvent("new", "all", "effects/sfx_poison_aura", GetEntityIndex(GetOwner()), PLR_FEAURA_AOE, PLR_PAURA_CL_RATE);
		PLR_FEAURA_CLIDX = "game.script.last_sent_id";
		PLR_FEAURA_NEXT_CL = GetGameTime();
		PLR_FEAURA_NEXT_CL += PLR_PAURA_CL_RATE;
		acid_feaura_loop();
	}

	void acid_feaura_loop()
	{
		if (!(PLR_FEAURA)) return;
		ScheduleDelayedEvent(1.0, "acid_feaura_loop");
		string GAME_TIME = GetGameTime();
		if (GAME_TIME > PLR_FEAURA_NEXT_CL)
		{
			ClientEvent("new", "all", "effects/sfx_poison_aura", GetEntityIndex(GetOwner()), PLR_FEAURA_AOE, PLR_PAURA_CL_RATE);
			PLR_FEAURA_CLIDX = "game.script.last_sent_id";
			PLR_FEAURA_NEXT_CL = GAME_TIME;
			PLR_FEAURA_NEXT_CL += PLR_PAURA_CL_RATE;
		}
		if (!(IsEntityAlive(GetOwner()))) return;
		PLR_FEAURA_SCAN = FindEntitiesInSphere("enemy", PLR_FEAURA_AOE);
		if (!(PLR_FEAURA_SCAN != "none")) return;
		for (int i = 0; i < GetTokenCount(PLR_FEAURA_SCAN, ";"); i++)
		{
			acid_feaura_burn();
		}
	}

	void acid_feaura_burn()
	{
		string CUR_TARG = GetToken(PLR_FEAURA_SCAN, i, ";");
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(CUR_TARG)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IS_AFK))
		{
			ApplyEffect(CUR_TARG, "effects/dot_acid", 5.0, GetEntityIndex(GetOwner()), PLR_FEAURA_DOT, "spellcasting.affliction");
		}
	}

	void ext_acid_feaura_remove()
	{
		PLR_FEAURA = 0;
		ClientEvent("update", "all", PLR_FEAURA_CLIDX, "remove_me");
	}

	void ext_weather_change()
	{
		if (!(PLR_IN_WORLD)) return;
		PLR_WEATHER = param1;
		if (G_WEATHER_LOCK != 0)
		{
			PLR_WEATHER = G_WEATHER_LOCK;
		}
		else
		{
			if ((PLR_LOCK_CLEAR))
			{
			}
			PLR_WEATHER = "clear";
		}
		if (PLR_WEATHER == "storm")
		{
			PLR_WEATHER = "rain_storm";
		}
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "weather_change", PLR_WEATHER);
	}

	void ext_weather_force_change()
	{
		PLR_WEATHER = param1;
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "weather_force_change", param1);
	}

	void ext_repel_shield()
	{
		string L_DUR = param1;
		L_DUR("ext_end_repel_shield");
		PLR_REPEL_SHIELD_ACTIVE = 1;
		PLR_REPEL_SHIELD_RADIUS = param2;
		PLR_REPEL_SHIELD_SPECIAL = param3;
		GAME_PVP = "game.pvp";
		loop_repel_shield();
		if (PLR_REPEL_SHIELD_SPECIAL == "darkfire")
		{
			ClientEvent("new", "all", "effects/sfx_raura", GetEntityIndex(GetOwner()), L_DUR);
			PLR_DAURA_CL_IDX = "game.script.last_sent_id";
			// svplaysound: svplaysound 1 10  magic/chant_loop.wav
			EmitSound(1, 10, "magic/chant_loop.wav");
		}
	}

	void loop_repel_shield()
	{
		if (!(PLR_REPEL_SHIELD_ACTIVE)) return;
		ScheduleDelayedEvent(0.2, "loop_repel_shield");
		PLR_REPEL_SHIELD_TARGETS = FindEntitiesInSphere("enemy", PLR_REPEL_SHIELD_RADIUS);
		if (!(PLR_REPEL_SHIELD_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(PLR_REPEL_SHIELD_TARGETS, ";"); i++)
		{
			affect_targets_repel_shield();
		}
	}

	void affect_targets_repel_shield()
	{
		string CUR_TARG = GetToken(PLR_REPEL_SHIELD_TARGETS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (PLR_REPEL_SHIELD_SPECIAL == "darkfire")
		{
			string SHADOW_DMG = GetSkillLevel(GetOwner(), "spellcasting.affliction");
			ApplyEffect(CUR_TARG, "effects/dot_dark", 5, GetEntityIndex(GetOwner()), SHADOW_DMG, "swordsmanship");
		}
		string TARG_HP = GetEntityHealth(CUR_TARG);
		string MY_HP_X = GetEntityMaxHealth(GetOwner());
		MY_HP_X *= 4;
		if (TARG_HP < 1500)
		{
			int DO_PUSH = 1;
		}
		if (TARG_HP < MY_HP_X)
		{
			int DO_PUSH = 1;
		}
		if (!(DO_PUSH)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		if (GetGameTime() > NEXT_REPEL_SHIELD_SOUND)
		{
			NEXT_REPEL_SHIELD_SOUND = GetGameTime();
			NEXT_REPEL_SHIELD_SOUND += 0.5;
			EmitSound(GetOwner(), 0, "doors/aliendoor3.wav", 5);
		}
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

	void ext_end_repel_shield()
	{
		if (PLR_REPEL_SHIELD_SPECIAL == "darkfire")
		{
			ClientEvent("update", "all", PLR_DAURA_CL_IDX, "remove_fx");
			// svplaysound: svplaysound 1 0 magic/chant_loop.wav
			EmitSound(1, 0, "magic/chant_loop.wav");
		}
		PLR_REPEL_SHIELD_ACTIVE = 0;
	}

	void ext_set_dark_level()
	{
		PLR_DARK_LEVEL = param1;
		SetPlayerQuestData(GetOwner(), "dl");
		CallExternal(GetOwner(), "player_calc_holy_resistance");
	}

	void ext_tossprojectile()
	{
		TossProjectile(param1, param2, param3, param4, param5, param6, param7, param8, param9);
		PLR_LAST_PROJECTILE = GetEntityIndex("ent_lastprojectile");
	}

	void ext_sfaura_start()
	{
		PLR_SFAURA_SIZE = 65;
		PLR_SFAURA_ITEM = param1;
		GAME_PVP = "game.pvp";
		PLR_SFAURA_DOT = GetSkillLevel(GetOwner(), "spellcasting.fire");
		PLR_SFAURA_DOT *= 0.5;
		PLR_SFAURA_MAXPUSH = GetEntityMaxHealth(GetOwner());
		PLR_SFAURA_MAXPUSH *= 4;
		string SIZE_RATIO = PLR_SFAURA_SIZE;
		SIZE_RATIO /= PLR_SFAURA_MAXSIZE;
		ClientEvent("new", "all", "effects/sfx_sfaura", GetEntityIndex(GetOwner()), SIZE_RATIO, 20.0);
		PLR_SFAURA_CL_IDX = "game.script.last_sent_id";
		// svplaysound: svplaysound 1 10 ambience/rocketrumble1.wav
		EmitSound(1, 10, "ambience/rocketrumble1.wav");
		PLR_SFAURA_ACTIVE = 1;
		sfaura_loop();
		ScheduleDelayedEvent(20.0, "sfaura_fx_refresh");
	}

	void sfaura_loop()
	{
		if (!(PLR_SFAURA_ACTIVE)) return;
		if (GetEntityMP(GetOwner()) <= 10)
		{
			SendColoredMessage(GetOwner(), "Shadowfire Blade: Insufficient mana for Shadowfire Aura");
			ext_sfaura_end();
		}
		if ((EXIT_SUB)) return;
		ScheduleDelayedEvent(0.2, "sfaura_loop");
		GiveMP(GetOwner());
		if (PLR_SFAURA_SIZE < PLR_SFAURA_MAXSIZE)
		{
			PLR_SFAURA_SIZE += PLR_SFAURA_GROWTH_RATE;
		}
		if (PLR_SFAURA_SIZE > PLR_SFAURA_MAXSIZE)
		{
			PLR_SFAURA_SIZE = PLR_SFAURA_MAXSIZE;
		}
		PLR_SFAURA_TARGS = FindEntitiesInSphere("enemy", PLR_SFAURA_SIZE);
		if (!(PLR_SFAURA_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(PLR_SFAURA_TARGS, ";"); i++)
		{
			sfaura_affect_targets();
		}
	}

	void sfaura_affect_targets()
	{
		string CUR_TARG = GetToken(PLR_SFAURA_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TRACE_START = GetEntityOrigin(GetOwner());
		string TRACE_END = GetEntityOrigin(CUR_TARG);
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), PLR_SFAURA_DOT, "swordsmanship");
		float RESIST_ROLL = 1.0;
		RESIST_ROLL -= Random(0, 1.0);
		string FIRE_RESIST = /* TODO: $get_takedmg */ $get_takedmg(CUR_TARG, "fire");
		if (!(RESIST_ROLL < FIRE_RESIST)) return;
		if (GetGameTime() > PLR_NEXT_FSAURA_SOUND)
		{
			PLR_NEXT_FSAURA_SOUND = GetGameTime();
			PLR_NEXT_FSAURA_SOUND += 1.0;
			EmitSound(GetOwner(), 0, "ambience/flameburst1.wav", 5);
		}
		if (GetEntityHealth(CUR_TARG) < 1500)
		{
			int DO_PUSH = 1;
		}
		if (GetEntityHealth(CUR_TARG) < PLR_SFAURA_MAXPUSH)
		{
			int DO_PUSH = 1;
		}
		if (!(DO_PUSH)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

	void sfaura_fx_refresh()
	{
		if (!(PLR_SFAURA_ACTIVE)) return;
		string SIZE_RATIO = PLR_SFAURA_SIZE;
		SIZE_RATIO /= PLR_SFAURA_MAXSIZE;
		// svplaysound: svplaysound 1 10 ambience/rocketrumble1.wav
		EmitSound(1, 10, "ambience/rocketrumble1.wav");
		ClientEvent("new", "all", "effects/sfx_sfaura", GetEntityIndex(GetOwner()), SIZE_RATIO, 20.0);
		PLR_SFAURA_CL_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(20.0, "sfaura_fx_refresh");
	}

	void ext_sfaura_end()
	{
		// svplaysound: svplaysound 1 0 ambience/rocketrumble1.wav
		EmitSound(1, 0, "ambience/rocketrumble1.wav");
		PLR_SFAURA_ACTIVE = 0;
		ClientEvent("update", "all", PLR_SFAURA_CL_IDX, "remove_fx");
		if (param1 != "remote")
		{
			CallExternal(PLR_SFAURA_ITEM, "ext_faura_ended");
		}
	}

	void ext_toss_spear()
	{
		PLR_SPEAR_CHARGE_LEVEL = param1;
		TossProjectile(param2, param3, param4, param5, param6, param7, param8);
		PLR_LAST_PROJECTILE = GetEntityIndex("ent_lastprojectile");
	}

	void ext_holy_aura()
	{
		if ((PLR_HAURA_ACTIVE)) return;
		string L_DUR = param1;
		L_DUR("ext_end_holy_aura");
		PLR_HAURA_ACTIVE = 1;
		PLR_HAURA_RADIUS = param2;
		PLR_HAURA_POWER = param3;
		loop_holy_aura();
		// svplaysound: svplaysound 2 10 ambience/alien_powernode.wav
		EmitSound(2, 10, "ambience/alien_powernode.wav");
		string L_AURA_SIZE = PLR_HAURA_RADIUS;
		L_AURA_SIZE *= 1.5;
		int L_AURA_MDL_OFS = 25;
		if (PLR_HAURA_RADIUS > 256)
		{
			L_AURA_MDL_OFS += 1;
		}
		ClientEvent("new", "all", "effects/sfx_seal_follow", GetEntityIndex(GetOwner()), 10.0, L_AURA_MDL_OFS, 1, Vector3(255, 200, 0), L_AURA_SIZE);
		PLR_HAURA_CL_ID = "game.script.last_sent_id";
		ScheduleDelayedEvent(10.0, "holy_aura_refresh");
	}

	void holy_aura_refresh()
	{
		if (!(PLR_HAURA_ACTIVE)) return;
		string L_AURA_SIZE = PLR_HAURA_RADIUS;
		L_AURA_SIZE *= 1.5;
		int L_AURA_MDL_OFS = 25;
		if (PLR_HAURA_RADIUS > 256)
		{
			L_AURA_MDL_OFS += 1;
		}
		ClientEvent("new", "all", "effects/sfx_seal_follow", GetEntityIndex(GetOwner()), 10.0, L_AURA_MDL_OFS, 1, Vector3(255, 200, 0), L_AURA_SIZE);
		PLR_HAURA_CL_ID = "game.script.last_sent_id";
		ScheduleDelayedEvent(10.0, "holy_aura_refresh");
	}

	void loop_holy_aura()
	{
		if (!(PLR_HAURA_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "loop_holy_aura");
		PLR_HAURA_TARGETS = FindEntitiesInSphere("any", PLR_HAURA_RADIUS);
		if (!(PLR_HAURA_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(PLR_HAURA_TARGETS, ";"); i++)
		{
			affect_targets_holy_aura();
		}
	}

	void affect_targets_holy_aura()
	{
		string CUR_TARG = GetToken(PLR_HAURA_TARGETS, i, ";");
		if (GetRelationship(CUR_TARG) == "ally")
		{
			int HEAL_TARGET = 1;
		}
		if ((IsValidPlayer(CUR_TARG)))
		{
			int HEAL_TARGET = 1;
		}
		if ((GetEntityProperty(CUR_TARG, "scriptvar")))
		{
			if (!(IsValidPlayer(CUR_TARG)))
			{
			}
			int HEAL_TARGET = 0;
		}
		if ((HEAL_TARGET))
		{
			ApplyEffect(CUR_TARG, "effects/effect_rejuv2", 0, PLR_HAURA_POWER, GetEntityIndex(GetOwner()));
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string NME_UNHOLY = /* TODO: $get_takedmg */ $get_takedmg(CUR_TARG, "holy");
		if (!(NME_UNHOLY > 0)) return;
		if (!(/* TODO: $can_damage */ $can_damage(CUR_TARG, GetOwner()))) return;
		string TARG_HP = GetEntityHealth(CUR_TARG);
		string MY_HP_X = GetSkillLevel(GetOwner(), "spellcasting.divination");
		MY_HP_X *= 100;
		if (TARG_HP < 1500)
		{
			int DO_PUSH = 1;
		}
		if (TARG_HP < MY_HP_X)
		{
			int DO_PUSH = 1;
		}
		if (!(DO_PUSH)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		if (GetGameTime() > NEXT_HAURA_SOUND)
		{
			NEXT_HAURA_SOUND = GetGameTime();
			NEXT_HAURA_SOUND += 0.5;
			EmitSound(GetOwner(), 0, "doors/aliendoor3.wav", 5);
		}
		int PUSH_STR = 300;
		PUSH_STR *= NME_UNHOLY;
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, PUSH_STR, 0)));
	}

	void ext_end_holy_aura()
	{
		if ((PLR_HAURA_ACTIVE))
		{
			// svplaysound: svplaysound 2 0 ambience/alien_powernode.wav
			EmitSound(2, 0, "ambience/alien_powernode.wav");
			ClientEvent("update", "all", PLR_HAURA_CL_ID, "remove_fx");
		}
		PLR_HAURA_ACTIVE = 0;
	}

	void ext_setskin()
	{
		SetProp(GetOwner(), "skin", param1);
	}

	void ext_pole_lshield()
	{
		if ((PLR_PLSHIELD_ACTIVE)) return;
		PLR_PLSHIELD_ACTIVE = 1;
		PLR_PLSHIELD_DOT = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		PLR_PLSHIELD_DOT *= 0.25;
		PLR_PLSHIELD_PUSH = 500;
		GAME_PVP = "game.pvp";
		ClientEvent("new", "all", "items/polearms_ph_spin_cl", GetEntityIndex(GetOwner()));
		PLR_PLSHIELD_CL_IDX = "game.script.last_sent_id";
		// svplaysound: svplaysound 1 10 magic/bolt_loop.wav
		EmitSound(1, 10, "magic/bolt_loop.wav");
		pole_lshield_loop();
	}

	void pole_lshield_loop()
	{
		if (!(PLR_PLSHIELD_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "pole_lshield_loop");
		GiveMP(GetOwner());
		if (GetEntityMP(GetOwner()) <= 1)
		{
			SendColoredMessage(GetOwner(), "Stormpharaoh's Lance: Insufficient mana for Lightning Shield");
			ext_pole_lshield_end("mana");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string SCAN_LOC = GetEntityOrigin(GetOwner());
		OWNER_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		SCAN_LOC += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, 64, 0));
		PLR_PLSHIELD_TARGETS = FindEntitiesInSphere("enemy", 64);
		if (!(PLR_PLSHIELD_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(PLR_PLSHIELD_TARGETS, ";"); i++)
		{
			pole_lshield_affect_targets();
		}
	}

	void pole_lshield_affect_targets()
	{
		string CUR_TARGET = GetToken(PLR_PLSHIELD_TARGETS, i, ";");
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(CUR_TARGET)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string PUSH_STR = PLR_PLSHIELD_PUSH;
		PUSH_STR *= /* TODO: $get_takedmg */ $get_takedmg(CUR_TARGET, "lightning");
		AddVelocity(CUR_TARGET, /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, PUSH_STR, 10)));
		ApplyEffect(CUR_TARGET, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), PLR_PLSHIELD_DOT);
		if (GetGameTime() > NEXT_PLSHIELD_SOUND)
		{
			NEXT_PLSHIELD_SOUND = GetGameTime();
			NEXT_PLSHIELD_SOUND += 0.5;
			EmitSound(GetOwner(), 2, "magic/bolt_end.wav", 5);
		}
	}

	void ext_pole_lshield_end()
	{
		if ((PLR_PLSHIELD_ACTIVE))
		{
			// svplaysound: svplaysound 1 0 magic/bolt_loop.wav
			EmitSound(1, 0, "magic/bolt_loop.wav");
			ClientEvent("update", "all", PLR_PLSHIELD_CL_IDX, "end_fx");
		}
		PLR_PLSHIELD_ACTIVE = 0;
	}

	void svilla_music()
	{
		LogDebug("svilla_music G_SORCV_FRIENDLY");
		if ((G_SORCV_FRIENDLY))
		{
			// TODO: playmp3 ent_me combat PathAnubis.mp3
		}
		else
		{
			// TODO: playmp3 ent_me combat crimson_field.mp3
		}
	}

	void svilla_music2()
	{
		LogDebug("svilla_music2 G_SORCV_FRIENDLY");
		if ((G_SORCV_FRIENDLY))
		{
			// TODO: playmp3 ent_me combat haunted_desert.mp3
		}
		else
		{
			// TODO: playmp3 ent_me combat crimson_field.mp3
		}
	}

	void ext_stop_music()
	{
		// TODO: playmp3 ent_me stop
	}

	void ext_svilla_hostile()
	{
		SetGlobalVar("G_SORCV_FRIENDLY", 0);
	}

	void ext_weather_set_clear()
	{
		PLR_LOCK_CLEAR = 1;
		ext_weather_change("clear");
	}

	void ext_weather_manual_change()
	{
		PLR_LOCK_CLEAR = 0;
		string NEW_WEATHER = param1;
		ext_weather_change(NEW_WEATHER);
	}

	void trig_srocv_player_on_shelf()
	{
		string ALCH_ID = FindEntityByName("sorc_alchie");
		CallExternal(ALCH_ID, "ext_player_on_shelf");
	}

	void trig_srocv_player_on_table()
	{
		string ALCH_ID = FindEntityByName("sorc_alchie");
		CallExternal(ALCH_ID, "ext_player_on_table");
	}

	void ext_bravery()
	{
		SendColoredMessage(GetOwner(), "You will take no penalty for your next death");
		PLR_BRAVERY = 1;
		EmitSound(GetOwner(), 0, "voices/human/male_guard_hail.wav", 10);
	}

	void ext_dmg_adjust()
	{
		if (param1 == "fire")
		{
			PLR_DMG_ADJUST_FIRE = param2;
		}
	}

	void ext_dmg_add_dot()
	{
		if (param1 == "fire")
		{
			PLR_ADD_FIRE_DOT = param2;
		}
	}

	void trig_damage()
	{
		string TRIG_NAME = param1;
		string TRIG_DMG = param2;
		string TRIG_DMG_TYPE = param3;
		TRIG_DMG_TYPE += "_effect";
		CallExternal(GAME_MASTER, "gm_setname", TRIG_NAME);
		XDoDamage(GetOwner(), "direct", TRIG_DMG, 1.0, GAME_MASTER, GAME_MASTER, "none", TRIG_DMG_TYPE);
	}

	void ext_playrandomsound()
	{
		if (param5 == "PARAM5")
		{
			// PlayRandomSound from: param2, param3, param4
			array<string> sounds = {param2, param3, param4};
			EmitSound(GetOwner(), param1, sounds[RandomInt(0, sounds.length() - 1)], 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (param6 == "PARAM6")
		{
			// PlayRandomSound from: param2, param3, param4, param5
			array<string> sounds = {param2, param3, param4, param5};
			EmitSound(GetOwner(), param1, sounds[RandomInt(0, sounds.length() - 1)], 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (param7 == "PARAM7")
		{
			// PlayRandomSound from: param2, param3, param4, param5, param6
			array<string> sounds = {param2, param3, param4, param5, param6};
			EmitSound(GetOwner(), param1, sounds[RandomInt(0, sounds.length() - 1)], 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (param8 == "PARAM8")
		{
			// PlayRandomSound from: param2, param3, param4, param5, param6, param7
			array<string> sounds = {param2, param3, param4, param5, param6, param7};
			EmitSound(GetOwner(), param1, sounds[RandomInt(0, sounds.length() - 1)], 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (param9 == "PARAM9")
		{
			// PlayRandomSound from: param2, param3, param4, param5, param6, param7, param8
			array<string> sounds = {param2, param3, param4, param5, param6, param7, param8};
			EmitSound(GetOwner(), param1, sounds[RandomInt(0, sounds.length() - 1)], 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		// PlayRandomSound from: param2, param3, param4, param5, param6, param7, param8, param9
		array<string> sounds = {param2, param3, param4, param5, param6, param7, param8, param9};
		EmitSound(GetOwner(), param1, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void ext_orcfor_boss_musak()
	{
		if (param1 == 1)
		{
			PLR_ORCFOR_MUSIC = 1;
			// TODO: playmp3 ent_me combat seruboss1.mp3
		}
		if (param1 == 2)
		{
			if (PLR_ORCFOR_MUSIC != 2)
			{
			}
			PLR_ORCFOR_MUSIC = 2;
			// TODO: playmp3 ent_me combat seruboss2.mp3
		}
		if (param1 == 3)
		{
			string MY_ORG = GetEntityOrigin(GetOwner());
			string BOSS_ORG = param2;
			if (Distance(MY_ORG, BOSS_ORG) < 768)
			{
			}
			// TODO: playmp3 ent_me stop
		}
	}

	void ext_gabe_musak()
	{
		if (param1 == "stop")
		{
			// TODO: playmp3 ent_me stop
		}
		else
		{
			// TODO: playmp3 ent_me combat gabe1.mp3
		}
	}

	void ext_changelevel_prep()
	{
		ext_weather_force_change("clear");
	}

	void ext_bank_lock()
	{
		ApplyEffect(GetOwner(), "effects/effect_templock");
		ScheduleDelayedEvent(1.0, "ext_bank_lock_release");
	}

	void ext_bank_lock_release()
	{
		CallExternal(GetOwner(), "ext_end_templock");
	}

	void ext_alance_init()
	{
		GAME_PVP = "game.pvp";
		AFL_BURST_DOT = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		AFL_BURST_DOT *= 0.75;
	}

	void alance_dodamage()
	{
		if (!(param1)) return;
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(param2)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(param2, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), AFL_BURST_DOT);
		string TARG_HP = GetEntityHealth(param2);
		string MY_HP_X = GetEntityMaxHealth(GetOwner());
		MY_HP_X *= 4;
		if (TARG_HP < 1500)
		{
			int DO_PUSH = 1;
		}
		if (TARG_HP < MY_HP_X)
		{
			int DO_PUSH = 1;
		}
		if (!(DO_PUSH)) return;
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

	void ext_drainstamina()
	{
		DrainStamina(GetOwner());
	}

	void ext_clbeam()
	{
		string BEAM_TARG = FindEntitiesInSphere("enemy", 1024);
		string BEAM_TARG = GetToken(BEAM_TARG, 0, ";");
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "set_test_beam", GetEntityIndex(GetOwner()), GetEntityIndex(BEAM_TARG));
	}

	void ext_repel_burst()
	{
		string AOE_DMG = param1;
		string AOE_RAD = param2;
		string AOE_FAL = param3;
		string DMG_TYPE = param4;
		string DMG_SKILL = param5;
		PLR_REPEL_PUSH_STR = param6;
		PLR_REPEL_MAX_HP = param7;
		PLR_REPEL_ORG = param8;
		if ((PLR_REPEL_ORG).findFirst("(") == 0)
		{
			PLR_REPEL_ORG = GetEntityOrigin(GetOwner());
		}
		XDoDamage(PLR_REPEL_ORG, AOE_RAD, AOE_DMG, AOE_FAL, GetOwner(), GetOwner(), DMG_SKILL, DMG_TYPE, "dmgevent:repel");
	}

	void repel_dodamage()
	{
		if (!(param1)) return;
		ext_repel(param2, PLR_REPEL_ORG, PLR_REPEL_PUSH_STR, 110, PLR_REPEL_MAX_HP, 0);
	}

	void ext_repel()
	{
		string L_TARG = param1;
		string L_TARG_ORG = GetEntityOrigin(param1);
		string L_ORG = param2;
		string L_PUSHVEL = param3;
		string L_VPUSHVEL = param4;
		string L_MAXHP = param5;
		string L_OVERRIDE = param6;
		LogDebug("ext_repel vel L_PUSHVEL max L_MAXHP vs. GetEntityHealth(L_TARG) [ GetEntityName(L_TARG) ]");
		if (L_MAXHP > 0)
		{
			string L_TARG_HP = GetEntityHealth(L_TARG);
			if (L_TARG_HP > L_MAXHP)
			{
				return;
			}
			if (L_TARG_HP > /* TODO: $math(multiply) */ L_MAXHP)
			{
			}
			int L_RATIO = 1;
			L_RATIO -= /* TODO: $math(divide) */ L_TARG_HP;
			L_PUSHVEL *= L_RATIO;
		}
		LogDebug("ext_repel fvel L_PUSHVEL");
		string L_NEW_ANG = /* TODO: $angles */ $angles(L_ORG, L_TARG_ORG);
		if ((L_OVERRIDE))
		{
			AddVelocity(L_TARG, /* TODO: $relvel */ $relvel(Vector3(0, L_NEW_ANG, 0), Vector3(0, L_PUSHVEL, L_VPUSHVEL)));
		}
		else
		{
			AddVelocity(L_TARG, /* TODO: $relvel */ $relvel(Vector3(0, L_NEW_ANG, 0), Vector3(0, L_PUSHVEL, L_VPUSHVEL)));
		}
	}

	void ext_lcod()
	{
		PLR_LCOD_POS = param1;
		PLR_LCOD_DMG = param2;
		PLR_LCOD_DUR = param3;
		string CL_POS = PLR_LCOD_POS;
		CL_POS = "z";
		EmitSound3D("magic/pulsemachine_noloop.wav", 8, PLR_LCOD_POS, 0.8, 5, 100);
		PLR_NEXT_LCOD_SOUND = GetGameTime();
		PLR_NEXT_LCOD_SOUND += 1.88;
		ClientEvent("new", "all", "effects/sfx_cod", CL_POS, PLR_LCOD_DUR, 3, 98);
		PLR_LCOD_ACTIVE = 1;
		lcod_loop();
		PLR_LCOD_DUR("lcod_end");
	}

	void lcod_loop()
	{
		if (!(PLR_LCOD_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "lcod_loop");
		XDoDamage(PLR_LCOD_POS, PLR_LCOD_AOE, PLR_LCOD_DMG, 0, GetOwner(), GetOwner(), "spellcasting.affliction", "dark_effect");
		if (!(GetGameTime() > PLR_NEXT_LCOD_SOUND)) return;
		EmitSound3D("magic/pulsemachine_noloop.wav", 8, PLR_LCOD_POS, 0.8, 5, 100);
		PLR_NEXT_LCOD_SOUND = GetGameTime();
		PLR_NEXT_LCOD_SOUND += 1.88;
	}

	void lcod_end()
	{
		PLR_LCOD_ACTIVE = 0;
	}

	void ext_gcod()
	{
		PLR_GCOD_POS = param1;
		PLR_GCOD_DMG = param2;
		PLR_GCOD_DUR = param3;
		string CL_POS = PLR_GCOD_POS;
		CL_POS = "z";
		EmitSound3D("magic/pulsemachine_noloop.wav", 10, PLR_GCOD_POS, 0.8, 3, 100);
		PLR_NEXT_GCOD_SOUND = GetGameTime();
		PLR_NEXT_GCOD_SOUND += 1.88;
		ClientEvent("new", "all", "effects/sfx_cod", CL_POS, PLR_GCOD_DUR, 5, 196);
		PLR_GCOD_ACTIVE = 1;
		gcod_loop();
		PLR_GCOD_DUR("gcod_end");
	}

	void gcod_loop()
	{
		if (!(PLR_GCOD_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "gcod_loop");
		XDoDamage(PLR_GCOD_POS, PLR_GCOD_AOE, PLR_GCOD_DMG, 0, GetOwner(), GetOwner(), "spellcasting.affliction", "dark_effect");
		if (!(GetGameTime() > PLR_NEXT_GCOD_SOUND)) return;
		EmitSound3D("magic/pulsemachine_noloop.wav", 10, PLR_GCOD_POS, 0.8, 3, 100);
		PLR_NEXT_GCOD_SOUND = GetGameTime();
		PLR_NEXT_GCOD_SOUND += 1.88;
	}

	void gcod_end()
	{
		PLR_GCOD_ACTIVE = 0;
	}

	void ext_wraith_active()
	{
		PLR_WRAITH_ACTIVE = param1;
	}

	void ext_fissure()
	{
		string MY_YAW = GetEntityProperty(GetOwner(), "viewangles");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_YAW);
		FISSURE_YAW = MY_YAW;
		FISSURE_START = GetEntityOrigin(GetOwner());
		FISSURE_END = FISSURE_START;
		FISSURE_END += /* TODO: $relpos */ $relpos(Vector3(0, FISSURE_YAW, 0), Vector3(0, 768, 0));
		FISSURE_END = "z";
		FISSURE_END += "z";
		string TRACE_LINE = TraceLine(FISSURE_START, FISSURE_END);
		if ((G_DEVELOPER_MODE))
		{
			Effect("beam", "point", "lgtning.spr", 10, FISSURE_START, FISSURE_END, Vector3(255, 0, 255), 255, 0, 10);
		}
		FISSURE_LENGTH = Distance(FISSURE_START, FISSURE_END);
		FISSURE_COUNT = 0;
		FISSURE_ACTIVE = 1;
		FISSURE_DMG = GetSkillLevel(GetOwner(), "spellcasting.fire");
		int NO_ROCKS = 0;
		if (G_FISSURES == "G_FISSURES")
		{
			SetGlobalVar("G_FISSURES", 0);
		}
		G_FISSURES += 1;
		if (G_FISSURES > 1)
		{
			int NO_ROCKS = 1;
		}
		ClientEvent("new", "all", "effects/sfx_fissure", FISSURE_START, FISSURE_YAW, FISSURE_END, FISSURE_LENGTH, NO_ROCKS);
		FISSURE_COUNT = 0;
		FISSURE_MAX_COUNT = /* TODO: $math(divide) */ FISSURE_LENGTH;
		if (FISSURE_MAX_COUNT < 1)
		{
			FISSURE_MAX_COUNT = 1;
		}
		FISSURE_ORG = FISSURE_START;
		FISSURE_DIR = (FISSURE_END - FISSURE_ORG).Normalize();
		fissure_loop();
	}

	void fissure_loop()
	{
		FISSURE_COUNT += 1;
		string L_FISSURE_CHECK_POS = FISSURE_ORG;
		string L_FISSURE_MOVEAMT = FISSURE_DIR;
		L_FISSURE_MOVEAMT *= /* TODO: $math(multiply) */ 78;
		L_FISSURE_CHECK_POS += L_FISSURE_MOVEAMT;
		L_FISSURE_CHECK_POS += "z";
		L_FISSURE_CHECK_POS = "z";
		XDoDamage(L_FISSURE_CHECK_POS, 78, FISSURE_DMG, 1.0, GetOwner(), GetOwner(), "spellcasting.fire", "fire_effect", "dmgevent:fissure");
		if (FISSURE_COUNT < FISSURE_MAX_COUNT)
		{
			ScheduleDelayedEvent(0.20, "fissure_loop");
		}
		else
		{
			G_FISSURES -= 1;
		}
		if ((G_DEVELOPER_MODE))
		{
			string L_VEC_UP = L_FISSURE_CHECK_POS;
			L_VEC_UP += "z";
			Effect("beam", "point", "lgtning.spr", 10, L_FISSURE_CHECK_POS, L_VEC_UP, Vector3(255, 0, 255), 255, 0, 5);
		}
	}

	void fissure_dodamage()
	{
		if (!(param1)) return;
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(param2)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), FISSURE_DMG);
		string TARG_HP = GetEntityHealth(param2);
		string MAX_HP_PUSH = GetEntityMaxHealth(GetOwner());
		MAX_HP_PUSH *= 3;
		if (MAX_HP_PUSH < 2000)
		{
			int MAX_HP_PUSH = 2000;
		}
		if (!(TARG_HP < MAX_HP_PUSH)) return;
		string RND_RL = RandomInt(1, 2);
		if (RND_RL == 1)
		{
			int RND_RL = 400;
		}
		if (RND_RL == 2)
		{
			int RND_RL = -400;
		}
		SetVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, FISSURE_YAW, 0), Vector3(RND_RL, 0, 110)));
	}

	void ext_summon_unique()
	{
		if (PLR_UNIQUE_SUMMONS.length() > 0) PLR_UNIQUE_SUMMONS += ";";
		PLR_UNIQUE_SUMMONS += param1;
	}

	void ext_unsummon_unique()
	{
		string TOKEN_IDX = FindToken(PLR_UNIQUE_SUMMONS, param1, ";");
		RemoveToken(PLR_UNIQUE_SUMMONS, TOKEN_IDX, ";");
	}

	void ext_epilepsy_time_begin()
	{
		// TODO: hud.addimgicon ent_me bepilepsy2 bepilepsy2 15 20 75 60 0.25
		PLR_EPILEPSY_ACTIVE = 1;
		PLR_EPILEPSY_COUNT = 0;
		PLR_EPILEPSY_DELAY = 0.5;
		// TODO: playmp3 ent_me combat b-b-b-beetlejuice.mp3
		ScheduleDelayedEvent(0.25, "epilepsy_loop");
		// TODO: hud.addimgicon ent_me bepilepsy1 bepilepsy1 15 20 75 60 4.0
	}

	void epilepsy_loop()
	{
		if (!(PLR_EPILEPSY_ACTIVE)) return;
		PLR_EPILEPSY_DELAY("epilepsy_loop");
		string L_DUR = PLR_EPILEPSY_DELAY;
		L_DUR *= 0.5;
		// TODO: hud.addimgicon ent_me bepilepsy2 bepilepsy2 15 20 75 60 L_DUR
		PLR_EPILEPSY_COUNT += 0.5;
		if (PLR_EPILEPSY_COUNT > 4)
		{
			// TODO: hud.addimgicon ent_me bepilepsy1 bepilepsy1 15 20 75 60 1.0
			PLR_EPILEPSY_DELAY = 0.05;
		}
		if (PLR_EPILEPSY_COUNT > 25)
		{
			PLR_EPILEPSY_ACTIVE = 0;
		}
	}

	void ext_epilepsy_time_end()
	{
		// TODO: playmp3 ent_me combat UndeadX1Fortress.mp3
	}

	void ext_summon_register_pet()
	{
		if (PLR_ACTIVE_PETS == "PLR_ACTIVE_PETS")
		{
			PLR_ACTIVE_PETS = "";
		}
		if (PLR_ACTIVE_PET_TYPES == "PLR_ACTIVE_PET_TYPES")
		{
			PLR_ACTIVE_PET_TYPES = "";
		}
		if (PLR_ACTIVE_PETS.length() > 0) PLR_ACTIVE_PETS += ";";
		PLR_ACTIVE_PETS += GetEntityIndex(param1);
		if (PLR_ACTIVE_PET_TYPES.length() > 0) PLR_ACTIVE_PET_TYPES += ";";
		PLR_ACTIVE_PET_TYPES += GetEntityProperty(param1, "scriptvar");
		if (PLR_N_ACTIVE_PETS == "PLR_N_ACTIVE_PETS")
		{
			PLR_N_ACTIVE_PETS = 1;
		}
		else
		{
			PLR_N_ACTIVE_PETS += 1;
		}
	}

	void ext_summon_pets_new()
	{
		PLR_SUMMON_MENU_DISABLE = GetGameTime();
		PLR_SUMMON_MENU_DISABLE += 5.0;
		if (PLR_ACTIVE_PETS == "PLR_ACTIVE_PETS")
		{
			PLR_ACTIVE_PETS = "";
		}
		if (PLR_ACTIVE_PET_TYPES == "PLR_ACTIVE_PET_TYPES")
		{
			PLR_ACTIVE_PET_TYPES = "";
		}
		string SUMMON_SCRIPT = "monsters/companion/";
		SUMMON_SCRIPT += param2;
		string MY_YAW = GetEntityProperty(GetOwner(), "viewangles");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_YAW);
		string SUMMON_POS = GetEntityOrigin(GetOwner());
		SUMMON_POS += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 128, 0));
		SUMMON_POS = "z";
		SpawnNPC(SUMMON_SCRIPT, SUMMON_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		string reg.npcmove.endpos = SUMMON_POS;
		reg.npcmove.endpos += "z";
		int reg.npcmove.testonly = 0;
		NpcMove(m_hLastCreated, "none");
		if ("game.ret.npcmove.dist" <= 0)
		{
			PLR_SUMMON_MENU_DISABLE = GetGameTime();
			SendColoredMessage(GetOwner(), "You cannot summon pet here");
			DeleteEntity(m_hLastCreated);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (PLR_ACTIVE_PETS.length() > 0) PLR_ACTIVE_PETS += ";";
		PLR_ACTIVE_PETS += GetEntityIndex(m_hLastCreated);
		if (PLR_ACTIVE_PET_TYPES.length() > 0) PLR_ACTIVE_PET_TYPES += ";";
		PLR_ACTIVE_PET_TYPES += GetEntityProperty(m_hLastCreated, "scriptvar");
		if (PLR_N_ACTIVE_PETS == "PLR_N_ACTIVE_PETS")
		{
			PLR_N_ACTIVE_PETS = 1;
		}
		else
		{
			PLR_N_ACTIVE_PETS += 1;
		}
	}

	void ext_unsummon_pets_new()
	{
		PLR_SUMMON_MENU_DISABLE = GetGameTime();
		PLR_SUMMON_MENU_DISABLE += 5.0;
		string PET_ID = param2;
		string PET_IDX = FindToken(PLR_ACTIVE_PETS, PET_ID, ";");
		RemoveToken(PLR_ACTIVE_PETS, PET_IDX, ";");
		string PET_TYPE = GetEntityProperty(PET_ID, "scriptvar");
		string PET_TYPE_IDX = FindToken(PLR_ACTIVE_PET_TYPES, PET_TYPE, ";");
		RemoveToken(PLR_ACTIVE_PET_TYPES, PET_TYPE_IDX, ";");
		PLR_N_ACTIVE_PETS -= 1;
		if ((param3)) return;
		CallExternal(PET_ID, "companion_unsummon");
	}

	void ext_ice_staff_on()
	{
		// svplaysound: svplaysound 2 10 magic/freezeray_loop.wav
		EmitSound(2, 10, "magic/freezeray_loop.wav");
	}

	void ext_ice_staff_off()
	{
		// svplaysound: svplaysound 2 0 magic/freezeray_loop.wav
		EmitSound(2, 0, "magic/freezeray_loop.wav");
	}

	void ext_register_fists()
	{
		LogDebug("ext_register_fists");
		PLR_FISTS_ID = param1;
	}

	void ext_lesser_leadfoot()
	{
		SetDamageResistance("stun", param1);
		PLR_LESSER_LEADFOOT = 1;
		PLR_LESSER_LEADFOOT_STUN = param1;
		string L_STR = /* TODO: $math(multiply) */ PLR_LESSER_LEADFOOT_STUN;
		string L_STR = int(/* TODO: $math(subtract) */ 100);
		if (!(GetEntityProperty(GetOwner(), "nopush")))
		{
			SendColoredMessage(GetOwner(), "Your stun resistance is now L_STR");
		}
	}

	void ext_delay_playsound()
	{
		PLR_DEL_PLAYSOUND_CHAN = param2;
		PLR_DEL_PLAYSOUND_VOL = param3;
		PLR_DEL_PLAYSOUND_WAV = param4;
		PARAM1("ext_delay_playsound2");
	}

	void ext_delay_playsound2()
	{
		EmitSound(GetOwner(), PLR_DEL_PLAYSOUND_CHAN, PLR_DEL_PLAYSOUND_WAV, PLR_DEL_PLAYSOUND_VOL);
	}

	void ext_tosscre()
	{
		PLR_CRE_HAND = param1;
		PLR_CRE_TYPE = param2;
		if (PLR_CRE_HAND == 1)
		{
			string L_OFS = /* TODO: $relpos */ $relpos(20, 20, 18);
		}
		else
		{
			string L_OFS = /* TODO: $relpos */ $relpos(-20, 20, 18);
		}
		TossProjectile("proj_crescent", L_OFS, "none", 200, 0, 0, "none");
		PLR_LAST_PROJECTILE = GetEntityIndex("ent_lastprojectile");
	}

	void ext_set_glow()
	{
		PLR_HAS_GLOW = param1;
		IR_GLOWING = param1;
		if ((PLR_HAS_GLOW)) return;
		ScheduleDelayedEvent(0.1, "restore_item_lights");
	}

	void restore_item_lights()
	{
		CallExternal("all", "ext_restore_item_lights");
	}

	void ext_teleportfx1()
	{
		ScheduleDelayedEvent(0.1, "ext_teleportfx1_delay");
	}

	void ext_teleportfx1_delay()
	{
		string MY_FEET = GetEntityOrigin(GetOwner());
		MY_FEET = "z";
		ClientEvent("update", "all", "const.localplayer.scriptID", "cl_tele1_fx", MY_FEET);
	}

	void ext_teleportfx2()
	{
		EmitSound(GetOwner(), 0, "debris/beamstart8.wav", 10);
	}

	void extsoc_show_scores()
	{
		LogDebug("extsoc_show_scores");
		string L_POINTS_RED = param1;
		string L_POINTS_BLUE = param2;
		float L_SPR_DUR = 3.0;
		if (L_POINTS_RED == 5)
		{
			int L_GAME_WON = 1;
		}
		if (L_POINTS_BLUE == 5)
		{
			int L_GAME_WON = 2;
		}
		if (L_GAME_WON > 0)
		{
			float L_SPR_DUR = 10.0;
		}
		string L_SCORE_SPRITE = L_POINTS_RED;
		string L_SCORE_SPRITE = int(L_SCORE_SPRITE);
		L_SCORE_SPRITE += "_red";
		// TODO: hud.addimgicon ent_me L_SCORE_SPRITE sc1 20 10 20 30 L_SPR_DUR
		string L_SCORE_SPRITE = L_POINTS_BLUE;
		string L_SCORE_SPRITE = int(L_SCORE_SPRITE);
		L_SCORE_SPRITE += "_blue";
		// TODO: hud.addimgicon ent_me L_SCORE_SPRITE sc2 60 10 20 30 L_SPR_DUR
		// TODO: hud.addimgicon ent_me red sc3 20 0 20 10 L_SPR_DUR
		// TODO: hud.addimgicon ent_me vs sc4 40 0 20 10 L_SPR_DUR
		// TODO: hud.addimgicon ent_me blue sc5 60 0 20 10 L_SPR_DUR
		if (L_GAME_WON > 0)
		{
			if (L_GAME_WON == 1)
			{
				// TODO: hud.addimgicon ent_me red_wins sc6 25 40 50 25 1.0
				PLR_SOCCER_TEAMSPR = "red_wins";
				ScheduleDelayedEvent(2.0, "extsoc_flash_win");
				ScheduleDelayedEvent(4.0, "extsoc_flash_win");
				ScheduleDelayedEvent(6.0, "extsoc_flash_win");
				ScheduleDelayedEvent(8.0, "extsoc_flash_win");
			}
			else
			{
				// TODO: hud.addimgicon ent_me blue_wins sc6 25 40 50 25 1.0
				PLR_SOCCER_TEAMSPR = "blue_wins";
				ScheduleDelayedEvent(2.0, "extsoc_flash_win");
				ScheduleDelayedEvent(4.0, "extsoc_flash_win");
				ScheduleDelayedEvent(6.0, "extsoc_flash_win");
				ScheduleDelayedEvent(8.0, "extsoc_flash_win");
			}
		}
	}

	void extsoc_flash_win()
	{
		// TODO: hud.addimgicon ent_me PLR_SOCCER_TEAMSPR sc6 25 40 50 25 1.5
	}

	void ext_hud_icon()
	{
		// TODO: hud.addimgicon ent_me PARAM1 PARAM2 PARAM3 PARAM4 PARAM5 PARAM6 PARAM7
	}

	void ext_shender_telfdoor()
	{
		LogDebug("ext_shender_telfdoor PLR_DID_SHENDER_EVENT");
		ext_darkenbloom(2);
		if ((PLR_DID_SHENDER_EVENT)) return;
		string WIN_ELF = FindEntityByName("telf_win");
		if ((IsEntityAlive(WIN_ELF)))
		{
			if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
			{
			}
			PLR_DID_SHENDER_EVENT = 1;
			CallExternal(WIN_ELF, "ext_bunny_comment");
		}
	}

	void ext_conflict()
	{
	}

	void ext_dumpvars()
	{
	}

	void ext_showflags()
	{
		string L_TEST = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "listall");
	}

	void ext_svplaysound_kiss()
	{
		LogDebug("ext_svplaysound_kiss PARAM1 PARAM2 PARAM3 PARAM4 PARAM5");
		// svplaysound: svplaysound PARAM1 PARAM2 PARAM3 PARAM4 PARAM5
		EmitSound(param1, param2, param3, param4, param5);
	}

	void ext_clear_valid_gauntlets()
	{
		SetPlayerQuestData(GetOwner(), "mv");
		SetPlayerQuestData(GetOwner(), "m");
	}

	void ext_haste_cooldown()
	{
		PLR_NEXT_HASTE = GetGameTime();
		PLR_NEXT_HASTE += param1;
	}

	void ext_register_corrode()
	{
		PLR_CORRODE_DURATION = param1;
	}

	void ext_clevent_me()
	{
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", param1, param2, param3, param4, param5, param6, param7, param8);
	}

	void ext_clevent_all()
	{
		ClientEvent("update", "all", "const.localplayer.scriptID", param1, param2, param3, param4, param5, param6, param7, param8);
	}

	void ext_mana_regen_loop()
	{
		if (!(/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "mana_regen", "type_exists"))) return;
		ScheduleDelayedEvent(1.0, "ext_mana_regen_loop");
		string L_CUR_MP = GetEntityMP(GetOwner());
		string L_MAX_MP = GetEntityProperty(GetOwner(), "maxmp");
		if (L_CUR_MP < L_MAX_MP)
		{
			L_MAX_MP -= L_CUR_MP;
			GiveMP(L_MAX_MP);
		}
	}

	void ext_arrow_hit()
	{
		if (param1 != "world")
		{
			string L_TARG_ID = /* TODO: $get_by_idx */ $get_by_idx(param1, "id");
			string L_BASE_DMG = GetToken(param2, 0, ";");
			string L_BASE_DMG_TYPE = GetToken(param2, 1, ";");
			string L_WEAPON_IDX = GetToken(param2, 2, ";");
			string L_PROJ_NAME = GetToken(param2, 3, ";");
			string L_WEAPON_ID = /* TODO: $get_by_idx */ $get_by_idx(L_WEAPON_IDX, "id");
			string L_FINAL_DMG = L_BASE_DMG;
			string L_STAT = "skill.";
			string L_BASE_STAT = GetEntityProperty(L_WEAPON_ID, "scriptvar");
			L_STAT += L_BASE_STAT;
			L_STAT += ".power.ratio";
			L_FINAL_DMG *= GetEntityProperty(GetOwner(), "l_stat");
			string L_DMG_MULTI = GetEntityProperty(L_WEAPON_ID, "scriptvar");
			if (L_DMG_MULTI > 0)
			{
				L_FINAL_DMG *= L_DMG_MULTI;
			}
			int L_SPECIAL_DMG = 0;
			if (L_PROJ_NAME == "proj_arrow_gholy")
			{
				string L_HOLY_DMG = GetSkillLevel(GetOwner(), "spellcasting.divination");
				L_HOLY_DMG += 5;
				CallExternal(L_TARG_ID, "turn_undead", L_HOLY_DMG, GetEntityIndex(GetOwner()));
			}
			else
			{
				if (L_PROJ_NAME == "proj_arrow_fbow")
				{
					int L_FREEZE_MANA_COST = 10;
					string L_CDOT_DMG = GetSkillLevel(GetOwner(), "spellcasting.ice");
					string L_FDOT_DMG = CDOT_DMG;
					L_CDOT_DMG /= 1.8;
					L_FDOT_DMG /= 2;
					int L_PROJ_TYPE = 0;
					if (GetEntityMP(GetOwner()) >= L_FREEZE_MANA_COST)
					{
						string L_PROJ_TYPE = RandomInt(0, 1);
					}
					if (!(L_PROJ_TYPE))
					{
						ApplyEffect(L_TARG_ID, "effects/dot_cold", Random(5, 10), GetEntityIndex(GetOwner()), L_CDOT_DMG, "spellcasting.ice");
					}
					else
					{
						GiveMP(GetOwner());
						ApplyEffect(L_TARG_ID, "effects/dot_cold_freeze", 8.0, GetEntityIndex(GetOwner()), L_FDOT_DMG, "spellcasting.ice");
					}
				}
				else
				{
					if (L_PROJ_NAME == "proj_arrow_frost")
					{
						ApplyEffect(L_TARG_ID, "effects/dot_cold", RandomInt(5, 10), GetEntityIndex(GetOwner()), 5, "archery");
					}
					else
					{
						if (L_PROJ_NAME == "proj_arrow_gpoison")
						{
							ApplyEffect(L_TARG_ID, "effects/dot_poison", RandomInt(5, 10), GetEntityIndex(GetOwner()), Random(12, 33), "archery");
						}
						else
						{
							if (L_PROJ_NAME == "proj_arrow_lightning")
							{
								ApplyEffect(L_TARG_ID, "effects/dot_lightning", RandomInt(5, 10), GetEntityIndex(GetOwner()), Random(10, 25), "archery");
							}
							else
							{
								if (L_PROJ_NAME == "proj_arrow_poison")
								{
									ApplyEffect(L_TARG_ID, "effects/dot_poison", 15, GetEntityIndex(GetOwner()), Random(2, 3), 0, "archery");
								}
							}
						}
					}
				}
			}
			if (!(L_SPECIAL_DMG))
			{
			}
			XDoDamage(L_TARG_ID, "direct", L_FINAL_DMG, 1.0, GetOwner(), L_WEAPON_ID, L_BASE_STAT, L_BASE_DMG_TYPE);
		}
		else
		{
			LogDebug("ext_arrow_hit hit world @ PARAM3");
		}
	}

	void ext_reset_bank()
	{
		PLR_RESET_BANK += 1;
		if (PLR_RESET_BANK == 1)
		{
			LogMessage("ent_me WARNING: This will delete ALL items in your Galat chest and cannot be undone!");
			LogMessage("ent_me Type resetbank again to confirm!");
		}
		else
		{
			PLR_RESET_BANK = 0;
			SetPlayerQuestData(GetOwner(), "b0");
			SetPlayerQuestData(GetOwner(), "b1");
			SetPlayerQuestData(GetOwner(), "b2");
			SetPlayerQuestData(GetOwner(), "b3");
			SetPlayerQuestData(GetOwner(), "b4");
			SetPlayerQuestData(GetOwner(), "b5");
			SetPlayerQuestData(GetOwner(), "b6");
			SetPlayerQuestData(GetOwner(), "b7");
			SetPlayerQuestData(GetOwner(), "b8");
			SetPlayerQuestData(GetOwner(), "b9");
			LogMessage("ent_me Your Galat Chest bank strings have been reset.");
		}
	}

	void ext_targeted_by_mob()
	{
		string L_NPC = param1;
		if (!(IsEntityAlive(L_NPC))) return;
		string L_COMBAT_TAG = "combat";
		L_COMBAT_TAG += int(GetEntityIndex(L_NPC));
		SetScriptFlags(GetOwner(), "add", L_COMBAT_TAG, "combat");
		if ((G_DEVELOPER_MODE))
		{
			if (!(PLR_IN_COMBAT))
			{
			}
			if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "combat", "type_exists")))
			{
			}
			// TODO: hud.addstatusicon ent_me PLR_COMBAT_ICON combat 9999
			SendColoredMessage(GetOwner(), "!!!!!! entered combat !!!!!!");
		}
		PLR_IN_COMBAT = 1;
	}

	void ext_untargeted_by_mob()
	{
		string L_NPC = param1;
		string L_COMBAT_TAG = "combat";
		L_COMBAT_TAG += int(GetEntityIndex(L_NPC));
		SetScriptFlags(GetOwner(), "remove", L_COMBAT_TAG);
		if (!(/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "combat", "type_exists")))
		{
			if ((G_DEVELOPER_MODE))
			{
				if ((PLR_IN_COMBAT))
				{
				}
				SendColoredMessage(GetOwner(), "====== exited combat ======");
				// TODO: hud.killstatusicon ent_me combat
			}
			PLR_IN_COMBAT = 0;
		}
	}

	void game_touched_local_trans()
	{
		if (!(PLR_LOCAL_TRANS != param2)) return;
		LogDebug("game_touched_local_trans PARAM1 PARAM2 PARAM3 PARAM4 PARAM5");
		if ((param1).findFirst("_") == 0)
		{
			string L_TITLE = "Local transition to ";
			L_TITLE += param1;
		}
		else
		{
			string L_TITLE = /* TODO: $string_from */ $string_from(L_TITLE, _);
		}
		string L_DESC = "Push (Enter) to activate.";
		if ((param3))
		{
			L_DESC += " Requires all active players be present.";
		}
		SendInfoMsg(GetOwner(), "L_TITLE L_DESC");
		PLR_LOCAL_TRANS = param2;
		PLR_LTRAN_ORG = GetEntityOrigin(GetOwner());
		PLR_LTRAN_MINS = param4;
		PLR_LTRAN_MAXS = param5;
		string L_NEW_SPAWN = param6;
		if (L_NEW_SPAWN != "none")
		{
			ext_setspawn(L_NEW_SPAWN);
		}
		loop_check_local_trans();
	}

	void loop_check_local_trans()
	{
		if (!(PLR_LOCAL_TRANS != "none")) return;
		if (!(/* TODO: $within_box */ $within_box(GetOwner(), Vector3(0, 0, 0), PLR_LTRAN_MINS, PLR_LTRAN_MAXS)))
		{
			PLR_LOCAL_TRANS = "none";
			LogDebug("loop_check_local_trans EXITED LTRANS");
		}
		else
		{
			ScheduleDelayedEvent(1.0, "loop_check_local_trans");
		}
	}

	void ext_setspawn()
	{
		LogDebug("ext_setspawn PARAM1");
		SetTransition(GetOwner(), param1);
		SetPlayerQuestData(GetOwner(), "d");
	}

	void ext_remove_afk()
	{
		if ((G_DEVELOPER_MODE))
		{
			if ((IS_AFK))
			{
			}
			SendColoredMessage(GetOwner(), "====== No longer afk");
		}
		IS_AFK = 0;
		PLR_LAST_ATK_TIME = GetGameTime();
	}

	void ext_poison_bolt()
	{
		LogDebug("ext_poison_bolt PARAM1");
		float L_PBOLT_DURATION = 15.0;
		PLR_PBOLT_AOE = 64;
		string L_PBOLT_LOC = param1;
		SetScriptFlags(GetOwner(), "add", "stack_pbolt", "pbolt", L_PBOLT_LOC, L_PBOLT_DURATION);
		ClientEvent("new", "all", "effects/sfx_poison_cloud", L_PBOLT_LOC, PLR_PBOLT_AOE, L_PBOLT_DURATION);
		if ((PLR_PBOLT_ACTIVE)) return;
		GAME_PVP = "game.pvp";
		PLR_PBOLT_ACTIVE = 1;
		PLR_PBOLT_COUNTER = 0;
		PLR_PBOLT_DOT = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		ext_poison_bolt_loop();
	}

	void ext_poison_bolt_loop()
	{
		if (!(PLR_PBOLT_ACTIVE)) return;
		PLR_PBOLT_ARRAY = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "pbolt", "type_array");
		if (PLR_PBOLT_ARRAY != "none")
		{
			string L_NBOLTS = /* TODO: $get_array_amt */ $get_array_amt(PLR_PBOLT_ARRAY);
			L_NBOLTS -= 1;
			if (PLR_PBOLT_COUNTER > L_NBOLTS)
			{
				PLR_PBOLT_COUNTER = 0;
			}
			PLR_PBOLT_ORG = /* TODO: $get_array */ $get_array(PLR_PBOLT_ARRAY, PLR_PBOLT_COUNTER);
			ext_poison_bolt_dmg();
			float L_BOLT_SCAN_SPEED = 1.0;
			if (L_NBOLTS > 0)
			{
				L_BOLT_SCAN_SPEED /= L_NBOLTS;
			}
			if (L_BOLT_SCAN_SPEED < 0.1)
			{
				float L_BOLT_SCAN_SPEED = 0.2;
			}
			PLR_PBOLT_COUNTER += 1;
			L_BOLT_SCAN_SPEED("ext_poison_bolt_loop");
		}
		else
		{
			PLR_PBOLT_ACTIVE = 0;
		}
	}

	void ext_poison_bolt_dmg()
	{
		string L_SCAN_POINT = PLR_PBOLT_ORG;
		L_SCAN_POINT += "z";
		PLR_PBOLT_TARGS = FindEntitiesInSphere("enemy", PLR_PBOLT_AOE);
		if (!(PLR_PBOLT_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(PLR_PBOLT_TARGS, ";"); i++)
		{
			ext_poison_bolt_affect();
		}
	}

	void ext_poison_bolt_affect()
	{
		string CUR_TARG = GetToken(PLR_PBOLT_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(CUR_TARG, "effects/dot_poison", 10.0, GetEntityIndex(GetOwner()), PLR_PBOLT_DOT, "spellcasting.affliction");
	}

	void ext_speak()
	{
		SayText("PARAM1");
	}

	void ext_saytextrange()
	{
		SetSayTextRange(param1);
	}

	void ext_req_viewmodel_idx()
	{
		LogDebug("requesting viewmodel idx...");
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "ext_svreq_viewmodel_idx");
	}

	void ext_rec_viewmodel_idx()
	{
		PLR_ACTIVE_VIEWMODEL = param1;
		string L_VIEWMODEL_ID = /* TODO: $get_by_idx */ $get_by_idx(PLR_ACTIVE_VIEWMODEL, "id");
		LogDebug("Got viewmodelidx PLR_ACTIVE_VIEWMODEL [ L_VIEWMODEL_ID ]");
		Effect("beam", "follow", "lgtning.spr", L_VIEWMODEL_ID, 1, 30, 30.0, 200, Vector3(255, 0, 0));
		SetProp(L_VIEWMODEL_ID, "rendermode", 5);
		SetProp(L_VIEWMODEL_ID, "renderamt", 255);
	}

	void ext_remove_effect()
	{
		LogDebug("ext_remove_effect PARAM1");
		RemoveEffect(GetOwner(), param1);
	}

	void ext_clientcmd()
	{
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "ext_cl_clientcmd", param1);
	}

	void ext_set_fquest()
	{
		string L_FEL_QUEST = GetPlayerQuestData(GetOwner(), "f");
		if (L_FEL_QUEST == "complete")
		{
			ShowHelpTip(GetOwner(), "generic", "One Time Quest Already Completed", "You cannot obtain another Felewyn Shard by completing this quest again.");
		}
		else
		{
			if (GetToken(L_FEL_QUEST, 0, ";") != 1)
			{
				ShowHelpTip(GetOwner(), "generic", "One Time Quest Acquired", "The Felwyn Shard quest can only be completed one time per character.|The quest is completed upon acquisition of one of the Shards of the Felewyn Blade.");
				SetPlayerQuestData(GetOwner(), "f");
			}
		}
	}

	void ext_debug_que()
	{
		if (!(/* TODO: $get_array */ $get_array(ARRAY_DEBUG, "exists")))
		{
			array<string> ARRAY_DEBUG;
		}
		ARRAY_DEBUG.insertLast(param1);
		if ((PLR_DEBUG_ARRAY_ACTIVE)) return;
		PLR_DEBUG_ARRAY_ACTIVE = 1;
		ext_debug_que_loop();
	}

	void ext_debug_que_loop()
	{
		if (!(PLR_DEBUG_ARRAY_ACTIVE)) return;
		string L_OUT = /* TODO: $get_array */ $get_array(ARRAY_DEBUG, 0);
		if ((L_OUT).length() > 100)
		{
			string L_LOUT = (L_OUT).substr(0, 100);
			L_LOUT += "*";
		}
		LogMessage("ent_me L_OUT");
		ARRAY_DEBUG.removeAt(0);
		if (/* TODO: $get_array_amt */ $get_array_amt(ARRAY_DEBUG) > 0)
		{
			ScheduleDelayedEvent(0.1, "ext_debug_que_loop");
		}
		else
		{
			PLR_DEBUG_ARRAY_ACTIVE = 0;
		}
	}

	void ext_quake_fx()
	{
		string L_DUR = param1;
		EmitSound(GetOwner(), 1, "magic/volcano_start.wav", 10);
		// svplaysound: svplaysound 2 10 magic/volcano_loop.wav 0.8 60
		EmitSound(2, 10, "magic/volcano_loop.wav", 0.8, 60);
		ClientEvent("new", GetOwner(), "effects/sfx_quake", GetEntityIndex(GetOwner()), 1, 256, L_DUR);
		Effect("screenshake", GetEntityOrigin(GetOwner()), 50, 10, L_DUR, 512);
		L_DUR("ext_quake_fx_end");
	}

	void ext_quake_fx_end()
	{
		// svplaysound: svplaysound 2 0 magic/volcano_loop.wav
		EmitSound(2, 0, "magic/volcano_loop.wav");
	}

	void ext_iexist_test()
	{
		LogMessage("ent_me item_exist_test ItemExists(GetOwner(), param1)");
	}

	void ext_shield_up()
	{
		if ((param1))
		{
			PLR_SHIELD_UP = 1;
			SetScriptFlags(GetOwner(), "add", "shieldnp", "nopush", 1, -1, "none");
		}
		else
		{
			PLR_SHIELD_UP = 0;
			SetScriptFlags(GetOwner(), "remove", "shieldnp");
		}
	}

	void ext_dburst()
	{
		PLR_DBURST_ORG = param1;
		PLR_DBURST_AOE = param2;
		PLR_DBURST_PUSH = param3;
		string L_USE_SOUND = param4;
		GAME_PVP = "game.pvp";
		PLR_DBURST_SKILL = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		PLR_DBURST_DMG = PLR_DBURST_SKILL;
		PLR_DBURST_DMG *= 3;
		PLR_DBURST_DOT = PLR_DBURST_SKILL;
		PLR_DBURST_DOT *= 0.5;
		PLR_DBURST_MAXPUSH = GetEntityMaxHealth(GetOwner());
		PLR_DBURST_MAXPUSH *= 4;
		ClientEvent("new", "all", "effects/sfx_dburst", PLR_DBURST_ORG, PLR_DBURST_AOE, L_USE_SOUND);
		XDoDamage(PLR_DBURST_ORG, PLR_DBURST_AOE, PLR_DBURST_DMG, 0.1, GetOwner(), GetOwner(), "spellcasting.affliction", "dark_effect", "dmgevent:dburst");
	}

	void dburst_dodamage()
	{
		if (!(param1)) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(GAME_PVP))
			{
			}
			return;
		}
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_dark", 15.0, GetEntityIndex(GetOwner()), PLR_DBURST_DOT, "spellcasting.affliction");
		if (!(PLR_DBURST_PUSH)) return;
		string CUR_TARG = param2;
		string TARG_HP = GetEntityHealth(CUR_TARG);
		if (TARG_HP < PLR_DBURST_MAXPUSH)
		{
			int DO_PUSH = 1;
		}
		if (!(DO_PUSH)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(PLR_DBURST_ORG, TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(0, 1000, 0)));
	}

	void ext_environment_change()
	{
		ext_tod_lock(/* TODO: $pass */ $pass(param1));
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "environment_change", /* TODO: $pass */ $pass(param1));
	}

	void ext_change_sky()
	{
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "change_sky", /* TODO: $pass */ $pass(param1));
	}

}

}
