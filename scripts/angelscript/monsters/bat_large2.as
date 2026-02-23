#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_flyer_grav.as"
#include "monsters/base_propelled.as"

namespace MS
{

class BatLarge2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int DID_ALERT;
	int IS_ACTIVE;
	string MONSTER_WIDTH;
	string NEXT_HORROR_BOOST;
	string NEXT_RETREAT;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string NPC_MODEL_SCALED;
	string NPC_ORG_HEIGHT;
	string NPC_ORG_WIDTH;
	int NPC_USES_HANDLE_EVENTS;

	BatLarge2()
	{
		const int BFLY_NO_FAKE_DEATH = 1;
		const int AS_CUSTOM_UNSTUCK = 1;
		NPC_HACKED_MOVE_SPEED = 100;
		ANIM_IDLE = "IdleFlyNormal";
		ANIM_WALK = "IdleFlyFace";
		ANIM_RUN = "IdleFlyNormal";
		ANIM_ATTACK = "Bite";
		ANIM_DEATH = "Deadground";
		const string ANIM_DEAD_GROUND = "Deadground";
		const string ANIM_HOVER = "IdleFlyFace";
		const string ANIM_IDLE_HANG = "IdleHang";
		ATTACK_MOVERANGE = 15;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 150;
		NPC_GIVE_EXP = 150;
		const int DMG_BITE = 100;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN = "monsters/bat/c_bat_hit1.wav";
		const string SOUND_IDLE = "monsters/bat/c_bat_hit2.wav";
		const string SOUND_DEATH = "monsters/bat/c_bat_yes.wav";
		const string SOUND_BOOST1 = "monsters/bat/c_bat_bat1.wav";
		const string SOUND_BOOST2 = "monsters/bat/c_bat_bat2.wav";
		const string SOUND_ATTACK1 = "monsters/bat/c_bat_atk1.wav";
		const string SOUND_ATTACK2 = "monsters/bat/c_bat_atk2.wav";
		const string SOUND_ATTACK3 = "monsters/bat/c_bat_atk3.wav";
		const string SOUND_ALERT = "monsters/bat/death.wav";
		const int HORROR_BOOST_SPEED = 300;
	}

	void OnSpawn() override
	{
		SetName("Huge Bat");
		SetModel("monsters/bat_large.mdl");
		SetHealth(500);
		SetRace("vermin");
		SetWidth(24);
		SetHeight(24);
		SetGravity(0);
		SetHearingSensitivity(3.5);
		SetIdleAnim(ANIM_IDLE_HANG);
		SetMoveAnim(ANIM_RUN);
		PlayAnim("once", ANIM_IDLE_HANG);
		IS_ACTIVE = 0;
		npcatk_suspend_ai();
		ScheduleDelayedEvent(2.0, "final_props");
		if (StringToLower(GetMapName()) == "nightmare_edana")
		{
			SetMonsterClip(0);
		}
		re_scale(2.0, 1, 0);
		SetAnimFrameRate(0.75);
	}

	void re_scale()
	{
		LogDebug("ext_scale PARAM1 PARAM2 PARAM3");
		if (!(param1 > 0)) return;
		string MY_WIDTH = GetEntityWidth(GetOwner());
		string MY_HEIGHT = GetEntityHeight(GetOwner());
		if (NPC_ORG_WIDTH == "NPC_ORG_WIDTH")
		{
			NPC_ORG_WIDTH = MY_WIDTH;
			NPC_ORG_HEIGHT = MY_HEIGHT;
		}
		else
		{
			string MY_WIDTH = NPC_ORG_WIDTH;
			string MY_HEIGHT = NPC_ORG_HEIGHT;
		}
		SetProp(GetOwner(), "scale", param1);
		MY_WIDTH *= param1;
		MY_HEIGHT *= param1;
		if (MY_WIDTH < 16)
		{
			int MY_WIDTH = 16;
		}
		if (MY_HEIGHT < 16)
		{
			int MY_HEIGHT = 16;
		}
		SetWidth(MY_WIDTH);
		SetHeight(MY_WIDTH);
		MONSTER_WIDTH = MY_WIDTH;
		NPC_MODEL_SCALED = param1;
		NPC_USES_HANDLE_EVENTS = 1;
		string L_HALF_W = MY_WIDTH;
		L_HALF_W *= 0.5;
		if (param2 != 1)
		{
			SetBBox(Vector3(/* TODO: $neg */ $neg(L_HALF_W), /* TODO: $neg */ $neg(L_HALF_W), 0), Vector3(L_HALF_W, L_HALF_W, MY_HEIGHT));
		}
		if (param1 > 1)
		{
			if (BASE_MOVESPEED == "BASE_MOVESPEED")
			{
				BASE_MOVESPEED = param1;
				NPC_ORG_BASE_MOVESPEED = BASE_MOVESPEED;
			}
			else
			{
				if (NPC_ORG_BASE_MOVESPEED == "NPC_ORG_BASE_MOVESPEED")
				{
					BASE_MOVESPEED = NPC_ORG_BASE_MOVESPEED;
				}
				else
				{
					NPC_ORG_BASE_MOVESPEED = BASE_MOVESPEED;
				}
				BASE_MOVESPEED += param1;
			}
			SetAnimMoveSpeed(BASE_MOVESPEED);
			SetMoveSpeed(BASE_MOVESPEED);
		}
		NPC_MODEL_SCALED = param1;
		if (!(param3 != 1)) return;
		if (!(NPC_RANGED))
		{
			LogDebug("ext_scale adjusting ranges");
			ScheduleDelayedEvent(1.9, "ext_adjust_scale_range");
		}
		else
		{
			LogDebug("ext_scale not changing reach , mob is ranged");
		}
	}

	void set_spawn_active()
	{
		ScheduleDelayedEvent(0.1, "active_mode");
	}

	void active_mode()
	{
		PlayAnim("critical", ANIM_WALK);
		SetIdleAnim(ANIM_WALK);
		SetMoveAnim(ANIM_RUN);
		IS_ACTIVE = 1;
		npcatk_resume_ai();
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((IS_ACTIVE)) return;
		string HEARD_ID = GetEntityIndex("ent_lastheard");
		if (!(GetRelationship(HEARD_ID) == "enemy")) return;
		active_mode();
	}

	void OnDamage(int damage) override
	{
		if (!(IS_ACTIVE))
		{
			active_mode();
		}
		if (!(GetGameTime() > NEXT_RETREAT)) return;
		NEXT_RETREAT = GetGameTime();
		NEXT_RETREAT += Random(10.0, 20.0);
		string RND_LR = Random(-300.0, 300.0);
		string RND_FB = Random(-1500.0, 500.0);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_LR, RND_FB, 0));
	}

	void bite1()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, 0.9, "pierce");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npc_targetsighted()
	{
		if (GetGameTime() > NEXT_HORROR_BOOST)
		{
			NEXT_HORROR_BOOST = GetGameTime();
			NEXT_HORROR_BOOST += Random(3.0, 5.0);
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, HORROR_BOOST_SPEED, 0));
			// PlayRandomSound from: SOUND_BOOST1, SOUND_BOOST2
			array<string> sounds = {SOUND_BOOST1, SOUND_BOOST2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(-50, 0, 0));
		}
		if ((DID_ALERT)) return;
		DID_ALERT = 1;
		// svplaysound: svplaysound 0 10 SOUND_ALERT
		EmitSound(0, 10, SOUND_ALERT);
	}

	void my_target_died()
	{
		DID_ALERT = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		ClientEvent("new", "all", "monsters/bat_large_corpse_cl", GetEntityOrigin(GetOwner()), 0, 2.0);
	}

	void OnSuspendAI()
	{
		LogDebug("npcatk_suspend_ai PARAM1 PARAM2");
	}

	void as_npcatk_suspend_ai()
	{
		LogDebug("as_npcatk_suspend_ai PARAM1 PARAM2");
	}

	void npc_stuck()
	{
		LogDebug("npc_stuck");
		chicken_run(1.0);
	}

}

}
