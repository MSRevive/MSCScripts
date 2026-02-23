#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class FwElder : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BLADE_ATTACK;
	int BLADE_DRAWN;
	int CAN_RETALIATE;
	int CUR_BOLT;
	int DID_AID_ALERT;
	string DID_WARCRY;
	string DRAW_ON_SIGHT;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string EFFECT_DMG;
	string EFFECT_DUR;
	string EFFECT_SCRIPT;
	string ELDER_TYPE;
	int FLEE_CHECK_DELAY;
	string FREQ_SPELL;
	string G_LAST_VICTORY;
	string JUMP_AWAY_CHANCE;
	string NEXT_LEAP;
	string NEXT_SEARCH;
	string NEXT_SPELL;
	int NPC_GIVE_EXP;
	int NPC_RANGED;
	int OVERRIDE_TYPE;
	int PASS_FREEZE_DMG;
	float PASS_FREEZE_DUR;
	int RND_ELDER_TYPE;
	string SOUND_EFFECT;
	string WEAPON_IDX;

	FwElder()
	{
		CAN_RETALIATE = 0;
		NPC_RANGED = 1;
		const int ATTACK_RANGE_MELEE = 50;
		const int ATTACK_RANGE_PROJ = 512;
		const float CL_RESET_FREQ = 5.0;
		const string REPEL_BEAM_VEL = /* TODO: $relvel */ $relvel(0, 350, 60);
		const int MAX_BEAM_RANGE = 800;
		const int BEAM_IDLE_VOL = 4;
		const int DMG_FIRE_BOLT = 80;
		const int DMG_POISON_BOLT = 50;
		const int DOT_POISON = 20;
		const int DOT_FIRE = 40;
		const int DOT_COLD = 20;
		const int DOT_SHOCK = 30;
		const int DMG_KNIFE = 75;
		const int DMG_REPEL_BEAM = 10;
		const string ANIM_WALK_NORM = "walk2handed";
		const string ANIM_RUN_NORM = "run2";
		const string ANIM_IDLE_NORM = "idle";
		const string ANIM_HOP = "jump";
		const string ANIM_JUMP = "long_jump";
		const string ANIM_CRAWL = "crawl";
		const string ANIM_IDLE_CRAWL = "crouch_idle";
		const string ANIM_ATTACK_NORM = "ref_shoot_knife";
		const string ANIM_ATTACK_CRAWL = "crouch_shoot_knife";
		const string ANIM_SEARCH = "look_idle";
		const string ANIM_CAST_NORM = "ref_shoot_onehanded";
		const string ANIM_CAST_CRAWL = "crouch_shoot_onehanded";
		const string ANIM_DEATH1 = "die_simple";
		const string ANIM_DEATH2 = "die_backwards1";
		const string ANIM_DEATH3 = "die_backwards";
		const string ANIM_DEATH4 = "die_forwards";
		const string ANIM_DEATH5 = "headshot";
		const string ANIM_DEATH6 = "die_spin";
		const string ANIM_DEATH7 = "gutshot";
		const string FREQ_IDLE = Random(20, 40);
		const int ATTACK_HITCHANCE = 80;
		const int DMG_KNIFE = 60;
		PASS_FREEZE_DMG = 50;
		PASS_FREEZE_DUR = 5.0;
		ANIM_WALK = "walk2handed";
		ANIM_RUN = "run2";
		if (!(AM_TURRET))
		{
			ANIM_IDLE = "idle";
		}
		else
		{
			ANIM_IDLE = "ref_aim_knife";
		}
		ANIM_ATTACK = "ref_shoot_knife";
		ANIM_DEATH = "die_simple";
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 170;
		ATTACK_MOVERANGE = 512;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 100;
		NPC_GIVE_EXP = 1250;
		const string SOUND_JUMP1 = "voices/phlame/vs_ndrawlm_atk1.wav";
		const string SOUND_JUMP2 = "voices/phlame/vs_ndrawlm_atk2.wav";
		const string SOUND_JUMP3 = "voices/phlame/vs_ndrawlm_atk3.wav";
		const string SOUND_SWING = "weapons/swingsmall.wav";
		const string SOUND_THROW = "zombie/claw_miss1.wav";
		const string SOUND_DRAW = "weapons/dagger/dagger2.wav";
		const string SOUND_PARRY = "weapons/dagger/daggermetal2.wav";
		const string SOUND_PAIN1 = "voices/phlame/vs_nkarlatm_hit1.wav";
		const string SOUND_PAIN2 = "voices/phlame/vs_nkarlatm_hit2.wav";
		const string SOUND_PAIN3 = "voices/phlame/vs_nkarlatm_hit3.wav";
		const string SOUND_DEATH1 = "voices/phlame/vs_nkarlatm_dead.wav";
		const string SOUND_DEATH2 = "voices/phlame/vs_nkarlatm_hit3.wav";
		const string SOUND_ALERT1 = "voices/phlame/vs_nkarlatm_attk.wav";
		const string SOUND_ALERT2 = "voices/phlame/vs_nkarlatm_bat1.wav";
		const string SOUND_ALERT3 = "voices/phlame/vs_nkarlatm_help.wav";
		const string SOUND_IDLE = "voices/phlame/vs_nkarlatm_haha.wav";
		const string SOUND_WARCRY1 = "voices/phlame/vs_nkarlatm_bat2.wav";
		const string SOUND_WARCRY2 = "voices/phlame/vs_nkarlatm_bat3.wav";
		const string SOUND_STRUCK1 = "debris/flesh1.wav";
		const string SOUND_STRUCK2 = "debris/flesh2.wav";
		const string SOUND_ACID1 = "bullchicken/bc_attack1.wav";
		const string SOUND_ACID2 = "bullchicken/bc_attack2.wav";
		const string SOUND_ACID3 = "bullchicken/bc_attack3.wav";
		const string SOUND_LOST_SIGHT1 = "voices/phlame/vs_nkarlatm_attk.wav";
		const string SOUND_LOST_SIGHT2 = "voices/phlame/vs_nkarlatm_bat1.wav";
		const string SOUND_LOST_SIGHT3 = "voices/phlame/vs_nkarlatm_bat2.wav";
		const string SOUND_LOST_SIGHT4 = "voices/phlame/vs_nkarlatm_bat3.wav";
		const string SOUND_LOST_SIGHT5 = "voices/phlame/vs_nkarlatm_warn.wav";
		const string SOUND_VICTORY1 = "voices/phlame/vs_nkarlatm_vict.wav";
		const string SOUND_BURN = "ambience/steamburst1.wav";
		const string SOUND_POISON = "bullchicken/bc_bite2.wav";
		const string SOUND_FREEZE = "magic/frost_forward.wav";
		const string SOUND_SHOCK = "debris/zap1.wav";
		Precache(SOUND_BURN);
		Precache(SOUND_POISON);
		Precache(SOUND_FREEZE);
		const string SOUND_BEAM_LOOP = "magic/bolt_loop.wav";
		const string SOUND_BEAM_ACTIVATE = "magic/bolt_start.wav";
		const string SOUND_BEAM_SHOOT = "magic/bolt_end.wav";
		const string SOUND_ZAP1 = "debris/beamstart14.wav";
		const string SOUND_ZAP2 = "debris/beamstart14.wav";
		const string SOUND_ZAP3 = "debris/zap1.wav";
		const string SOUND_SPELL_POISON = "bullchicken/bc_attack3.wav";
		const string SOUND_SPELL_COLD = "magic/frost_reverse.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_IDLE);
		if (m_hAttackTarget == "unset")
		{
		}
		AS_ATTACKING = GetGameTime();
		PlayAnim("once", ANIM_SEARCH);
		EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
	}

	void game_precache()
	{
		Precache("monsters/k_elder_cl");
	}

	void OnSpawn() override
	{
		SetName("Phlame Elder");
		SetModel("monsters/fire_alcolyte.mdl");
		SetModelBody(1, 1);
		SetModelBody(2, 1);
		SetProp(GetOwner(), "skin", 1);
		SetHealth(RandomInt(2000, 4000));
		SetBloodType("red");
		CUR_BOLT = 0;
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetIdleAnim("idle");
		SetMoveAnim("walk2handed");
		SetRace("demon");
		SetWidth(32);
		SetHeight(72);
		SetRoam(true);
		SetHearingSensitivity(4);
		if (!(true)) return;
		ScheduleDelayedEvent(0.01, "setup_elder");
	}

	void set_type()
	{
		OVERRIDE_TYPE = 2;
	}

	void type_fire()
	{
		OVERRIDE_TYPE = 2;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string RND_DEATH = RandomInt(1, 7);
		if (RND_DEATH == 1)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
		if (RND_DEATH == 2)
		{
			ANIM_DEATH = ANIM_DEATH2;
		}
		if (RND_DEATH == 3)
		{
			ANIM_DEATH = ANIM_DEATH3;
		}
		if (RND_DEATH == 4)
		{
			ANIM_DEATH = ANIM_DEATH4;
		}
		if (RND_DEATH == 5)
		{
			ANIM_DEATH = ANIM_DEATH5;
		}
		if (RND_DEATH == 6)
		{
			ANIM_DEATH = ANIM_DEATH6;
		}
		if (RND_DEATH == 7)
		{
			ANIM_DEATH = ANIM_DEATH7;
		}
		// PlayRandomSound from: SOUND_DEATH1, SOUND_DEATH2
		array<string> sounds = {SOUND_DEATH1, SOUND_DEATH2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void setup_elder()
	{
		RND_ELDER_TYPE = 2;
		SetDamageResistance("holy", 0.5);
		if (RND_ELDER_TYPE == 2)
		{
			JUMP_AWAY_CHANCE = 20;
			DRAW_ON_SIGHT = 0;
			ELDER_TYPE = "fire";
			WEAPON_IDX = 2;
			FREQ_SPELL = 1.0;
			EFFECT_SCRIPT = "effects/dot_poison";
			EFFECT_DUR = 5;
			EFFECT_DMG = DOT_FIRE;
			SOUND_EFFECT = SOUND_BURN;
		}
	}

	void draw_blade()
	{
		BLADE_DRAWN = 1;
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_CAST_NORM);
		ScheduleDelayedEvent(0.2, "draw_blade2");
	}

	void draw_blade2()
	{
		SetModelBody(2, WEAPON_IDX);
		EmitSound(GetOwner(), 0, SOUND_DRAW, 10);
	}

	void lknife_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_BEAM_ACTIVATE, 10);
	}

	void OnDamage(int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 8);
		if (!(GetEntityRange(param1) < 256)) return;
		string RND_100 = RandomInt(1, 100);
		LogDebug("RND_100 vs JUMP_AWAY_CHANCE");
		if (RND_100 < JUMP_AWAY_CHANCE)
		{
			if (GetGameTime() > NEXT_LEAP)
			{
			}
			NEXT_LEAP = GetGameTime();
			NEXT_LEAP += 10.0;
			LogDebug("leap away!");
			leap_away(GetEntityIndex(param1));
		}
	}

	void leap_away()
	{
		npcatk_suspend_ai(1.0);
		SetMoveDest(param1);
		AS_ATTACKING = GetGameTime();
		// PlayRandomSound from: SOUND_JUMP1, SOUND_JUMP2, SOUND_JUMP3
		array<string> sounds = {SOUND_JUMP1, SOUND_JUMP2, SOUND_JUMP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ScheduleDelayedEvent(0.1, "leap_boost");
	}

	void leap_boost()
	{
		PlayAnim("critical", ANIM_JUMP);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 600, 75));
	}

	void game_dodamage()
	{
		if ((BLADE_ATTACK))
		{
			if (ELDER_TYPE != "dark")
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			if (GetGameTime() > NEXT_APPLYEFFECT_SOUND)
			{
				NEXT_APPLYEFFECT_SOUND = GetGameTime();
				NEXT_APPLYEFFECT_SOUND += EFFECT_DUR;
				EmitSound(GetOwner(), 0, SOUND_EFFECT, 10);
			}
			ApplyEffect(param2, EFFECT_SCRIPT, EFFECT_DUR, GetEntityIndex(GetOwner()), EFFECT_DMG);
		}
		BLADE_ATTACK = 0;
	}

	void attack_knife()
	{
		EmitSound(GetOwner(), 0, SOUND_SWING, 5);
		BLADE_ATTACK = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KNIFE, ATTACK_HITCHANCE, "pierce");
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		PlayAnim("critical", ANIM_CAST_NORM);
		EmitSound(GetOwner(), 0, SOUND_PARRY, 10);
	}

	void OnAidingAlly(CBaseEntity@ ally, CBaseEntity@ enemy)
	{
		CallExternal(NPC_ALLY_TO_AID, "being_aided");
	}

	void being_aided()
	{
		if (!(false)) return;
		if ((DID_AID_ALERT)) return;
		DID_AID_ALERT = 1;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npcatk_lost_sight()
	{
		if ((false)) return;
		if (!(GetGameTime() > NEXT_SEARCH)) return;
		NEXT_SEARCH = GetGameTime();
		NEXT_SEARCH += 20.0;
		// PlayRandomSound from: SOUND_LOST_SIGHT1, SOUND_LOST_SIGHT2, SOUND_LOST_SIGHT3, SOUND_LOST_SIGHT4, SOUND_LOST_SIGHT5
		array<string> sounds = {SOUND_LOST_SIGHT1, SOUND_LOST_SIGHT2, SOUND_LOST_SIGHT3, SOUND_LOST_SIGHT4, SOUND_LOST_SIGHT5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("once", ANIM_SEARCH);
		AS_ATTACKING = GetGameTime();
	}

	void npc_targetsighted()
	{
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			// PlayRandomSound from: SOUND_WARCRY1, SOUND_WARCRY2
			array<string> sounds = {SOUND_WARCRY1, SOUND_WARCRY2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			if ((DRAW_ON_SIGHT))
			{
				ScheduleDelayedEvent(0.1, "draw_blade");
			}
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if (!(NPC_CANSEE_TARGET)) return;
		if (ELDER_TYPE == "fire")
		{
			if (GetGameTime() > NEXT_SPELL)
			{
			}
			NEXT_SPELL = GetGameTime();
			NEXT_SPELL += FREQ_SPELL;
			do_spell();
		}
	}

	void do_spell()
	{
		if (ELDER_TYPE == "fire")
		{
			PlayAnim("critical", ANIM_CAST_NORM);
			CUR_BOLT += 1;
			if (CUR_BOLT == 1)
			{
				TossProjectile("proj_fire_xolt", /* TODO: $relpos */ $relpos(0, 0, 26), m_hAttackTarget, 400, DMG_FIRE_BOLT, 2, "none");
			}
			else
			{
				// PlayRandomSound from: SOUND_ACID1, SOUND_ACID2, SOUND_ACID3
				array<string> sounds = {SOUND_ACID1, SOUND_ACID2, SOUND_ACID3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 0, 26), m_hAttackTarget, 400, DMG_FIRE_BOLT, 2, "none");
				CUR_BOLT = 0;
			}
		}
	}

	void npc_selectattack()
	{
		if (!(BLADE_DRAWN))
		{
			draw_blade();
		}
		if ((GetEntityProperty(m_hAttackTarget, "scriptvar"))) return;
	}

	void reset_flee_check_delay()
	{
		FLEE_CHECK_DELAY = 0;
	}

	void my_target_died()
	{
		LogDebug("my_target_died");
		if (!(GetGameTime() > G_LAST_VICTORY)) return;
		G_LAST_VICTORY = GetGameTime();
		G_LAST_VICTORY += 30.0;
		EmitSound(GetOwner(), 0, SOUND_VICTORY1, 10);
	}

}

}
