#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class DoomPlantNew : CGameScript
{
	int AM_GROWING;
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string ATTACK_HITRANGE;
	string ATTACK_RANGE;
	string HALF_HP;
	string LEVEL_PREFIX;
	string NEXT_CL_REFRESH;
	string NEXT_GROW;
	string NEXT_IDLE;
	string NEXT_SHOOT;
	string NEXT_SPORE;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	int SLASH_ATTACK;
	string SPORE_POISON_DMG;
	string TREE_CL_INDEX;
	int TREE_LEVEL;

	DoomPlantNew()
	{
		NPC_GIVE_EXP = 200;
		NO_STUCK_CHECKS = 1;
		const float DMG_SPUR = 5.0;
		const float DMG_SLASH = 8.0;
		const float DMG_SPORE = 50.0;
		const int DOT_POISON = 30;
		const float FREQ_GROW = 40.0;
		const float FREQ_SHOOT = 0.5;
		const float FREQ_SPORE = 15.0;
		const float FREQ_CL_REFRESH = 20.0;
		const string FREQ_IDLE = Random(3.0, 6.0);
		const string GIB_MODEL = "cactusgibs.mdl";
		const string SOUND_GIB = "debris/bustflesh1.wav";
		const string SOUND_SLASH = "zombie/claw_miss1.wav";
		const string SOUND_SCRATCH = "headcrab/hc_attack1.wav";
		const string SOUND_SPORE = "weapons/bow/crossbow.wav";
		const string SOUND_GROW = "weapons/bow/stretch.wav";
		const string SOUND_STRUCK1 = "weapons/xbow_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/xbow_hitbod2.wav";
		Precache(GIB_MODEL);
	}

	void OnSpawn() override
	{
		SetName("Doom Tree");
		SetModel("monsters/dewm_tree_combo.mdl");
		SetRace("demon");
		SetBloodType("green");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("fire", 1.5);
		SetHealth(100);
		SetNoPush(true);
		SetHearingSensitivity(4);
		SetWidth(48);
		SetHeight(96);
		TREE_LEVEL = 1;
		AM_GROWING = 1;
		ScheduleDelayedEvent(0.1, "setup_tree_level");
		ScheduleDelayedEvent(2.0, "set_final_params");
	}

	void set_final_params()
	{
	}

	void do_grow()
	{
		if (!(TREE_LEVEL < 3)) return;
		TREE_LEVEL += 1;
		AM_GROWING = 1;
		setup_tree_level();
	}

	void setup_tree_level()
	{
		NEXT_GROW = GetGameTime();
		NEXT_GROW += FREQ_GROW;
		TREE_LEVEL = int(TREE_LEVEL);
		LEVEL_PREFIX = /* TODO: $stradd */ $stradd("level", TREE_LEVEL, _);
		string TREE_LEVEL_M1 = TREE_LEVEL;
		TREE_LEVEL_M1 -= 1;
		SetModelBody(0, TREE_LEVEL_M1);
		npcatk_suspend_ai(1.0);
		if ((AM_GROWING))
		{
			PlayAnim("critical", /* TODO: $stradd */ $stradd(LEVEL_PREFIX, "grow"));
		}
		AM_GROWING = 0;
		ANIM_ATTACK = /* TODO: $stradd */ $stradd(LEVEL_PREFIX, "attack");
		ANIM_IDLE = /* TODO: $stradd */ $stradd(LEVEL_PREFIX, "idle1");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		ANIM_WALK = ANIM_IDLE;
		ANIM_RUN = ANIM_IDLE;
		int FINAL_HP = 100;
		if (TREE_LEVEL == 1)
		{
			FINAL_HP *= 1.0;
		}
		if (TREE_LEVEL == 2)
		{
			FINAL_HP *= 5.0;
		}
		if (TREE_LEVEL == 3)
		{
			FINAL_HP *= 10.0;
		}
		if (TREE_LEVEL < 3)
		{
			ATTACK_RANGE = 72;
		}
		if (TREE_LEVEL == 3)
		{
			ATTACK_RANGE = 128;
		}
		ATTACK_HITRANGE = ATTACK_RANGE;
		if (StringToLower(GetMapName()) == "underpath")
		{
			ATTACK_RANGE = 2048;
			ATTACK_HITRANGE = 2048;
		}
		if (NPC_SET_RANGE != "NPC_SET_RANGE")
		{
			ATTACK_RANGE = NPC_SET_RANGE;
			ATTACK_HITRANGE = NPC_SET_RANGE;
		}
		FINAL_HP *= NPC_HP_MULTI;
		SetHealth(FINAL_HP);
		HALF_HP = FINAL_HP;
		HALF_HP *= 0.5;
	}

	void grow_done()
	{
		npcatk_resume_ai();
	}

	void OnDamage(int damage) override
	{
		if (!(TREE_LEVEL > 1)) return;
		if (!(GetEntityHealth(GetOwner()) < HALF_HP)) return;
		SetDamage("dmg");
		SetDamage("hit");
		return;
		do_shrink();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		EmitSound(GetOwner(), 0, SOUND_GIB, 10);
		Effect("tempent", "gibs", GIB_MODEL, /* TODO: $relpos */ $relpos(0, 0, 0), 1.0, 100, 30, 20, 4.0);
		if ((TREE_SUMMONED))
		{
			if ((IsEntityAlive(MY_OWNER)))
			{
			}
			CallExternal(MY_OWNER, "plant_died");
		}
	}

	void start_level2()
	{
		TREE_LEVEL = 2;
		NPC_GIVE_EXP *= 2;
		setup_tree_level();
	}

	void start_level3()
	{
		TREE_LEVEL = 3;
		NPC_GIVE_EXP *= 3;
		setup_tree_level();
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetGameTime() > NEXT_CL_REFRESH)
		{
			NEXT_CL_REFRESH = GetGameTime();
			NEXT_CL_REFRESH += FREQ_CL_REFRESH;
			if (TREE_CL_INDEX != "TREE_CL_INDEX")
			{
				ClientEvent("update", "all", TREE_CL_INDEX, "remove_fx");
			}
			ClientEvent("new", "all", "monsters/doom_plant_cl", FREQ_CL_REFRESH);
			TREE_CL_INDEX = "game.script.last_sent_id";
		}
		if (GetGameTime() > NEXT_GROW)
		{
			NEXT_GROW = GetGameTime();
			NEXT_GROW += FREQ_GROW;
			do_grow();
		}
		if ((SUSPEND_AI)) return;
		if (m_hAttackTarget != "unset")
		{
			if ((false))
			{
			}
			if (TREE_LEVEL >= 2)
			{
				EmitSound(GetOwner(), 0, SOUND_SLASH, 10);
				PlayAnim("once", ANIM_ATTACK);
			}
		}
		if (TREE_LEVEL == 1)
		{
			if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
			{
			}
			int DO_IDLE = 1;
		}
		if (!(false))
		{
			int DO_IDLE = 1;
		}
		if (!(DO_IDLE)) return;
		if (!(GetGameTime() > NEXT_IDLE)) return;
		NEXT_IDLE = GetGameTime();
		NEXT_IDLE += FREQ_IDLE;
		string RND_ANIM = RandomInt(1, 5);
		PlayAnim("once", /* TODO: $stradd */ $stradd(LEVEL_PREFIX, "idle", RND_ANIM));
	}

	void spur_damage()
	{
		string L_DMG_SPUR = DMG_SPUR;
		L_DMG_SPUR *= TREE_LEVEL;
		DoDamage(m_hAttackTarget, "direct", L_DMG_SPUR, 1.0, GetOwner());
	}

	void attack_slash()
	{
		EmitSound(GetOwner(), 0, SOUND_SLASH, 10);
		string L_DMG_SLASH = DMG_SLASH;
		L_DMG_SLASH *= TREE_LEVEL;
		SLASH_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_RANGE, L_DMG_SLASH, 1.0, GetOwner());
		if (!(TREE_LEVEL > 1)) return;
		if (!(GetGameTime() > NEXT_SHOOT)) return;
		NEXT_SHOOT = GetGameTime();
		NEXT_SHOOT += FREQ_SHOOT;
		string TRACE_START = GetEntityOrigin(GetOwner());
		string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		TRACE_START += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 32, 32));
		if (TREE_LEVEL == 3)
		{
			TRACE_START += "z";
		}
		string TRACE_END = GetEntityOrigin(m_hAttackTarget);
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		ClientEvent("update", "all", TREE_CL_INDEX, "shoot_spur", TRACE_START, GetEntityProperty(GetOwner(), "angles.yaw"));
		ScheduleDelayedEvent(0.1, "spur_damage");
		if (!(TREE_LEVEL == 3)) return;
		if (!(GetGameTime() > NEXT_SPORE)) return;
		NEXT_SPORE = GetGameTime();
		NEXT_SPORE += FREQ_SPORE;
		EmitSound(GetOwner(), 0, SOUND_SPORE, 10);
		SPORE_POISON_DMG = DOT_POISON;
		TossProjectile("proj_spore", /* TODO: $relpos */ $relpos(0, 32, 16), m_hAttackTarget, 500, DMG_SPORE, 0.1, "none");
	}

	void game_dodamage()
	{
		if ((SLASH_ATTACK))
		{
			EmitSound(GetOwner(), 0, SOUND_SCRATCH, 10);
		}
		SLASH_ATTACK = 0;
	}

	void do_shrink()
	{
		NEXT_GROW = GetGameTime();
		NEXT_GROW += FREQ_GROW;
		PlayAnim("critical", /* TODO: $stradd */ $stradd(LEVEL_PREFIX, "shrink"));
		TREE_LEVEL -= 1;
		npcatk_suspend_ai(0.75);
	}

	void shrink_done()
	{
		AM_GROWING = 0;
		npcatk_resume_ai();
		setup_tree_level();
	}

}

}
