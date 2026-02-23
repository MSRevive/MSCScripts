#pragma context server

#include "monsters/bear_base_giant.as"

namespace MS
{

class Kodiak : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int CAN_FLEE;

	Kodiak()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const int ATTACK_NORMAL_DAMAGE = 50;
		const string ATTACK_STANDING_DAMAGE = Random(18, 33);
		const int ATTACK_STOMPRANGE = 225;
		const int ATTACK_STOMPDMG = 60;
		const float ATTACK_HITCHANCE = 0.7;
		const int NPC_BASE_EXP = 500;
		CAN_FLEE = 0;
	}

	void OnSpawn() override
	{
		SetHealth(2000);
		SetName("Kodiak");
		SetDamageResistance("fire", 0.5);
		SetModelBody(0, 2);
		if (StringToLower(GetMapName()) == "bloodrose")
		{
			GiveItem(GetOwner(), "item_bearclaw");
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string FINDLE_ID = FindEntityByName("npc_findlebind");
		if (!(IsEntityAlive(FINDLE_ID))) return;
		CallExternal(FINDLE_ID, "da_bear_died");
	}

}

}
