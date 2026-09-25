#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class DragonGreenMini : CGameScript
{
	string ANIMSET_ATK_CLOSE;
	string ANIMSET_ATK_FAR;
	string ANIM_ATTACK;
	string ANIM_BREATH_CLOSE;
	string ANIM_BREATH_FAR;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SPIT;
	string ANIM_WALK;
	int AOE_BITE;
	int AOE_CLAW;
	int AOE_STOMP;
	string AS_ATTACKING;
	int ATK_SOUND_IDX;
	int ATTACK_ANIM_IDX;
	int ATTACK_HITRANGE;
	string ATTACK_MODE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BLOB_ORG;
	int BONE_LEFT_CLAW;
	int BONE_LEFT_FOOT;
	int BONE_RIGHT_CLAW;
	string BREATH_CURRENT_YAW;
	string BREATH_FWD_OFS;
	int BREATH_HOVER;
	int BREATH_IDX;
	int BREATH_LOOP_SOUND;
	int BREATH_ON;
	string BREATH_TARGET;
	string CL_BREATH_IDX;
	string CL_WIND_IDX;
	string CUR_SPIT_TARG_IDX;
	string DEBUG_BEAM_END;
	string DEBUG_BEAM_RADIUS;
	int DEBUG_BEAM_ROT;
	string DEBUG_BEAM_START;
	int DID_INTRO;
	int DMG_BITE;
	int DMG_BREATH;
	int DMG_CLAW;
	string DMG_GLOB;
	int DMG_STOMP;
	int DOT_BREATH;
	float FALLOFF_BITE;
	float FALLOFF_CLAW;
	int FALLOFF_STOMP;
	int FORCE_BREATH;
	float FREQ_BREATH;
	string GLOB_TARG;
	string HALF_HEALTH;
	float HOVER_DURATION;
	string MASTER_ID;
	int MAX_BREATH_RANGE;
	int MOVE_RANGE;
	string NEXT_BREATH;
	string NEXT_BREATH_DEBUG_CIRC;
	string NEXT_BREATH_DMG;
	string NEXT_GLOAT;
	string NEXT_STANCE_SHIFT;
	int NO_SPAWN_STUCK_CHECK;
	int NO_STEP_ADJ;
	float NPC_BOSS_REGEN_FREQ;
	float NPC_BOSS_REGEN_RATE;
	float NPC_DELAY_RETALITATE;
	int NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	int NPC_MUST_SEE_TARGET;
	string PROJ_LAND_ORG;
	string PROJ_NME_TARGS;
	string SLAM_ORG;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_BREATH;
	string SOUND_BREATH_LOOP;
	string SOUND_BREATH_START;
	string SOUND_DEATH;
	string SOUND_FLAP;
	string SOUND_IDLE;
	string SOUND_INTRO;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_STEP3;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_SWING;

	DragonGreenMini()
	{
		ANIMSET_ATK_CLOSE = "anim_atk_close1;anim_atk_close2;anim_atk_close2;anim_atk_close1;anim_atk_close2;anim_atk_close3;anim_atk_close1;anim_atk_close2;anim_atk_close4";
		ANIMSET_ATK_FAR = "anim_atk_far1";
		ANIM_BREATH_CLOSE = "anim_breath_close";
		ANIM_BREATH_FAR = "anim_breath_far";
		ANIM_ATTACK = "anim_atk_far1";
		ANIM_RUN = "anim_lx_leap";
		ANIM_WALK = "anim_lx_leap";
		ANIM_IDLE = "anim_idle_deep";
		ANIM_SPIT = "anim_atk_fireball";
		ANIM_BREATH_FAR = "anim_breath_far";
		ANIM_BREATH_CLOSE = "anim_breath_close";
		NO_SPAWN_STUCK_CHECK = 1;
		NO_STEP_ADJ = 1;
		NPC_MUST_SEE_TARGET = 0;
		ATTACK_MOVERANGE = 256;
		MOVE_RANGE = 256;
		ATTACK_RANGE = 265;
		ATTACK_HITRANGE = 265;
		NPC_IS_BOSS = 1;
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_REGEN_FREQ = 120.0;
		NPC_GIVE_EXP = 20000;
		MAX_BREATH_RANGE = 384;
		ATTACK_MODE = "close";
		BONE_RIGHT_CLAW = 35;
		BONE_LEFT_CLAW = 30;
		BONE_LEFT_FOOT = 72;
		DMG_CLAW = 400;
		AOE_CLAW = 128;
		FALLOFF_CLAW = 0.01;
		DMG_BITE = 600;
		AOE_BITE = 96;
		FALLOFF_BITE = 0.01;
		DMG_STOMP = 800;
		AOE_STOMP = 256;
		FALLOFF_STOMP = 0;
		SOUND_INTRO = "monsters/dragons/c_dragnold_bat2.wav";
		SOUND_ALERT1 = "monsters/dragons/c_dragnold_bat1.wav";
		SOUND_ALERT2 = "monsters/dragons/c_dragnold_bat2.wav";
		SOUND_ATTACK1 = "monsters/dragons/c_dragnold_atk1.wav";
		SOUND_ATTACK2 = "monsters/dragons/c_dragnold_atk2.wav";
		SOUND_ATTACK3 = "monsters/dragons/c_dragnold_atk3.wav";
		SOUND_DEATH = "monsters/dragons/c_dragnold_dead.wav";
		SOUND_PAIN1 = "monsters/dragons/c_dragnold_hit1.wav";
		SOUND_PAIN2 = "monsters/dragons/c_dragnold_hit2.wav";
		SOUND_PAIN3 = "monsters/dragons/c_dragonold_hit2.wav";
		SOUND_IDLE = "monsters/dragons/c_dragnold_slct.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_SWING = "weapons/swinghuge.wav";
		SOUND_STEP1 = "monsters/dragons/fs_x0snw_drg1.wav";
		SOUND_STEP2 = "monsters/dragons/fs_x0snw_drg2.wav";
		SOUND_STEP3 = "monsters/dragons/fs_x0snw_drg3.wav";
		SOUND_BREATH = "magic/spookie1.wav";
		SOUND_BREATH_START = "magic/flame_loop_start.wav";
		SOUND_BREATH_LOOP = "magic/flame_loop.wav";
		SOUND_FLAP = "monsters/bat/flap_big.wav";
		FREQ_BREATH = Random(60.0, 120.0);
		BREATH_IDX = 0;
		HOVER_DURATION = 15.0;
		ATK_SOUND_IDX = 0;
		DMG_BREATH = 75;
		DOT_BREATH = 100;
		NPC_DELAY_RETALITATE = Random(10.0, 20.0);
		Precache("monsters/monster_extras.mdl");
	}

	void game_precache()
	{
		Precache("nashalrath/dragon_green_mini_cl");
		Precache("nashalrath/wind_cl");
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 monsters/bat/flap_big.wav
		EmitSound(0, 0, "monsters/bat/flap_big.wav");
	}

	void OnSpawn() override
	{
		SetName("Aspect of Jaminporlants");
		SetName("gdragon_aspect");
		SetModel("monsters/dragon_green_mini.mdl");
		SetRace("demon");
		SetWidth(256);
		SetHeight(256);
		SetHealth(40000);
		SetNoPush(true);
		SetDamageResistance("all", 0.25);
		SetDamageResistance("cold", 0.75);
		SetDamageResistance("holy", 0.0);
		SetDamageResistance("stun", 0);
		SetHearingSensitivity(11);
		SetIdleAnim("anim_intro");
		SetMoveAnim("anim_intro");
		ATTACK_ANIM_IDX = 0;
		SetTurnRate(0.1);
		SetStepSize(0);
		ScheduleDelayedEvent(2.0, "get_final_props");
	}

	void get_final_props()
	{
		HALF_HEALTH = GetEntityMaxHealth(GetOwner());
		HALF_HEALTH *= 0.5;
		MASTER_ID = FindEntityByName("gdragon_img");
		string MASTER_TARG = GetEntityProperty(MASTER_ID, "scriptvar");
		npcatk_settarget(MASTER_TARG);
	}

	void npc_targetsighted()
	{
		if ((DID_INTRO)) return;
		DID_INTRO = 1;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		PlayAnim("critical", "anim_intro");
		EmitSound(GetOwner(), 0, SOUND_INTRO, 10);
		CallExternal("players", "ext_play_music_me", "tikal.mp3");
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
	}

	void npc_selectattack()
	{
		if (GetGameTime() > NEXT_STANCE_SHIFT)
		{
			NEXT_STANCE_SHIFT = GetGameTime();
			NEXT_STANCE_SHIFT += Random(4.0, 6.0);
			if (GetEntityRange(m_hAttackTarget) < 128)
			{
				if (ATTACK_MODE != "close")
				{
				}
				ANIM_ATTACK = "anim_far2close";
			}
			else
			{
				if (ATTACK_MODE != "far")
				{
				}
				ANIM_ATTACK = "anim_close2far";
			}
		}
	}

	void frame_far2close_done()
	{
		ATTACK_MODE = "close";
		ANIM_IDLE = "anim_idle_close";
		SetIdleAnim(ANIM_IDLE);
		dist_select_attack();
	}

	void frame_close2far_done()
	{
		ATTACK_MODE = "far";
		ANIM_IDLE = "anim_idle_far";
		SetIdleAnim(ANIM_IDLE);
		dist_select_attack();
	}

	void frame_slct_next_attack()
	{
		dist_select_attack();
		EmitSound(GetOwner(), 0, SOUND_SWING, 10);
	}

	void dist_select_attack()
	{
		if (ATTACK_MODE == "close")
		{
			if (ATTACK_ANIM_IDX >= GetTokenCount(ANIMSET_ATK_CLOSE, ";"))
			{
				ATTACK_ANIM_IDX = 0;
			}
			ANIM_ATTACK = GetToken(ANIMSET_ATK_CLOSE, ATTACK_ANIM_IDX, ";");
			ATTACK_ANIM_IDX += 1;
		}
		if (ATTACK_MODE == "far")
		{
			if (ATTACK_ANIM_IDX >= GetTokenCount(ANIMSET_ATK_FAR, ";"))
			{
				ATTACK_ANIM_IDX = 0;
			}
			ANIM_ATTACK = GetToken(ANIMSET_ATK_FAR, ATTACK_ANIM_IDX, ";");
			ATTACK_ANIM_IDX += 1;
		}
	}

	void frame_claw_right()
	{
		attack_sound();
		string L_POS = GetEntityProperty(GetOwner(), "svbonepos");
		L_POS = "z";
		if ((G_DEVELOPER_MODE))
		{
			debug_circle(L_POS, AOE_CLAW);
		}
		XDoDamage(L_POS, AOE_CLAW, DMG_CLAW, FALLOFF_CLAW, GetOwner(), GetOwner(), "none", "slash");
	}

	void frame_claw_left()
	{
		attack_sound();
		string L_POS = GetEntityProperty(GetOwner(), "svbonepos");
		L_POS = "z";
		if ((G_DEVELOPER_MODE))
		{
			debug_circle(L_POS, AOE_CLAW);
		}
		XDoDamage(L_POS, AOE_CLAW, DMG_CLAW, FALLOFF_CLAW, GetOwner(), GetOwner(), "none", "slash");
	}

	void frame_bite()
	{
		attack_sound();
		string L_POS = GetEntityProperty(GetOwner(), "attachpos");
		L_POS = "z";
		if ((G_DEVELOPER_MODE))
		{
			debug_circle(L_POS, AOE_BITE);
		}
		XDoDamage(L_POS, AOE_BITE, DMG_BITE, FALLOFF_BITE, GetOwner(), GetOwner(), "none", "pierce");
	}

	void frame_knock_left()
	{
		attack_sound();
		string L_POS = GetEntityProperty(GetOwner(), "svbonepos");
		L_POS = "z";
		if ((G_DEVELOPER_MODE))
		{
			debug_circle(L_POS, AOE_CLAW);
		}
		string L_DMG = DMG_CLAW;
		L_DMG *= 1.5;
		XDoDamage(L_POS, AOE_CLAW, L_DMG, FALLOFF_CLAW, GetOwner(), GetOwner(), "none", "slash_effect", "dmgevent:knockleft");
	}

	void knockleft_dodamage()
	{
		if (!(param1)) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(-800, 100, 120));
	}

	void frame_stomp()
	{
		string L_POS = GetEntityProperty(GetOwner(), "svbonepos");
		L_POS = "z";
		if ((G_DEVELOPER_MODE))
		{
			debug_circle(L_POS, AOE_STOMP);
		}
		ClientEvent("new", "all", "effects/sfx_stun_burst", L_POS, 256, 1, Vector3(0, 0, 255));
		SLAM_ORG = L_POS;
		XDoDamage(L_POS, AOE_STOMP, DMG_STOMP, FALLOFF_STOMP, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:stomp");
	}

	void stomp_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		if (!(IsOnGround(param2))) return;
		ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = SLAM_ORG;
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 500, 110)));
	}

	void debug_circle()
	{
		DEBUG_BEAM_START = param1;
		DEBUG_BEAM_END = DEBUG_BEAM_START;
		DEBUG_BEAM_END += "z";
		DEBUG_BEAM_RADIUS = param2;
		Effect("beam", "point", "lgtning.spr", 20, DEBUG_BEAM_START, DEBUG_BEAM_END, Vector3(255, 0, 255), 200, 0, 1.0);
		DEBUG_BEAM_ROT = 0;
		for (int i = 0; i < 16; i++)
		{
			debug_circle_loop();
		}
	}

	void debug_circle_loop()
	{
		string BEAM_START = DEBUG_BEAM_START;
		string BEAM_END = DEBUG_BEAM_START;
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, DEBUG_BEAM_ROT, 0), Vector3(0, DEBUG_BEAM_RADIUS, 32));
		DEBUG_BEAM_ROT += 22.5;
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, DEBUG_BEAM_ROT, 0), Vector3(0, DEBUG_BEAM_RADIUS, 32));
		Effect("beam", "point", "lgtning.spr", 20, BEAM_START, BEAM_END, Vector3(255, 0, 255), 200, 0, 1.0);
	}

	void my_target_died()
	{
		if (!(GetGameTime() > NEXT_GLOAT)) return;
		NEXT_GLOAT = GetGameTime();
		NEXT_GLOAT += Random(20.0, 60.0);
		CallExternal(MASTER_ID, "ext_gloat");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(MASTER_ID, "ext_image_died");
		ANIM_DEATH = "anim_die_far";
		if (ATTACK_MODE == "close")
		{
			ANIM_DEATH = "anim_die_close";
		}
		if (ATTACK_MODE == "far")
		{
			ANIM_DEATH = "anim_die_far";
		}
		if (GetEntityRange(m_hLastStruck) > 384)
		{
			ANIM_DEATH = "anim_die_vfar";
		}
		if ((BREATH_ON))
		{
			ClientEvent("update", "all", CL_BREATH_IDX, "end_fx");
			if ((BREATH_HOVER))
			{
				ClientEvent("update", "all", CL_WIND_IDX, "end_fx");
			}
			if ((BREATH_LOOP_SOUND))
			{
				EmitSound(GetOwner(), 4, SOUND_BREATH_LOOP, 0);
			}
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetEntityHealth(GetOwner()) > HALF_HP)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void attack_sound()
	{
		ATK_SOUND_IDX += 1;
		if (ATK_SOUND_IDX == 2)
		{
			EmitSound(GetOwner(), 0, SOUND_ATTACK1, 10);
		}
		if (ATK_SOUND_IDX == 4)
		{
			EmitSound(GetOwner(), 0, SOUND_ATTACK2, 10);
		}
		if (ATK_SOUND_IDX == 6)
		{
			EmitSound(GetOwner(), 0, SOUND_ATTACK3, 10);
			ATK_SOUND_IDX = 0;
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(GetGameTime() > NEXT_BREATH)) return;
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
		if (!(m_hAttackTarget != "unset")) return;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 15.0;
		do_breath();
	}

	void do_breath()
	{
		LogDebug("do_breath BREATH_IDX FORCE_BREATH");
		int VFAR_BREATH = 0;
		if (GetEntityRange(m_hAttackTarget) > MAX_BREATH_RANGE)
		{
			int VFAR_BREATH = 1;
		}
		if (FORCE_BREATH == "vfar")
		{
			int VFAR_BREATH = 1;
		}
		if ((VFAR_BREATH))
		{
			BREATH_TARGET = m_hAttackTarget;
			npcatk_suspend_movement(ANIM_SPIT);
			npcatk_suspend_ai(5.0);
			PlayAnim("critical", ANIM_SPIT);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		BREATH_IDX += 1;
		if (FORCE_BREATH == "hover")
		{
			BREATH_IDX = 6;
		}
		if (BREATH_IDX < 5)
		{
			BREATH_FWD_OFS = 64;
			string L_ATTACK_MODE = ATTACK_MODE;
			if (FORCE_BREATH == "close")
			{
				string L_ATTACK_MODE = FORCE_BREATH;
			}
			if (FORCE_BREATH == "far")
			{
				string L_ATTACK_MODE = FORCE_BREATH;
			}
			if (L_ATTACK_MODE == "close")
			{
				PlayAnim("critical", ANIM_BREATH_CLOSE);
				BREATH_TARGET = m_hAttackTarget;
				BREATH_FORWARD = 100;
				npcatk_suspend_ai(5.0);
				npcatk_suspend_movement(ANIM_BREATH_CLOSE);
			}
			else
			{
				PlayAnim("critical", ANIM_BREATH_FAR);
				BREATH_TARGET = m_hAttackTarget;
				BREATH_FORWARD = 200;
				npcatk_suspend_ai(5.0);
				npcatk_suspend_movement(ANIM_BREATH_FAR);
			}
		}
		if (BREATH_IDX == 6)
		{
			BREATH_IDX = 0;
			npcatk_suspend_ai(25.0);
			BREATH_FWD_OFS = 128;
			if (ATTACK_MODE == "close")
			{
				PlayAnim("critical", "anim_close2hover");
			}
			if (ATTACK_MODE == "far")
			{
				PlayAnim("critical", "anim_far2hover");
			}
			string WIND_ORG = GetEntityOrigin(GetOwner());
			string L_HOVER_DURATION = HOVER_DURATION;
			L_HOVER_DURATION += 1.0;
			ClientEvent("new", "all", "nashalrath/wind_cl", WIND_ORG, 1.0, L_HOVER_DURATION);
			CL_WIND_IDX = "game.script.last_sent_id";
		}
		FORCE_BREATH = 0;
	}

	void frame_launch()
	{
		EmitSound(GetOwner(), 0, SOUND_FLAP, 10);
	}

	void frame_launch_done()
	{
		npcatk_suspend_movement("anim_hover_breath");
		PlayAnim("critical", "anim_hover_breath");
		EmitSound(GetOwner(), 0, SOUND_BREATH_START, 10);
		ClientEvent("new", "all", "nashalrath/dragon_green_mini_cl", GetEntityIndex(GetOwner()), "breath");
		CL_BREATH_IDX = "game.script.last_sent_id";
		BREATH_CURRENT_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		BREATH_ON = 1;
		BREATH_HOVER = 1;
		breath_loop();
		HOVER_DURATION("breath_end");
	}

	void frame_breath_prep()
	{
		EmitSound(GetOwner(), 0, SOUND_BREATH, 10);
		SetMoveDest(BREATH_TARGET);
	}

	void frame_breath_far_start()
	{
		breath_start();
	}

	void frame_breath_close_start()
	{
		breath_start();
	}

	void frame_breath_close_end()
	{
		breath_end();
	}

	void frame_breath_far_end()
	{
		breath_end();
	}

	void breath_start()
	{
		EmitSound(GetOwner(), 1, SOUND_BREATH_START, 10);
		ScheduleDelayedEvent(1.5, "breath_loop_sound");
		ClientEvent("new", "all", "nashalrath/dragon_green_mini_cl", GetEntityIndex(GetOwner()), "breath");
		CL_BREATH_IDX = "game.script.last_sent_id";
		BREATH_CURRENT_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		BREATH_ON = 1;
		breath_loop();
	}

	void breath_loop_sound()
	{
		if (!(BREATH_ON)) return;
		BREATH_LOOP_SOUND = 1;
		EmitSound(GetOwner(), 4, SOUND_BREATH_LOOP, 10);
	}

	void breath_loop()
	{
		if (!(BREATH_ON)) return;
		ScheduleDelayedEvent(0.1, "breath_loop");
		if (!(BREATH_HOVER))
		{
			if (GetGameTime() > NEXT_BREATH_ANG_ADJ)
			{
				NEXT_BREATH_ANG_ADJ = GetGameTime();
				NEXT_BREATH_ANG_ADJ += 1.0;
				if ((IsEntityAlive(BREATH_TARGET)))
				{
				}
				string MY_ORG = GetEntityOrigin(GetOwner());
				string TARG_ORG = GetEntityOrigin(BREATH_TARGET);
				string ANG_TO_TARG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
				BREATH_DEST_YAW = ANG_TO_TARG;
			}
			string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
			if (BREATH_CURRENT_YAW != BREATH_DEST_YAW)
			{
				if (BREATH_DEST_YAW < MY_YAW)
				{
					BREATH_ROT_DIR = -1;
				}
				else
				{
					BREATH_ROT_DIR = 1;
				}
				BREATH_CURRENT_YAW += BREATH_ROT_DIR;
				if (/* TODO: $anglediff */ $anglediff(BREATH_DEST_YAW, BREATH_CURRENT_YAW) < 10)
				{
					BREATH_CURRENT_YAW = BREATH_DEST_YAW;
				}
				string L_BREATH_FACE_ORG = GetEntityOrigin(GetOwner());
				L_BREATH_FACE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_CURRENT_YAW, 0), Vector3(0, 500, 0));
				SetMoveDest(L_BREATH_FACE_ORG);
			}
		}
		else
		{
			BREATH_CURRENT_YAW += 2;
			if (BREATH_CURRENT_YAW > 359.99)
			{
				BREATH_CURRENT_YAW = 0;
			}
			string L_BREATH_FACE_ORG = GetEntityOrigin(GetOwner());
			L_BREATH_FACE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_CURRENT_YAW, 0), Vector3(0, 500, 0));
			SetMoveDest(L_BREATH_FACE_ORG);
			if (GetGameTime() > NEXT_FLAP_SOUND)
			{
				NEXT_FLAP_SOUND = GetGameTime();
				NEXT_FLAP_SOUND += 1.0;
				EmitSound3D(SOUND_FLAP, 10, GetEntityProperty(GetOwner(), "attachpos"));
			}
		}
		if (!(GetGameTime() > NEXT_BREATH_DMG)) return;
		NEXT_BREATH_DMG = GetGameTime();
		NEXT_BREATH_DMG += Random(0.2, 0.5);
		string L_BREATH_POS = GetEntityProperty(GetOwner(), "attachpos");
		L_BREATH_POS = "z";
		L_BREATH_POS += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_CURRENT_YAW, 0), Vector3(0, BREATH_FWD_OFS, 0));
		XDoDamage(L_BREATH_POS, 128, DMG_BREATH, 0.1, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:breath");
		if ((G_DEVELOPER_MODE))
		{
			if (GetGameTime() > NEXT_BREATH_DEBUG_CIRC)
			{
			}
			NEXT_BREATH_DEBUG_CIRC = GetGameTime();
			NEXT_BREATH_DEBUG_CIRC += 1;
			debug_circle(L_BREATH_POS, 128);
		}
	}

	void breath_dodamage()
	{
		if (!(param1)) return;
		if (!(GetEntityProperty(param2, "haseffect")))
		{
			ApplyEffect(param2, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_BREATH);
		}
		ApplyEffect(param2, "effects/dot_acid", 5.0, GetEntityIndex(GetOwner()), DOT_BREATH, "none");
	}

	void breath_end()
	{
		BREATH_ON = 0;
		ClientEvent("update", "all", CL_BREATH_IDX, "end_fx");
		EmitSound(GetOwner(), 4, SOUND_BREATH_LOOP, 0);
		BREATH_LOOP_SOUND = 0;
		if ((BREATH_HOVER))
		{
			if (ATTACK_MODE == "close")
			{
				PlayAnim("critical", "anim_hover2close");
			}
			else
			{
				PlayAnim("critical", "anim_hover2far");
			}
			EmitSound(GetOwner(), 0, SOUND_FLAP, 10);
		}
		if ((BREATH_HOVER)) return;
		npcatk_resume_movement();
		npcatk_resume_ai();
	}

	void frame_land()
	{
		BREATH_HOVER = 0;
		npcatk_resume_ai();
		npcatk_resume_movement();
		ClientEvent("update", "all", CL_WIND_IDX, "end_fx");
	}

	void frame_vfar_breath_start()
	{
		EmitSound(GetOwner(), 0, SOUND_BREATH, 10);
		SetMoveDest(BREATH_TARGET);
	}

	void frame_vfar_breath_fire()
	{
		EmitSound(GetOwner(), 0, SOUND_SPIT, 10);
		string SPIT_DEST = GetEntityProperty(GetOwner(), "attachpos");
		string SPIT_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		SPIT_DEST += /* TODO: $relpos */ $relpos(Vector3(0, SPIT_YAW, 0), Vector3(0, 512, 0));
		TossProjectile("proj_gdragon_spit", GetEntityProperty(GetOwner(), "attachpos"), SPIT_DEST, 400, 0, 0, "none");
		npcatk_resume_movement();
		npcatk_resume_ai();
	}

	void ext_proj_touch()
	{
		string L_DOT_BREATH = DOT_BREATH;
		L_DOT_BREATH *= 0.5;
		ApplyEffect(param1, "effects/dot_poison_blind", 5.0, GetEntityIndex(GetOwner()), L_DOT_BREATH);
	}

	void ext_proj_landed()
	{
		PROJ_LAND_ORG = param1;
		PROJ_NME_TARGS = FindEntitiesInSphere("enemy", 1024);
		if (PROJ_NME_TARGS != "none")
		{
			CUR_SPIT_TARG_IDX = 0;
			guided_slime_ball();
			ScheduleDelayedEvent(0.4, "guided_slime_ball");
			if (GetTokenCount(PROJ_NME_TARGS, ";") > 1)
			{
				ScheduleDelayedEvent(0.6, "guided_slime_ball");
			}
			if (GetTokenCount(PROJ_NME_TARGS, ";") > 2)
			{
				ScheduleDelayedEvent(0.8, "guided_slime_ball");
			}
		}
	}

	void guided_slime_ball()
	{
		string CUR_TARG = GetToken(PROJ_NME_TARGS, CUR_SPIT_TARG_IDX, ";");
		CUR_SPIT_TARG_IDX += 1;
		if (CUR_SPIT_TARG_IDX > GetTokenCount(PROJ_NME_TARGS, ";"))
		{
			CUR_SPIT_TARG_IDX = 0;
		}
		GLOB_TARG = CUR_TARG;
		TossProjectile("proj_glob_guided", PROJ_LAND_ORG, CUR_TARG, 200, 0, 0, "none");
	}

	void ext_glob_landed()
	{
		BLOB_ORG = param1;
		DMG_GLOB = DOT_BREATH;
		DMG_GLOB *= 0.5;
		XDoDamage(param1, 96, DMG_GLOB, 0.2, GetOwner(), GetOwner(), "none", "acid_effect", "dmgevent:glob");
	}

	void glob_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		string TARG_ORG = GetEntityOrigin(param2);
		float BLOB_DIST = Distance(BLOB_ORG, TARG_ORG);
		BLOB_DIST /= 64;
		int BLOB_DIST_RATIO = 1;
		BLOB_DIST_RATIO -= BLOB_DIST;
		string BLIND_DURATION = /* TODO: $ratio */ $ratio(BLOB_DIST_RATIO, 2.0, 6.0);
		ApplyEffect(param2, "effects/dot_poison_blind", BLIND_DURATION, GetEntityIndex(GetOwner()), DMG_GLOB);
	}

	void ext_abreath_now()
	{
		LogDebug("ext_abreath_now PARAM1");
		NEXT_BREATH = 0;
		if ((param1).findFirst(PARAM) == 0)
		{
			int DO_NADDA = 1;
		}
		else
		{
			FORCE_BREATH = param1;
		}
	}

}

}
