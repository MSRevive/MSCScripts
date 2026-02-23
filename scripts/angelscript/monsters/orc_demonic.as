#pragma context server

#include "monsters/orc_flayer.as"

namespace MS
{

class OrcDemonic : CGameScript
{
	string AS_ATTACKING;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	string FIRE_BALL_DAMAGE;
	int IS_UNHOLY;
	int MELEE_ATTACK;
	string NEXT_FIREBALL;
	int ORC_JUMPER;

	OrcDemonic()
	{
		const int NPC_BASE_EXP = 200;
		const float ATTACK_ACCURACY = 0.8;
		const string FREQ_FIREBALL = Random(5.0, 10.0);
		const string FIRE_BALL_DAMAGE_NORM = "$rand(75,100)";
		const string FIRE_BALL_DAMAGE_ALT = "$rand(25,50)";
		FIRE_BALL_DAMAGE = FIRE_BALL_DAMAGE_NORM;
		const float DOT_FIRE = 20.0;
		const string SOUND_FIRECHARGE = "magic/fireball_powerup.wav";
		const string SOUND_FIRESHOOT = "magic/fireball_strike.wav";
		ORC_JUMPER = 1;
		IS_UNHOLY = 1;
	}

	void orc_spawn()
	{
		SetHealth(500);
		SetName("Demonic Blackhand");
		SetProp(GetOwner(), "skin", 2);
		SetHearingSensitivity(2);
		SetStat("parry", 50);
		SetDamageResistance("all", ".5");
		SetDamageResistance("holy", 0.5);
		SetDamageResistance("fire", 0.0);
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 5);
		if (!(true)) return;
		ScheduleDelayedEvent(2.0, "final_adjstments");
	}

	void final_adjstments()
	{
		DROP_ITEM1 = "none";
		DROP_ITEM1_CHANCE = 0.0;
	}

	void cycle_up()
	{
		NEXT_FIREBALL = GetGameTime();
		NEXT_FIREBALL += FREQ_FIREBALL;
		if (!(SAY_SUMMONER)) return;
		SetSayTextRange(4096);
	}

	void npc_targetsighted()
	{
		if (!(GetGameTime() > NEXT_FIREBALL)) return;
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_HITRANGE)) return;
		NEXT_FIREBALL = GetGameTime();
		NEXT_FIREBALL += FREQ_FIREBALL;
		EmitSound(GetOwner(), 0, SOUND_FIRESHOOT, 10);
		PlayAnim("critical", ANIM_ATTACK);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 2.0;
		TossProjectile("proj_fire_ball", /* TODO: $relpos */ $relpos(0, 48, 12), m_hAttackTarget, 400, FIRE_BALL_DAMAGE, 2, "none");
		CallExternal("ent_lastprojectile", "lighten", DOT_FIRE, 0.0);
	}

	void swing_sword()
	{
		MELEE_ATTACK = 1;
	}

	void game_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		}
		MELEE_ATTACK = 0;
	}

}

}
