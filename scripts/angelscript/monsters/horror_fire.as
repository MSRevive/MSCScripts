#pragma context server

#include "monsters/horror.as"

namespace MS
{

class HorrorFire : CGameScript
{
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string BREATH_SPRITE;
	int FLIGHT_SCANNING;
	int I_FLY;
	string MY_OWNER;
	int NO_STUCK_CHECKS;
	int NPC_BASE_EXP;
	int NPC_GIVE_EXP;
	string SPAWNED_ORG;
	string SPITTING;
	int SPORE_CLOUD_AMMO;

	HorrorFire()
	{
		NPC_BASE_EXP = 200;
		BREATH_SPRITE = "3dmflaora.spr";
	}

	void OnSpawn() override
	{
		SetName("Flaming Horror");
		SetHealth(500);
		SetDamageResistance("all", 1.0);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("fire", 0.0);
		SetWidth(22);
		SetHeight(22);
		SetRoam(true);
		SetFly(true);
		I_FLY = 1;
		0 = float(0);
		SetRace("demon");
		SetIdleAnim(ANIM_WALK);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(5);
		SetModel("monsters/edwardgorey.mdl");
		SetModelBody(0, 1);
		NPC_GIVE_EXP = 300;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		FLIGHT_SCANNING = 1;
		SPORE_CLOUD_AMMO = 1;
	}

	void OnPostSpawn() override
	{
		NO_STUCK_CHECKS = 0;
	}

	void attack1()
	{
		if ((SPITTING))
		{
			TossProjectile("proj_fire_xolt", "view", "none", 500, SPIT_DAMAGE, 0.5, "none");
			SPITTING = 0;
			if (SPIT_AMMO == 0)
			{
				fly_mode();
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY, "slash");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (RandomInt(1, 10) == 1)
		{
			ANIM_ATTACK = ANIM_GORE;
		}
	}

	void npcatk_anti_stuck()
	{
		if (!(STUCK_CHECK > 10)) return;
		if ((IsEntityAlive(MY_OWNER)))
		{
			ScheduleDelayedEvent(0.1, "npc_suicide");
		}
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		AM_SUMMONED = 1;
		SPAWNED_ORG = GetMonsterProperty("origin");
		ScheduleDelayedEvent(180.0, "do_vanish");
	}

	void do_vanish()
	{
		CallExternal(MY_OWNER, "horror_died");
		ScheduleDelayedEvent(0.1, "do_vanish2");
	}

	void do_vanish2()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
