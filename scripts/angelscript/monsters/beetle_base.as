#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class BeetleBase : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	string ATTACK_HITRANGE;
	string ATTACK_HITRANGE_CLAW;
	string ATTACK_HITRANGE_GORE;
	string ATTACK_HITRANGE_LEAP;
	string ATTACK_MOVERANGE;
	string ATTACK_RANGE;
	string ATTACK_RANGE_CLAW;
	string ATTACK_RANGE_GORE;
	string ATTACK_RANGE_LEAP;
	int BBET_BURROWER;
	string BBET_BURROW_CLOUD_RADIUS;
	int BBET_DID_FAKE_DEATH;
	int BBET_DID_GROWL;
	int BBET_FLYING;
	int BBET_FLY_LEAP;
	string BBET_GIANT_MODEL;
	string BBET_HALF_HP;
	string BBET_LARGE_MODEL;
	string BBET_NEXT_FLY;
	string BBET_NEXT_FLY_LEAP;
	int BBET_ONBACK;
	int BBET_RENDERAMT;
	int BBET_RISE_FINALIZED;
	string BBET_SLAM_RADIUS;
	int BBET_WAITING_TO_DROP;
	string BBET_WILL_FAKE_DEATH;
	string BBET_WINGS_CL_IDX;
	int GORE_ATTACK;
	int LEAP_ATTACK;
	string NEXT_ALERT;
	string NEXT_FORCE_GORE;
	string NEXT_SEARCH;
	string NEXT_SLAM;
	int NPC_NO_ATTACK;

	BeetleBase()
	{
		ANIM_WALK = "bug_walk";
		ANIM_IDLE = "bug_idle";
		ANIM_RUN = "bug_run";
		ANIM_ATTACK = "bug_leapatk";
		ANIM_DEATH = "bug_death";
		ANIM_FLINCH = "bug_flinch";
		const string ANIM_RUN_DEFAULT = "bug_run";
		const string ANIM_WALK_DEFAULT = "bug_walk";
		const string ANIM_IDLE_DEFAULT = "bug_idle";
		const string ANIM_ATTACK_LEAP = "bug_leapatk";
		const string ANIM_ATTACK_CLAW = "bug_claw_up";
		const string ANIM_ATTACK_GORE = "bug_gore";
		const string ANIM_ATTACK_SLAM = "bug_slam";
		const string ANIM_TO_BACK = "bug_toback";
		const string ANIM_BACK_TO_FEET = "bug_backtofeet";
		const string ANIM_IDLE_ONBACK = "bug_onback";
		const string ANIM_DEATH_ONBACK = "bug_back_to_death";
		const string ANIM_DEATH_NORMAL = "bug_death";
		const string ANIM_FLY = "bug_jump";
		const string ANIM_SPECIAL = "bug_conjure";
		const string ANIM_RISE_FROM_GROUND = "bug_rise";
		const string ANIM_RAWR = "bug_rawr";
		const string ANIM_ALERT = "bug_alert";
		BBET_LARGE_MODEL = "monsters/beetles.mdl";
		BBET_GIANT_MODEL = "monsters/beetles_giant.mdl";
		const int BBET_SIZE = 1;
		const int BBET_CAN_FLY = 1;
		const int BBET_CAN_LEAP = 1;
		const int BBET_CAN_SLAM = 0;
		const int BBET_GORE_PUSH_STR = 400;
		const string BBET_FAKE_DEATH = RandomInt(0, 1);
		const float BBET_MAX_FLY_TIME = 8.0;
		const int BBET_HORN = 0;
		const float FREQ_ALERT = 10.0;
		const float FREQ_SEARCH = 10.0;
		const float FREQ_FORCE_GORE = 15.0;
		const string FREQ_SLAM = Random(10.0, 20.0);
		const string FREQ_FLY = Random(5.0, 15.0);
		const string FREQ_FLY_LEAP = Random(20.0, 60.0);
		const int AOE_GORE = 96;
		const int DMG_SLASH = 60;
		const int DMG_GORE = 120;
		const int DMG_LEAP = 300;
		const int DMG_SLAM = 400;
		const float ATTACK_HITCHANCE = 0.9;
		const string DMGTYPE_GORE = "pierce";
		const string BBET_CL_SCRIPT = "monsters/beetle_base_cl";
		const string SOUND_ATTACK1 = "monsters/beetle/attack_single1.wav";
		const string SOUND_ATTACK2 = "monsters/beetle/attack_single2.wav";
		const string SOUND_ATTACK3 = "monsters/beetle/attack_single3.wav";
		const string SOUND_SWIPE = "zombie/claw_miss1.wav";
		const string SOUND_GROWL = "monsters/beetle/distract1.wav";
		const string SOUND_DIG1 = "monsters/beetle/dig1.wav";
		const string SOUND_DIG2 = "monsters/beetle/dig2.wav";
		const string SOUND_DIGWARN = "monsters/beetle/rumble1.wav";
		const string SOUND_IDLE1 = "monsters/beetle/idle1.wav";
		const string SOUND_IDLE2 = "monsters/beetle/idle2.wav";
		const string SOUND_IDLE3 = "monsters/beetle/idle3.wav";
		const string SOUND_IDLE4 = "monsters/beetle/idle4.wav";
		const string SOUND_IDLE5 = "monsters/beetle/idle5.wav";
		const string SOUND_FLY_LOOP = "monsters/beetle/fly1.wav";
		const string SOUND_CHITTER_LOOP = "monsters/beetle/charge_loop1.wav";
		const string SOUND_LAND = "monsters/beetle/land1.wav";
		const string SOUND_SLAM = "magic/boom.wav";
		const string SOUND_PAIN1 = "monsters/beetle/pain1.wav";
		const string SOUND_PAIN2 = "monsters/beetle/pain2.wav";
		const string SOUND_STRUCK1 = "monsters/beetle/shell_impact1.wav";
		const string SOUND_STRUCK2 = "monsters/beetle/shell_impact2.wav";
		const string SOUND_STRUCK3 = "monsters/beetle/shell_impact3.wav";
		const string SOUND_STRUCK4 = "monsters/beetle/shell_impact4.wav";
		const string SOUND_GIBBED = "monsters/beetle/squashed.wav";
		const string SOUND_DEATH = "monsters/beetle/pain2.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(8.0, 15.0));
		if ((IsEntityAlive(GetOwner())))
		{
		}
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnSpawn() override
	{
		if (BBET_SIZE == 1)
		{
			SetModel(BBET_LARGE_MODEL);
			SetWidth(40);
			SetHeight(40);
			ATTACK_MOVERANGE = 48;
			ATTACK_RANGE = 130;
			ATTACK_HITRANGE = 160;
			ATTACK_RANGE_LEAP = 150;
			ATTACK_HITRANGE_LEAP = 175;
			ATTACK_RANGE_GORE = 64;
			ATTACK_HITRANGE_GORE = 100;
			ATTACK_RANGE_CLAW = 32;
			ATTACK_HITRANGE_CLAW = 64;
			BBET_SLAM_RADIUS = 128;
			BBET_BURROW_CLOUD_RADIUS = 64;
		}
		if (BBET_SIZE == 2)
		{
			SetModel(BBET_GIANT_MODEL);
			SetWidth(72);
			SetHeight(72);
			ATTACK_MOVERANGE = 64;
			ATTACK_RANGE = 80;
			ATTACK_HITRANGE = 150;
			ATTACK_RANGE_GORE = 80;
			ATTACK_HITRANGE_GORE = 150;
			ATTACK_RANGE_CLAW = 48;
			ATTACK_HITRANGE_CLAW = 96;
			BBET_SLAM_RADIUS = 256;
			BBET_BURROW_CLOUD_RADIUS = 128;
		}
		SetRace("spider");
		SetHearingSensitivity(4);
		SetRoam(true);
		if (!(BBET_BURROWER))
		{
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_WALK);
		}
		BBET_WILL_FAKE_DEATH = BBET_FAKE_DEATH;
		beetle_spawn();
	}

	void OnPostSpawn() override
	{
		BBET_HALF_HP = GetEntityMaxHealth(GetOwner());
		BBET_HALF_HP /= 2;
		if (BBET_SIZE == 2)
		{
			SetStepSize(16);
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(BBET_CAN_FLY)) return;
		if ((BBET_ONBACK)) return;
		if ((SUSPEND_AI)) return;
		if ((BBET_FLYING)) return;
		if ((I_R_FROZEN)) return;
		if (!(GetGameTime() > BBET_NEXT_FLY)) return;
		if (m_hAttackTarget != "unset")
		{
			if (GetEntityRange(m_hAttackTarget) < 800)
			{
				string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
				string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
				if ((IsValidPlayer(m_hAttackTarget)))
				{
					TARG_Z -= 38;
				}
				string Z_DIFF = TARG_Z;
				Z_DIFF -= MY_Z;
				if (Z_DIFF > 64)
				{
					bbet_fly_start();
				}
			}
			if (GetEntityRange(m_hAttackTarget) > ATTACK_HITRANGE)
			{
			}
			if (GetGameTime() > BBET_NEXT_FLY_LEAP)
			{
			}
			BBET_NEXT_FLY_LEAP = GetGameTime();
			BBET_NEXT_FLY_LEAP += FREQ_FLY_LEAP;
			bbet_fly_leap();
		}
	}

	void npc_selectattack()
	{
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		if ((BBET_CAN_LEAP))
		{
			if (TARG_RANGE < ATTACK_RANGE_LEAP)
			{
			}
			if (TARG_RANGE > ATTACK_RANGE_GORE)
			{
			}
			ANIM_ATTACK = ANIM_ATTACK_LEAP;
		}
		if (TARG_RANGE < ATTACK_RANGE_GORE)
		{
			if (TARG_RANGE > ATTACK_RANGE_CLAW)
			{
			}
			ANIM_ATTACK = ANIM_ATTACK_GORE;
		}
		if (TARG_RANGE < ATTACK_RANGE_CLAW)
		{
			ANIM_ATTACK = ANIM_ATTACK_CLAW;
			if (GetGameTime() > NEXT_FORCE_GORE)
			{
			}
			ANIM_ATTACK = ANIM_ATTACK_GORE;
		}
		if ((BBET_CAN_SLAM))
		{
			if (GetGameTime() > NEXT_SLAM)
			{
			}
			ANIM_ATTACK = ANIM_ATTACK_SLAM;
		}
	}

	void cycle_up()
	{
		if ((BBET_CAN_SLAM))
		{
			NEXT_SLAM = GetGameTime();
			NEXT_SLAM += FREQ_SLAM;
		}
		if ((BBET_CAN_FLY))
		{
			if (RandomInt(1, 2) == 1)
			{
			}
			BBET_NEXT_FLY_LEAP = GetGameTime();
			BBET_NEXT_FLY_LEAP += FREQ_FLY_LEAP;
		}
		if (!(GetGameTime() > NEXT_ALERT)) return;
		NEXT_ALERT = GetGameTime();
		NEXT_ALERT += FREQ_ALERT;
		AS_ATTACKING = GetGameTime();
		string RND_ANIM = RandomInt(1, 2);
		if (RND_ANIM == 1)
		{
			PlayAnim("critical", ANIM_ALERT);
		}
		if (RND_ANIM == 2)
		{
			PlayAnim("critical", ANIM_RAWR);
		}
		EmitSound(GetOwner(), 0, SOUND_GROWL, 10);
	}

	void npc_targetsighted()
	{
		if ((BBET_DID_GROWL)) return;
		BBET_DID_GROWL = 1;
		AS_ATTACKING = GetGameTime();
		string RND_ANIM = RandomInt(1, 2);
		if (RND_ANIM == 1)
		{
			PlayAnim("critical", ANIM_ALERT);
		}
		if (RND_ANIM == 2)
		{
			PlayAnim("critical", ANIM_RAWR);
		}
		EmitSound(GetOwner(), 0, SOUND_GROWL, 10);
	}

	void cycle_down()
	{
		BBET_DID_GROWL = 0;
	}

	void npcatk_lost_sight()
	{
		if (!(GetGameTime() > NEXT_SEARCH)) return;
		NEXT_SEARCH = GetGameTime();
		NEXT_SEARCH += FREQ_SEARCH;
		PlayAnim("once", ANIM_ALERT);
		EmitSound(GetOwner(), 0, SOUND_GROWL, 10);
	}

	void frame_gore_start()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void frame_gore()
	{
		NEXT_FORCE_GORE = GetGameTime();
		NEXT_FORCE_GORE += FREQ_FORCE_GORE;
		GORE_ATTACK = 1;
		if (BBET_SIZE == 1)
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE_GORE, DMG_GORE, ATTACK_HITCHANCE, DMGTYPE_GORE);
		}
		else
		{
			XDoDamage(GetEntityProperty(GetOwner(), "attachpos"), AOE_GORE, DMG_GORE, 0, GetOwner(), GetOwner(), "none", DMGTYPE_GORE);
		}
		ScheduleDelayedEvent(0.1, "bbet_reset_gore_attack");
	}

	void frame_leap_start()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		// svplaysound: svplaysound 1 10 SOUND_CHITTER_LOOP
		EmitSound(1, 10, SOUND_CHITTER_LOOP);
	}

	void frame_leap_attack1()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE_LEAP, DMG_LEAP, ATTACK_HITCHANCE, "slash");
		LEAP_ATTACK = 1;
		EmitSound(GetOwner(), 0, SOUND_LAND, 5);
		// svplaysound: svplaysound 1 0 SOUND_CHITTER_LOOP
		EmitSound(1, 0, SOUND_CHITTER_LOOP);
	}

	void frame_claw_up()
	{
		if (RandomInt(1, 5) != 1)
		{
			EmitSound(GetOwner(), 0, SOUND_SWIPE, 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE_CLAW, DMG_LEAP, ATTACK_HITCHANCE, "slash");
	}

	void bbet_reset_gore_attack()
	{
		GORE_ATTACK = 0;
	}

	void game_dodamage()
	{
		if ((GORE_ATTACK))
		{
			if (((param2 !is null)))
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-10, BBET_GORE_PUSH_STR, 110));
		}
		if ((LEAP_ATTACK))
		{
			if (((param2 !is null)))
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-10, BBET_GORE_PUSH_STR, 110));
		}
		LEAP_ATTACK = 0;
	}

	void frame_rise_done()
	{
		bbet_rise_complete();
	}

	void frame_slam_start()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void frame_slam()
	{
		// PlayRandomSound from: SOUND_SLAM
		array<string> sounds = {SOUND_SLAM};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		NEXT_SLAM = GetGameTime();
		NEXT_SLAM += FREQ_SLAM;
		beetle_slam();
	}

	void frame_on_back()
	{
		PlayAnim("critical", ANIM_IDLE_ONBACK);
	}

	void set_burrower()
	{
		BBET_BURROWER = 1;
		SetProp(GetOwner(), "rendermode", 1);
		SetProp(GetOwner(), "renderamt", 0);
		SetIdleAnim(ANIM_RISE_FROM_GROUND);
		SetMoveAnim(ANIM_RISE_FROM_GROUND);
		ScheduleDelayedEvent(0.1, "bbet_burrower_effect");
	}

	void bbet_burrower_effect()
	{
		string EFFECT_ORG = GetEntityOrigin(GetOwner());
		EFFECT_ORG = "z";
		EmitSound(GetOwner(), 0, SOUND_DIG1, 10);
		ClientEvent("new", "all", BBET_CL_SCRIPT, "burrow", EFFECT_ORG, BBET_BURROW_CLOUD_RADIUS);
		BBET_RENDERAMT = 0;
		bbet_burrower_effect_fadein();
		PlayAnim("critical", ANIM_RISE_FROM_GROUND);
	}

	void bbet_burrower_effect_fadein()
	{
		BBET_RENDERAMT += 50;
		if (BBET_RENDERAMT > 255)
		{
			BBET_RENDERAMT = 255;
		}
		SetProp(GetOwner(), "renderamt", BBET_RENDERAMT);
		if (BBET_RENDERAMT < 255)
		{
			ScheduleDelayedEvent(0.1, "bbet_burrower_effect_fadein");
		}
		if (!(BBET_RENDERAMT == 255)) return;
		SetProp(GetOwner(), "rendermode", 0);
		ScheduleDelayedEvent(2.0, "bbet_rise_complete");
	}

	void bbet_rise_complete()
	{
		if ((BBET_RISE_FINALIZED)) return;
		BBET_RISE_FINALIZED = 1;
		EmitSound(GetOwner(), 0, SOUND_DIG2, 10);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// svplaysound: svplaysound 1 0 SOUND_CHITTER_LOOP
		EmitSound(1, 0, SOUND_CHITTER_LOOP);
		// svplaysound: svplaysound 2 0 SOUND_FLY_LOOP
		EmitSound(2, 0, SOUND_FLY_LOOP);
		if ((BBET_ONBACK))
		{
			ANIM_DEATH = ANIM_DEATH_ONBACK;
		}
		else
		{
			ANIM_DEATH = ANIM_DEATH_NORMAL;
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 10);
		if (!(BBET_WILL_FAKE_DEATH)) return;
		if ((BBET_DID_FAKE_DEATH)) return;
		if ((BBET_FLYING)) return;
		if (!(GetEntityHealth(GetOwner()) < BBET_HALF_HP)) return;
		BBET_DID_FAKE_DEATH = 1;
		bbet_fake_death();
	}

	void bbet_fake_death()
	{
		npcatk_suspend_movement(ANIM_IDLE_ONBACK);
		PlayAnim("critical", ANIM_TO_BACK);
		BBET_ONBACK = 1;
		Random(4_0, 8_0)("bbet_get_up");
	}

	void bbet_get_up()
	{
		npcatk_resume_movement();
		PlayAnim("critical", ANIM_BACK_TO_FEET);
		BBET_ONBACK = 0;
	}

	void bbet_fly_leap()
	{
		BBET_FLY_LEAP = 1;
		bbet_fly_start();
	}

	void bbet_fly_start()
	{
		BBET_FLYING = 1;
		SetGravity(0);
		SetModelBody(1, 1);
		BBET_WINGS_CL_IDX = "game.script.last_sent_id";
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 200));
		if (!(BBET_FLY_LEAP))
		{
			BBET_MAX_FLY_TIME("bbet_end_flight");
		}
		else
		{
			ScheduleDelayedEvent(2.0, "bbet_end_flight");
		}
		SetMoveAnim(ANIM_FLY);
		ANIM_WALK = ANIM_FLY;
		ANIM_RUN = ANIM_FLY;
		NPC_NO_ATTACK = 1;
		// svplaysound: svplaysound 2 10 SOUND_FLY_LOOP
		EmitSound(2, 10, SOUND_FLY_LOOP);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(BBET_FLYING)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		if (m_hAttackTarget != "unset")
		{
			if (!(BBET_FLY_LEAP))
			{
				string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
				string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
				if ((IsValidPlayer(m_hAttackTarget)))
				{
					TARG_Z -= 38;
				}
				string Z_DIFF = TARG_Z;
				Z_DIFF -= MY_Z;
				if (Z_DIFF > 64)
				{
					if (Z_DIFF < 384)
					{
						SetGravity(0);
						string RND_LR = Random(-10, 10);
						int FWD_SPEED = 110;
						if (GetEntityRange(m_hAttackTarget) > 400)
						{
							int FWD_SPEED = 210;
						}
						AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_LR, FWD_SPEED, 200));
					}
					else
					{
						SetGravity(0.5);
						if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
						{
							bbet_end_flight();
						}
						else
						{
							string MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
							if ((GetMonsterProperty("origin")).z == MY_GROUND)
							{
							}
							AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 110, 200));
						}
					}
				}
				else
				{
					SetGravity(0.5);
					if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
					{
						bbet_end_flight();
					}
					else
					{
						string MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
						if ((GetMonsterProperty("origin")).z == MY_GROUND)
						{
						}
						LogDebug("stuck_ground");
						AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 110, 150));
					}
				}
			}
			else
			{
				if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
				{
					bbet_end_flight();
				}
				else
				{
					LogDebug("leap_flight");
					SetGravity(0.5);
					string RND_LR = Random(-10, 10);
					AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_LR, 150, 200));
				}
			}
		}
		else
		{
			bbet_end_flight();
		}
		if (!(BBET_FLYING)) return;
		if (!(STUCK_COUNT >= 1)) return;
		bbet_end_flight();
	}

	void bbet_end_flight()
	{
		if (!(BBET_FLYING)) return;
		BBET_NEXT_FLY = GetGameTime();
		BBET_NEXT_FLY += FREQ_FLY;
		BBET_FLYING = 0;
		BBET_FLY_LEAP = 0;
		// svplaysound: svplaysound 2 0 SOUND_FLY_LOOP
		EmitSound(2, 0, SOUND_FLY_LOOP);
		SetGravity(1);
		ANIM_WALK = ANIM_WALK_DEFAULT;
		ANIM_RUN = ANIM_RUN_DEFAULT;
		SetMoveAnim(ANIM_RUN);
		NPC_NO_ATTACK = 0;
		SetModelBody(1, 0);
		string MY_POS = GetEntityOrigin(GetOwner());
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(MY_POS);
		if (!((MY_POS).z != GROUND_Z)) return;
		BBET_WAITING_TO_DROP = 1;
		ScheduleDelayedEvent(5.0, "bbet_stop_waiting_for_drop");
		bbet_wait_to_drop_loop();
	}

	void bbet_stop_waiting_for_drop()
	{
		BBET_WAITING_TO_DROP = 0;
	}

	void bbet_wait_to_drop_loop()
	{
		if (!(BBET_WAITING_TO_DROP)) return;
		string MY_POS = GetEntityOrigin(GetOwner());
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(MY_POS);
		if ((MY_POS).z != GROUND_Z)
		{
			ScheduleDelayedEvent(0.1, "bbet_wait_to_drop_loop");
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_LAND, 10);
			BBET_WAITING_TO_DROP = 0;
		}
	}

	void freeze_solid()
	{
		if (!(BBET_FLYING)) return;
		bbet_end_flight();
	}

}

}
