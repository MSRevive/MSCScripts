#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SorcChief2 : CGameScript
{
	int AM_LEAPING;
	int AM_UNARMED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BD_ID;
	int CAN_FLINCH;
	int CUR_SPECIAL;
	int CYCLES_STARTED;
	string DOUBLE_FOR;
	string DOUBLE_UP;
	float FREQ_LEAP;
	int GAVE_SWORD;
	int JUMP_FWD_DIST;
	int KICK_DELAY;
	string LAST_SWORD_HIT;
	string LAST_TELE;
	string LEAP_DELAY;
	int MALDORA_DEAD;
	string MALDORA_ID;
	string MINION_TO_ZAP;
	int MOVE_RANGE;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int RENDER_COUNT;
	string RETURN_POINT;
	int STUCK_TELE;
	int SWORD_ATTACK;
	string TALK_TARGET;
	string T_BOX;
	int ZAPPED_MINION;

	SorcChief2()
	{
		const float MIN_TELEPORT_DELAY = 15.0;
		const int NPC_USES_LIGHTS = 1;
		NPC_GIVE_EXP = 0;
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
		const string FREQ_SPECIAL = RandomInt(20, 40);
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
		Precache("doors/aliendoor3.wav");
		Precache("magic/spawn.wav");
		Precache("zombie/claw_miss2.wav");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(8, 15));
		if (m_hAttackTarget == "unset")
		{
			npcatk_settarget(MALDORA_ID);
		}
		T_BOX = /* TODO: $get_tbox */ $get_tbox("enemy", 1024);
		if (T_BOX != "none")
		{
		}
		ZAPPED_MINION = 0;
		for (int i = 0; i < T_BOX; i++)
		{
			check_for_lminion();
		}
		if ((IsEntityAlive(MINION_TO_ZAP)))
		{
			zap_minion(MINION_TO_ZAP);
		}
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
		STUCK_TELE = 1;
		do_teleport("stuck_count");
	}

	void OnSpawn() override
	{
		SetName("Runegahr , Shadahar Orc Chieftain");
		SetRace("human");
		SetHealth(8000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("stun", 0.25);
		SetHearingSensitivity(10);
		SetModel("monsters/sorc.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 8);
		SetStat("parry", 150);
		SetWidth(32);
		SetHeight(96);
		SetRoam(true);
		SetSayTextRange(2048);
		SWORD_ATTACK = 0;
		JUMP_FWD_DIST = 250;
		CUR_SPECIAL = 0;
		ScheduleDelayedEvent(1.0, "get_teleporters");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!((GetEntityName(param1)).findFirst("Lightning") >= 0)) return;
		zap_minion(param1);
	}

	void cycle_npc()
	{
		cycle_up();
	}

	void cycle_up()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		FREQ_SPECIAL("do_special");
		ScheduleDelayedEvent(60.0, "do_teleport");
		SetRoam(true);
		SayText("Now , Maldora! With these allies I shall defeat you!");
		EmitSound(GetOwner(), 0, SOUND_ATTACK2, 10);
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
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SMASH, ATTACK_HITCHANCE, "dark");
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
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SLASH, ATTACK_HITCHANCE, "dark");
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
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KICK, ATTACK_HITCHANCE, "blunt");
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

	void OnDamage(int damage) override
	{
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

	void warcry_done()
	{
		CAN_FLINCH = 1;
		if ((SUSPEND_AI))
		{
			npcatk_resume_ai();
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

	void do_teleport()
	{
		if ((MALDORA_DEAD)) return;
		SpawnNPC("monsters/summon/ibarrier", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 64, 2, 0, 0, 0, 1
		leap_tele();
	}

	void leap_tele()
	{
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		SetMoveDest(/* TODO: $relpos */ $relpos(0, 0, 1000));
		ScheduleDelayedEvent(0.1, "do_leap");
		RENDER_COUNT = 255;
		ScheduleDelayedEvent(0.1, "flicker_out");
		ScheduleDelayedEvent(0.25, "tele_out");
		ScheduleDelayedEvent(4.5, "tele_in_barrier");
		ScheduleDelayedEvent(5.0, "tele_in");
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
		RETURN_POINT = GetMonsterProperty("origin");
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		SetEntityOrigin(GetOwner(), Vector3(-20000, 10000, -20000));
	}

	void tele_in_barrier()
	{
		string RETURN_BAR = RETURN_POINT;
		RETURN_BAR = "z";
		SpawnNPC("monsters/summon/ibarrier", RETURN_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 64, 2, 0, 0, 0, 1
	}

	void tele_in()
	{
		SetEntityOrigin(GetOwner(), RETURN_POINT);
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		RENDER_COUNT = 0;
		flicker_in();
		LAST_TELE = GetGameTime();
		HealEntity(GetOwner(), 2000);
		if (!(STUCK_TELE))
		{
			ScheduleDelayedEvent(120.0, "do_teleport");
		}
		if ((STUCK_TELE))
		{
			STUCK_TELE = 0;
		}
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
		do_throw2();
	}

	void do_throw2()
	{
		SetModelBody(2, 0);
		AM_UNARMED = 1;
		PlayAnim("critical", ANIM_SWIPE);
		SpawnNPC("monsters/summon/blood_drinker", /* TODO: $relpos */ $relpos(0, 48, 48), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), MALDORA_ID, 100, 30.0
		BD_ID = GetEntityIndex(m_hLastCreated);
	}

	void do_special()
	{
		if ((MALDORA_DEAD)) return;
		string NEXT_TRY = FREQ_SPECIAL;
		if ((SUSPEND_AI))
		{
			float NEXT_TRY = 5.0;
			int ABORT_SPECIAL = 1;
		}
		NEXT_TRY("do_special");
		if ((ABORT_SPECIAL)) return;
		do_throw();
	}

	void sword_return()
	{
		SetModelBody(2, 8);
		AM_UNARMED = 0;
	}

	void do_nadda()
	{
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		UseTrigger("sorc_defeat");
	}

	void check_for_lminion()
	{
		string CUR_NME = GetToken(T_BOX, i, ";");
		string CUR_NAME = GetEntityName(CUR_NME);
		if (!((CUR_NAME).findFirst("Lightning") >= 0)) return;
		MINION_TO_ZAP = CUR_NME;
	}

	void zap_minion()
	{
		SayText("Maldora! Your minions are pathetic!");
		EmitSound(GetOwner(), 0, "weather/lightning.wav", 10);
		Effect("beam", "ents", "lgtning.spr", 100, GetOwner(), 1, param1, 0, Vector3(255, 255, 0), 255, 30, 3.0);
		CallExternal(param1, "npc_suicide");
	}

	void game_dynamically_created()
	{
		MALDORA_ID = param1;
		SetMoveDest(MALDORA_ID);
		ScheduleDelayedEvent(0.1, "cycle_up");
	}

	void maldora_final_died()
	{
		npcatk_suspend_ai();
		MALDORA_DEAD = 1;
		SetMenuAutoOpen(1);
		if ((IsEntityAlive(BD_ID)))
		{
			DeleteEntity(BD_ID);
		}
		sword_return();
		CatchSpeech("say_hi", "hail");
	}

	void game_menu_getoptions()
	{
		if (!(MALDORA_DEAD)) return;
		if ((GAVE_SWORD)) return;
		string reg.mitem.title = "Demand Reward";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_sword";
	}

	void say_hi()
	{
		SetMoveDest(GetEntityIndex("ent_lastspoke"));
		SayText("I got something you want , human?");
		OpenMenu(GetEntityIndex("ent_lastspoke"));
	}

	void say_sword()
	{
		if ((GAVE_SWORD)) return;
		TALK_TARGET = param1;
		SetMoveDest(TALK_TARGET);
		SetRoam(false);
		if (!(MALDORA_DEAD)) return;
		SayText("Since you were the first to have the guts to ask , here you are , as promised.");
		SetModelBody(2, 0);
		ScheduleDelayedEvent(4.0, "say_sword2");
		GAVE_SWORD = 1;
		// TODO: offer PARAM1 swords_blood_drinker
	}

	void say_sword2()
	{
		SetMoveDest(TALK_TARGET);
		SayText("Worry not , I have a spare back at the palace... A couple spares , actually.");
		ScheduleDelayedEvent(4.0, "say_sword3");
	}

	void say_sword3()
	{
		SetMoveDest(TALK_TARGET);
		SayText("If you ever dare to step foot within the walls of the palace , be sure to find me.");
		ScheduleDelayedEvent(4.0, "say_sword4");
	}

	void say_sword4()
	{
		SetMoveDest(TALK_TARGET);
		SayText("You maybe lowly human s, but you ve proven yourself true warriors all. Our doors are always open to true warriors.");
		ScheduleDelayedEvent(4.0, "say_sword4b");
	}

	void say_sword4b()
	{
		SetMoveDest(TALK_TARGET);
		SayText("...but when you do visit us , be sure to show me that sword. All you human s look alike to me.");
		ScheduleDelayedEvent(4.0, "say_sword5");
	}

	void say_sword5()
	{
		SetMoveDest(TALK_TARGET);
		SayText("That having been said , I must leave before this citidel comes crashing down - I suggest you do the same.");
		PlayAnim("critical", "warcry");
		ScheduleDelayedEvent(3.0, "final_tele_out");
	}

	void final_tele_out()
	{
		SetMoveDest(TALK_TARGET);
		SayText("Sorry I can t take you with me...");
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		SpawnNPC("monsters/summon/ibarrier", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 64, 2, 0, 0, 0, 1
		ScheduleDelayedEvent(0.1, "fade_away");
	}

	void fade_away()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
