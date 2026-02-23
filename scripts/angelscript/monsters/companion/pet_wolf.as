#pragma context server

#include "monsters/companion/base_companion.as"
#include "monsters/summon/base_summon.as"

namespace MS
{

class PetWolf : CGameScript
{
	string ACT_NAME;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	string COMPANION_TYPE;
	string FLINCH_ANIM;
	int IS_COMPANION;
	int IS_HIRED;
	int MELEE_ATTACK;
	string NEXT_HOWL;
	string NEXT_REFACE;
	string NO_STUCK_CHECKS;
	int NPC_NO_PLAYER_DMG;
	string NPC_REVIVAL_SCRIPT;
	string PET_LAST_ATTACK;
	int SEARCH_DELAY;
	int SIT_MODE;

	PetWolf()
	{
		IS_COMPANION = 1;
		const int SUMMON_CIRCLE_INDEX = 13;
		const int SUMMON_RUN_DIST = 160;
		const string ANIM_WALK_BASE = "walk_wolf";
		const string ANIM_RUN_BASE = "run_wolf";
		const int BASE_HP = 150;
		IS_HIRED = 1;
		const int SUM_NO_TALK = 1;
		const int COMPANION_MAXHP = 3000;
		const int MAX_DMG = 50;
		const float XPDMG_MULTI = 0.01;
		const int BASE_DMG = 4;
		COMPANION_TYPE = "wolf";
		ACT_NAME = "pet wolf";
		NPC_REVIVAL_SCRIPT = currentscript;
		const string SOUND_TELE = "monsters/wolves/wolf_atk2.wav";
		const int HOVER_FAR = 256;
		const int HOVER_CLOSE = 128;
		ANIM_WALK = "walk_wolf";
		ANIM_RUN = "run_wolf";
		ANIM_IDLE = "standidle1";
		ANIM_DEATH = "die1";
		ANIM_ATTACK = "attack1";
		ANIM_FLINCH = "hopback";
		const string ANIM_LEAP = "attack2";
		const string ANIM_CLAW = "attack2";
		const string ANIM_HOWL = "howl";
		const string ANIM_ALERT = "threat";
		const string ANIM_IDLE_SIT = "sit_idle1";
		const string ANIM_IDLE_SIT2 = "sit_idle2";
		const string ANIM_IDLE_STAND = "standidle1";
		const string ANIM_IDLE_STAND2 = "standidle2";
		const string ANIM_IDLE_STAND3 = "guard";
		const string ANIM_TOSTAND = "standup";
		const string ANIM_BITE = "attack1";
		const string ANIM_CLAW = "attack2";
		const string ANIM_EAT = "eat";
		const string ANIM_FLINCH1 = "hopback";
		const string ANIM_FLINCH2 = "pain1";
		const string ANIM_FLINCH3 = "pain2";
		ATTACK_RANGE = 92;
		ATTACK_HITRANGE = 128;
		ATTACK_MOVERANGE = 72;
		const int NPC_BATTLE_ALLY = 1;
		NPC_NO_PLAYER_DMG = 1;
		const int ATTACK_HITCHANCE = 70;
		const int LEAP_RANGE = 256;
		const string DMG_BITE = Random(3.0, 6.0);
		const string DMG_CLAW = Random(4.0, 5.0);
		const float FREQ_LOOK = 20.0;
		const string FREQ_IDLE = Random(10, 30);
		const string FREQ_HOWL = Random(30, 60);
		const int CHANCE_CLAW = 50;
		const string SOUND_HOWL1 = "monsters/wolves/wolf_howl1.wav";
		const string SOUND_HOWL2 = "monsters/wolves/wolf_howl2.wav";
		const string SOUND_GROWL = "monsters/wolves/wolf_alert.wav";
		const string SOUND_ATK1 = "monsters/wolves/wolf_atk1.wav";
		const string SOUND_ATK2 = "monsters/wolves/wolf_atk2.wav";
		const string SOUND_ATK3 = "monsters/wolves/wolf_atk3.wav";
		const string SOUND_PAIN = "monsters/wolves/wolf_yelp1.wav";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_YELP = "monsters/wolves/wolf_yelp2.wav";
		const string SOUND_DEATH = "monsters/wolves/wolf_death.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_IDLE);
		if (!(SUSPEND_AI))
		{
		}
		if (!(AM_ALPHA))
		{
			if (MY_ALPHA != "unset")
			{
			}
			npcatk_setmovedest(G_ALPHA, ATTACK_MOVERANGE);
		}
		if (m_hAttackTarget == "unset")
		{
		}
		if (GetGameTime() > NEXT_HOWL)
		{
			LogDebug("idle howl");
			NEXT_HOWL = GetGameTime();
			NEXT_HOWL += FREQ_HOWL;
			do_howl();
			int EXIT_SUB = 1;
		}
		if (!(EXIT_SUB))
		{
		}
		if ((SIT_MODE))
		{
			NO_STUCK_CHECKS = 1;
			PlayAnim("critical", ANIM_IDLE_SIT2);
		}
		else
		{
			NO_STUCK_CHECKS = 0;
			string RND_IDLE = RandomInt(1, 2);
			if (RND_IDLE == 1)
			{
				atk_sound();
				PlayAnim("critical", ANIM_IDLE_STAND2);
				AS_ATTACKING = GetGameTime();
			}
			if (RND_IDLE == 2)
			{
				EmitSound(GetOwner(), 0, SOUND_GROWL, 10);
				PlayAnim("critical", ANIM_IDLE_STAND3);
				AS_ATTACKING = GetGameTime();
			}
		}
		if ((AM_ALPHA))
		{
		}
		if (RandomInt(1, 2) == 1)
		{
		}
		if (!(GUARD_MODE))
		{
		}
		if ((SIT_MODE))
		{
			ScheduleDelayedEvent(0.5, "sitmode_off");
		}
		if (!(SIT_MODE))
		{
			ScheduleDelayedEvent(0.5, "sitmode_on");
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(15.0);
		if (GetGameTime() > COMPANION_NEXT_REGEN)
		{
		}
		if (m_hAttackTarget == "unset")
		{
		}
		if (GetEntityHealth(GetOwner()) < GetEntityMaxHealth(GetOwner()))
		{
		}
		string TEN_PERCENT = GetEntityMaxHealth(GetOwner());
		TEN_PERCENT *= 0.1;
		HealEntity(GetOwner(), TEN_PERCENT);
		sitmode_on();
	}

	void pet_spawn()
	{
		SetName("pet wolf");
		SetRace("human");
		SetModel("monsters/giant_rat.mdl");
		SetModelBody(0, 1);
		SetHearingSensitivity(8);
		SetWidth(36);
		SetHeight(48);
		SetRoam(false);
		SetHealth(BASE_HP);
		NEXT_HOWL = 0;
		CatchSpeech("say_sit", "sit");
		CatchSpeech("say_speak", "speak");
	}

	void OnPostSpawn() override
	{
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
	}

	void sitmode_off()
	{
		if ((SIT_MODE))
		{
			PlayAnim("critical", ANIM_TOSTAND);
		}
		SIT_MODE = 0;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
	}

	void sitmode_on()
	{
		SIT_MODE = 1;
		SetMoveAnim(ANIM_IDLE_SIT);
		SetIdleAnim(ANIM_IDLE_SIT);
	}

	void bite1()
	{
		PET_LAST_ATTACK = GetGameTime();
		ATTACK_TYPE = "bite";
		string DMG_FINAL = DMG_BITE;
		string ADD_DMG = COMPANION_XP;
		ADD_DMG *= XPDMG_MULTI;
		DMG_FINAL += ADD_DMG;
		if (DMG_FINAL > MAX_DMG)
		{
			string DMG_FINAL = MAX_DMG;
		}
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_FINAL, ATTACK_HITCHANCE, "slash");
		atk_sound();
		if (RandomInt(1, 100) < CHANCE_CLAW)
		{
			ANIM_ATTACK = ANIM_CLAW;
		}
		MELEE_ATTACK = 1;
	}

	void claw1()
	{
		ATTACK_TYPE = "claw";
		string DMG_FINAL = DMG_CLAW;
		string ADD_DMG = COMPANION_XP;
		ADD_DMG *= XPDMG_MULTI;
		DMG_FINAL += ADD_DMG;
		if (DMG_FINAL > MAX_DMG)
		{
			string DMG_FINAL = MAX_DMG;
		}
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_FINAL, ATTACK_HITCHANCE, "slash");
		atk_sound();
		MELEE_ATTACK = 1;
		ANIM_ATTACK = ANIM_BITE;
	}

	void do_howl()
	{
		if ((IsEntityAlive(GetOwner())))
		{
			PlayAnim("critical", ANIM_HOWL);
		}
		// PlayRandomSound from: SOUND_HOWL1, SOUND_HOWL2
		array<string> sounds = {SOUND_HOWL1, SOUND_HOWL2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npcatk_lost_sight()
	{
		if ((false)) return;
		if ((SEARCH_DELAY)) return;
		SEARCH_DELAY = 1;
		EmitSound(GetOwner(), 0, SOUND_GROWL, 10);
		FREQ_LOOK("reset_search_delay");
		do_howl();
	}

	void reset_search_delay()
	{
		SEARCH_DELAY = 0;
	}

	void OnFlinch()
	{
		string RND_FLINCH = RandomInt(1, 5);
		if (RND_FLINCH == 1)
		{
			FLINCH_ANIM = ANIM_FLINCH2;
		}
		if (RND_FLINCH == 2)
		{
			FLINCH_ANIM = ANIM_FLINCH3;
		}
		if (RND_FLINCH > 2)
		{
			FLINCH_ANIM = ANIM_FLINCH1;
		}
		EmitSound(GetOwner(), 0, SOUND_YELP, 10);
	}

	void cycle_up()
	{
		if ((SIT_MODE))
		{
			sitmode_off();
		}
	}

	void atk_sound()
	{
		// PlayRandomSound from: SOUND_ATK1, SOUND_ATK2, SOUND_ATK3
		array<string> sounds = {SOUND_ATK1, SOUND_ATK2, SOUND_ATK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		string HALF_HEALTH = GetEntityMaxHealth(GetOwner());
		HALF_HEALTH *= 0.5;
		string QUART_HEALTH = GetEntityMaxHealth(GetOwner());
		QUART_HEALTH *= 0.25;
		if (GetEntityHealth(GetOwner()) > HALF_HEALTH)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			if (GetEntityHealth(GetOwner()) > QUART_HEALTH)
			{
				// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN
				array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			else
			{
				// PlayRandomSound from: SOUND_PAIN
				array<string> sounds = {SOUND_PAIN};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (ATTACK_TYPE == "bite")
		{
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-50, 110, 105));
		}
		if (ATTACK_TYPE == "claw")
		{
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-100, 130, 120));
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string RND_DEATH = RandomInt(1, 2);
		if (RND_DEATH == 1)
		{
			ANIM_DEATH = "die1";
		}
		if (RND_DEATH == 2)
		{
			ANIM_DEATH = "die2";
		}
	}

	void my_target_died()
	{
		if ((false)) return;
		PlayAnim("once", ANIM_EAT);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SendInfoMsg(SUMMON_MASTER, "YOUR PET HAS BEEN SLAIN! COMPANION_NAME has been slain!");
		summon_death();
		bcompanion_un_regme();
	}

	void bs_set_guard_mode()
	{
		EmitSound(GetOwner(), 0, SOUND_ATK2, 10);
		sitmode_on();
	}

	void bs_set_hunt_mode()
	{
		EmitSound(GetOwner(), 0, SOUND_ATK2, 10);
		sitmode_off();
		bs_set_defend_mode();
	}

	void bs_set_follow_mode()
	{
		EmitSound(GetOwner(), 0, SOUND_ATK2, 10);
		sitmode_off();
	}

	void bs_set_defend_mode()
	{
		EmitSound(GetOwner(), 0, SOUND_ATK2, 10);
		sitmode_off();
	}

	void basesummon_say_report()
	{
		if (param2 != "from_menu")
		{
			if (GetEntityIndex("ent_lastspoke") != SUMMON_MASTER)
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (ATK_MIN == "ATK_MIN")
		{
			string ATK_MIN = DMG_MAX;
		}
		string ME_HEALTH = GetMonsterHP();
		string ME_MAX_HEALTH = GetMonsterMaxHP();
		string HEALTH_STRING = "(";
		HEALTH_STRING += ME_HEALTH;
		HEALTH_STRING += "/";
		HEALTH_STRING += ME_MAX_HEALTH;
		HEALTH_STRING += ")";
		string DMG_FINAL = BASE_DMG;
		string ADD_DMG = COMPANION_XP;
		ADD_DMG *= XPDMG_MULTI;
		DMG_FINAL += ADD_DMG;
		if (DMG_FINAL > MAX_DMG)
		{
			string DMG_FINAL = MAX_DMG;
		}
		string ME_STRENGTH = DMG_FINAL;
		SetSayTextRange(1024);
		SayText("[status] HP HEALTH_STRING DMG/ATK: ME_STRENGTH XP: int(COMPANION_XP)");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		cliff_check();
		if ((SUSPEND_AI)) return;
		if (!(m_hAttackTarget == "unset")) return;
		if (!(IsEntityAlive(SUMMON_MASTER))) return;
		string ESCORT_DIST = GetEntityRange(SUMMON_MASTER);
		if (ESCORT_DIST > 128)
		{
			if ((SIT_MODE))
			{
				sitmode_off();
			}
			NEXT_REFACE = GetGameTime();
			NEXT_REFACE += 2.0;
			NO_STUCK_CHECKS = 0;
			npcatk_setmovedest(SUMMON_MASTER, 128);
			if (ESCORT_DIST > SUMMON_RUN_DIST)
			{
				SetMoveAnim(ANIM_RUN);
			}
			else
			{
				SetMoveAnim(ANIM_WALK);
			}
		}
		else
		{
			NO_STUCK_CHECKS = 1;
			if (GetGameTime() > NEXT_REFACE)
			{
			}
			SetMoveDest("none");
			string ESCORT_FACE = GetEntityProperty(SUMMON_MASTER, "angles.yaw");
			SetAngles("face");
		}
	}

	void game_targeted_by_player()
	{
		LogDebug("game_targeted_by_player GetEntityName(param1)");
		CallExternal(param1, "ext_show_hbar_monster", GetEntityIndex(GetOwner()), 1);
	}

	void OnDamage(int damage) override
	{
		if (!(SIT_MODE)) return;
		SetIdleAnim(ANIM_IDLE);
	}

	void summon_cycle()
	{
	}

	void cliff_check()
	{
		if ((IsOnGround(GetOwner()))) return;
		string TRACE_START = GetEntityOrigin(GetOwner());
		TRACE_START += "z";
		string TRACE_END = TRACE_START;
		TRACE_END += "z";
		if (!(TraceLine(TRACE_START, TRACE_END) == TRACE_END)) return;
		LogDebug("OMG cliff!");
		basecompanion_catchup(1);
	}

	void npcatk_anti_stuck()
	{
		if (!(STUCK_COUNT > 1)) return;
		basecompanion_catchup();
	}

	void say_sit()
	{
		PlayAnim("hold", ANIM_IDLE_SIT);
	}

	void say_speak()
	{
		EmitSound(GetOwner(), 0, "monsters/wolves/wolf_alert.wav", 10);
	}

}

}
