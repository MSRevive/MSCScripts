#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class FwElder : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK_CRAWL;
	string ANIM_ATTACK_NORM;
	string ANIM_CAST_CRAWL;
	string ANIM_CAST_NORM;
	string ANIM_CRAWL;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_DEATH3;
	string ANIM_DEATH4;
	string ANIM_DEATH5;
	string ANIM_DEATH6;
	string ANIM_DEATH7;
	string ANIM_HOP;
	string ANIM_IDLE;
	string ANIM_IDLE_CRAWL;
	string ANIM_IDLE_NORM;
	string ANIM_JUMP;
	string ANIM_RUN;
	string ANIM_RUN_NORM;
	string ANIM_SEARCH;
	string ANIM_WALK;
	string ANIM_WALK_NORM;
	string AS_ATTACKING;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int ATTACK_RANGE_MELEE;
	int ATTACK_RANGE_PROJ;
	int BEAM_IDLE_VOL;
	int BLADE_ATTACK;
	int BLADE_DRAWN;
	int CAN_RETALIATE;
	float CL_RESET_FREQ;
	int CUR_BOLT;
	int DID_AID_ALERT;
	string DID_WARCRY;
	int DMG_FIRE_BOLT;
	int DMG_KNIFE;
	int DMG_POISON_BOLT;
	int DMG_REPEL_BEAM;
	int DOT_COLD;
	int DOT_FIRE;
	int DOT_POISON;
	int DOT_SHOCK;
	string DRAW_ON_SIGHT;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string EFFECT_DMG;
	string EFFECT_DUR;
	string EFFECT_SCRIPT;
	string ELDER_TYPE;
	int FLEE_CHECK_DELAY;
	float FREQ_IDLE;
	string FREQ_SPELL;
	string G_LAST_VICTORY;
	string JUMP_AWAY_CHANCE;
	int MAX_BEAM_RANGE;
	string NEXT_LEAP;
	string NEXT_SEARCH;
	string NEXT_SPELL;
	int NPC_GIVE_EXP;
	int NPC_RANGED;
	int OVERRIDE_TYPE;
	int PASS_FREEZE_DMG;
	float PASS_FREEZE_DUR;
	string REPEL_BEAM_VEL;
	int RND_ELDER_TYPE;
	string SOUND_ACID1;
	string SOUND_ACID2;
	string SOUND_ACID3;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_ALERT3;
	string SOUND_BEAM_ACTIVATE;
	string SOUND_BEAM_LOOP;
	string SOUND_BEAM_SHOOT;
	string SOUND_BURN;
	string SOUND_DEATH1;
	string SOUND_DEATH2;
	string SOUND_DRAW;
	string SOUND_EFFECT;
	string SOUND_FREEZE;
	string SOUND_IDLE;
	string SOUND_JUMP1;
	string SOUND_JUMP2;
	string SOUND_JUMP3;
	string SOUND_LOST_SIGHT1;
	string SOUND_LOST_SIGHT2;
	string SOUND_LOST_SIGHT3;
	string SOUND_LOST_SIGHT4;
	string SOUND_LOST_SIGHT5;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;
	string SOUND_PARRY;
	string SOUND_POISON;
	string SOUND_SHOCK;
	string SOUND_SPELL_COLD;
	string SOUND_SPELL_POISON;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_SWING;
	string SOUND_THROW;
	string SOUND_VICTORY1;
	string SOUND_WARCRY1;
	string SOUND_WARCRY2;
	string SOUND_ZAP1;
	string SOUND_ZAP2;
	string SOUND_ZAP3;
	string WEAPON_IDX;

	FwElder()
	{
		CAN_RETALIATE = 0;
		NPC_RANGED = 1;
		ATTACK_RANGE_MELEE = 50;
		ATTACK_RANGE_PROJ = 512;
		CL_RESET_FREQ = 5.0;
		REPEL_BEAM_VEL = /* TODO: $relvel */ $relvel(0, 350, 60);
		MAX_BEAM_RANGE = 800;
		BEAM_IDLE_VOL = 4;
		DMG_FIRE_BOLT = 80;
		DMG_POISON_BOLT = 50;
		DOT_POISON = 20;
		DOT_FIRE = 40;
		DOT_COLD = 20;
		DOT_SHOCK = 30;
		DMG_KNIFE = 75;
		DMG_REPEL_BEAM = 10;
		ANIM_WALK_NORM = "walk2handed";
		ANIM_RUN_NORM = "run2";
		ANIM_IDLE_NORM = "idle";
		ANIM_HOP = "jump";
		ANIM_JUMP = "long_jump";
		ANIM_CRAWL = "crawl";
		ANIM_IDLE_CRAWL = "crouch_idle";
		ANIM_ATTACK_NORM = "ref_shoot_knife";
		ANIM_ATTACK_CRAWL = "crouch_shoot_knife";
		ANIM_SEARCH = "look_idle";
		ANIM_CAST_NORM = "ref_shoot_onehanded";
		ANIM_CAST_CRAWL = "crouch_shoot_onehanded";
		ANIM_DEATH1 = "die_simple";
		ANIM_DEATH2 = "die_backwards1";
		ANIM_DEATH3 = "die_backwards";
		ANIM_DEATH4 = "die_forwards";
		ANIM_DEATH5 = "headshot";
		ANIM_DEATH6 = "die_spin";
		ANIM_DEATH7 = "gutshot";
		FREQ_IDLE = Random(20, 40);
		ATTACK_HITCHANCE = 80;
		DMG_KNIFE = 60;
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
		SOUND_JUMP1 = "voices/phlame/vs_ndrawlm_atk1.wav";
		SOUND_JUMP2 = "voices/phlame/vs_ndrawlm_atk2.wav";
		SOUND_JUMP3 = "voices/phlame/vs_ndrawlm_atk3.wav";
		SOUND_SWING = "weapons/swingsmall.wav";
		SOUND_THROW = "zombie/claw_miss1.wav";
		SOUND_DRAW = "weapons/dagger/dagger2.wav";
		SOUND_PARRY = "weapons/dagger/daggermetal2.wav";
		SOUND_PAIN1 = "voices/phlame/vs_nkarlatm_hit1.wav";
		SOUND_PAIN2 = "voices/phlame/vs_nkarlatm_hit2.wav";
		SOUND_PAIN3 = "voices/phlame/vs_nkarlatm_hit3.wav";
		SOUND_DEATH1 = "voices/phlame/vs_nkarlatm_dead.wav";
		SOUND_DEATH2 = "voices/phlame/vs_nkarlatm_hit3.wav";
		SOUND_ALERT1 = "voices/phlame/vs_nkarlatm_attk.wav";
		SOUND_ALERT2 = "voices/phlame/vs_nkarlatm_bat1.wav";
		SOUND_ALERT3 = "voices/phlame/vs_nkarlatm_help.wav";
		SOUND_IDLE = "voices/phlame/vs_nkarlatm_haha.wav";
		SOUND_WARCRY1 = "voices/phlame/vs_nkarlatm_bat2.wav";
		SOUND_WARCRY2 = "voices/phlame/vs_nkarlatm_bat3.wav";
		SOUND_STRUCK1 = "debris/flesh1.wav";
		SOUND_STRUCK2 = "debris/flesh2.wav";
		SOUND_ACID1 = "bullchicken/bc_attack1.wav";
		SOUND_ACID2 = "bullchicken/bc_attack2.wav";
		SOUND_ACID3 = "bullchicken/bc_attack3.wav";
		SOUND_LOST_SIGHT1 = "voices/phlame/vs_nkarlatm_attk.wav";
		SOUND_LOST_SIGHT2 = "voices/phlame/vs_nkarlatm_bat1.wav";
		SOUND_LOST_SIGHT3 = "voices/phlame/vs_nkarlatm_bat2.wav";
		SOUND_LOST_SIGHT4 = "voices/phlame/vs_nkarlatm_bat3.wav";
		SOUND_LOST_SIGHT5 = "voices/phlame/vs_nkarlatm_warn.wav";
		SOUND_VICTORY1 = "voices/phlame/vs_nkarlatm_vict.wav";
		SOUND_BURN = "ambience/steamburst1.wav";
		SOUND_POISON = "bullchicken/bc_bite2.wav";
		SOUND_FREEZE = "magic/frost_forward.wav";
		SOUND_SHOCK = "debris/zap1.wav";
		Precache(SOUND_BURN);
		Precache(SOUND_POISON);
		Precache(SOUND_FREEZE);
		SOUND_BEAM_LOOP = "magic/bolt_loop.wav";
		SOUND_BEAM_ACTIVATE = "magic/bolt_start.wav";
		SOUND_BEAM_SHOOT = "magic/bolt_end.wav";
		SOUND_ZAP1 = "debris/beamstart14.wav";
		SOUND_ZAP2 = "debris/beamstart14.wav";
		SOUND_ZAP3 = "debris/zap1.wav";
		SOUND_SPELL_POISON = "bullchicken/bc_attack3.wav";
		SOUND_SPELL_COLD = "magic/frost_reverse.wav";
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
		int RND_DEATH = RandomInt(1, 7);
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
		int RND_100 = RandomInt(1, 100);
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
