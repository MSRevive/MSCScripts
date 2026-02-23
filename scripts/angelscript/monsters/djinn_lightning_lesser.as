#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_lightning_shield.as"

namespace MS
{

class DjinnLightningLesser : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_RUN_DEFAULT;
	string ANIM_WALK;
	string ANIM_WALK_DEFAULT;
	string BEAM_ID;
	string BEAM_LIST;
	string BEAM_TARGET_LIST;
	int CAN_FLINCH;
	int CAN_LEAP;
	int CHAIN_COUNT;
	int CHAIN_ON;
	int CUR_BEAM;
	int DID_WARCRY;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	float FLINCH_CHANCE;
	float FLINCH_DELAY;
	int FLINCH_HEALTH;
	int HEADBUTT_DELAY;
	int HEADBUTT_ON;
	int LEAP_ENABLED;
	string NEXT_SHIELD;
	float NPC_DELAYING_UNSTUCK;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int ORC_JUMPING;
	int RUN_STEP;
	int SEARCH_ANIM_DELAY;
	int SWIPE_ATTACK;

	DjinnLightningLesser()
	{
		const float ORC_HOP_DELAY = 1.0;
		const int ORC_JUMP_THRESH = 80;
		NPC_GIVE_EXP = 800;
		const string ANIM_SEARCH = "idle_look";
		ANIM_IDLE = "idle1";
		const string ANIM_SWIPE = "attack1";
		const string ANIM_HEADBUTT = "attack2";
		const string ANIM_JUMP = "jump";
		const string ANIM_LEAP = "jump";
		ANIM_WALK_DEFAULT = "walk";
		ANIM_RUN_DEFAULT = "run1";
		ANIM_DEATH = "dieforward";
		const string ANIM_WARCRY = "warcry";
		ANIM_FLINCH = "bigflinch";
		ANIM_WALK = ANIM_WALK_DEFAULT;
		ANIM_RUN = ANIM_RUN_DEFAULT;
		ANIM_ATTACK = ANIM_SWIPE;
		const string SOUND_IDLE1 = "bullchicken/bc_idle1.wav";
		const string SOUND_IDLE2 = "bullchicken/bc_idle2.wav";
		const string SOUND_IDLE3 = "bullchicken/bc_idle3.wav";
		const string SOUND_IDLE4 = "bullchicken/bc_idle4.wav";
		const string SOUND_IDLE5 = "bullchicken/bc_idle5.wav";
		const string SOUND_DEATH = "bullchicken/bc_die1.wav";
		const string SOUND_HEADBUTT = "bullchicken/bc_spithit1.wav";
		const string SOUND_SWIPEHIT1 = "zombie/claw_strike1.wav";
		const string SOUND_SWIPEHIT2 = "zombie/claw_strike2.wav";
		const string SOUND_SWIPEMISS1 = "zombie/claw_miss1.wav";
		const string SOUND_SWIPEMISS2 = "zombie/claw_miss2.wav";
		const string SOUND_STRUCK1 = "debris/flesh1.wav";
		const string SOUND_STRUCK2 = "debris/flesh2.wav";
		const string SOUND_STEP1 = "player/pl_dirt1.wav";
		const string SOUND_STEP2 = "player/pl_dirt2.wav";
		const string SOUND_PAIN_WEAK = "bullchicken/bc_pain2.wav";
		const string SOUND_PAIN_STRONG = "bullchicken/bc_pain1.wav";
		const string SOUND_WARCRY = "bullchicken/bc_attackgrowl3.wav";
		const string SOUND_LEAP = "bullchicken/bc_attackgrowl2.wav";
		const string SOUND_LEAP_LAND = "weapons/g_bounce2.wav";
		const string SOUND_FLINCH = "bullchicken/bc_pain3.wav";
		Precache(SOUND_DEATH);
		const int WEAK_THRESHOLD = 1250;
		const string SWIPE_DAMAGE = "$rand(75,110)";
		const float HEADBUTT_CHANCE = 1.0;
		const float HEADBUTT_FREQ = 7.0;
		const string HEADBUTT_DAMAGE = "$rand(75,110)";
		const string LEAP_DAMAGE = "$rand(20,75)";
		const float LEAP_STUNCHANCE = 0.35;
		const int LEAP_RANGE_TOOFAR = 512;
		const int LEAP_RANGE_TOOCLOSE = 128;
		const int LEAP_AWAY_INTERVAL = 500;
		const int NEXT_LEAP_AWAY = 1800;
		const string FREQ_CHAIN = RandomInt(10, 40);
		const int CHANCE_SHOCK = 30;
		const string DMG_CHAIN = Random(2, 6);
		CAN_LEAP = 1;
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 30;
		DROP_GOLD_MAX = 50;
		const float ATTACK_HITCHANCE = 0.95;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 0.1;
		FLINCH_DELAY = 10.0;
		FLINCH_HEALTH = 1750;
		const int LSHIELD_PASSIVE = 0;
		const int LSHIELD_RADIUS = 120;
		const int DMG_LSHIELD = 60;
		const string FREQ_SHIELD = Random(30, 50);
		const string MONSTER_MODEL = "monsters/swamp_ogre.mdl";
		Precache(MONSTER_MODEL);
	}

	void OnSpawn() override
	{
		SetName("Lesser Lightning Djinn");
		SetHealth(2750);
		SetRace("demon");
		SetRoam(true);
		SetModel(MONSTER_MODEL);
		SetMoveAnim(ANIM_WALK);
		SetHeight(64);
		SetWidth(32);
		SetHearingSensitivity(2);
		SetBloodType("green");
		SetIdleAnim(ANIM_IDLE);
		RUN_STEP = 0;
		if (!(true)) return;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		CUR_BEAM = 0;
		BEAM_LIST = "";
		ScheduleDelayedEvent(0.1, "init_beam1");
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("all", 0.8);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("holy", 0.25);
		SetDamageResistance("poison", 1.5);
	}

	void npcatk_validatetarget()
	{
		if (!(IsValidPlayer(param1))) return;
		if ((DID_WARCRY)) return;
		PlayAnim("critical", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		DID_WARCRY = 1;
	}

	void my_target_died()
	{
		if (!(false))
		{
			PlayAnim("critical", ANIM_WARCRY);
			EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
			DID_WARCRY = 0;
			ScheduleDelayedEvent(1.0, "enable_leap");
		}
	}

	void enable_leap()
	{
		LEAP_ENABLED = 1;
	}

	void cycle_up()
	{
		FREQ_CHAIN("do_lightning");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(GetGameTime() > NEXT_SHIELD)) return;
		NEXT_SHIELD = GetGameTime();
		NEXT_SHIELD += FREQ_SHIELD;
		ext_lshield_on();
		if (GetMonsterHP() < GetMonsterMaxHP())
		{
			HealEntity(GetOwner(), 0.1);
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) <= LEAP_RANGE_TOOFAR)) return;
		if (!(GetEntityRange(m_hAttackTarget) > LEAP_RANGE_TOOCLOSE)) return;
		if (!(LEAP_ENABLED)) return;
		LEAP_ENABLED = 0;
		ScheduleDelayedEvent(5.0, "enable_leap");
		script_leap();
	}

	void script_leap()
	{
		PlayAnim("critical", ANIM_LEAP);
		ScheduleDelayedEvent(0.1, "leap_boost");
	}

	void leap_boost()
	{
		if ((I_R_FROZEN)) return;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 600, 100));
	}

	void npc_selectattack()
	{
		if ((HEADBUTT_DELAY))
		{
			ANIM_ATTACK = ANIM_SWIPE;
		}
		else
		{
			if (RandomInt(1, 100) < HEADBUTT_CHANCE)
			{
				ANIM_ATTACK = ANIM_HEADBUTT;
				HEADBUTT_DELAY = 1;
				HEADBUTT_FREQ("headbutt_reset");
			}
		}
	}

	void headbutt_reset()
	{
		HEADBUTT_DELAY = 0;
	}

	void attack1()
	{
		SWIPE_ATTACK = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, SWIPE_DAMAGE, ATTACK_HITCHANCE);
	}

	void attack2()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, HEADBUTT_DAMAGE, ATTACK_HITCHANCE);
		HEADBUTT_ON = 1;
	}

	void game_dodamage()
	{
		if ((HEADBUTT_ON))
		{
			if ((param1))
			{
				EmitSound(GetOwner(), 0, SOUND_HEADBUTT, 10);
				ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			}
			if (!(param1))
			{
				// PlayRandomSound from: SOUND_SWIPEMISS1, SOUND_SWIPEMISS2
				array<string> sounds = {SOUND_SWIPEMISS1, SOUND_SWIPEMISS2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			ANIM_ATTACK = ANIM_SWIPE;
			HEADBUTT_ON = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((SWIPE_ATTACK))
		{
			SWIPE_ATTACK = 0;
			if (RandomInt(1, 100) < CHANCE_SHOCK)
			{
			}
			EmitSound(GetOwner(), 0, SOUND_BFIRE, 10);
			Effect("glow", GetOwner(), Vector3(255, 255, 0), 64, 1, 1);
			ApplyEffect(param2, "effects/dot_lightning", RandomInt(2, 5), GetEntityIndex(GetOwner()), 10);
		}
		if ((param1))
		{
			// PlayRandomSound from: SOUND_SWIPEHIT1, SOUND_SWIPEHIT2
			array<string> sounds = {SOUND_SWIPEHIT1, SOUND_SWIPEHIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(-100, 130, 120));
		}
		if (!(param1))
		{
			// PlayRandomSound from: SOUND_SWIPEMISS1, SOUND_SWIPEMISS2
			array<string> sounds = {SOUND_SWIPEMISS1, SOUND_SWIPEMISS2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if ((CHAIN_ON))
		{
			AddVelocity(param2, Vector3(0, 0, 0));
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetMonsterHP() > WEAK_THRESHOLD)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_STRONG
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_STRONG};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (GetMonsterHP() <= WEAK_THRESHOLD)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_WEAK
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_WEAK};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (param1 > 200)
		{
			leap_away();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string HP_AFTER = GetMonsterHP();
		HP_AFTER -= param1;
		if (HP_AFTER < NEXT_LEAP_AWAY)
		{
			NEXT_LEAP_AWAY -= LEAP_AWAY_INTERVAL;
			leap_away();
		}
	}

	void leap_away()
	{
		PlayAnim("critical", ANIM_LEAP);
		SetMoveDest(m_hAttackTarget);
		ScheduleDelayedEvent(0.1, "leap_boost");
		npcatk_suspend_ai(3.0);
	}

	void leap_attack()
	{
		EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
		if ((CanSee("enemy", 128)))
		{
			npcatk_dodamage(GetEntityIndex(m_hLastSeen), ATTACK_HITRANGE, LEAP_DAMAGE, ATTACK_HITCHANCE);
			if (RandomInt(1, 100) < LEAP_STUNCHANCE)
			{
				ApplyEffect(GetEntityIndex(m_hLastSeen), "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			}
		}
	}

	void leap_done()
	{
		EmitSound(GetOwner(), 0, SOUND_LEAP_LAND, 10);
		SetMoveAnim(ANIM_RUN);
	}

	void npcatk_search_init_advanced()
	{
		if ((SEARCH_ANIM_DELAY)) return;
		NPC_DELAYING_UNSTUCK = 10.0;
		PlayAnim("critical", ANIM_SEARCH);
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		SEARCH_ANIM_DELAY = 1;
		ScheduleDelayedEvent(5.0, "reset_search_anim");
	}

	void reset_search_anim()
	{
		// TODO: UNCONVERTED: setrvard SEARCH_ANIM_DELAY 0
	}

	void OnFlinch()
	{
		EmitSound(GetOwner(), 0, SOUND_FLINCH, 10);
	}

	void idle_sounds()
	{
		Random(3, 10)("idle_sounds");
		if (!(m_hAttackTarget == "unset")) return;
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void run_step1()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 5);
	}

	void run_step2()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP2, 5);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((ORC_JUMPING)) return;
		if (!(IsValidPlayer(m_hAttackTarget))) return;
		ORC_JUMPING = 1;
		ScheduleDelayedEvent(1.0, "orc_jump_check");
	}

	void orc_jump_check()
	{
		if (!(ORC_JUMPING)) return;
		ORC_HOP_DELAY("orc_jump_check");
		if (!(CAN_LEAP)) return;
		if ((IS_FLEEING)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(false)) return;
		string ME_POS = GetMonsterProperty("origin");
		string MY_Z = (ME_POS).z;
		string TARGET_POS = GetEntityOrigin(m_hAttackTarget);
		string TARGET_Z = (TARGET_POS).z;
		string TARGET_Z_DIFFERENCE = TARGET_Z;
		TARGET_Z_DIFFERENCE -= MY_Z;
		if (TARGET_Z_DIFFERENCE > ORC_JUMP_THRESH)
		{
			orc_hop();
		}
	}

	void orc_hop()
	{
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(m_hAttackTarget);
		PlayAnim("critical", ANIM_LEAP);
		EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
		string JUMP_HEIGHT = RandomInt(550, 650);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, JUMP_HEIGHT));
	}

	void my_target_died()
	{
		if ((false)) return;
		ORC_JUMPING = 0;
	}

	void bo_zombie_mode()
	{
		npc_suicide();
	}

	void ext_lshield_on()
	{
		CAN_LEAP = 0;
		string SHIELD_DURATION = param1;
		if (SHIELD_DURATION == 0)
		{
			float SHIELD_DURATION = 3.0;
		}
		npcatk_suspend_ai();
		SetRoam(false);
		lshield_activate(SHIELD_DURATION);
		SetIdleAnim("warcry");
		SetMoveAnim("warcry");
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		SHIELD_DURATION("ext_end_shield");
	}

	void ext_end_shield()
	{
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		npcatk_resume_ai();
		SetRoam(true);
		CAN_LEAP = 1;
	}

	void do_lightning()
	{
		CHAIN_ON = 1;
		CHAIN_COUNT = 0;
		CAN_LEAP = 0;
		npcatk_suspend_ai();
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 128, 3, 1);
		CUR_BEAM = 0;
		BEAM_TARGET_LIST = FindEntitiesInSphere("enemy", 1024);
		LogDebug("BEAM_TARGET_LIST");
		for (int i = 0; i < GetTokenCount(BEAM_TARGET_LIST, ";"); i++)
		{
			set_beam();
		}
		ScheduleDelayedEvent(0.1, "chain_lightning");
	}

	void chain_lightning()
	{
		CHAIN_COUNT += 1;
		if (CHAIN_COUNT < 10)
		{
			SetIdleAnim("idle2");
			SetMoveAnim("idle2");
			CAN_LEAP = 0;
		}
		if (CHAIN_COUNT == 10)
		{
			CHAIN_ON = 0;
			for (int i = 0; i < GetTokenCount(BEAM_LIST, ";"); i++)
			{
				beams_off();
			}
			ScheduleDelayedEvent(1.0, "resume_attack");
			FREQ_CHAIN("do_lightning");
		}
		if (!(CHAIN_COUNT < 10)) return;
		ScheduleDelayedEvent(0.1, "chain_lightning");
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		for (int i = 0; i < GetTokenCount(BEAM_TARGET_LIST, ";"); i++)
		{
			push_targets();
		}
		CAN_LEAP = 1;
	}

	void push_targets()
	{
		string CUR_TARGET = GetToken(BEAM_TARGET_LIST, i, ";");
		string TARG_ORG = GetEntityOrigin(BEAM_TARGET_LIST);
		string TRACE_LINE = TraceLine(GetMonsterProperty("origin"), TARG_ORG);
		if (!(TRACE_LINE == TARG_ORG)) return;
		string FIN_DMG = DMG_CHAIN;
		string RESIST_FLOAT = /* TODO: $get_takedmg */ $get_takedmg(CUR_TARGET, "lightning");
		FIN_DMG *= RESIST_FLOAT;
		DamageEntity(CUR_TARGET, GetOwner());
		AddVelocity(CUR_TARGET, Vector3(130, 0, 0));
	}

	void set_beam()
	{
		string CUR_BEAM_ID = GetToken(BEAM_LIST, CUR_BEAM, ";");
		string CUR_TARGET = GetToken(BEAM_TARGET_LIST, i, ";");
		if (!(CUR_BEAM_ID != 0)) return;
		LogDebug("beam CUR_BEAM_ID to GetEntityName(CUR_TARGET)");
		Effect("beam", "update", CUR_BEAM_ID, "brightness", 200);
		Effect("beam", "update", CUR_BEAM_ID, "end_target", CUR_TARGET, 0);
		CUR_BEAM += 1;
		if (!(CUR_BEAM > GetTokenCount(BEAM_LIST, ";"))) return;
		CUR_BEAM = 0;
	}

	void beams_off()
	{
		Effect("beam", "update", GetToken(BEAM_LIST, i, ";"), "brightness", 0);
	}

	void beams_remove()
	{
		Effect("beam", "update", GetToken(BEAM_LIST, i, ";"), "remove", 0);
	}

	void resume_attack()
	{
		npcatk_resume_ai();
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
	}

	void init_beam1()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		BEAM_ID = GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam1 BEAM_ID");
		ScheduleDelayedEvent(0.1, "init_beam2");
	}

	void init_beam2()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam2 BEAM_LIST GetEntityIndex(m_hLastCreated)");
		ScheduleDelayedEvent(0.1, "init_beam3");
	}

	void init_beam3()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam3 BEAM_LIST GetEntityIndex(m_hLastCreated)");
		ScheduleDelayedEvent(0.1, "init_beam4");
	}

	void init_beam4()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam4 BEAM_LIST GetEntityIndex(m_hLastCreated)");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		for (int i = 0; i < GetTokenCount(BEAM_LIST, ";"); i++)
		{
			beams_remove();
		}
	}

}

}
