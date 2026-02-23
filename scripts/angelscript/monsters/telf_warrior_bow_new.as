#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorBowNew : CGameScript
{
	string ANIM_ATTACK;
	string AOE_ARROW;
	string ARROW_AOE;
	string ARROW_CL_SCRIPT;
	string ARROW_DMG_AOE;
	string ARROW_DMG_TYPE;
	string ARROW_DOT_DMG;
	string ARROW_DOT_DUR;
	string ARROW_EFFECT;
	string ARROW_KNOCKBACK;
	string ARROW_TARGET_LIST;
	string AS_ATTACKING;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string FIRE_DELAY;
	string MAXRANGE_RATIO;
	int MISS_COUNT;
	string NEXT_FIRE;
	int NPC_GIVE_EXP;
	int NPC_RANGED;
	string PROJ_TYPE;
	string SPIRAL_DMG;
	string SPIRAL_DMG_TYPE;
	string SPIRAL_GLOW_COLOR;
	string SPIRAL_ON;
	string SPIRAL_SPIRTE_FILE;
	string SPIRAL_SPRITE_COLOR;
	string SPIRAL_SPRITE_FRAMES;
	string SPIRAL_SPRITE_SCALE;
	string TRACK_ARROW_ACTIVE;
	string TRACK_SPIRAL_ANG;
	string TRACK_SPIRAL_DEST;
	string TRACK_SPIRAL_ORG;

	TelfWarriorBowNew()
	{
		LogDebug("share_test - Shared");
		Precache("xfireball3.spr");
		Precache("char_breath.spr");
		Precache("firemagic.spr");
		LogDebug("share_test - Server");
		const int ARROW_CL_SPEED = 200;
		const float ARROW_SV_SPEED = 42.5;
		NPC_GIVE_EXP = 2500;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		NPC_RANGED = 1;
		const int AM_ARCHER = 1;
		const string ATTACK_STANCE = "bow";
		const int CAN_KICK = 1;
		const float FREQ_KICK = 8.0;
		const int LEAP_AFTER_KICK = 1;
		const string SOUND_BOW_STRETCH = "monsters/archer/stretch.wav";
		const string SOUND_BOW_SHOOT = "monsters/archer/bow.wav";
		const string ARROW_CL_SCRIPT_FIRE = "effects/sfx_fire_burst";
		const string ARROW_CL_SCRIPT_COLD = "effects/sfx_ice_burst";
	}

	void game_precache()
	{
		Precache(ARROW_CL_SCRIPT_FIRE);
		Precache(ARROW_CL_SCRIPT_COLD);
	}

	void elf_spawn()
	{
		SetName("Torkalath Shadowarcher");
		SetHealth(3500);
		SetDamageResistance("all", 0.5);
		SetRace("torkie");
		SetModelBody(1, 5);
		MISS_COUNT = 0;
	}

	void frame_stretch_bow()
	{
		EmitSound(GetOwner(), 0, SOUND_BOW_STRETCH, 10);
	}

	void frame_shoot_bow()
	{
		EmitSound(GetOwner(), 0, SOUND_BOW_SHOOT, 10);
		MISS_COUNT += 1;
		int N_PROJECTILES = 3;
		string RND_PROJECTILE = RandomInt(3, 5);
		if (RND_PROJECTILE == 1)
		{
			PROJ_TYPE = "fire_aoe";
			int ARROW_SPEED = 500;
			string ARROW_SCRIPT = "proj_arrow_npc_dyn";
			int ARROW_GLOW = 1;
			Vector3 ARROW_GLOW_COLOR = Vector3(255, 0, 0);
			AOE_ARROW = 1;
			ARROW_KNOCKBACK = 800;
			ARROW_AOE = 128;
			ARROW_EFFECT = "effects/dot_fire";
			ARROW_DOT_DMG = 150;
			ARROW_DOT_DUR = 5.0;
			ARROW_CL_SCRIPT = ARROW_CL_SCRIPT_FIRE;
			ARROW_DMG_AOE = 200;
			ARROW_DMG_TYPE = "fire_effect";
		}
		if (RND_PROJECTILE == 2)
		{
			PROJ_TYPE = "ice_aoe";
			int ARROW_SPEED = 500;
			string ARROW_SCRIPT = "proj_arrow_npc_dyn";
			int ARROW_GLOW = 1;
			Vector3 ARROW_GLOW_COLOR = Vector3(128, 128, 255);
			AOE_ARROW = 1;
			ARROW_KNOCKBACK = 800;
			ARROW_AOE = 128;
			ARROW_EFFECT = "effects/dot_cold";
			ARROW_DOT_DMG = 50;
			ARROW_DOT_DUR = 5.0;
			ARROW_CL_SCRIPT = ARROW_CL_SCRIPT_COLD;
			ARROW_DMG_AOE = 150;
			ARROW_DMG_TYPE = "cold_effect";
		}
		if (RND_PROJECTILE == 3)
		{
			PROJ_TYPE = "spiral_fire";
			string ARROW_SCRIPT = "proj_arrow_spiral";
			int ARROW_SPEED = 200;
			AOE_ARROW = 0;
			ARROW_KNOCKBACK = 0;
			SPIRAL_DMG_TYPE = "fire_effect";
			SPIRAL_DMG = 150;
			SPIRAL_SPIRTE_FILE = "xfireball3.spr";
			SPIRAL_SPRITE_FRAMES = 19;
			SPIRAL_SPRITE_SCALE = 1.0;
			SPIRAL_SPRITE_COLOR = Vector3(255, 255, 255);
			SPIRAL_GLOW_COLOR = Vector3(255, 0, 0);
			SPIRAL_ON = 1;
			int SPIRAL_ARROW = 1;
		}
		if (RND_PROJECTILE == 4)
		{
			PROJ_TYPE = "spiral_cold";
			string ARROW_SCRIPT = "proj_arrow_spiral";
			int ARROW_SPEED = 200;
			AOE_ARROW = 0;
			ARROW_KNOCKBACK = 0;
			SPIRAL_DMG_TYPE = "cold_effect";
			SPIRAL_DMG = 150;
			SPIRAL_SPIRTE_FILE = "char_breath.spr";
			SPIRAL_SPRITE_FRAMES = 1;
			SPIRAL_SPRITE_SCALE = 2.5;
			SPIRAL_SPRITE_COLOR = Vector3(255, 255, 255);
			SPIRAL_GLOW_COLOR = Vector3(128, 128, 255);
			SPIRAL_ON = 1;
			int SPIRAL_ARROW = 1;
		}
		if (RND_PROJECTILE == 5)
		{
			PROJ_TYPE = "spiral_lightning";
			string ARROW_SCRIPT = "proj_arrow_spiral";
			int ARROW_SPEED = 200;
			AOE_ARROW = 0;
			ARROW_KNOCKBACK = 0;
			SPIRAL_DMG_TYPE = "lightning_effect";
			SPIRAL_DMG = 150;
			SPIRAL_SPIRTE_FILE = "firemagic.spr";
			SPIRAL_SPRITE_FRAMES = 8;
			SPIRAL_SPRITE_SCALE = 0.5;
			SPIRAL_SPRITE_COLOR = Vector3(255, 255, 255);
			SPIRAL_GLOW_COLOR = Vector3(255, 255, 0);
			SPIRAL_ON = 1;
			int SPIRAL_ARROW = 1;
		}
		if (!(AOE_ARROW))
		{
			string TRACE_START = GetEntityOrigin(GetOwner());
			TRACE_START += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 0, 64));
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			string TRACE_END = TARG_ORG;
			string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(TRACE_START, TRACE_END);
			ANG_TO_TARG = "x";
			TRACE_END += /* TODO: $relpos */ $relpos(ANG_TO_TARG, Vector3(0, 4096, 0));
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
			TRACK_SPIRAL_ANG = ANG_TO_TARG;
			TRACK_SPIRAL_ORG = TRACE_START;
			TRACK_SPIRAL_DEST = TRACE_LINE;
			ClientEvent("new", "all", "monsters/telf_warrior_bow_cl", TRACK_SPIRAL_ORG, SPIRAL_SPIRTE_FILE, SPIRAL_SPRITE_FRAMES, SPIRAL_SPRITE_SCALE, SPIRAL_SPRITE_COLOR, SPIRAL_GLOW_COLOR, ANG_TO_TARG, ARROW_CL_SPEED);
			MAXRANGE_RATIO = GetEntityRange(m_hAttackTarget);
			MAXRANGE_RATIO /= ATTACK_RANGE;
			FIRE_DELAY = /* TODO: $get_skill_ratio */ $get_skill_ratio(MAXRANGE_RATIO, 0.25, 3.25);
			LogDebug("fire_delay: FIRE_DELAY");
			NEXT_FIRE = GetGameTime();
			NEXT_FIRE += FIRE_DELAY;
			if (!(TRACK_ARROW_ACTIVE))
			{
			}
			TRACK_ARROW_ACTIVE = 1;
			ScheduleDelayedEvent(0.1, "track_spiral_arrow");
		}
		else
		{
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			string HALF_AOE = ARROW_AOE;
			HALF_AOE /= 2;
			TARG_ORG += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359.99), 0), Vector3(0, HALF_AOE, 0));
			if (!(IsValidPlayer(TARG_ORG)))
			{
				TARG_ORG += "z";
			}
			string TARG_DIST = Distance(TARG_ORG, GetMonsterProperty("origin"));
			TARG_DIST /= 25;
			SetAngles("add_view.pitch");
			TossProjectile(ARROW_SCRIPT, /* TODO: $relpos */ $relpos(10, 0, 28), "none", ARROW_SPEED, DMG_ARROW, 1, "none");
			float GRAV_ADJ = 0.4;
			if ((TARG_ORG).z < GetMonsterProperty("origin.z"))
			{
				string ADJ_RATIO = (TARG_ORG).z;
				ADJ_RATIO /= GetMonsterProperty("origin.z");
				string GRAV_ADJ = /* TODO: $get_skill_ratio */ $get_skill_ratio(ADJ_RATIO, 0.4, 2.0);
				LogDebug("adjusting down GRAV_ADJ ADJ_RATIO");
			}
			CallExternal("ent_lastprojectile", "ext_lighten", GRAV_ADJ, ARROW_GLOW, ARROW_GLOW_COLOR);
		}
		if (MISS_COUNT > 4)
		{
			MISS_COUNT = 2;
			PlayAnim("once", "break");
			chicken_run(1.5);
		}
	}

	void ext_arrow_hit()
	{
		string TARG_ALIVE = IsEntityAlive(param2);
		if (GetRelationship(param2) == "enemy")
		{
			if ((TARG_ALIVE))
			{
			}
			int HIT_ENEMY = 1;
		}
		if (ARROW_EFFECT != "ARROW_EFFECT")
		{
			if ((HIT_ENEMY))
			{
			}
			ApplyEffect(param2, ARROW_EFFECT, ARROW_DOT_DUR, GetEntityIndex(GetOwner()), ARROW_DOT_DMG);
		}
		if ((AOE_ARROW))
		{
			string ARROW_POS = param3;
			if ((HIT_ENEMY))
			{
				string ARROW_POS = GetEntityOrigin(param2);
			}
			ARROW_POS = "z";
			ClientEvent("new", "all", ARROW_CL_SCRIPT, ARROW_POS, 128, 1, Vector3(255, 0, 0));
			XDoDamage(ARROW_POS, ARROW_AOE, ARROW_DMG_AOE, 0, GetOwner(), GetOwner(), "none", ARROW_DMG_TYPE);
			ARROW_TARGET_LIST = FindEntitiesInSphere("enemy", ARROW_AOE);
			if (ARROW_TARGET_LIST != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(ARROW_TARGET_LIST, ";"); i++)
			{
				arrow_affect_targets();
			}
		}
	}

	void arrow_affect_targets()
	{
		string CUR_TARG = GetToken(ARROW_TARGET_LIST, i, ";");
		ApplyEffect(CUR_TARG, ARROW_EFFECT, ARROW_DOT_DUR, GetEntityIndex(GetOwner()), ARROW_DOT_DMG);
		MISS_COUNT = 0;
	}

	void game_dodamage()
	{
		if ((IsEntityAlive(param2)))
		{
			if (GetRelationship(param2) == "enemy")
			{
			}
			MISS_COUNT = 0;
		}
	}

	void spiral_done()
	{
		TRACK_ARROW_ACTIVE = 0;
		SPIRAL_ON = 0;
	}

	void track_spiral_arrow()
	{
		if (!(TRACK_ARROW_ACTIVE)) return;
		ScheduleDelayedEvent(0.2, "track_spiral_arrow");
		TRACK_SPIRAL_ORG += /* TODO: $relpos */ $relpos(TRACK_SPIRAL_ANG, Vector3(0, ARROW_SV_SPEED, 0));
		XDoDamage(TRACK_SPIRAL_ORG, 128, SPIRAL_DMG, 0, GetOwner(), GetOwner(), "none", SPIRAL_DMG_TYPE);
		if ((G_DEVELOPER_MODE))
		{
			string BEAM_START = TRACK_SPIRAL_ORG;
			string BEAM_END = BEAM_START;
			BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 32));
			Effect("beam", "point", "lgtning.spr", 100, BEAM_START, BEAM_END, Vector3(255, 0, 255), 200, 0, 0.2);
		}
	}

	void npc_selectattack()
	{
		if (GetGameTime() < NEXT_FIRE)
		{
			int HOLD_ATTACK = 1;
		}
		if ((HOLD_ATTACK))
		{
			ANIM_ATTACK = ANIM_IDLE;
			AS_ATTACKING = GetGameTime();
		}
		else
		{
			ANIM_ATTACK = "shootbow";
		}
	}

}

}
