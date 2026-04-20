#pragma context server

#include "monsters/zombie.as"

namespace MS
{

class Zombie : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DISEASE;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SWIPE;
	string ANIM_WALK;
	float AS_STUCK_FREQ;
	float ATTACK_DAMAGE;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int DISEASE_DELAY;
	float DISEASE_DMG;
	int DISEASE_DUR;
	float DISEASE_FREQ;
	float FLINCH_HEALTH_RATIO;
	string MODEL;
	int NPC_GIVE_EXP;

	Zombie()
	{
		ANIM_WALK = "walkb1";
		ANIM_RUN = "walkb1";
		ANIM_IDLE = "idle1";
		ANIM_SWIPE = "stab1";
		ANIM_DISEASE = "slash";
		ANIM_ATTACK = ANIM_SWIPE;
		NPC_GIVE_EXP = 75;
		ANIM_WALK = "walkb1";
		ANIM_RUN = "walkb1";
		ANIM_IDLE = "idle1";
		ANIM_SWIPE = "stab1";
		ANIM_DISEASE = "slash";
		FLINCH_HEALTH_RATIO = 0.3;
		AS_STUCK_FREQ = 0.6;
		ATTACK_DAMAGE = Random(12.5, 25.0);
		ATTACK_HITCHANCE = 25;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 130;
		ATTACK_MOVERANGE = 50;
		DISEASE_FREQ = 10.0;
		DISEASE_DMG = Random(5, 8);
		DISEASE_DUR = RandomInt(20, 25);
		MODEL = "nightmare/monsters/fzombie.mdl";
		Precache(MODEL);
	}

	void OnSpawn() override
	{
		SetName("Zombified Commoner");
		SetHealth(200);
		SetModel(MODEL);
		int RAND_EYES = RandomInt(0, 3);
		SetModelBody(0, RAND_EYES);
		SetModelBody(1, 0);
		SetModelBody(2, 0);
		SetModelBody(3, 0);
		SetRace("undead");
		SetWidth(25);
		SetHeight(80);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(7);
		if (!(ME_NO_WANDER))
		{
			SetRoam(true);
		}
		if ((ME_NO_WANDER))
		{
			SetRoam(false);
		}
		SetGold(RandomInt(50, 100));
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("poison", 0.01);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("blunt", 1.0);
		SetDamageResistance("slash", 1.25);
		ScheduleDelayedEvent(1.0, "idle_sounds");
		int PICK_DEATH = RandomInt(1, 5);
		if (PICK_DEATH == 1)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
		if (PICK_DEATH == 2)
		{
			ANIM_DEATH = ANIM_DEATH2;
		}
		if (PICK_DEATH == 3)
		{
			ANIM_DEATH = ANIM_DEATH3;
		}
		if (PICK_DEATH == 4)
		{
			ANIM_DEATH = ANIM_DEATH4;
		}
		if (PICK_DEATH == 5)
		{
			ANIM_DEATH = ANIM_DEATH5;
		}
		CatchSpeech("debug_props", "debug");
	}

	void npc_selectattack()
	{
		if ((DISEASE_DELAY)) return;
		DISEASE_DELAY = 1;
		DISEASE_FREQ("reset_disease_delay");
		ANIM_ATTACK = ANIM_DISEASE;
	}

}

}
