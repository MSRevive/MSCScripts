#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SpiderCrystal : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_PREFIX;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BITE_ATTACK;
	string DELAY_V_PUSH;
	string DID_INTRO;
	int GROUND_MODE;
	int HITRANGE_CLOSE;
	int HITRANGE_NORM;
	int IMMUNE_VAMPIRE;
	int MOVERANGE_NORM;
	int MOVERANGE_PROJ;
	int MOVE_RANGE;
	string NEXT_BITE;
	string NEXT_INTRO;
	string NEXT_SIDESTEP;
	string NEXT_TELEPORT;
	int NEXT_TELE_FIX;
	int NPC_GIVE_EXP;
	int NPC_RANGED;
	int NPC_RENDER_AMT;
	int NPC_RENDER_MODE;
	string PROJ_SPRITE;
	int RANGE_CLOSE;
	int RANGE_NORM;
	int RANGE_PROJ;
	int STAY_ON_GROUND;
	string TELE_TYPE;
	int V_ADJ;

	SpiderCrystal()
	{
		ANIM_IDLE = "c_idle";
		ANIM_WALK = "c_walk";
		ANIM_RUN = "c_run";
		ANIM_ATTACK = "c_project";
		ANIM_PREFIX = "c_";
		const string BANIM_IDLE = "idle";
		const string BANIM_WALK = "walk";
		const string BANIM_RUN = "run";
		const string BANIM_DODGEL = "walkl";
		const string BANIM_DODGER = "walkr";
		const string BANIM_BITE = "bite";
		const string BANIM_SPELL = "spell";
		const string BANIM_DOUBLEATK = "dblslash";
		const string BANIM_CLOSEATK = "close";
		const string BANIM_FLING = "fling";
		const string BANIM_PROJ = "project";
		const string BANIM_REEL = "real";
		const string BANIM_FLINCH = "flinch";
		const string C_PREFIX = "c_";
		const string G_PREFIX = "g_";
		const string ANIM_JUMP = "g_jump";
		const string ANIM_TOGROUND = "toground";
		ANIM_DEATH = "death";
		NPC_GIVE_EXP = 600;
		ATTACK_RANGE = 9999;
		ATTACK_HITRANGE = 9999;
		ATTACK_MOVERANGE = 100;
		MOVE_RANGE = 100;
		RANGE_NORM = 150;
		MOVERANGE_NORM = 100;
		HITRANGE_NORM = 175;
		RANGE_CLOSE = 70;
		HITRANGE_CLOSE = 100;
		const int RANGE_CHASE = 300;
		RANGE_PROJ = 9999;
		MOVERANGE_PROJ = 9999;
		NPC_RANGED = 1;
		const string FREQ_BITE = Random(10.0, 15.0);
		const string FREQ_TELEPORT = Random(10.0, 20.0);
		const string FREQ_SIDESTEP = Random(10.0, 20.0);
		const float DOT_POISON = 30.0;
		const float DMG_SWIPE = 75.0;
		const float DMG_BITE = 100.0;
		const float DMG_PROJ = 60.0;
		const float DOT_SHOCK = 20.0;
		const int ATTACH_MAW = 0;
		const int ATTACH_CLAW1 = 1;
		const int ATTACH_CLAW2 = 2;
		const string SOUND_ALERT1 = "monsters/spider/c_pspidhas_bat1.wav";
		const string SOUND_ALERT2 = "monsters/spider/c_pspidire_bat1.wav";
		const string SOUND_ALERT3 = "monsters/spider/c_pspidr_bat1.wav";
		const string SOUND_ALERT4 = "monsters/spider/c_pspidr_bat2.wav";
		const string SOUND_PAIN1 = "monsters/spider/c_pspidr_hit1.wav";
		const string SOUND_PAIN2 = "monsters/spider/c_pspidr_hit2.wav";
		const string SOUND_ATTACK1 = "monsters/spider/c_pspidr_atk1.wav";
		const string SOUND_ATTACK2 = "monsters/spider/c_pspidr_atk2.wav";
		const string SOUND_ATTACK3 = "monsters/spider/c_pspidr_atk3.wav";
		const string SOUND_MANIFEST = "monsters/spider/c_pspidrth_bat1.wav";
		const string SOUND_QUICK1 = "monsters/spider/c_pspidr_no.wav";
		const string SOUND_QUICK2 = "monsters/spider/c_pspidr_yes.wav";
		const string SOUND_SEARCH = "monsters/spider/c_pspidr_slct.wav";
		const string SOUND_DEATH = "monsters/spider/c_pspidr_dead.wav";
		PROJ_SPRITE = "nhth1.spr";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(5.0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", NPC_RENDER_AMT);
	}

	void game_precache()
	{
		Precache("nhth1.spr");
		Precache(SOUND_DEATH);
		Precache("debris/beamstart4.wav");
		Precache("c-tele1.spr");
		Precache("magic/teleport.wav");
	}

	void OnSpawn() override
	{
		SetName("Crystal Phase Spider");
		SetModel("monsters/spider_crystal.mdl");
		SetWidth(48);
		SetHeight(48);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(11);
		SetRace("spider");
		SetRoam(true);
		IMMUNE_VAMPIRE = 1;
		NPC_RENDER_AMT = 0;
		if (!(true)) return;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SetHealth(1000);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("slash", 0.75);
		SetDamageResistance("blunt", 1.25);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("poison", 0.0);
		TELE_TYPE = "melee";
		NEXT_TELE_FIX = 99999;
	}

	void set_start_ground()
	{
		ground_mode();
	}

	void set_stay_ground()
	{
		set_start_ground();
		STAY_ON_GROUND = 1;
	}

	void OnPostSpawn() override
	{
		NPC_RENDER_AMT = 0;
		NPC_RENDER_MODE = 5;
		spider_fade_in();
		if ((GROUND_MODE)) return;
		ScheduleDelayedEvent(0.1, "ceiling_mode");
	}

	void spider_fade_in()
	{
		NPC_RENDER_AMT += 10;
		if (NPC_RENDER_AMT < 255)
		{
			SetProp(GetOwner(), "renderamt", NPC_RENDER_AMT);
			ScheduleDelayedEvent(0.1, "spider_fade_in");
		}
		else
		{
			SetProp(GetOwner(), "renderamt", 255);
			SetProp(GetOwner(), "rendermode", 5);
			NPC_RENDER_AMT = 255;
		}
	}

	void ground_mode()
	{
		if (!(GROUND_MODE))
		{
			PlayAnim("critical", ANIM_TOGROUND);
		}
		ANIM_IDLE = "g_idle";
		ANIM_WALK = "g_walk";
		ANIM_RUN = "g_run";
		ANIM_ATTACK = "g_projectile";
		GROUND_MODE = 1;
		ANIM_PREFIX = G_PREFIX;
		V_ADJ = 64;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void ceiling_mode()
	{
		if ((GROUND_MODE))
		{
			PlayAnim("critical", ANIM_JUMP);
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 1000));
		DELAY_V_PUSH = GetGameTime();
		DELAY_V_PUSH += 1.0;
		ANIM_IDLE = "c_idle";
		ANIM_WALK = "c_walk";
		ANIM_RUN = "c_run";
		ANIM_ATTACK = "c_project";
		GROUND_MODE = 0;
		ANIM_PREFIX = C_PREFIX;
		V_ADJ = -64;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void npc_targetsighted()
	{
		if (!(DID_INTRO))
		{
			if (GetGameTime() > NEXT_INTRO)
			{
			}
			DID_INTRO = 1;
			// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4
			array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			NEXT_SIDESTEP = GetGameTime();
			NEXT_SIDESTEP += Random(30.0, 40.0);
			NEXT_TELEPORT = GetGameTime();
			NEXT_TELEPORT += FREQ_TELEPORT;
		}
	}

	void npcatk_clear_targets()
	{
		DID_INTRO = 0;
		NEXT_INTRO = GetGameTime();
		NEXT_INTRO += Random(6.0, 12.0);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		string GAME_TIME = GetGameTime();
		if (!(GROUND_MODE))
		{
			SetGravity(-1.0);
			if (GAME_TIME > DELAY_V_PUSH)
			{
			}
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 1));
		}
		else
		{
			SetGravity(1.0);
		}
		if (m_hAttackTarget == "unset")
		{
			if ((DID_TELEPORT))
			{
			}
			if (GAME_TIME > NEXT_TELE_FIX)
			{
				LogDebug("teleport_fix NEXT_TELE_FIX");
				ClientEvent("new", "all", "effects/sfx_sprite_in_fancy", GetEntityOrigin(GetOwner()), "c-tele1.spr", 25, 2.0, Vector3(255, 255, 255), 512, "magic/teleport.wav");
				SetEntityOrigin(GetOwner(), NPC_HOME_LOC);
				TELE_TYPE = "melee";
				NEXT_TELE_FIX = 99999;
				ClientEvent("new", "all", "effects/sfx_sprite_in_fancy", NPC_HOME_LOC, "c-tele1.spr", 25, 2.0, Vector3(255, 255, 255), 512, "magic/teleport.wav");
			}
		}
		if (!(m_hAttackTarget != "unset")) return;
		NEXT_TELE_FIX = GAME_TIME;
		NEXT_TELE_FIX += 20.0;
		if (GAME_TIME > NEXT_TELEPORT)
		{
			if ((IsValidPlayer(m_hAttackTarget)))
			{
			}
			check_teleport();
		}
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		if (TARG_RANGE < RANGE_CHASE)
		{
			if (TARG_RANGE > RANGE_CLOSE)
			{
			}
			ANIM_ATTACK = /* TODO: $stradd */ $stradd(ANIM_PREFIX, BANIM_DOUBLEATK);
			ATTACK_RANGE = RANGE_NORM;
			ATTACK_HITRANGE = HITRANGE_NORM;
			ATTACK_MOVERANGE = MOVERANGE_NORM;
			SetMoveAnim(ANIM_RUN);
		}
		if (TARG_RANGE < RANGE_CLOSE)
		{
			ANIM_ATTACK = /* TODO: $stradd */ $stradd(ANIM_PREFIX, BANIM_CLOSEATK);
			ATTACK_RANGE = RANGE_CLOSE;
			ATTACK_HITRANGE = HITRANGE_CLOSE;
			ATTACK_MOVERANGE = MOVERANGE_NORM;
			if (GAME_TIME > NEXT_BITE)
			{
			}
			ANIM_ATTACK = /* TODO: $stradd */ $stradd(ANIM_PREFIX, BANIM_BITE);
		}
		if (TARG_RANGE > RANGE_CHASE)
		{
			ANIM_ATTACK = /* TODO: $stradd */ $stradd(ANIM_PREFIX, BANIM_PROJ);
			ATTACK_RANGE = RANGE_PROJ;
			ATTACK_HITRANGE = RANGE_PROJ;
			ATTACK_MOVERANGE = MOVERANGE_PROJ;
		}
		if (GAME_TIME > NEXT_SIDESTEP)
		{
			NEXT_SIDESTEP = GAME_TIME;
			string L_FREQ_SIDESTEP = FREQ_SIDESTEP;
			if (TARG_RANGE > RANGE_CHASE)
			{
				L_FREQ_SIDESTEP *= 0.5;
			}
			NEXT_SIDESTEP += L_FREQ_SIDESTEP;
			string SIDESTEP_DIR = RandomInt(1, 2);
			if (SIDESTEP_DIR == 1)
			{
				PlayAnim("critical", /* TODO: $stradd */ $stradd(ANIM_PREFIX, BANIM_DODGEL));
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(-1000, 0, 0));
			}
			if (SIDESTEP_DIR == 2)
			{
				PlayAnim("critical", /* TODO: $stradd */ $stradd(ANIM_PREFIX, BANIM_DODGER));
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(1000, 0, 0));
			}
		}
	}

	void frame_projectile()
	{
		// PlayRandomSound from: SOUND_QUICK1, SOUND_QUICK2
		array<string> sounds = {SOUND_QUICK1, SOUND_QUICK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		TossProjectile("proj_sprite", /* TODO: $relpos */ $relpos(0, 32, V_ADJ), m_hAttackTarget, 300, 0, 0.1, "none");
		Effect("beam", "ents", "lgtning.spr", 10, GetOwner(), 2, GetOwner(), 3, Vector3(255, 0, 255), 200, 90, 1.0);
	}

	void ext_proj_land()
	{
		string TARG_ALIVE = IsEntityAlive(param2);
		if (GetRelationship(param2) == "enemy")
		{
			if ((TARG_ALIVE))
			{
			}
			int HIT_ENEMY = 1;
		}
		string ARROW_POS = param3;
		if ((HIT_ENEMY))
		{
			string ARROW_POS = GetEntityOrigin(param2);
		}
		ARROW_POS = "z";
		ARROW_POS += "z";
		ClientEvent("new", "all", "effects/sfx_light_fade", ARROW_POS, Vector3(255, 0, 255), 190, 1, "debris/beamstart4.wav", 5);
		XDoDamage(ARROW_POS, 128, DMG_PROJ, 0.1, GetOwner(), GetOwner(), "none", "lightning_effect", "dmgevent:proj");
	}

	void proj_dodamage()
	{
		LogDebug("proj_dodamage PARAM1 GetEntityName(param2) PARAM3 PARAM4");
		if (!(param1)) return;
		ApplyEffect(param2, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
	}

	void frame_melee_strike()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, 0.9, "slash");
	}

	void frame_bite()
	{
		// PlayRandomSound from: SOUND_QUICK1, SOUND_QUICK2
		array<string> sounds = {SOUND_QUICK1, SOUND_QUICK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		BITE_ATTACK = 1;
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, 1.0, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bite");
		ANIM_ATTACK = /* TODO: $stradd */ $stradd(ANIM_PREFIX, BANIM_CLOSEATK);
		NEXT_BITE = GetGameTime();
		NEXT_BITE += FREQ_BITE;
	}

	void bite_dodamage()
	{
		if (!(param1)) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 400, 110));
		ApplyEffect(param2, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_POISON);
	}

	void check_teleport()
	{
		string L_CUR_POS = GetEntityOrigin(GetOwner());
		if (TELE_TYPE == "melee")
		{
			if ((false))
			{
				string TELE_POINT = GetEntityOrigin(m_hAttackTarget);
				string RND_ANG = Random(0, 359.99);
				TELE_POINT += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, MOVERANGE_NORM, 0));
				TELE_POINT = "z";
				if (!(GROUND_MODE))
				{
					TELE_POINT += "z";
				}
				LAST_TELE_POINT = GetEntityOrigin(GetOwner());
			}
			else
			{
				NEXT_TELEPORT = GetGameTime();
				NEXT_TELEPORT += 3.0;
				return;
			}
		}
		if (TELE_TYPE == "ranged")
		{
			if (LAST_TELE_POINT != "LAST_TELE_POINT")
			{
				string TELE_POINT = LAST_TELE_POINT;
			}
			else
			{
				string TELE_POINT = NPC_HOME_LOC;
			}
		}
		SetEntityOrigin(GetOwner(), TELE_POINT);
		string L_POS = TELE_POINT;
		string reg.npcmove.endpos = L_POS;
		string L_WIGGLE_RL = Random(-8, 8);
		string L_WIGGLE_FB = Random(-8, 8);
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(L_WIGGLE_RL, L_WIGGLE_FB, 0));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" <= 0)
		{
			int L_TELE_FAIL = 1;
		}
		if ((L_TELE_FAIL))
		{
			LogDebug("teleport failed TELE_TYPE game.ret.npcmove.dist TELE_POINT");
			SetEntityOrigin(GetOwner(), L_CUR_POS);
		}
		else
		{
			string SPR_POINT = TELE_POINT;
			if (TELE_TYPE == "melee")
			{
				SPR_POINT += "z";
			}
			ClientEvent("new", "all", "effects/sfx_sprite_in_fancy", SPR_POINT, "c-tele1.spr", 25, 2.0, Vector3(255, 255, 255), 512, "magic/teleport.wav");
			ClientEvent("new", "all", "effects/sfx_sprite_in_fancy", L_CUR_POS, "c-tele1.spr", 25, 2.0, Vector3(255, 255, 255), 512, "magic/teleport.wav");
			NEXT_TELEPORT = GetGameTime();
			string L_FREQ_TELEPORT = FREQ_TELEPORT;
			if (TELE_TYPE == "melee")
			{
				L_FREQ_TELEPORT *= 0.5;
			}
			NEXT_TELEPORT += L_FREQ_TELEPORT;
			if (!(STAY_ON_GROUND))
			{
				if (TELE_TYPE == "melee")
				{
					if (!(GROUND_MODE))
					{
						PlayAnim("once", "break");
					}
					GROUND_MODE = 1;
					ground_mode();
				}
				else
				{
					if ((GROUND_MODE))
					{
						PlayAnim("once", "break");
					}
					GROUND_MODE = 0;
					ceiling_mode();
				}
			}
			if (!(L_TELE_FAIL))
			{
				DID_TELEPORT = 1;
				if (TELE_TYPE == "melee")
				{
					TELE_TYPE = "ranged";
				}
				else
				{
					TELE_TYPE = "melee";
				}
			}
		}
	}

}

}
