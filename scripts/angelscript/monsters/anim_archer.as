#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class AnimArcher : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_DELAY;
	int ATTACK_RANGE;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int I_AM_FOUR;
	int I_AM_ONE;
	int I_AM_THREE;
	int I_AM_TURNABLE;
	int I_AM_TWO;
	string LAST_ENEMY;
	int MOVE_RANGE;
	string NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	string SPAWNER;

	AnimArcher()
	{
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		const float FREQ_BOW = 2.0;
		const int FIN_EXP = 45;
		NPC_MUST_SEE_TARGET = 1;
		const string SOUND_STRUCK1 = "body/armour1.wav";
		const string SOUND_STRUCK2 = "body/armour2.wav";
		const string SOUND_STRUCK3 = "body/armour3.wav";
		const string SOUND_HIT = "body/armour3.wav";
		const string SOUND_HIT2 = "body/armour2.wav";
		const string SOUND_HIT3 = "body/armour1.wav";
		const string SOUND_PAIN = "body/armour1.wav";
		const string SOUND_ATTACK1 = "none";
		const string SOUND_ATTACK2 = "none";
		const string SOUND_ATTACK3 = "none";
		const string SOUND_DEATH = "none";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die";
		const string SOUND_BOW = "weapons/bow/bow.wav";
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 25);
		NPC_GIVE_EXP = FIN_EXP;
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_silver";
		ANIM_ATTACK = "shootorcbow";
		const int AIM_RATIO = 50;
		const int ARROW_DAMAGE_LOW = 12;
		const int ARROW_DAMAGE_HIGH = 15;
		MOVE_RANGE = 400;
		ATTACK_RANGE = 60;
		const int ATTACK_SPEED = 1000;
		const int ATTACK_CONE_OF_FIRE = 2;
		I_AM_TURNABLE = 0;
	}

	void OnSpawn() override
	{
		SetName("Animated armor");
		SetRoam(true);
		SetRace("demon");
		SetWidth(40);
		SetHeight(90);
		SetHealth(200);
		SetStepSize(16);
		SetModel("monsters/animarmor.mdl");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetBloodType("none");
		SetDamageResistance("all", 0.9);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 3.0);
		SetDamageResistance("lightning", 1.2);
		SetModelBody(1, 1);
		SetModelBody(2, 3);
	}

	void npc_targetsighted()
	{
		if (GetEntityRange(param1) < ATTACK_SPEED)
		{
			if (!(ATTACK_DELAY))
			{
			}
			if ((false))
			{
			}
			do_attack();
		}
		string LASTSEEN_ENEMY = GetEntityIndex(m_hLastSeen);
		if (!(LASTSEEN_ENEMY != LAST_ENEMY)) return;
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_ATTACK2, 5);
		LAST_ENEMY = LASTSEEN_ENEMY;
	}

	void reset_attack_delay()
	{
		ATTACK_DELAY = 0;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {"game.sound.maxvol", SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npc_targetsighted()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 1.0;
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(ATTACK_PUSH != "ATTACK_PUSH")) return;
		if (!(ATTACK_PUSH != "none")) return;
		AddVelocity(m_hLastStruckByMe, ATTACK_PUSH);
	}

	void OnFlinch()
	{
		PlayAnim("critical", "flinch");
	}

	void retaliate()
	{
		if (!(RandomInt(1, 3) == 1)) return;
		SetMoveDest(m_hLastStruck);
		LookAt(GetOwner());
		hunt_look();
	}

	void shoot_arrow()
	{
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.x");
		string LCL_ATKDMG = Random(ARROW_DAMAGE_LOW, ARROW_DAMAGE_HIGH);
		TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, 3), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
		SetModelBody(3, 0);
		EmitSound(GetOwner(), 2, SOUND_BOW, 10);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
	}

	void grab_arrow()
	{
		SetModelBody(3, 1);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
	}

	void game_dynamically_created()
	{
		SPAWNER = param1;
	}

	void two_was_summoned()
	{
		SetGlobalVar("ONE_IS_DEAD", 0);
		I_AM_ONE = 1;
	}

	void two_was_summoned()
	{
		SetGlobalVar("TWO_IS_DEAD", 0);
		I_AM_TWO = 1;
	}

	void three_was_summoned()
	{
		SetGlobalVar("THREE_IS_DEAD", 0);
		I_AM_THREE = 1;
	}

	void four_was_summoned()
	{
		SetGlobalVar("FOUR_IS_DEAD", 0);
		I_AM_FOUR = 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (I_AM_ONE == 1)
		{
			SetGlobalVar("ONE_IS_DEAD", 1);
		}
		if (I_AM_TWO == 1)
		{
			SetGlobalVar("TWO_IS_DEAD", 1);
		}
		if (I_AM_THREE == 1)
		{
			SetGlobalVar("THREE_IS_DEAD", 1);
		}
		if (I_AM_FOUR == 1)
		{
			SetGlobalVar("FOUR_IS_DEAD", 1);
		}
		SetModelBody(2, 0);
		SetModelBody(3, 0);
		SetModelBody(4, 0);
		CallExternal(SPAWNER, "undead_died");
	}

	void do_attack()
	{
		AS_ATTACKING = GetGameTime();
		ATTACK_DELAY = 1;
		FREQ_BOW("reset_attack_delay");
		PlayAnim("once", ANIM_ATTACK);
	}

}

}
