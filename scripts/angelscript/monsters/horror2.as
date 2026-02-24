#pragma context server

#include "monsters/horror.as"

namespace MS
{

class Horror2 : CGameScript
{
	int ATTACK_BLIND_RANGE;
	int ATTACK_DAMAGE;
	int BREATH_DAMAGE_MAX;
	int BREATH_DAMAGE_MIN;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int FLIGHT_SCANNING;
	int IS_UNHOLY;
	int I_FLY;
	int NPC_BASE_EXP;
	int NPC_GIVE_EXP;
	int SPIT_DAMAGE;
	int SPORE_CLOUD_AMMO;
	string SPORE_DELAY;

	Horror2()
	{
		NPC_BASE_EXP = 400;
		IS_UNHOLY = 1;
		ATTACK_BLIND_RANGE = 200;
		ATTACK_DAMAGE = 200;
		SPIT_DAMAGE = 100;
		BREATH_DAMAGE_MIN = 100;
		BREATH_DAMAGE_MAX = 200;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 30;
		DROP_GOLD_MAX = 60;
	}

	void OnSpawn() override
	{
		SetName("Elder Horror");
		SetHealth(1500);
		SetDamageResistance("all", 0.75);
		SetDamageResistance("holy", 0.5);
		SetDamageResistance("poison", 0.0);
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
		NPC_GIVE_EXP = 400;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		FLIGHT_SCANNING = 1;
		SPORE_CLOUD_AMMO = 1;
		SPORE_DELAY = GetGameTime();
		SPORE_DELAY += Random(3.0, 20.0);
	}

	void my_target_died()
	{
		SPORE_CLOUD_AMMO = 1;
	}

	void npc_targetsighted()
	{
		if (!(SPORE_CLOUD_AMMO > 0)) return;
		if (!(GetEntityRange(m_hAttackTarget) > 256)) return;
		if (!(GetGameTime() > SPORE_DELAY)) return;
		PlayAnim("critical", ANIM_ATTACK);
		string CLOUD_ORIGIN = GetEntityOrigin(m_hAttackTarget);
		SpawnNPC("monsters/summon/npc_poison_cloud2", CLOUD_ORIGIN, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 75, 20.0, 2
		SPORE_CLOUD_AMMO -= 1;
	}

}

}
