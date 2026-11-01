#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorBow : CGameScript
{
	int AM_ARCHER;
	string AOE_ARROW;
	string ARROW_AOE;
	string ARROW_CL_SCRIPT;
	string ARROW_CL_SCRIPT_COLD;
	string ARROW_CL_SCRIPT_FIRE;
	string ARROW_DMG_AOE;
	string ARROW_DMG_TYPE;
	string ARROW_DOT_DMG;
	string ARROW_DOT_DUR;
	string ARROW_EFFECT;
	string ARROW_KNOCKBACK;
	string ARROW_TARGET_LIST;
	string ATTACK_STANCE;
	int CAN_KICK;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	float FREQ_KICK;
	int LEAP_AFTER_KICK;
	int MISS_COUNT;
	int NPC_GIVE_EXP;
	int NPC_RANGED;
	string PROJ_TYPE;
	string SOUND_BOW_SHOOT;
	string SOUND_BOW_STRETCH;
	string SPIRAL_DMG;
	string SPIRAL_DMG_TYPE;
	string SPIRAL_GLOW_COLOR;
	string SPIRAL_ON;
	string SPIRAL_SPIRTE_FILE;
	string SPIRAL_SPRITE_COLOR;
	string SPIRAL_SPRITE_FRAMES;
	string SPIRAL_SPRITE_SCALE;

	TelfWarriorBow()
	{
		Precache("char_breath.spr");
		NPC_GIVE_EXP = 2500;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		NPC_RANGED = 1;
		AM_ARCHER = 1;
		ATTACK_STANCE = "bow";
		CAN_KICK = 1;
		FREQ_KICK = 8.0;
		LEAP_AFTER_KICK = 1;
		SOUND_BOW_STRETCH = "monsters/archer/stretch.wav";
		SOUND_BOW_SHOOT = "monsters/archer/bow.wav";
		ARROW_CL_SCRIPT_FIRE = "effects/sfx_fire_burst";
		ARROW_CL_SCRIPT_COLD = "effects/sfx_ice_burst";
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
		int RND_PROJECTILE = RandomInt(3, 5);
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
			SPIRAL_DMG = 100;
			SPIRAL_SPIRTE_FILE = "3dmflaora.spr";
			SPIRAL_SPRITE_FRAMES = 19;
			SPIRAL_SPRITE_SCALE = 1.0;
			SPIRAL_SPRITE_COLOR = Vector3(255, 0, 0);
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
			SPIRAL_DMG = 100;
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
			SPIRAL_DMG = 100;
			SPIRAL_SPIRTE_FILE = "3dmflaora.spr";
			SPIRAL_SPRITE_FRAMES = 8;
			SPIRAL_SPRITE_SCALE = 0.5;
			SPIRAL_SPRITE_COLOR = Vector3(255, 255, 0);
			SPIRAL_GLOW_COLOR = Vector3(255, 255, 0);
			SPIRAL_ON = 1;
			int SPIRAL_ARROW = 1;
		}
		if (!(AOE_ARROW))
		{
			TossProjectile(ARROW_SCRIPT, /* TODO: $relpos */ $relpos(10, 0, 28), m_hAttackTarget, ARROW_SPEED, DMG_ARROW, 0, "none");
			CallExternal("ent_lastprojectile", "ext_lighten", 0, ARROW_GLOW, ARROW_GLOW_COLOR);
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
			float TARG_DIST = Distance(TARG_ORG, GetMonsterProperty("origin"));
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
		if ((SPIRAL_ON))
		{
			if ((param1))
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 200, 110));
		}
	}

	void ext_spiral_done()
	{
		SPIRAL_ON = 0;
	}

}

}
