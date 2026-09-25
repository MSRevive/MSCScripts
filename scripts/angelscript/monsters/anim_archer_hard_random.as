#pragma context server

#include "monsters/anim_archer.as"

namespace MS
{

class AnimArcherHardRandom : CGameScript
{
	string ARMOR_TYPE;
	int ARROW_DAMAGE_HIGH;
	int ARROW_DAMAGE_LOW;
	int ARROW_MISS_COUNT;
	string AS_ATTACKING;
	string CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	string DAMAGE_TYPE;
	string DROPS_CONTAINER;
	int FIN_EXP;
	int FLIGHT_STUCK;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	string LIGHT_COLOR;
	int LIGHT_RAD;
	int MOVE_RANGE;
	string MY_LIGHT_SCRIPT;
	int STUCK_SENSITIVITY;

	AnimArcherHardRandom()
	{
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		LIGHT_RAD = 64;
		STUCK_SENSITIVITY = 10;
		MOVE_RANGE = 300;
		FIN_EXP = 320;
		Precache("monsters/animarmor_fly.mdl");
		ARROW_DAMAGE_LOW = 30;
		ARROW_DAMAGE_HIGH = 45;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10.0);
		Effect("glow", GetOwner(), LIGHT_COLOR, 64, -1, 0);
		string GRND_LEVEL = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		string MY_Z = (GetMonsterProperty("origin")).z;
		if (GRND_LEVEL >= MY_Z)
		{
			string DIST_DIFF = GRND_LEVEL;
			DIST_DIFF -= MY_Z;
		}
		if (GRND_LEVEL < MY_Z)
		{
			string DIST_DIFF = MY_Z;
			DIST_DIFF -= GRND_LEVEL;
		}
		if (DIST_DIFF < 32)
		{
			AddVelocity(GetOwner(), Vector3(0, 0, 110));
			int EXIT_SUB = 1;
		}
		if (!(EXIT_SUB))
		{
		}
		string TRACE_START = GetMonsterProperty("origin");
		string TRACE_END = GetMonsterProperty("origin");
		TRACE_END += "z";
		string FIND_CEILING = TraceLine(TRACE_START, TRACE_END);
		string CEIL_Z = (FIND_CEILING).z;
		string SKY_Z = /* TODO: $get_sky_height */ $get_sky_height(GetMonsterProperty("origin"));
		if (SKY_Z != "none")
		{
			if (SKY_Z < CEIL_Z)
			{
			}
			string CEIL_Z = "equals";
		}
		if (CEIL_Z >= MY_Z)
		{
			string DIST_DIFF = CEIL_Z;
			DIST_DIFF -= MY_Z;
		}
		if (CEIL_Z < MY_Z)
		{
			string DIST_DIFF = MY_Z;
			DIST_DIFF -= CEIL_Z;
		}
		if (DIST_DIFF < 32)
		{
			AddVelocity(GetOwner(), Vector3(0, 0, -110));
		}
	}

	void OnSpawn() override
	{
		SetRoam(true);
		SetRace("demon");
		SetWidth(64);
		SetHeight(64);
		SetHealth(500);
		SetModel("monsters/animarmor_fly.mdl");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(8);
		SetBloodType("none");
		SetFly(true);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
		SetModelBody(1, 1);
		SetModelBody(2, 3);
		ScheduleDelayedEvent(0.1, "select_armor");
		ARROW_MISS_COUNT = 0;
	}

	void select_armor()
	{
		if (ARMOR_TYPE == "ARMOR_TYPE")
		{
			ARMOR_TYPE = RandomInt(1, 4);
		}
		if (ARMOR_TYPE == 1)
		{
			SetName("Animated Archer of Flame");
			DAMAGE_TYPE = "fire";
			SetDamageResistance("lightning", 1.2);
			SetDamageResistance("fire", 0.0);
			SetDamageResistance("cold", 2.0);
			LIGHT_COLOR = Vector3(255, 0, 0);
			DROPS_CONTAINER = 1;
			CONTAINER_DROP_CHANCE = 0.1;
			CONTAINER_SCRIPT = "chests/quiver_of_fire";
		}
		if (ARMOR_TYPE == 2)
		{
			SetName("Animated Archer of Thunder");
			DAMAGE_TYPE = "lightning";
			SetDamageResistance("lightning", 0.0);
			SetDamageResistance("acid", 2.0);
			LIGHT_COLOR = Vector3(255, 255, 0);
			DROPS_CONTAINER = 1;
			CONTAINER_DROP_CHANCE = 0.1;
			CONTAINER_SCRIPT = "chests/quiver_of_lightning";
		}
		if (ARMOR_TYPE == 3)
		{
			SetName("Animated Archer of Frost");
			DAMAGE_TYPE = "cold";
			SetDamageResistance("fire", 2.0);
			SetDamageResistance("lightning", 1.2);
			SetDamageResistance("cold", 0.0);
			LIGHT_COLOR = Vector3(200, 200, 255);
			DROPS_CONTAINER = 1;
			CONTAINER_DROP_CHANCE = 0.1;
			CONTAINER_SCRIPT = "chests/quiver_of_frost";
		}
		if (ARMOR_TYPE == 4)
		{
			SetName("Animated Archer of Venom");
			DAMAGE_TYPE = "poison";
			SetDamageResistance("lightning", 2.5);
			LIGHT_COLOR = Vector3(0, 255, 0);
			DROPS_CONTAINER = 1;
			CONTAINER_DROP_CHANCE = 0.1;
			CONTAINER_SCRIPT = "chests/quiver_of_gpoison";
		}
		Effect("glow", GetOwner(), LIGHT_COLOR, 64, -1, 0);
		string GRND_LEVEL = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		string MY_Z = (GetMonsterProperty("origin")).z;
		if (/* TODO: $dest */ $dest(GRND_LEVEL, MY_Z) < 32)
		{
			AddVelocity(GetOwner(), Vector3(0, 0, 110));
		}
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!((param3).findFirst("pierce") >= 0)) return;
		ARROW_MISS_COUNT = 0;
		if (DAMAGE_TYPE == "fire")
		{
			ApplyEffect(param1, "effects/dot_fire", 30, GetEntityIndex(GetOwner()), RandomInt(5, 12));
		}
		if (DAMAGE_TYPE == "poison")
		{
			ApplyEffect(param1, "effects/dot_poison", 30, GetEntityIndex(GetOwner()), RandomInt(5, 12));
		}
		if (DAMAGE_TYPE == "cold")
		{
			ApplyEffect(param1, "effects/dot_cold", 10, GetEntityIndex(GetOwner()), RandomInt(5, 12));
		}
		if (DAMAGE_TYPE == "lightning")
		{
			ApplyEffect(param1, "effects/dot_lightning", 10, GetEntityIndex(GetOwner()), RandomInt(5, 12));
		}
	}

	void OnPostSpawn() override
	{
		ClientEvent("persist", "all", "monsters/lighted_cl", GetEntityIndex(GetOwner()), LIGHT_COLOR, LIGHT_RAD);
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		ClientEvent("update", "all", MY_LIGHT_SCRIPT, "remove_me");
	}

	void bf_agrofly_boost()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, BF_BOOST_SPEED, 150));
	}

	void bf_agrofly_loop()
	{
		if (!(IsEntityAlive(HUNT_LASTTARGET))) return;
		if ((false)) return;
		FLIGHT_STUCK = 8;
	}

	void chicken_run()
	{
		SetMoveSpeed(2.0);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -110, 120));
	}

	void chicken_end()
	{
		SetMoveSpeed(1.0);
	}

	void do_attack()
	{
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
	}

	void shoot_arrow()
	{
		ARROW_MISS_COUNT += 1;
		if (!(ARROW_MISS_COUNT > 3)) return;
		chicken_run(2.0);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
	}

	void npc_targetsighted()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 1.0;
	}

}

}
