#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_flyer_grav.as"
#include "monsters/base_propelled.as"

namespace MS
{

class BatLargeVampire : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEAD_GROUND;
	string ANIM_DEATH;
	string ANIM_HOVER;
	string ANIM_IDLE;
	string ANIM_IDLE_HANG;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_CUSTOM_UNSTUCK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BFLY_NO_FAKE_DEATH;
	int DID_ALERT;
	int DMG_BITE;
	float DOT_POISON;
	int IS_ACTIVE;
	string NEXT_HORROR_BOOST;
	string NEXT_RETREAT;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string OLD_TARGET;
	string REGEN_RATE;
	string SOUND_ALERT;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_BOOST1;
	string SOUND_BOOST2;
	string SOUND_DEATH;
	string SOUND_HEARTBEAT;
	string SOUND_IDLE;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string TRACK_HIT;

	BatLargeVampire()
	{
		BFLY_NO_FAKE_DEATH = 1;
		AS_CUSTOM_UNSTUCK = 1;
		NPC_HACKED_MOVE_SPEED = 500;
		ANIM_IDLE = "IdleFlyNormal";
		ANIM_WALK = "IdleFlyFace";
		ANIM_RUN = "IdleFlyNormal";
		ANIM_ATTACK = "Bite";
		ANIM_DEATH = "Deadground";
		ANIM_DEAD_GROUND = "Deadground";
		ANIM_HOVER = "IdleFlyFace";
		ANIM_IDLE_HANG = "IdleHang";
		ATTACK_MOVERANGE = 15;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 100;
		NPC_GIVE_EXP = 150;
		DMG_BITE = 50;
		DOT_POISON = 10.0;
		SOUND_HEARTBEAT = "player/heartbeat_noloop.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN = "monsters/bat/c_bat_hit1.wav";
		SOUND_IDLE = "monsters/bat/c_bat_hit2.wav";
		SOUND_DEATH = "monsters/bat/c_bat_yes.wav";
		SOUND_BOOST1 = "monsters/bat/c_bat_bat1.wav";
		SOUND_BOOST2 = "monsters/bat/c_bat_bat2.wav";
		SOUND_ATTACK1 = "monsters/bat/c_bat_atk1.wav";
		SOUND_ATTACK2 = "monsters/bat/c_bat_atk2.wav";
		SOUND_ATTACK3 = "monsters/bat/c_bat_atk3.wav";
		SOUND_ALERT = "monsters/bat/death.wav";
	}

	void OnSpawn() override
	{
		SetName("Vampire Bat");
		SetModel("monsters/bat_large.mdl");
		SetHealth(200);
		SetRace("vermin");
		SetWidth(32);
		SetHeight(32);
		SetGravity(0);
		SetHearingSensitivity(3.5);
		SetIdleAnim(ANIM_IDLE_HANG);
		SetMoveAnim(ANIM_RUN);
		PlayAnim("once", ANIM_IDLE_HANG);
		IS_ACTIVE = 0;
		npcatk_suspend_ai();
		ScheduleDelayedEvent(2.0, "final_props");
		SetProp(GetOwner(), "skin", 1);
		if (StringToLower(GetMapName()) == "nightmare_edana")
		{
			SetMonsterClip(0);
		}
	}

	void final_props()
	{
		REGEN_RATE = GetEntityMaxHealth(GetOwner());
		REGEN_RATE *= 0.1;
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
		NEXT_RETREAT += Random(3.0, 5.0);
		float RND_LR = Random(-300.0, 300.0);
		float RND_FB = Random(-1500.0, 500.0);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_LR, RND_FB, 0));
	}

	void bite_dodamage()
	{
		if (!(GetEntityProperty(param2, "scriptvar")))
		{
			HealEntity(GetOwner(), REGEN_RATE);
			EmitSound(GetOwner(), 0, SOUND_HEARTBEAT, 10);
		}
		if (!(IsEntityAlive(OLD_TARGET)))
		{
			OLD_TARGET = param1;
		}
		if (OLD_TARGET == param2)
		{
			TRACK_HIT += 1;
		}
		else
		{
			TRACK_HIT = 0;
		}
		if (TRACK_HIT > 3)
		{
			TRACK_HIT = 0;
			ApplyEffect(param2, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_POISON, 1);
		}
		OLD_TARGET = param2;
	}

	void bite1()
	{
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, 0.9, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bite");
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
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 800, 0));
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
		ClientEvent("new", "all", "monsters/bat_large_corpse_cl", GetEntityOrigin(GetOwner()), 1);
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
