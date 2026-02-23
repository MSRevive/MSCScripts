#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class KElder : CGameScript
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
	int ATTACK_RANGE_MELEE;
	int BLADE_ATTACK;
	int BLADE_DRAWN;
	int CAN_RETALIATE;
	string CL_IDX;
	string DID_WARCRY;
	string DRAW_ON_SIGHT;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string EFFECT_DMG;
	string EFFECT_DUR;
	string EFFECT_SCRIPT;
	string ELDER_SKIN;
	string ELDER_TYPE;
	int FLEE_CHECK_DELAY;
	string FREQ_SPELL;
	string JUMP_AWAY_CHANCE;
	int LIGHTNING_ON;
	string NEXT_CL_RESET;
	string NEXT_LEAP;
	string NEXT_SEARCH;
	int NPC_GIVE_EXP;
	int NPC_RANGED;
	string OVERRIDE_TYPE;
	int PASS_FREEZE_DMG;
	float PASS_FREEZE_DUR;
	string RND_ELDER_TYPE;
	string SOUND_EFFECT;
	string WEAPON_IDX;

	KElder()
	{
		CAN_RETALIATE = 0;
		NPC_RANGED = 1;
		ATTACK_RANGE_MELEE = 50;
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
		const string FREQ_IDLE = Random(5, 10);
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
		NPC_GIVE_EXP = 1000;
		const string SOUND_JUMP = "voices/kcult_jump.wav";
		const string SOUND_SWING = "weapons/swingsmall.wav";
		const string SOUND_THROW = "zombie/claw_miss1.wav";
		const string SOUND_DRAW = "weapons/dagger/dagger2.wav";
		const string SOUND_PARRY = "weapons/dagger/daggermetal2.wav";
		const string SOUND_PAIN1 = "voices/kcult_pain3.wav";
		const string SOUND_PAIN2 = "voices/kcult_pain2.wav";
		const string SOUND_DEATH1 = "voices/kcult_pain1.wav";
		const string SOUND_DEATH2 = "voices/kcult_die1.wav";
		const string SOUND_ALERT1 = "voices/kcult_ally_alert1.wav";
		const string SOUND_ALERT2 = "voices/kcult_ally_alert2.wav";
		const string SOUND_IDLE = "voices/human/male_oldidle2.wav";
		const string SOUND_WARCRY1 = "voices/kcult_alert1.wav";
		const string SOUND_WARCRY2 = "voices/kcult_alert2.wav";
		const string SOUND_STRUCK1 = "debris/flesh1.wav";
		const string SOUND_STRUCK2 = "debris/flesh2.wav";
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
		SetName("Kharaztorant Elder");
		SetModel("monsters/k_alcolyte.mdl");
		SetModelBody(1, 1);
		SetModelBody(2, 4);
		SetHealth(RandomInt(2000, 4000));
		SetBloodType("red");
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

	void game_dynamically_created()
	{
		if ((param1).findFirst("PARAM") == 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		OVERRIDE_TYPE = param1;
		LogDebug("Overriding Type: OVERRIDE_TYPE");
	}

	void set_type()
	{
		OVERRIDE_TYPE = param1;
	}

	void type_dark()
	{
		OVERRIDE_TYPE = 1;
	}

	void type_fire()
	{
		OVERRIDE_TYPE = 2;
	}

	void type_poison()
	{
		OVERRIDE_TYPE = 3;
	}

	void type_cold()
	{
		OVERRIDE_TYPE = 4;
	}

	void type_lightning()
	{
		OVERRIDE_TYPE = 5;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (ELDER_TYPE == "lightning")
		{
			ClientEvent("update", "all", CL_IDX, "ke_end_effect");
		}
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
		if (OVERRIDE_TYPE > 0)
		{
			RND_ELDER_TYPE = OVERRIDE_TYPE;
		}
		else
		{
			RND_ELDER_TYPE = RandomInt(2, 5);
		}
		SetDamageResistance("holy", 0.5);
		if (RND_ELDER_TYPE == 1)
		{
			ELDER_TYPE = "dark";
			WEAPON_IDX = 0;
			DRAW_ON_SIGHT = 1;
			JUMP_AWAY_CHANCE = 20;
			NEXT_CL_RESET = GetGameTime();
			NEXT_CL_RESET += 20.0;
		}
		if (RND_ELDER_TYPE == 2)
		{
			JUMP_AWAY_CHANCE = 20;
			DRAW_ON_SIGHT = 0;
			ELDER_TYPE = "fire";
			WEAPON_IDX = 1;
			FREQ_SPELL = 1.0;
			EFFECT_SCRIPT = "effects/dot_fire";
			EFFECT_DUR = 5;
			EFFECT_DMG = DOT_FIRE;
			SOUND_EFFECT = SOUND_BURN;
		}
		if (RND_ELDER_TYPE == 3)
		{
			JUMP_AWAY_CHANCE = 50;
			DRAW_ON_SIGHT = 0;
			ELDER_TYPE = "poison";
			WEAPON_IDX = 2;
			FREQ_SPELL = 2.0;
			EFFECT_SCRIPT = "effects/dot_poison";
			EFFECT_DUR = 10;
			EFFECT_DMG = DOT_POISON;
			SOUND_EFFECT = SOUND_POISON;
		}
		if (RND_ELDER_TYPE == 4)
		{
			JUMP_AWAY_CHANCE = 30;
			DRAW_ON_SIGHT = 0;
			ELDER_TYPE = "cold";
			WEAPON_IDX = 3;
			FREQ_SPELL = 5.1;
			EFFECT_SCRIPT = "effects/dot_cold";
			EFFECT_DUR = 5;
			EFFECT_DMG = DOT_COLD;
			SOUND_EFFECT = SOUND_FREEZE;
		}
		if (RND_ELDER_TYPE == 5)
		{
			JUMP_AWAY_CHANCE = 50;
			ATTACK_MOVERANGE = 200;
			DRAW_ON_SIGHT = 1;
			ELDER_TYPE = "lightning";
			WEAPON_IDX = 5;
			EFFECT_SCRIPT = "effects/dot_lightning";
			EFFECT_DUR = 5;
			EFFECT_DMG = DOT_SHOCK;
			ClientEvent("persist", "all", "monsters/k_elder_cl", GetEntityIndex(GetOwner()), "lightning", 0);
			CL_IDX = "game.script.last_sent_id";
			SOUND_EFFECT = SOUND_SHOCK;
		}
		ELDER_SKIN = RND_ELDER_TYPE;
		ELDER_SKIN -= 1;
		LogDebug("setup_elder - skin ELDER_SKIN type ELDER_TYPE");
		SetProp(GetOwner(), "skin", ELDER_SKIN);
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
		if (ELDER_TYPE == "lightning")
		{
			ScheduleDelayedEvent(0.1, "lknife_sound");
			ClientEvent("update", "all", CL_IDX, "ke_knife_sprite_on");
			NEXT_CL_RESET = GetGameTime();
			NEXT_CL_RESET += 20.0;
		}
		EmitSound(GetOwner(), 0, SOUND_DRAW, 10);
	}

	void lknife_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_BEAM_ACTIVATE, 10);
	}

	void OnDamage(int damage) override
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 8);
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
		EmitSound(GetOwner(), 0, SOUND_JUMP, 10);
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
			if (ELDER_TYPE == "lightning")
			{
				string HIT_RESIST = /* TODO: $get_takedmg */ $get_takedmg(m_hAttackTarget, "lightning");
				if (Random(0.01, 1.0) < HIT_RESIST)
				{
				}
				AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 250, 120));
			}
		}
		BLADE_ATTACK = 0;
	}

	void attack_knife()
	{
		EmitSound(GetOwner(), 0, SOUND_SWING, 5);
		BLADE_ATTACK = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KNIFE, ATTACK_HITCHANCE, ELDER_TYPE);
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
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npcatk_lost_sight()
	{
		if ((false)) return;
		EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		if (!(GetGameTime() > NEXT_SEARCH)) return;
		NEXT_SEARCH = GetGameTime();
		NEXT_SEARCH += 3.0;
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
		if (ELDER_TYPE == "lightning")
		{
			if (m_hAttackTarget != "unset")
			{
				if ((false))
				{
					string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
					if ((WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles"))))
					{
						if (!(LIGHTNING_ON))
						{
							if (!(I_R_FROZEN))
							{
							}
							if (GetEntityRange(m_hAttackTarget) < MAX_BEAM_RANGE)
							{
							}
							if (GetEntityRange(m_hAttackTarget) >= ATTACK_RANGE)
							{
							}
							lightning_on();
							TARG_RESIST = /* TODO: $get_takedmg */ $get_takedmg(m_hAttackTarget, "lightning");
						}
						else
						{
							if ((I_R_FROZEN))
							{
								lightning_off();
								int EXIT_SUB = 1;
							}
							if (!(EXIT_SUB))
							{
							}
							if (GetEntityRange(m_hAttackTarget) >= MAX_BEAM_RANGE)
							{
								lightning_off();
							}
							if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
							{
								lightning_off();
							}
							else
							{
								AS_ATTACKING = GetGameTime();
								DoDamage(m_hAttackTarget, "direct", DMG_REPEL_BEAM, 1.0, "lightning");
								if (Random(0.01, 1.0) < TARG_RESIST)
								{
								}
								AddVelocity(m_hAttackTarget, REPEL_BEAM_VEL);
							}
						}
					}
					else
					{
						if ((LIGHTNING_ON))
						{
						}
						lightning_off();
					}
				}
				else
				{
					if ((LIGHTNING_ON))
					{
					}
					lightning_off();
				}
			}
			if (m_hAttackTarget == "unset")
			{
				if ((LIGHTNING_ON))
				{
				}
				lightning_off();
			}
		}
		else
		{
			if (m_hAttackTarget != "unset")
			{
			}
			if ((NPC_CANSEE_TARGET))
			{
			}
			if (ELDER_TYPE == "dark")
			{
			}
			if (ELDER_TYPE == "fire")
			{
				if (GetGameTime() > NEXT_SPELL)
				{
				}
				NEXT_SPELL = GetGameTime();
				NEXT_SPELL += FREQ_SPELL;
				do_spell();
			}
			if (ELDER_TYPE == "cold")
			{
				if ((GetEntityProperty(m_hAttackTarget, "scriptvar")))
				{
					ATTACK_MOVERANGE = ATTACK_RANGE_MELEE;
				}
				else
				{
					ATTACK_MOVERANGE = ATTACK_RANGE_PROJ;
				}
				if (GetGameTime() > NEXT_SPELL)
				{
				}
				NEXT_SPELL = GetGameTime();
				NEXT_SPELL += FREQ_SPELL;
				do_spell();
			}
			if (ELDER_TYPE == "poison")
			{
				if (GetGameTime() > NEXT_SPELL)
				{
				}
				NEXT_SPELL = GetGameTime();
				NEXT_SPELL += FREQ_SPELL;
				do_spell();
			}
		}
	}

	void do_spell()
	{
		if (ELDER_TYPE == "fire")
		{
			PlayAnim("critical", ANIM_CAST_NORM);
			TossProjectile("proj_fire_xolt", /* TODO: $relpos */ $relpos(0, 0, 26), m_hAttackTarget, 400, DMG_FIRE_BOLT, 2, "none");
		}
		if (ELDER_TYPE == "cold")
		{
			EmitSound(GetOwner(), 0, SOUND_SPELL_COLD, 10);
			if (!(GetEntityProperty(m_hAttackTarget, "scriptvar")))
			{
			}
			PlayAnim("critical", ANIM_CAST_NORM);
			TossProjectile("proj_freezing_sphere", /* TODO: $relpos */ $relpos(0, 96, 26), m_hAttackTarget, 100, 0, 0, "none");
		}
		if (ELDER_TYPE == "poison")
		{
			EmitSound(GetOwner(), 0, SOUND_SPELL_POISON, 10);
			PlayAnim("critical", ANIM_CAST_NORM);
			TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 0, 26), m_hAttackTarget, 200, DMG_POISON_BOLT, 10, "none");
			TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 0, 26), m_hAttackTarget, 200, DMG_POISON_BOLT, 10, "none");
			TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 0, 26), m_hAttackTarget, 200, DMG_POISON_BOLT, 10, "none");
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

	void lightning_on()
	{
		LIGHTNING_ON = 1;
		string TARG_HEIGHT = GetEntityHeight(m_hAttackTarget);
		TARG_HEIGHT /= 2;
		ClientEvent("update", "all", CL_IDX, "ke_beam_on", GetEntityIndex(m_hAttackTarget), TARG_HEIGHT);
		EmitSound(GetOwner(), 1, SOUND_BEAM_LOOP, 10);
		EmitSound(GetOwner(), 2, SOUND_BEAM_SHOOT, 10);
	}

	void lightning_off()
	{
		LIGHTNING_ON = 0;
		ClientEvent("update", "all", CL_IDX, "ke_beam_off");
		EmitSound(GetOwner(), 1, SOUND_BEAM_LOOP, 1);
	}

}

}
