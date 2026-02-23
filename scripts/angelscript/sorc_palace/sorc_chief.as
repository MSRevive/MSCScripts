#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_chat.as"

namespace MS
{

class SorcChief : CGameScript
{
	int AM_LEAPING;
	int AM_STANDING;
	int AM_UNARMED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BARRIER_IDX;
	string BARRIER_NEXT_REFRESH;
	int BARRIER_ON;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	string BLOOD_DRINKER_ID;
	string BURST_ORIGIN;
	string BURST_OVERRIDE;
	int CAN_FLINCH;
	string CHAT_MODE;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	int CHAT_STEPS;
	string CHIEF_SPAWN;
	int COMBAT_MODE;
	int CUR_SPECIAL;
	int CYCLES_STARTED;
	string DEFAULT_TELE_POINT;
	string DOUBLE_FOR;
	string DOUBLE_UP;
	int ESCORT_ACTIVE;
	string FACE_PLAYERS;
	string FOUND_NEAR_TARGET;
	float FREQ_LEAP;
	int FRIEND_FOE_ANSWERED;
	string HALF_HEALTH;
	string ID_LSTORM1;
	string ID_LSTORM2;
	int JUMP_FWD_DIST;
	int KICK_DELAY;
	string LAST_SWORD_HIT;
	string LAST_TELE;
	string LEAP_DELAY;
	int LOC_LSTORM1;
	int LOC_LSTORM2;
	int LSTORM_LOOPCOUNT;
	string LSTORM_TARGS;
	int MOVE_RANGE;
	string MOVE_TARG;
	string MREPELL_LIST;
	string NEW_TARGET;
	int NPC_FORCED_MOVEDEST;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string NPC_PROXACT_EVENT;
	string NPC_PROXACT_FOV;
	string NPC_PROXACT_IFSEEN;
	string NPC_PROXACT_RANGE;
	int NPC_PROX_ACTIVATE;
	int N_BLOOD_DRINKERS;
	int N_STORMS;
	int N_TELES;
	int ON_LODAGOND;
	int PLAYERS_INRANGE;
	int PLAYERS_NEAR;
	int PNEAR_LOOP_COUNT;
	int RENDER_COUNT;
	string REPULSE_LIST;
	string SEARCH_RAD;
	int SWORD_ATTACK;
	string TELE_ANGS;
	string TELE_DEST;
	string TELE_ID1;
	string TELE_ID2;
	string TELE_ID3;
	string TELE_ID4;

	SorcChief()
	{
		const string ANIM_SIT = "on_chair";
		const int NO_CLOSE_MOUTH = 1;
		const float CHAT_DELAY = 6.0;
		const int NO_CHAT = 1;
		COMBAT_MODE = 0;
		const int BARRIER_RAD = 64;
		const int DMG_BARRIER = 100;
		const string SOUND_DRAW_WEAPON = "weapons/swords/sworddraw.wav";
		NPC_PROX_ACTIVATE = 1;
		const float MIN_TELEPORT_DELAY = 15.0;
		const int NPC_BOSS_REGEN_RATE = 0;
		const float NPC_BOSS_RESTORATION = 0.3;
		const int NPC_USES_LIGHTS = 1;
		if (StringToLower(GetMapName()) == "shad_palace")
		{
			NPC_GIVE_EXP = 10000;
			NPC_IS_BOSS = 1;
		}
		const string ANIM_WARCRY = "warcry";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_FLINCH = "flinch";
		ANIM_ATTACK = "swordswing1_L";
		const string ANIM_SWIPE = "swordswing1_L";
		const string ANIM_SMASH = "battleaxe_swing1_L";
		const string ANIM_KICK = "kick";
		const string ANIM_PARRY = "shielddeflect1";
		ANIM_DEATH = "die_fallback";
		const string ANIM_HOP = "battleaxe_swing1_L";
		CAN_FLINCH = 1;
		const float ATTACK_HITCHANCE = 0.9;
		ATTACK_MOVERANGE = 32;
		MOVE_RANGE = 32;
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 120;
		const string DMG_SLASH = RandomInt(100, 200);
		const string DMG_SMACK = RandomInt(25, 50);
		const string DMG_SMASH = RandomInt(150, 400);
		const string DMG_KICK = Random(25, 100);
		const int DMG_LBLAST = 100;
		const int DMG_LSTORM = 100;
		const int DUR_LSTORM = 30;
		const string FREQ_TORNADO = RandomInt(15, 30);
		const string FREQ_LSTORM = RandomInt(30, 45);
		const string FREQ_LBLAST = RandomInt(15, 30);
		const string FREQ_THROW = RandomInt(10, 30);
		const string FREQ_SPECIAL = RandomInt(10, 15);
		const string FREQ_TELEPORT = RandomInt(20, 140);
		const string FREQ_TELEPORT_FAST = RandomInt(20, 40);
		const float FREQ_KICK = 10.0;
		FREQ_LEAP = 5.0;
		const string SOUND_WARCRY = "monsters/troll/trollidle.wav";
		const string SOUND_STRUCK1 = "body/armour1.wav";
		const string SOUND_STRUCK2 = "body/armour2.wav";
		const string SOUND_STRUCK3 = "body/armour3.wav";
		const string SOUND_HIT = "voices/orc/hit.wav";
		const string SOUND_HIT2 = "voices/orc/hit2.wav";
		const string SOUND_HIT3 = "voices/orc/hit3.wav";
		const string SOUND_PAIN = "monsters/orc/pain.wav";
		const string SOUND_WARCRY1 = "monsters/orc/battlecry.wav";
		const string SOUND_ATTACK1 = "voices/orc/attack.wav";
		const string SOUND_ATTACK2 = "voices/orc/attack2.wav";
		const string SOUND_ATTACK3 = "voices/orc/attack3.wav";
		const string SOUND_DEATH = "voices/orc/die.wav";
		const string SOUND_HELP = "voices/orc/help.wav";
		const string SOUND_TELE = "magic/teleport.wav";
		const float VAMPIRE_RATIO = 0.1;
		Precache(SOUND_DEATH);
		Precache("weapons/magic/tornado.mdl");
		Precache("magic/vent1.wav");
		Precache("magic/vent2.wav");
		Precache("magic/vent3.wav");
		Precache("magic/gusts1.wav");
		Precache("magic/gusts2.wav");
		Precache("weather/Storm_exclamation.wav");
		Precache("magic/lightning_strike.wav");
		Precache("doors/aliendoor3.wav");
		Precache("magic/spawn.wav");
		Precache("zombie/claw_miss2.wav");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(8, 15));
		if (!(SUSPEND_AI))
		{
		}
		if (m_hAttackTarget != "unset")
		{
		}
		string LEAP_TYPE = RandomInt(1, 4);
		if (LEAP_TYPE < 4)
		{
			leap_at(m_hAttackTarget, "random");
		}
		if (LEAP_TYPE == 4)
		{
			leap_random();
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(1.1);
		if (STUCK_COUNT > 4)
		{
		}
		do_teleport("stuck_count");
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(20.0);
		if ((COMBAT_MODE))
		{
		}
		if (GetEntityRange(m_hAttackTarget) > 256)
		{
		}
		string LAST_TELE_DIFF = GetGameTime();
		LAST_TELE_DIFF -= LAST_TELE;
		if (LAST_TELE_DIFF > 5.0)
		{
		}
		string LAST_HIT_DIFF = GetGameTime();
		LAST_HIT_DIFF -= LAST_SWORD_HIT;
		if (LAST_HIT_DIFF > 20.0)
		{
		}
		do_teleport("stuck_count", "no_hits");
	}

	void OnRepeatTimer_3()
	{
		SetRepeatDelay(1.0);
		if (!(AM_STANDING))
		{
		}
		if (GetEntityOrigin(GetOwner()) != CHIEF_SPAWN)
		{
		}
		SetEntityOrigin(GetOwner(), CHIEF_SPAWN);
		SetGravity(0);
	}

	void OnSpawn() override
	{
		SetName("the_warchief");
		SetName("Runegahr the Warchief");
		SetRace("orc");
		SetHealth(18000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("stun", 0.25);
		SetHearingSensitivity(10);
		SetInvincible(2);
		SetModel("monsters/sorc.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 0);
		SetStat("parry", 150);
		SetWidth(32);
		SetHeight(96);
		SetIdleAnim(ANIM_SIT);
		SetMoveAnim(ANIM_SIT);
		SetMenuAutoOpen(0);
		SetRoam(false);
		SetGravity(0);
		SetFly(true);
		SetSayTextRange(4096);
		SWORD_ATTACK = 0;
		JUMP_FWD_DIST = 250;
		CUR_SPECIAL = 0;
		ScheduleDelayedEvent(1.0, "get_teleporters");
		ScheduleDelayedEvent(0.1, "check_for_blood");
		npcatk_suspend_ai();
		if (!(true)) return;
		CHIEF_SPAWN = GetEntityOrigin(GetOwner());
	}

	void ext_nudge()
	{
		MOVE_TARG = param1;
		SetMoveDest(param1);
		string NEW_ORG = GetEntityOrigin(GetOwner());
		NEW_ORG += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 4, 0));
		SetEntityOrigin(GetOwner(), NEW_ORG);
		LogDebug("ext_nudge GetEntityName(param1) GetEntityOrigin(GetOwner())");
	}

	void OnPostSpawn() override
	{
		SetMenuAutoOpen(0);
		string NEW_ORG = GetEntityOrigin(GetOwner());
		NEW_ORG += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 4, 0));
		SetMoveDest(NEW_ORG);
		SetEntityOrigin(GetOwner(), NEW_ORG);
		HALF_HEALTH = GetMonsterMaxHP();
		HALF_HEALTH /= 2;
		string L_MAP_NAME = StringToLower(GetMapName());
		if (!(L_MAP_NAME == "lodagond-1")) return;
		ON_LODAGOND = 1;
	}

	void check_for_blood()
	{
		GetAllPlayers(BD_PLAYER_LIST);
		N_BLOOD_DRINKERS = 0;
		for (int i = 0; i < GetTokenCount(BD_PLAYER_LIST, ";"); i++)
		{
			check_inventories();
		}
		if (N_BLOOD_DRINKERS != 0)
		{
			SetGlobalVar("G_SORC_CHIEF_PRESENT", 1);
			NPC_PROXACT_RANGE = 256;
			NPC_PROXACT_EVENT = "player_nears";
			NPC_PROXACT_IFSEEN = 0;
			NPC_PROXACT_FOV = 0;
		}
	}

	void check_inventories()
	{
		string CUR_TARG = GetToken(BD_PLAYER_LIST, i, ";");
		if ((ItemExists(CUR_TARG, "swords_blood_drinker")))
		{
			N_BLOOD_DRINKERS += 1;
			if (N_BLOOD_DRINKERS == 1)
			{
				BLOOD_ID = CUR_TARG;
			}
		}
		if ((ItemExists(CUR_TARG, "item_tk_swords_blood_drinker")))
		{
			N_BLOOD_DRINKERS += 1;
			if (N_BLOOD_DRINKERS == 1)
			{
				BLOOD_ID = CUR_TARG;
			}
		}
	}

	void player_nears()
	{
		CHAT_STEP1 = "I remember ";
		if (N_BLOOD_DRINKERS > 1)
		{
			string REF_RESCUE = "some of you";
		}
		else
		{
			if (GetPlayerCount() == 1)
			{
				string REF_RESCUE = "you";
			}
			else
			{
				if (N_BLOOD_DRINKERS == 1)
				{
					string REF_RESCUE = GetEntityName(BLOOD_ID);
				}
			}
		}
		REF_RESCUE += "... Aiding... In my escape from Lodagond.";
		CHAT_STEP1 += REF_RESCUE;
		CHAT_STEP2 = "So, before I decide whether or not to slay you here and now.";
		CHAT_STEP3 = "I ask you, have you come as [friend] or [foe]?";
		CHAT_STEPS = 3;
		chat_loop();
		FRIEND_FOE_ANSWERED = 0;
		string CHAT_DELAY_TOTAL = CHAT_STEPS;
		CHAT_DELAY_TOTAL -= 1;
		CHAT_DELAY_TOTAL *= CHAT_DELAY;
		CHAT_DELAY_TOTAL += 1.0;
		LogDebug("player_nears cdt CHAT_DELAY_TOTAL");
		CHAT_DELAY_TOTAL("send_ff_menu");
		CatchSpeech("say_friend", "friend");
		CatchSpeech("say_foe", "foe");
	}

	void send_ff_menu()
	{
		SetMenuAutoOpen(1);
		CHAT_MODE = "friend_foe";
		OpenMenu(NPC_PROXACT_PLAYERID);
	}

	void game_menu_getoptions()
	{
		if (CHAT_MODE == "friend_foe")
		{
			string reg.mitem.title = "Friend";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_friend";
			string reg.mitem.title = "Foe";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_foe";
		}
	}

	void game_menu_cancel()
	{
		if (!(CHAT_MODE == "friend_foe")) return;
		ScheduleDelayedEvent(1.0, "resend_menu");
	}

	void resend_menu()
	{
		if ((FRIEND_FOE_ANSWERED)) return;
		OpenMenu(NPC_PROXACT_PLAYERID);
	}

	void say_friend()
	{
		if (CHAT_MODE == "in_combat")
		{
			SayText("Too late now , coward.");
		}
		LogDebug("was busy chatting BUSY_CHATTING");
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(0.1, "say_friend");
		}
		if ((BUSY_CHATTING)) return;
		if ((FRIEND_FOE_ANSWERED)) return;
		if (!(CHAT_MODE == "friend_foe")) return;
		CHAT_MODE = "friend";
		UseTrigger("towndoors01");
		SetGlobalVar("G_SORCV_FRIENDLY", 1);
		FRIEND_FOE_ANSWERED = 1;
		CHAT_STEP1 = "Very well then...";
		CHAT_STEP2 = "I suppose I should be upset that you slaughtered the palace guard...";
		CHAT_STEP3 = "But, if they couldn't stop you, I suppose they weren't up to the job.";
		CHAT_STEP4 = "I've some more promising recruits lined up in the villa anyways.";
		CHAT_STEPS = 4;
		chat_loop();
		string CHAT_DELAY_TOTAL = CHAT_STEPS;
		CHAT_DELAY_TOTAL -= 1;
		CHAT_DELAY_TOTAL *= CHAT_DELAY;
		CHAT_DELAY_TOTAL += 4.0;
		CHAT_DELAY_TOTAL("announce_visitors");
	}

	void announce_visitors()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(0.1, "announce_visitors");
		}
		if ((BUSY_CHATTING)) return;
		// TODO: playmp3 all combat haunted_desert.mp3
		stand_up();
		CHAT_STEP1 = "Let it be known that ";
		if (GetPlayerCount() > 1)
		{
			CHAT_STEP1 += "these humans are my guests.";
			CHAT_STEP2 = "They are under MY protection. And you are to treat them as if they were our own.";
			CHAT_STEP3 = "The gates to the villa are to be opened to them...";
			CHAT_STEP4 = "...and I expect them to be allowed to partake in what 'hospitality' we provide therein.";
		}
		if (GetPlayerCount() == 1)
		{
			CHAT_STEP1 += GetEntityName(NPC_PROXACT_PLAYERID);
			CHAT_STEP1 += " is my guest.";
			CHAT_STEP2 = "He is under my protection. And you are to treat him as if he was one of us.";
			CHAT_STEP3 = "The gates to the villa are to be opened to him...";
			CHAT_STEP4 = "...and I expect him to be allowed to partake in whatever 'hospitality' we provide therein.";
		}
		CHAT_STEPS = 4;
		chat_loop();
		string CHAT_DELAY_TOTAL = CHAT_STEPS;
		CHAT_DELAY_TOTAL -= 1;
		CHAT_DELAY_TOTAL *= CHAT_DELAY;
		CHAT_DELAY_TOTAL += 3.0;
		CHAT_DELAY_TOTAL("get_reply");
	}

	void get_reply()
	{
		CallExternal("all", "sorcs_confirm_order");
	}

	void OnDamage(int damage) override
	{
		if ((COMBAT_MODE)) return;
		SetDamage("dmg");
		SetDamage("hit");
		return;
		if (!(COMBAT_MODE)) return;
		if (GetMonsterHP() < HALF_HEALTH)
		{
			JUMP_FWD_DIST = 500;
			FREQ_LEAP = 0.1;
		}
		string HIT_BY = GetEntityIndex(param1);
		if (param2 > 30)
		{
			if (GetEntityRange(HIT_BY) < ATTACK_HITRANGE)
			{
			}
			if (RandomInt(1, 3) == 1)
			{
			}
			if (!(LEAP_DELAY))
			{
			}
			LEAP_DELAY = 1;
			FREQ_LEAP("leap_delay_reset");
			leap_away(HIT_BY);
		}
	}

	void ext_tell_approach()
	{
		if (!(N_BLOOD_DRINKERS > 0)) return;
		if (GetPlayerCount() > 1)
		{
			SayText("Humans! Approach the throne of Runegahr. I wish to speak with thee.");
		}
		else
		{
			SayText("Human! You may approach the throne of Runegahr. I wish to speak with thee.");
		}
	}

	void say_foe()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(0.1, "say_foe");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "So be it.";
		CHAT_STEP2 = "Thuldahr, it is as you hoped. They are yours.";
		CHAT_STEPS = 2;
		chat_loop();
		ESCORT_ACTIVE = 1;
		CHAT_MODE = "in_combat";
		string CHAT_DELAY_TOTAL = CHAT_STEPS;
		CHAT_DELAY_TOTAL *= CHAT_DELAY;
		CHAT_DELAY_TOTAL += 1.0;
		CHAT_DELAY_TOTAL("begin_the_attack");
	}

	void begin_the_attack()
	{
		CallExternal("all", "ext_chief_orders_attack");
		shield_up();
	}

	void shield_up()
	{
		BARRIER_ON = 1;
		BARRIER_NEXT_REFRESH = GetGameTime();
		BARRIER_NEXT_REFRESH += 20.0;
		ClientEvent("new", "all", "sorc_palace/sorc_chief_cl", GetEntityIndex(GetOwner()), BARRIER_RAD, Vector3(255, 0, 0), 20.0);
		BARRIER_IDX = "game.script.last_sent_id";
		barrier_loop();
	}

	void barrier_loop()
	{
		if (!(BARRIER_ON)) return;
		ScheduleDelayedEvent(0.5, "barrier_loop");
		if (GetGameTime() > BARRIER_NEXT_REFRESH)
		{
			ClientEvent("update", "all", BARRIER_IDX, "remove_me");
			ClientEvent("new", "all", "sorc_palace/sorc_chief_cl", GetEntityIndex(GetOwner()), BARRIER_RAD, Vector3(255, 0, 0), 20.0);
			BARRIER_IDX = "game.script.last_sent_id";
			BARRIER_NEXT_REFRESH = GetGameTime();
			BARRIER_NEXT_REFRESH += 20.0;
		}
		repell_burst(GetEntityOrigin(GetOwner()), BARRIER_RAD, 0);
	}

	void barrier_off()
	{
		BARRIER_ON = 0;
		ClientEvent("update", "all", BARRIER_IDX, "clear_sprites");
	}

	void repell_burst()
	{
		BURST_ORIGIN = param1;
		string BURST_RAD = param2;
		BURST_OVERRIDE = param3;
		REPULSE_LIST = FindEntitiesInSphere("enemy", BURST_RAD);
		if (!(REPULSE_LIST != "none")) return;
		EmitSound(GetOwner(), 0, "doors/aliendoor3.wav", 10);
		for (int i = 0; i < GetTokenCount(REPULSE_LIST, ";"); i++)
		{
			repulse_targets();
		}
		DoDamage(BURST_ORIGIN, BURST_RAD, DMG_BARRIER, 1.0, 0);
	}

	void repulse_targets()
	{
		string CUR_TARG = GetToken(REPULSE_LIST, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(BURST_ORIGIN, TARG_ORG);
		if (!(BURST_OVERRIDE))
		{
			SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 2000, 110)));
		}
		else
		{
			SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 2000, 110)));
		}
	}

	void mild_repell_loop()
	{
		MREPELL_LIST = FindEntitiesInSphere("any", 64);
		ScheduleDelayedEvent(0.5, "mild_repell_loop");
		if (!(MREPELL_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(MREPELL_LIST, ";"); i++)
		{
			mrepell_targets();
		}
	}

	void mrepell_targets()
	{
		string CUR_TARG = GetToken(MREPELL_LIST, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(0, 400, 110)));
	}

	void thuld_died()
	{
		combat_mode_go();
	}

	void combat_mode_go()
	{
		barrier_off();
		COMBAT_MODE = 1;
		SetMenuAutoOpen(0);
		repell_burst(/* TODO: $relpos */ $relpos(0, 64, 0), 128, 1);
		ScheduleDelayedEvent(0.5, "stand_up");
	}

	void stand_up()
	{
		SetGravity(1);
		SetFly(false);
		AM_STANDING = 1;
		UseTrigger("chief_stand");
		if (!(COMBAT_MODE))
		{
			mild_repell_loop();
		}
		SetEntityOrigin(GetOwner(), /* TODO: $relpos */ $relpos(0, 64, 0));
		SetIdleAnim(ANIM_IDLE);
		if ((COMBAT_MODE))
		{
			SetMoveAnim(ANIM_WALK);
			ScheduleDelayedEvent(0.1, "combat_mode_go2");
		}
		else
		{
			SetMoveAnim(ANIM_IDLE);
			SetSolid("none");
			FACE_PLAYERS = 1;
		}
	}

	void combat_mode_go2()
	{
		DEFAULT_TELE_POINT = GetEntityOrigin(GetOwner());
		PlayAnim("critical", ANIM_WARCRY);
		npcatk_resume_ai();
		SetInvincible(false);
		EmitSound(GetOwner(), 0, SOUND_WARCY, 10);
		SayText("NOW IT'S MY TURN!");
		SetMoveSpeed(1.5);
		SetAnimMoveSpeed(1.5);
		SetAnimFrameRate(1.5);
		BASE_MOVESPEED = 1.5;
		BASE_FRAMERATE = 1.5;
		UseTrigger("spawn_throne_escort");
		SetGlobalVar("G_SORCV_FRIENDLY", 0);
	}

	void warcry_done()
	{
		if ((SWORD_DRAWN)) return;
		SetModelBody(2, 8);
		EmitSound(GetOwner(), 0, SOUND_DRAW_WEAPON, 10);
		CAN_FLINCH = 1;
		if ((SUSPEND_AI))
		{
			npcatk_resume_ai();
		}
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(FACE_PLAYERS)) return;
		string HEARD_ID = GetEntityIndex("ent_lastheard");
		if (!(IsValidPlayer(HEARD_ID))) return;
		if (!(GetEntityRange(HEARD_ID) < 128)) return;
		SetMoveDest(HEARD_ID);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if ((SWORD_ATTACK))
		{
			SWORD_ATTACK = 0;
			AddVelocity(param1, /* TODO: $relvel */ $relvel(-100, 130, 120));
			if (GetMonsterHP() < GetMonsterMaxHP())
			{
				string HP_TO_GIVE = param2;
				HP_TO_GIVE *= VAMPIRE_RATIO;
				HealEntity(GetOwner(), VAMPIRE_RATIO);
				Effect("glow", GetOwner(), Vector3(0, 255, 0), 96, 0.5, 0.5);
				EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
			}
		}
	}

	void cycle_up()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		FREQ_SPECIAL("do_special");
		ScheduleDelayedEvent(60.0, "do_teleport");
		SetRoam(true);
	}

	void swing_axe()
	{
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			LAST_SWORD_HIT = GetGameTime();
		}
		sorc_yell();
		SWORD_ATTACK = 1;
		if (!(AM_UNARMED))
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SMASH, ATTACK_HITCHANCE, "slash");
		}
		if ((AM_UNARMED))
		{
			SWORD_ATTACK = 0;
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SMACK, ATTACK_HITCHANCE, "blunt");
		}
		ANIM_ATTACK = ANIM_SWIPE;
		check_kick();
	}

	void swing_sword()
	{
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			LAST_SWORD_HIT = GetGameTime();
		}
		sorc_yell();
		if (!(AM_UNARMED))
		{
			SWORD_ATTACK = 1;
		}
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SLASH, ATTACK_HITCHANCE, "slash");
		if ((AM_UNARMED))
		{
			SWORD_ATTACK = 0;
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SMACK, ATTACK_HITCHANCE, "blunt");
		}
		if (RandomInt(1, 5) == 1)
		{
			ANIM_ATTACK = ANIM_SMASH;
		}
		check_kick();
	}

	void check_kick()
	{
		if ((KICK_DELAY)) return;
		if (!(AM_UNARMED))
		{
			if (RandomInt(1, 5) != 1)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ANIM_ATTACK = ANIM_KICK;
		KICK_DELAY = 1;
		if (!(AM_UNARMED))
		{
			FREQ_KICK("reset_kick_delay");
		}
		if ((AM_UNARMED))
		{
			ScheduleDelayedEvent(1.0, "reset_kick_delay");
		}
	}

	void kick_land()
	{
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			LAST_SWORD_HIT = GetGameTime();
		}
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KICK, ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = ANIM_SWIPE;
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		ApplyEffect(m_hAttackTarget, "effects/debuff_stun", Random(5, 10), GetEntityIndex(GetOwner()));
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(-100, 200, 150));
	}

	void reset_kick_delay()
	{
		KICK_DELAY = 0;
	}

	void sorc_yell()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void leap_delay_reset()
	{
		LEAP_DELAY = 0;
	}

	void orc_hop()
	{
		EmitSound(GetOwner(), 0, "monsters/orc/attack1.wav", 10);
		if (GetMonsterHP() > HALF_HEALTH)
		{
			string JUMP_HEIGHT = RandomInt(350, 450);
		}
		if (GetMonsterHP() <= HALF_HEALTH)
		{
			string JUMP_HEIGHT = RandomInt(350, 950);
		}
		string L_JUMP_FWD_DIST = JUMP_FWD_DIST;
		string L_JUMP_HEIGHT = JUMP_HEIGHT;
		if ((DOUBLE_FOR))
		{
			DOUBLE_FOR = 0;
			L_JUMP_FWD_DIST *= 2;
		}
		if ((DOUBLE_UP))
		{
			DOUBLE_UP = 0;
			L_JUMP_HEIGHT *= 2;
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, L_JUMP_FWD_DIST, L_JUMP_HEIGHT));
	}

	void leap_away()
	{
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "do_leap");
	}

	void leap_random()
	{
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		string RND_ROT = RandomInt(0, 359);
		string LEAP_DEST = GetMonsterProperty("origin");
		LEAP_DEST += /* TODO: $relpos */ $relpos(Vector3(0, RND_ROT, 0), Vector3(0, 400, 0));
		SetMoveDest(LEAP_DEST);
		ScheduleDelayedEvent(0.1, "do_leap");
	}

	void leap_at()
	{
		if ((AM_LEAPING)) return;
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		if ((IsEntityAlive(m_hAttackTarget)))
		{
			string TARGET_ORG = GetEntityOrigin(m_hAttackTarget);
			string TARGET_Z = (TARGET_ORG).z;
			string MY_Z = GetMonsterProperty("origin.z");
			if (TARGET_Z > MY_Z)
			{
				string V_DEST = GetMonsterProperty("origin");
				V_DEST = "z";
				if (Distance(GetMonsterProperty("origin"), V_DEST) > 96)
				{
				}
				DOUBLE_UP = 1;
			}
			if (GetEntityProperty(m_hAttackTarget, "range2d") > 1600)
			{
				DOUBLE_FOR = 1;
			}
		}
		npcatk_suspend_ai(1.0);
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "do_leap");
	}

	void do_leap()
	{
		// PlayRandomSound from: SOUND_HIT, SOUND_HIT2, SOUND_HIT3
		array<string> sounds = {SOUND_HIT, SOUND_HIT2, SOUND_HIT3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_HOP);
		ScheduleDelayedEvent(0.1, "orc_hop");
		ScheduleDelayedEvent(1.0, "reset_leaping");
	}

	void reset_leaping()
	{
		AM_LEAPING = 0;
	}

	void do_lstorm()
	{
		CAN_FLINCH = 0;
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		npcatk_suspend_ai(2.0);
		LSTORM_TARGS = "placeholder";
		GetAllPlayers(LSTORM_TARGS);
		string N_LSTORM_TARGS = GetTokenCount(LSTORM_TARGS, ";");
		N_STORMS = 0;
		LOC_LSTORM1 = 0;
		LOC_LSTORM2 = 0;
		LSTORM_LOOPCOUNT = 0;
		if (N_LSTORM_TARGS > 0)
		{
			for (int i = 0; i < N_LSTORM_TARGS; i++)
			{
				do_lstorm_loop();
			}
		}
		if (!(N_STORMS > 0)) return;
		ScheduleDelayedEvent(0.1, "do_lstorm2");
		if (N_STORMS > 1)
		{
			ScheduleDelayedEvent(0.5, "do_lstorm3");
		}
	}

	void do_lstorm2()
	{
		SpawnNPC("monsters/summon/summon_lightning_storm", LOC_LSTORM1, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), DMG_LSTORM, DUR_LSTORM
		ID_LSTORM1 = GetEntityIndex(m_hLastCreated);
	}

	void do_lstorm3()
	{
		SpawnNPC("monsters/summon/summon_lightning_storm", LOC_LSTORM2, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), DMG_LSTORM, DUR_LSTORM
		ID_LSTORM2 = GetEntityIndex(m_hLastCreated);
	}

	void do_lstorm_loop()
	{
		string CUR_PLAYER = GetToken(LSTORM_TARGS, LSTORM_LOOPCOUNT, ";");
		LSTORM_LOOPCOUNT += 1;
		if (GetEntityRange(CUR_PLAYER) < 1024)
		{
			if (N_STORMS < 2)
			{
			}
			N_STORMS += 1;
			string TARG_ORG = GetEntityOrigin(CUR_PLAYER);
			if (N_STORMS == 2)
			{
				if (Distance(TARG_ORG, LOC_LSTORM1) < 256)
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			string STORM_GRNDPOS = /* TODO: $get_ground_height */ $get_ground_height(TARG_ORG);
			TARG_ORG = "z";
			if (N_STORMS == 1)
			{
				LOC_LSTORM1 = TARG_ORG;
			}
			if (N_STORMS == 2)
			{
				LOC_LSTORM2 = TARG_ORG;
			}
		}
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((SUSPEND_AI)) return;
		if (RandomInt(1, 3) == 1)
		{
			PlayAnim("critical", "shielddeflect1");
		}
	}

	void get_teleporters()
	{
		N_TELES = 0;
		TELE_ID1 = GetToken(G_RUNE_POINTS, 0, ";");
		TELE_ID2 = GetToken(G_RUNE_POINTS, 1, ";");
		TELE_ID3 = GetToken(G_RUNE_POINTS, 2, ";");
		TELE_ID4 = GetToken(G_RUNE_POINTS, 3, ";");
		N_TELES = 3;
	}

	void do_teleport()
	{
		if (!(N_TELES > 0)) return;
		if (param1 != "stuck_count")
		{
			if (GetMonsterHP() > HALF_HEALTH)
			{
				int TELEPORT_FAST = 0;
			}
			if (GetMonsterHP() <= HALF_HEALTH)
			{
				int TELEPORT_FAST = 1;
			}
			if (!(TELEPORT_FAST))
			{
				FREQ_TELEPORT("do_teleport");
			}
			if ((TELEPORT_FAST))
			{
				FREQ_TELEPORT_FAST("do_teleport");
			}
		}
		string LAST_TELE_DIFF = GetGameTime();
		LAST_TELE_DIFF -= LAST_TELE;
		if (!(LAST_TELE_DIFF > MIN_TELEPORT_DELAY)) return;
		LogDebug("game.time secs: do_teleport PARAM1 PARAM2");
		LAST_TELE = GetGameTime();
		string TOTAL_TELES = N_TELES;
		TOTAL_TELES += 1;
		string PICK_TELE = RandomInt(1, TOTAL_TELES);
		if (param2 == "no_hits")
		{
			if ((G_DEVELOPER_MODE))
			{
				SendInfoMessageToAll("green no_hits teleport");
			}
			GetAllPlayers(PLAYER_LIST);
			ScrambleTokens(PLAYER_LIST, ";");
			FOUND_NEAR_TARGET = 0;
			SEARCH_RAD = 512;
			for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
			{
				find_near_teleporter();
			}
			if (FOUND_NEAR_TARGET > 0)
			{
				npcatk_settarget(NEW_TARGET);
				if ((G_DEVELOPER_MODE))
				{
					SendInfoMessageToAll("green SORC_CHIEF: found GetEntityName(NEW_TARGET) near FOUND_NEAR_TARGET");
				}
				string PICK_TELE = FOUND_NEAR_TARGET;
			}
		}
		if (PICK_TELE == 1)
		{
			TELE_DEST = TELE_ID1;
		}
		if (PICK_TELE == 2)
		{
			TELE_DEST = TELE_ID2;
		}
		if (PICK_TELE == 3)
		{
			TELE_DEST = TELE_ID3;
		}
		if (PICK_TELE == 4)
		{
			TELE_DEST = TELE_ID4;
		}
		if (PICK_TELE > N_TELES)
		{
			TELE_DEST = DEFAULT_TELE_POINT;
			TELE_ANGS = NPC_SPAWN_ANGLES;
		}
		SpawnNPC("monsters/summon/ibarrier", TELE_DEST, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 64, 2, 0, 0, 0, 1
		leap_tele();
	}

	void find_near_teleporter()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		string PLAYER_ORG = GetEntityOrigin(CUR_PLAYER);
		if (!(FOUND_NEAR_TARGET == 0)) return;
		if (!(N_TELES >= 1)) return;
		string TEST_TELE = TELE_ID1;
		TEST_TELE = "z";
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			FOUND_NEAR_TARGET = 1;
			NEW_TARGET = CUR_PLAYER;
		}
		if (!(N_TELES >= 2)) return;
		string TEST_TELE = TELE_ID2;
		TEST_TELE = "z";
		string OLD_TELE_DIST = TELE_DIST;
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			if (OLD_TELE_DIST > TELE_DIST)
			{
			}
			FOUND_NEAR_TARGET = 2;
			NEW_TARGET = CUR_PLAYER;
		}
		if (!(N_TELES >= 3)) return;
		string TEST_TELE = TELE_ID3;
		TEST_TELE = "z";
		string OLD_TELE_DIST = TELE_DIST;
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			if (OLD_TELE_DIST > TELE_DIST)
			{
			}
			FOUND_NEAR_TARGET = 3;
			NEW_TARGET = CUR_PLAYER;
		}
		if (!(N_TELES >= 4)) return;
		string TEST_TELE = TELE_ID4;
		TEST_TELE = "z";
		string OLD_TELE_DIST = TELE_DIST;
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			if (OLD_TELE_DIST > TELE_DIST)
			{
			}
			FOUND_NEAR_TARGET = 4;
			NEW_TARGET = CUR_PLAYER;
		}
		string TEST_TELE = NPC_SPAWN_LOC;
		TEST_TELE = "z";
		string OLD_TELE_DIST = TELE_DIST;
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			if (OLD_TELE_DIST > TELE_DIST)
			{
			}
			FOUND_NEAR_TARGET = 5;
			NEW_TARGET = CUR_PLAYER;
		}
	}

	void leap_tele()
	{
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		SetMoveDest(/* TODO: $relpos */ $relpos(0, 1000, 0));
		ScheduleDelayedEvent(0.1, "do_leap");
		RENDER_COUNT = 255;
		ScheduleDelayedEvent(0.25, "flicker_out");
		ScheduleDelayedEvent(0.75, "tele_out");
		ScheduleDelayedEvent(1.0, "tele_in");
	}

	void flicker_out()
	{
		RENDER_COUNT -= 50;
		if (!(RENDER_COUNT > 0)) return;
		ScheduleDelayedEvent(0.1, "flicker_out");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RENDER_COUNT);
	}

	void tele_out()
	{
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		SetEntityOrigin(GetOwner(), Vector3(-20000, 10000, -20000));
	}

	void tele_in()
	{
		SetEntityOrigin(GetOwner(), TELE_DEST);
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		RENDER_COUNT = 0;
		flicker_in();
		LAST_TELE = GetGameTime();
	}

	void flicker_in()
	{
		RENDER_COUNT += 50;
		if (RENDER_COUNT >= 255)
		{
			SetProp(GetOwner(), "rendermode", 0);
			SetProp(GetOwner(), "renderamt", 255);
		}
		if (!(RENDER_COUNT < 255)) return;
		ScheduleDelayedEvent(0.1, "flicker_in");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RENDER_COUNT);
	}

	void do_tornado()
	{
		PlayAnim("critical", ANIM_SWIPE);
		SpawnNPC("monsters/summon/tornado", /* TODO: $relpos */ $relpos(0, 72, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 200, 20.0
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if ((ATTACK_PARRY))
		{
			SetDamage("hit");
			SetDamage("dmg");
		}
	}

	void do_throw()
	{
		if ((AM_UNARMED)) return;
		PLAYERS_NEAR = 0;
		PLAYERS_INRANGE = 0;
		GetAllPlayers(SORC_LPLAYERS);
		PNEAR_LOOP_COUNT = 0;
		for (int i = 0; i < GetTokenCount(SORC_LPLAYERS, ";"); i++)
		{
			any_players_near();
		}
		if ((PLAYERS_NEAR)) return;
		if (!(PLAYERS_INRANGE)) return;
		do_throw2();
	}

	void do_throw2()
	{
		SetModelBody(2, 0);
		AM_UNARMED = 1;
		PlayAnim("critical", ANIM_SWIPE);
		SpawnNPC("monsters/summon/blood_drinker", /* TODO: $relpos */ $relpos(0, 48, 48), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityIndex(m_hLastStruck), 100, 30.0
		BLOOD_DRINKER_ID = GetEntityIndex(m_hLastCreated);
	}

	void any_players_near()
	{
		string CUR_PLAYER = GetToken(SORC_LPLAYERS, PNEAR_LOOP_COUNT, ";");
		if (GetEntityRange(CUR_PLAYER) < ATTACK_RANGE)
		{
			PLAYERS_NEAR = 1;
		}
		if (GetEntityRange(CUR_PLAYER) < 2048)
		{
			PLAYERS_INRANGE = 1;
		}
		PNEAR_LOOP_COUNT += 1;
	}

	void do_special()
	{
		string NEXT_TRY = FREQ_SPECIAL;
		if ((SUSPEND_AI))
		{
			float NEXT_TRY = 5.0;
			int ABORT_SPECIAL = 1;
		}
		NEXT_TRY("do_special");
		if ((ABORT_SPECIAL)) return;
		CUR_SPECIAL += 1;
		if (CUR_SPECIAL > 3)
		{
			CUR_SPECIAL = 1;
		}
		if (CUR_SPECIAL == 1)
		{
			do_tornado();
		}
		if (CUR_SPECIAL == 2)
		{
			do_lstorm();
		}
		if (CUR_SPECIAL == 3)
		{
			do_throw();
		}
	}

	void sword_return()
	{
		SetModelBody(2, 8);
		AM_UNARMED = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		UseTrigger("towndoors01");
		if (((BLOOD_DRINKER_ID !is null)))
		{
			CallExternal(BLOOD_DRINKER_ID, "ext_remove");
		}
		SetModelBody(2, 0);
		CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()));
		repell_burst(GetEntityOrigin(GetOwner()), BARRIER_RAD, 0);
		ClientEvent("new", "all", "sorc_palace/sorc_chief_cl", GetEntityIndex(GetOwner()), 128, Vector3(255, 0, 0), 3.0, 1);
	}

}

}
