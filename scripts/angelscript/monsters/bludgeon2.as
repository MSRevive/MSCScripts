#pragma context server

#include "monsters/bludgeon.as"

namespace MS
{

class Bludgeon2 : CGameScript
{
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int IS_JUMPING;
	int IS_UNHOLY;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	Bludgeon2()
	{
		IS_UNHOLY = 1;
		NPC_GIVE_EXP = 250;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 15;
		DROP_GOLD_MAX = 50;
		const string SOUND_STRUCK1 = "monsters/bludgeon/bludgeonattack2.wav";
		const string SOUND_STRUCK2 = "monsters/bludgeon/bludgeonattack2.wav";
		const string SOUND_STRUCK3 = "monsters/bludgeon/bludgeonattack2.wav";
		const string SOUND_PAIN = "monsters/bludgeon/bludgeonpain2.wav";
		const string SOUND_IDLE1 = "monsters/bludgeon/bludgeonidle2.wav";
		const string SOUND_IDLE2 = "monsters/bludgeon/bludgeonidle2.wav";
		const string SOUND_CHARGE = "monsters/boar/boarsight.wav";
		const string SOUND_DEATH = "monsters/bludgeon/bludgeonpain2.wav";
		Precache(SOUND_DEATH);
		MOVE_RANGE = 32;
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 120;
		const string ATTACK_DAMAGE = "$rand(40,80)";
		const string CHARGE_DAMAGE = "$rand(80,160)";
		const string CL_SCRIPT = "monsters/boar_base_cl_charge";
		Precache(CL_SCRIPT);
	}

	void OnSpawn() override
	{
		SetName("Bludgeon Demon Warrior");
		SetModel("monsters/bludgeon.mdl");
		SetHealth(800);
		SetWidth(32);
		SetHeight(72);
		SetRace("demon");
		SetRoam(true);
		SetHearingSensitivity(8);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 2.0);
		SetDamageResistance("lightning", 2.0);
		SetDamageResistance("holy", 1.0);
		SetMoveSpeed(BASE_MOVESPEED);
		ScheduleDelayedEvent(5.0, "idle_loop");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		PlayAnim("once", ANIM_IDLE);
	}

	void my_target_died()
	{
		IS_JUMPING = 0;
	}

}

}
