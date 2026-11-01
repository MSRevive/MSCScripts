#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class BaseSummon : CGameScript
{
	string ACT_NAME;
	string ANIM_RUN;
	string ANIM_RUN_BASE;
	string ANIM_WALK;
	string ANIM_WALK_BASE;
	string AS_LAST_ORIGIN;
	int CAN_RETALIATE;
	int CYCLED_UP;
	string CYCLE_TIME;
	float CYCLE_TIME_BATTLE;
	float CYCLE_TIME_IDLE;
	float CYCLE_TIME_NPC;
	int DEFEND_MODE;
	int DEFEND_RANGE;
	int FOLLOW_MASTER;
	int GUARD_MODE;
	string GUARD_POS;
	int HOVER_CLOSE;
	string HOVER_DISTANCE;
	int HOVER_FAR;
	int IGNORE_TARGETS;
	string IS_HIRED;
	string I_R_PET;
	int KILL_MODE;
	string NAMEPREFIX;
	string NO_STUCK_CHECKS;
	string NPCATK_TARGET;
	string NPC_ATTACK_TARGET;
	int NPC_FORCED_MOVEDEST;
	string NPC_MOVE_TARGET;
	string OWNER_TARGET;
	int STUCK_CHECKING;
	int SUMMON_CIRCLE_INDEX;
	string SUMMON_LAST_TARG;
	string SUMMON_LAST_TARG_NOTICE;
	string SUMMON_MASTER;
	int SUMMON_RUN_DIST;
	int SUMMON_VICINITY;
	string SUM_REPORT_SUFFIX;
	string SUM_SAY_ATTACK;
	string SUM_SAY_COME;
	string SUM_SAY_DEATH;
	string SUM_SAY_DEFEND;
	string SUM_SAY_GUARD;
	string SUM_SAY_HUNT;

	BaseSummon()
	{
		SUMMON_CIRCLE_INDEX = 3;
		SUMMON_RUN_DIST = 256;
		SUM_SAY_COME = "Coming sir.";
		SUM_SAY_ATTACK = "Attacking target.";
		SUM_SAY_HUNT = "Hunting, sir.";
		SUM_SAY_DEFEND = "Defending you.";
		SUM_SAY_DEATH = "Arrrrrrrrgghh!";
		SUM_SAY_GUARD = "I shall guard this position with my life.";
		SUM_REPORT_SUFFIX = ", sir.";
		ANIM_WALK_BASE = "walk";
		ANIM_RUN_BASE = "run";
		DEFEND_RANGE = 256;
		CAN_RETALIATE = 0;
		HOVER_FAR = 128;
		HOVER_CLOSE = 64;
		Precache("xflare1.spr");
		CYCLE_TIME_BATTLE = 0.1;
		CYCLE_TIME_IDLE = 0.1;
		CYCLE_TIME_NPC = 0.1;
		SUMMON_VICINITY = 400;
	}

	void OnSpawn() override
	{
		SetMonsterClip(0);
		if ((StringToLower(GetMapName())).findFirst("sfor") >= 0)
		{
			SetMonsterClip(1);
		}
		CatchSpeech("basesummon_say_come", "come");
		CatchSpeech("basesummon_say_defend", "defend");
		CatchSpeech("basesummon_say_attacktarget", "kill");
		CatchSpeech("basesummon_say_attackall", "attack");
		CatchSpeech("basesummon_say_report", "status");
		CatchSpeech("basesummon_say_dismiss", "dismiss");
		CatchSpeech("basesummon_say_guard", "guard");
		SetMenuAutoOpen(1);
		summon_cycle();
		summon_spawn();
	}

	void OnPostSpawn() override
	{
		HOVER_DISTANCE = HOVER_FAR;
	}

	void game_dynamically_created()
	{
		SUMMON_MASTER = param1;
		if ((SUMMON_UNIQUE))
		{
			CallExternal(SUMMON_MASTER, "ext_summon_unique", SUMMON_UNIQUE_TAG);
		}
		if ((IsValidPlayer(SUMMON_MASTER)))
		{
			IS_HIRED = 1;
			I_R_PET = 1;
		}
		ScheduleDelayedEvent(1.0, "bs_set_defend_mode");
		pre_name_set();
		if (!(IS_COMPANION))
		{
			ACT_NAME = GetEntityName(GetOwner());
			NAMEPREFIX = GetEntityName(SUMMON_MASTER);
			NAMEPREFIX += "'s";
			NAMEPREFIX += " ";
			NAMEPREFIX += GetEntityName(GetOwner());
			SetName(NAMEPREFIX);
		}
		else
		{
			ext_companion_update_name();
		}
		ScheduleDelayedEvent(0.1, "summon_circle");
		ScheduleDelayedEvent(0.5, "basesummon_delayedspawneffect");
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		string OUT_PAR3 = param3;
		string OUT_PAR4 = param4;
		string OUT_PAR5 = param5;
		string OUT_PAR6 = param6;
		string OUT_PAR7 = param7;
		string OUT_PAR8 = param8;
		string OUT_PAR9 = param9;
		summon_summoned(OUT_PAR1, OUT_PAR2, OUT_PAR3, OUT_PAR4, OUT_PAR5, OUT_PAR6, OUT_PAR7, OUT_PAR8, OUT_PAR9);
		STUCK_CHECKING = 1;
		AS_LAST_ORIGIN = GetMonsterProperty("origin");
	}

	void summon_circle()
	{
		string CIRCLE_POS = GetEntityOrigin(GetOwner());
		CIRCLE_POS = "z";
		ClientEvent("new", "all", "effects/sfx_summon_circle", CIRCLE_POS, SUMMON_CIRCLE_INDEX);
	}

	void summon_summoned()
	{
		if (!(I_R_PET)) return;
		LogDebug("summon_summoned help_summons");
		string TEXT = "You've Summoned your first monster";
		TEXT += "|You can control all your summons globally with the following say commands:";
		TEXT += "|all hunt";
		TEXT += "|all follow";
		TEXT += "|all vanish";
		ShowHelpTip(SUMMON_MASTER, "help_summons", "Monster Summons", TEXT);
	}

	void basesummon_say_come()
	{
		if (param2 != "from_menu")
		{
			if (GetEntityIndex("ent_lastspoke") != SUMMON_MASTER)
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		SetSayTextRange(1024);
		if (!(SUM_NO_TALK))
		{
			SayText(SUM_SAY_COME);
		}
		if ((IsEntityAlive(m_hAttackTarget)))
		{
			SendColoredMessage(SUMMON_MASTER, ACT_NAME + " disengaging battle");
		}
		else
		{
			SendColoredMessage(SUMMON_MASTER, ACT_NAME + " following and non-agro");
		}
		summon_acknowledge("follow");
		npcatk_clear_targets();
		nocatk_suspend_ai(1.0);
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(SUMMON_MASTER);
		bs_set_follow_mode();
		summon_come();
	}

	void basesummon_say_attacktarget()
	{
		if (param2 != "from_menu")
		{
			if (GetEntityIndex("ent_lastspoke") != SUMMON_MASTER)
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		OWNER_TARGET = GetEntityProperty(SUMMON_MASTER, "target");
		if (!((OWNER_TARGET !is null))) return;
		bs_set_hunt_mode();
		KILL_MODE = 1;
		npcatk_clear_targets();
		if (OWNER_TARGET != GetOwner())
		{
			if (GetRelationship(GetOwner()) != "ally")
			{
			}
			npcatk_settarget(OWNER_TARGET);
		}
		SetSayTextRange(1024);
		if (!(SUM_NO_TALK))
		{
			SayText(SUM_SAY_ATTACK);
		}
		SendColoredMessage(SUMMON_MASTER, ACT_NAME + " attacking target");
		summon_acknowledge("attack");
		NPC_MOVE_TARGET = OWNER_TARGET;
		NPC_ATTACK_TARGET = OWNER_TARGET;
		SetMoveDest(NPC_MOVE_TARGET);
	}

	void basesummon_say_attackall()
	{
		if (param2 != "from_menu")
		{
			if (GetEntityIndex("ent_lastspoke") != SUMMON_MASTER)
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		SetSayTextRange(1024);
		if (!(SUM_NO_TALK))
		{
			SayText(SUM_SAY_HUNT);
		}
		SendColoredMessage(SUMMON_MASTER, ACT_NAME + " seeking enemies");
		summon_acknowledge("hunt");
		PlayAnim("once", ANIM_WALK);
		bs_set_hunt_mode();
		if ((false)) return;
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(SUMMON_MASTER);
	}

	void basesummon_say_defend()
	{
		if (param2 != "from_menu")
		{
			if (GetEntityIndex("ent_lastspoke") != SUMMON_MASTER)
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		SetSayTextRange(1024);
		if (!(SUM_NO_TALK))
		{
			SayText(SUM_SAY_DEFEND);
		}
		SendColoredMessage(SUMMON_MASTER, ACT_NAME + " set defensive mode");
		summon_acknowledge("defend");
		bs_set_defend_mode();
	}

	void basesummon_say_guard()
	{
		if (param2 != "from_menu")
		{
			if (GetEntityIndex("ent_lastspoke") != SUMMON_MASTER)
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		SetSayTextRange(1024);
		if (!(SUM_NO_TALK))
		{
			SayText(SUM_SAY_GUARD);
		}
		SendColoredMessage(SUMMON_MASTER, ACT_NAME + " holding location");
		summon_acknowledge("stay");
		bs_set_guard_mode();
	}

	void summon_cycle()
	{
		ScheduleDelayedEvent(2.0, "summon_cycle");
		if (!(IS_HIRED)) return;
		if (!(NO_STUCK_CHECKS))
		{
			string MIN_RANGE = GetMonsterProperty("moveprox");
			MIN_RANGE += 32;
			if (GetEntityRange(SUMMON_MASTER) > MIN_RANGE)
			{
			}
			NO_STUCK_CHECKS = 1;
		}
		if ((GUARD_MODE))
		{
			if (Distance(GetMonsterProperty("origin"), GUARD_POS) > HOVER_CLOSE)
			{
			}
			SetMoveAnim(ANIM_WALK);
			NPC_FORCED_MOVEDEST = 1;
			SetMoveDest(GUARD_POS);
		}
		if ((FOLLOW_MASTER))
		{
			if (GetEntityRange(SUMMON_MASTER) <= SUMMON_RUN_DIST)
			{
				if (m_hAttackTarget == "unset")
				{
					SetMoveAnim(ANIM_WALK);
				}
			}
			if (GetEntityRange(SUMMON_MASTER) > SUMMON_RUN_DIST)
			{
				SetMoveAnim(ANIM_RUN);
			}
			NPC_FORCED_MOVEDEST = 1;
			if (m_hAttackTarget == "unset")
			{
			}
			SetMoveDest(SUMMON_MASTER);
		}
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (m_hAttackTarget == SUMMON_MASTER)
		{
			NPCATK_TARGET = "unset";
		}
		if (GetEntityRace(m_hAttackTarget) == "hguard")
		{
			if (!(KILL_MODE))
			{
			}
			NPCATK_TARGET = "unset";
		}
		CYCLE_TIME = CYCLE_TIME_BATTLE;
		CYCLED_UP = 1;
		if ((DEFEND_MODE))
		{
			if (GetEntityRange(param1) > DEFEND_RANGE)
			{
				NPCATK_TARGET = "unset";
			}
		}
		if ((IGNORE_TARGETS))
		{
			NPCATK_TARGET = "unset";
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((SUMMON_UNIQUE))
		{
			CallExternal(SUMMON_MASTER, "ext_unsummon_unique", SUMMON_UNIQUE_TAG);
		}
		if (I_R_PET == 1)
		{
			CURRENT_SUMMONS -= 1;
		}
		SetSayTextRange(1024);
		if (RandomInt(1, 2) == 1)
		{
			if (!(SUM_NO_TALK))
			{
				if (SUM_SAY_DEATH != "none")
				{
				}
				SayText(SUM_SAY_DEATH);
			}
		}
		SendPlayerMessage(SUMMON_MASTER, "Your " + ACT_NAME + " has been slain!");
		summon_death();
		DeleteEntity(GetOwner(), true); // fade out
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
		string ME_HEALTH = GetMonsterHP();
		string ME_MAX_HEALTH = GetMonsterMaxHP();
		string HEALTH_STRING = ME_HEALTH;
		HEALTH_STRING += "/";
		HEALTH_STRING += ME_MAX_HEALTH;
		if (!(SUM_NO_TALK))
		{
			if (ATK_MIN == "ATK_MIN")
			{
				string ATK_MIN = DMG_MAX;
			}
			string ME_STRENGTH = ATK_MIN;
			ME_STREGTH += "/strike";
			SetSayTextRange(1024);
			SayText("My health is " + HEALTH_STRING + "and my attack strength is " + ME_STRENGTH + SUM_REPORT_SUFFIX);
		}
		summon_acknowledge("report");
		SendColoredMessage(SUMMON_MASTER, /* TODO: $stradd */ $stradd(ACT_NAME, ":") + "Health " + int(HEALTH_STRING) + "Attack " + int(SUMMON_DMG_BASE));
	}

	void basesummon_say_dismiss()
	{
		if ((I_R_COMPANION)) return;
		if (!(I_R_PET)) return;
		if (param2 != "from_menu")
		{
			if (GetEntityIndex("ent_lastspoke") != SUMMON_MASTER)
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		killme();
	}

	void killme()
	{
		if (I_R_PET == 1)
		{
			CURRENT_SUMMONS -= 1;
		}
		summon_unsummon();
		if ((SUMMON_UNIQUE))
		{
			CallExternal(SUMMON_MASTER, "ext_unsummon_unique", SUMMON_UNIQUE_TAG);
		}
		SetAlive(0);
		DeleteEntity(GetOwner(), true); // fade out
		RemoveScript();
		ClientEvent("remove", "all", GetEntityIndex(GetOwner()));
	}

	void bs_set_follow_mode()
	{
		LogDebug("bs_set_follow_mode");
		if (!(I_R_COMPANION))
		{
			SetRoam(true);
		}
		KILL_MODE = 0;
		NO_STUCK_CHECKS = 0;
		ANIM_WALK = ANIM_WALK_BASE;
		ANIM_RUN = ANIM_RUN_BASE;
		SetMoveAnim(ANIM_RUN);
		GUARD_MODE = 0;
		IGNORE_TARGETS = 1;
		DEFEND_MODE = 0;
		FOLLOW_MASTER = 1;
		HOVER_DISTANCE = HOVER_CLOSE;
	}

	void bs_set_hunt_mode()
	{
		LogDebug("bs_set_hunt_mode");
		if (!(I_R_COMPANION))
		{
			SetRoam(true);
		}
		KILL_MODE = 0;
		NO_STUCK_CHECKS = 0;
		ANIM_WALK = ANIM_WALK_BASE;
		ANIM_RUN = ANIM_RUN_BASE;
		SetMoveAnim(ANIM_RUN);
		GUARD_MODE = 0;
		IGNORE_TARGETS = 0;
		DEFEND_MODE = 0;
		FOLLOW_MASTER = 0;
	}

	void bs_set_defend_mode()
	{
		LogDebug("bs_set_defend_mode");
		SetRoam(false);
		NO_STUCK_CHECKS = 0;
		KILL_MODE = 0;
		ANIM_WALK = ANIM_WALK_BASE;
		ANIM_RUN = ANIM_RUN_BASE;
		SetMoveAnim(ANIM_RUN);
		GUARD_MODE = 0;
		IGNORE_TARGETS = 0;
		DEFEND_MODE = 1;
		FOLLOW_MASTER = 1;
		HOVER_DISTANCE = HOVER_FAR;
	}

	void bs_set_guard_mode()
	{
		LogDebug("bs_set_guard_mode");
		SetRoam(false);
		KILL_MODE = 0;
		NO_STUCK_CHECKS = 1;
		SetMoveAnim(ANIM_IDLE);
		ANIM_WALK = ANIM_IDLE;
		ANIM_RUN = ANIM_IDLE;
		GUARD_POS = GetMonsterProperty("origin");
		GUARD_MODE = 1;
		IGNORE_TARGETS = 0;
		DEFEND_MODE = 0;
		FOLLOW_MASTER = 0;
		HOVER_DISTANCE = HOVER_FAR;
	}

	void game_menu_getoptions()
	{
		if (!(param1 == SUMMON_MASTER)) return;
		if (!(IS_HIRED)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((COMPANION_CONFIRM_DISMISS))
		{
			ShowHelpTip(param1, "generic", "DISMISS PET", "Are you sure you want to abandon your pet?|Remember, you won't be able to get the pet back again.");
			SendColoredMessage(param1, "Confirm release of pet...");
			string reg.mitem.title = "Yes";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "from_menu";
			string reg.mitem.callback = "companion_release";
			string reg.mitem.title = "No";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "from_menu";
			string reg.mitem.callback = "companion_release_cancel";
		}
		if ((COMPANION_CONFIRM_DISMISS)) return;
		string reg.mitem.title = "Report Status";
		string reg.mitem.type = "callback";
		string reg.mitem.data = "from_menu";
		string reg.mitem.callback = "basesummon_say_report";
		if (m_hAttackTarget == "unset")
		{
			string reg.mitem.title = "Follow (Do Not Engage)";
		}
		else
		{
			string reg.mitem.title = "Disengage";
		}
		string reg.mitem.type = "callback";
		string reg.mitem.data = "from_menu";
		string reg.mitem.callback = "basesummon_say_come";
		string reg.mitem.title = "Defend";
		string reg.mitem.type = "callback";
		string reg.mitem.data = "from_menu";
		string reg.mitem.callback = "basesummon_say_defend";
		string reg.mitem.title = "Hunt";
		string reg.mitem.type = "callback";
		string reg.mitem.data = "from_menu";
		string reg.mitem.callback = "basesummon_say_attackall";
		string reg.mitem.title = "Stay Here";
		string reg.mitem.type = "callback";
		string reg.mitem.data = "from_menu";
		string reg.mitem.callback = "basesummon_say_guard";
		if (!(I_R_PET)) return;
		if (!(I_R_COMPANION))
		{
			string reg.mitem.title = "Unsummon";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "from_menu";
			string reg.mitem.callback = "basesummon_say_dismiss";
		}
		else
		{
			string reg.mitem.title = "Unsummon";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "from_menu";
			string reg.mitem.callback = "companion_unsummon";
			string reg.mitem.title = "Abandon Pet";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "from_menu";
			string reg.mitem.callback = "companion_abandon";
		}
	}

	void bs_unsolid()
	{
		SetSolid("none");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetAnimFrameRate(0.0);
		SetAnimMoveSpeed(0.0);
		SetMoveSpeed(0.0);
	}

	void bs_attempt_solid()
	{
		string MIN_RANGE = GetMonsterProperty("moveprox");
		MIN_RANGE += 15;
		if (!(GetEntityRange(SUMMON_MASTER) > MIN_RANGE)) return;
		SetSolid("box");
		SetProp(GetOwner(), "rendermode", 0);
		SetAnimFrameRate(1.0);
		SetAnimMoveSpeed(1.0);
		SetMoveSpeed(1.0);
	}

	void npc_monster_stuck()
	{
		string MIN_RANGE = GetMonsterProperty("moveprox");
		MIN_RANGE += 15;
		if (!(GetEntityRange(SUMMON_MASTER) < MIN_RANGE)) return;
		bs_unsolid();
		npcatk_suspend_ai(2.0);
		ScheduleDelayedEvent(2.0, "bs_attempt_solid");
	}

	void npc_found_new_target()
	{
		string TARG_NAME = GetEntityProperty(param1, "name.full");
		float LASTN_DIFF = GetGameTime();
		LASTN_DIFF -= SUMMON_LAST_TARG_NOTICE;
		if (!(LASTN_DIFF > 5)) return;
		SUMMON_LAST_TARG_NOTICE = GetGameTime();
		if (!(SUMMON_LAST_TARG != param1)) return;
		if ((I_R_PET))
		{
			SendPlayerMessage(SUMMON_MASTER, "Your " + ACT_NAME + "has targeted " + TARG_NAME);
		}
		SUMMON_LAST_TARG = param1;
	}

	void my_target_died()
	{
		if ((KILL_MODE))
		{
			KILL_MODE = 0;
			bs_set_defend_mode();
		}
	}

	void bs_global_command()
	{
		if (!(param1 == SUMMON_MASTER)) return;
		string CALLER_ID = param1;
		string IN_COMMAND = param2;
		if (IN_COMMAND == "follow")
		{
			basesummon_say_come(CALLER_ID, "from_menu");
		}
		if (IN_COMMAND == "defend")
		{
			basesummon_say_defend(CALLER_ID, "from_menu");
		}
		if (IN_COMMAND == "kill")
		{
			basesummon_say_attacktarget(CALLER_ID, "from_menu");
		}
		if (IN_COMMAND == "hunt")
		{
			basesummon_say_attackall(CALLER_ID, "from_menu");
		}
		if (IN_COMMAND == "vanish")
		{
			basesummon_say_dismiss(CALLER_ID, "from_menu");
		}
		if (IN_COMMAND == "stay")
		{
			basesummon_say_guard(CALLER_ID, "from_menu");
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (((SUMMON_MASTER !is null))) return;
		if (!(I_R_PET)) return;
		killme();
	}

}

}
